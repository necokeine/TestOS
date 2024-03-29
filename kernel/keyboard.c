#include <header.h>
#define PORT_KEYDAT				0x0060
#define PORT_KEYSTA				0x0064
#define PORT_KEYCMD				0x0064
#define KEYSTA_SEND_NOTREADY	0x02
#define KEYCMD_WRITE_MODE		0x60
#define KBC_MODE				0x47


void wait_KBC_sendready(void)
{
	/* 僉乕儃乕僪僐儞僩儘乕儔偑僨乕僞憲怣壜擻偵側傞偺傪懸偮 */
	for (;;) {
		if ((io_in8(PORT_KEYSTA) & KEYSTA_SEND_NOTREADY) == 0) {
			break;
		}
	}
	return;
}

void init_keyboard(void)
{
	/* 僉乕儃乕僪僐儞僩儘乕儔偺弶婜壔 */
	wait_KBC_sendready();
	io_out8(PORT_KEYCMD, KEYCMD_WRITE_MODE);
	wait_KBC_sendready();
	io_out8(PORT_KEYDAT, KBC_MODE);
	return;
}
