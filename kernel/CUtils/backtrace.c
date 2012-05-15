#include "backtrace.h"
#include "stdio.h"

#define BACKTRACE_SIZE 10
static void *backtrace_buffer[BACKTRACE_SIZE];

void backtrace_print(void)
{
        int i;

        backtrace(backtrace_buffer, BACKTRACE_SIZE);
        for (i = 0; i < BACKTRACE_SIZE; ++i) {
                printf("%3d: 0x%08x\n", i backtrace_buffer[i]);
        }
}

