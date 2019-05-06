/*****************************************************************************\
| File Name: RFC2544.c 									                 	|
| Project: PD1461 - netFPGA SUME						             		|
| Author: Lucas Pugens Fernandes & Thiago Mânica Monteiro					|
| Purpose: Run RFC2544 tests over a network using a netFPGA SUME board		|
| Version: 3.0										                       	|
| Date: July, 2016									                 		|
/*****************************************************************************/

/**
 * @file RFC2544.c
 * @author Lucas Pugens
 * @date 8 July 2016
 * @brief Code implementing the software/hardware communication for the tester.
 *
 * This code...
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <fcntl.h>
#include <ctype.h>
#include <errno.h>
#include <termios.h>
#include <math.h>
#include <sys/types.h>
#include <sys/mman.h>

#include "RFC2544.h"

#include <stdint.h>
#include <inttypes.h>

/* Initialize semaphores */
void initialize(){
	pthread_mutex_init(&mutex_uart, NULL);
	pthread_mutex_init(&mutex_printf, NULL);

	printf("+------------------------------------------------------+\n");
	printf("|                   _                                  |\n");
	printf("|       _ __   ___ | |__                               |\n");
	printf("|      | '_ \\ | ' ||  __|                              |\n");
	printf("|      | | | || __/| |__                               |\n");
	printf("|      |_| |_|\\___| \\___|                              |\n");
	printf("|                                                      |\n");
	printf("|                                                      |\n");
	printf("|                    ___   _   _ _ __   __  ___        |\n");
	printf("|                   / __| | | | | '_ \\ /| || ' |       |\n");
	printf("|                   \\__  \\| |_| | | | | | || __/       |\n");
	printf("|                    |___/ \\___//_| |_| |_|\\___|       |\n");
	printf("|                                                      |\n");
	printf("|                                                      |\n");
	printf("+------------------------------------------------------+\n");
	printf("\n");
}

/**
Set addresses of destination and source
\param sfp the SFP number to cofigure the default values, mac source, mac target, ip source and ip target addresses
\return void
*/
void setSwitchRegs(char sfp, unsigned long int mac_source, unsigned long int mac_target, unsigned int ip_source, unsigned int ip_target, unsigned int mac_filter){
		unsigned int mac_source_h;
		unsigned int mac_source_l;

		unsigned int mac_target_h;
		unsigned int mac_target_l;

		//mascara para separar parte alta e baixa
		mac_source_h = (mac_source & 0xffff00000000) >> 32;
		printf("Mac src High: %u\n", mac_source_h);

		mac_source_l = (mac_source & 0x0000ffffffff);
		printf("Mac src Low: %u\n", mac_source_l);

		mac_target_h = (mac_target & 0xffff00000000) >> 32;
		printf("Mac target High: %u\n", mac_target_h);

		mac_target_l = (mac_target & 0x0000ffffffff);
		printf("Mac target Low: %u\n", mac_target_l);

		mpu_write_pci(sfp, MAC_SOURCE_31_0_REG,  mac_source_l);
		mpu_write_pci(sfp, MAC_SOURCE_47_32_REG, mac_source_h);

		mpu_write_pci(sfp, MAC_DESTINATION_31_0_REG,  mac_target_l);
		mpu_write_pci(sfp, MAC_DESTINATION_47_32_REG, mac_target_h);

		mpu_write_pci(sfp, IP_SOURCE_REG, ip_source);

		mpu_write_pci(sfp, IP_DESTINATION_REG, ip_target);

		mpu_write_pci(sfp, LOOPBACK_FILTER_REG, mac_filter);
}

/**
Detects the DUT maximum rate throught multiple datagram trains
searching the maximum dute rate in a binary search style.
\param pktlen size of the generated packets
\param npkts number of packets to generate
\param top_rate maximum media rate
\param step variation in the rate at each packet train
\param timeout maximum waiting time for a response
\param sfp SFP identification for the test
\param verbose flag to print more info
\param loss_rate acceptable loss rate during the test
\param payload_type indicates if the payload type is ID (System Recovery test - variable set as 0), LFSR (variable set as 1), all 0s (variable set as 2) or all 1s (variable set as 3)
\param mac_source indicates the mac source address
\param mac_target indicates the mac target address
\param ip_source indicates the ip source address
\param ip_target indicates the ip target address
\param mac_filter indicates if the receiver operates in promiscous mode or just receives the packets intended for its MAC as well if the loopback inverts or not the mac source and mac target fields
\return result_throughput struct
*/
struct result_throughput throughput(unsigned int pktlen,
									unsigned long long npkts, double top_rate,
									unsigned int step, unsigned int timeout,
									char sfp, int verbose, double loss_rate, unsigned int payload_type,
									unsigned long int mac_source, unsigned long int mac_target,
									unsigned int ip_source, unsigned int ip_target, unsigned int mac_filter){

	double rate;							/* Current train rate */
	double bert;							/* Bit Error Rate */
	double throughput;						/* Current throughput train */
	double rate_out;						/* Best case throughput rate */
	unsigned long long received_pkts;		/* Number of received packets at each train */
	unsigned long long bitsWithError;		/* The number of bits lost in transmission */
	unsigned long long idleCount;			/* Number of idles read from hardware */
	unsigned int end_test;					/* Flag to indicate the end of the test */
	unsigned int idle_number;				/* Number of idle cycles related to the rate at each train */
	unsigned int temp_idle;					/* Auxiliar variable to grant change of rate at each train */
	unsigned int first_loop;				/* Flag indicating first train of data */
	unsigned int tested_rate;				/* Indicates the current rate to run the binary search */
	unsigned int numberOfIdlesHigh;			/* Most significant bytes of number of idles register */
	unsigned int numberOfIdlesLow;			/* Less significant bytes of number of idles register */
	unsigned int intern_step;				/* Calculated step */
	unsigned int last_step;					/* Step prior to the current used step */
	unsigned int flagLostPacket;			/* Indicates wether any bit was flipped in any train */
	unsigned int flagNoLostPacket;			/* Indicates wether any train ocurred without bit errors */
	unsigned int flagLostPacketInLastTrain;	/* Indicates wether the LAST train ocurred with bit errors */
	unsigned int bitsWithErrorLow;			/* Number of bit flips in the last train - Low part */
	unsigned int bitsWithErrorHigh;			/* Number of bit flips in the last train - High part */
	struct result_throughput result;		/* Result struct */

	/* Initializing variables */
	result.rate 		= 0;
	result.idle 		= 0;
	result.bert 		= 0;
	bert 				= 0;
	throughput 			= 0;
	bitsWithError 		= 0;
	idleCount 			= 0;
	end_test 			= 0;
	rate 				= top_rate;
	idle_number 		= idle_calc(rate, pktlen);
	rate 				= rate_calc(idle_number, pktlen);
	first_loop 			= 1;
	tested_rate			= 1;
	numberOfIdlesHigh 	= 0;
	numberOfIdlesLow 	= 0;
	last_step 			= binary_search(tested_rate,top_rate/4);
	flagLostPacket 		= 0;
	flagLostPacket 		= 0;
	flagNoLostPacket 	= 0;
	bitsWithErrorHigh 	= 0;
	bitsWithErrorLow 	= 0;

	wrap_printf(sfp+1, "%-30s\n","##Running Throughput test");
	wrap_printf(sfp+1, "%-30s%li\n","##Number of packets:", npkts);
	wrap_printf(sfp+1, "%-30s%d KB\n","##Packet length:", pktlen);
	wrap_printf(sfp+1, "%-30s%f Mbit/s\n","##Init rate:", rate);
	wrap_printf(sfp+1, "%-30s%d Mbit/s\n","##Step:", step);
	wrap_printf(sfp+1, "%-30s%.4f ms\n","##Timeout:", ((double)timeout*6.4/1000));

	intern_step = binary_search(tested_rate,last_step);	/* Initial binary search value */

	/* Trains of data and checking of results */
	do{
		if(verbose){
			wrap_printf(sfp+1, "###NEW ITERATION\n");
			wrap_printf(sfp+1, "%-30s%f Mbit/s\n","    Current Frame Rate:", rate);
			wrap_printf(sfp+1, "%-30s%d\n","    Idle number:", idle_number);
		}

		/* HARDWARE PRECONFIGURATION ##################################################### */
		reset(sfp);																	/* Reset state of tester Hardware */
		setSwitchRegs(sfp,mac_source,mac_target,ip_source,ip_target, mac_filter);   /* Set MACs and IPs for a given test */
		mpu_write_pci(sfp, PKT_NUMBER_31_0_REG, npkts);								/* Write number of packets to hardware - High part */
		mpu_write_pci(sfp, PKT_NUMBER_63_32_REG, (npkts >> 32));					/* Write number of packets to hardware - Low part */
		set_cycles(pktlen,sfp);														/* Write packet length */
		mpu_write_pci(sfp, TIMEOUT_REG, 50000);										/* Write timeout time amount */
		mpu_write_pci(sfp, IDLE_NUMBER_REG, idle_number);							/* Write the new number of idles related to the required rate */
		mpu_write_pci(sfp, TEST_CODE_REG, 0);										/* Write test code */
		mpu_write_pci(sfp, PAYLOAD_TYPE_REG, 0);									/* PAYLOAD TYPE bert */
		/* END OF HARDWARE PRECONFIGURATION ############################################### */

		write_status(sfp, STATUS_REG, 1);								/* Starts test */

		read_status(sfp, STATUS_BACK_REG);								/* Awaits for end of test */

		PKT_RX_31_0 	= mpu_read_pci(sfp, PKT_RX_31_0_REG);			/* Reads from hardware how many packets were correctly received - Low part */
		PKT_RX_63_32 	= mpu_read_pci(sfp, PKT_RX_63_32_REG);			/* Reads from hardware how many packets were correctly received - High part */
		received_pkts = PKT_RX_63_32*0x100000000 + PKT_RX_31_0;			/* Join High and Low parts */

		numberOfIdlesLow = mpu_read_pci(sfp, TIME_RECEIVER_31_0_REG);	/* Reads from hardware how many idles cycles it had to await for each packet - Low part */
		numberOfIdlesHigh = mpu_read_pci(sfp, TIME_RECEIVER_63_32_REG);	/* Reads from hardware how many idles cycles it had to await for each packet - High part */
		idleCount = numberOfIdlesHigh*0x100000000 + numberOfIdlesLow;	/* Join High and Low parts */

		bitsWithErrorLow = mpu_read_pci(sfp, CONT_ERROR_31_0_REG);			/* Reads from hardware the number of bit occurred in the packet - Low part */
		bitsWithErrorHigh = mpu_read_pci(sfp, CONT_ERROR_63_32_REG);		/* Reads from hardware the number of bit occurred in the packet - High part */
		bitsWithError = bitsWithErrorHigh*0x100000000 + bitsWithErrorLow;		/* Join High and Low parts */

		bert = (bitsWithError/(npkts*pktlen*8.0)) * 100.0;				/* Calculates the Bit Error Rate (BERT) */

		throughput = rateFromIdle(idleCount, pktlen, npkts);			/* Get throughput rate obtained */

		/* All packets received - updates rate values */
		if(received_pkts == npkts){
			result.rate = throughput;
			result.idle = idle_number;
		}

		/* Conditions to end test */
		if((idle_number == 1 && received_pkts >= (npkts - npkts*loss_rate/100)) ||
			(intern_step == 1 && flagLostPacket == 1 && flagNoLostPacket == 1)){
				end_test = 1;
		} else {
			/* Check for bit-flips in the last train */
			if(received_pkts < npkts){
				flagLostPacket = 1;				/* Set to 1, does not goes back to 0 */
				flagLostPacketInLastTrain = 1;	/* Set again at each train */
			}else{
				flagNoLostPacket = 1;			/* Set to 1, does not goes back to 0 */
				flagLostPacketInLastTrain = 0;	/* Set again at each train */
			}

			/* Any train with bit-flips AND any train without bit-flips */
			if(flagLostPacket == 1 && flagNoLostPacket == 1){
				last_step = intern_step;							/* Keep track of last step */
				intern_step = binary_search(tested_rate,last_step);	/* Updates new step according to the rules */
			}

			temp_idle = idle_number;			/* Save the number of idles from last train */

			/* Do until get a new idle_number.
				Sometimes the throughput step calculed can be so small it does not change the real
				throughput because it is related to the hardware clock */
			do{
				if (flagLostPacketInLastTrain==0){
					rate = rate + intern_step;
				}else if (flagLostPacketInLastTrain==1){
					rate = rate - intern_step;
				}
				/* Recalculate the idle number */
				idle_number = idle_calc(rate, pktlen);

			}while(temp_idle == idle_number);

			/* Recalculates the throughput rate to the next train */
			rate = rate_calc(idle_number, pktlen);
		}

		/* Prints the number if sent and received packets from last train */
		if(verbose){
			wrap_printf(sfp+1, "%-30s%llu\n","    ->tx:", npkts);
			wrap_printf(sfp+1, "%-30s%llu\n","    ->rx:", received_pkts);
		}
	}while(end_test != 1 && rate > 0);

	/* No viable throughput found with given step */
	if(result.rate <= 0){
		result.rate = 0;
		result.idle = 0;
	}

	wrap_printf(sfp+1, "%-30s\n","##END THROUGHPUT TEST");
	wrap_printf(sfp+1, "%-30s%f Mbit/s\n","   ->Maximum effective throughput rate:", result.rate);
	wrap_printf(sfp+1, "%-30s%d cycles\n","   ->Minimum idle cycles:", result.idle);
	wrap_printf(sfp+1, "%-30s%f \%\n","   ->Bit Error Rate:", result.bert);

	return result;
}

