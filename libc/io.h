#ifndef IO_H
#define IO_H

#include "types.h"
#define VID_MEM 0xb8000

void prints(char* s) {
	uint16_t *mem_loc = (uint16_t*) VID_MEM;
	static int mem_offset  = 0;
	uint16_t out = 0x0700;

	while(*s) {
		out = out | (uint16_t)(*s);
		*(mem_loc + mem_offset) = out;
		mem_offset++;
		out = 0x0700;
		s++;
	}
}

void clear() {
	uint16_t *mem_loc = (uint16_t*) VID_MEM;
	const uint16_t out = 0x0700;
	int mem_offset = 0;
	
	for(int16_t i = 0; i < 25*80; i++) {	
		*(mem_loc + mem_offset) = out;
		mem_offset++;
	}
}

#endif