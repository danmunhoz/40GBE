/*****************************************************************************\
| File Name: RFC2544.h 									                 	  |
| Project: PD1461 - netFPGA SUME						             		  |
| Author: Lucas Pugens Fernandes & Thiago Mânica Monteiro					  |
| Purpose: Run RFC2544 tests over a network using a netFPGA SUME board		  |
| Version: 2.0										                       	  |
| Date: November, 2015									                 	  |
/*****************************************************************************/

/**
 * @file RFC2544.h
 * @author Lucas Pugens
 * @date 13 July 2016
 * @brief .h file with some functions related to the RFC2544.c file
 */

#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <getopt.h>
#include <math.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

#include "RFC2544_defines.h"

pthread_mutex_t mutex_uart;		/*!< Mutual exclusive semaphore to access the uart and PCIe interfaces */
pthread_mutex_t mutex_printf;	/*!< Mutual exclusive semaphore to access the output */
int slot;						/*!< Slot SFP address */
void *virt_addr;				/*!< Memory map to PCIe writes */
void *map_base;					/*!< Memory map to PCIe writes */

void wrap_exit(int sfp, int status);

struct arguments{
	unsigned int throughput_step;				/*!< OUT_DATED */
	unsigned int throughput_initrate;			/*!< OUT_DATED */
	int tid;									/*!< OUT_DATED */
	int slot;									/*!< OUT_DATED */
	int usb;									/*!< OUT_DATED */

	unsigned int top_rate;						/*!< Maximum channel rate */
	unsigned long long npkts;					/*!< Number of packets to use in different tests */
	unsigned int timeout;						/*!< Timeout for different tests */
	unsigned int back_to_back_step;				/*!< Incremental step in the number of packets in a single train for the back-to-back test */
	unsigned int back_to_back_initrate;			/*!< Initial number of packets used in the back-to-back test */
	unsigned int back_to_back_limit;			/*!< Maximum number of packets in a single train used in the back-toback test */
	unsigned int latency_wait;					/*!< Time of the packet train duration before measurement of the latency */
	unsigned int system_recovery_overload_time;	/*!< Time of duration at 110% rate for the system-recovery test */
	unsigned int system_recovery_pktseq;		/*!< Number of packets correctly received at 55% rate before end the test */
	unsigned int system_recovery_iterations;	/*!< Number of system-recovery executions to take average */
	unsigned long int timing;					/*!< Timed-throughput duration */
	double acceptable_error;					/*!< Acceptable Loss Rate */
	double loss_rate_step;						/*!< Loss rate step rate */
	unsigned int payload_type;					/*!< Indicates if the payload type is ID (System Recovery test - variable set as 0), LFSR (variable set as 1), all 0s (variable set as 2) or all 1s (variable set as 3) */
	unsigned long int mac_source;				/*!< MAC Source Address */
	unsigned long int mac_target;				/*!< MAC Target Address*/
	unsigned int ip_source;						/*!< IP Source Address */
	unsigned int ip_target;						/*!< IP Target Address */
	unsigned int lfsr_polynomial; 				/*!< Choses the LFSR polynomial: 0 if 2³¹-1, 1 if 2²³-1, 2 if 2¹⁵-1 and 3 if 2⁷-1  */
	unsigned int pktlen;						/*!< Used to jumb frame lenghts */
	unsigned int mac_filter;					/*!< Specifies mac filter (0 inverts mac source and mac target and receives just packets in broadcast or intended for its mac, 1 does not invert mac source and mac target and receives just packets in broadcast or intended for its mac, 2 inverts mac source and mac target and operates in promiscous mode and 3 does not invert mac source and mac target and operates in promiscous mode) */
	
	int throughput_test_flag;					/*!< Specific test request */
	int latency_test_flag;						/*!< Specific test request */
	int back_to_back_test_flag;					/*!< Specific test request */
	int loss_rate_test_flag;					/*!< Specific test request */
	int system_recovery_test_flag;				/*!< Specific test request */
	int timed_throughput_test_flag;				/*!< Specific test request */
	int loopback_test_flag;						/*!< Specific test request */
	int training_flag;							/*!< Specific test request */
	int reset_test_flag;								/*!< Specific test request */
	int soft_reset_flag;						/*!< Specific test request */
	int read_status_flag;						/*!< Specific test request */
	int rfc2544_flag;							/*!< Request to run all RFC2544 tests */
	int verbose_flag;							/*!< Detailed output about the tests run */
	int sfps_flags[NUMBER_OF_SFPS];				/*!< Channel execution indicators */
	int ps_flags[NUMBER_OF_SIZES];				/*!< Packet sizes flags */
	char resource[256];							/*!< PCIe file path */
	char out_file[256];							/*!< Output file path */
} arguments;

