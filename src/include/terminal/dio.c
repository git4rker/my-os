#include <stdarg.h>
#include "string.h"
#include "tty.h"

void printf(const char *format, ...) {
    va_list arg;
    va_start(arg, format);

    char c;
    char buf[512];
    int counter = 0;

    memset(buf, 0, 512);

    while((c = *format++) != '\0') {
        if (c == '%') {
            c = *format++;

            switch (c) {
                case 'd':
                case 'x':
                    int32_t n = va_arg(arg, int32_t);
                    char *n_conv = { 'e' }; // to remove the "may be used uninitialized" warning
                    itoa(n, n_conv, c == 'd' ? 10 : 16);
                    
                    while (*n_conv != '\0')
                        buf[counter++] = *n_conv++;

                    break;
                case 's':
                    char *s = va_arg(arg, char*);

                    while (*s != '\0')
                        buf[counter++] = *s++;

                    break;
            }

            continue;
        }

        buf[counter++] = c;
    }

    buf[counter] = '\0';

    terminal_writestring(buf);

    va_end(arg);
}