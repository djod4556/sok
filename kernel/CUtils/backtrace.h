/*
 * backtrace.h
 *
 * Copyright (C) 2012 Simple Object Kernel project
 * by Gaëtan Morin
 *
 * Backtrace Headers.
 */

#ifndef _BACKTRACE_H_
#define _BACKTRACE_H_

#ifdef __cplusplus
extern "C" {
#endif



void backtrace(void **array, int size);



#ifdef __cplusplus
}
#endif

#endif