/**
Detects the DUT average delay time between transmission and reception using maximum rate
detected in the throughput test.
\param pktlen size of the generated packets
\param max_rate result from the throughput test
\param time time of data train before the delay is measured (microsecond)
\param timeout maximum time between a packet can be received after it was sent (microsecond)
\param sfp which SFP will transmit the test
\param verbose flag to print more info
\param payload_type indicates if the payload type is ID (System Recovery test - variable set as 0), LFSR (variable set as 1), all 0s (variable set as 2) or all 1s (variable set as 3)
\param mac_source indicates the mac source address
\param mac_target indicates the mac target address
\param ip_source indicates the ip source address
\param ip_target indicates the ip target address
\param mac_filter indicates if the receiver operates in promiscous mode or just receives the packets intended for its MAC as well if the loopback inverts or not the mac source and mac target fields
\return double value for the average latency
*/
double latency(unsigned int pktlen, struct result_throughput max_rate,
							unsigned int time, unsigned int timeout, char sfp,
							int verbose, unsigned int payload_type, unsigned long int mac_source,
							unsigned long int mac_target, unsigned int ip_source, unsigned int ip_target, unsigned int mac_filter){

	double result_latency;	/* Measured average latency */
	int i;					/* Loop variable */

	wrap_printf(sfp+1, "%-30s\n","##Running Latency test");
	wrap_printf(sfp+1, "%-30s%d KB\n","##Packet length:", pktlen);
	wrap_printf(sfp+1, "%-30s%f Mbit/s\n","##Rate:", max_rate.rate);
	wrap_printf(sfp+1, "%-30s%.4f ms\n","##Timeout:", ((double)timeout*6.4/1000));
	wrap_printf(sfp+1, "%-30s%.4f s * 20\n","##Wait:", ((double)time/1000000));

	result_latency = 0;
	/* Measure the latency 20 times to take the average delay time */
	for(i = 0; i < 20; i++){


		/* HARDWARE PRECONFIGURATION ##################################################### */
		reset(sfp);																	/* Reset state of tester Hardware */
		setSwitchRegs(sfp,mac_source,mac_target,ip_source,ip_target, mac_filter);   /* Set MACs and IPs for a given test */
		set_cycles(pktlen,sfp);														/* Write packet length */
		mpu_write_pci(sfp, TIMEOUT_REG, 50000);										/* Write timeout time amount */
		mpu_write_pci(sfp, IDLE_NUMBER_REG, max_rate.idle);							/* Write the number of idles related to the maximum rate measured by the throughput test */
		mpu_write_pci(sfp, TEST_CODE_REG, 1);										/* Write test code */
		mpu_write_pci(sfp, PAYLOAD_TYPE_REG, 0);									/* PAYLOAD TYPE bert */
		/* END OF HARDWARE PRECONFIGURATION ############################################### */

		write_status(sfp, STATUS_REG, 1);	/* Starts test */
		usleep(time);						/* Waits for the given time while the hardware maintain a continuous train of packets */

		write_status(sfp, STATUS_REG, 2);	/* Tell hardware to measure the delay time between emit and receive the next packet */
		read_status(sfp, STATUS_BACK_REG);	/* Wait for the end of the test */

		LATENCY_31_0 	= mpu_read_pci(sfp, LATENCY_31_0_REG);					/* Read from the hardware the delay time of one packet - Low part */
		LATENCY_47_32 	= mpu_read_pci(sfp, LATENCY_47_32_REG);					/* Read from the hardware the delay time of one packet - High part */
		result_latency += (LATENCY_47_32*0x100000000 + LATENCY_31_0)*0.0064;	/* Join High and Low parts */
	}

	result_latency = result_latency/20;		/* Average the recorded values of latency */

	wrap_printf(sfp+1, "%-30s\n","##END LATENCY TEST");
	wrap_printf(sfp+1, "%-30s%f us\n","   ->Latency:", result_latency);

	return result_latency;
}

/**
Measure the loss-rate of packets at high throughput rates by sending trains
of packets starting from the maximum throughput supported by the media,
then decreases the rate at a given step until it stops losing packets.
Keep lowering the rate until there are two consecutive steps without lost packets.
Return a list of pointers with a loss-rate for each throughput rate tested at the trains.
\param pktlen size of the generated packets
\param npkts number of packets for each train of packets
\param top_rate maximum throughput rate from the media (usually 1 or 10 Gb/s)
\param percent_step percentage of the maximum media throughput to be used as a step between trains
\param timeout maximum time between a packet can be received after it was sent
\param sfp which SFP will transmit the test
\param verbose flag to print more info
\param acceptable_error percentage of packets lost that can be ignored
\param payload_type indicates if the payload type is ID (System Recovery test - variable set as 0), LFSR (variable set as 1), all 0s (variable set as 2) or all 1s (variable set as 3)
\param mac_source indicates the mac source address
\param mac_target indicates the mac target address
\param ip_source indicates the ip source address
\param ip_target indicates the ip target address
\param mac_filter indicates if the receiver operates in promiscous mode or just receives the packets intended for its MAC as well if the loopback inverts or not the mac source and mac target fields
\return *result_loss_rate pointer to a list of result_loss_rate containing all the tested values. The first struct in the array will contain in its rate value the number of allocated structs, the other positions contain real values.
*/
struct result_loss_rate * loss_rate(unsigned int pktlen,
									unsigned long long npkts, unsigned int timeout,
									unsigned int top_rate, double percent_step,
									char sfp, int verbose, int acceptable_error,
									unsigned int payload_type, unsigned long int mac_source,
									unsigned long int mac_target, unsigned int ip_source, unsigned int ip_target, unsigned int mac_filter){

	struct result_loss_rate *result;	/* Dynamic pointer list of results */
	double rate;						/* Throughput rate for each train of packets */
	double showLossRate;				/* Measured loss rate for the given size of packet */
	int i;								/* Loop variable */
	int idle_number;					/* Number of idles used to calculate the throughput rate */
	int temp_idle;						/* Auxiliar variable to ensure the throughput rate between trains is changed */
	int countNoLossInSequence;			/* Count the number of consecutive trains of data without loss of packets */
	int count;							/* Count the number of steps */
	unsigned long long received_pkts;	/* Number of received packets */

	wrap_printf(sfp+1, "%-30s\n","##Running Loss Rate test");
	wrap_printf(sfp+1, "%-30s%d KB\n","##Packet length:", pktlen);
	wrap_printf(sfp+1, "%-30s%li\n","##Number of packets:", npkts);
	wrap_printf(sfp+1, "%-30s%.4f ms\n","##Timeout:", ((double)timeout*6.4/1000));

	idle_number = idle_calc(top_rate, pktlen);	/* Idle number related to the maximum media throughput rate */
	rate = rate_calc(idle_number, pktlen);		/* Real rate obtained for the given packet size */

	result = (struct result_loss_rate *) malloc(sizeof(struct result_loss_rate)*100); /* Malloc space to 100 structs */
	/* Initialize these structs with a invalid loss-rate */
	for(i = 0; i < 100; i++){
		result[i].loss_rate = -1;
	}
	result[0].rate = 100;	/* Rate percentage of 100% at the first train */

	countNoLossInSequence = 0;
	count = 1;
	do{
		/* In need of more points, it is allocated a hundred more structs */
		if(count > result[0].rate-1){
			result = (struct result_loss_rate *)realloc(result, (count + 100) * sizeof(struct result_loss_rate));
			for(i = 0; i < 100; i++){
				result[(int)(i+result[0].rate)].loss_rate = -1;
			}
			result[0].rate = result[0].rate + 100;
		}
		if(verbose){
			wrap_printf(sfp+1, "%-30s\n","\n###NEW THROUGHPUT RATE");
			wrap_printf(sfp+1, "%-30s%f Mbit/s\n","    ->Throughput rate:", rate);
			wrap_printf(sfp+1, "%-30s%d\n","    ->Idle number for this rate:", idle_number);
			wrap_printf(sfp+1, "%-30s%d %%\n","    ->Acceptable error:", acceptable_error);
		}

		/* HARDWARE PRECONFIGURATION ##################################################### */
		reset(sfp);																	/* Reset state of tester Hardware */
		setSwitchRegs(sfp,mac_source,mac_target,ip_source,ip_target, mac_filter);	/* Set MACs and IPs for a given test */
		mpu_write_pci(sfp, PKT_NUMBER_31_0_REG, npkts);								/* Write number of packets to hardware - High part */
		mpu_write_pci(sfp, PKT_NUMBER_63_32_REG, (npkts >> 32));					/* Write number of packets to hardware - Low part */
		set_cycles(pktlen,sfp);														/* Write packet length */
		mpu_write_pci(sfp, TIMEOUT_REG, 50000);										/* Write timeout time amount */
		mpu_write_pci(sfp, IDLE_NUMBER_REG, idle_number);							/* Write the number of idles related to the maximum rate measured by the throughput test */
		mpu_write_pci(sfp, TEST_CODE_REG, 0);										/* Write test code */
		mpu_write_pci(sfp, PAYLOAD_TYPE_REG, 0);									/* PAYLOAD TYPE bert */
		/* END OF HARDWARE PRECONFIGURATION ############################################### */

		write_status(sfp, STATUS_REG, 1);						/* Indicates hardware to start the test */
		read_status(sfp,STATUS_BACK_REG);						/* Waits hardware signal of test end */

		PKT_RX_31_0 	= mpu_read_pci(sfp, PKT_RX_31_0_REG);	/* Reads from hardware how many packets were correctly received - Low part */
		PKT_RX_63_32 	= mpu_read_pci(sfp, PKT_RX_63_32_REG);	/* Reads from hardware how many packets were correctly received - High part */
		received_pkts = PKT_RX_63_32*0x100000000 + PKT_RX_31_0;	/* Join High and Low parts */

		result[count].loss_rate = ((double)npkts - (double)received_pkts) * 100.0 / (double)npkts;	/* Calculates the number of packets lost in the last train */
		result[count].rate = rate/(double)top_rate * 100.0;											/* Calculate the percentage of the last train rate in respect to the maximum media rate */

		showLossRate = result[count].loss_rate;		/* Loss rate to show */

		if(verbose){
			wrap_printf(sfp+1, "%-30s%f %%\n","    ->Loss rate:", result[count].loss_rate);
		}

		temp_idle = idle_number;	/* Save the number of idles from last train */

		/* Do until get a new idle_number.
			Sometimes the throughput step calculed can be so small it does not change the real
			throughput because it is related to the hardware clock */
		do{
			rate = rate * (1.0-percent_step*(double)count);
			idle_number = idle_calc(rate, pktlen);
		}while(temp_idle == idle_number);
		rate = rate_calc(idle_number, pktlen);

		/* Increment the counter of no loss in sequence in case the loss_rate was in the acceptable range */
		if(result[count].loss_rate <= acceptable_error){
			countNoLossInSequence++;
		} else {
			countNoLossInSequence = 0;
		}

		count++;
	}while(countNoLossInSequence < 2 && rate > 0);

	wrap_printf(sfp+1, "%-30s\n","##END LOSS RATE TEST");
	wrap_printf(sfp+1,"Loss occured for this test: %f\n", showLossRate);

	return result;
}