struct result_throughput{
	double rate;		/*!< Maximum throughput rate obtained */
	unsigned int idle;	/*!< Hardware idle cycles related to the maximum throughput rate obtained */
	double bert;		/*!< Bit Error RaTe */
} result_throughput;

struct result_timed_throughput{
	double wished_rate;					/*!< OUT_DATED */
	unsigned long long lost_packets;	/*!< OUT_DATED */
	unsigned int pktlen;				/*!< OUT_DATED */
	double achieved_rate;				/*!< OUT_DATED */
	double throughput;					/*!< OUT_DATED */
	double bert;						/*!< OUT_DATED */

	unsigned long long npkts;			/*!< Number of packets sent during the test */
	unsigned long long received_pkts;	/*!< Number of packets received during the test */
} result_timed_throughput;


struct result_loss_rate{
	double loss_rate;	/*!< Loss rate detected during the test */
	double rate;		/*!< Throughput rate used during the test */
} result_loss_rate;


/**
Initialize Serial Bus. OUT_DATED
\param usb system identificator of the USB
\return local identifier to the USB
*/
int open_serial(int usb){
	int slot;					/* Local identifier to the USB */
	char usb_path_string[128];	/* Path to the system USB */
	char error_string[128];		/* Error report string */
	struct termios options;


	sprintf(usb_path_string, "/dev/ttyUSB%d", usb);
	slot = open(usb_path_string, O_RDWR | O_NOCTTY);
	if(slot == -1)
	{
		sprintf(error_string, "open_port: Unable to open %s - ", usb_path_string);
		perror(error_string);
		exit(1);
	}

	/*
	CONFIGURE THE UART
	The flags (defined in /usr/include/termios.h
		- see http://pubs.opengroup.org/onlinepubs/007908799/xsh/termios.h.html):
	
		-> Baud rate:- B1200, B2400, B4800, B9600, B19200, B38400, B57600, B115200,
				B230400, B460800, B500000, B576000, B921600, B1000000, B1152000,
				B1500000,	B2000000, B2500000, B3000000, B3500000, B4000000
		-> CSIZE:- CS5, CS6, CS7, CS8
		-> CLOCAL - Ignore modem status lines
		-> CREAD - Enable receiver
		-> IGNPAR = Ignore characters with parity errors
		-> ICRNL - Map CR to NL on input (Use for ASCII comms where you want to
				auto correct end of line characters - don't use for bianry comms!)
		-> PARENB - Parity enable
		-> PARODD - Odd parity (else even)
	*/
	tcgetattr(slot, &options);
	options.c_cflag = B115200 | CS8 | CLOCAL | CREAD;
	options.c_iflag = IGNPAR;
	options.c_oflag = 0;
	options.c_lflag = 0;
	tcflush(slot, TCIFLUSH);
	tcsetattr(slot, TCSANOW, &options);

	return slot;
}

/**
Wrapper to the printf function with semaphore between threads and thread identificator.
\param sfp SFP, or thread identifier
\param format string related to the first parameter of a common printf function call
\param ... rest of the common parameters to a printf function
*/
void wrap_printf (int sfp, const char * format, ... ){
	va_list args;
	char string[256];

	va_start(args, format);

	pthread_mutex_lock(&mutex_printf);
	sprintf(string, "SFP %d: ", sfp);
	printf("%-10s", string);
	vprintf(format, args);
	fflush;
	pthread_mutex_unlock(&mutex_printf);

	va_end(args);
}

/**
Close the serial connection. OUT_DATED
\param slot USB slot
*/
void close_serial(int slot){
	close(slot);
	printf("Serial closed!\n");
}

/**
Calculate the precise number of hardware idle cycles for a given throughput rate and packet length
\param rate throughput rate
\param pktlen packet size
\return number of hardware idle cycles
*/
unsigned int idle_calc(double rate, unsigned int pktlen){
	/* 
			idle =  |  pktlen * 10000   - 8 |     1
					| ----------------      | X  ---
					|       rate            |     8
	*/
	double local_rate = rate/10000.0;
	double local_pktlen = (double)pktlen;
	int idle = floor((local_pktlen/local_rate - local_pktlen - 8.0)/8.0);
	/* Minimum number of idle cycles is 1 that is interpreted by the hardware as 1.5 */
	if(idle < 1) idle = 1;
	return idle;
}

