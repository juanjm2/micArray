#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <inttypes.h>
#include "./include/hwlib.h"
#include "./include/socal.h"
#include "./include/hps.h"
#include "./include/hps_0.h"
#include "./include/alt_types.h"

//#define BUF_SIZE 380000							// Buffer size ~5 seconds
#define HW_REGS_BASE ( ALT_STM_OFST )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )
#define DDR_BASE ( 0x00000000 )
#define DDR_SPAN ( 0x3FFFFFFF )
#define BUF_SIZE 0x000AFC80
#define SAMPLING_RATE 48000
#define START_ADDRESS 0x01000000
//48000 sampling rate
int main() {
	void *virtual_base;
	void *mem_base;
	int fd;
	int choice = -1;
	float rec_length = 0;
	int d2 = 0;
	alt_u32 *h2p_lw_audio_addr;

	if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
		printf( "ERROR: could not open \"/dev/mem\"...\n" );
		return( 1 );
	}

	virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_REGS_BASE );

	if( virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	mem_base =  mmap( NULL, DDR_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, DDR_BASE );

	if( virtual_base == MAP_FAILED ) {
		printf( "ERROR: DDR mmap()  failed...\n" );
		close( fd );
		return( 1 );
	}

	h2p_lw_audio_addr = ((alt_u32) virtual_base) + ( ( alt_u32  )( ALT_LWFPGASLVS_OFST + MIC_SYSTEM_0_BASE ) & ( alt_u32)( HW_REGS_MASK ) );
	
	TOP: alt_write_word(h2p_lw_audio_addr + 1, START_ADDRESS);
	alt_write_word(h2p_lw_audio_addr + 2, BUF_SIZE);
	alt_write_word(h2p_lw_audio_addr, 0x0);

	rec_length = BUF_SIZE / SAMPLING_RATE;

	printf("Audio set to record for %f seconds\n\n", rec_length);

	alt_u32* ddr3 = (alt_u32) mem_base + START_ADDRESS;
	alt_u32* ddr3_2 = (alt_u32) mem_base + START_ADDRESS + (BUF_SIZE * 4);
	alt_u32* ddr3_3 = (alt_u32) mem_base + START_ADDRESS + ((BUF_SIZE * 4) * 2);
	alt_u32* ddr3_4 = (alt_u32) mem_base + START_ADDRESS + ((BUF_SIZE * 4) * 3);
	alt_u32* ddr3_5 = (alt_u32) mem_base + START_ADDRESS + ((BUF_SIZE * 4) * 4);

	//printf("DDR3 TEST: %lX\n", alt_read_word(ddr3));
	printf("ENTER 1 TO START RECORDING: ");
	scanf("%d", &d2);
	alt_write_word(h2p_lw_audio_addr, 0x1);
	// int d2;
	// scanf("Press enter to continue: %d", &d2);

	while (alt_read_word(h2p_lw_audio_addr + 2) == 0x0){}
	alt_write_word(h2p_lw_audio_addr, 0x0);
	// printf("After DMA write: %lX\n", alt_read_word(ddr3));
	// printf("After DMA write: %lX\n", alt_read_word(ddr3 + 0x0001));
	// printf("After DMA write: %lX\n", alt_read_word(ddr3 + 0x0002));
	// printf("After DMA write: %lX\n", alt_read_word(ddr3 + 0x0003));

	// alt_write_word(h2p_lw_audio_addr, 0x00000000);

	while (1)
	{
		printf("Enter 2 to save data\nEnter 1 to Re-record (Overwrites data)\nEnter 0 to exit without saving data\n");
		printf("INPUT: ");
		scanf("%d", &choice);
		if (choice == 2)
		{
			FILE * f;
			unsigned int i;
			uint16_t left, right;
			uint32_t fir_left, fir_right;
			f = fopen("OUT.dat", "w");
			if (f == NULL)
			{
				printf("ERROR: OUT.dat not found.\n");
			}

			// Writing to the file

			for(i = 0x00000000; i < BUF_SIZE; i = i + 0x00000001)
			{
				left = (alt_read_word(ddr3 + i) >> 16) & 0x0000FFFF;
				right = alt_read_word(ddr3 + i) & 0x0000FFFF;
				fprintf(f, "%hX	%hX\n", left, right);
			}

			fclose(f);	// Closing file

			FILE * f2;

			f2 = fopen("OUT2.dat", "w");
			if (f2 == NULL)
			{
				printf("ERROR: OUT.dat not found.\n");
			}

			// Writing to the file

			for(i = 0x00000000; i < BUF_SIZE; i = i + 0x00000001)
			{
				left = (alt_read_word(ddr3_2 + i) >> 16) & 0x0000FFFF;
				right = alt_read_word(ddr3_2 + i) & 0x0000FFFF;
				fprintf(f2, "%hX %hX\n", left, right);
			}

			fclose(f2);	// Closing file

			FILE * f3;

			f3 = fopen("OUT3.dat", "w");
			if (f3 == NULL)
			{
				printf("ERROR: OUT.dat not found.\n");
			}

			// Writing to the file

			for(i = 0x00000000; i < BUF_SIZE; i = i + 0x00000001)
			{
				fir_left = alt_read_word(ddr3_3 + i) & 0xFFFFFFFF;
				fprintf(f3, "%d\n", fir_left);
			}

			fclose(f3);	// Closing file

			FILE * f4;

			f4 = fopen("OUT4.dat", "w");
			if (f4 == NULL)
			{
				printf("ERROR: OUT.dat not found.\n");
			}

			// Writing to the file

			for(i = 0x00000000; i < BUF_SIZE; i = i + 0x00000001)
			{
				fir_right = alt_read_word(ddr3_4 + i) & 0xFFFFFFFF;
				fprintf(f4, "%d\n", fir_right);
			}

			fclose(f4);	// Closing file

			FILE * f5;

			f5 = fopen("OUT5.dat", "w");
			if (f5 == NULL)
			{
				printf("ERROR: OUT.dat not found.\n");
			}

			// Writing to the file

			for(i = 0x00000000; i < BUF_SIZE; i = i + 0x00000001)
			{
				left = (alt_read_word(ddr3_5 + i) >> 16) & 0x0000FFFF;
				right = alt_read_word(ddr3_5 + i) & 0x0000FFFF;
				fprintf(f5, "%hX %hX\n", left, right);
			}

			fclose(f5);	// Closing file

			printf("Wrote to files successfully\n");
			alt_write_word(h2p_lw_audio_addr + 3, 0x1);
			alt_write_word(h2p_lw_audio_addr + 3, 0x0);
			break;
		}
		else if (choice == 1){
			alt_write_word(h2p_lw_audio_addr + 3, 0x1);
			alt_write_word(h2p_lw_audio_addr + 3, 0x0);
			goto TOP;
			break;
		}
		else{
			break;
		}
	}

	if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
		printf( "ERROR: munmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	if( munmap( mem_base, DDR_SPAN ) != 0 ) {
		printf( "ERROR: munmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	close( fd );

	return( 0 );
}