/**
Test for drops of packets in long trains of packets at the maximum throughput rate
\param pktlen size of the generated packets
\param npkts number of packets for the starting train of packets
\param max_rate result from the throughput test
\param pktstep step used to increse the number of packets between trains
\param timeout maximum time between a packet can be received after it was sent
\param limit maximum number of packets to be tested in a single train
\param sfp which SFP will transmit the test
\param verbose flag to print more info
\param payload_type indicates if the payload type is ID (System Recovery test - variable set as 0), LFSR (variable set as 1), all 0s (variable set as 2) or all 1s (variable set as 3)
\param mac_source indicates the mac source address
\param mac_target indicates the mac target address
\param ip_source indicates the ip source address
\param ip_target indicates the ip target address
\param mac_filter indicates if the receiver operates in promiscous mode or just receives the packets intended for its MAC as well if the loopback inverts or not the mac source and mac target fields
\return how many packets could be sent in a single train
*/
unsigned int back_to_back(unsigned int pktlen, unsigned long long npkts,
						struct result_throughput max_rate,
						unsigned int pktstep,
						unsigned int timeout, unsigned int limit,
						char sfp, int verbose,
						unsigned int payload_type, unsigned long int mac_source,
						unsigned long int mac_target, unsigned int ip_source, unsigned int ip_target, unsigned int mac_filter){

	unsigned long long local_npkts;		/* Number of packets in each train */
	unsigned long long received_pkts;	/* Number of received packets at each train */
	unsigned long long sent_pkts;		/* Number of sent packets at each train */
	int flagEndTest;					/* Flag to indicate end of test */
	int flagFirstIteration;				/* Flag to indicate first iteration of loop */
	int intern_step;					/* Intern step to increase the number of packets (Can be negative) */
	unsigned int result;				/* Maximum number of packets successfully received in a single train */

	flagEndTest = 0;
	result = 0;
	local_npkts = npkts;				/* Starting number of packets */
	intern_step = pktstep;				/* Starting step of trains */

	wrap_printf(sfp+1, "%-30s\n","##Running Back-to-Back test");
	wrap_printf(sfp+1, "%-30s%d KB\n","##Packet length:", pktlen);
	wrap_printf(sfp+1, "%-30s%li\n","##Starting number of packets:", local_npkts);
	wrap_printf(sfp+1, "%-30s%-10f Mb/s\n","##Maximum rate:", max_rate.rate);
	wrap_printf(sfp+1, "%-30s%-10d\n","##Number of packets step:", pktstep);
	wrap_printf(sfp+1, "%-30s%.4f ms\n","##Timeout:", ((double)timeout*6.4/1000));

	flagFirstIteration = 1;				/* Indicates the first train of packets */
	do{
		if(verbose){
			wrap_printf(sfp+1, "%-30s\n","\n###NEW packet NUMBER");
			wrap_printf(sfp+1, "%-30s%li\n","    ->Number of packets:", local_npkts);
		}

		/* HARDWARE PRECONFIGURATION ##################################################### */
		reset(sfp);																	/* Reset state of tester Hardware */
		setSwitchRegs(sfp,mac_source,mac_target,ip_source,ip_target, mac_filter);	/* Set MACs and IPs for a given test */
		mpu_write_pci(sfp, PKT_NUMBER_31_0_REG, local_npkts);						/* Write number of packets to hardware - High part */
		mpu_write_pci(sfp, PKT_NUMBER_63_32_REG, (local_npkts >> 32));				/* Write number of packets to hardware - Low part */
		set_cycles(pktlen,sfp);														/* Write packet length */
		mpu_write_pci(sfp, TIMEOUT_REG, 50000);										/* Write timeout time amount */
		mpu_write_pci(sfp, IDLE_NUMBER_REG, max_rate.idle);							/* Write the number of idles related to the maximum rate measured by the throughput test */
		mpu_write_pci(sfp, TEST_CODE_REG, 0);										/* Write test code */
		/* END OF HARDWARE PRECONFIGURATION ############################################### */

		write_status(sfp, STATUS_REG, 1);		/* Indicates hardware to start the test */
		read_status(sfp, STATUS_BACK_REG);		/* Waits hardware signal of test end */

		PKT_RX_31_0 	= mpu_read_pci(sfp, PKT_RX_31_0_REG);	/* Reads from hardware how many packets were correctly received - Low part */
		PKT_RX_63_32 	= mpu_read_pci(sfp, PKT_RX_63_32_REG);	/* Reads from hardware how many packets were correctly received - High part */
		received_pkts = PKT_RX_63_32*0x100000000 + PKT_RX_31_0;	/* Join High and Low parts */

		if(verbose){
			wrap_printf(sfp+1, "%-30s%li\n","   ->local_npkts:", local_npkts);
			wrap_printf(sfp+1, "%-30s%li\n","   ->received_pkts:", received_pkts);
		}

		/* All packets received correctly */
		if(local_npkts == received_pkts){
			result = local_npkts;
		}

		/* If the first iteration loses packets the step will be decremental until it receives all the pakets correctly */
		if(flagFirstIteration){
			if(received_pkts < local_npkts){
				intern_step = - intern_step;
			}
			flagFirstIteration = 0;
		}else{
			/* Conditions to end the test
				a) Intern step is negative, meaning the test started loosing packets, AND all packets where received in the last train
				b) Intern step is positive, meaning the test started receiveing all packets of the train, and some packets were lost
			*/
			if((intern_step < 0 && local_npkts == received_pkts) ||
					(intern_step > 0 && received_pkts < local_npkts) ||
					local_npkts >= limit){
				flagEndTest = 1;
			}
		}

		local_npkts = local_npkts + intern_step;	/* Increment the number of packets to the next train */
	}while(flagEndTest != 1 && local_npkts > 0);

	wrap_printf(sfp+1, "%-30s\n","##END BACK-TO-BACK TEST");
	wrap_printf(sfp+1, "%-30s%d\n","   ->Number of packets:", result);

	return result;
}

/**
This test function has two stages.
It will start with a train of packets at 110% maximum rate for the DUT measured in the throughput test.
After a certain time in that train, it will immediately drop the throughput rate to 55% of the original train rate
and measure the time it takes to a certain number of packets be received without errors.
\param iterations number of executions to take the average time to recover
\param pktlen size of the generated packets
\param max_rate result from the throughput test
\param time the time the 110% train of packets will last (microssecond)
\param pktseq number of packets received correctly stopping the test
\param timeout maximum time between a packet can be received after it was sent
\param sfp which SFP will transmit the test
\param verbose flag to print more info
\param payload_type indicates if the payload type is ID (System Recovery test - variable set as 0), LFSR (variable set as 1), all 0s (variable set as 2) or all 1s (variable set as 3)
\param mac_source indicates the mac source address
\param mac_target indicates the mac target address
\param ip_source indicates the ip source address
\param ip_target indicates the ip target address
\param mac_filter indicates if the receiver operates in promiscous mode or just receives the packets intended for its MAC as well if the loopback inverts or not the mac source and mac target fields
\return time of recovery in microsseconds
*/
double system_recovery(unsigned int iterations, unsigned int pktlen,
						double max_rate, unsigned int time, unsigned int pktseq,
						int timeout, char sfp, int verbose, unsigned int payload_type, unsigned long int mac_source,
						unsigned long int mac_target, unsigned int ip_source, unsigned int ip_target,
						unsigned int mac_filter){
	int idle_number;		/* Calculated number of idle cycles related to the throughput rate */
	int i;					/* Loop variable */
	double timeToRecover;	/* Time to recover at each iteration */
	double result;			/* Average time of the DUT to recover */

	wrap_printf(sfp+1, "%-30s\n","##Running System Recovery test");
	wrap_printf(sfp+1, "%-30s%d KB\n","##Packet length:", pktlen);
	wrap_printf(sfp+1, "%-30s%u\n","##Number of iterations:", iterations);
	wrap_printf(sfp+1, "%-30s%-10f Mb/s\n","##110%% rate:", max_rate);
	wrap_printf(sfp+1, "%-30s%-10d\n","##Idle number at 110%% rate:", idle_calc(max_rate, pktlen));
	wrap_printf(sfp+1, "%-30s%-10f Mb/s\n","##55%% rate:", max_rate*0.5);
	wrap_printf(sfp+1, "%-30s%-10d\n","##Idle number at 55%% rate:", idle_calc(max_rate*0.5, pktlen));
	wrap_printf(sfp+1, "%-30s%.4f s\n","##Overload time:", ((double)time/1000000));
	wrap_printf(sfp+1, "%-30s%d\n","##Packet sequence:", pktseq);
	wrap_printf(sfp+1, "%-30s%.4f ms\n","##Timeout:", ((double)timeout*6.4/1000));

	result = 0;
	/* Executions of the test cycles */
	for(i = 0; i < iterations; i++){

		idle_number = idle_calc(max_rate, pktlen);

		/* HARDWARE PRECONFIGURATION ##################################################### */
		reset(sfp);																	/* Reset state of tester Hardware */
		setSwitchRegs(sfp,mac_source,mac_target,ip_source,ip_target, mac_filter);	/* Set MACs and IPs for a given test */
		mpu_write_pci(sfp, PKT_SEQUENCE_REG, pktseq);								/* Set the hardware how many packets to accept correctly in sequence to finish the test */
		set_cycles(pktlen,sfp);														/* Write packet length */
		mpu_write_pci(sfp, TIMEOUT_REG, 50000);										/* Write timeout time amount */
		mpu_write_pci(sfp, IDLE_NUMBER_REG, idle_number);							/* Write the number of idles related to the maximum rate measured by the throughput test */
		mpu_write_pci(sfp, PAYLOAD_TYPE_REG, 0);									/* Payload type - packet ID */
		mpu_write_pci(sfp, TEST_CODE_REG, 2);										/* Write test code */
		/* END OF HARDWARE PRECONFIGURATION ############################################### */

		write_status(sfp, STATUS_REG, 1);										/* Indicates hardware to start the test */

		usleep(time);															/* Waits the given time */

		idle_number = idle_calc(max_rate*0.5, pktlen);							/* Calculates the 55% throughput rate related idle cycles */
		mpu_write_pci(sfp, IDLE_NUMBER_REG, idle_number);						/* Inform the hardware the number of idle cycles required to obtain a 55% rate */

		write_status(sfp, STATUS_REG, 2);										/* Inform hardware to switch to the new throughput rate */
		read_status(sfp,STATUS_BACK_REG);										/* Waits hardware signal of test end - a number of packets were received correctly */

		LATENCY_31_0    = mpu_read_pci(sfp, LATENCY_31_0_REG);					/* Reads the number of cycles it took to the DUT to recover - Low part */
		LATENCY_47_32   = mpu_read_pci(sfp, LATENCY_47_32_REG);					/* Reads the number of cycles it took to the DUT to recover - High part */
		timeToRecover	= (LATENCY_47_32*0x100000000 + LATENCY_31_0)*0.0064;	/* Join High and Low parts */

		if(verbose){
			wrap_printf(sfp+1, "##Iteration %u done\n", i+1);
			wrap_printf(sfp+1, "%-30s%f us\n","   ->Partial recovery time:", timeToRecover);
		}

		result += timeToRecover;	/* Sum all recovery times */
	}
	result = result / (double)iterations;	/* Average the recovery times */

	wrap_printf(sfp+1, "%-30s\n","##END SYSTEM RECOVERY TEST");
	wrap_printf(sfp+1, "%-30s%f us\n","   ->Recovery time:", result);

	return result;
}

