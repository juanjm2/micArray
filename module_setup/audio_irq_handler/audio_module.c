#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <asm/io.h>
#include "../address_map_arm.h"
#include "../interrupt_ID.h"
MODULE_LICENSE("GPL");
MODULE_AUTHOR("YAY_GOD");
MODULE_DESCRIPTION("audio bish");

#define BUF_SIZE 500000			// about 10 seconds of buffer (@ 48K samples/sec)
#define BUF_THRESHOLD 96		// 75% of 128 word buffer

void * LW_virtual;
volatile int *AUDIO_ptr;

volatile int i;
volatile int buffer_index;
volatile int left_buffer[BUF_SIZE];
volatile int right_buffer[BUF_SIZE];

irq_handler_t audio_handler(int irq, void *dev_id, struct pt_regs *regs)
{
//	printk(KERN_ALERT "Servicing Audio..\n");
	int fifospace;
	if (*(AUDIO_ptr) & 0x100)
	{
//		printk(KERN_ALERT "Inside recording loop!\n");
		fifospace = *(AUDIO_ptr + 1);
		while ((fifospace & 0x000000FF) && (buffer_index < BUF_SIZE))
		{
			left_buffer[buffer_index] = *(AUDIO_ptr + 2);	
			right_buffer[buffer_index] = *(AUDIO_ptr + 3);		
			++buffer_index;
			if (buffer_index == BUF_SIZE)
			{
				*(AUDIO_ptr) = 0x0;
			}
			fifospace = *(AUDIO_ptr + 1);	// read the audio port fifospace register
		}
	}
	if (*(AUDIO_ptr) & 0x200)
	{
//		printk(KERN_ALERT "Inside playback loop!\n");
		fifospace = *(AUDIO_ptr + 1);
		while ((fifospace & 0x000000FF) && (buffer_index < BUF_SIZE))
		{
			*(AUDIO_ptr + 2) = left_buffer[i];
			*(AUDIO_ptr + 3) = right_buffer[i];		
			++i;
			if (i == BUF_SIZE)
			{
				*(AUDIO_ptr) = 0x0;
			}
			fifospace = *(AUDIO_ptr + 1);	// read the audio port fifospace register
		}
	}
	return (irq_handler_t) IRQ_HANDLED;
}

static int __init initialize(void)
{
	int value;
//	printk(KERN_ALERT "Initializing audio!\n");

	LW_virtual = ioremap_nocache (LW_BRIDGE_BASE, LW_BRIDGE_SPAN);
	AUDIO_ptr = LW_virtual + AUDIO_BASE;

	*(AUDIO_ptr) = 0;
	buffer_index = 0;
	i = 0;
	value = request_irq(AUDIO_IRQ, (irq_handler_t)audio_handler,
               IRQF_SHARED, "audio_module",
               (void *)(audio_handler));
	return value;
}

static void __exit cleanup(void)
{
//	printk(KERN_ALERT "Terminating Audio!\n");
	*(AUDIO_ptr) = 0;
	iounmap(LW_virtual);
	free_irq(AUDIO_IRQ, (void*) audio_handler);

}

module_init(initialize);
module_exit(cleanup);


