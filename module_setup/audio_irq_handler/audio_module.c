#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/spinlock.h>
#include <asm/io.h>
#include "../address_map_arm.h"
#include "../interrupt_ID.h"
MODULE_LICENSE("GPL");
MODULE_AUTHOR("YAY_GOD");
MODULE_DESCRIPTION("audio bish");

spinlock_t lock;

void * LW_virtual;
volatile int *AUDIO_ptr;
volatile int *LED_ptr;    // virtual address for the LEDR port

// Externs that share data between modules that include address_map_arm.h
extern volatile int buffer_index;
extern volatile int left_buffer[BUF_SIZE];
extern volatile int right_buffer[BUF_SIZE];

irq_handler_t audio_handler(int irq, void *dev_id, struct pt_regs *regs)
{
	int fifospace;
	unsigned long flags;
	spin_lock_irqsave(&lock, flags);
	if (*(AUDIO_ptr) & 0x100)
	{
		buffer_index = 0;
		fifospace = *(AUDIO_ptr + 1);
		while (buffer_index < BUF_SIZE)
		{
			*(LED_ptr) = 0x1;
			left_buffer[buffer_index] = *(AUDIO_ptr + 2);	
			right_buffer[buffer_index] = *(AUDIO_ptr + 3);		
			++buffer_index;
			if (buffer_index == BUF_SIZE)
			{
				*(LED_ptr) = 0x0;
				*(AUDIO_ptr) = 0x0;
			}
			fifospace = *(AUDIO_ptr + 1);	// read the audio port fifospace register
		}
	}
	if (*(AUDIO_ptr) & 0x200)
	{
		buffer_index = 0;
		fifospace = *(AUDIO_ptr + 1);
		while (buffer_index < BUF_SIZE)
		{
			*(LED_ptr) = 0x2;
			*(AUDIO_ptr + 2) = left_buffer[buffer_index];
			*(AUDIO_ptr + 3) = right_buffer[buffer_index];		
			++buffer_index;
			if (buffer_index == BUF_SIZE)
			{
				*(LED_ptr) = 0x0;
				*(AUDIO_ptr) = 0x0;
			}
			fifospace = *(AUDIO_ptr + 1);	// read the audio port fifospace register
		}
	}
	*(AUDIO_ptr) = 0x0;
	// *(LED_ptr) = 0x0;
	spin_unlock_irqrestore(&lock, flags);
	return (irq_handler_t) IRQ_HANDLED;
}

static int __init initialize(void)
{
	int value;
	LW_virtual = ioremap_nocache (LW_BRIDGE_BASE, LW_BRIDGE_SPAN);
	AUDIO_ptr = LW_virtual + AUDIO_BASE;
	LED_ptr = LW_virtual + LEDR_BASE;  // init virtual address for LEDR port
	*(AUDIO_ptr) = 0;
	buffer_index = 0;
	spin_lock_init(&lock);
	value = request_irq(AUDIO_IRQ, (irq_handler_t)audio_handler,
               IRQF_SHARED, "audio_module",
               (void *)(audio_handler));
	return value;
}

static void __exit cleanup(void)
{
	*(AUDIO_ptr) = 0;
	
	iounmap(LW_virtual);
	free_irq(AUDIO_IRQ, (void*) audio_handler);
}

module_init(initialize);
module_exit(cleanup);