/**
This test function has two stages.
It will start with a train of packets at 110% maximum rate for the DUT measured in the throughput test.
After a certain time in that train, it will immediately drop the throughput rate to 55% of the original train rate
and measure the time it takes to a certain number of packets be received without errors.
\param iterations number of executions to take the average time to recover
\param pktlen size of the generated packets
\param max_rate result from the throughput test
\param time the time the 110% train of packets will last (microssecond)
\param pktseq number of packets received correctly stopping the test
\param timeout maximum time between a packet can be received after it was sent
\param sfp which SFP will transmit the test
\param verbose flag to print more info
\param payload_type indicates if the payload type is ID (System Recovery test - variable set as 0), LFSR (variable set as 1), all 0s (variable set as 2) or all 1s (variable set as 3)
\param mac_source indicates the mac source address
\param mac_target indicates the mac target address
\param ip_source indicates the ip source address
\param ip_target indicates the ip target address
\param mac_filter indicates if the receiver operates in promiscous mode or just receives the packets intended for its MAC as well if the loopback inverts or not the mac source and mac target fields
\return time of recovery in microsseconds
*/
double reset_test(unsigned int iterations, unsigned int pktlen,
						double max_rate, unsigned int time, unsigned int pktseq,
						int timeout, char sfp, int verbose, unsigned int payload_type, unsigned long int mac_source,
						unsigned long int mac_target, unsigned int ip_source, unsigned int ip_target,
						unsigned int mac_filter){
	int idle_number, idle;		/* Calculated number of idle cycles related to the throughput rate */
	int i;					/* Loop variable */
	double timeToRecover;	/* Time to recover at each iteration */
	double result;			/* Average time of the DUT to recover */
	unsigned int packets_lost, packets_lost_31_0, packets_lost_63_32;
	wrap_printf(sfp+1, "%-30s\n","##Running Reset test");
	wrap_printf(sfp+1, "%-30s%d KB\n","##Packet length:", pktlen);
	//getchar();
	result = 0;

	idle_number = idle_calc(max_rate, pktlen);

	/* HARDWARE PRECONFIGURATION ##################################################### */
	reset(sfp);																	/* Reset state of tester Hardware */
	setSwitchRegs(sfp,mac_source,mac_target,ip_source,ip_target, mac_filter);	/* Set MACs and IPs for a given test */

	mpu_write_pci(sfp, PKT_NUMBER_31_0_REG, 4294967295);								/* Write number of packets to hardware - High part */
	mpu_write_pci(sfp, PKT_NUMBER_63_32_REG, 100000000);					/* Write number of packets to hardware - Low part */
	//mpu_write_pci(sfp, PKT_SEQUENCE_REG, pktseq);								/* Set the hardware how many packets to accept correctly in sequence to finish the test */
	set_cycles(pktlen,sfp);														/* Write packet length */
	mpu_write_pci(sfp, TIMEOUT_REG, 50000);										/* Write timeout time amount */
	mpu_write_pci(sfp, IDLE_NUMBER_REG, idle_number);							/* Write the number of idles related to the maximum rate measured by the throughput test */
	mpu_write_pci(sfp, PAYLOAD_TYPE_REG, 0);									/* Payload type - packet ID */
	mpu_write_pci(sfp, START_RESET_TEST, 1);
	mpu_write_pci(sfp, TEST_CODE_REG, 4);										/* Write test code */
	/* END OF HARDWARE PRECONFIGURATION ############################################### */

	write_status(sfp, STATUS_REG, 1);										/* Indicates hardware to start the test */

	//usleep(500);																/* Waits the given time */

	//idle_number = idle_calc(max_rate*0.5, pktlen);							/* Calculates the 55% throughput rate related idle cycles */
	//mpu_write_pci(sfp, IDLE_NUMBER_REG, idle_number);						/* Inform the hardware the number of idle cycles required to obtain a 55% rate */

	//printf("VO PRO READ_STATUS\n");
	read_status(sfp,STATUS_BACK_REG);										/* Waits hardware signal of test end - a number of packets were received correctly */
	//printf("SAIU READ_STATUS\n");
	//getchar();

	//usleep(500000000);

	packets_lost_31_0 = mpu_read_pci(sfp, PACKETS_LOST_31_0_REG);
	packets_lost_63_32 = mpu_read_pci(sfp, PACKETS_LOST_63_32_REG);
	packets_lost = packets_lost_63_32*0x100000000 + packets_lost_31_0;

	//#define PACKETS_LOST_31_0_REG 0xA0
	//#define PACKETS_LOST_63_32_REG 0xA4

	printf("ID Difference: %u\n",packets_lost);

	timeToRecover = packets_lost*0.0064*(idle_number+9);	

	//if(verbose){
	//	wrap_printf(sfp+1, "##Iteration %u done\n", i+1);
	//	wrap_printf(sfp+1, "%-30s%f us\n","   ->Partial recovery time:", timeToRecover);
	//}

	//result += timeToRecover;	/* Sum all recovery times */

	//result = result / (double)iterations;	/* Average the recovery times */

	wrap_printf(sfp+1, "%-30s\n","##END RESET TEST");
	wrap_printf(sfp+1, "%-30s%f us\n","   ->Reset time:", timeToRecover);

	return result;
}

