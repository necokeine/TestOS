#include <header.h>
struct MOUSE_DEC glob;


#define PORT_KEYDAT				0x0060
#define PORT_KEYSTA				0x0064
#define PORT_KEYCMD				0x0064
#define KEYSTA_SEND_NOTREADY	0x02
#define KEYCMD_WRITE_MODE		0x60
#define KBC_MODE				0x47
#define KEYCMD_SENDTO_MOUSE		0xd4
#define MOUSECMD_ENABLE			0xf4
unsigned char mousepic[256];     //mouse logo buffer

void enable_mouse(struct boot_info *bootp)
{
	/* 儅僂僗桳岠 */
	init_mouse(mousepic,0);//7　means background color:white
	wait_KBC_sendready();
	io_out8(PORT_KEYCMD, KEYCMD_SENDTO_MOUSE);
	wait_KBC_sendready();
	io_out8(PORT_KEYDAT, MOUSECMD_ENABLE);
	glob.phase=-1;
	glob.x=60;
	glob.y=60;
	display_mouse(bootp->vram,bootp->xsize,16,16,60,60,mousepic,16);
	return; /* 偆傑偔偄偔偲ACK(0xfa)偑憲怣偝傟偰偔傞 */
}

void mouse_move(struct boot_info *bootp){
	boxfill8(bootp->vram,bootp->xsize,COL8_000000, glob.x,glob.y,glob.x+15,glob.y+15);//bg is black
	int i = glob.buf[1];
	if ((glob.buf[0] & 0x10) != 0 ) i |= 0xffffff00;
	glob.x += i;
	i = glob.buf[2];
	if ((glob.buf[0] & 0x20) != 0 ) i |= 0xffffff00;
	glob.y -= i;
	if (glob.x<0) glob.x=0;
	if (glob.y<0) glob.y=0;
	if (glob.x>bootp->xsize-16) glob.x=bootp->xsize-16;
	if (glob.y>bootp->ysize-16) glob.y=bootp->ysize-16;
	display_mouse(bootp->vram,bootp->xsize,16,16,glob.x,glob.y,mousepic,16);
	glob.buf[0]=glob.buf[1]=glob.buf[2]=0;
}