/**
Calculate the precise throughput rate frin the number of idle hardware cycles and packet length
\param idle number of hardware idle cycles
\param pklen packet size
\return throughput rate claculated
*/
double rate_calc(unsigned int idle, unsigned int pktlen){
	float aux; 
	int cycles,last_bits;
	
	aux = ((((pktlen*8.0)-32.0)/64.0)-7.0);
	cycles = aux;
	last_bits = 64.0*(float)((float)aux - (float)cycles);
	double rate;
	double local_pktlen = (double)pktlen;
	double local_idle = 0;
	if(idle == 1)	
	{
		rate = ((local_pktlen*8.0)/(local_pktlen*8.0 + 96.0 + 64.0))*10000.0;
	}
	else if (last_bits >= 32)
	{
		local_idle = (double)idle;
		rate = ((local_pktlen*8.0)/(local_pktlen*8.0 + local_idle*64.0 - (last_bits-32.0) + 64.0))*10000.0;
	}
	else if (last_bits == 0)
	{
		local_idle = (double)idle;
		rate = ((local_pktlen*8.0)/(local_pktlen*8.0 + local_idle*64.0 + 32.0))*10000.0;
	}
	else
	{
		local_idle = (double)idle;
		rate = ((local_pktlen*8.0)/(local_pktlen*8.0 + local_idle*64.0 + (64.0-32.0-last_bits) + 64.0))*10000.0;
	}
	return rate;
}

/**
Calculate the real rate of packets received for a period of time
\param idleCount number of hardware idle cycles while receiving packets
\param pklen packet size
\param npkts number of packets received
\return throughput rate obeserved
*/
double rateFromIdle(unsigned long long idleCount, unsigned int pktlen, unsigned long long npkts){
	double numOfIdle = 0;
	double rate = 0;

	numOfIdle = ((idleCount/(double)npkts)-1.0 -(pktlen/8.0));

	rate = (pktlen/(pktlen+8.0*numOfIdle+8.0))*10000.0;

	return rate;
}

/**
Implement the binary search method used in the throughput test function
\param step REVIEW
\param last_step last step used
\return next value for the binary search
*/
int binary_search(int step, int last_step){
	return (step+last_step)/2;
}

/**
Write values through serial communication. OUT_DATED
\param slot communication slot
\param sfp SFP address (high part of the address)
\param addr_low low part of the address
\param data_high high part of the data
\param data_low low part of the data
*/
void write_serial(int slot, char sfp, char addr_low, char data_high, char data_low){
	char tx_buffer[5];
	//----- TX BYTES -----

	tx_buffer[0] = WRITE;
	tx_buffer[1] = sfp;
	tx_buffer[2] = addr_low;
	tx_buffer[3] = data_high;
	tx_buffer[4] = data_low;

	usleep(SLEEP_RW_UTIME);

	if (slot != -1){
		// Filestream, bytes to write, number of bytes to write
		int count = write(slot, &tx_buffer[0], 5);
		if (count < 0){
			wrap_printf((int)sfp, "UART TX error\n");
			wrap_exit(sfp, 3);
		}
	}

}

/**
Write data to the PICe bus
\param sfp SFP number
\param *virt_addr memory map of the bus
\param data data to be written
*/
void write_pci(char sfp, void *virt_addr, int data){
	*((unsigned int *) virt_addr) = data;
}

/**
Wrap function to write data into the hardware
\param sfp SFP number
\param reg register address
\param data data to be written
*/
void mpu_write_pci(char sfp, int reg, int data){
	pthread_mutex_lock(&mutex_uart);
	virt_addr = map_base + ((reg + (sfp<<9)) & MAP_MASK);
	write_pci(sfp, virt_addr, data);
	pthread_mutex_unlock(&mutex_uart);
}

/**
Read data from the hardware through the PCIe Bus
\param sfp SFP number
\param *virt_addr memory map of the bus
\return read value
*/
int read_pci(char sfp, void *virt_addr){
	int ans = *((unsigned int *) virt_addr);
	return ans;
}