/**
This function will configure the hardware to run a continuous train of data at a given rate.
Calculate the number of lost packets and BERT for this train.
This test also measure the rate at wich the packets were received
\param pktlen size of the generated packets
\param timing time of the train (microsseconds)
\param sfp which SFP will transmit the test
\param rate throughput rate at wich the train will happen
\param verbose flag to print more info
\param payload_type indicates if the payload type is ID (System Recovery test - variable set as 0), LFSR (variable set as 1), all 0s (variable set as 2) or all 1s (variable set as 3)
\param mac_source indicates the mac source address
\param mac_target indicates the mac target address
\param ip_source indicates the ip source address
\param ip_target indicates the ip target address
\param mac_filter indicates if the receiver operates in promiscous mode or just receives the packets intended for its MAC as well if the loopback inverts or not the mac source and mac target fields
\return result_time_throughput struct
*/
struct result_timed_throughput timed_throughput (unsigned int pktlen,
									double timing, char sfp, double rate,
									int verbose, unsigned int payload_type, unsigned long int mac_source,
									unsigned long int mac_target, unsigned int ip_source, unsigned int ip_target, unsigned int lfsr_polynomial,
									unsigned int mac_filter){

	double bert;							/* Bit Error RaTe */
	double throughput;						/* Calculated throughput (tries to get as close as possible to the argument rate) */
	int idle_number;						/* Number of idle cycles calculated to get the desired rate */
	unsigned int numberOfIdlesHigh;			/* Number of hardware cycles between each packet is received - High part */
	unsigned int numberOfIdlesLow;			/* Number of hardware cycles between each packet is received - Low part */
	unsigned int bitsWithErrorLow;			/* Number of bit-flips detected by the hardware - High part */
	unsigned int bitsWithErrorHigh;			/* Number of bit-flips detected by the hardware - Low part */
	unsigned long long bitsWithError;		/* Number of bit-flips detected by the hardware */
	unsigned long long received_pkts;		/* Number of packets received by the hardware */
	unsigned long long npkts;				/* Number of packets sent to achieve the desired time of train */
	unsigned long long idleCount;			/* Number of hardware cycles between each packet to achieve the desired throughput rate */
	struct result_timed_throughput result;	/* Timed throughput measurements */
	int random0, random32, random64, random96, random128, random160, random192, random224;				/* High and Low parts to the LFSR seed*/

	idle_number = idle_calc(rate, pktlen);	/* Calculate the number of hardware idle cycles to obtain the desired throughput rate */
	rate = rate_calc(idle_number, pktlen);	/* Obtainable rate close to the required */

	wrap_printf(sfp+1, "%-29s %d\n","##Idles:",idle_number);

	/* The packets with 1518 bytes are a special case because its size is not divisible by 64bits (the hardware outputs 64bits per cycle) */
	if(pktlen==1518){
		/* If the number of idles is configured to 1, the hardware will actually switch beteen 1 and 2 cycles, obtaining an average of 1.5 cycles of idle */
		if(idle_number == 1){
			/*
					npkts = 			timing
							----------------------------------
							 2.25 + ceil(pktlen/8) * (6.4*10^-9)
			*/
			npkts= (long long)((double)timing/(double)((1.0+1.25+(double)(ceil(pktlen/8.0)))*(double)(6.4/1000000000.0)));
		}else{
			/*
					npkts = 			        timing
							--------------------------------------------------
							 0.75 + idle_number + ceil(pktlen/8) * (6.4*10^-9)
			*/
			npkts= (long long)(timing/((1.0-0.25+idle_number+(double)ceil(pktlen/8.0))*(double)(6.4/1000000000.0)));
		}
	}else if(pktlen==0){
		/* If the packet lenght is 0, the test will run almost infinitely, around 30.000 years*/
		npkts=0xffffffffffffffff;
	}else{
		/* If the number of idles is configured to 1, the hardware will actually switch beteen 1 and 2 cycles, obtaining an average of 1.5 cycles of idle */
		if(idle_number == 1){
			/*
					npkts = 			timing
							----------------------------------
							 2.5 + ceil(pktlen/8) * (6+4*10^-9)
			*/
			npkts= (long long)((double)timing/(double)((1.0+1.5+(double)(pktlen/8.0))*(double)(6.4/1000000000.0)));
		}else{
			/*
					npkts = 			        timing
							-----------------------------------------------
							 1 + idle_number + ceil(pktlen/8) * (6+4*10^-9)
			*/
			npkts= (long long)( (double)timing/((1.0+(double)idle_number+(double)(pktlen/8.0))*(double)(6.4/1000000000.0)));
		}
	}

	wrap_printf(sfp+1, "%-30s\n","##Running Throughput test");
	wrap_printf(sfp+1, "%-30s%llu\n","##Number of packets:", npkts);
	wrap_printf(sfp+1, "%-30s%d Bytes\n","##Packet length:", pktlen);
	wrap_printf(sfp+1, "%-30s%f Mb/s\n","##Init rate:", rate);
	wrap_printf(sfp+1, "%-30s%.0f seconds\n","The test will run for ", timing);

	/* HARDWARE PRECONFIGURATION ##################################################### */
	reset(sfp);																		/* Reset state of tester Hardware */
	setSwitchRegs(sfp,mac_source,mac_target,ip_source,ip_target, mac_filter);		/* Set MACs and IPs for a given test */
	set_cycles(pktlen,sfp);															/* Write packet length */
	mpu_write_pci(sfp, TIMEOUT_REG, 50000);											/* Write timeout time amount */
	mpu_write_pci(sfp, IDLE_NUMBER_REG, idle_number);								/* Write the number of idles related the required throughput rate */
	mpu_write_pci(sfp, PAYLOAD_TYPE_REG, payload_type);								/* Payload type - BERT */
	//mpu_write_pci(sfp, PKT_NUMBER_31_0_REG, 400);									/* Number of packets necessary to achieve the time of train required - Low part */
	//mpu_write_pci(sfp, PKT_NUMBER_63_32_REG, 0);		/* Number of packets necessary to achieve the time of train required - High part */
	mpu_write_pci(sfp, PKT_NUMBER_31_0_REG, npkts);					/* Number of packets necessary to achieve the time of train required - Low part */
	mpu_write_pci(sfp, PKT_NUMBER_63_32_REG, (npkts >> 32));		/* Number of packets necessary to achieve the time of train required - High part */
	mpu_write_pci(sfp, TEST_CODE_REG, 0);							/* Write test code */
	/* END OF HARDWARE PRECONFIGURATION ############################################### */
	srand (time(NULL));
	
	random224	= rand();											/* Generates a random seed based on the system clock */											
	random192	= rand();											/* Generates a random seed based on the system clock */
	random160	= rand();											/* Generates a random seed based on the system clock */
	random128	= rand();											/* Generates a random seed based on the system clock */
	random96	= rand();											/* Generates a random seed based on the system clock */
	random64	= rand();											/* Generates a random seed based on the system clock */
	random32	= rand();											/* Generates a random seed based on the system clock */
	random0		= rand();											/* Generates a random seed based on the system clock */

	mpu_write_pci(sfp, LFSR_SEED_255_224_REG, 	random224);			/* Writes to the hardware the seed */
	mpu_write_pci(sfp, LFSR_SEED_223_192_REG, 	random192);			/* Writes to the hardware the seed */
	mpu_write_pci(sfp, LFSR_SEED_191_160_REG, 	random160);			/* Writes to the hardware the seed */
	mpu_write_pci(sfp, LFSR_SEED_159_128_REG, 	random128);			/* Writes to the hardware the seed */
	mpu_write_pci(sfp, LFSR_SEED_127_96_REG, 	random96);			/* Writes to the hardware the seed */
	mpu_write_pci(sfp, LFSR_SEED_95_64_REG, 	random64);			/* Writes to the hardware the seed */
	mpu_write_pci(sfp, LFSR_SEED_63_32_REG, 	random32);			/* Writes to the hardware the seed */
	mpu_write_pci(sfp, LFSR_SEED_31_0_REG, 		random0);				/* Writes to the hardware the seed */
	mpu_write_pci(sfp, LFSR_POLYNOMIAL_REG, lfsr_polynomial); 		/* Choses the LFSR polynomial */

	/*Starts test*/
	write_status(sfp, STATUS_REG, 1);	/* Indicates hardware to start the test */

	read_status(sfp, STATUS_BACK_REG);	/* Waits hardware signal of test end */

	numberOfIdlesHigh = mpu_read_pci(sfp, TIME_RECEIVER_63_32_REG);	/* Effective number of idles between packets received - High part */
	numberOfIdlesLow = mpu_read_pci(sfp, TIME_RECEIVER_31_0_REG);	/* Effective number of idles between packets received - Low part */
	idleCount = numberOfIdlesHigh*0x100000000 + numberOfIdlesLow;	/* Join low and high parts */

	throughput = rateFromIdle(idleCount, pktlen, npkts); /* Calculates the effective rate using the hardware information - number of idles */

	PKT_RX_31_0 	= mpu_read_pci(sfp, PKT_RX_31_0_REG);	/* Number of packets correctly received - Low part */
	PKT_RX_63_32 	= mpu_read_pci(sfp, PKT_RX_63_32_REG);	/* Number of packets correctly received - High part */
	received_pkts = PKT_RX_63_32*0x100000000 + PKT_RX_31_0;	/* Join low and high parts */

	bitsWithErrorLow = mpu_read_pci(sfp, CONT_ERROR_31_0_REG);			/* Number of bit-flips during the test - Low part */
	bitsWithErrorHigh = mpu_read_pci(sfp, CONT_ERROR_63_32_REG);		/* Number of bit-flips during the test - High part */
	bitsWithError = bitsWithErrorHigh*0x100000000 + bitsWithErrorLow;	/* Join low and high parts */

	bert = bitsWithError / (double)(received_pkts*pktlen*8.0) * 100.0;	/* Calculates the bit error rate */

	/* Save results in the return struct */
	result.npkts = npkts;
	result.received_pkts = received_pkts;
	result.achieved_rate = received_pkts/timing;
	result.wished_rate = npkts/timing;
	result.lost_packets = npkts - received_pkts;
	result.pktlen = pktlen;
	result.throughput = throughput;
	result.bert = bert;

	wrap_printf(sfp+1, "%-30s\n","##END THROUGHPUT TEST");

	wrap_printf(sfp+1, "%-30s%llu\n","##Packets Received:",received_pkts);
	wrap_printf(sfp+1, "%-30s%llu\n","##Packets Sent:",npkts);

	wrap_printf(sfp+1, "%-30s%llu\n","##Number of bits with error:", bitsWithError);
	wrap_printf(sfp+1, "%-30s%llu\n","##Lost Packets:",npkts - received_pkts);
	wrap_printf(sfp+1, "%-30s%f Mb/s\n","##Real Throughput:",throughput);
	wrap_printf(sfp+1, "%-30s%f \%\n","##Bit Error Rate:", bert);

	return result;
}

/**
This function will configure a given SFP port to simply send back any packet it receives,
inverting the sender and receiver fields.
It will remain in loopback mode until it is reset.
\param sfp which SFP will be put in loopback mode
\param mac_source indicates the mac source address
\param mac_target indicates the mac target address
\param ip_source indicates the ip source address
\param ip_target indicates the ip target address
\param mac_filter indicates if the receiver operates in promiscous mode or just receives the packets intended for its MAC as well if the loopback inverts or not the mac source and mac target fields
*/
void loopback (char sfp,  unsigned long int mac_source, unsigned long int mac_target, unsigned int ip_source, unsigned int ip_target, unsigned int mac_filter){
	reset(sfp);

	/* HARDWARE PRECONFIGURATION ##################################################### */
	setSwitchRegs(sfp,mac_source,mac_target,ip_source,ip_target, mac_filter);	/* Inform hardware wich SFP to put in loopback mode */
	mpu_write_pci(sfp, TEST_CODE_REG, 3);										/* Write the test code to hardware */
	/* ############################################################################### */

	write_status(sfp, STATUS_REG, 1);	/* Starts the loopback mode */

	wrap_printf(sfp+1, "%-30s\n","##Running loopback mode");
}

/**
This test calls the throughput test to detect the maximum throughput rate from de DUT using a small number of packets.
It then execute a timed throughput test for a given time at the throughput measured.
If it loses more than the allowed number of packets, it decreases the throughput rate and execute the timed throughput
rate until it loses no more than the allowed number of packets.
\param pktlen size of the generated packets
\param top_rate
\param step is the step value to be used in the internal call to the throughput() function
\param timeout maximum waiting time for a response
\param sfp which SFP will transmit the test
\param verbose flag to print more info
\param timing time for the execution of the timed_throughput() function called internally
\param loss_rate acceptable loss rate (%)
\param payload_type indicates if the payload type is ID (System Recovery test - variable set as 0), LFSR (variable set as 1), all 0s (variable set as 2) or all 1s (variable set as 3)
\param mac_source indicates the mac source address
\param mac_target indicates the mac target address
\param ip_source indicates the ip source address
\param ip_target indicates the ip target address
\param mac_filter indicates if the receiver operates in promiscous mode or just receives the packets intended for its MAC as well if the loopback inverts or not the mac source and mac target fields
\return maximum rate obtained without losing more than the allowed number of packets in the long train
*/
double training(unsigned int pktlen, double top_rate,
				unsigned int step, unsigned int timeout,
				char sfp, int verbose, double timing, double loss_rate,
				unsigned int payload_type, unsigned long int mac_source, unsigned long int mac_target, unsigned int ip_source, unsigned int ip_target, unsigned int lfsr_polynomial,
				unsigned int mac_filter) {

	struct result_throughput throughput_ans;				/* Result from the throughput test calls */
	struct result_timed_throughput timed_throughput_ans;	/* Result from the timed throughput test calls */
	unsigned long long allowedLostPackets;					/* Number of packets allowed to lose for the given loss-rate */
	unsigned long long npkts;								/* Number of packets used in the throughput test */
	double result;											/* Achieved rate for long trains */
	int idle_number;										/* Number of hardware idle cycles */


	idle_number = idle_calc(top_rate, pktlen);				/* Number of hardware idles for the top media rate */

	/*
			npkts = 			          3
					-----------------------------------------------
					 1 + idle_number + ceil(pktlen/8) * (6+4*10^-9)
	*/
	npkts = 3.0/((1.0+(double)idle_number+((double)pktlen/8.0))*(6.4/1000000000.0)); 				/* Number of packets to the throughput test use trains of arround 3 seconds of duration */
	throughput_ans = throughput(pktlen, npkts, top_rate, step, timeout, sfp, verbose, loss_rate, payload_type, mac_source, mac_target, ip_source, ip_target, mac_filter);	/* Executes the throughput test */

	/* Verify the throughput rate measured by the troughput test for longer trains.
	   If it detects losses bigger than the allowed loss rate, the rate is decreased and verified again.
	*/
	do {
		timed_throughput_ans = timed_throughput(pktlen,	timing,	sfp, throughput_ans.rate, verbose, payload_type, mac_source, mac_target, ip_source, ip_target, lfsr_polynomial, mac_filter);	/* Executes the timed-throughput for long train of packets */

		allowedLostPackets = timed_throughput_ans.npkts - (timed_throughput_ans.npkts * (loss_rate/100.0));	/* Calculates the number of packets allowed to be lost */
		idle_number++;											/* Decrease the rate by one idle */
		throughput_ans.rate = rate_calc(idle_number, pktlen);	/* Recalculates the throughput rate */
	}while(timed_throughput_ans.received_pkts < allowedLostPackets);

	idle_number--;												/* Compesate for the while loop */
	throughput_ans.rate = rate_calc(idle_number, pktlen);		/* Compesate for the while loop */
	result = throughput_ans.rate;								/* Get the throughput achieved rate */

	if(verbose){
		wrap_printf(sfp+1, "%-30s\n","##END TRAINING TEST");
		wrap_printf(sfp+1, "%-30s%f Mbit/s\n","->Throughput rate:", result);
		wrap_printf(sfp+1, "%-30s%d\n","->Number of packets:",timed_throughput_ans.npkts);
		wrap_printf(sfp+1, "%-30s%d\n","->Received packets:",timed_throughput_ans.received_pkts);
		wrap_printf(sfp+1, "%-30s%f\n","->Loss rate:",loss_rate);
		wrap_printf(sfp+1, "%-35s %d\n","->Idle number for this rate:", idle_number);
	}

	wrap_printf(sfp+1, "%-30s\n","##END training");

	return result;
}

