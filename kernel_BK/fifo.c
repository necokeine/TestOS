/* FIFO buffer */

#include "header.h"

#define FLAGS_OVERRUN		0x0001

void fifo8_init(struct FIFO8 *fifo, int size, unsigned char *buf)
{
	fifo->size = size;
	fifo->buf = buf;
	fifo->free = size; 
	fifo->flags = 0;
	fifo->p = 0; /* next write */
	fifo->q = 0; /* next read */
	return;
}

int fifo8_put(struct FIFO8 *fifo, unsigned char data)
{
	if (fifo->free == 0) {
		/* no free space */
		fifo->flags |= FLAGS_OVERRUN;
		return -1;
	}
	fifo->buf[fifo->p] = data;
	fifo->p++;
	if (fifo->p == fifo->size) {
		fifo->p = 0;
	}
	fifo->free--;
	return 0;
}

int fifo8_get(struct FIFO8 *fifo)
{
	int data;
	if (fifo->free == fifo->size) {
		/* if buffer empty, return -1 */
		return -1;
	}
	data = fifo->buf[fifo->q];
	fifo->q++;
	if (fifo->q == fifo->size) {
		fifo->q = 0;
	}
	fifo->free++;
	return data;
}

int fifo8_status(struct FIFO8 *fifo)
/* return how much data in buffer */
{
	return fifo->size - fifo->free;
}