/**
Wrap function to read data from the hardware
\param sfp SFP number
\param reg register address
\return read value
*/
int mpu_read_pci(char sfp, int reg){
	int n;

	pthread_mutex_lock(&mutex_uart);	
	virt_addr = map_base +  ((reg + (sfp<<9)) & MAP_MASK);
	n = read_pci(sfp, virt_addr);
	pthread_mutex_unlock(&mutex_uart);
	return n;
}

/**
Blocking pooling function to detect end of tests
\param sfp SFP number
\param reg register address
*/
void read_status(char sfp, int reg)
{
	int ans;
	unsigned int contErrorLow, contErrorHigh;
	unsigned long long bitsWithError;

	usleep(1);
	do{
		ans = mpu_read_pci(sfp, reg);
//Get bert error
	contErrorLow = mpu_read_pci(sfp, CONT_ERROR_31_0_REG); // CONT_ERROR_63_32_REG
	contErrorHigh = mpu_read_pci(sfp, CONT_ERROR_63_32_REG); // CONT_ERROR_31_0_REG
	//contErrorLow = mpu_read_pci(sfp, PACKETS_LOST);
	bitsWithError = contErrorHigh*0x100000000 + contErrorLow;
	//bitsWithError = contErrorLow;
	wrap_printf(sfp+1, "%-30s%llu\n","##Number of bits with error:", bitsWithError);
	if (ans) usleep(500000);
	}while(ans);
}

/**
Write status to the hardware, giving time to the hardware process the status
\param sfp SFP number
\param reg register address
\param data status to be written
*/
void write_status(char sfp, int reg, int data){
	usleep(1);
	mpu_write_pci(sfp, reg, data);
	usleep(1);
}

/**
Hardware reset
\param sfp SFP address to reset
*/
void reset(char sfp){
	int ans;
	usleep(1);
	mpu_write_pci(sfp, STATUS_REG, 3);
	usleep(1);
	do{
		ans = mpu_read_pci(sfp, STATUS_REG);
		if (ans) usleep(500000);
	}while(ans);
	do{
		ans = mpu_read_pci(sfp, STATUS_BACK_REG);
		if (ans) usleep(500000);
	}while(ans);
	/* Reset again to be sure no packet was lost in the middle of the test */
	usleep(1000000);
	mpu_write_pci(sfp, STATUS_REG, 3);
	usleep(1);
	do{
		ans = mpu_read_pci(sfp, STATUS_REG);
		if (ans) usleep(500000);
	}while(ans);
	do{
		ans = mpu_read_pci(sfp, STATUS_BACK_REG);
		if (ans) usleep(500000);
	}while(ans);
}

/**
Print in the terminal the formatted output
\param slot SFP number
\param *plot_file file descriptor containing the formatted output
*/
void plot_results(int slot, char* plot_file){
	char string[256];

	sprintf(string, "cat %s", plot_file);
	pthread_mutex_lock(&mutex_printf);
	system(string);
	pthread_mutex_unlock(&mutex_printf);
}

/**
Decode the packet length in a scale from 0 to 7
\param pktlen packet length identifier in the scale (0 to 7)
\return packet length
*/
int pktlenDecoder(int pktlen){
	if (pktlen == 64)
	return 0;
	else if (pktlen == 128)
	return 1;
	else if (pktlen == 256)
	return 2;
	else if (pktlen == 512)
	return 3;
	else if (pktlen == 768)
	return 4;
	else if (pktlen == 1024)
	return 5;
	else if (pktlen == 1280)
	return 6;
	else if (pktlen == 1518)
	return 7;
}

/**
Decode packet length identifier from the packet length
\param pktlen packet length
\return packet length identifier in the scale (0 to 7)
*/
int indexlenDecoder(int pktlen){
	if (pktlen == 0)
	return 64;
	else if (pktlen == 1)
	return 128;
	else if (pktlen == 2)
	return 256;
	else if (pktlen == 3)
	return 512;
	else if (pktlen == 4)
	return 768;
	else if (pktlen == 5)
	return 1024;
	else if (pktlen == 6)
	return 1280;
	else if (pktlen == 7)
	return 1518;
}

/**
Thread exit in case of failure
\param sfp SFP number
\param status exit status (0 to exit without error)
*/
void wrap_exit (int sfp, int status){
	int i, ans;
	char tx_buffer[5];
	//----- TX BYTES -----
	tx_buffer[0] = WRITE;
	tx_buffer[1] = sfp;
	tx_buffer[2] = STATUS_REG;
	tx_buffer[3] = 0;
	tx_buffer[4] = 10;

	wrap_printf(sfp, "Starting secure exit!\n");
	if(status){
		for(i = 0; i < NUMBER_OF_SFPS; i++){
			/*Reset*/
			write(slot, &tx_buffer[0], 5);
		}
		close(slot);
		exit(3);
	}
	exit(0);
}

