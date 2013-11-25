
/**********************************************************************

 **********************************************************************/
#include"header.h"
#include"fontascii.h"

//需要用到的函数，halt,cli,out8,read_eflags,write_eflags,这些函数在x86.h中
//init _palette, set_palette 这两个函数我想放在screen.c中

#define black 0
#define red   1
#define green 2
struct boot_info *bootp=(struct boot_info *)ADDR_BOOT;

void bootmain(void)
{
static char font[40];	//sprintf buffer
char s[40];
int i=124567;		//sprintf variable i for test
char mousepic[256];     //mouse logo buffer
  char keybuf[32], mousebuf[128];
  clear_screen(40);   	//read
 	
  sti();		//enable cpu interrupt
  fifo8_init(&keyfifo, 32, keybuf);
  fifo8_init(&mousefifo, 128, mousebuf);
  init_screen((struct boot_info * )bootp);
  init_palette();  //color table from 0 to 15

  draw_window();  

/*
puts8((char *)bootp->vram ,bootp->xsize,0,0,black,"hello,world");
puts16((char *)bootp->vram ,bootp->xsize,0,16,red,"hello,world");
puts8((char *)bootp->vram ,bootp->xsize,0,40,green,"123456789  hello os");

sprintf(font,"print var:xsize=%d,vram=%x",bootp->xsize,bootp->vram); //
puts8((char *)bootp->vram ,bootp->xsize,0,118,2,font);

sprintf(font,"print var:i=%d",i);//printf variable i
puts8((char *)bootp->vram ,bootp->xsize,0,134,2,font);
*/




//display mouse logo
init_mouse(mousepic,7);//7　means background color:white
display_mouse(bootp->vram,bootp->xsize,16,16,60,60,mousepic,16);
init_gdtidt();
init_pic();//函数中：　irq 1(keyboard)对应设置中断号int0x21,    irq　12(mouse)对应的中断号是int0x2c 要写中断服务程序了。
outb(PIC0_IMR, 0xf9);//1111 1001  irq 1 2打开 因为keyboard是irq 1
outb(PIC1_IMR, 0xef);//1110 1111  irq 12打开　mouse是irq 12  所以要把pic 1 pic 2的芯片中断响应位打开。 



//inthandler21();

//int addr=inthandler21;
//printdebug(addr,0);

//打印出int0x21处的idt值，主要看offset是否与　asm_inthandler21一样（看反汇编，可以看到地址）
int * addr=(int *)(0x0026f800+8*0x21);
printdebug(*(addr),0);
printdebug(*(addr+1),160);

//io_halt();
  init_keyboard();
  enable_mouse();

	for (;;) {
		io_cli();
		if (fifo8_status(&keyfifo) || fifo8_status(&mousefifo)) {
			io_stihlt();
		} else {
			if (fifo8_status(&keyfifo) != 0) {
				i = fifo8_get(&keyfifo);
				io_sti();
				sprintf(s, "%x", i);
				boxfill8(bootp->vram, bootp->xsize, COL8_008484,  0, 16, 40, 31);
				puts8(bootp->vram, bootp->xsize, 0, 16, COL8_FFFFFF, s);
			} else if (fifo8_status(&mousefifo) != 0) {
				i = fifo8_get(&mousefifo);
				io_sti();
				sprintf(s, "%x", i);
				boxfill8(bootp->vram, bootp->xsize, COL8_008484, 50, 16, 90, 31);
				puts8(bootp->vram, bootp->xsize, 32, 16, COL8_FFFFFF, s);
			}
		}
	}

}

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

#define KEYCMD_SENDTO_MOUSE		0xd4
#define MOUSECMD_ENABLE			0xf4

void enable_mouse(void)
{
	/* 儅僂僗桳岠 */
	wait_KBC_sendready();
	io_out8(PORT_KEYCMD, KEYCMD_SENDTO_MOUSE);
	wait_KBC_sendready();
	io_out8(PORT_KEYDAT, MOUSECMD_ENABLE);
	return; /* 偆傑偔偄偔偲ACK(0xfa)偑憲怣偝傟偰偔傞 */
}

