/*****************************************************************************\
| File Name: RFC2544_defines.h					                 			|
| Project: PD1461 - netFPGA SUME						             		|
| Author: Lucas Pugens Fernandes, Thiago Mânica Monteiro,					|
|		Walter Lau, Leonardo Juracy e Felipe Lazzarotto						|
| Purpose: Run RFC2544 tests over a network using a netFPGA SUME board		|
| Version: 2.1										                       	|
| Date: Junho, 2016									                 		|
/*****************************************************************************/

#define WRITE 0x57 //W em hexa
#define READ 0x52 //R em hexa

#define STATUS_REG 0x00
#define TEST_CODE_REG 0x04
#define PACKET_LENTGH_REG 0x08
#define IDLE_NUMBER_REG 0x0C
#define PKT_NUMBER_31_0_REG 0x10
#define PKT_NUMBER_63_32_REG 0x14
#define PAYLOAD_TYPE_REG 0x18 // payload type, 0 if packet id, 1 if bert
#define MAC_SOURCE_31_0_REG 0x1C
#define MAC_SOURCE_47_32_REG 0x20
#define MAC_DESTINATION_31_0_REG 0x24
#define MAC_DESTINATION_47_32_REG 0x28
#define IP_SOURCE_REG 0x2C
#define IP_DESTINATION_REG 0x30
#define TIMEOUT_REG 0x34
#define PKT_SEQUENCE_REG 0x38
#define PKT_RX_31_0_REG 0x3C
#define PKT_RX_63_32_REG 0x40
#define PKT_TX_31_0_REG 0x44
#define PKT_TX_63_32_REG 0x48
#define LATENCY_31_0_REG 0x4C
#define LATENCY_47_32_REG 0x50
#define TIME_RECEIVER_31_0_REG 0x54 //idle conunt
#define TIME_RECEIVER_63_32_REG 0x58 //idle conunt
#define LINK_STATUS 0x5C

#define STATUS_BACK_REG 0x60 //novo registrador inserido

#define MAC_SOURCE_RX_31_0_REG 0x64
#define MAC_SOURCE_RX_47_32_REG 0x68
#define MAC_DESTINATION_RX_31_0_REG 0x6C
#define MAC_DESTINATION_RX_47_32_REG 0x70
#define IP_SOURCE_RX_31_0_REG 0x74
#define IP_DESTINATION_RX_31_0_REG 0x78

#define CONT_ERROR_31_0_REG 0x7C
#define CONT_ERROR_63_32_REG 0x80

#define LFSR_SEED_31_0_REG 0x84
#define LFSR_SEED_63_32_REG 0x88
#define LFSR_POLYNOMIAL_REG 0x8C

#define CYCLES_REG 0x90
#define LAST_BITS_REG 0x94

#define LOOPBACK_FILTER_REG 0x98
#define START_RESET_TEST 0x9C
#define PACKETS_LOST_31_0_REG 0xA0
#define PACKETS_LOST_63_32_REG 0xA4
//#define LAST_ID 0xA8
//#define CURRENT_ID 0xAC

#define SLEEP_RW_UTIME 10000 //n foi modificado

unsigned int STATUS;
unsigned int TEST_CODE;
unsigned int PACKET_LENTGH;
unsigned int IDLE_NUMBER;
unsigned int PKT_NUMBER_31_0;
unsigned int PKT_NUMBER_63_32;
unsigned int TIMESTAMP_POS;
unsigned int MAC_SOURCE_31_0;
unsigned int MAC_SOURCE_47_32;
unsigned int MAC_DESTINATION_31_0;
unsigned int MAC_DESTINATION_47_32;
unsigned int IP_SOURCE;
unsigned int IP_DESTINATION;
unsigned int TIMEOUT;
unsigned int PKT_SEQUENCE;
unsigned int PKT_RX_31_0;
unsigned int PKT_RX_63_32;
unsigned int PKT_TX_31_0;
unsigned int PKT_TX_63_32;
unsigned int LATENCY_31_0;
unsigned int LATENCY_47_32;
unsigned int TIME_RECEIVER_31_0;
unsigned int TIME_RECEIVER_63_32;
unsigned int STATUS_BACK;
unsigned int PAYLOAD_TYPE;
unsigned int MAC_SOURCE_RX_31_0;
unsigned int MAC_SOURCE_RX_47_32;
unsigned int MAC_DESTINATION_RX_31_0;
unsigned int MAC_DESTINATION_RX_47_32;
unsigned int IP_SOURCE_RX;
unsigned int IP_DESTINATION_RX;

#define NUMBER_OF_SIZES 8
const int PACKET_SIZES[] = {64, 128, 256, 512, 768, 1024, 1280, 1518};

#define NUMBER_OF_SFPS 4
const int SFPS[] = {0x00, 0x01, 0x02, 0x03};

#define PRINT_ERROR \
do { \
    fprintf(stderr, "Error at line %d, file %s (%d) [%s]\n", \
    __LINE__, __FILE__, errno, strerror(errno)); exit(1); \
} while(0)

#define MAP_SIZE 4096UL
// #define MAP_SIZE 8*1024
#define MAP_MASK (MAP_SIZE - 1)