/**
Detects if any of the SFPs were selected to run the tests
\param args struct arguments read from user input
\return flag indicating if any SFP was selected
*/
int is_sfps(struct arguments args){
	int i;
	int result = 0;
	for(i = 0; i < NUMBER_OF_SFPS; i++){
		if(args.sfps_flags[i]){
			result = 1;
			return result;
		}
	}
	return result;
}

/**
Detects if any of the packet sizes were selected
\param args struct arguments read from user input
\return flag indicating if any packet size was selected
*/
int is_packet_sizes(struct arguments args){
	int i;
	int result = 0;
	for(i = 0; i < NUMBER_OF_SIZES; i++){
		if(args.ps_flags[i]){
			result = 1;
			return result;
		}
	}
	return result;
}

/**
Set the number of cycles used for jumbo frames
\param pktlen packet length
\param sfp SFP number
*/
void set_cycles (int pktlen, char sfp){
	float aux; 
	int cycles,last_bits;
	
	aux = ((((pktlen*8.0)-32.0)/64.0)-7.0);
	cycles = aux;
	last_bits = 64.0*(float)((float)aux - (float)cycles);
	
	mpu_write_pci(sfp, PACKET_LENTGH_REG, pktlen);
		printf("pktlen: %d\n", pktlen);
	if (last_bits == 0) {	
		mpu_write_pci(sfp, CYCLES_REG, cycles-1);
	}
	else 
		mpu_write_pci(sfp, CYCLES_REG, cycles);
			printf("cycles: %d\n", cycles);

	mpu_write_pci(sfp, LAST_BITS_REG, last_bits);	
		printf("last bits: %d\n", last_bits);

}

/**
Help print about the software usage
\param *exec_name filename from the binary called
\param default_arguments argument values used by default 
*/
void print_usage(char * exec_name, struct arguments default_arguments){
	int cont = 0;
	char msg[256];
	printf("Usage:\n");
	printf("%s [OPTIONS]\n", exec_name);
	printf(" %-45s%s\n", "Argument", "Default Value");
	printf(" %-45s\n", "--throughput");
	printf(" %-45s\n", "--latency");
	printf(" %-45s\n", "--back-to-back");
	printf(" %-45s\n", "--loss-rate");
	printf(" %-45s\n", "--system-recovery");
	printf(" %-45s\n", "--reset");
	printf(" %-45s\n", "--timed-throughput");
	printf(" %-45s\n", "--loopback");
	printf(" %-45s\n", "--rfc2544");
	printf(" %-45s\n", "--training");
	printf(" %-45s\n", "--soft-reset");
	printf(" %-45s\n", "--read-status");
	printf(" %-45s\n", "--sfp1");
	printf(" %-45s\n", "--sfp2");
	printf(" %-45s\n", "--sfp3");
	printf(" %-45s\n", "--sfp4");
	printf(" %-45s\n", "--verbose");
	printf(" %-45s\n", "--ps64");
	printf(" %-45s\n", "--ps128");
	printf(" %-45s\n", "--ps256");
	printf(" %-45s\n", "--ps512");
	printf(" %-45s\n", "--ps768");
	printf(" %-45s\n", "--ps1024");
	printf(" %-45s\n", "--ps1280");
	printf(" %-45s\n", "--ps1518");
	printf(" %-45s%f\n", "--acceptable-error|x", default_arguments.acceptable_error);
	printf(" %-45s%d\n", "--top-rate|r", default_arguments.top_rate);
	printf(" %-45s%llu\n", "--npkts|n", default_arguments.npkts);
	printf(" %-45s%d\n", "--timeout|t", default_arguments.timeout);
	printf(" %-45s%d\n", "--throughput-initrate|i", default_arguments.throughput_initrate);
	printf(" %-45s%d\n", "--throughput-step|s", default_arguments.throughput_step);
	printf(" %-45s%d\n", "--latency-load-time|l", default_arguments.latency_wait);
	printf(" %-45s%f\n", "--loss-rate-step|p", default_arguments.loss_rate_step);
	printf(" %-45s%d\n", "--back-to-back-init|b", default_arguments.back_to_back_initrate);
	printf(" %-45s%d\n", "--back-to-back-step|c", default_arguments.back_to_back_step);
	printf(" %-45s%d\n", "--back-to-back-limit|k", default_arguments.back_to_back_limit);
	printf(" %-45s%d\n", "--system-recovery-overload-time|d", default_arguments.system_recovery_overload_time);
	printf(" %-45s%d\n", "--system-recovery-pkt-recovery-sequence|e", default_arguments.system_recovery_pktseq);
	printf(" %-45s%d\n", "--system-recovery-iterations|g", default_arguments.system_recovery_iterations);
	printf(" %-45s%u\n", "--pktlen|w", default_arguments.pktlen);
	printf(" %-45s%li\n", "--timing|a", default_arguments.timing);
	printf(" %-45s%d\n", "--payload-type", default_arguments.payload_type);
	printf(" %-45s%lu\n", "--mac-source", default_arguments.mac_source);
	printf(" %-45s%lu\n", "--mac-target", default_arguments.mac_target);
	printf(" %-45s%u\n", "--ip-source", default_arguments.ip_source);
	printf(" %-45s%u\n", "--ip-target", default_arguments.ip_target);
	printf(" %-45s%u\n", "--lfsr-polynomial", default_arguments.lfsr_polynomial);
	printf(" %-45s%u\n", "--mac-filter", default_arguments.mac_filter);
	printf(" %-45s%d\n", "--usb|u", default_arguments.usb);
	printf(" %-45s%s\n", "--resource|z", default_arguments.resource);
	printf(" %-45s%s\n", "--out-file|o", default_arguments.out_file);
	printf(" %-45s\n", "--help|h");
}

