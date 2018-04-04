#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <asm/io.h>

volatile int left_buffer[500000];
volatile int right_buffer[500000];
volatile int buffer_index;

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Altera University Program");
MODULE_DESCRIPTION("DE1SoC Pushbutton Interrupt Handler");

void * lwbridgebase;

irq_handler_t button_handler(int irq, void *dev_id, struct pt_regs *regs)
{
    // Increment the value on the LEDs
    printk("handling button interrupt!\n"); 
    iowrite32(ioread32(lwbridgebase)+1,lwbridgebase);
    // Clear the edgecapture register (clears current interrupt)
    int key_val;
    key_val = ioread32(lwbridgebase+0x5c);
    iowrite32(0xf,lwbridgebase+0x5c);
    if (key_val == 0x1)
    {
        printk("Enabling Recording..\n"); 
        buffer_index = 0;
        iowrite32(0x4, lwbridgebase+0x3040);
        iowrite32(0x1, lwbridgebase+0x3040);
    }
    else if (key_val == 0x2)
    {
        printk("Enabling Playback..\n"); 
        buffer_index = 0;
        iowrite32(0x8, lwbridgebase+0x3040);
        iowrite32(0x2, lwbridgebase+0x3040);
	}
    return (irq_handler_t) IRQ_HANDLED;
}

irq_handler_t audio_handler(int irq, void *dev_id, struct pt_regs *regs)
{
	int fifospace;
        printk("Handling Audio!!!");
	if (ioread32(lwbridgebase+0x3040) & 0x100)						// check bit RI of the Control register
	{
		if (buffer_index == 0)
			iowrite32(0x1,lwbridgebase);					// turn on LEDR[0]

		fifospace = ioread32(lwbridgebase+0x3040+1);	 			// read the audio port fifospace register
		// store data until the the audio-in FIFO is empty or the buffer is full
		while ( (fifospace & 0x000000FF) && (buffer_index < 500000) )
		{
			left_buffer[buffer_index] = ioread32(lwbridgebase+0x3040+2); 		
			right_buffer[buffer_index] = ioread32(lwbridgebase+0x3040+3); 		
			++buffer_index;

			if (buffer_index == 500000)
			{
				// done recording
				iowrite32(0x0,lwbridgebase);				// turn off LEDR
				iowrite32(0x0,lwbridgebase+0x3040); 					// turn off interrupts
			}
			fifospace = ioread32(lwbridgebase+0x3040+1);	// read the audio port fifospace register
		}
	}
	if (ioread32(lwbridgebase+0x3040) & 0x200)						// check bit WI of the Control register
	{
		if (buffer_index == 0)
			iowrite32(0x2,lwbridgebase);					// turn on LEDR_1
		fifospace = ioread32(lwbridgebase+0x3040+1);	 			// read the audio port fifospace register
		// output data until the buffer is empty or the audio-out FIFO is full
		while ( (fifospace & 0x00FF0000) && (buffer_index < 500000) )
		{
			iowrite32(left_buffer[buffer_index], lwbridgebase+0x3040+2);
			iowrite32(right_buffer[buffer_index], lwbridgebase+0x3040+3);
			++buffer_index;
	
			if (buffer_index == 500000)
			{
				// done playback
				iowrite32(0x0,lwbridgebase);				// turn off LEDR
				iowrite32(0x0,lwbridgebase+0x3040); 					// turn off interrupts
			}
			fifospace = ioread32(lwbridgebase+0x3040+1);	// read the audio port fifospace register
		}
	}
    
    return (irq_handler_t) IRQ_HANDLED;
}

static int __init intitialize_handlers(void)
{
    // get the virtual addr that maps to 0xff200000
    lwbridgebase = ioremap_nocache(0xff200000, 0x200000);
    // Set LEDs to 0x2AA (the leftmost LED will turn on)
    iowrite32(0x2AA,lwbridgebase);
    // Clear the PIO edgecapture register (clear any pending interrupt)
    iowrite32(0xf,lwbridgebase+0x5c);
    iowrite32(0x0,lwbridgebase+0x3040);
    // Enable IRQ generation for the 4 buttons 
    iowrite32(0xf,lwbridgebase+0x58);
    printk("Initializing!\n");    
    // Register the interrupt handler.
    return  ((request_irq(73, (irq_handler_t)button_handler,
            IRQF_SHARED, "pushbutton_irq_handler",
            (void *)(button_handler))) == 
            (request_irq(78, (irq_handler_t)audio_handler,
            IRQF_SHARED, "pushbutton_irq_handler",
            (void *)(audio_handler))));
}

static void __exit cleanup_handlers(void)
{
    // Turn off LEDs and de-register irq handler
    iowrite32(0x0,lwbridgebase);
    free_irq(73, (void*) button_handler);
    free_irq(78, (void*) audio_handler);
}

module_init(intitialize_handlers);
module_exit(cleanup_handlers);
