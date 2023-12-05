#include "tty.h"
#include "dio.h"
#include "pio.h"

void kernel_main(void) {
	terminal_initialize(vga_entry_color(VGA_COLOR_LIGHT_GREEN, VGA_COLOR_BLACK));

	printf("\n");
}