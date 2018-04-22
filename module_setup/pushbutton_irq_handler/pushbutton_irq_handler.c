#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <asm/io.h>
#include "../address_map_arm.h"
#include "../interrupt_ID.h"

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Altera University Program");
MODULE_DESCRIPTION("DE1SoC Pushbutton Interrupt Handler");

void * LW_virtual;         // Lightweight bridge base address
volatile int *LEDR_ptr;    // virtual address for the LEDR port
volatile int *KEY_ptr;     // virtual address for the KEY port
volatile int *AUDIO_ptr;

irq_handler_t irq_handler(int irq, void *dev_id, struct pt_regs *regs)
{
  if (*(KEY_ptr + 3) == 0x1)
  {
    // clear audio-in FIFO  
    *(AUDIO_ptr) = 0x4;
    // turn off clear, and enable audio-in interrupts
    *(AUDIO_ptr) = 0x1;
  }
  else if (*(KEY_ptr + 3) == 0x2)
  {
    // clear audio-out FIFO
    *(AUDIO_ptr) = 0x8;
    // turn off clear, and enable audio-out interrupts
    *(AUDIO_ptr) = 0x2;
  }
  *(KEY_ptr + 3) = 0xF; // Clear the edgecapture register (clears current interrupt)
  return (irq_handler_t) IRQ_HANDLED;
}

static int __init initialize_pushbutton_handler(void)
{
  int value;
  // generate a virtual address for the FPGA lightweight bridge
  LW_virtual = ioremap_nocache (LW_BRIDGE_BASE, LW_BRIDGE_SPAN);

  LEDR_ptr = LW_virtual + LEDR_BASE;  // init virtual address for LEDR port
  *LEDR_ptr = 0x200;                  // turn on the leftmost light

  AUDIO_ptr = LW_virtual + AUDIO_BASE;
  KEY_ptr = LW_virtual + KEY_BASE;    // init virtual address for KEY port
  // Clear the PIO edgecapture register (clear any pending interrupt)
  *(KEY_ptr + 3) = 0xF; 
  // Enable IRQ generation for the 4 buttons
  *(KEY_ptr + 2) = 0xF; 

  // Register the interrupt handler.
  value = request_irq (KEYS_IRQ, (irq_handler_t) irq_handler, IRQF_SHARED, 
    "pushbutton_irq_handler", (void *) (irq_handler));
  return value;
}

static void __exit cleanup_pushbutton_handler(void)
{
  *LEDR_ptr = 0; // Turn off LEDs and de-register irq handler
  iounmap(LW_virtual);
  free_irq (KEYS_IRQ, (void*) irq_handler);
}

module_init(initialize_pushbutton_handler);
module_exit(cleanup_pushbutton_handler);

