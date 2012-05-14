#
# backtrace.s
#
# Copyright (C) 2012 Simple Object Kernel project
# by Gaëtan Morin
#
# x86 (32bit) implementation of backtrace.
#
#
# ---
#
# The idea behind this algorithm to follow the linked list formed by the base
# pointers pushed at the beginning of each stack frame when a function is
# entered. We assume that the word just before the base pointer in the stack
# is indeed the return address to the caller and write that in the back trace.
#
# WARNING:
# Currently this code is not able to exit early when the end of the stack is
# reached. This means that if you call backtrace with a `size` parameter larger
# than the total number of stack frames at the time of the call, this code WILL
# segfault or do somthing bad.
#


.globl backtrace


backtrace:                              # backtrace(void **array, int size)
    pushl   %ebp
    movl    %esp, %ebp
    
    movl    8(%ebp), %ecx               # %ecx = array
    movl    12(%ebp), %edx              # %edx = size
    leal    (%ecx, %edx, 4), %edx       # %edx = &array[size]

backtrace.loop:
    # Exit when %ecx == %edx (ie. we wrote `size` entries into array)
    #
    cmpl    %ecx, %edx
    je      backtrace.exit

    # At this point:
    #
    #               +----------------+
    #               | RETURN ADDRESS |
    #               +----------------+
    #       EBP --> | PREVIOUS FRAME |
    #               +----------------+
    #
    movl    4(%ebp), %eax               # %eax = return address
    movl    0(%ebp), %ebp               # %ebp = previous frame
    movl    %eax, (%ecx)                # *(%ecx) = return address
    addl    $4, %ecx                    # %ecx++
    jmp     backtrace.loop

backtrace.exit:
    popl   %ebp
    ret


