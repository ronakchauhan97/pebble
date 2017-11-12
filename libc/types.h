#ifndef TYPES_H
#define TYPES_H

/* typedefs for common length datatypes */

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned long uint32_t;
typedef unsigned long long uint64_t;
typedef unsigned long long size_t;

typedef unsigned char int8_t;
typedef unsigned short int16_t;
typedef unsigned long int32_t;
typedef unsigned long long int64_t;


/* simulating bool using byte-long numbers as enums will be 4 bytes long */
typedef uint8_t bool;
#define true 1
#define false 0

#endif