static struct arguments result;

/**
Read, process and verifies the user input argumets
\param argc input call parameters
\param **argv input call parameters
\return arguments struct containing the user options
*/
struct arguments process_arguments(int argc, char ** argv){
	int i;
	int option;
	int option_index = 0;
	int argument_error_flag = 0;
	char found_device[8];
	struct arguments default_arguments;
	FILE *fp;

	/* Default argument values. */
	default_arguments.top_rate 							= 10000;
	default_arguments.npkts 							= 1000000;
	default_arguments.timeout 							= 65000;
	default_arguments.throughput_initrate				= 8000;
	default_arguments.throughput_step 					= 500;
	default_arguments.latency_wait						= 600000;
	default_arguments.loss_rate_step					= .1;
	default_arguments.back_to_back_initrate				= 500000;
	default_arguments.back_to_back_step					= 100000;
	default_arguments.back_to_back_limit				= 1000000;
	default_arguments.system_recovery_overload_time		= 60000000;
	default_arguments.system_recovery_pktseq			= 100000;
	default_arguments.system_recovery_iterations		= 5;
	default_arguments.usb								= 1;
	default_arguments.payload_type						= 0;				//payload with bert by default
	default_arguments.mac_source 						= 0x00215adfd164;	//Default mac source
	default_arguments.mac_target 						= 0x00215adfd165;	//Default mac target
	default_arguments.ip_source  						= 0xc0a80004;		//Default IP source
	default_arguments.ip_target  						= 0xffffffff;		//Default IP target
	default_arguments.mac_filter 						= 0; 				//Default MAC Filter - inverts mac source and mac target and receives just packets in broadcast or intended for its mac
	default_arguments.lfsr_polynomial 					= 0; 				//Default LFSR polynomial
	sprintf(default_arguments.resource, "/sys/bus/pci/devices/0000:");
	//default_arguments.resource							= "/sys/bus/pci/devices/0000:03:00.0/resource0";
	sprintf(default_arguments.out_file, "plots.txt");
	default_arguments.throughput_test_flag				= 0; // False
	default_arguments.latency_test_flag					= 0; // False
	default_arguments.back_to_back_test_flag			= 0; // False
	default_arguments.loss_rate_test_flag				= 0; // False
	default_arguments.system_recovery_test_flag			= 0; // False
	default_arguments.reset_test_flag					= 0; // False
	default_arguments.timed_throughput_test_flag		= 0; // False
	default_arguments.loopback_test_flag				= 0; // False
	default_arguments.rfc2544_flag						= 0; // False
	default_arguments.training_flag						= 0; // False
	default_arguments.soft_reset_flag					= 0; // False
	default_arguments.read_status_flag					= 0; // False
	default_arguments.sfps_flags[0]						= 0; // False
	default_arguments.sfps_flags[1]						= 0; // False
	default_arguments.sfps_flags[2]						= 0; // False
	default_arguments.sfps_flags[3]						= 0; // False
	default_arguments.ps_flags[0]						= 0; // False
	default_arguments.ps_flags[1]						= 0; // False
	default_arguments.ps_flags[2]						= 0; // False
	default_arguments.ps_flags[3]						= 0; // False
	default_arguments.ps_flags[4]						= 0; // False
	default_arguments.ps_flags[5]						= 0; // False
	default_arguments.ps_flags[6]						= 0; // False
	default_arguments.ps_flags[7]						= 0; // False
	default_arguments.verbose_flag						= 0; // False
	default_arguments.pktlen 							= 64;
	default_arguments.timing 							= 60;
	default_arguments.acceptable_error					= 0;

