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
#define BUF_SIZE 0x00173400
//48000 sampling rate
int main() {
	void *virtual_base;
	void *mem_base;
	int fd;
	int choice = -1;
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
	
	alt_write_word(h2p_lw_audio_addr, 0x00000000);
	alt_write_word(h2p_lw_audio_addr + 1, 0x02000000);
	alt_write_word(h2p_lw_audio_addr + 2, 0x00173400);

	printf("Audio set up to record for 7.92s\n");

	alt_u32* ddr3 = (alt_u32) mem_base + 0x02000000;

	printf("DDR3 TEST: %lX\n", alt_read_word(ddr3));

	alt_write_word(h2p_lw_audio_addr, 0x00000001);

	while (alt_read_word(h2p_lw_audio_addr + 2) == 0x0){}

	printf("After DMA write: %lX\n", alt_read_word(ddr3));
	printf("After DMA write: %lX\n", alt_read_word(ddr3 + 0x0001));
	printf("After DMA write: %lX\n", alt_read_word(ddr3 + 0x0002));
	printf("After DMA write: %lX\n", alt_read_word(ddr3 + 0x0003));

	alt_write_word(h2p_lw_audio_addr, 0x00000000);

	while (1)
	{
		printf("Enter 1 to save data\nEnter 0 to exit without saving data\n");
		printf("INPUT: ");
		scanf("%d", &choice);
		if (choice == 1)
		{
			FILE * f;
			unsigned int i;
			uint16_t left, right;
			f = fopen("OUT.dat", "w");
			if (f == NULL)
			{
				printf("ERROR: OUT.dat not found.\n");
			}

			// Writing to the file

			for(i = 0x00000001; i < 0x00173400; i = i + 0x00000001)
			{
				left = (alt_read_word(ddr3 + i) >> 16) & 0x0000FFFF;
				right = alt_read_word(ddr3 + i) & 0x0000FFFF;
				fprintf(f, "%hX	%hX\n", left, right);
			}

			fclose(f);	// Closing file
			printf("Wrote to OUT.dat file successfully\n");
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