/**
One thread is a handler for each SFP.
Each thread will handle the arguments given to the software.
\param void pointer to an arguments struct
*/
void *thread_func(void *arguments){
	struct 			arguments *args;								/* Command-line arguments */
	struct 			result_throughput throughput_ans[8];			/* One throughput result for each packet size */
	struct			result_timed_throughput timed_throughput_ans;	/* Result from the timed-throughput test */
	double			training_ans;									/* Result from the training test */
	struct			result_loss_rate *loss_rate_ans;				/* A dynamic list for the loss-rate test result */
	double 			latency_ans;									/* Result from the latency test */
	double 			system_recovery_ans;							/* Result from the system-recovery test */
	double 			reset_ans;										/* Result from the system-recovery test */
	double 			max_throughput;									/* Maximum throughput value obtained by the throughput test */
	double			min_throughput;									/* Minimum throughput value obtained by the throughput test */
	double 			max_loss_rate;									/* Maximum loss-rate obtained */
	double			max_rate;										/* 110% rate used in the system-recovery test */
	double			bert;											/* Bit Error RaTe */
	char 			string[256];									/* Auxiliar string */
	char			gnup_script[256];								/* Path to the generated Gnuplot script */
	char			out_file[256];									/* Output data in the RFC2544 format */
	char			directory[256];									/* Directory with all output files */
	char 			sfp;											/* SFP number for this thread */
	int 			i, j;											/* Loop variables */
	int				cont_zero_loss_rates;							/* Counter of consecutive 0 values in the loss-rate result */
	int				ans;											/* Pooling variable */
	int				idle_number;									/* Number of hardware idle cycles between packet transmissions */
	int 			pktLength;										/* Packet length defined for the tests */
	unsigned int 	back_to_back_ans;								/* Result from the back-to-back test */
	unsigned int	link_status;									/* Link status for the channel */
	unsigned int 	pktlen;											/* TODO */
	unsigned int 	bitsWithErrorLow;								/* Number of bit-flips detected by the hardware - High part */
 	unsigned int 	bitsWithErrorHigh;								/* Number of bit-flips detected by the hardware - Low part */
	FILE 			*f_data;										/* File descriptor for the raw data output */
	FILE 			*f_data_csv;									/* File descriptor for the CSV data output */
	FILE 			*f_script;										/* File descriptor for the Gnuplot script */
	FILE 			*f_output;										/* File descriptor for the text formatted output */

	unsigned long long 	received_pkts;								/* Number of packets received by the hardware */
	unsigned long long 	bitsWithError;								/* Number of bit-flips detected by the hardware */


	args = (struct arguments*) arguments;							/* Cast the input argument to the arguments struct */
	sfp = SFPS[args->tid];											/* Get the sfp handled by this thread */

	if(args->read_status_flag){
		sprintf(string,"sfp%d_temp_result.csv",sfp+1);
		f_data_csv = fopen(string, "w");
		/* Failed to open file */
		if (f_data_csv == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

 		pktlen = mpu_read_pci(sfp, PACKET_LENTGH_REG);

 		PKT_RX_31_0 	= mpu_read_pci(sfp, PKT_RX_31_0_REG);	/* Number of packets correctly received - Low part */
 		PKT_RX_63_32 	= mpu_read_pci(sfp, PKT_RX_63_32_REG);	/* Number of packets correctly received - High part */
 		received_pkts = PKT_RX_63_32*0x100000000 + PKT_RX_31_0;	/* Join low and high parts */

 		bitsWithErrorLow = mpu_read_pci(sfp, CONT_ERROR_31_0_REG);			/* Number of bit-flips during the test - Low part */
 		bitsWithErrorHigh = mpu_read_pci(sfp, CONT_ERROR_63_32_REG);		/* Number of bit-flips during the test - High part */
 		bitsWithError = bitsWithErrorHigh*0x100000000 + bitsWithErrorLow;	/* Join low and high parts */

 		bert = bitsWithError / (double)(received_pkts*pktlen*8.0) * 100.0;	/* Calculates the bit error rate */

 		link_status = mpu_read_pci(sfp, LINK_STATUS);

 		fprintf(f_data_csv, "\"%u\",\"%u\",\"%llu\",\"%u\",\"%u\",\"%llu\",\"%u\"\n", pktlen, 0, received_pkts, 0, 0, bitsWithError, link_status);

 		fclose(f_data_csv);	/* Close output files */

		pthread_exit(NULL);
	}

	ans = mpu_read_pci(sfp, LINK_STATUS);							/* Verify if the SFP channel is correclty connected */
	if (ans != 1) {
		wrap_printf(sfp+1, " Link status is %d - NOT CONNECTED\n", ans);
		wrap_printf(sfp+1, "%-30s%d\n"," FINISHING THREAD", args->tid);
		wrap_printf(sfp+1, "%-30s%d\n"," SFP", sfp+1);
		pthread_exit(NULL);
	}

	wrap_printf(sfp+1, "%-30s\n","# PACKET INFO");
	wrap_printf(sfp+1, "%-30s%s\n"," Packet type:", "UDP");
	wrap_printf(sfp+1, "%-30s%s\n"," Message:", "echo");
	wrap_printf(sfp+1, "%-30s%d\n"," Thread:", args->tid);
	wrap_printf(sfp+1, "%-30s%d\n"," SFP:", sfp+1);

	sprintf(out_file, "./sfp%d_%s", sfp+1, args->out_file);	/* Set the name of the output file */
	sprintf(directory, "sfp%d_data", sfp+1);				/* Set the name of the data file */
	sprintf(gnup_script, "sfp%d_gnup_script", sfp+1);		/* Set the name of the Gnuplot script file */
	sprintf(string, "mkdir -p %s", directory);				/* Compose a command to crate an output directory */
	system(string);											/* Execute the command */
	sprintf(string, "rm -f %s", out_file);					/* Clean any old output file */
	system(string);											/* Execute the command */

	/* The software will execute the throughput test if it is selected to run or if any command depedent on it is selected */
	if(args->rfc2544_flag || args->throughput_test_flag || args->latency_test_flag ||
				 args->back_to_back_test_flag || args->system_recovery_test_flag || args->reset_test_flag){

		printf("THROUGHPUT\n");
		f_script = fopen(gnup_script, "w");					/* Open Gnuplot script file */
		/* Failed to open file */
		if (f_script == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		sprintf(string, "./%s/throughput.dat", directory);	/* Compose the output data file directory for the throughput test */
		f_data = fopen(string, "w");						/* Open the output data file */
		/* Failed to open file */
		if (f_data == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		fprintf(f_data, "#RFC2544\n#THROUGHPUT RESULT (Mb/s):\n");	/* Write header of the Throughput section in the output file */
		fprintf(f_script, "%s\n", "set term dumb\n");				/* Start composing the script file. This line will make Gnuplot plot in text */

		sprintf(string, "./%s/throughput.csv", directory);	/* Compose the Comma Separated Values (CSV) file path */
		f_data_csv = fopen(string, "w");					/* Open the CSV file */
		/* Failed to open file */
		if (f_data_csv == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		max_throughput = -1;			/* Any valid throughput rate will be greater than -1 */
		min_throughput = 100000;		/* Any valid throughput rate will be smaller than 100000 Mb/s for the current tecnologies*/

		/* Loop to execute throughput for all the selected packet sizes */
		for(i = 0; i < 8; i++){
			/* Only execute to selected packet size */
			if(args->ps_flags[i] == 1){
				pktLength = indexlenDecoder(i);		/* Decode the packet lenght value */
				throughput_ans[i] = throughput(pktLength, args->npkts, args->top_rate,
												args->throughput_step, args->timeout,
												sfp, args->verbose_flag, args->acceptable_error,
												args->payload_type,	args->mac_source,
												args->mac_target, args->ip_source,
												args->ip_target, args->mac_filter);	/* Run the throughput test */
				/* Get the highest throughput rate obtained */
				if(throughput_ans[i].rate > max_throughput){
					max_throughput = throughput_ans[i].rate;
				}
				/* Get the lowest throughput rate obtained */
				if(throughput_ans[i].rate < min_throughput){
					min_throughput = throughput_ans[i].rate;
				}
				fprintf(f_data, "%-30d%-30f\n", PACKET_SIZES[i], throughput_ans[i].rate);		/* print raw data to the output file */
				fprintf(f_data_csv, "\"%d\",\"%f\"\n", PACKET_SIZES[i], throughput_ans[i].rate);/* print data in CSV format */
			}
		}


		fprintf(f_script, "set yrange[%f:%f]\n", min_throughput*0.9, max_throughput*1.1);		/* Set the Y range of the plot according to the values detected */
		fprintf(f_script, "plot \"./%s/throughput.dat\" using 1:2 title\"Throughput (Mb/s)\" with linespoints\n", directory);	/* Last line of the Gnuplot script */
		fclose(f_script);		/* Close output files */
		fclose(f_data);			/* Close output files */
		fclose(f_data_csv);		/* Close output files */

		sprintf(string, "gnuplot %s >> %s", gnup_script, out_file);	/* Compose the execution call to Gnuplot add the generated plot to the output file */
		system(string);												/* Execute the Gnuplot call */
	}

	/* Latency test is required */
	if(args->rfc2544_flag || args->latency_test_flag){
		f_output = fopen(out_file, "a");				/* Open output file directly to write the table-formatted result */
		/* Failed to open the file */
		if (f_output == NULL){
				wrap_printf(sfp+1, "Error opening file!\n");
		}

		sprintf(string, "./%s/latency.csv", directory);	/* Compose the path to the CSV output file */
		f_data_csv = fopen(string, "w");				/* Open the CSV file */
		/* Failed to open the file */
		if (f_data_csv == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		/* Output table header */
		fprintf(f_output, "\nLATENCY TEST\n");
		fprintf(f_output, "------------------------------------------------------------------------------\n");
		fprintf(f_output, "|%-15s|%-20s|%-18s|%-20s|\n", "Frame Size(KB)", "Rate(Mb/s)", "Media Type(Mb/s)", "Latency(us)");

		/* The latency test will try to execute for every packet size */
		for(i = 0; i < 8; i++){
			/* Only the selected packet sizes will be run */
			if(args->ps_flags[i] == 1){
				pktLength = indexlenDecoder(i);		/* Decode the packet lenght value */

				latency_ans = latency(pktLength, throughput_ans[i], args->latency_wait,
												args->timeout, sfp, args->verbose_flag, args->payload_type, args->mac_source, args->mac_target,
							  					args->ip_source, args->ip_target, args->mac_filter);	/* Execution of the latency test */
				fprintf(f_output, "|%-15d|%-20f|%-18d|%-20f|\n", pktLength,
									throughput_ans[i].rate, args->top_rate, latency_ans);	/* Write result to the output file in a table-style */
				fprintf(f_data_csv, "\"%d\",\"%f\",\"%d\",\"%f\"\n", pktLength,
								throughput_ans[i].rate, args->top_rate, latency_ans);		/* Write result to the CSV file */
			}
		}

		fprintf(f_output, "------------------------------------------------------------------------------\n"); /* Table footer */

		fclose(f_output);	/* Close output files */
		fclose(f_data_csv);	/* Close output files */
	}

	/* Loss-rate test is required */
	if(args->rfc2544_flag || args->loss_rate_test_flag){
		f_script = fopen(gnup_script, "w");					/* Open Gnuplot script file */
		if (f_script == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		fprintf(f_script, "%s\n", "set term dumb\n");		/* Start composing the script file. This line will make Gnuplot plot in text */

		cont_zero_loss_rates = 0;							/* Initialize the number of consecutive 0 loss rate values */

		/* Try to execute the loss-rate test for every packet size */
		for(i = 0; i < 8; i++){
			/* Only the selected packet sizes will be run */
			if(args->ps_flags[i] == 1){
				pktLength = indexlenDecoder(i);		/* Decode the packet lenght value */
				sprintf(string, "./%s/loss_rate%d.dat", directory, pktLength);	/* Compose the loss-rate output raw file for a packet length */
				f_data = fopen(string, "w");									/* Open the raw file */
				/* Failed to open the file */
				if (f_data == NULL){
					wrap_printf(sfp+1, "Error opening file!\n");
				}

				sprintf(string, "./%s/loss_rate%d.csv", directory, pktLength);	/* Compose the loss-rate output CSV file for a packet length */
				f_data_csv = fopen(string, "w");								/* Open the output CSV file */
				if (f_data_csv == NULL){
					wrap_printf(sfp+1, "Error opening file!\n");
				}

				fprintf(f_data, "#RFC2544\n#LOSS RATE FOR packets OF %dkb (us):\n", pktLength);	/* Header for the raw output file */

				loss_rate_ans = loss_rate(pktLength, args->npkts, args->timeout,
											args->top_rate, args->loss_rate_step,
											sfp, args->verbose_flag, args->acceptable_error, args->payload_type, args->mac_source,
							  				args->mac_target, args->ip_source, args->ip_target, args->mac_filter);	/* Execute the loss-rate test */

				pktLength = indexlenDecoder(i);									/* Decode the packet length */
				max_loss_rate = 0;												/* Initialize the maximum loss-rate value */

				/* Loop throught the loss-rate results */
				for(j = 1; j < loss_rate_ans[0].rate; j++){
					/* Detect results with 0% loss-rate */
					if(loss_rate_ans[j].loss_rate <= 0){
						cont_zero_loss_rates++;												/* Increment the number of consecutive zeros */
						fprintf(f_data, "%-30f%-30f\n", loss_rate_ans[j].rate, 0.0);		/* Write data to the raw file */
						fprintf(f_data_csv, "\"%f\",\"%f\"\n", loss_rate_ans[j].rate, 0.0);	/* Write data to the CSV file */
						/* Condition of end of test. All next values are invalid */
						if(cont_zero_loss_rates == 2){
							break;
						}
					} else {	/* Not-zero loss-rate value */
						cont_zero_loss_rates = 0;										/* Reset the consecutive-zero counter */
						fprintf(f_data, "%-30f%-30f\n", loss_rate_ans[j].rate,
														loss_rate_ans[j].loss_rate);	/* Write the raw data to the file */
						fprintf(f_data_csv, "\"%f\",\"%f\"\n", loss_rate_ans[j].rate,
															loss_rate_ans[j].loss_rate);/* Write the CSV data to the file */
					}
					/* Update maximum value */
					if(loss_rate_ans[j].loss_rate > max_loss_rate){
						max_loss_rate = loss_rate_ans[j].loss_rate;
					}
				}

				free(loss_rate_ans);	/* Dealocate the dynamic array */
				fclose(f_data);			/* Close file */
				fclose(f_data_csv);		/* Close file */

				fprintf(f_script, "set yrange[0:100]\n");								/* Loss-rate values will be between 0 and 100% */
				fprintf(f_script, "plot \"./%s/loss_rate%d.dat\" using 1:2 title\
				 				\"Loss rate for %d kb (%%)\" with linespoints\n",
													directory, pktLength, pktLength);	/* Gnuplot command information */
				/* Whether DUT did not lose any packet */
				if(max_loss_rate > 0){
					wrap_printf(sfp+1, "No loss occured for this test!\n");
				}
			}
		}

		fclose(f_script);	/* Close Gnuplot script file */

		sprintf(string, "gnuplot %s >> %s", gnup_script, out_file);	/* Compose the bash command to execute the Gnuplot script and save the results in the output file */
		system(string);												/* Execute Gnuplot script */
	}

	/* Back-to-back test is required */
	if(args->rfc2544_flag || args->back_to_back_test_flag){
		f_output = fopen(out_file, "a");					/* Open output file */
		/* Fail to open file */
		if (f_output == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		sprintf(string, "./%s/back_to_back.csv", directory);/* Compose the CSV file path */
		f_data_csv = fopen(string, "w");					/* Open CSV file */
		/* Fail to open file */
		if (f_data_csv == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		fprintf(f_output, "\nBACK-TO-BACK FRAMES TEST\n");													/* Header to output file */
		fprintf(f_output, "->Values greater than %d packets were NOT tested\n", args->back_to_back_limit);	/* Header to output file */
		fprintf(f_output, "--------------------------------------\n");										/* Write table header */
		fprintf(f_output, "|%-15s|%-20s|\n", "Frame Size(KB)", "Maximum Packet Count");						/* Write table header */

		/* Try to execute back-to-back test for each packet size */
		for(i = 0; i < 8; i++){
			/* Only selected packet sizes will run */
			if(args->ps_flags[i]==1){
				pktLength=indexlenDecoder(i);											/* Decode the packet length */
				back_to_back_ans = back_to_back(pktLength, args->back_to_back_initrate,
								   throughput_ans[i], args->back_to_back_step,
								   args->timeout, args->back_to_back_limit, sfp,
								   args->verbose_flag, args->payload_type, args->mac_source,
							  	   args->mac_target, args->ip_source,
							  	   args->ip_target, args->mac_filter);									/* Execute the back-to-back test */
				fprintf(f_output, "|%-15d|%-20d|\n", pktLength, back_to_back_ans);		/* Write the next table value to the raw file */
				fprintf(f_data_csv, "\"%d\",\"%d\"\n", pktLength, back_to_back_ans);	/* Write the next table value to the CSV file */
			}
		}

		fprintf(f_output, "--------------------------------------\n");	/* Write table footer */

		fclose(f_output);		/* Close output files */
		fclose(f_data_csv);		/* Close output files */
	}

	/* If the system-recovery test is required */
	if(args->rfc2544_flag || args->system_recovery_test_flag){
		f_output = fopen(out_file, "a");						/* Open output raw file */
		/* Failed to open file */
		if (f_output == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		sprintf(string, "./%s/system_recovery.csv", directory);	/* Compose the path to the CSV file */
		f_data_csv = fopen(string, "w");						/* Open output CSV file */
		/* Failed to open file */
		if (f_data_csv == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		/* Table header */
		fprintf(f_output, "\nSYSTEM RECOVERY TEST\n");
		fprintf(f_output, "--------------------------------------------------------------------------------\n");
		fprintf(f_output, "|%-15s|%-20s|%-20s|%-20s|\n", "Frame Size(KB)", "110%%Rate(Mb/s)", "55%%Rate(Mb/s)", "Recovery Time");

		/* Try to execute the system-recovery test for all packet sizes */
		for(i = 0; i < 8; i++){
			/* Run test if packet size is selected */
			if(args->ps_flags[i]==1){
				pktLength = indexlenDecoder(i);									/* Decode the packet length */
				idle_number = idle_calc(throughput_ans[i].rate*1.1, pktLength);	/* Calculate the throughput rate of 110% of the detected */
				/* Make sure the 110% throughput rate does not exeed 10000 Gb/s */
				while(rate_calc(idle_number, pktLength) > args->top_rate){
					idle_number = idle_number + 1;
				}
				max_rate = rate_calc(idle_number, pktLength);					/* Calculate the real 110% throughput rate */

				system_recovery_ans = system_recovery(args->system_recovery_iterations,
									  pktLength, max_rate, args->system_recovery_overload_time,
									  args->system_recovery_pktseq, args->timeout, sfp, args->verbose_flag,
									  args->payload_type, args->mac_source,
							  		  args->mac_target, args->ip_source,
							  		  args->ip_target, args->mac_filter);	/* Execute the system-recovery test */

				/* Write to output raw and CSV files */
				fprintf(f_output, "|%-15d|%-20f|%-20f|%-20f|\n", pktLength, (throughput_ans[i].rate*1.1), (max_rate*0.55), system_recovery_ans);
				fprintf(f_data_csv, "\"%d\",\"%f\",\"%f\",\"%f\"|\n", pktLength, (throughput_ans[i].rate*1.1), (max_rate*0.55), system_recovery_ans);
			}
		}

		fprintf(f_output, "--------------------------------------------------------------------------------\n");	/* Table footer */

		fclose(f_output);	/* Close output files */
		fclose(f_data_csv);	/* Close output files */
	}

	/* If the reset test is required */
	if(args->rfc2544_flag || args->reset_test_flag){
		printf("TO AQUI!!!!\n");
		f_output = fopen(out_file, "a");						/* Open output raw file */
		/* Failed to open file */
		if (f_output == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		sprintf(string, "./%s/reset.csv", directory);	/* Compose the path to the CSV file */
		f_data_csv = fopen(string, "w");						/* Open output CSV file */
		/* Failed to open file */
		if (f_data_csv == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		/* Table header */
		fprintf(f_output, "\nRESET TEST\n");
		fprintf(f_output, "--------------------------------------------------------------------------------\n");
		fprintf(f_output, "|%-15s|%-20s|%-20s|%-20s|\n", "Frame Size(KB)", "110%%Rate(Mb/s)", "55%%Rate(Mb/s)", "Recovery Time");

		/* Try to execute the system-recovery test for all packet sizes */
		//for(i = 0; i < 8; i++){
			/* Run test if packet size is selected */
			if(args->ps_flags[0]==1){
				pktLength = 64;													/* Decode the packet length */
				idle_number = idle_calc(throughput_ans[i].rate*1.1, pktLength);	/* Calculate the throughput rate of 110% of the detected */
				/* Make sure the 110% throughput rate does not exeed 10000 Gb/s */
				while(rate_calc(idle_number, pktLength) > args->top_rate){
					idle_number = idle_number + 1;
				}
				max_rate = rate_calc(idle_number, pktLength);					/* Calculate the real 110% throughput rate */

				reset_ans = reset_test(args->system_recovery_iterations,
									  pktLength, max_rate, args->system_recovery_overload_time,
									  args->system_recovery_pktseq, args->timeout, sfp, args->verbose_flag,
									  args->payload_type, args->mac_source,
							  		  args->mac_target, args->ip_source,
							  		  args->ip_target, args->mac_filter);	/* Execute the system-recovery test */

				/* Write to output raw and CSV files */
				fprintf(f_output, "|%-15d|%-20f|%-20f|%-20f|\n", pktLength, (throughput_ans[i].rate*1.1), (max_rate*0.55), reset_ans);
			 	fprintf(f_data_csv, "\"%d\",\"%f\",\"%f\",\"%f\"|\n", pktLength, (throughput_ans[i].rate*1.1), (max_rate*0.55), reset_ans);
			}
		//}

		fprintf(f_output, "--------------------------------------------------------------------------------\n");	/* Table footer */

		fclose(f_output);	/* Close output files */
		fclose(f_data_csv);	/* Close output files */
	}

	/* If the system-recovery test is required */
	if(args->timed_throughput_test_flag){
		printf("TO AQUI!!!!\n");
		f_output = fopen(out_file, "a");	/* Open the raw output file */
		/* Failed to open file */
		if (f_output == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		sprintf(string, "./%s/timed_throughput.csv", directory);	/* Compose the path to the CSV file */
		f_data_csv = fopen(string, "w");							/* Open the CSV file */
		/* Failed to open file */
		if (f_data_csv == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		/* Try to execute the time_throghput test for all packet sizes */
		for(i = 0; i < 8; i++){
			/* If the packet size selected is a RFC and no a jumbo frame*/
			if(args->ps_flags[i]==1 && args->pktlen == 0){
				pktLength=indexlenDecoder(i);	/* Decode the packet size */
				timed_throughput_ans = timed_throughput(pktLength, args->timing,
										sfp, args->top_rate, args->verbose_flag, args->payload_type, args->mac_source,
							  			args->mac_target, args->ip_source, args->ip_target, args->lfsr_polynomial, args->mac_filter);	/* Execute the timed-throughput test */

				/* Write the table HEADER */
				fprintf(f_output, "\nTIMED THROUGHPUT  TEST\n");
				fprintf(f_output, "------------------------------------------------------------------------------------------------------------------------------\n");
				fprintf(f_output, "|%-15s|%-20s|%-22s|%-20s|%-20s|%-20s|\n", "Frame Size(bytes)", "Sent Packets", "Received Packets", "Lost Packets", "Throughput (Mb/s)", "BERT");

				/* Write the values detected to the raw and CSV files */
				fprintf(f_output, "|%-17u|%-20llu|%-22llu|%-20llu|%-20f|%-20f|\n", timed_throughput_ans.pktlen, timed_throughput_ans.npkts, timed_throughput_ans.received_pkts, timed_throughput_ans.lost_packets, timed_throughput_ans.throughput, timed_throughput_ans.bert );
				fprintf(f_data_csv, "\"%u\",\"%llu\",\"%llu\",\"%llu\",\"%f\",\"%f\"\n", timed_throughput_ans.pktlen, timed_throughput_ans.npkts, timed_throughput_ans.received_pkts, timed_throughput_ans.lost_packets, timed_throughput_ans.throughput, timed_throughput_ans.bert );

				/* Table footer */
				fprintf(f_output, "------------------------------------------------------------------------------------------------------------------------------\n");
			}
			/* If the packet size selected is a jumbo frame*/
			else if (args->pktlen != 0){
				timed_throughput_ans = timed_throughput(args->pktlen, args->timing,
										sfp, args->top_rate, args->verbose_flag, args->payload_type, args->mac_source,
							  			args->mac_target, args->ip_source, args->ip_target, args->lfsr_polynomial, args->mac_filter);	/* Execute the timed-throughput test */

				/* Write the table HEADER */
				fprintf(f_output, "\nTIMED THROUGHPUT  TEST\n");
				fprintf(f_output, "------------------------------------------------------------------------------------------------------------------------------\n");
				fprintf(f_output, "|%-15s|%-20s|%-22s|%-20s|%-20s|%-20s|\n", "Frame Size(bytes)", "Sent Packets", "Received Packets", "Lost Packets", "Throughput (Mb/s)", "BERT");

				/* Write the values detected to the raw and CSV files */
				fprintf(f_output, "|%-17u|%-20llu|%-22llu|%-20llu|%-20f|%-20f|\n", timed_throughput_ans.pktlen, timed_throughput_ans.npkts, timed_throughput_ans.received_pkts, timed_throughput_ans.lost_packets, timed_throughput_ans.throughput, timed_throughput_ans.bert );
				fprintf(f_data_csv, "\"%u\",\"%llu\",\"%llu\",\"%llu\",\"%f\",\"%f\"\n", timed_throughput_ans.pktlen, timed_throughput_ans.npkts, timed_throughput_ans.received_pkts, timed_throughput_ans.lost_packets, timed_throughput_ans.throughput, timed_throughput_ans.bert );

				/* Table footer */
				fprintf(f_output, "------------------------------------------------------------------------------------------------------------------------------\n");
				break;
			}
		}

		fclose(f_output);	/* Close output file */
		fclose(f_data_csv);	/* Close output file */

	}

	/* Loopback execution */
	if(args->loopback_test_flag){
		f_output = fopen(out_file, "a");	/* Open raw output file */
		/* Failed to open file */
		if (f_output == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		/* Set loopback mode to the channel */
		loopback(sfp, args->mac_source, args->mac_target, args->ip_source, args->ip_target, args->mac_filter);

		/* Write info to the output file */
		fprintf(f_output, "\nLOOPBACK  TEST\n");
		fprintf(f_output, "CHANNEL %d IN LOOPBACK MODE\n",sfp+1);

		fclose(f_output);	/* Close output file */
	}

	/* Training test selected */
	if(args->training_flag){
		f_output = fopen(out_file, "a");				/* Open raw output file */
		/* Failed to open file */
		if (f_output == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		sprintf(string, "./%s/training.csv", directory);	/* Compose the path to the CSV output file */
		f_data_csv = fopen(string, "w");					/* Open the CSV file */
		/* Failed to open file */
		if (f_data_csv == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		/* Raw output table header */
		fprintf(f_output, "\nTraining TEST\n");
		fprintf(f_output, "-----------------------------------------------------------\n");
		fprintf(f_output, "|%-15s|%-20s|%-20s|\n", "Frame Size(KB)", "Achieved Rate(Mb/s)", "Loss Rate(%%)");

		/* Try to execute the test for all packet sizes */
		for(i = 0; i < 8; i++){
			/* If the packet size is selected */
			if(args->ps_flags[i] == 1){
				pktLength = indexlenDecoder(i);						/* Decode the packet size */
				training_ans = training(pktLength, args->top_rate, args->throughput_step,
													args->timeout, sfp, args->verbose_flag,
													args->timing, args->acceptable_error, args->payload_type, args->mac_source,
							  						args->mac_target, args->ip_source, args->ip_target, args->lfsr_polynomial, args->mac_filter);	/* Execute the training test */

				/* Write training results to the raw and CSV files */
				fprintf(f_output, "|%-15d|%-20f|%-20f|\n", pktLength,
								training_ans, args->acceptable_error);
				fprintf(f_data_csv, "\"%d\",\"%f\",\"%f\"\n", pktLength,
								training_ans, args->acceptable_error);
			}
		}

		/* Table footer */
		fprintf(f_output, "-----------------------------------------------------------\n");

		fclose(f_output);	/* Close output files */
		fclose(f_data_csv);	/* Close output files */
	}

	if(args->soft_reset_flag){
		f_output = fopen(out_file, "a");	/* Open raw output file */
		/* Failed to open file */
		if (f_output == NULL){
			wrap_printf(sfp+1, "Error opening file!\n");
		}

		/*  */
		if(args->ps_flags[i] == 1){
			reset(sfp);
			wrap_printf(sfp+1, "%-30s\n","##Soft reset");

			/* Write info to the output file */
			fprintf(f_output, "\nSOFT RESET\n");
			fprintf(f_output, "CHANNEL %d RESET\n",sfp+1);

			fclose(f_output);	/* Close output file */

		}
	}

	wrap_printf(sfp+1, "%-30s%d\n","#FINISHING THREAD", args->tid);
	wrap_printf(sfp+1, "%-30s%d\n"," SFP", sfp+1);

	plot_results(sfp+1, out_file);	/* Show the plots in the terminal */

	pthread_exit(NULL);
}

int main(int argc,char *argv[]){
	int i;										/* Loop variable */
	int fileDescriptor;							/* File descriptor to the PCIe slot */
	struct arguments args[NUMBER_OF_SFPS];		/* Array of arguments. Each argument struct is given to a thread */
	pthread_t pthreadPointer[NUMBER_OF_SFPS];	/* Pthread identifier */
	char *filename;								/* File name to the file descriptor */
	off_t target = 0;							/* Comment... */

	initialize();								/* Initialize semaphores */

	args[0] = process_arguments(argc, argv);	/* Process command line arguments */

	filename = args[0].resource;				/* Resource file */
	/* Error opening descriptor file */
	if((fileDescriptor = open(filename, O_RDWR | O_SYNC)) == -1){
		PRINT_ERROR;
	}

	map_base = mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fileDescriptor, target & ~MAP_MASK);	/* Map hardware registers */
    if(map_base == (void *) -1){
    	PRINT_ERROR;
    }

    /* Start all the threads */
	for(i = 0; i < NUMBER_OF_SFPS; i++){
		/* Only selected SFPs */
		if(args[0].sfps_flags[i]){
			/* Each thread has to have a copy of the arguments */
			if(i != 0){
				args[i] = args[0];
			}
			args[i].tid = i;	/* Thread ID */
			pthread_create(&pthreadPointer[i], NULL, &thread_func, (void *)&args[i]);	/* Run threads */
		}
	}

	for(i = 0; i < NUMBER_OF_SFPS; i++){
		if(args[0].sfps_flags[i])
			pthread_join(pthreadPointer[i], NULL);
	}
}