	result = default_arguments;

	static struct option long_options[] =
	{
		/* These options set a flag. */
		{"throughput", no_argument, &result.throughput_test_flag, 1},
		{"latency", no_argument, &result.latency_test_flag, 1},
		{"back-to-back", no_argument, &result.back_to_back_test_flag, 1},
		{"loss-rate", no_argument, &result.loss_rate_test_flag, 1},
		{"system-recovery", no_argument, &result.system_recovery_test_flag, 1},
		{"reset", no_argument, &result.reset_test_flag, 1},
		{"timed-throughput", no_argument, &result.timed_throughput_test_flag, 1},
		{"loopback", no_argument, &result.loopback_test_flag, 1},
		{"rfc2544", no_argument, &result.rfc2544_flag, 1},
		{"training", no_argument, &result.training_flag, 1},
		{"soft-reset", no_argument, &result.soft_reset_flag, 1},
		{"read-status", no_argument, &result.read_status_flag, 1},
		{"sfp1", no_argument, &result.sfps_flags[0], 1},
		{"sfp2", no_argument, &result.sfps_flags[1], 1},
		{"sfp3", no_argument, &result.sfps_flags[2], 1},
		{"sfp4", no_argument, &result.sfps_flags[3], 1},
		{"ps64", no_argument, &result.ps_flags[0], 1},
		{"ps128", no_argument, &result.ps_flags[1], 1},
		{"ps256", no_argument, &result.ps_flags[2], 1},
		{"ps512", no_argument, &result.ps_flags[3], 1},
		{"ps768", no_argument, &result.ps_flags[4], 1},
		{"ps1024", no_argument, &result.ps_flags[5], 1},
		{"ps1280", no_argument, &result.ps_flags[6], 1},
		{"ps1518", no_argument, &result.ps_flags[7], 1},
		{"verbose", no_argument, &result.verbose_flag, 1},
		/* These options don’t set a flag.
		We distinguish them by their indices. */
		{"acceptable-error",     required_argument,       0, 'x'},
		{"top-rate",     required_argument,       0, 'r'},
		{"npkts",  required_argument,       0, 'n'},
		{"timeout",  required_argument, 0, 't'},
		{"throughput-initrate",  required_argument, 0, 'i'},
		{"throughput-step",  required_argument, 0, 's'},
		{"latency-load-time",  required_argument, 0, 'l'},
		{"loss-rate-step",  required_argument, 0, 'p'},
		{"back-to-back-init",  required_argument, 0, 'b'},
		{"back-to-back-step",  required_argument, 0, 'c'},
		{"back-to-back-limit",  required_argument, 0, 'k'},
		{"system-recovery-overload-time",  required_argument, 0, 'd'},
		{"system-recovery-pkt-recovery-sequence",  required_argument, 0, 'e'},
		{"system-recovery-pkt-iterations",  required_argument, 0, 'g'},		
		{"pktlen",  required_argument, 0, 'w'},
		{"timing",     required_argument,       0, 'a'},
		{"out-file",  required_argument, 0, 'o'},
		{"usb",  required_argument, 0, 'u'},
		{"resource",  required_argument, 0, 'z'},
		{"help",  no_argument, 0, 'h'},
		{"mac-source",    required_argument,       0,   'A'},
		{"mac-target",    required_argument,       0,	'B'},
		{"ip-source",     required_argument,       0, 	'C'},
		{"ip-target",     required_argument,       0, 	'D'},
		{"payload-type",  required_argument,	   0,	'F'},
		{"lfsr-polynomial",  required_argument,	   0,	'G'},
		{"mac-filter",		 required_argument,	   0,	'H'},

		{0, 0, 0, 0}
	};

	while ((option = getopt_long (argc, argv, "x:r:n:t:i:s:l:p:b:c:i:d:e:g:w:a:o:u:A:B:C:D:E:F:G:H:z:h",
			long_options, &option_index)) != -1) {
		switch (option) {
			case 0 :
			/* If this option set a flag, do nothing else now. */
			if (long_options[option_index].flag != 0)
			break;
			case 'x' :
			result.acceptable_error = atoi(optarg);
			break;
			case 'r' :
			result.top_rate = atoi(optarg);
			break;
			case 'n' :
			result.npkts = atol(optarg);
			break;
			case 't' :
			result.timeout = atoi(optarg);
			break;
			case 'i' :
			result.throughput_initrate = atoi(optarg);
			break;
			case 's' :
			result.throughput_step = atoi(optarg);
			break;
			case 'l' :
			result.latency_wait = atoi(optarg);
			break;
			case 'p' :
			result.loss_rate_step = atof(optarg);
			break;
			case 'b' :
			result.back_to_back_initrate = atoi(optarg);
			break;
			case 'c' :
			result.back_to_back_step = atoi(optarg);
			break;
			case 'k' :
			result.back_to_back_limit = atoi(optarg);
			break;
			case 'd' :
			result.system_recovery_overload_time = atoi(optarg);
			break;
			case 'e' :
			result.system_recovery_pktseq = atoi(optarg);
			break;
			case 'g' :
			result.system_recovery_iterations = atoi(optarg);
			break;
			case 'w' :
			result.pktlen = atoi(optarg);
			break;
			case 'a' :
			result.timing = atoi(optarg);
			break;
			case 'o' :
			sprintf(result.out_file, "%s", optarg);
			break;
			case 'u' :
			result.usb = atoi(optarg);
			break;
			case 'A' :
			result.mac_source = strtol(optarg,NULL,16);
			break;
			case 'B' :
			result.mac_target = strtol(optarg,NULL,16);
			break;
			case 'C' :
			result.ip_source = atoi(optarg);
			break;
			case 'D' :
			result.ip_target = atoi(optarg);
			break;
			case 'F' :
			result.payload_type = atoi(optarg);
			break;
			case 'G':
			result.lfsr_polynomial = atoi(optarg);
			break;
			case 'H':
			result.mac_filter = atoi(optarg);
			break;
			case 'z' :
			sprintf(result.resource, "%s", optarg);
			break;
			case 'h' :
			print_usage(argv[0], default_arguments);
			exit(0);
			break;
			case '?':
			/* getopt_long already printed an error message. */
			argument_error_flag = 1;
			break;
			default:
			exit(1);
		}
	}

	system("./pciRescan.sh");
	fp = popen("lspci | grep Xilinx | awk '{print $1}'", "r");
	fgets(found_device, sizeof(char)*8, fp);
	fclose(fp);
	sprintf(default_arguments.resource, "%s%s%s", default_arguments.resource, found_device, "/resource0");

	if(strlen(found_device) == 0) {
		printf("XGT4 FPGA not found!\n");
		exit(1);
	} else {
		printf("XGT4 FPGA found at :%s\n", default_arguments.resource);
	}

	if(argument_error_flag) {
		print_usage(argv[0], default_arguments);
		exit(1);
	}

	if(!result.rfc2544_flag && !result.throughput_test_flag &&
		!result.latency_test_flag	&& !result.loss_rate_test_flag &&
		!result.back_to_back_test_flag && !result.system_recovery_test_flag && !result.reset_test_flag
		&& !result.timed_throughput_test_flag && !result.loopback_test_flag 
		&& !result.training_flag && !result.soft_reset_flag
		&& !result.read_status_flag){
		printf("NO TEST SELECTED!\n");
		print_usage(argv[0], default_arguments);
		exit(1);
	}

	/* Enables all SFPS by default */
	if(!is_sfps(result)){
		for(i = 0; i < NUMBER_OF_SFPS; i++){
			result.sfps_flags[i] = 1;
		}
	}

	/* Enables all size packets by default */
	if(!is_packet_sizes(result)){
		for(i = 0; i < NUMBER_OF_SIZES; i++){
			result.ps_flags[i] = 1;
		}
	}
	return result;
}


