
cobj.out：     文件格式 elf32-i386


Disassembly of section .text:

00280000 <wait_KBC_sendready>:
#define KEYSTA_SEND_NOTREADY	0x02
#define KEYCMD_WRITE_MODE		0x60
#define KBC_MODE				0x47

void wait_KBC_sendready(void)
{
  280000:	55                   	push   %ebp
static __inline uint8_t
inb(int port)
{
  //read a byte from port
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  280001:	ba 64 00 00 00       	mov    $0x64,%edx
  280006:	89 e5                	mov    %esp,%ebp
  280008:	ec                   	in     (%dx),%al
	/* 僉乕儃乕僪僐儞僩儘乕儔偑僨乕僞憲怣壜擻偵側傞偺傪懸偮 */
	for (;;) {
		if ((io_in8(PORT_KEYSTA) & KEYSTA_SEND_NOTREADY) == 0) {
  280009:	a8 02                	test   $0x2,%al
  28000b:	75 fb                	jne    280008 <wait_KBC_sendready+0x8>
			break;
		}
	}
	return;
}
  28000d:	5d                   	pop    %ebp
  28000e:	c3                   	ret    

0028000f <init_keyboard>:

void init_keyboard(void)
{
  28000f:	55                   	push   %ebp
  280010:	89 e5                	mov    %esp,%ebp
	/* 僉乕儃乕僪僐儞僩儘乕儔偺弶婜壔 */
	wait_KBC_sendready();
  280012:	e8 e9 ff ff ff       	call   280000 <wait_KBC_sendready>
// out:write a data to a port
static __inline void
outb(int port, uint8_t data)
{
  //data是变量0%0 , port是变量word１%w1
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  280017:	ba 64 00 00 00       	mov    $0x64,%edx
  28001c:	b0 60                	mov    $0x60,%al
  28001e:	ee                   	out    %al,(%dx)
	io_out8(PORT_KEYCMD, KEYCMD_WRITE_MODE);
	wait_KBC_sendready();
  28001f:	e8 dc ff ff ff       	call   280000 <wait_KBC_sendready>
  280024:	ba 60 00 00 00       	mov    $0x60,%edx
  280029:	b0 47                	mov    $0x47,%al
  28002b:	ee                   	out    %al,(%dx)
	io_out8(PORT_KEYDAT, KBC_MODE);
	return;
}
  28002c:	5d                   	pop    %ebp
  28002d:	c3                   	ret    

0028002e <enable_mouse>:

#define KEYCMD_SENDTO_MOUSE		0xd4
#define MOUSECMD_ENABLE			0xf4

void enable_mouse(void)
{
  28002e:	55                   	push   %ebp
  28002f:	89 e5                	mov    %esp,%ebp
	/* 儅僂僗桳岠 */
	wait_KBC_sendready();
  280031:	e8 ca ff ff ff       	call   280000 <wait_KBC_sendready>
  280036:	ba 64 00 00 00       	mov    $0x64,%edx
  28003b:	b0 d4                	mov    $0xd4,%al
  28003d:	ee                   	out    %al,(%dx)
	io_out8(PORT_KEYCMD, KEYCMD_SENDTO_MOUSE);
	wait_KBC_sendready();
  28003e:	e8 bd ff ff ff       	call   280000 <wait_KBC_sendready>
  280043:	ba 60 00 00 00       	mov    $0x60,%edx
  280048:	b0 f4                	mov    $0xf4,%al
  28004a:	ee                   	out    %al,(%dx)
	io_out8(PORT_KEYDAT, MOUSECMD_ENABLE);
	return; /* 偆傑偔偄偔偲ACK(0xfa)偑憲怣偝傟偰偔傞 */
}
  28004b:	5d                   	pop    %ebp
  28004c:	c3                   	ret    

0028004d <bootmain>:
#define red   1
#define green 2
struct boot_info *bootp=(struct boot_info *)ADDR_BOOT;

void bootmain(void)
{
  28004d:	55                   	push   %ebp
  28004e:	89 e5                	mov    %esp,%ebp
  280050:	53                   	push   %ebx
  280051:	81 ec e0 01 00 00    	sub    $0x1e0,%esp
static char font[40];	//sprintf buffer
char s[40];
int i=124567;		//sprintf variable i for test
char mousepic[256];     //mouse logo buffer
  char keybuf[32], mousebuf[128];
  clear_screen(40);   	//read
  280057:	6a 28                	push   $0x28
  280059:	e8 ca 01 00 00       	call   280228 <clear_screen>

static __inline void
sti(void)
{

	__asm __volatile("sti");
  28005e:	fb                   	sti    
 	
  sti();		//enable cpu interrupt
  fifo8_init(&keyfifo, 32, keybuf);
  28005f:	83 c4 0c             	add    $0xc,%esp
  280062:	8d 85 30 fe ff ff    	lea    -0x1d0(%ebp),%eax
  280068:	50                   	push   %eax
  280069:	6a 20                	push   $0x20
  28006b:	68 c4 2b 28 00       	push   $0x282bc4
  280070:	e8 b7 0a 00 00       	call   280b2c <fifo8_init>
  fifo8_init(&mousefifo, 128, mousebuf);
  280075:	83 c4 0c             	add    $0xc,%esp
  280078:	8d 85 78 fe ff ff    	lea    -0x188(%ebp),%eax
  28007e:	50                   	push   %eax
  28007f:	68 80 00 00 00       	push   $0x80
  280084:	68 dc 2b 28 00       	push   $0x282bdc
  280089:	e8 9e 0a 00 00       	call   280b2c <fifo8_init>




//display mouse logo
init_mouse(mousepic,7);//7　means background color:white
  28008e:	8d 9d f8 fe ff ff    	lea    -0x108(%ebp),%ebx
  clear_screen(40);   	//read
 	
  sti();		//enable cpu interrupt
  fifo8_init(&keyfifo, 32, keybuf);
  fifo8_init(&mousefifo, 128, mousebuf);
  init_screen((struct boot_info * )bootp);
  280094:	58                   	pop    %eax
  280095:	ff 35 c0 2b 28 00    	pushl  0x282bc0
  28009b:	e8 d1 03 00 00       	call   280471 <init_screen>
  init_palette();  //color table from 0 to 15
  2800a0:	e8 e3 01 00 00       	call   280288 <init_palette>

  draw_window();  
  2800a5:	e8 66 02 00 00       	call   280310 <draw_window>




//display mouse logo
init_mouse(mousepic,7);//7　means background color:white
  2800aa:	5a                   	pop    %edx
  2800ab:	59                   	pop    %ecx
  2800ac:	6a 07                	push   $0x7
  2800ae:	53                   	push   %ebx
  2800af:	e8 dc 03 00 00       	call   280490 <init_mouse>
display_mouse(bootp->vram,bootp->xsize,16,16,60,60,mousepic,16);
  2800b4:	a1 c0 2b 28 00       	mov    0x282bc0,%eax
  2800b9:	6a 10                	push   $0x10
  2800bb:	53                   	push   %ebx
  2800bc:	6a 3c                	push   $0x3c
  2800be:	6a 3c                	push   $0x3c
  2800c0:	6a 10                	push   $0x10
  2800c2:	6a 10                	push   $0x10
  2800c4:	0f bf 50 04          	movswl 0x4(%eax),%edx
  2800c8:	52                   	push   %edx
  2800c9:	ff 70 08             	pushl  0x8(%eax)
  2800cc:	e8 0f 04 00 00       	call   2804e0 <display_mouse>
init_gdtidt();
  2800d1:	83 c4 30             	add    $0x30,%esp
  2800d4:	e8 bd 07 00 00       	call   280896 <init_gdtidt>
init_pic();//函数中：　irq 1(keyboard)对应设置中断号int0x21,    irq　12(mouse)对应的中断号是int0x2c 要写中断服务程序了。
  2800d9:	e8 46 09 00 00       	call   280a24 <init_pic>
// out:write a data to a port
static __inline void
outb(int port, uint8_t data)
{
  //data是变量0%0 , port是变量word１%w1
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  2800de:	ba 21 00 00 00       	mov    $0x21,%edx
  2800e3:	b0 f9                	mov    $0xf9,%al
  2800e5:	ee                   	out    %al,(%dx)
  2800e6:	b0 ef                	mov    $0xef,%al
  2800e8:	b2 a1                	mov    $0xa1,%dl
  2800ea:	ee                   	out    %al,(%dx)
//int addr=inthandler21;
//printdebug(addr,0);

//打印出int0x21处的idt值，主要看offset是否与　asm_inthandler21一样（看反汇编，可以看到地址）
int * addr=(int *)(0x0026f800+8*0x21);
printdebug(*(addr),0);
  2800eb:	53                   	push   %ebx
  2800ec:	53                   	push   %ebx
  2800ed:	6a 00                	push   $0x0
  2800ef:	ff 35 08 f9 26 00    	pushl  0x26f908
				boxfill8(bootp->vram, bootp->xsize, COL8_008484,  0, 16, 40, 31);
				puts8(bootp->vram, bootp->xsize, 0, 16, COL8_FFFFFF, s);
			} else if (fifo8_status(&mousefifo) != 0) {
				i = fifo8_get(&mousefifo);
				io_sti();
				sprintf(s, "%x", i);
  2800f5:	8d 9d 50 fe ff ff    	lea    -0x1b0(%ebp),%ebx
//int addr=inthandler21;
//printdebug(addr,0);

//打印出int0x21处的idt值，主要看offset是否与　asm_inthandler21一样（看反汇编，可以看到地址）
int * addr=(int *)(0x0026f800+8*0x21);
printdebug(*(addr),0);
  2800fb:	e8 50 06 00 00       	call   280750 <printdebug>
printdebug(*(addr+1),160);
  280100:	58                   	pop    %eax
  280101:	5a                   	pop    %edx
  280102:	68 a0 00 00 00       	push   $0xa0
  280107:	ff 35 0c f9 26 00    	pushl  0x26f90c
  28010d:	e8 3e 06 00 00       	call   280750 <printdebug>

//io_halt();
  init_keyboard();
  280112:	e8 f8 fe ff ff       	call   28000f <init_keyboard>
  enable_mouse();
  280117:	e8 12 ff ff ff       	call   28002e <enable_mouse>
  28011c:	83 c4 10             	add    $0x10,%esp

	for (;;) {
		io_cli();
  28011f:	fa                   	cli    
		if (fifo8_status(&keyfifo) || fifo8_status(&mousefifo)) {
  280120:	83 ec 0c             	sub    $0xc,%esp
  280123:	68 c4 2b 28 00       	push   $0x282bc4
  280128:	e8 9d 0a 00 00       	call   280bca <fifo8_status>
  28012d:	83 c4 10             	add    $0x10,%esp
  280130:	85 c0                	test   %eax,%eax
  280132:	74 07                	je     28013b <bootmain+0xee>
			io_stihlt();
  280134:	e8 f0 09 00 00       	call   280b29 <io_stihlt>
  280139:	eb e4                	jmp    28011f <bootmain+0xd2>
  init_keyboard();
  enable_mouse();

	for (;;) {
		io_cli();
		if (fifo8_status(&keyfifo) || fifo8_status(&mousefifo)) {
  28013b:	83 ec 0c             	sub    $0xc,%esp
  28013e:	68 dc 2b 28 00       	push   $0x282bdc
  280143:	e8 82 0a 00 00       	call   280bca <fifo8_status>
  280148:	83 c4 10             	add    $0x10,%esp
  28014b:	85 c0                	test   %eax,%eax
  28014d:	75 e5                	jne    280134 <bootmain+0xe7>
			io_stihlt();
		} else {
			if (fifo8_status(&keyfifo) != 0) {
  28014f:	83 ec 0c             	sub    $0xc,%esp
  280152:	68 c4 2b 28 00       	push   $0x282bc4
  280157:	e8 6e 0a 00 00       	call   280bca <fifo8_status>
  28015c:	83 c4 10             	add    $0x10,%esp
  28015f:	85 c0                	test   %eax,%eax
  280161:	74 4d                	je     2801b0 <bootmain+0x163>
				i = fifo8_get(&keyfifo);
  280163:	83 ec 0c             	sub    $0xc,%esp
  280166:	68 c4 2b 28 00       	push   $0x282bc4
  28016b:	e8 25 0a 00 00       	call   280b95 <fifo8_get>
				io_sti();
  280170:	fb                   	sti    
				sprintf(s, "%x", i);
  280171:	83 c4 0c             	add    $0xc,%esp
  280174:	50                   	push   %eax
  280175:	68 e2 26 28 00       	push   $0x2826e2
  28017a:	53                   	push   %ebx
  28017b:	e8 60 04 00 00       	call   2805e0 <sprintf>
				boxfill8(bootp->vram, bootp->xsize, COL8_008484,  0, 16, 40, 31);
  280180:	83 c4 0c             	add    $0xc,%esp
  280183:	a1 c0 2b 28 00       	mov    0x282bc0,%eax
  280188:	6a 1f                	push   $0x1f
  28018a:	6a 28                	push   $0x28
  28018c:	6a 10                	push   $0x10
  28018e:	6a 00                	push   $0x0
  280190:	6a 0e                	push   $0xe
  280192:	0f bf 50 04          	movswl 0x4(%eax),%edx
  280196:	52                   	push   %edx
  280197:	ff 70 08             	pushl  0x8(%eax)
  28019a:	e8 1a 01 00 00       	call   2802b9 <boxfill8>
				puts8(bootp->vram, bootp->xsize, 0, 16, COL8_FFFFFF, s);
  28019f:	83 c4 18             	add    $0x18,%esp
  2801a2:	a1 c0 2b 28 00       	mov    0x282bc0,%eax
  2801a7:	53                   	push   %ebx
  2801a8:	6a 07                	push   $0x7
  2801aa:	6a 10                	push   $0x10
  2801ac:	6a 00                	push   $0x0
  2801ae:	eb 63                	jmp    280213 <bootmain+0x1c6>
			} else if (fifo8_status(&mousefifo) != 0) {
  2801b0:	83 ec 0c             	sub    $0xc,%esp
  2801b3:	68 dc 2b 28 00       	push   $0x282bdc
  2801b8:	e8 0d 0a 00 00       	call   280bca <fifo8_status>
  2801bd:	83 c4 10             	add    $0x10,%esp
  2801c0:	85 c0                	test   %eax,%eax
  2801c2:	0f 84 57 ff ff ff    	je     28011f <bootmain+0xd2>
				i = fifo8_get(&mousefifo);
  2801c8:	83 ec 0c             	sub    $0xc,%esp
  2801cb:	68 dc 2b 28 00       	push   $0x282bdc
  2801d0:	e8 c0 09 00 00       	call   280b95 <fifo8_get>
				io_sti();
  2801d5:	fb                   	sti    
				sprintf(s, "%x", i);
  2801d6:	83 c4 0c             	add    $0xc,%esp
  2801d9:	50                   	push   %eax
  2801da:	68 e2 26 28 00       	push   $0x2826e2
  2801df:	53                   	push   %ebx
  2801e0:	e8 fb 03 00 00       	call   2805e0 <sprintf>
				boxfill8(bootp->vram, bootp->xsize, COL8_008484, 50, 16, 90, 31);
  2801e5:	83 c4 0c             	add    $0xc,%esp
  2801e8:	a1 c0 2b 28 00       	mov    0x282bc0,%eax
  2801ed:	6a 1f                	push   $0x1f
  2801ef:	6a 5a                	push   $0x5a
  2801f1:	6a 10                	push   $0x10
  2801f3:	6a 32                	push   $0x32
  2801f5:	6a 0e                	push   $0xe
  2801f7:	0f bf 50 04          	movswl 0x4(%eax),%edx
  2801fb:	52                   	push   %edx
  2801fc:	ff 70 08             	pushl  0x8(%eax)
  2801ff:	e8 b5 00 00 00       	call   2802b9 <boxfill8>
				puts8(bootp->vram, bootp->xsize, 32, 16, COL8_FFFFFF, s);
  280204:	83 c4 18             	add    $0x18,%esp
  280207:	a1 c0 2b 28 00       	mov    0x282bc0,%eax
  28020c:	53                   	push   %ebx
  28020d:	6a 07                	push   $0x7
  28020f:	6a 10                	push   $0x10
  280211:	6a 20                	push   $0x20
  280213:	0f bf 50 04          	movswl 0x4(%eax),%edx
  280217:	52                   	push   %edx
  280218:	ff 70 08             	pushl  0x8(%eax)
  28021b:	e8 cc 04 00 00       	call   2806ec <puts8>
  280220:	83 c4 20             	add    $0x20,%esp
  280223:	e9 f7 fe ff ff       	jmp    28011f <bootmain+0xd2>

00280228 <clear_screen>:
#include<header.h>

void clear_screen(char color) //15:pure white
{
  280228:	55                   	push   %ebp
  int i;
  for(i=0xa0000;i<0xaffff;i++)
  280229:	b8 00 00 0a 00       	mov    $0xa0000,%eax
#include<header.h>

void clear_screen(char color) //15:pure white
{
  28022e:	89 e5                	mov    %esp,%ebp
  280230:	8a 55 08             	mov    0x8(%ebp),%dl
  int i;
  for(i=0xa0000;i<0xaffff;i++)
  {
  write_mem8(i,color);  //if we write 15 ,all pixels color will be white,15 mens pure white ,so the screen changes into white
  280233:	88 10                	mov    %dl,(%eax)
#include<header.h>

void clear_screen(char color) //15:pure white
{
  int i;
  for(i=0xa0000;i<0xaffff;i++)
  280235:	40                   	inc    %eax
  280236:	3d ff ff 0a 00       	cmp    $0xaffff,%eax
  28023b:	75 f6                	jne    280233 <clear_screen+0xb>
  {
  write_mem8(i,color);  //if we write 15 ,all pixels color will be white,15 mens pure white ,so the screen changes into white

  }
}
  28023d:	5d                   	pop    %ebp
  28023e:	c3                   	ret    

0028023f <color_screen>:

void color_screen(char color) //15:pure white
{
  28023f:	55                   	push   %ebp
  int i;
  color=color;
  for(i=0xa0000;i<0xaffff;i++)
  280240:	b8 00 00 0a 00       	mov    $0xa0000,%eax

  }
}

void color_screen(char color) //15:pure white
{
  280245:	89 e5                	mov    %esp,%ebp
  int i;
  color=color;
  for(i=0xa0000;i<0xaffff;i++)
  {
  write_mem8(i,i);  //if we write 15 ,all pixels color will be white,15 mens pure white ,so the screen changes into white
  280247:	88 00                	mov    %al,(%eax)

void color_screen(char color) //15:pure white
{
  int i;
  color=color;
  for(i=0xa0000;i<0xaffff;i++)
  280249:	40                   	inc    %eax
  28024a:	3d ff ff 0a 00       	cmp    $0xaffff,%eax
  28024f:	75 f6                	jne    280247 <color_screen+0x8>
  {
  write_mem8(i,i);  //if we write 15 ,all pixels color will be white,15 mens pure white ,so the screen changes into white

  }
}
  280251:	5d                   	pop    %ebp
  280252:	c3                   	ret    

00280253 <set_palette>:
   set_palette(0,255,table_rgb);
}

//设置调色板，  只用到了16个color,后面的都没有用到。
void set_palette(int start,int end, unsigned char *rgb)
{
  280253:	55                   	push   %ebp
  280254:	89 e5                	mov    %esp,%ebp
  280256:	56                   	push   %esi
  280257:	8b 4d 10             	mov    0x10(%ebp),%ecx
  28025a:	53                   	push   %ebx
  28025b:	8b 5d 08             	mov    0x8(%ebp),%ebx
//read eflags and write_eflags
static __inline uint32_t
read_eflags(void)
{
        uint32_t eflags;
        __asm __volatile("pushfl; popl %0" : "=r" (eflags));
  28025e:	9c                   	pushf  
  28025f:	5e                   	pop    %esi
  int i,eflag;
  eflag=read_eflags();   //记录从前的cpsr值
 
  io_cli(); // disable interrupt
  280260:	fa                   	cli    
// out:write a data to a port
static __inline void
outb(int port, uint8_t data)
{
  //data是变量0%0 , port是变量word１%w1
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  280261:	ba c8 03 00 00       	mov    $0x3c8,%edx
  //为什么写port 0x03c8
  
  //rgb=rgb+;
  outb(0x03c8,start);
  280266:	0f b6 c3             	movzbl %bl,%eax
  280269:	ee                   	out    %al,(%dx)
  28026a:	b2 c9                	mov    $0xc9,%dl
  for(i=start;i<=end;i++)
  28026c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
  28026f:	7f 11                	jg     280282 <set_palette+0x2f>
  280271:	8a 01                	mov    (%ecx),%al
  280273:	ee                   	out    %al,(%dx)
  280274:	8a 41 01             	mov    0x1(%ecx),%al
  280277:	ee                   	out    %al,(%dx)
  280278:	8a 41 02             	mov    0x2(%ecx),%al
  28027b:	ee                   	out    %al,(%dx)
  {
    outb(0x03c9,*(rgb));    //outb函数是往指定的设备，送数据。
    outb(0x03c9,*(rgb+1));   
    outb(0x03c9,*(rgb+2));   
    rgb=rgb+3;
  28027c:	83 c1 03             	add    $0x3,%ecx
  io_cli(); // disable interrupt
  //为什么写port 0x03c8
  
  //rgb=rgb+;
  outb(0x03c8,start);
  for(i=start;i<=end;i++)
  28027f:	43                   	inc    %ebx
  280280:	eb ea                	jmp    28026c <set_palette+0x19>
}

static __inline void
write_eflags(uint32_t eflags)
{
        __asm __volatile("pushl %0; popfl" : : "r" (eflags));
  280282:	56                   	push   %esi
  280283:	9d                   	popf   
  }
  
write_eflags(eflag);  //恢复从前的cpsr
  return;
  
}
  280284:	5b                   	pop    %ebx
  280285:	5e                   	pop    %esi
  280286:	5d                   	pop    %ebp
  280287:	c3                   	ret    

00280288 <init_palette>:
}

//初始化调色板，table_rgb[]保存了16种color的编码。
//什么调色板是这样进行设置，这个与x86的port 0x03c8 0x03c9
void init_palette(void)
{
  280288:	55                   	push   %ebp
  //16种color，每个color三个字节。
unsigned char table_rgb[16*3]={
  280289:	b9 0c 00 00 00       	mov    $0xc,%ecx
}

//初始化调色板，table_rgb[]保存了16种color的编码。
//什么调色板是这样进行设置，这个与x86的port 0x03c8 0x03c9
void init_palette(void)
{
  28028e:	89 e5                	mov    %esp,%ebp
  280290:	57                   	push   %edi
  280291:	56                   	push   %esi
  //16种color，每个color三个字节。
unsigned char table_rgb[16*3]={
  280292:	be a8 25 28 00       	mov    $0x2825a8,%esi
}

//初始化调色板，table_rgb[]保存了16种color的编码。
//什么调色板是这样进行设置，这个与x86的port 0x03c8 0x03c9
void init_palette(void)
{
  280297:	83 ec 30             	sub    $0x30,%esp
    0x00,0x00,0x84,   /*12:dark 青*/
    0x84,0x00,0x84,   /*13:dark purper*/
    0x00,0x84,0x84,   /*14:light blue*/
    0x84,0x84,0x84,   /*15:dark gray*/
  };
   set_palette(0,255,table_rgb);
  28029a:	8d 45 c8             	lea    -0x38(%ebp),%eax
//初始化调色板，table_rgb[]保存了16种color的编码。
//什么调色板是这样进行设置，这个与x86的port 0x03c8 0x03c9
void init_palette(void)
{
  //16种color，每个color三个字节。
unsigned char table_rgb[16*3]={
  28029d:	8d 7d c8             	lea    -0x38(%ebp),%edi
  2802a0:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    0x00,0x00,0x84,   /*12:dark 青*/
    0x84,0x00,0x84,   /*13:dark purper*/
    0x00,0x84,0x84,   /*14:light blue*/
    0x84,0x84,0x84,   /*15:dark gray*/
  };
   set_palette(0,255,table_rgb);
  2802a2:	50                   	push   %eax
  2802a3:	68 ff 00 00 00       	push   $0xff
  2802a8:	6a 00                	push   $0x0
  2802aa:	e8 a4 ff ff ff       	call   280253 <set_palette>
  2802af:	83 c4 0c             	add    $0xc,%esp
}
  2802b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  2802b5:	5e                   	pop    %esi
  2802b6:	5f                   	pop    %edi
  2802b7:	5d                   	pop    %ebp
  2802b8:	c3                   	ret    

002802b9 <boxfill8>:
  return;
  
}

void boxfill8(unsigned char *vram,int xsize,unsigned char color,int x0,int y0,int x1,int y1)
{
  2802b9:	55                   	push   %ebp
  2802ba:	89 e5                	mov    %esp,%ebp
  2802bc:	8b 4d 18             	mov    0x18(%ebp),%ecx
  2802bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  2802c2:	53                   	push   %ebx
  2802c3:	8a 5d 10             	mov    0x10(%ebp),%bl
  2802c6:	0f af c1             	imul   %ecx,%eax
  2802c9:	03 45 08             	add    0x8(%ebp),%eax
 int x,y;
 for(y=y0;y<=y1;y++)
  2802cc:	3b 4d 20             	cmp    0x20(%ebp),%ecx
  2802cf:	7f 14                	jg     2802e5 <boxfill8+0x2c>
  2802d1:	8b 55 14             	mov    0x14(%ebp),%edx
 {
   for(x=x0;x<=x1;x++)
  2802d4:	3b 55 1c             	cmp    0x1c(%ebp),%edx
  2802d7:	7f 06                	jg     2802df <boxfill8+0x26>
   {
      vram[y*xsize+x]=color;
  2802d9:	88 1c 10             	mov    %bl,(%eax,%edx,1)
void boxfill8(unsigned char *vram,int xsize,unsigned char color,int x0,int y0,int x1,int y1)
{
 int x,y;
 for(y=y0;y<=y1;y++)
 {
   for(x=x0;x<=x1;x++)
  2802dc:	42                   	inc    %edx
  2802dd:	eb f5                	jmp    2802d4 <boxfill8+0x1b>
}

void boxfill8(unsigned char *vram,int xsize,unsigned char color,int x0,int y0,int x1,int y1)
{
 int x,y;
 for(y=y0;y<=y1;y++)
  2802df:	41                   	inc    %ecx
  2802e0:	03 45 0c             	add    0xc(%ebp),%eax
  2802e3:	eb e7                	jmp    2802cc <boxfill8+0x13>
   {
      vram[y*xsize+x]=color;
   }
 }
   
}
  2802e5:	5b                   	pop    %ebx
  2802e6:	5d                   	pop    %ebp
  2802e7:	c3                   	ret    

002802e8 <boxfill>:
void boxfill(unsigned char color,int x0,int y0,int x1,int y1)
{
  2802e8:	55                   	push   %ebp
  2802e9:	89 e5                	mov    %esp,%ebp
  boxfill8((unsigned char *)VRAM,320,color,x0,y0,x1,y1);
  2802eb:	ff 75 18             	pushl  0x18(%ebp)
  2802ee:	ff 75 14             	pushl  0x14(%ebp)
  2802f1:	ff 75 10             	pushl  0x10(%ebp)
  2802f4:	ff 75 0c             	pushl  0xc(%ebp)
  2802f7:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
  2802fb:	50                   	push   %eax
  2802fc:	68 40 01 00 00       	push   $0x140
  280301:	68 00 00 0a 00       	push   $0xa0000
  280306:	e8 ae ff ff ff       	call   2802b9 <boxfill8>
  28030b:	83 c4 1c             	add    $0x1c,%esp
}
  28030e:	c9                   	leave  
  28030f:	c3                   	ret    

00280310 <draw_window>:

void draw_window()
{ 
  280310:	55                   	push   %ebp
  280311:	89 e5                	mov    %esp,%ebp
  int x=320,y=200;
    p=(unsigned char*)VRAM;
//     boxfill8(p,320,110,20,20,250,150);
    
    //draw a window
    boxfill(7 ,0, 0   ,x-1,y-29);
  280313:	68 ab 00 00 00       	push   $0xab
  280318:	68 3f 01 00 00       	push   $0x13f
  28031d:	6a 00                	push   $0x0
  28031f:	6a 00                	push   $0x0
  280321:	6a 07                	push   $0x7
  280323:	e8 c0 ff ff ff       	call   2802e8 <boxfill>
//task button    
    boxfill(8  ,0, y-28,x-1,y-28);
  280328:	68 ac 00 00 00       	push   $0xac
  28032d:	68 3f 01 00 00       	push   $0x13f
  280332:	68 ac 00 00 00       	push   $0xac
  280337:	6a 00                	push   $0x0
  280339:	6a 08                	push   $0x8
  28033b:	e8 a8 ff ff ff       	call   2802e8 <boxfill>
    boxfill(7  ,0, y-27,x-1,y-27);
  280340:	83 c4 28             	add    $0x28,%esp
  280343:	68 ad 00 00 00       	push   $0xad
  280348:	68 3f 01 00 00       	push   $0x13f
  28034d:	68 ad 00 00 00       	push   $0xad
  280352:	6a 00                	push   $0x0
  280354:	6a 07                	push   $0x7
  280356:	e8 8d ff ff ff       	call   2802e8 <boxfill>
    boxfill(8  ,0, y-26,x-1,y-1);
  28035b:	68 c7 00 00 00       	push   $0xc7
  280360:	68 3f 01 00 00       	push   $0x13f
  280365:	68 ae 00 00 00       	push   $0xae
  28036a:	6a 00                	push   $0x0
  28036c:	6a 08                	push   $0x8
  28036e:	e8 75 ff ff ff       	call   2802e8 <boxfill>
    
    
//left button    
    boxfill(7, 3,  y-24, 59,  y-24);
  280373:	83 c4 28             	add    $0x28,%esp
  280376:	68 b0 00 00 00       	push   $0xb0
  28037b:	6a 3b                	push   $0x3b
  28037d:	68 b0 00 00 00       	push   $0xb0
  280382:	6a 03                	push   $0x3
  280384:	6a 07                	push   $0x7
  280386:	e8 5d ff ff ff       	call   2802e8 <boxfill>
    boxfill(7, 2,  y-24, 2 ,  y-4);  
  28038b:	68 c4 00 00 00       	push   $0xc4
  280390:	6a 02                	push   $0x2
  280392:	68 b0 00 00 00       	push   $0xb0
  280397:	6a 02                	push   $0x2
  280399:	6a 07                	push   $0x7
  28039b:	e8 48 ff ff ff       	call   2802e8 <boxfill>
    boxfill(15, 3,  y-4,  59,  y-4);
  2803a0:	83 c4 28             	add    $0x28,%esp
  2803a3:	68 c4 00 00 00       	push   $0xc4
  2803a8:	6a 3b                	push   $0x3b
  2803aa:	68 c4 00 00 00       	push   $0xc4
  2803af:	6a 03                	push   $0x3
  2803b1:	6a 0f                	push   $0xf
  2803b3:	e8 30 ff ff ff       	call   2802e8 <boxfill>
    boxfill(15, 59, y-23, 59,  y-5);
  2803b8:	68 c3 00 00 00       	push   $0xc3
  2803bd:	6a 3b                	push   $0x3b
  2803bf:	68 b1 00 00 00       	push   $0xb1
  2803c4:	6a 3b                	push   $0x3b
  2803c6:	6a 0f                	push   $0xf
  2803c8:	e8 1b ff ff ff       	call   2802e8 <boxfill>
    boxfill(0, 2,  y-3,  59,  y-3);
  2803cd:	83 c4 28             	add    $0x28,%esp
  2803d0:	68 c5 00 00 00       	push   $0xc5
  2803d5:	6a 3b                	push   $0x3b
  2803d7:	68 c5 00 00 00       	push   $0xc5
  2803dc:	6a 02                	push   $0x2
  2803de:	6a 00                	push   $0x0
  2803e0:	e8 03 ff ff ff       	call   2802e8 <boxfill>
    boxfill(0, 60, y-24, 60,  y-3);  
  2803e5:	68 c5 00 00 00       	push   $0xc5
  2803ea:	6a 3c                	push   $0x3c
  2803ec:	68 b0 00 00 00       	push   $0xb0
  2803f1:	6a 3c                	push   $0x3c
  2803f3:	6a 00                	push   $0x0
  2803f5:	e8 ee fe ff ff       	call   2802e8 <boxfill>

// 
//right button    
    boxfill(15, x-47, y-24,x-4,y-24);
  2803fa:	83 c4 28             	add    $0x28,%esp
  2803fd:	68 b0 00 00 00       	push   $0xb0
  280402:	68 3c 01 00 00       	push   $0x13c
  280407:	68 b0 00 00 00       	push   $0xb0
  28040c:	68 11 01 00 00       	push   $0x111
  280411:	6a 0f                	push   $0xf
  280413:	e8 d0 fe ff ff       	call   2802e8 <boxfill>
    boxfill(15, x-47, y-23,x-47,y-4);  
  280418:	68 c4 00 00 00       	push   $0xc4
  28041d:	68 11 01 00 00       	push   $0x111
  280422:	68 b1 00 00 00       	push   $0xb1
  280427:	68 11 01 00 00       	push   $0x111
  28042c:	6a 0f                	push   $0xf
  28042e:	e8 b5 fe ff ff       	call   2802e8 <boxfill>
    boxfill(7, x-47, y-3,x-4,y-3);
  280433:	83 c4 28             	add    $0x28,%esp
  280436:	68 c5 00 00 00       	push   $0xc5
  28043b:	68 3c 01 00 00       	push   $0x13c
  280440:	68 c5 00 00 00       	push   $0xc5
  280445:	68 11 01 00 00       	push   $0x111
  28044a:	6a 07                	push   $0x7
  28044c:	e8 97 fe ff ff       	call   2802e8 <boxfill>
    boxfill(7, x-3, y-24,x-3,y-3);
  280451:	68 c5 00 00 00       	push   $0xc5
  280456:	68 3d 01 00 00       	push   $0x13d
  28045b:	68 b0 00 00 00       	push   $0xb0
  280460:	68 3d 01 00 00       	push   $0x13d
  280465:	6a 07                	push   $0x7
  280467:	e8 7c fe ff ff       	call   2802e8 <boxfill>
  28046c:	83 c4 28             	add    $0x28,%esp
}
  28046f:	c9                   	leave  
  280470:	c3                   	ret    

00280471 <init_screen>:


void init_screen(struct boot_info * bootp)
{
  280471:	55                   	push   %ebp
  280472:	89 e5                	mov    %esp,%ebp
  280474:	8b 45 08             	mov    0x8(%ebp),%eax
  bootp->vram=(char *)VRAM;
  280477:	c7 40 08 00 00 0a 00 	movl   $0xa0000,0x8(%eax)
  bootp->color_mode=8;
  28047e:	c6 40 02 08          	movb   $0x8,0x2(%eax)
  bootp->xsize=320;
  280482:	66 c7 40 04 40 01    	movw   $0x140,0x4(%eax)
  bootp->ysize=200;
  280488:	66 c7 40 06 c8 00    	movw   $0xc8,0x6(%eax)
  
}
  28048e:	5d                   	pop    %ebp
  28048f:	c3                   	ret    

00280490 <init_mouse>:

///关于mouse的函数
void init_mouse(char *mouse,char bg)
{
  280490:	55                   	push   %ebp
  280491:	31 c9                	xor    %ecx,%ecx
  280493:	89 e5                	mov    %esp,%ebp
  280495:	8a 45 0c             	mov    0xc(%ebp),%al
  280498:	8b 55 08             	mov    0x8(%ebp),%edx
  28049b:	56                   	push   %esi
  28049c:	53                   	push   %ebx
  28049d:	89 c6                	mov    %eax,%esi
  28049f:	31 c0                	xor    %eax,%eax
	int x,y;
	for(y=0;y<16;y++)
	{
	  for(x=0;x<16;x++)
	  {
	    switch (cursor[y][x])
  2804a1:	8a 9c 01 d8 25 28 00 	mov    0x2825d8(%ecx,%eax,1),%bl
  2804a8:	80 fb 2e             	cmp    $0x2e,%bl
  2804ab:	74 10                	je     2804bd <init_mouse+0x2d>
  2804ad:	80 fb 4f             	cmp    $0x4f,%bl
  2804b0:	74 12                	je     2804c4 <init_mouse+0x34>
  2804b2:	80 fb 2a             	cmp    $0x2a,%bl
  2804b5:	75 11                	jne    2804c8 <init_mouse+0x38>
	    {
	      case '.':mouse[x+16*y]=bg;break;  //background
	      case '*':mouse[x+16*y]=outline;break;   //outline
  2804b7:	c6 04 02 00          	movb   $0x0,(%edx,%eax,1)
  2804bb:	eb 0b                	jmp    2804c8 <init_mouse+0x38>
	{
	  for(x=0;x<16;x++)
	  {
	    switch (cursor[y][x])
	    {
	      case '.':mouse[x+16*y]=bg;break;  //background
  2804bd:	89 f3                	mov    %esi,%ebx
  2804bf:	88 1c 02             	mov    %bl,(%edx,%eax,1)
  2804c2:	eb 04                	jmp    2804c8 <init_mouse+0x38>
	      case '*':mouse[x+16*y]=outline;break;   //outline
	      case 'O':mouse[x+16*y]=inside;break;  //inside
  2804c4:	c6 04 02 02          	movb   $0x2,(%edx,%eax,1)
		".............***"
	};
	int x,y;
	for(y=0;y<16;y++)
	{
	  for(x=0;x<16;x++)
  2804c8:	40                   	inc    %eax
  2804c9:	83 f8 10             	cmp    $0x10,%eax
  2804cc:	75 d3                	jne    2804a1 <init_mouse+0x11>
  2804ce:	83 c1 10             	add    $0x10,%ecx
  2804d1:	83 c2 10             	add    $0x10,%edx
		"*..........*OOO*",
		"............*OO*",
		".............***"
	};
	int x,y;
	for(y=0;y<16;y++)
  2804d4:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
  2804da:	75 c3                	jne    28049f <init_mouse+0xf>
	    
	  }
	  
	}
  
}
  2804dc:	5b                   	pop    %ebx
  2804dd:	5e                   	pop    %esi
  2804de:	5d                   	pop    %ebp
  2804df:	c3                   	ret    

002804e0 <display_mouse>:

void display_mouse(char *vram,int xsize,int pxsize,int pysize,int px0,int py0,char *buf,int bxsize)
{
  2804e0:	55                   	push   %ebp
  2804e1:	89 e5                	mov    %esp,%ebp
  2804e3:	8b 45 1c             	mov    0x1c(%ebp),%eax
  2804e6:	56                   	push   %esi
  int x,y;
  for(y=0;y<pysize;y++)
  2804e7:	31 f6                	xor    %esi,%esi
	}
  
}

void display_mouse(char *vram,int xsize,int pxsize,int pysize,int px0,int py0,char *buf,int bxsize)
{
  2804e9:	53                   	push   %ebx
  2804ea:	8b 5d 20             	mov    0x20(%ebp),%ebx
  2804ed:	0f af 45 0c          	imul   0xc(%ebp),%eax
  2804f1:	03 45 18             	add    0x18(%ebp),%eax
  2804f4:	03 45 08             	add    0x8(%ebp),%eax
  int x,y;
  for(y=0;y<pysize;y++)
  2804f7:	3b 75 14             	cmp    0x14(%ebp),%esi
  2804fa:	7d 19                	jge    280515 <display_mouse+0x35>
  2804fc:	31 d2                	xor    %edx,%edx
  {
    for(x=0;x<pxsize;x++)
  2804fe:	3b 55 10             	cmp    0x10(%ebp),%edx
  280501:	7d 09                	jge    28050c <display_mouse+0x2c>
    {
     vram[(py0+y)*xsize+(px0+x)]=buf[y*bxsize+x];
  280503:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  280506:	88 0c 10             	mov    %cl,(%eax,%edx,1)
void display_mouse(char *vram,int xsize,int pxsize,int pysize,int px0,int py0,char *buf,int bxsize)
{
  int x,y;
  for(y=0;y<pysize;y++)
  {
    for(x=0;x<pxsize;x++)
  280509:	42                   	inc    %edx
  28050a:	eb f2                	jmp    2804fe <display_mouse+0x1e>
}

void display_mouse(char *vram,int xsize,int pxsize,int pysize,int px0,int py0,char *buf,int bxsize)
{
  int x,y;
  for(y=0;y<pysize;y++)
  28050c:	46                   	inc    %esi
  28050d:	03 5d 24             	add    0x24(%ebp),%ebx
  280510:	03 45 0c             	add    0xc(%ebp),%eax
  280513:	eb e2                	jmp    2804f7 <display_mouse+0x17>
    {
     vram[(py0+y)*xsize+(px0+x)]=buf[y*bxsize+x];
    }
  }
  
}
  280515:	5b                   	pop    %ebx
  280516:	5e                   	pop    %esi
  280517:	5d                   	pop    %ebp
  280518:	c3                   	ret    
  280519:	66 90                	xchg   %ax,%ax
  28051b:	90                   	nop

0028051c <itoa>:
sprintf(font,"Debug:var=%x" ,i);
puts8((char *)VRAM ,320,x,150,1,font);

}

void itoa(int value,char *buf){
  28051c:	55                   	push   %ebp
    char tmp_buf[10] = {0};
  28051d:	31 c0                	xor    %eax,%eax
sprintf(font,"Debug:var=%x" ,i);
puts8((char *)VRAM ,320,x,150,1,font);

}

void itoa(int value,char *buf){
  28051f:	89 e5                	mov    %esp,%ebp
    char tmp_buf[10] = {0};
  280521:	b9 0a 00 00 00       	mov    $0xa,%ecx
sprintf(font,"Debug:var=%x" ,i);
puts8((char *)VRAM ,320,x,150,1,font);

}

void itoa(int value,char *buf){
  280526:	57                   	push   %edi
  280527:	56                   	push   %esi
  280528:	53                   	push   %ebx
  280529:	83 ec 10             	sub    $0x10,%esp
  28052c:	8b 55 08             	mov    0x8(%ebp),%edx
    char tmp_buf[10] = {0};
  28052f:	8d 7d ea             	lea    -0x16(%ebp),%edi
sprintf(font,"Debug:var=%x" ,i);
puts8((char *)VRAM ,320,x,150,1,font);

}

void itoa(int value,char *buf){
  280532:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    char tmp_buf[10] = {0};
  280535:	f3 aa                	rep stos %al,%es:(%edi)
  280537:	8d 7d ea             	lea    -0x16(%ebp),%edi
    char *tbp = tmp_buf;
    if((value >> 31) & 0x1)
  28053a:	85 d2                	test   %edx,%edx
  28053c:	79 06                	jns    280544 <itoa+0x28>
    { /* neg num */
        *buf++ = '-';//得到负号
  28053e:	c6 03 2d             	movb   $0x2d,(%ebx)
        value = ~value + 1; //将负数变为正数
  280541:	f7 da                	neg    %edx
void itoa(int value,char *buf){
    char tmp_buf[10] = {0};
    char *tbp = tmp_buf;
    if((value >> 31) & 0x1)
    { /* neg num */
        *buf++ = '-';//得到负号
  280543:	43                   	inc    %ebx
  280544:	89 f9                	mov    %edi,%ecx
        value = ~value + 1; //将负数变为正数
    }
    
    do
    {
        *tbp++ = ('0' + (char)(value % 10));//得到低位数字
  280546:	be 0a 00 00 00       	mov    $0xa,%esi
  28054b:	89 d0                	mov    %edx,%eax
  28054d:	41                   	inc    %ecx
  28054e:	99                   	cltd   
  28054f:	f7 fe                	idiv   %esi
  280551:	83 c2 30             	add    $0x30,%edx
        value /= 10;
    }while(value);
  280554:	85 c0                	test   %eax,%eax
        value = ~value + 1; //将负数变为正数
    }
    
    do
    {
        *tbp++ = ('0' + (char)(value % 10));//得到低位数字
  280556:	88 51 ff             	mov    %dl,-0x1(%ecx)
        value /= 10;
  280559:	89 c2                	mov    %eax,%edx
    }while(value);
  28055b:	75 ee                	jne    28054b <itoa+0x2f>
        value = ~value + 1; //将负数变为正数
    }
    
    do
    {
        *tbp++ = ('0' + (char)(value % 10));//得到低位数字
  28055d:	89 ce                	mov    %ecx,%esi
  28055f:	89 d8                	mov    %ebx,%eax
        value /= 10;
    }while(value);
    
    
    while(tmp_buf != tbp)
  280561:	39 f9                	cmp    %edi,%ecx
  280563:	74 09                	je     28056e <itoa+0x52>
    {
      tbp--;
  280565:	49                   	dec    %ecx
      *buf++ = *tbp;
  280566:	8a 11                	mov    (%ecx),%dl
  280568:	40                   	inc    %eax
  280569:	88 50 ff             	mov    %dl,-0x1(%eax)
  28056c:	eb f3                	jmp    280561 <itoa+0x45>
  28056e:	89 f0                	mov    %esi,%eax
  280570:	29 c8                	sub    %ecx,%eax

    }
    *buf='\0';
  280572:	c6 04 03 00          	movb   $0x0,(%ebx,%eax,1)
    
    
}
  280576:	83 c4 10             	add    $0x10,%esp
  280579:	5b                   	pop    %ebx
  28057a:	5e                   	pop    %esi
  28057b:	5f                   	pop    %edi
  28057c:	5d                   	pop    %ebp
  28057d:	c3                   	ret    

0028057e <xtoa>:
    else
        value = value + 48;
    return value;
}

void xtoa(unsigned int value,char *buf){
  28057e:	55                   	push   %ebp
    char tmp_buf[30] = {0};
  28057f:	31 c0                	xor    %eax,%eax
    else
        value = value + 48;
    return value;
}

void xtoa(unsigned int value,char *buf){
  280581:	89 e5                	mov    %esp,%ebp
    char tmp_buf[30] = {0};
  280583:	b9 1e 00 00 00       	mov    $0x1e,%ecx
    else
        value = value + 48;
    return value;
}

void xtoa(unsigned int value,char *buf){
  280588:	57                   	push   %edi
  280589:	56                   	push   %esi
  28058a:	53                   	push   %ebx
  28058b:	83 ec 20             	sub    $0x20,%esp
  28058e:	8b 55 0c             	mov    0xc(%ebp),%edx
    char tmp_buf[30] = {0};
  280591:	8d 7d d6             	lea    -0x2a(%ebp),%edi
  280594:	f3 aa                	rep stos %al,%es:(%edi)
    char *tbp = tmp_buf;
  280596:	8d 45 d6             	lea    -0x2a(%ebp),%eax

    *buf++='0';
  280599:	c6 02 30             	movb   $0x30,(%edx)
    *buf++='x';
  28059c:	8d 72 02             	lea    0x2(%edx),%esi
  28059f:	c6 42 01 78          	movb   $0x78,0x1(%edx)
  
    do
    {
        // *tbp++ = ('0' + (char)(value % 16));//得到低位数字
	*tbp++=fourbtoc(value&0x0000000f);
  2805a3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  2805a6:	40                   	inc    %eax
  2805a7:	83 e3 0f             	and    $0xf,%ebx
    
    
}
static  inline char fourbtoc(int value){
    if(value >= 10)
        value = value - 10 + 65;
  2805aa:	83 fb 0a             	cmp    $0xa,%ebx
  2805ad:	8d 4b 37             	lea    0x37(%ebx),%ecx
  2805b0:	8d 7b 30             	lea    0x30(%ebx),%edi
  2805b3:	0f 4c cf             	cmovl  %edi,%ecx
        // *tbp++ = ('0' + (char)(value % 16));//得到低位数字
	*tbp++=fourbtoc(value&0x0000000f);
        
        //*tbp++ = ((value % 16)>9)?('A' + (char)(value % 16-10)):('0' + (char)(value % 16));//得到低位数字
        value >>= 4;
    }while(value);
  2805b6:	c1 6d 08 04          	shrl   $0x4,0x8(%ebp)
static  inline char fourbtoc(int value){
    if(value >= 10)
        value = value - 10 + 65;
    else
        value = value + 48;
    return value;
  2805ba:	88 48 ff             	mov    %cl,-0x1(%eax)
        // *tbp++ = ('0' + (char)(value % 16));//得到低位数字
	*tbp++=fourbtoc(value&0x0000000f);
        
        //*tbp++ = ((value % 16)>9)?('A' + (char)(value % 16-10)):('0' + (char)(value % 16));//得到低位数字
        value >>= 4;
    }while(value);
  2805bd:	75 e4                	jne    2805a3 <xtoa+0x25>
    *buf++='x';
  
    do
    {
        // *tbp++ = ('0' + (char)(value % 16));//得到低位数字
	*tbp++=fourbtoc(value&0x0000000f);
  2805bf:	89 c3                	mov    %eax,%ebx
        //*tbp++ = ((value % 16)>9)?('A' + (char)(value % 16-10)):('0' + (char)(value % 16));//得到低位数字
        value >>= 4;
    }while(value);
    
    
    while(tmp_buf != tbp)
  2805c1:	8d 7d d6             	lea    -0x2a(%ebp),%edi
  2805c4:	39 f8                	cmp    %edi,%eax
  2805c6:	74 09                	je     2805d1 <xtoa+0x53>
    {
      tbp--;
  2805c8:	48                   	dec    %eax
      *buf++ = *tbp;
  2805c9:	8a 08                	mov    (%eax),%cl
  2805cb:	46                   	inc    %esi
  2805cc:	88 4e ff             	mov    %cl,-0x1(%esi)
  2805cf:	eb f0                	jmp    2805c1 <xtoa+0x43>
  2805d1:	29 c3                	sub    %eax,%ebx

    }
    *buf='\0';
  2805d3:	c6 44 1a 02 00       	movb   $0x0,0x2(%edx,%ebx,1)
    
    
}
  2805d8:	83 c4 20             	add    $0x20,%esp
  2805db:	5b                   	pop    %ebx
  2805dc:	5e                   	pop    %esi
  2805dd:	5f                   	pop    %edi
  2805de:	5d                   	pop    %ebp
  2805df:	c3                   	ret    

002805e0 <sprintf>:



//实现可变参数的打印，主要是为了观察打印的变量。
void sprintf(char *str,char *format ,...)
{
  2805e0:	55                   	push   %ebp
  2805e1:	89 e5                	mov    %esp,%ebp
  2805e3:	57                   	push   %edi
  2805e4:	56                   	push   %esi
  2805e5:	53                   	push   %ebx
  2805e6:	83 ec 10             	sub    $0x10,%esp
  2805e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  
   int *var=(int *)(&format)+1; //得到第一个可变参数的地址
  2805ec:	8d 75 10             	lea    0x10(%ebp),%esi
   char buffer[10];
   char *buf=buffer;
  while(*format)
  2805ef:	8b 7d 0c             	mov    0xc(%ebp),%edi
  2805f2:	8a 07                	mov    (%edi),%al
  2805f4:	84 c0                	test   %al,%al
  2805f6:	0f 84 83 00 00 00    	je     28067f <sprintf+0x9f>
  2805fc:	8d 4f 01             	lea    0x1(%edi),%ecx
  {
      if(*format!='%')
  2805ff:	3c 25                	cmp    $0x25,%al
      {
	*str++=*format++;
  280601:	89 4d 0c             	mov    %ecx,0xc(%ebp)
   int *var=(int *)(&format)+1; //得到第一个可变参数的地址
   char buffer[10];
   char *buf=buffer;
  while(*format)
  {
      if(*format!='%')
  280604:	74 05                	je     28060b <sprintf+0x2b>
      {
	*str++=*format++;
  280606:	88 03                	mov    %al,(%ebx)
  280608:	43                   	inc    %ebx
	continue;
  280609:	eb e4                	jmp    2805ef <sprintf+0xf>
      }
      else
      {
	format++;
	switch (*format)
  28060b:	8a 47 01             	mov    0x1(%edi),%al
  28060e:	3c 73                	cmp    $0x73,%al
  280610:	74 46                	je     280658 <sprintf+0x78>
  280612:	3c 78                	cmp    $0x78,%al
  280614:	74 23                	je     280639 <sprintf+0x59>
  280616:	3c 64                	cmp    $0x64,%al
  280618:	75 53                	jne    28066d <sprintf+0x8d>
	{
	  case 'd':itoa(*var,buf);while(*buf){*str++=*buf++;};break;
  28061a:	8d 45 ea             	lea    -0x16(%ebp),%eax
  28061d:	50                   	push   %eax
  28061e:	ff 36                	pushl  (%esi)
  280620:	e8 f7 fe ff ff       	call   28051c <itoa>
  280625:	59                   	pop    %ecx
  280626:	8d 4d ea             	lea    -0x16(%ebp),%ecx
  280629:	58                   	pop    %eax
  28062a:	89 d8                	mov    %ebx,%eax
  28062c:	8a 19                	mov    (%ecx),%bl
  28062e:	84 db                	test   %bl,%bl
  280630:	74 3d                	je     28066f <sprintf+0x8f>
  280632:	40                   	inc    %eax
  280633:	41                   	inc    %ecx
  280634:	88 58 ff             	mov    %bl,-0x1(%eax)
  280637:	eb f3                	jmp    28062c <sprintf+0x4c>
	  case 'x':xtoa(*var,buf);while(*buf){*str++=*buf++;};break;
  280639:	8d 45 ea             	lea    -0x16(%ebp),%eax
  28063c:	50                   	push   %eax
  28063d:	ff 36                	pushl  (%esi)
  28063f:	e8 3a ff ff ff       	call   28057e <xtoa>
  280644:	8d 4d ea             	lea    -0x16(%ebp),%ecx
  280647:	58                   	pop    %eax
  280648:	89 d8                	mov    %ebx,%eax
  28064a:	5a                   	pop    %edx
  28064b:	8a 19                	mov    (%ecx),%bl
  28064d:	84 db                	test   %bl,%bl
  28064f:	74 1e                	je     28066f <sprintf+0x8f>
  280651:	40                   	inc    %eax
  280652:	41                   	inc    %ecx
  280653:	88 58 ff             	mov    %bl,-0x1(%eax)
  280656:	eb f3                	jmp    28064b <sprintf+0x6b>
	  case 's':buf=(char*)(*var);while(*buf){*str++=*buf++;};break;
  280658:	8b 16                	mov    (%esi),%edx
  28065a:	89 d8                	mov    %ebx,%eax
  28065c:	89 c1                	mov    %eax,%ecx
  28065e:	29 d9                	sub    %ebx,%ecx
  280660:	8a 0c 11             	mov    (%ecx,%edx,1),%cl
  280663:	84 c9                	test   %cl,%cl
  280665:	74 08                	je     28066f <sprintf+0x8f>
  280667:	40                   	inc    %eax
  280668:	88 48 ff             	mov    %cl,-0x1(%eax)
  28066b:	eb ef                	jmp    28065c <sprintf+0x7c>
	continue;
      }
      else
      {
	format++;
	switch (*format)
  28066d:	89 d8                	mov    %ebx,%eax
	  case 's':buf=(char*)(*var);while(*buf){*str++=*buf++;};break;
	  
	}
	buf=buffer;
	var++;
	format++;
  28066f:	83 c7 02             	add    $0x2,%edi
	  case 'x':xtoa(*var,buf);while(*buf){*str++=*buf++;};break;
	  case 's':buf=(char*)(*var);while(*buf){*str++=*buf++;};break;
	  
	}
	buf=buffer;
	var++;
  280672:	83 c6 04             	add    $0x4,%esi
	format++;
  280675:	89 7d 0c             	mov    %edi,0xc(%ebp)
  280678:	89 c3                	mov    %eax,%ebx
  28067a:	e9 70 ff ff ff       	jmp    2805ef <sprintf+0xf>
	
      }
    
  }
  *str='\0';
  28067f:	c6 03 00             	movb   $0x0,(%ebx)
  
}
  280682:	8d 65 f4             	lea    -0xc(%ebp),%esp
  280685:	5b                   	pop    %ebx
  280686:	5e                   	pop    %esi
  280687:	5f                   	pop    %edi
  280688:	5d                   	pop    %ebp
  280689:	c3                   	ret    

0028068a <putfont8>:
}
  
}

void putfont8(char *vram ,int xsize,int x,int y,char color,char *font)//x=0 311 y=0 183
{
  28068a:	55                   	push   %ebp
  28068b:	89 e5                	mov    %esp,%ebp
  28068d:	57                   	push   %edi
  28068e:	56                   	push   %esi
  28068f:	53                   	push   %ebx
  280690:	83 ec 05             	sub    $0x5,%esp
  280693:	8b 55 14             	mov    0x14(%ebp),%edx
  280696:	8b 45 10             	mov    0x10(%ebp),%eax
  280699:	8a 5d 18             	mov    0x18(%ebp),%bl
  28069c:	0f af 55 0c          	imul   0xc(%ebp),%edx
  2806a0:	03 45 08             	add    0x8(%ebp),%eax
  2806a3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  2806aa:	88 5d ef             	mov    %bl,-0x11(%ebp)
  2806ad:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  int row,col;
  char d;
  for(row=0;row<16;row++)
  2806b0:	31 c0                	xor    %eax,%eax
  2806b2:	8b 75 f0             	mov    -0x10(%ebp),%esi
  {
    d=font[row];
    for(col=0;col<8;col++)
  2806b5:	31 c9                	xor    %ecx,%ecx
  2806b7:	8d 1c 3e             	lea    (%esi,%edi,1),%ebx
    {
      if(d&(0x80>>col))
  2806ba:	8b 75 1c             	mov    0x1c(%ebp),%esi
  2806bd:	0f be 34 06          	movsbl (%esi,%eax,1),%esi
  2806c1:	ba 80 00 00 00       	mov    $0x80,%edx
  2806c6:	d3 fa                	sar    %cl,%edx
  2806c8:	85 f2                	test   %esi,%edx
  2806ca:	74 06                	je     2806d2 <putfont8+0x48>
      {
	vram[(y+row)*xsize+x+col]=color;
  2806cc:	8a 55 ef             	mov    -0x11(%ebp),%dl
  2806cf:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  int row,col;
  char d;
  for(row=0;row<16;row++)
  {
    d=font[row];
    for(col=0;col<8;col++)
  2806d2:	41                   	inc    %ecx
  2806d3:	83 f9 08             	cmp    $0x8,%ecx
  2806d6:	75 e9                	jne    2806c1 <putfont8+0x37>

void putfont8(char *vram ,int xsize,int x,int y,char color,char *font)//x=0 311 y=0 183
{
  int row,col;
  char d;
  for(row=0;row<16;row++)
  2806d8:	40                   	inc    %eax
  2806d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  2806dc:	01 5d f0             	add    %ebx,-0x10(%ebp)
  2806df:	83 f8 10             	cmp    $0x10,%eax
  2806e2:	75 ce                	jne    2806b2 <putfont8+0x28>
    }
    
  }
  return;
  
}
  2806e4:	83 c4 05             	add    $0x5,%esp
  2806e7:	5b                   	pop    %ebx
  2806e8:	5e                   	pop    %esi
  2806e9:	5f                   	pop    %edi
  2806ea:	5d                   	pop    %ebp
  2806eb:	c3                   	ret    

002806ec <puts8>:
  *str='\0';
  
}

void puts8(char *vram ,int xsize,int x,int y,char color,char *font)//x=0 311 y=0 183
{
  2806ec:	55                   	push   %ebp
  2806ed:	89 e5                	mov    %esp,%ebp
  2806ef:	57                   	push   %edi
  2806f0:	8b 7d 14             	mov    0x14(%ebp),%edi
  2806f3:	56                   	push   %esi
      y=y+16;
      
    }
    else
    {  
    putfont8((char *)vram ,xsize,x,y,color,(char *)(Font8x16+(*font)*16));
  2806f4:	0f be 75 18          	movsbl 0x18(%ebp),%esi
  *str='\0';
  
}

void puts8(char *vram ,int xsize,int x,int y,char color,char *font)//x=0 311 y=0 183
{
  2806f8:	53                   	push   %ebx
  2806f9:	8b 5d 10             	mov    0x10(%ebp),%ebx
  
 while(*font)
  2806fc:	8b 45 1c             	mov    0x1c(%ebp),%eax
  2806ff:	0f be 00             	movsbl (%eax),%eax
  280702:	84 c0                	test   %al,%al
  280704:	74 42                	je     280748 <puts8+0x5c>
 {
    if(*font=='\n')
  280706:	3c 0a                	cmp    $0xa,%al
  280708:	75 05                	jne    28070f <puts8+0x23>
    {
      x=0;
      y=y+16;
  28070a:	83 c7 10             	add    $0x10,%edi
  28070d:	eb 32                	jmp    280741 <puts8+0x55>
      
    }
    else
    {  
    putfont8((char *)vram ,xsize,x,y,color,(char *)(Font8x16+(*font)*16));
  28070f:	c1 e0 04             	shl    $0x4,%eax
  280712:	05 d8 0b 28 00       	add    $0x280bd8,%eax
  280717:	50                   	push   %eax
  280718:	56                   	push   %esi
  280719:	57                   	push   %edi
  28071a:	53                   	push   %ebx
    x+=8;
  28071b:	83 c3 08             	add    $0x8,%ebx
      y=y+16;
      
    }
    else
    {  
    putfont8((char *)vram ,xsize,x,y,color,(char *)(Font8x16+(*font)*16));
  28071e:	ff 75 0c             	pushl  0xc(%ebp)
  280721:	ff 75 08             	pushl  0x8(%ebp)
  280724:	e8 61 ff ff ff       	call   28068a <putfont8>
    x+=8;
    if(x>312)
  280729:	83 c4 18             	add    $0x18,%esp
  28072c:	81 fb 38 01 00 00    	cmp    $0x138,%ebx
  280732:	7e 0f                	jle    280743 <puts8+0x57>
       {
	  x=0;
	  y+=16;
  280734:	83 c7 10             	add    $0x10,%edi
	  if(y>183)
  280737:	81 ff b7 00 00 00    	cmp    $0xb7,%edi
  28073d:	7e 02                	jle    280741 <puts8+0x55>
	  {
	    x=0;
	    y=0;
  28073f:	31 ff                	xor    %edi,%edi
       {
	  x=0;
	  y+=16;
	  if(y>183)
	  {
	    x=0;
  280741:	31 db                	xor    %ebx,%ebx
	    
	  }
        }    
    }
    
    font++;
  280743:	ff 45 1c             	incl   0x1c(%ebp)
  280746:	eb b4                	jmp    2806fc <puts8+0x10>
}
  
}
  280748:	8d 65 f4             	lea    -0xc(%ebp),%esp
  28074b:	5b                   	pop    %ebx
  28074c:	5e                   	pop    %esi
  28074d:	5f                   	pop    %edi
  28074e:	5d                   	pop    %ebp
  28074f:	c3                   	ret    

00280750 <printdebug>:
#include "header.h"


void printdebug(int i,int x)
{
  280750:	55                   	push   %ebp
  280751:	89 e5                	mov    %esp,%ebp
  280753:	53                   	push   %ebx
  280754:	83 ec 20             	sub    $0x20,%esp
char font[30];
sprintf(font,"Debug:var=%x" ,i);
  280757:	ff 75 08             	pushl  0x8(%ebp)
  28075a:	8d 5d de             	lea    -0x22(%ebp),%ebx
  28075d:	68 d8 26 28 00       	push   $0x2826d8
  280762:	53                   	push   %ebx
  280763:	e8 78 fe ff ff       	call   2805e0 <sprintf>
puts8((char *)VRAM ,320,x,150,1,font);
  280768:	53                   	push   %ebx
  280769:	6a 01                	push   $0x1
  28076b:	68 96 00 00 00       	push   $0x96
  280770:	ff 75 0c             	pushl  0xc(%ebp)
  280773:	68 40 01 00 00       	push   $0x140
  280778:	68 00 00 0a 00       	push   $0xa0000
  28077d:	e8 6a ff ff ff       	call   2806ec <puts8>
  280782:	83 c4 24             	add    $0x24,%esp

}
  280785:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  280788:	c9                   	leave  
  280789:	c3                   	ret    

0028078a <putfont16>:
      
  }
  
}
void putfont16(char *vram ,int xsize,int x,int y,char color,unsigned short *font)//x=0 311 y=0 183
{
  28078a:	55                   	push   %ebp
  int row,col;
  unsigned short  d;
  unsigned short *pt=(unsigned short *)(font-32*24);
  for(row=0;row<24;row++)
  28078b:	31 c9                	xor    %ecx,%ecx
      
  }
  
}
void putfont16(char *vram ,int xsize,int x,int y,char color,unsigned short *font)//x=0 311 y=0 183
{
  28078d:	89 e5                	mov    %esp,%ebp
  28078f:	8b 45 14             	mov    0x14(%ebp),%eax
  280792:	56                   	push   %esi
  280793:	53                   	push   %ebx
  280794:	8a 5d 18             	mov    0x18(%ebp),%bl
  280797:	0f af 45 0c          	imul   0xc(%ebp),%eax
  28079b:	03 45 10             	add    0x10(%ebp),%eax
  28079e:	03 45 08             	add    0x8(%ebp),%eax
  for(row=0;row<24;row++)
  {
    d=pt[row];
    for(col=0;col<16;col++)
    {
       if( (d&(1 << col) ))
  2807a1:	8b 75 1c             	mov    0x1c(%ebp),%esi
  unsigned short  d;
  unsigned short *pt=(unsigned short *)(font-32*24);
  for(row=0;row<24;row++)
  {
    d=pt[row];
    for(col=0;col<16;col++)
  2807a4:	31 d2                	xor    %edx,%edx
    {
       if( (d&(1 << col) ))
  2807a6:	0f b7 b4 4e 00 fa ff 	movzwl -0x600(%esi,%ecx,2),%esi
  2807ad:	ff 
  2807ae:	0f a3 d6             	bt     %edx,%esi
  2807b1:	73 03                	jae    2807b6 <putfont16+0x2c>
     // if((d<<col)&0x0001)
      {
	vram[(y+row)*xsize+x+col]=color;
  2807b3:	88 1c 10             	mov    %bl,(%eax,%edx,1)
  unsigned short  d;
  unsigned short *pt=(unsigned short *)(font-32*24);
  for(row=0;row<24;row++)
  {
    d=pt[row];
    for(col=0;col<16;col++)
  2807b6:	42                   	inc    %edx
  2807b7:	83 fa 10             	cmp    $0x10,%edx
  2807ba:	75 f2                	jne    2807ae <putfont16+0x24>
void putfont16(char *vram ,int xsize,int x,int y,char color,unsigned short *font)//x=0 311 y=0 183
{
  int row,col;
  unsigned short  d;
  unsigned short *pt=(unsigned short *)(font-32*24);
  for(row=0;row<24;row++)
  2807bc:	41                   	inc    %ecx
  2807bd:	03 45 0c             	add    0xc(%ebp),%eax
  2807c0:	83 f9 18             	cmp    $0x18,%ecx
  2807c3:	75 dc                	jne    2807a1 <putfont16+0x17>
    }
    
  }
  return;
  
}
  2807c5:	5b                   	pop    %ebx
  2807c6:	5e                   	pop    %esi
  2807c7:	5d                   	pop    %ebp
  2807c8:	c3                   	ret    

002807c9 <puts16>:
  return;
  
}
//print string: big string
void puts16(char *vram ,int xsize,int x,int y,char color,char *font)
{
  2807c9:	55                   	push   %ebp
  2807ca:	89 e5                	mov    %esp,%ebp
  2807cc:	57                   	push   %edi
  2807cd:	8b 7d 10             	mov    0x10(%ebp),%edi
  2807d0:	56                   	push   %esi
  2807d1:	8b 75 14             	mov    0x14(%ebp),%esi
  2807d4:	53                   	push   %ebx
      
    }
    else
    {
	pt=(unsigned short *)((*font)*24+ASCII_Table);
	putfont16(vram ,xsize,x,y,color,pt);
  2807d5:	0f be 5d 18          	movsbl 0x18(%ebp),%ebx
}
//print string: big string
void puts16(char *vram ,int xsize,int x,int y,char color,char *font)
{
  unsigned short  *pt;
  while(*font)
  2807d9:	8b 45 1c             	mov    0x1c(%ebp),%eax
  2807dc:	0f be 00             	movsbl (%eax),%eax
  2807df:	84 c0                	test   %al,%al
  2807e1:	74 2d                	je     280810 <puts16+0x47>
  {
    if(*font=='\n')
  2807e3:	3c 0a                	cmp    $0xa,%al
  2807e5:	75 07                	jne    2807ee <puts16+0x25>
    {
      x=0;
      y=y+24;
  2807e7:	83 c6 18             	add    $0x18,%esi
  unsigned short  *pt;
  while(*font)
  {
    if(*font=='\n')
    {
      x=0;
  2807ea:	31 ff                	xor    %edi,%edi
  2807ec:	eb 1d                	jmp    28080b <puts16+0x42>
      y=y+24;
      
    }
    else
    {
	pt=(unsigned short *)((*font)*24+ASCII_Table);
  2807ee:	6b c0 30             	imul   $0x30,%eax,%eax
  2807f1:	05 d8 13 28 00       	add    $0x2813d8,%eax
	putfont16(vram ,xsize,x,y,color,pt);
  2807f6:	50                   	push   %eax
  2807f7:	53                   	push   %ebx
  2807f8:	56                   	push   %esi
  2807f9:	57                   	push   %edi
	x=x+16;
  2807fa:	83 c7 10             	add    $0x10,%edi
      
    }
    else
    {
	pt=(unsigned short *)((*font)*24+ASCII_Table);
	putfont16(vram ,xsize,x,y,color,pt);
  2807fd:	ff 75 0c             	pushl  0xc(%ebp)
  280800:	ff 75 08             	pushl  0x8(%ebp)
  280803:	e8 82 ff ff ff       	call   28078a <putfont16>
	x=x+16;
  280808:	83 c4 18             	add    $0x18,%esp
	   
	   
    }
    
     font++;
  28080b:	ff 45 1c             	incl   0x1c(%ebp)
  28080e:	eb c9                	jmp    2807d9 <puts16+0x10>
      
  }
  
}
  280810:	8d 65 f4             	lea    -0xc(%ebp),%esp
  280813:	5b                   	pop    %ebx
  280814:	5e                   	pop    %esi
  280815:	5f                   	pop    %edi
  280816:	5d                   	pop    %ebp
  280817:	c3                   	ret    

00280818 <setgdt>:
#include"header.h"



void setgdt(struct GDT *sd ,unsigned int limit,int base,int access)//sd: selector describe
{
  280818:	55                   	push   %ebp
  280819:	89 e5                	mov    %esp,%ebp
  28081b:	8b 55 0c             	mov    0xc(%ebp),%edx
  28081e:	57                   	push   %edi
  28081f:	8b 45 08             	mov    0x8(%ebp),%eax
  280822:	56                   	push   %esi
  280823:	8b 7d 14             	mov    0x14(%ebp),%edi
  280826:	53                   	push   %ebx
  280827:	8b 5d 10             	mov    0x10(%ebp),%ebx
  if(limit>0xffff)
  28082a:	81 fa ff ff 00 00    	cmp    $0xffff,%edx
  280830:	76 09                	jbe    28083b <setgdt+0x23>
  {
    access|=0x8000;
  280832:	81 cf 00 80 00 00    	or     $0x8000,%edi
    limit /=0x1000;
  280838:	c1 ea 0c             	shr    $0xc,%edx
  }
  sd->limit_low=limit&0xffff;
  sd->base_low=base &0xffff;
  sd->base_mid=(base>>16)&0xff;
  28083b:	89 de                	mov    %ebx,%esi
  28083d:	c1 fe 10             	sar    $0x10,%esi
  280840:	89 f1                	mov    %esi,%ecx
  280842:	88 48 04             	mov    %cl,0x4(%eax)
  sd->access_right=access&0xff;
  280845:	89 f9                	mov    %edi,%ecx
  sd->limit_high=((limit>>16)&0x0f)|((access>>8)&0xf0);//低４位是limt的高位，高４位是访问的权限设置。
  280847:	c1 ff 08             	sar    $0x8,%edi
    limit /=0x1000;
  }
  sd->limit_low=limit&0xffff;
  sd->base_low=base &0xffff;
  sd->base_mid=(base>>16)&0xff;
  sd->access_right=access&0xff;
  28084a:	88 48 05             	mov    %cl,0x5(%eax)
  sd->limit_high=((limit>>16)&0x0f)|((access>>8)&0xf0);//低４位是limt的高位，高４位是访问的权限设置。
  28084d:	89 f9                	mov    %edi,%ecx
  if(limit>0xffff)
  {
    access|=0x8000;
    limit /=0x1000;
  }
  sd->limit_low=limit&0xffff;
  28084f:	66 89 10             	mov    %dx,(%eax)
  sd->base_low=base &0xffff;
  sd->base_mid=(base>>16)&0xff;
  sd->access_right=access&0xff;
  sd->limit_high=((limit>>16)&0x0f)|((access>>8)&0xf0);//低４位是limt的高位，高４位是访问的权限设置。
  280852:	83 e1 f0             	and    $0xfffffff0,%ecx
  280855:	c1 ea 10             	shr    $0x10,%edx
  {
    access|=0x8000;
    limit /=0x1000;
  }
  sd->limit_low=limit&0xffff;
  sd->base_low=base &0xffff;
  280858:	66 89 58 02          	mov    %bx,0x2(%eax)
  sd->base_mid=(base>>16)&0xff;
  sd->access_right=access&0xff;
  sd->limit_high=((limit>>16)&0x0f)|((access>>8)&0xf0);//低４位是limt的高位，高４位是访问的权限设置。
  28085c:	09 d1                	or     %edx,%ecx
  sd->base_high=(base>>24)&0xff;
  28085e:	c1 eb 18             	shr    $0x18,%ebx
  }
  sd->limit_low=limit&0xffff;
  sd->base_low=base &0xffff;
  sd->base_mid=(base>>16)&0xff;
  sd->access_right=access&0xff;
  sd->limit_high=((limit>>16)&0x0f)|((access>>8)&0xf0);//低４位是limt的高位，高４位是访问的权限设置。
  280861:	88 48 06             	mov    %cl,0x6(%eax)
  sd->base_high=(base>>24)&0xff;
  280864:	88 58 07             	mov    %bl,0x7(%eax)
  
}
  280867:	5b                   	pop    %ebx
  280868:	5e                   	pop    %esi
  280869:	5f                   	pop    %edi
  28086a:	5d                   	pop    %ebp
  28086b:	c3                   	ret    

0028086c <setidt>:

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
  28086c:	55                   	push   %ebp
  28086d:	89 e5                	mov    %esp,%ebp
  28086f:	8b 45 08             	mov    0x8(%ebp),%eax
  280872:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  280875:	8b 55 14             	mov    0x14(%ebp),%edx
  //idt中有32位的offset address
  gd->offset_low=offset & 0xffff;
  280878:	66 89 08             	mov    %cx,(%eax)
  gd->offset_high=(offset>>16)&0xffff;
  28087b:	c1 e9 10             	shr    $0x10,%ecx
  28087e:	66 89 48 06          	mov    %cx,0x6(%eax)
  
  //16位的selector决定了base address
  gd->selector=selector;
  280882:	8b 4d 10             	mov    0x10(%ebp),%ecx
  
  gd->dw_count=(access>>8)&0xff;
  gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的
  280885:	88 50 05             	mov    %dl,0x5(%eax)
  //idt中有32位的offset address
  gd->offset_low=offset & 0xffff;
  gd->offset_high=(offset>>16)&0xffff;
  
  //16位的selector决定了base address
  gd->selector=selector;
  280888:	66 89 48 02          	mov    %cx,0x2(%eax)
  
  gd->dw_count=(access>>8)&0xff;
  28088c:	89 d1                	mov    %edx,%ecx
  28088e:	c1 f9 08             	sar    $0x8,%ecx
  280891:	88 48 04             	mov    %cl,0x4(%eax)
  gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的
  
  
}
  280894:	5d                   	pop    %ebp
  280895:	c3                   	ret    

00280896 <init_gdtidt>:



void  init_gdtidt()
{
  280896:	55                   	push   %ebp
  280897:	89 e5                	mov    %esp,%ebp
  280899:	53                   	push   %ebx
  28089a:	53                   	push   %ebx
  28089b:	bb 00 00 27 00       	mov    $0x270000,%ebx
  struct GDT *gdt=(struct GDT *)(0x00270000);
  struct IDT *idt=(struct IDT *)(0x0026f800);
  int i;
  for(i=0;i<8192;i++)
  {
    setgdt(gdt+i,0,0,0);
  2808a0:	6a 00                	push   $0x0
  2808a2:	6a 00                	push   $0x0
  2808a4:	6a 00                	push   $0x0
  2808a6:	53                   	push   %ebx
  2808a7:	83 c3 08             	add    $0x8,%ebx
  2808aa:	e8 69 ff ff ff       	call   280818 <setgdt>
void  init_gdtidt()
{
  struct GDT *gdt=(struct GDT *)(0x00270000);
  struct IDT *idt=(struct IDT *)(0x0026f800);
  int i;
  for(i=0;i<8192;i++)
  2808af:	83 c4 10             	add    $0x10,%esp
  2808b2:	81 fb 00 00 28 00    	cmp    $0x280000,%ebx
  2808b8:	75 e6                	jne    2808a0 <init_gdtidt+0xa>
  {
    setgdt(gdt+i,0,0,0);
  }
  setgdt(gdt+1,0xffffffff   ,0x00000000,0x4092);//entry.s main.c data 4GB空间的数据都能访问
  2808ba:	68 92 40 00 00       	push   $0x4092
  2808bf:	6a 00                	push   $0x0
  2808c1:	6a ff                	push   $0xffffffff
  2808c3:	68 08 00 27 00       	push   $0x270008
  2808c8:	e8 4b ff ff ff       	call   280818 <setgdt>
  setgdt(gdt+2,0x000fffff   ,0x00000000,0x409a);//entry.S code
  2808cd:	68 9a 40 00 00       	push   $0x409a
  2808d2:	6a 00                	push   $0x0
  2808d4:	68 ff ff 0f 00       	push   $0xfffff
  2808d9:	68 10 00 27 00       	push   $0x270010
  2808de:	e8 35 ff ff ff       	call   280818 <setgdt>
  setgdt(gdt+3,0x000fffff   ,0x00280000,0x409a);  //main.c code　 0x7ffff=512kB
  2808e3:	83 c4 20             	add    $0x20,%esp
  2808e6:	68 9a 40 00 00       	push   $0x409a
  2808eb:	68 00 00 28 00       	push   $0x280000
  2808f0:	68 ff ff 0f 00       	push   $0xfffff
  2808f5:	68 18 00 27 00       	push   $0x270018
  2808fa:	e8 19 ff ff ff       	call   280818 <setgdt>

   load_gdtr(0xfff,0X00270000);//this is right
  2808ff:	5a                   	pop    %edx
  280900:	59                   	pop    %ecx
  280901:	68 00 00 27 00       	push   $0x270000
  280906:	68 ff 0f 00 00       	push   $0xfff
  28090b:	e8 f9 01 00 00       	call   280b09 <load_gdtr>
  280910:	83 c4 10             	add    $0x10,%esp
  280913:	31 c0                	xor    %eax,%eax
}

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
  //idt中有32位的offset address
  gd->offset_low=offset & 0xffff;
  280915:	66 c7 80 00 f8 26 00 	movw   $0x0,0x26f800(%eax)
  28091c:	00 00 
  28091e:	83 c0 08             	add    $0x8,%eax
  gd->offset_high=(offset>>16)&0xffff;
  280921:	66 c7 80 fe f7 26 00 	movw   $0x0,0x26f7fe(%eax)
  280928:	00 00 
  
  //16位的selector决定了base address
  gd->selector=selector;
  28092a:	66 c7 80 fa f7 26 00 	movw   $0x0,0x26f7fa(%eax)
  280931:	00 00 
  
  gd->dw_count=(access>>8)&0xff;
  280933:	c6 80 fc f7 26 00 00 	movb   $0x0,0x26f7fc(%eax)
  gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的
  28093a:	c6 80 fd f7 26 00 00 	movb   $0x0,0x26f7fd(%eax)
  setgdt(gdt+2,0x000fffff   ,0x00000000,0x409a);//entry.S code
  setgdt(gdt+3,0x000fffff   ,0x00280000,0x409a);  //main.c code　 0x7ffff=512kB

   load_gdtr(0xfff,0X00270000);//this is right

  for(i=0;i<256;i++)
  280941:	3d 00 08 00 00       	cmp    $0x800,%eax
  280946:	75 cd                	jne    280915 <init_gdtidt+0x7f>

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
  //idt中有32位的offset address
  gd->offset_low=offset & 0xffff;
  gd->offset_high=(offset>>16)&0xffff;
  280948:	ba b8 0a 28 00       	mov    $0x280ab8,%edx
  28094d:	66 31 c0             	xor    %ax,%ax
  280950:	c1 ea 10             	shr    $0x10,%edx
}

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
  //idt中有32位的offset address
  gd->offset_low=offset & 0xffff;
  280953:	b9 b8 0a 28 00       	mov    $0x280ab8,%ecx
  280958:	66 89 88 00 f8 26 00 	mov    %cx,0x26f800(%eax)
  28095f:	83 c0 08             	add    $0x8,%eax
  gd->offset_high=(offset>>16)&0xffff;
  280962:	66 89 90 fe f7 26 00 	mov    %dx,0x26f7fe(%eax)
  
  //16位的selector决定了base address
  gd->selector=selector;
  280969:	66 c7 80 fa f7 26 00 	movw   $0x18,0x26f7fa(%eax)
  280970:	18 00 
  
  gd->dw_count=(access>>8)&0xff;
  280972:	c6 80 fc f7 26 00 00 	movb   $0x0,0x26f7fc(%eax)
  gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的
  280979:	c6 80 fd f7 26 00 8e 	movb   $0x8e,0x26f7fd(%eax)
  for(i=0;i<256;i++)
  {
    setidt(idt+i,0,0,0);
  }
  
  for(i=0;i<256;i++)
  280980:	3d 00 08 00 00       	cmp    $0x800,%eax
  280985:	75 d1                	jne    280958 <init_gdtidt+0xc2>
  {
      setidt(idt+i,(int)asm_inthandler21,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了
    
  }
  setidt(idt+0x21,(int)asm_inthandler21-0x280000,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了
  280987:	b8 b8 0a 00 00       	mov    $0xab8,%eax
}

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
  //idt中有32位的offset address
  gd->offset_low=offset & 0xffff;
  28098c:	66 a3 08 f9 26 00    	mov    %ax,0x26f908
  gd->offset_high=(offset>>16)&0xffff;
  280992:	c1 e8 10             	shr    $0x10,%eax
  280995:	66 a3 0e f9 26 00    	mov    %ax,0x26f90e
  {
      setidt(idt+i,(int)asm_inthandler21,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了
    
  }
  setidt(idt+0x21,(int)asm_inthandler21-0x280000,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了
  setidt(idt+0x27,(int)asm_inthandler27-0x280000,3*8,0x008e);//
  28099b:	b8 d3 0a 00 00       	mov    $0xad3,%eax
}

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
  //idt中有32位的offset address
  gd->offset_low=offset & 0xffff;
  2809a0:	66 a3 38 f9 26 00    	mov    %ax,0x26f938
  gd->offset_high=(offset>>16)&0xffff;
  2809a6:	c1 e8 10             	shr    $0x10,%eax
  2809a9:	66 a3 3e f9 26 00    	mov    %ax,0x26f93e
      setidt(idt+i,(int)asm_inthandler21,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了
    
  }
  setidt(idt+0x21,(int)asm_inthandler21-0x280000,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了
  setidt(idt+0x27,(int)asm_inthandler27-0x280000,3*8,0x008e);//
  setidt(idt+0x2c,(int)asm_inthandler2c-0x280000,3*8,0x008e);
  2809af:	b8 ee 0a 00 00       	mov    $0xaee,%eax
}

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
  //idt中有32位的offset address
  gd->offset_low=offset & 0xffff;
  2809b4:	66 a3 60 f9 26 00    	mov    %ax,0x26f960
  gd->offset_high=(offset>>16)&0xffff;
  2809ba:	c1 e8 10             	shr    $0x10,%eax
  2809bd:	66 a3 66 f9 26 00    	mov    %ax,0x26f966
  
  //16位的selector决定了base address
  gd->selector=selector;
  2809c3:	66 c7 05 0a f9 26 00 	movw   $0x18,0x26f90a
  2809ca:	18 00 
  
  gd->dw_count=(access>>8)&0xff;
  2809cc:	c6 05 0c f9 26 00 00 	movb   $0x0,0x26f90c
  gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的
  2809d3:	c6 05 0d f9 26 00 8e 	movb   $0x8e,0x26f90d
  //idt中有32位的offset address
  gd->offset_low=offset & 0xffff;
  gd->offset_high=(offset>>16)&0xffff;
  
  //16位的selector决定了base address
  gd->selector=selector;
  2809da:	66 c7 05 3a f9 26 00 	movw   $0x18,0x26f93a
  2809e1:	18 00 
  
  gd->dw_count=(access>>8)&0xff;
  2809e3:	c6 05 3c f9 26 00 00 	movb   $0x0,0x26f93c
  gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的
  2809ea:	c6 05 3d f9 26 00 8e 	movb   $0x8e,0x26f93d
  //idt中有32位的offset address
  gd->offset_low=offset & 0xffff;
  gd->offset_high=(offset>>16)&0xffff;
  
  //16位的selector决定了base address
  gd->selector=selector;
  2809f1:	66 c7 05 62 f9 26 00 	movw   $0x18,0x26f962
  2809f8:	18 00 
  
  gd->dw_count=(access>>8)&0xff;
  2809fa:	c6 05 64 f9 26 00 00 	movb   $0x0,0x26f964
  gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的
  280a01:	c6 05 65 f9 26 00 8e 	movb   $0x8e,0x26f965
    
  }
  setidt(idt+0x21,(int)asm_inthandler21-0x280000,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了
  setidt(idt+0x27,(int)asm_inthandler27-0x280000,3*8,0x008e);//
  setidt(idt+0x2c,(int)asm_inthandler2c-0x280000,3*8,0x008e);
  load_idtr(0x7ff,0x0026f800);//this is right
  280a08:	50                   	push   %eax
  280a09:	50                   	push   %eax
  280a0a:	68 00 f8 26 00       	push   $0x26f800
  280a0f:	68 ff 07 00 00       	push   $0x7ff
  280a14:	e8 00 01 00 00       	call   280b19 <load_idtr>
  280a19:	83 c4 10             	add    $0x10,%esp

  return;

}
  280a1c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  280a1f:	c9                   	leave  
  280a20:	c3                   	ret    
  280a21:	66 90                	xchg   %ax,%ax
  280a23:	90                   	nop

00280a24 <init_pic>:
#include "header.h"

extern struct boot_info *bootp;
void init_pic()
{
  280a24:	55                   	push   %ebp
  280a25:	ba 21 00 00 00       	mov    $0x21,%edx
  280a2a:	89 e5                	mov    %esp,%ebp
  280a2c:	b0 ff                	mov    $0xff,%al
  280a2e:	ee                   	out    %al,(%dx)
  280a2f:	b2 a1                	mov    $0xa1,%dl
  280a31:	ee                   	out    %al,(%dx)
  280a32:	b0 11                	mov    $0x11,%al
  280a34:	b2 20                	mov    $0x20,%dl
  280a36:	ee                   	out    %al,(%dx)
  280a37:	b0 20                	mov    $0x20,%al
  280a39:	b2 21                	mov    $0x21,%dl
  280a3b:	ee                   	out    %al,(%dx)
  280a3c:	b0 04                	mov    $0x4,%al
  280a3e:	ee                   	out    %al,(%dx)
  280a3f:	b0 01                	mov    $0x1,%al
  280a41:	ee                   	out    %al,(%dx)
  280a42:	b0 11                	mov    $0x11,%al
  280a44:	b2 a0                	mov    $0xa0,%dl
  280a46:	ee                   	out    %al,(%dx)
  280a47:	b0 28                	mov    $0x28,%al
  280a49:	b2 a1                	mov    $0xa1,%dl
  280a4b:	ee                   	out    %al,(%dx)
  280a4c:	b0 02                	mov    $0x2,%al
  280a4e:	ee                   	out    %al,(%dx)
  280a4f:	b0 01                	mov    $0x1,%al
  280a51:	ee                   	out    %al,(%dx)
  280a52:	b0 fb                	mov    $0xfb,%al
  280a54:	b2 21                	mov    $0x21,%dl
  280a56:	ee                   	out    %al,(%dx)
  280a57:	b0 ff                	mov    $0xff,%al
  280a59:	b2 a1                	mov    $0xa1,%dl
  280a5b:	ee                   	out    %al,(%dx)
这是因为int 0x00-0x1f不能用于irq,因为这２０个Int是留给系统的，是给mi（not mask interrupt）用的。

所以cpu发现是产生了int 0到int0x1f时，就知道是非常重要的中断产生了，是不可mask的，一定要执行的。

   */
}
  280a5c:	5d                   	pop    %ebp
  280a5d:	c3                   	ret    

00280a5e <inthandler21>:
#define PORT_KEYDAT	0x0060
struct FIFO8 keyfifo;

//interrupt service procedure for keyboard
void inthandler21(int *esp)
{
  280a5e:	55                   	push   %ebp
  280a5f:	ba 20 00 00 00       	mov    $0x20,%edx
  280a64:	89 e5                	mov    %esp,%ebp
  280a66:	b0 61                	mov    $0x61,%al
  280a68:	83 ec 10             	sub    $0x10,%esp
  280a6b:	ee                   	out    %al,(%dx)
static __inline uint8_t
inb(int port)
{
  //read a byte from port
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  280a6c:	b2 60                	mov    $0x60,%dl
  280a6e:	ec                   	in     (%dx),%al
  unsigned char data;
  io_out8(PIC0_OCW2, 0x61);
  data=io_in8(PORT_KEYDAT);
  fifo8_put(&keyfifo, data);
  280a6f:	0f b6 c0             	movzbl %al,%eax
  280a72:	50                   	push   %eax
  280a73:	68 c4 2b 28 00       	push   $0x282bc4
  280a78:	e8 da 00 00 00       	call   280b57 <fifo8_put>
  280a7d:	83 c4 10             	add    $0x10,%esp
  return;  
}
  280a80:	c9                   	leave  
  280a81:	c3                   	ret    

00280a82 <inthandler2c>:

struct FIFO8 mousefifo;
void inthandler2c(int *esp)
{
  280a82:	55                   	push   %ebp
// out:write a data to a port
static __inline void
outb(int port, uint8_t data)
{
  //data是变量0%0 , port是变量word１%w1
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  280a83:	ba a0 00 00 00       	mov    $0xa0,%edx
  280a88:	89 e5                	mov    %esp,%ebp
  280a8a:	b0 64                	mov    $0x64,%al
  280a8c:	83 ec 10             	sub    $0x10,%esp
  280a8f:	ee                   	out    %al,(%dx)
  280a90:	b0 62                	mov    $0x62,%al
  280a92:	b2 20                	mov    $0x20,%dl
  280a94:	ee                   	out    %al,(%dx)
static __inline uint8_t
inb(int port)
{
  //read a byte from port
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  280a95:	b2 60                	mov    $0x60,%dl
  280a97:	ec                   	in     (%dx),%al
  unsigned char data;
  io_out8(PIC1_OCW2, 0x64);
  io_out8(PIC0_OCW2, 0x62);
  data=io_in8(PORT_KEYDAT);
  fifo8_put(&mousefifo, data);
  280a98:	0f b6 c0             	movzbl %al,%eax
  280a9b:	50                   	push   %eax
  280a9c:	68 dc 2b 28 00       	push   $0x282bdc
  280aa1:	e8 b1 00 00 00       	call   280b57 <fifo8_put>
  280aa6:	83 c4 10             	add    $0x10,%esp
  return;    
}
  280aa9:	c9                   	leave  
  280aaa:	c3                   	ret    

00280aab <inthandler27>:

void inthandler27(int *esp)
{
  280aab:	55                   	push   %ebp
// out:write a data to a port
static __inline void
outb(int port, uint8_t data)
{
  //data是变量0%0 , port是变量word１%w1
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  280aac:	ba 20 00 00 00       	mov    $0x20,%edx
  280ab1:	89 e5                	mov    %esp,%ebp
  280ab3:	b0 67                	mov    $0x67,%al
  280ab5:	ee                   	out    %al,(%dx)
  io_out8(PIC0_OCW2, 0x67);
  return;
}
  280ab6:	5d                   	pop    %ebp
  280ab7:	c3                   	ret    

00280ab8 <asm_inthandler21>:
.global load_gdtr 
.global load_idtr
.global io_stihlt
.code32
asm_inthandler21:
  pushw %es
  280ab8:	66 06                	pushw  %es
  pushw %ds
  280aba:	66 1e                	pushw  %ds
  pushal
  280abc:	60                   	pusha  
  movl %esp,%eax
  280abd:	89 e0                	mov    %esp,%eax
  pushl %eax
  280abf:	50                   	push   %eax
  movw %ss,%ax
  280ac0:	66 8c d0             	mov    %ss,%ax
  movw %ax,%ds
  280ac3:	8e d8                	mov    %eax,%ds
  movw %ax,%es
  280ac5:	8e c0                	mov    %eax,%es
  call inthandler21
  280ac7:	e8 92 ff ff ff       	call   280a5e <inthandler21>
  popl %eax
  280acc:	58                   	pop    %eax
  popal
  280acd:	61                   	popa   
  popw %ds
  280ace:	66 1f                	popw   %ds
  popW %es
  280ad0:	66 07                	popw   %es
  iret
  280ad2:	cf                   	iret   

00280ad3 <asm_inthandler27>:

asm_inthandler27:
  pushw %es
  280ad3:	66 06                	pushw  %es
  pushw %ds
  280ad5:	66 1e                	pushw  %ds
  pushal
  280ad7:	60                   	pusha  
  movl %esp,%eax
  280ad8:	89 e0                	mov    %esp,%eax
  pushl %eax
  280ada:	50                   	push   %eax
  movw %ss,%ax
  280adb:	66 8c d0             	mov    %ss,%ax
  movw %ax,%ds
  280ade:	8e d8                	mov    %eax,%ds
  movw %ax,%es
  280ae0:	8e c0                	mov    %eax,%es
  call inthandler27
  280ae2:	e8 c4 ff ff ff       	call   280aab <inthandler27>
  popl %eax
  280ae7:	58                   	pop    %eax
  popal
  280ae8:	61                   	popa   
  popw %ds
  280ae9:	66 1f                	popw   %ds
  popW %es
  280aeb:	66 07                	popw   %es
  iret
  280aed:	cf                   	iret   

00280aee <asm_inthandler2c>:

asm_inthandler2c:
  pushw %es
  280aee:	66 06                	pushw  %es
  pushw %ds
  280af0:	66 1e                	pushw  %ds
  pushal
  280af2:	60                   	pusha  
  movl %esp,%eax
  280af3:	89 e0                	mov    %esp,%eax
  pushl %eax
  280af5:	50                   	push   %eax
  movw %ss,%ax
  280af6:	66 8c d0             	mov    %ss,%ax
  movw %ax,%ds
  280af9:	8e d8                	mov    %eax,%ds
  movw %ax,%es
  280afb:	8e c0                	mov    %eax,%es
  call inthandler2c
  280afd:	e8 80 ff ff ff       	call   280a82 <inthandler2c>
  popl %eax
  280b02:	58                   	pop    %eax
  popal
  280b03:	61                   	popa   
  popw %ds
  280b04:	66 1f                	popw   %ds
  popW %es
  280b06:	66 07                	popw   %es
  iret
  280b08:	cf                   	iret   

00280b09 <load_gdtr>:

load_gdtr:		#; void load_gdtr(int limit, int addr);
  mov 4(%esp) ,%ax
  280b09:	66 8b 44 24 04       	mov    0x4(%esp),%ax
  mov %ax,6(%esp)
  280b0e:	66 89 44 24 06       	mov    %ax,0x6(%esp)
  lgdt 6(%esp)
  280b13:	0f 01 54 24 06       	lgdtl  0x6(%esp)
  ret
  280b18:	c3                   	ret    

00280b19 <load_idtr>:

load_idtr:		#; void load_idtr(int limit, int addr);
  mov 4(%esp) ,%ax
  280b19:	66 8b 44 24 04       	mov    0x4(%esp),%ax
  mov %ax,6(%esp)
  280b1e:	66 89 44 24 06       	mov    %ax,0x6(%esp)
  lidt 6(%esp)
  280b23:	0f 01 5c 24 06       	lidtl  0x6(%esp)
  ret
  280b28:	c3                   	ret    

00280b29 <io_stihlt>:

io_stihlt:
  sti
  280b29:	fb                   	sti    
  hlt
  280b2a:	f4                   	hlt    
  ret
  280b2b:	c3                   	ret    

00280b2c <fifo8_init>:
#include "header.h"

#define FLAGS_OVERRUN		0x0001

void fifo8_init(struct FIFO8 *fifo, int size, unsigned char *buf)
{
  280b2c:	55                   	push   %ebp
  280b2d:	89 e5                	mov    %esp,%ebp
  280b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  280b32:	8b 55 0c             	mov    0xc(%ebp),%edx
	fifo->size = size;
	fifo->buf = buf;
  280b35:	8b 4d 10             	mov    0x10(%ebp),%ecx
	fifo->free = size; 
	fifo->flags = 0;
  280b38:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

#define FLAGS_OVERRUN		0x0001

void fifo8_init(struct FIFO8 *fifo, int size, unsigned char *buf)
{
	fifo->size = size;
  280b3f:	89 50 0c             	mov    %edx,0xc(%eax)
	fifo->buf = buf;
  280b42:	89 08                	mov    %ecx,(%eax)
	fifo->free = size; 
  280b44:	89 50 10             	mov    %edx,0x10(%eax)
	fifo->flags = 0;
	fifo->p = 0; /* next write */
  280b47:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	fifo->q = 0; /* next read */
  280b4e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	return;
}
  280b55:	5d                   	pop    %ebp
  280b56:	c3                   	ret    

00280b57 <fifo8_put>:

int fifo8_put(struct FIFO8 *fifo, unsigned char data)
{
  280b57:	55                   	push   %ebp
  280b58:	89 e5                	mov    %esp,%ebp
  280b5a:	8b 45 08             	mov    0x8(%ebp),%eax
  280b5d:	53                   	push   %ebx
  280b5e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	if (fifo->free == 0) {
  280b61:	83 78 10 00          	cmpl   $0x0,0x10(%eax)
  280b65:	75 09                	jne    280b70 <fifo8_put+0x19>
		/* no free space */
		fifo->flags |= FLAGS_OVERRUN;
  280b67:	83 48 14 01          	orl    $0x1,0x14(%eax)
		return -1;
  280b6b:	83 c8 ff             	or     $0xffffffff,%eax
  280b6e:	eb 22                	jmp    280b92 <fifo8_put+0x3b>
	}
	fifo->buf[fifo->p] = data;
  280b70:	8b 50 04             	mov    0x4(%eax),%edx
  280b73:	8b 08                	mov    (%eax),%ecx
  280b75:	88 1c 11             	mov    %bl,(%ecx,%edx,1)
	fifo->p++;
  280b78:	8b 48 04             	mov    0x4(%eax),%ecx
  280b7b:	8d 51 01             	lea    0x1(%ecx),%edx
	if (fifo->p == fifo->size) {
  280b7e:	3b 50 0c             	cmp    0xc(%eax),%edx
		/* no free space */
		fifo->flags |= FLAGS_OVERRUN;
		return -1;
	}
	fifo->buf[fifo->p] = data;
	fifo->p++;
  280b81:	89 50 04             	mov    %edx,0x4(%eax)
	if (fifo->p == fifo->size) {
  280b84:	75 07                	jne    280b8d <fifo8_put+0x36>
		fifo->p = 0;
  280b86:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	}
	fifo->free--;
  280b8d:	ff 48 10             	decl   0x10(%eax)
	return 0;
  280b90:	31 c0                	xor    %eax,%eax
}
  280b92:	5b                   	pop    %ebx
  280b93:	5d                   	pop    %ebp
  280b94:	c3                   	ret    

00280b95 <fifo8_get>:

int fifo8_get(struct FIFO8 *fifo)
{
  280b95:	55                   	push   %ebp
  280b96:	89 e5                	mov    %esp,%ebp
  280b98:	8b 55 08             	mov    0x8(%ebp),%edx
  280b9b:	57                   	push   %edi
  280b9c:	56                   	push   %esi
  280b9d:	53                   	push   %ebx
	int data;
	if (fifo->free == fifo->size) {
  280b9e:	8b 5a 10             	mov    0x10(%edx),%ebx
  280ba1:	8b 7a 0c             	mov    0xc(%edx),%edi
  280ba4:	39 fb                	cmp    %edi,%ebx
  280ba6:	74 1a                	je     280bc2 <fifo8_get+0x2d>
		/* if buffer empty, return -1 */
		return -1;
	}
	data = fifo->buf[fifo->q];
  280ba8:	8b 72 08             	mov    0x8(%edx),%esi
	fifo->q++;
  280bab:	31 c9                	xor    %ecx,%ecx
	int data;
	if (fifo->free == fifo->size) {
		/* if buffer empty, return -1 */
		return -1;
	}
	data = fifo->buf[fifo->q];
  280bad:	8b 02                	mov    (%edx),%eax
  280baf:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
	fifo->q++;
  280bb3:	46                   	inc    %esi
  280bb4:	39 fe                	cmp    %edi,%esi
  280bb6:	0f 45 ce             	cmovne %esi,%ecx
	if (fifo->q == fifo->size) {
		fifo->q = 0;
	}
	fifo->free++;
  280bb9:	43                   	inc    %ebx
	if (fifo->free == fifo->size) {
		/* if buffer empty, return -1 */
		return -1;
	}
	data = fifo->buf[fifo->q];
	fifo->q++;
  280bba:	89 4a 08             	mov    %ecx,0x8(%edx)
	if (fifo->q == fifo->size) {
		fifo->q = 0;
	}
	fifo->free++;
  280bbd:	89 5a 10             	mov    %ebx,0x10(%edx)
	return data;
  280bc0:	eb 03                	jmp    280bc5 <fifo8_get+0x30>
int fifo8_get(struct FIFO8 *fifo)
{
	int data;
	if (fifo->free == fifo->size) {
		/* if buffer empty, return -1 */
		return -1;
  280bc2:	83 c8 ff             	or     $0xffffffff,%eax
	if (fifo->q == fifo->size) {
		fifo->q = 0;
	}
	fifo->free++;
	return data;
}
  280bc5:	5b                   	pop    %ebx
  280bc6:	5e                   	pop    %esi
  280bc7:	5f                   	pop    %edi
  280bc8:	5d                   	pop    %ebp
  280bc9:	c3                   	ret    

00280bca <fifo8_status>:

int fifo8_status(struct FIFO8 *fifo)
/* return how much data in buffer */
{
  280bca:	55                   	push   %ebp
  280bcb:	89 e5                	mov    %esp,%ebp
  280bcd:	8b 55 08             	mov    0x8(%ebp),%edx
	return fifo->size - fifo->free;
}
  280bd0:	5d                   	pop    %ebp
}

int fifo8_status(struct FIFO8 *fifo)
/* return how much data in buffer */
{
	return fifo->size - fifo->free;
  280bd1:	8b 42 0c             	mov    0xc(%edx),%eax
  280bd4:	2b 42 10             	sub    0x10(%edx),%eax
}
  280bd7:	c3                   	ret    

Disassembly of section .rodata:

00280bd8 <Font8x16>:
	...
  280de8:	00 00                	add    %al,(%eax)
  280dea:	00 10                	add    %dl,(%eax)
  280dec:	10 10                	adc    %dl,(%eax)
  280dee:	10 10                	adc    %dl,(%eax)
  280df0:	10 00                	adc    %al,(%eax)
  280df2:	10 10                	adc    %dl,(%eax)
  280df4:	00 00                	add    %al,(%eax)
  280df6:	00 00                	add    %al,(%eax)
  280df8:	00 00                	add    %al,(%eax)
  280dfa:	00 24 24             	add    %ah,(%esp)
  280dfd:	24 00                	and    $0x0,%al
	...
  280e0b:	24 24                	and    $0x24,%al
  280e0d:	7e 24                	jle    280e33 <Font8x16+0x25b>
  280e0f:	24 24                	and    $0x24,%al
  280e11:	7e 24                	jle    280e37 <Font8x16+0x25f>
  280e13:	24 00                	and    $0x0,%al
  280e15:	00 00                	add    %al,(%eax)
  280e17:	00 00                	add    %al,(%eax)
  280e19:	00 00                	add    %al,(%eax)
  280e1b:	10 7c 90 90          	adc    %bh,-0x70(%eax,%edx,4)
  280e1f:	7c 12                	jl     280e33 <Font8x16+0x25b>
  280e21:	12 7c 10 00          	adc    0x0(%eax,%edx,1),%bh
  280e25:	00 00                	add    %al,(%eax)
  280e27:	00 00                	add    %al,(%eax)
  280e29:	00 00                	add    %al,(%eax)
  280e2b:	00 62 64             	add    %ah,0x64(%edx)
  280e2e:	08 10                	or     %dl,(%eax)
  280e30:	20 4c 8c 00          	and    %cl,0x0(%esp,%ecx,4)
	...
  280e3c:	18 24 20             	sbb    %ah,(%eax,%eiz,1)
  280e3f:	50                   	push   %eax
  280e40:	8a 84 4a 30 00 00 00 	mov    0x30(%edx,%ecx,2),%al
  280e47:	00 00                	add    %al,(%eax)
  280e49:	00 00                	add    %al,(%eax)
  280e4b:	10 10                	adc    %dl,(%eax)
  280e4d:	20 00                	and    %al,(%eax)
	...
  280e57:	00 00                	add    %al,(%eax)
  280e59:	00 08                	add    %cl,(%eax)
  280e5b:	10 20                	adc    %ah,(%eax)
  280e5d:	20 20                	and    %ah,(%eax)
  280e5f:	20 20                	and    %ah,(%eax)
  280e61:	20 20                	and    %ah,(%eax)
  280e63:	10 08                	adc    %cl,(%eax)
  280e65:	00 00                	add    %al,(%eax)
  280e67:	00 00                	add    %al,(%eax)
  280e69:	00 20                	add    %ah,(%eax)
  280e6b:	10 08                	adc    %cl,(%eax)
  280e6d:	08 08                	or     %cl,(%eax)
  280e6f:	08 08                	or     %cl,(%eax)
  280e71:	08 08                	or     %cl,(%eax)
  280e73:	10 20                	adc    %ah,(%eax)
	...
  280e7d:	10 54 38 38          	adc    %dl,0x38(%eax,%edi,1)
  280e81:	54                   	push   %esp
  280e82:	10 00                	adc    %al,(%eax)
	...
  280e8c:	00 10                	add    %dl,(%eax)
  280e8e:	10 7c 10 10          	adc    %bh,0x10(%eax,%edx,1)
	...
  280ea2:	10 10                	adc    %dl,(%eax)
  280ea4:	20 00                	and    %al,(%eax)
	...
  280eae:	00 7c 00 00          	add    %bh,0x0(%eax,%eax,1)
	...
  280ec2:	00 10                	add    %dl,(%eax)
	...
  280ecc:	00 02                	add    %al,(%edx)
  280ece:	04 08                	add    $0x8,%al
  280ed0:	10 20                	adc    %ah,(%eax)
  280ed2:	40                   	inc    %eax
	...
  280edb:	38 44 44 4c          	cmp    %al,0x4c(%esp,%eax,2)
  280edf:	54                   	push   %esp
  280ee0:	64                   	fs
  280ee1:	44                   	inc    %esp
  280ee2:	44                   	inc    %esp
  280ee3:	38 00                	cmp    %al,(%eax)
  280ee5:	00 00                	add    %al,(%eax)
  280ee7:	00 00                	add    %al,(%eax)
  280ee9:	00 00                	add    %al,(%eax)
  280eeb:	10 30                	adc    %dh,(%eax)
  280eed:	10 10                	adc    %dl,(%eax)
  280eef:	10 10                	adc    %dl,(%eax)
  280ef1:	10 10                	adc    %dl,(%eax)
  280ef3:	38 00                	cmp    %al,(%eax)
  280ef5:	00 00                	add    %al,(%eax)
  280ef7:	00 00                	add    %al,(%eax)
  280ef9:	00 00                	add    %al,(%eax)
  280efb:	38 44 04 04          	cmp    %al,0x4(%esp,%eax,1)
  280eff:	08 10                	or     %dl,(%eax)
  280f01:	20 40 7c             	and    %al,0x7c(%eax)
  280f04:	00 00                	add    %al,(%eax)
  280f06:	00 00                	add    %al,(%eax)
  280f08:	00 00                	add    %al,(%eax)
  280f0a:	00 7c 04 08          	add    %bh,0x8(%esp,%eax,1)
  280f0e:	10 38                	adc    %bh,(%eax)
  280f10:	04 04                	add    $0x4,%al
  280f12:	04 78                	add    $0x78,%al
  280f14:	00 00                	add    %al,(%eax)
  280f16:	00 00                	add    %al,(%eax)
  280f18:	00 00                	add    %al,(%eax)
  280f1a:	00 08                	add    %cl,(%eax)
  280f1c:	18 28                	sbb    %ch,(%eax)
  280f1e:	48                   	dec    %eax
  280f1f:	48                   	dec    %eax
  280f20:	7c 08                	jl     280f2a <Font8x16+0x352>
  280f22:	08 08                	or     %cl,(%eax)
  280f24:	00 00                	add    %al,(%eax)
  280f26:	00 00                	add    %al,(%eax)
  280f28:	00 00                	add    %al,(%eax)
  280f2a:	00 7c 40 40          	add    %bh,0x40(%eax,%eax,2)
  280f2e:	40                   	inc    %eax
  280f2f:	78 04                	js     280f35 <Font8x16+0x35d>
  280f31:	04 04                	add    $0x4,%al
  280f33:	78 00                	js     280f35 <Font8x16+0x35d>
  280f35:	00 00                	add    %al,(%eax)
  280f37:	00 00                	add    %al,(%eax)
  280f39:	00 00                	add    %al,(%eax)
  280f3b:	3c 40                	cmp    $0x40,%al
  280f3d:	40                   	inc    %eax
  280f3e:	40                   	inc    %eax
  280f3f:	78 44                	js     280f85 <Font8x16+0x3ad>
  280f41:	44                   	inc    %esp
  280f42:	44                   	inc    %esp
  280f43:	38 00                	cmp    %al,(%eax)
  280f45:	00 00                	add    %al,(%eax)
  280f47:	00 00                	add    %al,(%eax)
  280f49:	00 00                	add    %al,(%eax)
  280f4b:	7c 04                	jl     280f51 <Font8x16+0x379>
  280f4d:	04 08                	add    $0x8,%al
  280f4f:	10 20                	adc    %ah,(%eax)
  280f51:	20 20                	and    %ah,(%eax)
  280f53:	20 00                	and    %al,(%eax)
  280f55:	00 00                	add    %al,(%eax)
  280f57:	00 00                	add    %al,(%eax)
  280f59:	00 00                	add    %al,(%eax)
  280f5b:	38 44 44 44          	cmp    %al,0x44(%esp,%eax,2)
  280f5f:	38 44 44 44          	cmp    %al,0x44(%esp,%eax,2)
  280f63:	38 00                	cmp    %al,(%eax)
  280f65:	00 00                	add    %al,(%eax)
  280f67:	00 00                	add    %al,(%eax)
  280f69:	00 00                	add    %al,(%eax)
  280f6b:	38 44 44 44          	cmp    %al,0x44(%esp,%eax,2)
  280f6f:	3c 04                	cmp    $0x4,%al
  280f71:	04 04                	add    $0x4,%al
  280f73:	38 00                	cmp    %al,(%eax)
	...
  280f7d:	00 00                	add    %al,(%eax)
  280f7f:	10 00                	adc    %al,(%eax)
  280f81:	00 10                	add    %dl,(%eax)
	...
  280f8f:	00 10                	add    %dl,(%eax)
  280f91:	00 10                	add    %dl,(%eax)
  280f93:	10 20                	adc    %ah,(%eax)
	...
  280f9d:	04 08                	add    $0x8,%al
  280f9f:	10 20                	adc    %ah,(%eax)
  280fa1:	10 08                	adc    %cl,(%eax)
  280fa3:	04 00                	add    $0x0,%al
	...
  280fad:	00 00                	add    %al,(%eax)
  280faf:	7c 00                	jl     280fb1 <Font8x16+0x3d9>
  280fb1:	7c 00                	jl     280fb3 <Font8x16+0x3db>
	...
  280fbb:	00 00                	add    %al,(%eax)
  280fbd:	20 10                	and    %dl,(%eax)
  280fbf:	08 04 08             	or     %al,(%eax,%ecx,1)
  280fc2:	10 20                	adc    %ah,(%eax)
  280fc4:	00 00                	add    %al,(%eax)
  280fc6:	00 00                	add    %al,(%eax)
  280fc8:	00 00                	add    %al,(%eax)
  280fca:	38 44 44 04          	cmp    %al,0x4(%esp,%eax,2)
  280fce:	08 10                	or     %dl,(%eax)
  280fd0:	10 00                	adc    %al,(%eax)
  280fd2:	10 10                	adc    %dl,(%eax)
	...
  280fdc:	00 38                	add    %bh,(%eax)
  280fde:	44                   	inc    %esp
  280fdf:	5c                   	pop    %esp
  280fe0:	54                   	push   %esp
  280fe1:	5c                   	pop    %esp
  280fe2:	40                   	inc    %eax
  280fe3:	3c 00                	cmp    $0x0,%al
  280fe5:	00 00                	add    %al,(%eax)
  280fe7:	00 00                	add    %al,(%eax)
  280fe9:	00 18                	add    %bl,(%eax)
  280feb:	24 42                	and    $0x42,%al
  280fed:	42                   	inc    %edx
  280fee:	42                   	inc    %edx
  280fef:	7e 42                	jle    281033 <Font8x16+0x45b>
  280ff1:	42                   	inc    %edx
  280ff2:	42                   	inc    %edx
  280ff3:	42                   	inc    %edx
  280ff4:	00 00                	add    %al,(%eax)
  280ff6:	00 00                	add    %al,(%eax)
  280ff8:	00 00                	add    %al,(%eax)
  280ffa:	7c 42                	jl     28103e <Font8x16+0x466>
  280ffc:	42                   	inc    %edx
  280ffd:	42                   	inc    %edx
  280ffe:	7c 42                	jl     281042 <Font8x16+0x46a>
  281000:	42                   	inc    %edx
  281001:	42                   	inc    %edx
  281002:	42                   	inc    %edx
  281003:	7c 00                	jl     281005 <Font8x16+0x42d>
  281005:	00 00                	add    %al,(%eax)
  281007:	00 00                	add    %al,(%eax)
  281009:	00 3c 42             	add    %bh,(%edx,%eax,2)
  28100c:	40                   	inc    %eax
  28100d:	40                   	inc    %eax
  28100e:	40                   	inc    %eax
  28100f:	40                   	inc    %eax
  281010:	40                   	inc    %eax
  281011:	40                   	inc    %eax
  281012:	42                   	inc    %edx
  281013:	3c 00                	cmp    $0x0,%al
  281015:	00 00                	add    %al,(%eax)
  281017:	00 00                	add    %al,(%eax)
  281019:	00 7c 42 42          	add    %bh,0x42(%edx,%eax,2)
  28101d:	42                   	inc    %edx
  28101e:	42                   	inc    %edx
  28101f:	42                   	inc    %edx
  281020:	42                   	inc    %edx
  281021:	42                   	inc    %edx
  281022:	42                   	inc    %edx
  281023:	7c 00                	jl     281025 <Font8x16+0x44d>
  281025:	00 00                	add    %al,(%eax)
  281027:	00 00                	add    %al,(%eax)
  281029:	00 7e 40             	add    %bh,0x40(%esi)
  28102c:	40                   	inc    %eax
  28102d:	40                   	inc    %eax
  28102e:	78 40                	js     281070 <Font8x16+0x498>
  281030:	40                   	inc    %eax
  281031:	40                   	inc    %eax
  281032:	40                   	inc    %eax
  281033:	7e 00                	jle    281035 <Font8x16+0x45d>
  281035:	00 00                	add    %al,(%eax)
  281037:	00 00                	add    %al,(%eax)
  281039:	00 7e 40             	add    %bh,0x40(%esi)
  28103c:	40                   	inc    %eax
  28103d:	40                   	inc    %eax
  28103e:	78 40                	js     281080 <Font8x16+0x4a8>
  281040:	40                   	inc    %eax
  281041:	40                   	inc    %eax
  281042:	40                   	inc    %eax
  281043:	40                   	inc    %eax
  281044:	00 00                	add    %al,(%eax)
  281046:	00 00                	add    %al,(%eax)
  281048:	00 00                	add    %al,(%eax)
  28104a:	3c 42                	cmp    $0x42,%al
  28104c:	40                   	inc    %eax
  28104d:	40                   	inc    %eax
  28104e:	5e                   	pop    %esi
  28104f:	42                   	inc    %edx
  281050:	42                   	inc    %edx
  281051:	42                   	inc    %edx
  281052:	42                   	inc    %edx
  281053:	3c 00                	cmp    $0x0,%al
  281055:	00 00                	add    %al,(%eax)
  281057:	00 00                	add    %al,(%eax)
  281059:	00 42 42             	add    %al,0x42(%edx)
  28105c:	42                   	inc    %edx
  28105d:	42                   	inc    %edx
  28105e:	7e 42                	jle    2810a2 <Font8x16+0x4ca>
  281060:	42                   	inc    %edx
  281061:	42                   	inc    %edx
  281062:	42                   	inc    %edx
  281063:	42                   	inc    %edx
  281064:	00 00                	add    %al,(%eax)
  281066:	00 00                	add    %al,(%eax)
  281068:	00 00                	add    %al,(%eax)
  28106a:	38 10                	cmp    %dl,(%eax)
  28106c:	10 10                	adc    %dl,(%eax)
  28106e:	10 10                	adc    %dl,(%eax)
  281070:	10 10                	adc    %dl,(%eax)
  281072:	10 38                	adc    %bh,(%eax)
  281074:	00 00                	add    %al,(%eax)
  281076:	00 00                	add    %al,(%eax)
  281078:	00 00                	add    %al,(%eax)
  28107a:	1c 08                	sbb    $0x8,%al
  28107c:	08 08                	or     %cl,(%eax)
  28107e:	08 08                	or     %cl,(%eax)
  281080:	08 08                	or     %cl,(%eax)
  281082:	48                   	dec    %eax
  281083:	30 00                	xor    %al,(%eax)
  281085:	00 00                	add    %al,(%eax)
  281087:	00 00                	add    %al,(%eax)
  281089:	00 42 44             	add    %al,0x44(%edx)
  28108c:	48                   	dec    %eax
  28108d:	50                   	push   %eax
  28108e:	60                   	pusha  
  28108f:	60                   	pusha  
  281090:	50                   	push   %eax
  281091:	48                   	dec    %eax
  281092:	44                   	inc    %esp
  281093:	42                   	inc    %edx
  281094:	00 00                	add    %al,(%eax)
  281096:	00 00                	add    %al,(%eax)
  281098:	00 00                	add    %al,(%eax)
  28109a:	40                   	inc    %eax
  28109b:	40                   	inc    %eax
  28109c:	40                   	inc    %eax
  28109d:	40                   	inc    %eax
  28109e:	40                   	inc    %eax
  28109f:	40                   	inc    %eax
  2810a0:	40                   	inc    %eax
  2810a1:	40                   	inc    %eax
  2810a2:	40                   	inc    %eax
  2810a3:	7e 00                	jle    2810a5 <Font8x16+0x4cd>
  2810a5:	00 00                	add    %al,(%eax)
  2810a7:	00 00                	add    %al,(%eax)
  2810a9:	00 82 82 c6 c6 aa    	add    %al,-0x5539397e(%edx)
  2810af:	aa                   	stos   %al,%es:(%edi)
  2810b0:	92                   	xchg   %eax,%edx
  2810b1:	92                   	xchg   %eax,%edx
  2810b2:	82                   	(bad)  
  2810b3:	82                   	(bad)  
  2810b4:	00 00                	add    %al,(%eax)
  2810b6:	00 00                	add    %al,(%eax)
  2810b8:	00 00                	add    %al,(%eax)
  2810ba:	42                   	inc    %edx
  2810bb:	62 62 52             	bound  %esp,0x52(%edx)
  2810be:	52                   	push   %edx
  2810bf:	4a                   	dec    %edx
  2810c0:	4a                   	dec    %edx
  2810c1:	46                   	inc    %esi
  2810c2:	46                   	inc    %esi
  2810c3:	42                   	inc    %edx
  2810c4:	00 00                	add    %al,(%eax)
  2810c6:	00 00                	add    %al,(%eax)
  2810c8:	00 00                	add    %al,(%eax)
  2810ca:	3c 42                	cmp    $0x42,%al
  2810cc:	42                   	inc    %edx
  2810cd:	42                   	inc    %edx
  2810ce:	42                   	inc    %edx
  2810cf:	42                   	inc    %edx
  2810d0:	42                   	inc    %edx
  2810d1:	42                   	inc    %edx
  2810d2:	42                   	inc    %edx
  2810d3:	3c 00                	cmp    $0x0,%al
  2810d5:	00 00                	add    %al,(%eax)
  2810d7:	00 00                	add    %al,(%eax)
  2810d9:	00 7c 42 42          	add    %bh,0x42(%edx,%eax,2)
  2810dd:	42                   	inc    %edx
  2810de:	42                   	inc    %edx
  2810df:	7c 40                	jl     281121 <Font8x16+0x549>
  2810e1:	40                   	inc    %eax
  2810e2:	40                   	inc    %eax
  2810e3:	40                   	inc    %eax
  2810e4:	00 00                	add    %al,(%eax)
  2810e6:	00 00                	add    %al,(%eax)
  2810e8:	00 00                	add    %al,(%eax)
  2810ea:	3c 42                	cmp    $0x42,%al
  2810ec:	42                   	inc    %edx
  2810ed:	42                   	inc    %edx
  2810ee:	42                   	inc    %edx
  2810ef:	42                   	inc    %edx
  2810f0:	42                   	inc    %edx
  2810f1:	42                   	inc    %edx
  2810f2:	4a                   	dec    %edx
  2810f3:	3c 0e                	cmp    $0xe,%al
  2810f5:	00 00                	add    %al,(%eax)
  2810f7:	00 00                	add    %al,(%eax)
  2810f9:	00 7c 42 42          	add    %bh,0x42(%edx,%eax,2)
  2810fd:	42                   	inc    %edx
  2810fe:	42                   	inc    %edx
  2810ff:	7c 50                	jl     281151 <Font8x16+0x579>
  281101:	48                   	dec    %eax
  281102:	44                   	inc    %esp
  281103:	42                   	inc    %edx
  281104:	00 00                	add    %al,(%eax)
  281106:	00 00                	add    %al,(%eax)
  281108:	00 00                	add    %al,(%eax)
  28110a:	3c 42                	cmp    $0x42,%al
  28110c:	40                   	inc    %eax
  28110d:	40                   	inc    %eax
  28110e:	3c 02                	cmp    $0x2,%al
  281110:	02 02                	add    (%edx),%al
  281112:	42                   	inc    %edx
  281113:	3c 00                	cmp    $0x0,%al
  281115:	00 00                	add    %al,(%eax)
  281117:	00 00                	add    %al,(%eax)
  281119:	00 7c 10 10          	add    %bh,0x10(%eax,%edx,1)
  28111d:	10 10                	adc    %dl,(%eax)
  28111f:	10 10                	adc    %dl,(%eax)
  281121:	10 10                	adc    %dl,(%eax)
  281123:	10 00                	adc    %al,(%eax)
  281125:	00 00                	add    %al,(%eax)
  281127:	00 00                	add    %al,(%eax)
  281129:	00 42 42             	add    %al,0x42(%edx)
  28112c:	42                   	inc    %edx
  28112d:	42                   	inc    %edx
  28112e:	42                   	inc    %edx
  28112f:	42                   	inc    %edx
  281130:	42                   	inc    %edx
  281131:	42                   	inc    %edx
  281132:	42                   	inc    %edx
  281133:	3c 00                	cmp    $0x0,%al
  281135:	00 00                	add    %al,(%eax)
  281137:	00 00                	add    %al,(%eax)
  281139:	00 44 44 44          	add    %al,0x44(%esp,%eax,2)
  28113d:	44                   	inc    %esp
  28113e:	28 28                	sub    %ch,(%eax)
  281140:	28 10                	sub    %dl,(%eax)
  281142:	10 10                	adc    %dl,(%eax)
  281144:	00 00                	add    %al,(%eax)
  281146:	00 00                	add    %al,(%eax)
  281148:	00 00                	add    %al,(%eax)
  28114a:	82                   	(bad)  
  28114b:	82                   	(bad)  
  28114c:	82                   	(bad)  
  28114d:	82                   	(bad)  
  28114e:	54                   	push   %esp
  28114f:	54                   	push   %esp
  281150:	54                   	push   %esp
  281151:	28 28                	sub    %ch,(%eax)
  281153:	28 00                	sub    %al,(%eax)
  281155:	00 00                	add    %al,(%eax)
  281157:	00 00                	add    %al,(%eax)
  281159:	00 42 42             	add    %al,0x42(%edx)
  28115c:	24 18                	and    $0x18,%al
  28115e:	18 18                	sbb    %bl,(%eax)
  281160:	24 24                	and    $0x24,%al
  281162:	42                   	inc    %edx
  281163:	42                   	inc    %edx
  281164:	00 00                	add    %al,(%eax)
  281166:	00 00                	add    %al,(%eax)
  281168:	00 00                	add    %al,(%eax)
  28116a:	44                   	inc    %esp
  28116b:	44                   	inc    %esp
  28116c:	44                   	inc    %esp
  28116d:	44                   	inc    %esp
  28116e:	28 28                	sub    %ch,(%eax)
  281170:	10 10                	adc    %dl,(%eax)
  281172:	10 10                	adc    %dl,(%eax)
  281174:	00 00                	add    %al,(%eax)
  281176:	00 00                	add    %al,(%eax)
  281178:	00 00                	add    %al,(%eax)
  28117a:	7e 02                	jle    28117e <Font8x16+0x5a6>
  28117c:	02 04 08             	add    (%eax,%ecx,1),%al
  28117f:	10 20                	adc    %ah,(%eax)
  281181:	40                   	inc    %eax
  281182:	40                   	inc    %eax
  281183:	7e 00                	jle    281185 <Font8x16+0x5ad>
  281185:	00 00                	add    %al,(%eax)
  281187:	00 00                	add    %al,(%eax)
  281189:	00 38                	add    %bh,(%eax)
  28118b:	20 20                	and    %ah,(%eax)
  28118d:	20 20                	and    %ah,(%eax)
  28118f:	20 20                	and    %ah,(%eax)
  281191:	20 20                	and    %ah,(%eax)
  281193:	38 00                	cmp    %al,(%eax)
	...
  28119d:	00 40 20             	add    %al,0x20(%eax)
  2811a0:	10 08                	adc    %cl,(%eax)
  2811a2:	04 02                	add    $0x2,%al
  2811a4:	00 00                	add    %al,(%eax)
  2811a6:	00 00                	add    %al,(%eax)
  2811a8:	00 00                	add    %al,(%eax)
  2811aa:	1c 04                	sbb    $0x4,%al
  2811ac:	04 04                	add    $0x4,%al
  2811ae:	04 04                	add    $0x4,%al
  2811b0:	04 04                	add    $0x4,%al
  2811b2:	04 1c                	add    $0x1c,%al
	...
  2811bc:	10 28                	adc    %ch,(%eax)
  2811be:	44                   	inc    %esp
	...
  2811d3:	00 ff                	add    %bh,%bh
  2811d5:	00 00                	add    %al,(%eax)
  2811d7:	00 00                	add    %al,(%eax)
  2811d9:	00 00                	add    %al,(%eax)
  2811db:	10 10                	adc    %dl,(%eax)
  2811dd:	08 00                	or     %al,(%eax)
	...
  2811eb:	00 00                	add    %al,(%eax)
  2811ed:	78 04                	js     2811f3 <Font8x16+0x61b>
  2811ef:	3c 44                	cmp    $0x44,%al
  2811f1:	44                   	inc    %esp
  2811f2:	44                   	inc    %esp
  2811f3:	3a 00                	cmp    (%eax),%al
  2811f5:	00 00                	add    %al,(%eax)
  2811f7:	00 00                	add    %al,(%eax)
  2811f9:	00 40 40             	add    %al,0x40(%eax)
  2811fc:	40                   	inc    %eax
  2811fd:	5c                   	pop    %esp
  2811fe:	62 42 42             	bound  %eax,0x42(%edx)
  281201:	42                   	inc    %edx
  281202:	62 5c 00 00          	bound  %ebx,0x0(%eax,%eax,1)
  281206:	00 00                	add    %al,(%eax)
  281208:	00 00                	add    %al,(%eax)
  28120a:	00 00                	add    %al,(%eax)
  28120c:	00 3c 42             	add    %bh,(%edx,%eax,2)
  28120f:	40                   	inc    %eax
  281210:	40                   	inc    %eax
  281211:	40                   	inc    %eax
  281212:	42                   	inc    %edx
  281213:	3c 00                	cmp    $0x0,%al
  281215:	00 00                	add    %al,(%eax)
  281217:	00 00                	add    %al,(%eax)
  281219:	00 02                	add    %al,(%edx)
  28121b:	02 02                	add    (%edx),%al
  28121d:	3a 46 42             	cmp    0x42(%esi),%al
  281220:	42                   	inc    %edx
  281221:	42                   	inc    %edx
  281222:	46                   	inc    %esi
  281223:	3a 00                	cmp    (%eax),%al
	...
  28122d:	3c 42                	cmp    $0x42,%al
  28122f:	42                   	inc    %edx
  281230:	7e 40                	jle    281272 <Font8x16+0x69a>
  281232:	42                   	inc    %edx
  281233:	3c 00                	cmp    $0x0,%al
  281235:	00 00                	add    %al,(%eax)
  281237:	00 00                	add    %al,(%eax)
  281239:	00 0e                	add    %cl,(%esi)
  28123b:	10 10                	adc    %dl,(%eax)
  28123d:	10 3c 10             	adc    %bh,(%eax,%edx,1)
  281240:	10 10                	adc    %dl,(%eax)
  281242:	10 10                	adc    %dl,(%eax)
	...
  28124c:	00 3e                	add    %bh,(%esi)
  28124e:	42                   	inc    %edx
  28124f:	42                   	inc    %edx
  281250:	42                   	inc    %edx
  281251:	42                   	inc    %edx
  281252:	3e 02 02             	add    %ds:(%edx),%al
  281255:	3c 00                	cmp    $0x0,%al
  281257:	00 00                	add    %al,(%eax)
  281259:	00 40 40             	add    %al,0x40(%eax)
  28125c:	40                   	inc    %eax
  28125d:	5c                   	pop    %esp
  28125e:	62 42 42             	bound  %eax,0x42(%edx)
  281261:	42                   	inc    %edx
  281262:	42                   	inc    %edx
  281263:	42                   	inc    %edx
  281264:	00 00                	add    %al,(%eax)
  281266:	00 00                	add    %al,(%eax)
  281268:	00 00                	add    %al,(%eax)
  28126a:	00 08                	add    %cl,(%eax)
  28126c:	00 08                	add    %cl,(%eax)
  28126e:	08 08                	or     %cl,(%eax)
  281270:	08 08                	or     %cl,(%eax)
  281272:	08 08                	or     %cl,(%eax)
  281274:	00 00                	add    %al,(%eax)
  281276:	00 00                	add    %al,(%eax)
  281278:	00 00                	add    %al,(%eax)
  28127a:	00 04 00             	add    %al,(%eax,%eax,1)
  28127d:	04 04                	add    $0x4,%al
  28127f:	04 04                	add    $0x4,%al
  281281:	04 04                	add    $0x4,%al
  281283:	04 44                	add    $0x44,%al
  281285:	38 00                	cmp    %al,(%eax)
  281287:	00 00                	add    %al,(%eax)
  281289:	00 40 40             	add    %al,0x40(%eax)
  28128c:	40                   	inc    %eax
  28128d:	42                   	inc    %edx
  28128e:	44                   	inc    %esp
  28128f:	48                   	dec    %eax
  281290:	50                   	push   %eax
  281291:	68 44 42 00 00       	push   $0x4244
  281296:	00 00                	add    %al,(%eax)
  281298:	00 00                	add    %al,(%eax)
  28129a:	10 10                	adc    %dl,(%eax)
  28129c:	10 10                	adc    %dl,(%eax)
  28129e:	10 10                	adc    %dl,(%eax)
  2812a0:	10 10                	adc    %dl,(%eax)
  2812a2:	10 10                	adc    %dl,(%eax)
	...
  2812ac:	00 ec                	add    %ch,%ah
  2812ae:	92                   	xchg   %eax,%edx
  2812af:	92                   	xchg   %eax,%edx
  2812b0:	92                   	xchg   %eax,%edx
  2812b1:	92                   	xchg   %eax,%edx
  2812b2:	92                   	xchg   %eax,%edx
  2812b3:	92                   	xchg   %eax,%edx
	...
  2812bc:	00 7c 42 42          	add    %bh,0x42(%edx,%eax,2)
  2812c0:	42                   	inc    %edx
  2812c1:	42                   	inc    %edx
  2812c2:	42                   	inc    %edx
  2812c3:	42                   	inc    %edx
	...
  2812cc:	00 3c 42             	add    %bh,(%edx,%eax,2)
  2812cf:	42                   	inc    %edx
  2812d0:	42                   	inc    %edx
  2812d1:	42                   	inc    %edx
  2812d2:	42                   	inc    %edx
  2812d3:	3c 00                	cmp    $0x0,%al
	...
  2812dd:	5c                   	pop    %esp
  2812de:	62 42 42             	bound  %eax,0x42(%edx)
  2812e1:	42                   	inc    %edx
  2812e2:	62 5c 40 40          	bound  %ebx,0x40(%eax,%eax,2)
  2812e6:	00 00                	add    %al,(%eax)
  2812e8:	00 00                	add    %al,(%eax)
  2812ea:	00 00                	add    %al,(%eax)
  2812ec:	00 3a                	add    %bh,(%edx)
  2812ee:	46                   	inc    %esi
  2812ef:	42                   	inc    %edx
  2812f0:	42                   	inc    %edx
  2812f1:	42                   	inc    %edx
  2812f2:	46                   	inc    %esi
  2812f3:	3a 02                	cmp    (%edx),%al
  2812f5:	02 00                	add    (%eax),%al
  2812f7:	00 00                	add    %al,(%eax)
  2812f9:	00 00                	add    %al,(%eax)
  2812fb:	00 00                	add    %al,(%eax)
  2812fd:	5c                   	pop    %esp
  2812fe:	62 40 40             	bound  %eax,0x40(%eax)
  281301:	40                   	inc    %eax
  281302:	40                   	inc    %eax
  281303:	40                   	inc    %eax
	...
  28130c:	00 3c 42             	add    %bh,(%edx,%eax,2)
  28130f:	40                   	inc    %eax
  281310:	3c 02                	cmp    $0x2,%al
  281312:	42                   	inc    %edx
  281313:	3c 00                	cmp    $0x0,%al
  281315:	00 00                	add    %al,(%eax)
  281317:	00 00                	add    %al,(%eax)
  281319:	00 00                	add    %al,(%eax)
  28131b:	20 20                	and    %ah,(%eax)
  28131d:	78 20                	js     28133f <Font8x16+0x767>
  28131f:	20 20                	and    %ah,(%eax)
  281321:	20 22                	and    %ah,(%edx)
  281323:	1c 00                	sbb    $0x0,%al
	...
  28132d:	42                   	inc    %edx
  28132e:	42                   	inc    %edx
  28132f:	42                   	inc    %edx
  281330:	42                   	inc    %edx
  281331:	42                   	inc    %edx
  281332:	42                   	inc    %edx
  281333:	3e 00 00             	add    %al,%ds:(%eax)
  281336:	00 00                	add    %al,(%eax)
  281338:	00 00                	add    %al,(%eax)
  28133a:	00 00                	add    %al,(%eax)
  28133c:	00 42 42             	add    %al,0x42(%edx)
  28133f:	42                   	inc    %edx
  281340:	42                   	inc    %edx
  281341:	42                   	inc    %edx
  281342:	24 18                	and    $0x18,%al
	...
  28134c:	00 82 82 82 92 92    	add    %al,-0x6d6d7d7e(%edx)
  281352:	aa                   	stos   %al,%es:(%edi)
  281353:	44                   	inc    %esp
	...
  28135c:	00 42 42             	add    %al,0x42(%edx)
  28135f:	24 18                	and    $0x18,%al
  281361:	24 42                	and    $0x42,%al
  281363:	42                   	inc    %edx
	...
  28136c:	00 42 42             	add    %al,0x42(%edx)
  28136f:	42                   	inc    %edx
  281370:	42                   	inc    %edx
  281371:	42                   	inc    %edx
  281372:	3e 02 02             	add    %ds:(%edx),%al
  281375:	3c 00                	cmp    $0x0,%al
  281377:	00 00                	add    %al,(%eax)
  281379:	00 00                	add    %al,(%eax)
  28137b:	00 00                	add    %al,(%eax)
  28137d:	7e 02                	jle    281381 <Font8x16+0x7a9>
  28137f:	04 18                	add    $0x18,%al
  281381:	20 40 7e             	and    %al,0x7e(%eax)
  281384:	00 00                	add    %al,(%eax)
  281386:	00 00                	add    %al,(%eax)
  281388:	00 00                	add    %al,(%eax)
  28138a:	08 10                	or     %dl,(%eax)
  28138c:	10 10                	adc    %dl,(%eax)
  28138e:	20 40 20             	and    %al,0x20(%eax)
  281391:	10 10                	adc    %dl,(%eax)
  281393:	10 08                	adc    %cl,(%eax)
  281395:	00 00                	add    %al,(%eax)
  281397:	00 00                	add    %al,(%eax)
  281399:	10 10                	adc    %dl,(%eax)
  28139b:	10 10                	adc    %dl,(%eax)
  28139d:	10 10                	adc    %dl,(%eax)
  28139f:	10 10                	adc    %dl,(%eax)
  2813a1:	10 10                	adc    %dl,(%eax)
  2813a3:	10 10                	adc    %dl,(%eax)
  2813a5:	10 10                	adc    %dl,(%eax)
  2813a7:	00 00                	add    %al,(%eax)
  2813a9:	00 20                	add    %ah,(%eax)
  2813ab:	10 10                	adc    %dl,(%eax)
  2813ad:	10 08                	adc    %cl,(%eax)
  2813af:	04 08                	add    $0x8,%al
  2813b1:	10 10                	adc    %dl,(%eax)
  2813b3:	10 20                	adc    %ah,(%eax)
	...
  2813bd:	00 22                	add    %ah,(%edx)
  2813bf:	54                   	push   %esp
  2813c0:	88 00                	mov    %al,(%eax)
	...

002813d8 <ASCII_Table>:
	...
  281408:	00 00                	add    %al,(%eax)
  28140a:	80 01 80             	addb   $0x80,(%ecx)
  28140d:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281413:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281419:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  28141f:	01 80 01 80 01 00    	add    %eax,0x18001(%eax)
  281425:	00 00                	add    %al,(%eax)
  281427:	00 80 01 80 01 00    	add    %al,0x18001(%eax)
	...
  281439:	00 00                	add    %al,(%eax)
  28143b:	00 cc                	add    %cl,%ah
  28143d:	00 cc                	add    %cl,%ah
  28143f:	00 cc                	add    %cl,%ah
  281441:	00 cc                	add    %cl,%ah
  281443:	00 cc                	add    %cl,%ah
  281445:	00 cc                	add    %cl,%ah
	...
  281473:	00 60 0c             	add    %ah,0xc(%eax)
  281476:	60                   	pusha  
  281477:	0c 60                	or     $0x60,%al
  281479:	0c 30                	or     $0x30,%al
  28147b:	06                   	push   %es
  28147c:	30 06                	xor    %al,(%esi)
  28147e:	fe                   	(bad)  
  28147f:	1f                   	pop    %ds
  281480:	fe                   	(bad)  
  281481:	1f                   	pop    %ds
  281482:	30 06                	xor    %al,(%esi)
  281484:	38 07                	cmp    %al,(%edi)
  281486:	18 03                	sbb    %al,(%ebx)
  281488:	fe                   	(bad)  
  281489:	1f                   	pop    %ds
  28148a:	fe                   	(bad)  
  28148b:	1f                   	pop    %ds
  28148c:	18 03                	sbb    %al,(%ebx)
  28148e:	18 03                	sbb    %al,(%ebx)
  281490:	8c 01                	mov    %es,(%ecx)
  281492:	8c 01                	mov    %es,(%ecx)
  281494:	8c 01                	mov    %es,(%ecx)
  281496:	00 00                	add    %al,(%eax)
  281498:	00 00                	add    %al,(%eax)
  28149a:	80 00 e0             	addb   $0xe0,(%eax)
  28149d:	03 f8                	add    %eax,%edi
  28149f:	0f 9c 0e             	setl   (%esi)
  2814a2:	8c 1c 8c             	mov    %ds,(%esp,%ecx,4)
  2814a5:	18 8c 00 98 00 f8 01 	sbb    %cl,0x1f80098(%eax,%eax,1)
  2814ac:	e0 07                	loopne 2814b5 <ASCII_Table+0xdd>
  2814ae:	80 0e 80             	orb    $0x80,(%esi)
  2814b1:	1c 8c                	sbb    $0x8c,%al
  2814b3:	18 8c 18 9c 18 b8 0c 	sbb    %cl,0xcb8189c(%eax,%ebx,1)
  2814ba:	f0 0f e0 03          	lock pavgb (%ebx),%mm0
  2814be:	80 00 80             	addb   $0x80,(%eax)
	...
  2814cd:	00 0e                	add    %cl,(%esi)
  2814cf:	18 1b                	sbb    %bl,(%ebx)
  2814d1:	0c 11                	or     $0x11,%al
  2814d3:	0c 11                	or     $0x11,%al
  2814d5:	06                   	push   %es
  2814d6:	11 06                	adc    %eax,(%esi)
  2814d8:	11 03                	adc    %eax,(%ebx)
  2814da:	11 03                	adc    %eax,(%ebx)
  2814dc:	9b                   	fwait
  2814dd:	01 8e 01 c0 38 c0    	add    %ecx,-0x3fc73fff(%esi)
  2814e3:	6c                   	insb   (%dx),%es:(%edi)
  2814e4:	60                   	pusha  
  2814e5:	44                   	inc    %esp
  2814e6:	60                   	pusha  
  2814e7:	44                   	inc    %esp
  2814e8:	30 44 30 44          	xor    %al,0x44(%eax,%esi,1)
  2814ec:	18 44 18 6c          	sbb    %al,0x6c(%eax,%ebx,1)
  2814f0:	0c 38                	or     $0x38,%al
	...
  2814fa:	e0 01                	loopne 2814fd <ASCII_Table+0x125>
  2814fc:	f0 03 38             	lock add (%eax),%edi
  2814ff:	07                   	pop    %es
  281500:	18 06                	sbb    %al,(%esi)
  281502:	18 06                	sbb    %al,(%esi)
  281504:	30 03                	xor    %al,(%ebx)
  281506:	f0 01 f0             	lock add %esi,%eax
  281509:	00 f8                	add    %bh,%al
  28150b:	00 9c 31 0e 33 06 1e 	add    %bl,0x1e06330e(%ecx,%esi,1)
  281512:	06                   	push   %es
  281513:	1c 06                	sbb    $0x6,%al
  281515:	1c 06                	sbb    $0x6,%al
  281517:	3f                   	aas    
  281518:	fc                   	cld    
  281519:	73 f0                	jae    28150b <ASCII_Table+0x133>
  28151b:	21 00                	and    %eax,(%eax)
	...
  281529:	00 00                	add    %al,(%eax)
  28152b:	00 0c 00             	add    %cl,(%eax,%eax,1)
  28152e:	0c 00                	or     $0x0,%al
  281530:	0c 00                	or     $0x0,%al
  281532:	0c 00                	or     $0x0,%al
  281534:	0c 00                	or     $0x0,%al
  281536:	0c 00                	or     $0x0,%al
	...
  281558:	00 00                	add    %al,(%eax)
  28155a:	00 02                	add    %al,(%edx)
  28155c:	00 03                	add    %al,(%ebx)
  28155e:	80 01 c0             	addb   $0xc0,(%ecx)
  281561:	00 c0                	add    %al,%al
  281563:	00 60 00             	add    %ah,0x0(%eax)
  281566:	60                   	pusha  
  281567:	00 30                	add    %dh,(%eax)
  281569:	00 30                	add    %dh,(%eax)
  28156b:	00 30                	add    %dh,(%eax)
  28156d:	00 30                	add    %dh,(%eax)
  28156f:	00 30                	add    %dh,(%eax)
  281571:	00 30                	add    %dh,(%eax)
  281573:	00 30                	add    %dh,(%eax)
  281575:	00 30                	add    %dh,(%eax)
  281577:	00 60 00             	add    %ah,0x0(%eax)
  28157a:	60                   	pusha  
  28157b:	00 c0                	add    %al,%al
  28157d:	00 c0                	add    %al,%al
  28157f:	00 80 01 00 03 00    	add    %al,0x30001(%eax)
  281585:	02 00                	add    (%eax),%al
  281587:	00 00                	add    %al,(%eax)
  281589:	00 20                	add    %ah,(%eax)
  28158b:	00 60 00             	add    %ah,0x0(%eax)
  28158e:	c0 00 80             	rolb   $0x80,(%eax)
  281591:	01 80 01 00 03 00    	add    %eax,0x30001(%eax)
  281597:	03 00                	add    (%eax),%eax
  281599:	06                   	push   %es
  28159a:	00 06                	add    %al,(%esi)
  28159c:	00 06                	add    %al,(%esi)
  28159e:	00 06                	add    %al,(%esi)
  2815a0:	00 06                	add    %al,(%esi)
  2815a2:	00 06                	add    %al,(%esi)
  2815a4:	00 06                	add    %al,(%esi)
  2815a6:	00 06                	add    %al,(%esi)
  2815a8:	00 03                	add    %al,(%ebx)
  2815aa:	00 03                	add    %al,(%ebx)
  2815ac:	80 01 80             	addb   $0x80,(%ecx)
  2815af:	01 c0                	add    %eax,%eax
  2815b1:	00 60 00             	add    %ah,0x0(%eax)
  2815b4:	20 00                	and    %al,(%eax)
	...
  2815c2:	00 00                	add    %al,(%eax)
  2815c4:	c0 00 c0             	rolb   $0xc0,(%eax)
  2815c7:	00 d8                	add    %bl,%al
  2815c9:	06                   	push   %es
  2815ca:	f8                   	clc    
  2815cb:	07                   	pop    %es
  2815cc:	e0 01                	loopne 2815cf <ASCII_Table+0x1f7>
  2815ce:	30 03                	xor    %al,(%ebx)
  2815d0:	38 07                	cmp    %al,(%edi)
	...
  2815f2:	00 00                	add    %al,(%eax)
  2815f4:	80 01 80             	addb   $0x80,(%ecx)
  2815f7:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2815fd:	01 fc                	add    %edi,%esp
  2815ff:	3f                   	aas    
  281600:	fc                   	cld    
  281601:	3f                   	aas    
  281602:	80 01 80             	addb   $0x80,(%ecx)
  281605:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  28160b:	01 00                	add    %eax,(%eax)
	...
  281639:	00 80 01 80 01 00    	add    %al,0x18001(%eax)
  28163f:	01 00                	add    %eax,(%eax)
  281641:	01 80 00 00 00 00    	add    %eax,0x0(%eax)
	...
  28165f:	00 e0                	add    %ah,%al
  281661:	07                   	pop    %es
  281662:	e0 07                	loopne 28166b <ASCII_Table+0x293>
	...
  281698:	00 00                	add    %al,(%eax)
  28169a:	c0 00 c0             	rolb   $0xc0,(%eax)
	...
  2816a9:	00 00                	add    %al,(%eax)
  2816ab:	0c 00                	or     $0x0,%al
  2816ad:	0c 00                	or     $0x0,%al
  2816af:	06                   	push   %es
  2816b0:	00 06                	add    %al,(%esi)
  2816b2:	00 06                	add    %al,(%esi)
  2816b4:	00 03                	add    %al,(%ebx)
  2816b6:	00 03                	add    %al,(%ebx)
  2816b8:	00 03                	add    %al,(%ebx)
  2816ba:	80 03 80             	addb   $0x80,(%ebx)
  2816bd:	01 80 01 80 01 c0    	add    %eax,-0x3ffe7fff(%eax)
  2816c3:	00 c0                	add    %al,%al
  2816c5:	00 c0                	add    %al,%al
  2816c7:	00 60 00             	add    %ah,0x0(%eax)
  2816ca:	60                   	pusha  
	...
  2816d7:	00 00                	add    %al,(%eax)
  2816d9:	00 e0                	add    %ah,%al
  2816db:	03 f0                	add    %eax,%esi
  2816dd:	07                   	pop    %es
  2816de:	38 0e                	cmp    %cl,(%esi)
  2816e0:	18 0c 0c             	sbb    %cl,(%esp,%ecx,1)
  2816e3:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  2816e6:	0c 18                	or     $0x18,%al
  2816e8:	0c 18                	or     $0x18,%al
  2816ea:	0c 18                	or     $0x18,%al
  2816ec:	0c 18                	or     $0x18,%al
  2816ee:	0c 18                	or     $0x18,%al
  2816f0:	0c 18                	or     $0x18,%al
  2816f2:	0c 18                	or     $0x18,%al
  2816f4:	18 0c 38             	sbb    %cl,(%eax,%edi,1)
  2816f7:	0e                   	push   %cs
  2816f8:	f0 07                	lock pop %es
  2816fa:	e0 03                	loopne 2816ff <ASCII_Table+0x327>
	...
  281708:	00 00                	add    %al,(%eax)
  28170a:	00 01                	add    %al,(%ecx)
  28170c:	80 01 c0             	addb   $0xc0,(%ecx)
  28170f:	01 f0                	add    %esi,%eax
  281711:	01 98 01 88 01 80    	add    %ebx,-0x7ffe77ff(%eax)
  281717:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  28171d:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281723:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281729:	01 80 01 00 00 00    	add    %eax,0x1(%eax)
	...
  281737:	00 00                	add    %al,(%eax)
  281739:	00 e0                	add    %ah,%al
  28173b:	03 f8                	add    %eax,%edi
  28173d:	0f 18 0c 0c          	prefetcht0 (%esp,%ecx,1)
  281741:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281744:	00 18                	add    %bl,(%eax)
  281746:	00 18                	add    %bl,(%eax)
  281748:	00 0c 00             	add    %cl,(%eax,%eax,1)
  28174b:	06                   	push   %es
  28174c:	00 03                	add    %al,(%ebx)
  28174e:	80 01 c0             	addb   $0xc0,(%ecx)
  281751:	00 60 00             	add    %ah,0x0(%eax)
  281754:	30 00                	xor    %al,(%eax)
  281756:	18 00                	sbb    %al,(%eax)
  281758:	fc                   	cld    
  281759:	1f                   	pop    %ds
  28175a:	fc                   	cld    
  28175b:	1f                   	pop    %ds
	...
  281768:	00 00                	add    %al,(%eax)
  28176a:	e0 01                	loopne 28176d <ASCII_Table+0x395>
  28176c:	f8                   	clc    
  28176d:	07                   	pop    %es
  28176e:	18 0e                	sbb    %cl,(%esi)
  281770:	0c 0c                	or     $0xc,%al
  281772:	0c 0c                	or     $0xc,%al
  281774:	00 0c 00             	add    %cl,(%eax,%eax,1)
  281777:	06                   	push   %es
  281778:	c0 03 c0             	rolb   $0xc0,(%ebx)
  28177b:	07                   	pop    %es
  28177c:	00 0c 00             	add    %cl,(%eax,%eax,1)
  28177f:	18 00                	sbb    %al,(%eax)
  281781:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281784:	0c 18                	or     $0x18,%al
  281786:	18 0c f8             	sbb    %cl,(%eax,%edi,8)
  281789:	07                   	pop    %es
  28178a:	e0 03                	loopne 28178f <ASCII_Table+0x3b7>
	...
  281798:	00 00                	add    %al,(%eax)
  28179a:	00 0c 00             	add    %cl,(%eax,%eax,1)
  28179d:	0e                   	push   %cs
  28179e:	00 0f                	add    %cl,(%edi)
  2817a0:	00 0f                	add    %cl,(%edi)
  2817a2:	80 0d c0 0c 60 0c 60 	orb    $0x60,0xc600cc0
  2817a9:	0c 30                	or     $0x30,%al
  2817ab:	0c 18                	or     $0x18,%al
  2817ad:	0c 0c                	or     $0xc,%al
  2817af:	0c fc                	or     $0xfc,%al
  2817b1:	3f                   	aas    
  2817b2:	fc                   	cld    
  2817b3:	3f                   	aas    
  2817b4:	00 0c 00             	add    %cl,(%eax,%eax,1)
  2817b7:	0c 00                	or     $0x0,%al
  2817b9:	0c 00                	or     $0x0,%al
  2817bb:	0c 00                	or     $0x0,%al
	...
  2817c9:	00 f8                	add    %bh,%al
  2817cb:	0f f8 0f             	psubb  (%edi),%mm1
  2817ce:	18 00                	sbb    %al,(%eax)
  2817d0:	18 00                	sbb    %al,(%eax)
  2817d2:	0c 00                	or     $0x0,%al
  2817d4:	ec                   	in     (%dx),%al
  2817d5:	03 fc                	add    %esp,%edi
  2817d7:	07                   	pop    %es
  2817d8:	1c 0e                	sbb    $0xe,%al
  2817da:	00 1c 00             	add    %bl,(%eax,%eax,1)
  2817dd:	18 00                	sbb    %al,(%eax)
  2817df:	18 00                	sbb    %al,(%eax)
  2817e1:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  2817e4:	1c 0c                	sbb    $0xc,%al
  2817e6:	18 0e                	sbb    %cl,(%esi)
  2817e8:	f8                   	clc    
  2817e9:	07                   	pop    %es
  2817ea:	e0 03                	loopne 2817ef <ASCII_Table+0x417>
	...
  2817f8:	00 00                	add    %al,(%eax)
  2817fa:	c0 07 f0             	rolb   $0xf0,(%edi)
  2817fd:	0f 38 1c 18          	pabsb  (%eax),%mm3
  281801:	18 18                	sbb    %bl,(%eax)
  281803:	00 0c 00             	add    %cl,(%eax,%eax,1)
  281806:	cc                   	int3   
  281807:	03 ec                	add    %esp,%ebp
  281809:	0f 3c                	(bad)  
  28180b:	0e                   	push   %cs
  28180c:	1c 1c                	sbb    $0x1c,%al
  28180e:	0c 18                	or     $0x18,%al
  281810:	0c 18                	or     $0x18,%al
  281812:	0c 18                	or     $0x18,%al
  281814:	18 1c 38             	sbb    %bl,(%eax,%edi,1)
  281817:	0e                   	push   %cs
  281818:	f0 07                	lock pop %es
  28181a:	e0 03                	loopne 28181f <ASCII_Table+0x447>
	...
  281828:	00 00                	add    %al,(%eax)
  28182a:	fc                   	cld    
  28182b:	1f                   	pop    %ds
  28182c:	fc                   	cld    
  28182d:	1f                   	pop    %ds
  28182e:	00 0c 00             	add    %cl,(%eax,%eax,1)
  281831:	06                   	push   %es
  281832:	00 06                	add    %al,(%esi)
  281834:	00 03                	add    %al,(%ebx)
  281836:	80 03 80             	addb   $0x80,(%ebx)
  281839:	01 c0                	add    %eax,%eax
  28183b:	01 c0                	add    %eax,%eax
  28183d:	00 e0                	add    %ah,%al
  28183f:	00 60 00             	add    %ah,0x0(%eax)
  281842:	60                   	pusha  
  281843:	00 70 00             	add    %dh,0x0(%eax)
  281846:	30 00                	xor    %al,(%eax)
  281848:	30 00                	xor    %al,(%eax)
  28184a:	30 00                	xor    %al,(%eax)
	...
  281858:	00 00                	add    %al,(%eax)
  28185a:	e0 03                	loopne 28185f <ASCII_Table+0x487>
  28185c:	f0 07                	lock pop %es
  28185e:	38 0e                	cmp    %cl,(%esi)
  281860:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281863:	0c 18                	or     $0x18,%al
  281865:	0c 38                	or     $0x38,%al
  281867:	06                   	push   %es
  281868:	f0 07                	lock pop %es
  28186a:	f0 07                	lock pop %es
  28186c:	18 0c 0c             	sbb    %cl,(%esp,%ecx,1)
  28186f:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281872:	0c 18                	or     $0x18,%al
  281874:	0c 18                	or     $0x18,%al
  281876:	38 0c f8             	cmp    %cl,(%eax,%edi,8)
  281879:	0f e0 03             	pavgb  (%ebx),%mm0
	...
  281888:	00 00                	add    %al,(%eax)
  28188a:	e0 03                	loopne 28188f <ASCII_Table+0x4b7>
  28188c:	f0 07                	lock pop %es
  28188e:	38 0e                	cmp    %cl,(%esi)
  281890:	1c 0c                	sbb    $0xc,%al
  281892:	0c 18                	or     $0x18,%al
  281894:	0c 18                	or     $0x18,%al
  281896:	0c 18                	or     $0x18,%al
  281898:	1c 1c                	sbb    $0x1c,%al
  28189a:	38 1e                	cmp    %bl,(%esi)
  28189c:	f8                   	clc    
  28189d:	1b e0                	sbb    %eax,%esp
  28189f:	19 00                	sbb    %eax,(%eax)
  2818a1:	18 00                	sbb    %al,(%eax)
  2818a3:	0c 00                	or     $0x0,%al
  2818a5:	0c 1c                	or     $0x1c,%al
  2818a7:	0e                   	push   %cs
  2818a8:	f8                   	clc    
  2818a9:	07                   	pop    %es
  2818aa:	f0 01 00             	lock add %eax,(%eax)
	...
  2818c1:	00 00                	add    %al,(%eax)
  2818c3:	00 80 01 80 01 00    	add    %al,0x18001(%eax)
	...
  2818d5:	00 00                	add    %al,(%eax)
  2818d7:	00 80 01 80 01 00    	add    %al,0x18001(%eax)
	...
  2818f1:	00 00                	add    %al,(%eax)
  2818f3:	00 80 01 80 01 00    	add    %al,0x18001(%eax)
	...
  281905:	00 00                	add    %al,(%eax)
  281907:	00 80 01 80 01 00    	add    %al,0x18001(%eax)
  28190d:	01 00                	add    %eax,(%eax)
  28190f:	01 80 00 00 00 00    	add    %eax,0x0(%eax)
	...
  281929:	10 00                	adc    %al,(%eax)
  28192b:	1c 80                	sbb    $0x80,%al
  28192d:	0f e0 03             	pavgb  (%ebx),%mm0
  281930:	f8                   	clc    
  281931:	00 18                	add    %bl,(%eax)
  281933:	00 f8                	add    %bh,%al
  281935:	00 e0                	add    %ah,%al
  281937:	03 80 0f 00 1c 00    	add    0x1c000f(%eax),%eax
  28193d:	10 00                	adc    %al,(%eax)
	...
  281957:	00 f8                	add    %bh,%al
  281959:	1f                   	pop    %ds
  28195a:	00 00                	add    %al,(%eax)
  28195c:	00 00                	add    %al,(%eax)
  28195e:	00 00                	add    %al,(%eax)
  281960:	f8                   	clc    
  281961:	1f                   	pop    %ds
	...
  281986:	00 00                	add    %al,(%eax)
  281988:	08 00                	or     %al,(%eax)
  28198a:	38 00                	cmp    %al,(%eax)
  28198c:	f0 01 c0             	lock add %eax,%eax
  28198f:	07                   	pop    %es
  281990:	00 1f                	add    %bl,(%edi)
  281992:	00 18                	add    %bl,(%eax)
  281994:	00 1f                	add    %bl,(%edi)
  281996:	c0 07 f0             	rolb   $0xf0,(%edi)
  281999:	01 38                	add    %edi,(%eax)
  28199b:	00 08                	add    %cl,(%eax)
	...
  2819a9:	00 e0                	add    %ah,%al
  2819ab:	03 f8                	add    %eax,%edi
  2819ad:	0f 18 0c 0c          	prefetcht0 (%esp,%ecx,1)
  2819b1:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  2819b4:	00 18                	add    %bl,(%eax)
  2819b6:	00 0c 00             	add    %cl,(%eax,%eax,1)
  2819b9:	06                   	push   %es
  2819ba:	00 03                	add    %al,(%ebx)
  2819bc:	80 01 c0             	addb   $0xc0,(%ecx)
  2819bf:	00 c0                	add    %al,%al
  2819c1:	00 c0                	add    %al,%al
  2819c3:	00 00                	add    %al,(%eax)
  2819c5:	00 00                	add    %al,(%eax)
  2819c7:	00 c0                	add    %al,%al
  2819c9:	00 c0                	add    %al,%al
	...
  2819db:	00 e0                	add    %ah,%al
  2819dd:	07                   	pop    %es
  2819de:	18 18                	sbb    %bl,(%eax)
  2819e0:	04 20                	add    $0x20,%al
  2819e2:	c2 29 22             	ret    $0x2229
  2819e5:	4a                   	dec    %edx
  2819e6:	11 44 09 44          	adc    %eax,0x44(%ecx,%ecx,1)
  2819ea:	09 44 09 44          	or     %eax,0x44(%ecx,%ecx,1)
  2819ee:	09 22                	or     %esp,(%edx)
  2819f0:	11 13                	adc    %edx,(%ebx)
  2819f2:	e2 0c                	loop   281a00 <ASCII_Table+0x628>
  2819f4:	02 40 04             	add    0x4(%eax),%al
  2819f7:	20 18                	and    %bl,(%eax)
  2819f9:	18 e0                	sbb    %ah,%al
  2819fb:	07                   	pop    %es
	...
  281a08:	00 00                	add    %al,(%eax)
  281a0a:	80 03 80             	addb   $0x80,(%ebx)
  281a0d:	03 c0                	add    %eax,%eax
  281a0f:	06                   	push   %es
  281a10:	c0 06 c0             	rolb   $0xc0,(%esi)
  281a13:	06                   	push   %es
  281a14:	60                   	pusha  
  281a15:	0c 60                	or     $0x60,%al
  281a17:	0c 30                	or     $0x30,%al
  281a19:	18 30                	sbb    %dh,(%eax)
  281a1b:	18 30                	sbb    %dh,(%eax)
  281a1d:	18 f8                	sbb    %bh,%al
  281a1f:	3f                   	aas    
  281a20:	f8                   	clc    
  281a21:	3f                   	aas    
  281a22:	1c 70                	sbb    $0x70,%al
  281a24:	0c 60                	or     $0x60,%al
  281a26:	0c 60                	or     $0x60,%al
  281a28:	06                   	push   %es
  281a29:	c0 06 c0             	rolb   $0xc0,(%esi)
	...
  281a38:	00 00                	add    %al,(%eax)
  281a3a:	fc                   	cld    
  281a3b:	03 fc                	add    %esp,%edi
  281a3d:	0f 0c                	(bad)  
  281a3f:	0c 0c                	or     $0xc,%al
  281a41:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281a44:	0c 18                	or     $0x18,%al
  281a46:	0c 0c                	or     $0xc,%al
  281a48:	fc                   	cld    
  281a49:	07                   	pop    %es
  281a4a:	fc                   	cld    
  281a4b:	0f 0c                	(bad)  
  281a4d:	18 0c 30             	sbb    %cl,(%eax,%esi,1)
  281a50:	0c 30                	or     $0x30,%al
  281a52:	0c 30                	or     $0x30,%al
  281a54:	0c 30                	or     $0x30,%al
  281a56:	0c 18                	or     $0x18,%al
  281a58:	fc                   	cld    
  281a59:	1f                   	pop    %ds
  281a5a:	fc                   	cld    
  281a5b:	07                   	pop    %es
	...
  281a68:	00 00                	add    %al,(%eax)
  281a6a:	c0 07 f0             	rolb   $0xf0,(%edi)
  281a6d:	1f                   	pop    %ds
  281a6e:	38 38                	cmp    %bh,(%eax)
  281a70:	1c 30                	sbb    $0x30,%al
  281a72:	0c 70                	or     $0x70,%al
  281a74:	06                   	push   %es
  281a75:	60                   	pusha  
  281a76:	06                   	push   %es
  281a77:	00 06                	add    %al,(%esi)
  281a79:	00 06                	add    %al,(%esi)
  281a7b:	00 06                	add    %al,(%esi)
  281a7d:	00 06                	add    %al,(%esi)
  281a7f:	00 06                	add    %al,(%esi)
  281a81:	00 06                	add    %al,(%esi)
  281a83:	60                   	pusha  
  281a84:	0c 70                	or     $0x70,%al
  281a86:	1c 30                	sbb    $0x30,%al
  281a88:	f0 1f                	lock pop %ds
  281a8a:	e0 07                	loopne 281a93 <ASCII_Table+0x6bb>
	...
  281a98:	00 00                	add    %al,(%eax)
  281a9a:	fe 03                	incb   (%ebx)
  281a9c:	fe 0f                	decb   (%edi)
  281a9e:	06                   	push   %es
  281a9f:	0e                   	push   %cs
  281aa0:	06                   	push   %es
  281aa1:	18 06                	sbb    %al,(%esi)
  281aa3:	18 06                	sbb    %al,(%esi)
  281aa5:	30 06                	xor    %al,(%esi)
  281aa7:	30 06                	xor    %al,(%esi)
  281aa9:	30 06                	xor    %al,(%esi)
  281aab:	30 06                	xor    %al,(%esi)
  281aad:	30 06                	xor    %al,(%esi)
  281aaf:	30 06                	xor    %al,(%esi)
  281ab1:	30 06                	xor    %al,(%esi)
  281ab3:	18 06                	sbb    %al,(%esi)
  281ab5:	18 06                	sbb    %al,(%esi)
  281ab7:	0e                   	push   %cs
  281ab8:	fe 0f                	decb   (%edi)
  281aba:	fe 03                	incb   (%ebx)
	...
  281ac8:	00 00                	add    %al,(%eax)
  281aca:	fc                   	cld    
  281acb:	3f                   	aas    
  281acc:	fc                   	cld    
  281acd:	3f                   	aas    
  281ace:	0c 00                	or     $0x0,%al
  281ad0:	0c 00                	or     $0x0,%al
  281ad2:	0c 00                	or     $0x0,%al
  281ad4:	0c 00                	or     $0x0,%al
  281ad6:	0c 00                	or     $0x0,%al
  281ad8:	fc                   	cld    
  281ad9:	1f                   	pop    %ds
  281ada:	fc                   	cld    
  281adb:	1f                   	pop    %ds
  281adc:	0c 00                	or     $0x0,%al
  281ade:	0c 00                	or     $0x0,%al
  281ae0:	0c 00                	or     $0x0,%al
  281ae2:	0c 00                	or     $0x0,%al
  281ae4:	0c 00                	or     $0x0,%al
  281ae6:	0c 00                	or     $0x0,%al
  281ae8:	fc                   	cld    
  281ae9:	3f                   	aas    
  281aea:	fc                   	cld    
  281aeb:	3f                   	aas    
	...
  281af8:	00 00                	add    %al,(%eax)
  281afa:	f8                   	clc    
  281afb:	3f                   	aas    
  281afc:	f8                   	clc    
  281afd:	3f                   	aas    
  281afe:	18 00                	sbb    %al,(%eax)
  281b00:	18 00                	sbb    %al,(%eax)
  281b02:	18 00                	sbb    %al,(%eax)
  281b04:	18 00                	sbb    %al,(%eax)
  281b06:	18 00                	sbb    %al,(%eax)
  281b08:	f8                   	clc    
  281b09:	1f                   	pop    %ds
  281b0a:	f8                   	clc    
  281b0b:	1f                   	pop    %ds
  281b0c:	18 00                	sbb    %al,(%eax)
  281b0e:	18 00                	sbb    %al,(%eax)
  281b10:	18 00                	sbb    %al,(%eax)
  281b12:	18 00                	sbb    %al,(%eax)
  281b14:	18 00                	sbb    %al,(%eax)
  281b16:	18 00                	sbb    %al,(%eax)
  281b18:	18 00                	sbb    %al,(%eax)
  281b1a:	18 00                	sbb    %al,(%eax)
	...
  281b28:	00 00                	add    %al,(%eax)
  281b2a:	e0 0f                	loopne 281b3b <ASCII_Table+0x763>
  281b2c:	f8                   	clc    
  281b2d:	3f                   	aas    
  281b2e:	3c 78                	cmp    $0x78,%al
  281b30:	0e                   	push   %cs
  281b31:	60                   	pusha  
  281b32:	06                   	push   %es
  281b33:	e0 07                	loopne 281b3c <ASCII_Table+0x764>
  281b35:	c0 03 00             	rolb   $0x0,(%ebx)
  281b38:	03 00                	add    (%eax),%eax
  281b3a:	03 fe                	add    %esi,%edi
  281b3c:	03 fe                	add    %esi,%edi
  281b3e:	03 c0                	add    %eax,%eax
  281b40:	07                   	pop    %es
  281b41:	c0 06 c0             	rolb   $0xc0,(%esi)
  281b44:	0e                   	push   %cs
  281b45:	c0 3c f0 f8          	sarb   $0xf8,(%eax,%esi,8)
  281b49:	3f                   	aas    
  281b4a:	e0 0f                	loopne 281b5b <ASCII_Table+0x783>
	...
  281b58:	00 00                	add    %al,(%eax)
  281b5a:	0c 30                	or     $0x30,%al
  281b5c:	0c 30                	or     $0x30,%al
  281b5e:	0c 30                	or     $0x30,%al
  281b60:	0c 30                	or     $0x30,%al
  281b62:	0c 30                	or     $0x30,%al
  281b64:	0c 30                	or     $0x30,%al
  281b66:	0c 30                	or     $0x30,%al
  281b68:	fc                   	cld    
  281b69:	3f                   	aas    
  281b6a:	fc                   	cld    
  281b6b:	3f                   	aas    
  281b6c:	0c 30                	or     $0x30,%al
  281b6e:	0c 30                	or     $0x30,%al
  281b70:	0c 30                	or     $0x30,%al
  281b72:	0c 30                	or     $0x30,%al
  281b74:	0c 30                	or     $0x30,%al
  281b76:	0c 30                	or     $0x30,%al
  281b78:	0c 30                	or     $0x30,%al
  281b7a:	0c 30                	or     $0x30,%al
	...
  281b88:	00 00                	add    %al,(%eax)
  281b8a:	80 01 80             	addb   $0x80,(%ecx)
  281b8d:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281b93:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281b99:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281b9f:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281ba5:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281bab:	01 00                	add    %eax,(%eax)
	...
  281bb9:	00 00                	add    %al,(%eax)
  281bbb:	06                   	push   %es
  281bbc:	00 06                	add    %al,(%esi)
  281bbe:	00 06                	add    %al,(%esi)
  281bc0:	00 06                	add    %al,(%esi)
  281bc2:	00 06                	add    %al,(%esi)
  281bc4:	00 06                	add    %al,(%esi)
  281bc6:	00 06                	add    %al,(%esi)
  281bc8:	00 06                	add    %al,(%esi)
  281bca:	00 06                	add    %al,(%esi)
  281bcc:	00 06                	add    %al,(%esi)
  281bce:	00 06                	add    %al,(%esi)
  281bd0:	00 06                	add    %al,(%esi)
  281bd2:	18 06                	sbb    %al,(%esi)
  281bd4:	18 06                	sbb    %al,(%esi)
  281bd6:	38 07                	cmp    %al,(%edi)
  281bd8:	f0 03 e0             	lock add %eax,%esp
  281bdb:	01 00                	add    %eax,(%eax)
	...
  281be9:	00 06                	add    %al,(%esi)
  281beb:	30 06                	xor    %al,(%esi)
  281bed:	18 06                	sbb    %al,(%esi)
  281bef:	0c 06                	or     $0x6,%al
  281bf1:	06                   	push   %es
  281bf2:	06                   	push   %es
  281bf3:	03 86 01 c6 00 66    	add    0x6600c601(%esi),%eax
  281bf9:	00 76 00             	add    %dh,0x0(%esi)
  281bfc:	de 00                	fiadd  (%eax)
  281bfe:	8e 01                	mov    (%ecx),%es
  281c00:	06                   	push   %es
  281c01:	03 06                	add    (%esi),%eax
  281c03:	06                   	push   %es
  281c04:	06                   	push   %es
  281c05:	0c 06                	or     $0x6,%al
  281c07:	18 06                	sbb    %al,(%esi)
  281c09:	30 06                	xor    %al,(%esi)
  281c0b:	60                   	pusha  
	...
  281c18:	00 00                	add    %al,(%eax)
  281c1a:	18 00                	sbb    %al,(%eax)
  281c1c:	18 00                	sbb    %al,(%eax)
  281c1e:	18 00                	sbb    %al,(%eax)
  281c20:	18 00                	sbb    %al,(%eax)
  281c22:	18 00                	sbb    %al,(%eax)
  281c24:	18 00                	sbb    %al,(%eax)
  281c26:	18 00                	sbb    %al,(%eax)
  281c28:	18 00                	sbb    %al,(%eax)
  281c2a:	18 00                	sbb    %al,(%eax)
  281c2c:	18 00                	sbb    %al,(%eax)
  281c2e:	18 00                	sbb    %al,(%eax)
  281c30:	18 00                	sbb    %al,(%eax)
  281c32:	18 00                	sbb    %al,(%eax)
  281c34:	18 00                	sbb    %al,(%eax)
  281c36:	18 00                	sbb    %al,(%eax)
  281c38:	f8                   	clc    
  281c39:	1f                   	pop    %ds
  281c3a:	f8                   	clc    
  281c3b:	1f                   	pop    %ds
	...
  281c48:	00 00                	add    %al,(%eax)
  281c4a:	0e                   	push   %cs
  281c4b:	e0 1e                	loopne 281c6b <ASCII_Table+0x893>
  281c4d:	f0 1e                	lock push %ds
  281c4f:	f0 1e                	lock push %ds
  281c51:	f0 36 d8 36          	lock fdivs %ss:(%esi)
  281c55:	d8 36                	fdivs  (%esi)
  281c57:	d8 36                	fdivs  (%esi)
  281c59:	d8 66 cc             	fsubs  -0x34(%esi)
  281c5c:	66                   	data16
  281c5d:	cc                   	int3   
  281c5e:	66                   	data16
  281c5f:	cc                   	int3   
  281c60:	c6 c6 c6             	mov    $0xc6,%dh
  281c63:	c6 c6 c6             	mov    $0xc6,%dh
  281c66:	c6 c6 86             	mov    $0x86,%dh
  281c69:	c3                   	ret    
  281c6a:	86 c3                	xchg   %al,%bl
	...
  281c78:	00 00                	add    %al,(%eax)
  281c7a:	0c 30                	or     $0x30,%al
  281c7c:	1c 30                	sbb    $0x30,%al
  281c7e:	3c 30                	cmp    $0x30,%al
  281c80:	3c 30                	cmp    $0x30,%al
  281c82:	6c                   	insb   (%dx),%es:(%edi)
  281c83:	30 6c 30 cc          	xor    %ch,-0x34(%eax,%esi,1)
  281c87:	30 cc                	xor    %cl,%ah
  281c89:	30 8c 31 0c 33 0c 33 	xor    %cl,0x330c330c(%ecx,%esi,1)
  281c90:	0c 36                	or     $0x36,%al
  281c92:	0c 36                	or     $0x36,%al
  281c94:	0c 3c                	or     $0x3c,%al
  281c96:	0c 3c                	or     $0x3c,%al
  281c98:	0c 38                	or     $0x38,%al
  281c9a:	0c 30                	or     $0x30,%al
	...
  281ca8:	00 00                	add    %al,(%eax)
  281caa:	e0 07                	loopne 281cb3 <ASCII_Table+0x8db>
  281cac:	f8                   	clc    
  281cad:	1f                   	pop    %ds
  281cae:	1c 38                	sbb    $0x38,%al
  281cb0:	0e                   	push   %cs
  281cb1:	70 06                	jo     281cb9 <ASCII_Table+0x8e1>
  281cb3:	60                   	pusha  
  281cb4:	03 c0                	add    %eax,%eax
  281cb6:	03 c0                	add    %eax,%eax
  281cb8:	03 c0                	add    %eax,%eax
  281cba:	03 c0                	add    %eax,%eax
  281cbc:	03 c0                	add    %eax,%eax
  281cbe:	03 c0                	add    %eax,%eax
  281cc0:	03 c0                	add    %eax,%eax
  281cc2:	06                   	push   %es
  281cc3:	60                   	pusha  
  281cc4:	0e                   	push   %cs
  281cc5:	70 1c                	jo     281ce3 <ASCII_Table+0x90b>
  281cc7:	38 f8                	cmp    %bh,%al
  281cc9:	1f                   	pop    %ds
  281cca:	e0 07                	loopne 281cd3 <ASCII_Table+0x8fb>
	...
  281cd8:	00 00                	add    %al,(%eax)
  281cda:	fc                   	cld    
  281cdb:	0f fc 1f             	paddb  (%edi),%mm3
  281cde:	0c 38                	or     $0x38,%al
  281ce0:	0c 30                	or     $0x30,%al
  281ce2:	0c 30                	or     $0x30,%al
  281ce4:	0c 30                	or     $0x30,%al
  281ce6:	0c 30                	or     $0x30,%al
  281ce8:	0c 18                	or     $0x18,%al
  281cea:	fc                   	cld    
  281ceb:	1f                   	pop    %ds
  281cec:	fc                   	cld    
  281ced:	07                   	pop    %es
  281cee:	0c 00                	or     $0x0,%al
  281cf0:	0c 00                	or     $0x0,%al
  281cf2:	0c 00                	or     $0x0,%al
  281cf4:	0c 00                	or     $0x0,%al
  281cf6:	0c 00                	or     $0x0,%al
  281cf8:	0c 00                	or     $0x0,%al
  281cfa:	0c 00                	or     $0x0,%al
	...
  281d08:	00 00                	add    %al,(%eax)
  281d0a:	e0 07                	loopne 281d13 <ASCII_Table+0x93b>
  281d0c:	f8                   	clc    
  281d0d:	1f                   	pop    %ds
  281d0e:	1c 38                	sbb    $0x38,%al
  281d10:	0e                   	push   %cs
  281d11:	70 06                	jo     281d19 <ASCII_Table+0x941>
  281d13:	60                   	pusha  
  281d14:	03 e0                	add    %eax,%esp
  281d16:	03 c0                	add    %eax,%eax
  281d18:	03 c0                	add    %eax,%eax
  281d1a:	03 c0                	add    %eax,%eax
  281d1c:	03 c0                	add    %eax,%eax
  281d1e:	03 c0                	add    %eax,%eax
  281d20:	07                   	pop    %es
  281d21:	e0 06                	loopne 281d29 <ASCII_Table+0x951>
  281d23:	63 0e                	arpl   %cx,(%esi)
  281d25:	3f                   	aas    
  281d26:	1c 3c                	sbb    $0x3c,%al
  281d28:	f8                   	clc    
  281d29:	3f                   	aas    
  281d2a:	e0 f7                	loopne 281d23 <ASCII_Table+0x94b>
  281d2c:	00 c0                	add    %al,%al
	...
  281d3a:	fe 0f                	decb   (%edi)
  281d3c:	fe                   	(bad)  
  281d3d:	1f                   	pop    %ds
  281d3e:	06                   	push   %es
  281d3f:	38 06                	cmp    %al,(%esi)
  281d41:	30 06                	xor    %al,(%esi)
  281d43:	30 06                	xor    %al,(%esi)
  281d45:	30 06                	xor    %al,(%esi)
  281d47:	38 fe                	cmp    %bh,%dh
  281d49:	1f                   	pop    %ds
  281d4a:	fe 07                	incb   (%edi)
  281d4c:	06                   	push   %es
  281d4d:	03 06                	add    (%esi),%eax
  281d4f:	06                   	push   %es
  281d50:	06                   	push   %es
  281d51:	0c 06                	or     $0x6,%al
  281d53:	18 06                	sbb    %al,(%esi)
  281d55:	18 06                	sbb    %al,(%esi)
  281d57:	30 06                	xor    %al,(%esi)
  281d59:	30 06                	xor    %al,(%esi)
  281d5b:	60                   	pusha  
	...
  281d68:	00 00                	add    %al,(%eax)
  281d6a:	e0 03                	loopne 281d6f <ASCII_Table+0x997>
  281d6c:	f8                   	clc    
  281d6d:	0f 1c 0c 0c          	nopl   (%esp,%ecx,1)
  281d71:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281d74:	0c 00                	or     $0x0,%al
  281d76:	1c 00                	sbb    $0x0,%al
  281d78:	f8                   	clc    
  281d79:	03 e0                	add    %eax,%esp
  281d7b:	0f 00 1e             	ltr    (%esi)
  281d7e:	00 38                	add    %bh,(%eax)
  281d80:	06                   	push   %es
  281d81:	30 06                	xor    %al,(%esi)
  281d83:	30 0e                	xor    %cl,(%esi)
  281d85:	30 1c 1c             	xor    %bl,(%esp,%ebx,1)
  281d88:	f8                   	clc    
  281d89:	0f e0 07             	pavgb  (%edi),%mm0
	...
  281d98:	00 00                	add    %al,(%eax)
  281d9a:	fe                   	(bad)  
  281d9b:	7f fe                	jg     281d9b <ASCII_Table+0x9c3>
  281d9d:	7f 80                	jg     281d1f <ASCII_Table+0x947>
  281d9f:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281da5:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281dab:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281db1:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281db7:	01 80 01 80 01 00    	add    %eax,0x18001(%eax)
	...
  281dc9:	00 0c 30             	add    %cl,(%eax,%esi,1)
  281dcc:	0c 30                	or     $0x30,%al
  281dce:	0c 30                	or     $0x30,%al
  281dd0:	0c 30                	or     $0x30,%al
  281dd2:	0c 30                	or     $0x30,%al
  281dd4:	0c 30                	or     $0x30,%al
  281dd6:	0c 30                	or     $0x30,%al
  281dd8:	0c 30                	or     $0x30,%al
  281dda:	0c 30                	or     $0x30,%al
  281ddc:	0c 30                	or     $0x30,%al
  281dde:	0c 30                	or     $0x30,%al
  281de0:	0c 30                	or     $0x30,%al
  281de2:	0c 30                	or     $0x30,%al
  281de4:	0c 30                	or     $0x30,%al
  281de6:	18 18                	sbb    %bl,(%eax)
  281de8:	f8                   	clc    
  281de9:	1f                   	pop    %ds
  281dea:	e0 07                	loopne 281df3 <ASCII_Table+0xa1b>
	...
  281df8:	00 00                	add    %al,(%eax)
  281dfa:	03 60 06             	add    0x6(%eax),%esp
  281dfd:	30 06                	xor    %al,(%esi)
  281dff:	30 06                	xor    %al,(%esi)
  281e01:	30 0c 18             	xor    %cl,(%eax,%ebx,1)
  281e04:	0c 18                	or     $0x18,%al
  281e06:	0c 18                	or     $0x18,%al
  281e08:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281e0b:	0c 38                	or     $0x38,%al
  281e0d:	0e                   	push   %cs
  281e0e:	30 06                	xor    %al,(%esi)
  281e10:	30 06                	xor    %al,(%esi)
  281e12:	70 07                	jo     281e1b <ASCII_Table+0xa43>
  281e14:	60                   	pusha  
  281e15:	03 60 03             	add    0x3(%eax),%esp
  281e18:	c0 01 c0             	rolb   $0xc0,(%ecx)
  281e1b:	01 00                	add    %eax,(%eax)
	...
  281e29:	00 03                	add    %al,(%ebx)
  281e2b:	60                   	pusha  
  281e2c:	c3                   	ret    
  281e2d:	61                   	popa   
  281e2e:	c3                   	ret    
  281e2f:	61                   	popa   
  281e30:	c3                   	ret    
  281e31:	61                   	popa   
  281e32:	66 33 66 33          	xor    0x33(%esi),%sp
  281e36:	66 33 66 33          	xor    0x33(%esi),%sp
  281e3a:	66 33 66 33          	xor    0x33(%esi),%sp
  281e3e:	6c                   	insb   (%dx),%es:(%edi)
  281e3f:	1b 6c 1b 6c          	sbb    0x6c(%ebx,%ebx,1),%ebp
  281e43:	1b 2c 1a             	sbb    (%edx,%ebx,1),%ebp
  281e46:	3c 1e                	cmp    $0x1e,%al
  281e48:	38 0e                	cmp    %cl,(%esi)
  281e4a:	38 0e                	cmp    %cl,(%esi)
	...
  281e58:	00 00                	add    %al,(%eax)
  281e5a:	0f e0 0c 70          	pavgb  (%eax,%esi,2),%mm1
  281e5e:	18 30                	sbb    %dh,(%eax)
  281e60:	30 18                	xor    %bl,(%eax)
  281e62:	70 0c                	jo     281e70 <ASCII_Table+0xa98>
  281e64:	60                   	pusha  
  281e65:	0e                   	push   %cs
  281e66:	c0 07 80             	rolb   $0x80,(%edi)
  281e69:	03 80 03 c0 03 e0    	add    -0x1ffc3ffd(%eax),%eax
  281e6f:	06                   	push   %es
  281e70:	70 0c                	jo     281e7e <ASCII_Table+0xaa6>
  281e72:	30 1c 18             	xor    %bl,(%eax,%ebx,1)
  281e75:	18 0c 30             	sbb    %cl,(%eax,%esi,1)
  281e78:	0e                   	push   %cs
  281e79:	60                   	pusha  
  281e7a:	07                   	pop    %es
  281e7b:	e0 00                	loopne 281e7d <ASCII_Table+0xaa5>
	...
  281e89:	00 03                	add    %al,(%ebx)
  281e8b:	c0 06 60             	rolb   $0x60,(%esi)
  281e8e:	0c 30                	or     $0x30,%al
  281e90:	1c 38                	sbb    $0x38,%al
  281e92:	38 18                	cmp    %bl,(%eax)
  281e94:	30 0c 60             	xor    %cl,(%eax,%eiz,2)
  281e97:	06                   	push   %es
  281e98:	e0 07                	loopne 281ea1 <ASCII_Table+0xac9>
  281e9a:	c0 03 80             	rolb   $0x80,(%ebx)
  281e9d:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281ea3:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281ea9:	01 80 01 00 00 00    	add    %eax,0x1(%eax)
	...
  281eb7:	00 00                	add    %al,(%eax)
  281eb9:	00 fc                	add    %bh,%ah
  281ebb:	7f fc                	jg     281eb9 <ASCII_Table+0xae1>
  281ebd:	7f 00                	jg     281ebf <ASCII_Table+0xae7>
  281ebf:	60                   	pusha  
  281ec0:	00 30                	add    %dh,(%eax)
  281ec2:	00 18                	add    %bl,(%eax)
  281ec4:	00 0c 00             	add    %cl,(%eax,%eax,1)
  281ec7:	06                   	push   %es
  281ec8:	00 03                	add    %al,(%ebx)
  281eca:	80 01 c0             	addb   $0xc0,(%ecx)
  281ecd:	00 60 00             	add    %ah,0x0(%eax)
  281ed0:	30 00                	xor    %al,(%eax)
  281ed2:	18 00                	sbb    %al,(%eax)
  281ed4:	0c 00                	or     $0x0,%al
  281ed6:	06                   	push   %es
  281ed7:	00 fe                	add    %bh,%dh
  281ed9:	7f fe                	jg     281ed9 <ASCII_Table+0xb01>
  281edb:	7f 00                	jg     281edd <ASCII_Table+0xb05>
	...
  281ee9:	00 e0                	add    %ah,%al
  281eeb:	03 e0                	add    %eax,%esp
  281eed:	03 60 00             	add    0x0(%eax),%esp
  281ef0:	60                   	pusha  
  281ef1:	00 60 00             	add    %ah,0x0(%eax)
  281ef4:	60                   	pusha  
  281ef5:	00 60 00             	add    %ah,0x0(%eax)
  281ef8:	60                   	pusha  
  281ef9:	00 60 00             	add    %ah,0x0(%eax)
  281efc:	60                   	pusha  
  281efd:	00 60 00             	add    %ah,0x0(%eax)
  281f00:	60                   	pusha  
  281f01:	00 60 00             	add    %ah,0x0(%eax)
  281f04:	60                   	pusha  
  281f05:	00 60 00             	add    %ah,0x0(%eax)
  281f08:	60                   	pusha  
  281f09:	00 60 00             	add    %ah,0x0(%eax)
  281f0c:	60                   	pusha  
  281f0d:	00 60 00             	add    %ah,0x0(%eax)
  281f10:	60                   	pusha  
  281f11:	00 e0                	add    %ah,%al
  281f13:	03 e0                	add    %eax,%esp
  281f15:	03 00                	add    (%eax),%eax
  281f17:	00 00                	add    %al,(%eax)
  281f19:	00 30                	add    %dh,(%eax)
  281f1b:	00 30                	add    %dh,(%eax)
  281f1d:	00 60 00             	add    %ah,0x0(%eax)
  281f20:	60                   	pusha  
  281f21:	00 60 00             	add    %ah,0x0(%eax)
  281f24:	c0 00 c0             	rolb   $0xc0,(%eax)
  281f27:	00 c0                	add    %al,%al
  281f29:	00 c0                	add    %al,%al
  281f2b:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281f31:	01 00                	add    %eax,(%eax)
  281f33:	03 00                	add    (%eax),%eax
  281f35:	03 00                	add    (%eax),%eax
  281f37:	03 00                	add    (%eax),%eax
  281f39:	06                   	push   %es
  281f3a:	00 06                	add    %al,(%esi)
	...
  281f48:	00 00                	add    %al,(%eax)
  281f4a:	e0 03                	loopne 281f4f <ASCII_Table+0xb77>
  281f4c:	e0 03                	loopne 281f51 <ASCII_Table+0xb79>
  281f4e:	00 03                	add    %al,(%ebx)
  281f50:	00 03                	add    %al,(%ebx)
  281f52:	00 03                	add    %al,(%ebx)
  281f54:	00 03                	add    %al,(%ebx)
  281f56:	00 03                	add    %al,(%ebx)
  281f58:	00 03                	add    %al,(%ebx)
  281f5a:	00 03                	add    %al,(%ebx)
  281f5c:	00 03                	add    %al,(%ebx)
  281f5e:	00 03                	add    %al,(%ebx)
  281f60:	00 03                	add    %al,(%ebx)
  281f62:	00 03                	add    %al,(%ebx)
  281f64:	00 03                	add    %al,(%ebx)
  281f66:	00 03                	add    %al,(%ebx)
  281f68:	00 03                	add    %al,(%ebx)
  281f6a:	00 03                	add    %al,(%ebx)
  281f6c:	00 03                	add    %al,(%ebx)
  281f6e:	00 03                	add    %al,(%ebx)
  281f70:	00 03                	add    %al,(%ebx)
  281f72:	e0 03                	loopne 281f77 <ASCII_Table+0xb9f>
  281f74:	e0 03                	loopne 281f79 <ASCII_Table+0xba1>
  281f76:	00 00                	add    %al,(%eax)
  281f78:	00 00                	add    %al,(%eax)
  281f7a:	00 00                	add    %al,(%eax)
  281f7c:	c0 01 c0             	rolb   $0xc0,(%ecx)
  281f7f:	01 60 03             	add    %esp,0x3(%eax)
  281f82:	60                   	pusha  
  281f83:	03 60 03             	add    0x3(%eax),%esp
  281f86:	30 06                	xor    %al,(%esi)
  281f88:	30 06                	xor    %al,(%esi)
  281f8a:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281f8d:	0c 00                	or     $0x0,%al
	...
  281fc7:	00 00                	add    %al,(%eax)
  281fc9:	00 ff                	add    %bh,%bh
  281fcb:	ff                   	(bad)  
  281fcc:	ff                   	(bad)  
  281fcd:	ff 00                	incl   (%eax)
	...
  281fd7:	00 00                	add    %al,(%eax)
  281fd9:	00 0c 00             	add    %cl,(%eax,%eax,1)
  281fdc:	0c 00                	or     $0x0,%al
  281fde:	0c 00                	or     $0x0,%al
  281fe0:	0c 00                	or     $0x0,%al
  281fe2:	0c 00                	or     $0x0,%al
  281fe4:	0c 00                	or     $0x0,%al
	...
  282012:	00 00                	add    %al,(%eax)
  282014:	f0 03 f8             	lock add %eax,%edi
  282017:	07                   	pop    %es
  282018:	1c 0c                	sbb    $0xc,%al
  28201a:	0c 0c                	or     $0xc,%al
  28201c:	00 0f                	add    %cl,(%edi)
  28201e:	f0 0f f8 0c 0c       	lock psubb (%esp,%ecx,1),%mm1
  282023:	0c 0c                	or     $0xc,%al
  282025:	0c 1c                	or     $0x1c,%al
  282027:	0f f8 0f             	psubb  (%edi),%mm1
  28202a:	f0 18 00             	lock sbb %al,(%eax)
	...
  282039:	00 18                	add    %bl,(%eax)
  28203b:	00 18                	add    %bl,(%eax)
  28203d:	00 18                	add    %bl,(%eax)
  28203f:	00 18                	add    %bl,(%eax)
  282041:	00 18                	add    %bl,(%eax)
  282043:	00 d8                	add    %bl,%al
  282045:	03 f8                	add    %eax,%edi
  282047:	0f 38 0c             	(bad)  
  28204a:	18 18                	sbb    %bl,(%eax)
  28204c:	18 18                	sbb    %bl,(%eax)
  28204e:	18 18                	sbb    %bl,(%eax)
  282050:	18 18                	sbb    %bl,(%eax)
  282052:	18 18                	sbb    %bl,(%eax)
  282054:	18 18                	sbb    %bl,(%eax)
  282056:	38 0c f8             	cmp    %cl,(%eax,%edi,8)
  282059:	0f d8 03             	psubusb (%ebx),%mm0
	...
  282074:	c0 03 f0             	rolb   $0xf0,(%ebx)
  282077:	07                   	pop    %es
  282078:	30 0e                	xor    %cl,(%esi)
  28207a:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  28207d:	00 18                	add    %bl,(%eax)
  28207f:	00 18                	add    %bl,(%eax)
  282081:	00 18                	add    %bl,(%eax)
  282083:	00 18                	add    %bl,(%eax)
  282085:	0c 30                	or     $0x30,%al
  282087:	0e                   	push   %cs
  282088:	f0 07                	lock pop %es
  28208a:	c0 03 00             	rolb   $0x0,(%ebx)
	...
  282099:	00 00                	add    %al,(%eax)
  28209b:	18 00                	sbb    %al,(%eax)
  28209d:	18 00                	sbb    %al,(%eax)
  28209f:	18 00                	sbb    %al,(%eax)
  2820a1:	18 00                	sbb    %al,(%eax)
  2820a3:	18 c0                	sbb    %al,%al
  2820a5:	1b f0                	sbb    %eax,%esi
  2820a7:	1f                   	pop    %ds
  2820a8:	30 1c 18             	xor    %bl,(%eax,%ebx,1)
  2820ab:	18 18                	sbb    %bl,(%eax)
  2820ad:	18 18                	sbb    %bl,(%eax)
  2820af:	18 18                	sbb    %bl,(%eax)
  2820b1:	18 18                	sbb    %bl,(%eax)
  2820b3:	18 18                	sbb    %bl,(%eax)
  2820b5:	18 30                	sbb    %dh,(%eax)
  2820b7:	1c f0                	sbb    $0xf0,%al
  2820b9:	1f                   	pop    %ds
  2820ba:	c0 1b 00             	rcrb   $0x0,(%ebx)
	...
  2820d1:	00 00                	add    %al,(%eax)
  2820d3:	00 c0                	add    %al,%al
  2820d5:	03 f0                	add    %eax,%esi
  2820d7:	0f 30                	wrmsr  
  2820d9:	0c 18                	or     $0x18,%al
  2820db:	18 f8                	sbb    %bh,%al
  2820dd:	1f                   	pop    %ds
  2820de:	f8                   	clc    
  2820df:	1f                   	pop    %ds
  2820e0:	18 00                	sbb    %al,(%eax)
  2820e2:	18 00                	sbb    %al,(%eax)
  2820e4:	38 18                	cmp    %bl,(%eax)
  2820e6:	30 1c f0             	xor    %bl,(%eax,%esi,8)
  2820e9:	0f c0 07             	xadd   %al,(%edi)
	...
  2820f8:	00 00                	add    %al,(%eax)
  2820fa:	80 0f c0             	orb    $0xc0,(%edi)
  2820fd:	0f c0 00             	xadd   %al,(%eax)
  282100:	c0 00 c0             	rolb   $0xc0,(%eax)
  282103:	00 f0                	add    %dh,%al
  282105:	07                   	pop    %es
  282106:	f0 07                	lock pop %es
  282108:	c0 00 c0             	rolb   $0xc0,(%eax)
  28210b:	00 c0                	add    %al,%al
  28210d:	00 c0                	add    %al,%al
  28210f:	00 c0                	add    %al,%al
  282111:	00 c0                	add    %al,%al
  282113:	00 c0                	add    %al,%al
  282115:	00 c0                	add    %al,%al
  282117:	00 c0                	add    %al,%al
  282119:	00 c0                	add    %al,%al
	...
  282133:	00 e0                	add    %ah,%al
  282135:	0d f8 0f 18 0e       	or     $0xe180ff8,%eax
  28213a:	0c 0c                	or     $0xc,%al
  28213c:	0c 0c                	or     $0xc,%al
  28213e:	0c 0c                	or     $0xc,%al
  282140:	0c 0c                	or     $0xc,%al
  282142:	0c 0c                	or     $0xc,%al
  282144:	0c 0c                	or     $0xc,%al
  282146:	18 0e                	sbb    %cl,(%esi)
  282148:	f8                   	clc    
  282149:	0f e0 0d 00 0c 0c 0c 	pavgb  0xc0c0c00,%mm1
  282150:	1c 06                	sbb    $0x6,%al
  282152:	f8                   	clc    
  282153:	07                   	pop    %es
  282154:	f0 01 00             	lock add %eax,(%eax)
  282157:	00 00                	add    %al,(%eax)
  282159:	00 18                	add    %bl,(%eax)
  28215b:	00 18                	add    %bl,(%eax)
  28215d:	00 18                	add    %bl,(%eax)
  28215f:	00 18                	add    %bl,(%eax)
  282161:	00 18                	add    %bl,(%eax)
  282163:	00 d8                	add    %bl,%al
  282165:	07                   	pop    %es
  282166:	f8                   	clc    
  282167:	0f 38 1c 18          	pabsb  (%eax),%mm3
  28216b:	18 18                	sbb    %bl,(%eax)
  28216d:	18 18                	sbb    %bl,(%eax)
  28216f:	18 18                	sbb    %bl,(%eax)
  282171:	18 18                	sbb    %bl,(%eax)
  282173:	18 18                	sbb    %bl,(%eax)
  282175:	18 18                	sbb    %bl,(%eax)
  282177:	18 18                	sbb    %bl,(%eax)
  282179:	18 18                	sbb    %bl,(%eax)
  28217b:	18 00                	sbb    %al,(%eax)
	...
  282189:	00 c0                	add    %al,%al
  28218b:	00 c0                	add    %al,%al
  28218d:	00 00                	add    %al,(%eax)
  28218f:	00 00                	add    %al,(%eax)
  282191:	00 00                	add    %al,(%eax)
  282193:	00 c0                	add    %al,%al
  282195:	00 c0                	add    %al,%al
  282197:	00 c0                	add    %al,%al
  282199:	00 c0                	add    %al,%al
  28219b:	00 c0                	add    %al,%al
  28219d:	00 c0                	add    %al,%al
  28219f:	00 c0                	add    %al,%al
  2821a1:	00 c0                	add    %al,%al
  2821a3:	00 c0                	add    %al,%al
  2821a5:	00 c0                	add    %al,%al
  2821a7:	00 c0                	add    %al,%al
  2821a9:	00 c0                	add    %al,%al
	...
  2821b7:	00 00                	add    %al,(%eax)
  2821b9:	00 c0                	add    %al,%al
  2821bb:	00 c0                	add    %al,%al
  2821bd:	00 00                	add    %al,(%eax)
  2821bf:	00 00                	add    %al,(%eax)
  2821c1:	00 00                	add    %al,(%eax)
  2821c3:	00 c0                	add    %al,%al
  2821c5:	00 c0                	add    %al,%al
  2821c7:	00 c0                	add    %al,%al
  2821c9:	00 c0                	add    %al,%al
  2821cb:	00 c0                	add    %al,%al
  2821cd:	00 c0                	add    %al,%al
  2821cf:	00 c0                	add    %al,%al
  2821d1:	00 c0                	add    %al,%al
  2821d3:	00 c0                	add    %al,%al
  2821d5:	00 c0                	add    %al,%al
  2821d7:	00 c0                	add    %al,%al
  2821d9:	00 c0                	add    %al,%al
  2821db:	00 c0                	add    %al,%al
  2821dd:	00 c0                	add    %al,%al
  2821df:	00 c0                	add    %al,%al
  2821e1:	00 f8                	add    %bh,%al
  2821e3:	00 78 00             	add    %bh,0x0(%eax)
  2821e6:	00 00                	add    %al,(%eax)
  2821e8:	00 00                	add    %al,(%eax)
  2821ea:	0c 00                	or     $0x0,%al
  2821ec:	0c 00                	or     $0x0,%al
  2821ee:	0c 00                	or     $0x0,%al
  2821f0:	0c 00                	or     $0x0,%al
  2821f2:	0c 00                	or     $0x0,%al
  2821f4:	0c 0c                	or     $0xc,%al
  2821f6:	0c 06                	or     $0x6,%al
  2821f8:	0c 03                	or     $0x3,%al
  2821fa:	8c 01                	mov    %es,(%ecx)
  2821fc:	cc                   	int3   
  2821fd:	00 6c 00 fc          	add    %ch,-0x4(%eax,%eax,1)
  282201:	00 9c 01 8c 03 0c 03 	add    %bl,0x30c038c(%ecx,%eax,1)
  282208:	0c 06                	or     $0x6,%al
  28220a:	0c 0c                	or     $0xc,%al
	...
  282218:	00 00                	add    %al,(%eax)
  28221a:	c0 00 c0             	rolb   $0xc0,(%eax)
  28221d:	00 c0                	add    %al,%al
  28221f:	00 c0                	add    %al,%al
  282221:	00 c0                	add    %al,%al
  282223:	00 c0                	add    %al,%al
  282225:	00 c0                	add    %al,%al
  282227:	00 c0                	add    %al,%al
  282229:	00 c0                	add    %al,%al
  28222b:	00 c0                	add    %al,%al
  28222d:	00 c0                	add    %al,%al
  28222f:	00 c0                	add    %al,%al
  282231:	00 c0                	add    %al,%al
  282233:	00 c0                	add    %al,%al
  282235:	00 c0                	add    %al,%al
  282237:	00 c0                	add    %al,%al
  282239:	00 c0                	add    %al,%al
	...
  282253:	00 7c 3c ff          	add    %bh,-0x1(%esp,%edi,1)
  282257:	7e c7                	jle    282220 <ASCII_Table+0xe48>
  282259:	e3 83                	jecxz  2821de <ASCII_Table+0xe06>
  28225b:	c1 83 c1 83 c1 83 c1 	roll   $0xc1,-0x7c3e7c3f(%ebx)
  282262:	83 c1 83             	add    $0xffffff83,%ecx
  282265:	c1 83 c1 83 c1 83 c1 	roll   $0xc1,-0x7c3e7c3f(%ebx)
	...
  282284:	98                   	cwtl   
  282285:	07                   	pop    %es
  282286:	f8                   	clc    
  282287:	0f 38 1c 18          	pabsb  (%eax),%mm3
  28228b:	18 18                	sbb    %bl,(%eax)
  28228d:	18 18                	sbb    %bl,(%eax)
  28228f:	18 18                	sbb    %bl,(%eax)
  282291:	18 18                	sbb    %bl,(%eax)
  282293:	18 18                	sbb    %bl,(%eax)
  282295:	18 18                	sbb    %bl,(%eax)
  282297:	18 18                	sbb    %bl,(%eax)
  282299:	18 18                	sbb    %bl,(%eax)
  28229b:	18 00                	sbb    %al,(%eax)
	...
  2822b1:	00 00                	add    %al,(%eax)
  2822b3:	00 c0                	add    %al,%al
  2822b5:	03 f0                	add    %eax,%esi
  2822b7:	0f 30                	wrmsr  
  2822b9:	0c 18                	or     $0x18,%al
  2822bb:	18 18                	sbb    %bl,(%eax)
  2822bd:	18 18                	sbb    %bl,(%eax)
  2822bf:	18 18                	sbb    %bl,(%eax)
  2822c1:	18 18                	sbb    %bl,(%eax)
  2822c3:	18 18                	sbb    %bl,(%eax)
  2822c5:	18 30                	sbb    %dh,(%eax)
  2822c7:	0c f0                	or     $0xf0,%al
  2822c9:	0f c0 03             	xadd   %al,(%ebx)
	...
  2822e4:	d8 03                	fadds  (%ebx)
  2822e6:	f8                   	clc    
  2822e7:	0f 38 0c             	(bad)  
  2822ea:	18 18                	sbb    %bl,(%eax)
  2822ec:	18 18                	sbb    %bl,(%eax)
  2822ee:	18 18                	sbb    %bl,(%eax)
  2822f0:	18 18                	sbb    %bl,(%eax)
  2822f2:	18 18                	sbb    %bl,(%eax)
  2822f4:	18 18                	sbb    %bl,(%eax)
  2822f6:	38 0c f8             	cmp    %cl,(%eax,%edi,8)
  2822f9:	0f d8 03             	psubusb (%ebx),%mm0
  2822fc:	18 00                	sbb    %al,(%eax)
  2822fe:	18 00                	sbb    %al,(%eax)
  282300:	18 00                	sbb    %al,(%eax)
  282302:	18 00                	sbb    %al,(%eax)
  282304:	18 00                	sbb    %al,(%eax)
	...
  282312:	00 00                	add    %al,(%eax)
  282314:	c0 1b f0             	rcrb   $0xf0,(%ebx)
  282317:	1f                   	pop    %ds
  282318:	30 1c 18             	xor    %bl,(%eax,%ebx,1)
  28231b:	18 18                	sbb    %bl,(%eax)
  28231d:	18 18                	sbb    %bl,(%eax)
  28231f:	18 18                	sbb    %bl,(%eax)
  282321:	18 18                	sbb    %bl,(%eax)
  282323:	18 18                	sbb    %bl,(%eax)
  282325:	18 30                	sbb    %dh,(%eax)
  282327:	1c f0                	sbb    $0xf0,%al
  282329:	1f                   	pop    %ds
  28232a:	c0 1b 00             	rcrb   $0x0,(%ebx)
  28232d:	18 00                	sbb    %al,(%eax)
  28232f:	18 00                	sbb    %al,(%eax)
  282331:	18 00                	sbb    %al,(%eax)
  282333:	18 00                	sbb    %al,(%eax)
  282335:	18 00                	sbb    %al,(%eax)
	...
  282343:	00 b0 07 f0 03 70    	add    %dh,0x7003f007(%eax)
  282349:	00 30                	add    %dh,(%eax)
  28234b:	00 30                	add    %dh,(%eax)
  28234d:	00 30                	add    %dh,(%eax)
  28234f:	00 30                	add    %dh,(%eax)
  282351:	00 30                	add    %dh,(%eax)
  282353:	00 30                	add    %dh,(%eax)
  282355:	00 30                	add    %dh,(%eax)
  282357:	00 30                	add    %dh,(%eax)
  282359:	00 30                	add    %dh,(%eax)
	...
  282373:	00 e0                	add    %ah,%al
  282375:	03 f0                	add    %eax,%esi
  282377:	03 38                	add    (%eax),%edi
  282379:	0e                   	push   %cs
  28237a:	18 0c 38             	sbb    %cl,(%eax,%edi,1)
  28237d:	00 f0                	add    %dh,%al
  28237f:	03 c0                	add    %eax,%eax
  282381:	07                   	pop    %es
  282382:	00 0c 18             	add    %cl,(%eax,%ebx,1)
  282385:	0c 38                	or     $0x38,%al
  282387:	0e                   	push   %cs
  282388:	f0 07                	lock pop %es
  28238a:	e0 03                	loopne 28238f <ASCII_Table+0xfb7>
	...
  28239c:	80 00 c0             	addb   $0xc0,(%eax)
  28239f:	00 c0                	add    %al,%al
  2823a1:	00 c0                	add    %al,%al
  2823a3:	00 f0                	add    %dh,%al
  2823a5:	07                   	pop    %es
  2823a6:	f0 07                	lock pop %es
  2823a8:	c0 00 c0             	rolb   $0xc0,(%eax)
  2823ab:	00 c0                	add    %al,%al
  2823ad:	00 c0                	add    %al,%al
  2823af:	00 c0                	add    %al,%al
  2823b1:	00 c0                	add    %al,%al
  2823b3:	00 c0                	add    %al,%al
  2823b5:	00 c0                	add    %al,%al
  2823b7:	00 c0                	add    %al,%al
  2823b9:	07                   	pop    %es
  2823ba:	80 07 00             	addb   $0x0,(%edi)
	...
  2823d1:	00 00                	add    %al,(%eax)
  2823d3:	00 18                	add    %bl,(%eax)
  2823d5:	18 18                	sbb    %bl,(%eax)
  2823d7:	18 18                	sbb    %bl,(%eax)
  2823d9:	18 18                	sbb    %bl,(%eax)
  2823db:	18 18                	sbb    %bl,(%eax)
  2823dd:	18 18                	sbb    %bl,(%eax)
  2823df:	18 18                	sbb    %bl,(%eax)
  2823e1:	18 18                	sbb    %bl,(%eax)
  2823e3:	18 18                	sbb    %bl,(%eax)
  2823e5:	18 38                	sbb    %bh,(%eax)
  2823e7:	1c f0                	sbb    $0xf0,%al
  2823e9:	1f                   	pop    %ds
  2823ea:	e0 19                	loopne 282405 <ASCII_Table+0x102d>
	...
  282404:	0c 18                	or     $0x18,%al
  282406:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  282409:	0c 18                	or     $0x18,%al
  28240b:	0c 30                	or     $0x30,%al
  28240d:	06                   	push   %es
  28240e:	30 06                	xor    %al,(%esi)
  282410:	30 06                	xor    %al,(%esi)
  282412:	60                   	pusha  
  282413:	03 60 03             	add    0x3(%eax),%esp
  282416:	60                   	pusha  
  282417:	03 c0                	add    %eax,%eax
  282419:	01 c0                	add    %eax,%eax
  28241b:	01 00                	add    %eax,(%eax)
	...
  282431:	00 00                	add    %al,(%eax)
  282433:	00 c1                	add    %al,%cl
  282435:	41                   	inc    %ecx
  282436:	c1 41 c3 61          	roll   $0x61,-0x3d(%ecx)
  28243a:	63 63 63             	arpl   %sp,0x63(%ebx)
  28243d:	63 63 63             	arpl   %sp,0x63(%ebx)
  282440:	36                   	ss
  282441:	36                   	ss
  282442:	36                   	ss
  282443:	36                   	ss
  282444:	36                   	ss
  282445:	36                   	ss
  282446:	1c 1c                	sbb    $0x1c,%al
  282448:	1c 1c                	sbb    $0x1c,%al
  28244a:	1c 1c                	sbb    $0x1c,%al
	...
  282464:	1c 38                	sbb    $0x38,%al
  282466:	38 1c 30             	cmp    %bl,(%eax,%esi,1)
  282469:	0c 60                	or     $0x60,%al
  28246b:	06                   	push   %es
  28246c:	60                   	pusha  
  28246d:	03 60 03             	add    0x3(%eax),%esp
  282470:	60                   	pusha  
  282471:	03 60 03             	add    0x3(%eax),%esp
  282474:	60                   	pusha  
  282475:	06                   	push   %es
  282476:	30 0c 38             	xor    %cl,(%eax,%edi,1)
  282479:	1c 1c                	sbb    $0x1c,%al
  28247b:	38 00                	cmp    %al,(%eax)
	...
  282491:	00 00                	add    %al,(%eax)
  282493:	00 18                	add    %bl,(%eax)
  282495:	30 30                	xor    %dh,(%eax)
  282497:	18 30                	sbb    %dh,(%eax)
  282499:	18 70 18             	sbb    %dh,0x18(%eax)
  28249c:	60                   	pusha  
  28249d:	0c 60                	or     $0x60,%al
  28249f:	0c e0                	or     $0xe0,%al
  2824a1:	0c c0                	or     $0xc0,%al
  2824a3:	06                   	push   %es
  2824a4:	c0 06 80             	rolb   $0x80,(%esi)
  2824a7:	03 80 03 80 03 80    	add    -0x7ffc7ffd(%eax),%eax
  2824ad:	01 80 01 c0 01 f0    	add    %eax,-0xffe3fff(%eax)
  2824b3:	00 70 00             	add    %dh,0x0(%eax)
	...
  2824c2:	00 00                	add    %al,(%eax)
  2824c4:	fc                   	cld    
  2824c5:	1f                   	pop    %ds
  2824c6:	fc                   	cld    
  2824c7:	1f                   	pop    %ds
  2824c8:	00 0c 00             	add    %cl,(%eax,%eax,1)
  2824cb:	06                   	push   %es
  2824cc:	00 03                	add    %al,(%ebx)
  2824ce:	80 01 c0             	addb   $0xc0,(%ecx)
  2824d1:	00 60 00             	add    %ah,0x0(%eax)
  2824d4:	30 00                	xor    %al,(%eax)
  2824d6:	18 00                	sbb    %al,(%eax)
  2824d8:	fc                   	cld    
  2824d9:	1f                   	pop    %ds
  2824da:	fc                   	cld    
  2824db:	1f                   	pop    %ds
	...
  2824e8:	00 00                	add    %al,(%eax)
  2824ea:	00 03                	add    %al,(%ebx)
  2824ec:	80 01 c0             	addb   $0xc0,(%ecx)
  2824ef:	00 c0                	add    %al,%al
  2824f1:	00 c0                	add    %al,%al
  2824f3:	00 c0                	add    %al,%al
  2824f5:	00 c0                	add    %al,%al
  2824f7:	00 c0                	add    %al,%al
  2824f9:	00 60 00             	add    %ah,0x0(%eax)
  2824fc:	60                   	pusha  
  2824fd:	00 30                	add    %dh,(%eax)
  2824ff:	00 60 00             	add    %ah,0x0(%eax)
  282502:	40                   	inc    %eax
  282503:	00 c0                	add    %al,%al
  282505:	00 c0                	add    %al,%al
  282507:	00 c0                	add    %al,%al
  282509:	00 c0                	add    %al,%al
  28250b:	00 c0                	add    %al,%al
  28250d:	00 c0                	add    %al,%al
  28250f:	00 80 01 00 03 00    	add    %al,0x30001(%eax)
  282515:	00 00                	add    %al,(%eax)
  282517:	00 00                	add    %al,(%eax)
  282519:	00 80 01 80 01 80    	add    %al,-0x7ffe7fff(%eax)
  28251f:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  282525:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  28252b:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  282531:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  282537:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  28253d:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  282543:	01 80 01 00 00 00    	add    %eax,0x1(%eax)
  282549:	00 60 00             	add    %ah,0x0(%eax)
  28254c:	c0 00 c0             	rolb   $0xc0,(%eax)
  28254f:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  282555:	01 80 01 80 01 00    	add    %eax,0x18001(%eax)
  28255b:	03 00                	add    (%eax),%eax
  28255d:	03 00                	add    (%eax),%eax
  28255f:	06                   	push   %es
  282560:	00 03                	add    %al,(%ebx)
  282562:	00 01                	add    %al,(%ecx)
  282564:	80 01 80             	addb   $0x80,(%ecx)
  282567:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  28256d:	01 80 01 c0 00 60    	add    %eax,0x6000c001(%eax)
	...
  282587:	00 f0                	add    %dh,%al
  282589:	10 f8                	adc    %bh,%al
  28258b:	1f                   	pop    %ds
  28258c:	08 0f                	or     %cl,(%edi)
	...
  2825aa:	00 ff                	add    %bh,%bh
  2825ac:	00 00                	add    %al,(%eax)
  2825ae:	00 ff                	add    %bh,%bh
  2825b0:	00 ff                	add    %bh,%bh
  2825b2:	ff 00                	incl   (%eax)
  2825b4:	00 00                	add    %al,(%eax)
  2825b6:	ff                   	(bad)  
  2825b7:	ff 00                	incl   (%eax)
  2825b9:	ff 00                	incl   (%eax)
  2825bb:	ff                   	(bad)  
  2825bc:	ff                   	(bad)  
  2825bd:	ff                   	(bad)  
  2825be:	ff                   	(bad)  
  2825bf:	ff c6                	inc    %esi
  2825c1:	c6 c6 84             	mov    $0x84,%dh
  2825c4:	00 00                	add    %al,(%eax)
  2825c6:	00 84 00 84 84 00 00 	add    %al,0x8484(%eax,%eax,1)
  2825cd:	00 84 84 00 84 00 84 	add    %al,-0x7bff7c00(%esp,%eax,4)
  2825d4:	84 84 84 84 2a 2a 2a 	test   %al,0x2a2a2a84(%esp,%eax,4)

002825d8 <cursor.1343>:
  2825d8:	2a 2a                	sub    (%edx),%ch
  2825da:	2a 2a                	sub    (%edx),%ch
  2825dc:	2a 2a                	sub    (%edx),%ch
  2825de:	2a 2a                	sub    (%edx),%ch
  2825e0:	2a 2a                	sub    (%edx),%ch
  2825e2:	2a 2a                	sub    (%edx),%ch
  2825e4:	2a 2a                	sub    (%edx),%ch
  2825e6:	2e 2e 2a 4f 4f       	cs sub %cs:0x4f(%edi),%cl
  2825eb:	4f                   	dec    %edi
  2825ec:	4f                   	dec    %edi
  2825ed:	4f                   	dec    %edi
  2825ee:	4f                   	dec    %edi
  2825ef:	4f                   	dec    %edi
  2825f0:	4f                   	dec    %edi
  2825f1:	4f                   	dec    %edi
  2825f2:	4f                   	dec    %edi
  2825f3:	4f                   	dec    %edi
  2825f4:	2a 2e                	sub    (%esi),%ch
  2825f6:	2e 2e 2a 4f 4f       	cs sub %cs:0x4f(%edi),%cl
  2825fb:	4f                   	dec    %edi
  2825fc:	4f                   	dec    %edi
  2825fd:	4f                   	dec    %edi
  2825fe:	4f                   	dec    %edi
  2825ff:	4f                   	dec    %edi
  282600:	4f                   	dec    %edi
  282601:	4f                   	dec    %edi
  282602:	4f                   	dec    %edi
  282603:	2a 2e                	sub    (%esi),%ch
  282605:	2e 2e 2e 2a 4f 4f    	cs cs sub %cs:0x4f(%edi),%cl
  28260b:	4f                   	dec    %edi
  28260c:	4f                   	dec    %edi
  28260d:	4f                   	dec    %edi
  28260e:	4f                   	dec    %edi
  28260f:	4f                   	dec    %edi
  282610:	4f                   	dec    %edi
  282611:	4f                   	dec    %edi
  282612:	2a 2e                	sub    (%esi),%ch
  282614:	2e 2e 2e 2e 2a 4f 4f 	cs cs cs sub %cs:0x4f(%edi),%cl
  28261b:	4f                   	dec    %edi
  28261c:	4f                   	dec    %edi
  28261d:	4f                   	dec    %edi
  28261e:	4f                   	dec    %edi
  28261f:	4f                   	dec    %edi
  282620:	4f                   	dec    %edi
  282621:	2a 2e                	sub    (%esi),%ch
  282623:	2e 2e 2e 2e 2e 2a 4f 	cs cs cs cs sub %cs:0x4f(%edi),%cl
  28262a:	4f 
  28262b:	4f                   	dec    %edi
  28262c:	4f                   	dec    %edi
  28262d:	4f                   	dec    %edi
  28262e:	4f                   	dec    %edi
  28262f:	4f                   	dec    %edi
  282630:	2a 2e                	sub    (%esi),%ch
  282632:	2e 2e 2e 2e 2e 2e 2a 	cs cs cs cs cs sub %cs:0x4f(%edi),%cl
  282639:	4f 4f 
  28263b:	4f                   	dec    %edi
  28263c:	4f                   	dec    %edi
  28263d:	4f                   	dec    %edi
  28263e:	4f                   	dec    %edi
  28263f:	4f                   	dec    %edi
  282640:	2a 2e                	sub    (%esi),%ch
  282642:	2e 2e 2e 2e 2e 2e 2a 	cs cs cs cs cs sub %cs:0x4f(%edi),%cl
  282649:	4f 4f 
  28264b:	4f                   	dec    %edi
  28264c:	4f                   	dec    %edi
  28264d:	4f                   	dec    %edi
  28264e:	4f                   	dec    %edi
  28264f:	4f                   	dec    %edi
  282650:	4f                   	dec    %edi
  282651:	2a 2e                	sub    (%esi),%ch
  282653:	2e 2e 2e 2e 2e 2a 4f 	cs cs cs cs sub %cs:0x4f(%edi),%cl
  28265a:	4f 
  28265b:	4f                   	dec    %edi
  28265c:	4f                   	dec    %edi
  28265d:	2a 2a                	sub    (%edx),%ch
  28265f:	4f                   	dec    %edi
  282660:	4f                   	dec    %edi
  282661:	4f                   	dec    %edi
  282662:	2a 2e                	sub    (%esi),%ch
  282664:	2e 2e 2e 2e 2a 4f 4f 	cs cs cs sub %cs:0x4f(%edi),%cl
  28266b:	4f                   	dec    %edi
  28266c:	2a 2e                	sub    (%esi),%ch
  28266e:	2e 2a 4f 4f          	sub    %cs:0x4f(%edi),%cl
  282672:	4f                   	dec    %edi
  282673:	2a 2e                	sub    (%esi),%ch
  282675:	2e 2e 2e 2a 4f 4f    	cs cs sub %cs:0x4f(%edi),%cl
  28267b:	2a 2e                	sub    (%esi),%ch
  28267d:	2e 2e 2e 2a 4f 4f    	cs cs sub %cs:0x4f(%edi),%cl
  282683:	4f                   	dec    %edi
  282684:	2a 2e                	sub    (%esi),%ch
  282686:	2e 2e 2a 4f 2a       	cs sub %cs:0x2a(%edi),%cl
  28268b:	2e 2e 2e 2e 2e 2e 2a 	cs cs cs cs cs sub %cs:0x4f(%edi),%cl
  282692:	4f 4f 
  282694:	4f                   	dec    %edi
  282695:	2a 2e                	sub    (%esi),%ch
  282697:	2e 2a 2a             	sub    %cs:(%edx),%ch
  28269a:	2e 2e 2e 2e 2e 2e 2e 	cs cs cs cs cs cs cs sub %cs:0x4f(%edi),%cl
  2826a1:	2e 2a 4f 4f 
  2826a5:	4f                   	dec    %edi
  2826a6:	2a 2e                	sub    (%esi),%ch
  2826a8:	2a 2e                	sub    (%esi),%ch
  2826aa:	2e 2e 2e 2e 2e 2e 2e 	cs cs cs cs cs cs cs cs sub %cs:0x4f(%edi),%cl
  2826b1:	2e 2e 2a 4f 4f 
  2826b6:	4f                   	dec    %edi
  2826b7:	2a 2e                	sub    (%esi),%ch
  2826b9:	2e 2e 2e 2e 2e 2e 2e 	cs cs cs cs cs cs cs cs cs cs sub %cs:0x4f(%edi),%cl
  2826c0:	2e 2e 2e 2e 2a 4f 4f 
  2826c7:	2a 2e                	sub    (%esi),%ch
  2826c9:	2e 2e 2e 2e 2e 2e 2e 	cs cs cs cs cs cs cs cs cs cs cs sub %cs:(%edx),%ch
  2826d0:	2e 2e 2e 2e 2e 2a 2a 
  2826d7:	2a                   	.byte 0x2a

Disassembly of section .rodata.str1.1:

002826d8 <.rodata.str1.1>:
  2826d8:	44                   	inc    %esp
  2826d9:	65 62 75 67          	bound  %esi,%gs:0x67(%ebp)
  2826dd:	3a 76 61             	cmp    0x61(%esi),%dh
  2826e0:	72 3d                	jb     28271f <cursor.1343+0x147>
  2826e2:	25                   	.byte 0x25
  2826e3:	78 00                	js     2826e5 <cursor.1343+0x10d>

Disassembly of section .eh_frame:

002826e8 <.eh_frame>:
  2826e8:	14 00                	adc    $0x0,%al
  2826ea:	00 00                	add    %al,(%eax)
  2826ec:	00 00                	add    %al,(%eax)
  2826ee:	00 00                	add    %al,(%eax)
  2826f0:	01 7a 52             	add    %edi,0x52(%edx)
  2826f3:	00 01                	add    %al,(%ecx)
  2826f5:	7c 08                	jl     2826ff <cursor.1343+0x127>
  2826f7:	01 1b                	add    %ebx,(%ebx)
  2826f9:	0c 04                	or     $0x4,%al
  2826fb:	04 88                	add    $0x88,%al
  2826fd:	01 00                	add    %eax,(%eax)
  2826ff:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282702:	00 00                	add    %al,(%eax)
  282704:	1c 00                	sbb    $0x0,%al
  282706:	00 00                	add    %al,(%eax)
  282708:	f8                   	clc    
  282709:	d8 ff                	fdivr  %st(7),%st
  28270b:	ff 0f                	decl   (%edi)
  28270d:	00 00                	add    %al,(%eax)
  28270f:	00 00                	add    %al,(%eax)
  282711:	41                   	inc    %ecx
  282712:	0e                   	push   %cs
  282713:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282719:	46                   	inc    %esi
  28271a:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  28271d:	04 00                	add    $0x0,%al
  28271f:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282722:	00 00                	add    %al,(%eax)
  282724:	3c 00                	cmp    $0x0,%al
  282726:	00 00                	add    %al,(%eax)
  282728:	e7 d8                	out    %eax,$0xd8
  28272a:	ff                   	(bad)  
  28272b:	ff 1f                	lcall  *(%edi)
  28272d:	00 00                	add    %al,(%eax)
  28272f:	00 00                	add    %al,(%eax)
  282731:	41                   	inc    %ecx
  282732:	0e                   	push   %cs
  282733:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282739:	5b                   	pop    %ebx
  28273a:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  28273d:	04 00                	add    $0x0,%al
  28273f:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282742:	00 00                	add    %al,(%eax)
  282744:	5c                   	pop    %esp
  282745:	00 00                	add    %al,(%eax)
  282747:	00 e6                	add    %ah,%dh
  282749:	d8 ff                	fdivr  %st(7),%st
  28274b:	ff 1f                	lcall  *(%edi)
  28274d:	00 00                	add    %al,(%eax)
  28274f:	00 00                	add    %al,(%eax)
  282751:	41                   	inc    %ecx
  282752:	0e                   	push   %cs
  282753:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282759:	5b                   	pop    %ebx
  28275a:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  28275d:	04 00                	add    $0x0,%al
  28275f:	00 18                	add    %bl,(%eax)
  282761:	00 00                	add    %al,(%eax)
  282763:	00 7c 00 00          	add    %bh,0x0(%eax,%eax,1)
  282767:	00 e5                	add    %ah,%ch
  282769:	d8 ff                	fdivr  %st(7),%st
  28276b:	ff db                	lcall  *<反汇编器内部错误>
  28276d:	01 00                	add    %eax,(%eax)
  28276f:	00 00                	add    %al,(%eax)
  282771:	41                   	inc    %ecx
  282772:	0e                   	push   %cs
  282773:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282779:	47                   	inc    %edi
  28277a:	83 03 1c             	addl   $0x1c,(%ebx)
  28277d:	00 00                	add    %al,(%eax)
  28277f:	00 98 00 00 00 a4    	add    %bl,-0x5c000000(%eax)
  282785:	da ff                	(bad)  
  282787:	ff 17                	call   *(%edi)
  282789:	00 00                	add    %al,(%eax)
  28278b:	00 00                	add    %al,(%eax)
  28278d:	41                   	inc    %ecx
  28278e:	0e                   	push   %cs
  28278f:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282795:	4e                   	dec    %esi
  282796:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282799:	04 00                	add    $0x0,%al
  28279b:	00 1c 00             	add    %bl,(%eax,%eax,1)
  28279e:	00 00                	add    %al,(%eax)
  2827a0:	b8 00 00 00 9b       	mov    $0x9b000000,%eax
  2827a5:	da ff                	(bad)  
  2827a7:	ff 14 00             	call   *(%eax,%eax,1)
  2827aa:	00 00                	add    %al,(%eax)
  2827ac:	00 41 0e             	add    %al,0xe(%ecx)
  2827af:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  2827b5:	4b                   	dec    %ebx
  2827b6:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  2827b9:	04 00                	add    $0x0,%al
  2827bb:	00 24 00             	add    %ah,(%eax,%eax,1)
  2827be:	00 00                	add    %al,(%eax)
  2827c0:	d8 00                	fadds  (%eax)
  2827c2:	00 00                	add    %al,(%eax)
  2827c4:	8f                   	(bad)  
  2827c5:	da ff                	(bad)  
  2827c7:	ff 35 00 00 00 00    	pushl  0x0
  2827cd:	41                   	inc    %ecx
  2827ce:	0e                   	push   %cs
  2827cf:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  2827d5:	45                   	inc    %ebp
  2827d6:	86 03                	xchg   %al,(%ebx)
  2827d8:	83 04 6a c3          	addl   $0xffffffc3,(%edx,%ebp,2)
  2827dc:	41                   	inc    %ecx
  2827dd:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
  2827e1:	04 04                	add    $0x4,%al
  2827e3:	00 24 00             	add    %ah,(%eax,%eax,1)
  2827e6:	00 00                	add    %al,(%eax)
  2827e8:	00 01                	add    %al,(%ecx)
  2827ea:	00 00                	add    %al,(%eax)
  2827ec:	9c                   	pushf  
  2827ed:	da ff                	(bad)  
  2827ef:	ff 31                	pushl  (%ecx)
  2827f1:	00 00                	add    %al,(%eax)
  2827f3:	00 00                	add    %al,(%eax)
  2827f5:	41                   	inc    %ecx
  2827f6:	0e                   	push   %cs
  2827f7:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  2827fd:	42                   	inc    %edx
  2827fe:	87 03                	xchg   %eax,(%ebx)
  282800:	86 04 64             	xchg   %al,(%esp,%eiz,2)
  282803:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
  282807:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  28280a:	04 00                	add    $0x0,%al
  28280c:	20 00                	and    %al,(%eax)
  28280e:	00 00                	add    %al,(%eax)
  282810:	28 01                	sub    %al,(%ecx)
  282812:	00 00                	add    %al,(%eax)
  282814:	a5                   	movsl  %ds:(%esi),%es:(%edi)
  282815:	da ff                	(bad)  
  282817:	ff 2f                	ljmp   *(%edi)
  282819:	00 00                	add    %al,(%eax)
  28281b:	00 00                	add    %al,(%eax)
  28281d:	41                   	inc    %ecx
  28281e:	0e                   	push   %cs
  28281f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282825:	47                   	inc    %edi
  282826:	83 03 63             	addl   $0x63,(%ebx)
  282829:	c3                   	ret    
  28282a:	41                   	inc    %ecx
  28282b:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  28282e:	04 00                	add    $0x0,%al
  282830:	1c 00                	sbb    $0x0,%al
  282832:	00 00                	add    %al,(%eax)
  282834:	4c                   	dec    %esp
  282835:	01 00                	add    %eax,(%eax)
  282837:	00 b0 da ff ff 28    	add    %dh,0x28ffffda(%eax)
  28283d:	00 00                	add    %al,(%eax)
  28283f:	00 00                	add    %al,(%eax)
  282841:	41                   	inc    %ecx
  282842:	0e                   	push   %cs
  282843:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282849:	64 c5 0c 04          	lds    %fs:(%esp,%eax,1),%ecx
  28284d:	04 00                	add    $0x0,%al
  28284f:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282852:	00 00                	add    %al,(%eax)
  282854:	6c                   	insb   (%dx),%es:(%edi)
  282855:	01 00                	add    %eax,(%eax)
  282857:	00 b8 da ff ff 61    	add    %bh,0x61ffffda(%eax)
  28285d:	01 00                	add    %eax,(%eax)
  28285f:	00 00                	add    %al,(%eax)
  282861:	41                   	inc    %ecx
  282862:	0e                   	push   %cs
  282863:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282869:	03 5d 01             	add    0x1(%ebp),%ebx
  28286c:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  28286f:	04 1c                	add    $0x1c,%al
  282871:	00 00                	add    %al,(%eax)
  282873:	00 8c 01 00 00 f9 db 	add    %cl,-0x24070000(%ecx,%eax,1)
  28287a:	ff                   	(bad)  
  28287b:	ff 1f                	lcall  *(%edi)
  28287d:	00 00                	add    %al,(%eax)
  28287f:	00 00                	add    %al,(%eax)
  282881:	41                   	inc    %ecx
  282882:	0e                   	push   %cs
  282883:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282889:	5b                   	pop    %ebx
  28288a:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  28288d:	04 00                	add    $0x0,%al
  28288f:	00 24 00             	add    %ah,(%eax,%eax,1)
  282892:	00 00                	add    %al,(%eax)
  282894:	ac                   	lods   %ds:(%esi),%al
  282895:	01 00                	add    %eax,(%eax)
  282897:	00 f8                	add    %bh,%al
  282899:	db ff                	(bad)  
  28289b:	ff 50 00             	call   *0x0(%eax)
  28289e:	00 00                	add    %al,(%eax)
  2828a0:	00 41 0e             	add    %al,0xe(%ecx)
  2828a3:	08 85 02 44 0d 05    	or     %al,0x50d4402(%ebp)
  2828a9:	48                   	dec    %eax
  2828aa:	86 03                	xchg   %al,(%ebx)
  2828ac:	83 04 02 40          	addl   $0x40,(%edx,%eax,1)
  2828b0:	c3                   	ret    
  2828b1:	41                   	inc    %ecx
  2828b2:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
  2828b6:	04 04                	add    $0x4,%al
  2828b8:	24 00                	and    $0x0,%al
  2828ba:	00 00                	add    %al,(%eax)
  2828bc:	d4 01                	aam    $0x1
  2828be:	00 00                	add    %al,(%eax)
  2828c0:	20 dc                	and    %bl,%ah
  2828c2:	ff                   	(bad)  
  2828c3:	ff                   	(bad)  
  2828c4:	39 00                	cmp    %eax,(%eax)
  2828c6:	00 00                	add    %al,(%eax)
  2828c8:	00 41 0e             	add    %al,0xe(%ecx)
  2828cb:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  2828d1:	44                   	inc    %esp
  2828d2:	86 03                	xchg   %al,(%ebx)
  2828d4:	43                   	inc    %ebx
  2828d5:	83 04 6c c3          	addl   $0xffffffc3,(%esp,%ebp,2)
  2828d9:	41                   	inc    %ecx
  2828da:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
  2828de:	04 04                	add    $0x4,%al
  2828e0:	28 00                	sub    %al,(%eax)
  2828e2:	00 00                	add    %al,(%eax)
  2828e4:	fc                   	cld    
  2828e5:	01 00                	add    %eax,(%eax)
  2828e7:	00 34 dc             	add    %dh,(%esp,%ebx,8)
  2828ea:	ff                   	(bad)  
  2828eb:	ff 62 00             	jmp    *0x0(%edx)
  2828ee:	00 00                	add    %al,(%eax)
  2828f0:	00 41 0e             	add    %al,0xe(%ecx)
  2828f3:	08 85 02 44 0d 05    	or     %al,0x50d4402(%ebp)
  2828f9:	4b                   	dec    %ebx
  2828fa:	87 03                	xchg   %eax,(%ebx)
  2828fc:	86 04 83             	xchg   %al,(%ebx,%eax,4)
  2828ff:	05 02 4e c3 41       	add    $0x41c34e02,%eax
  282904:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
  282908:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  28290b:	04 28                	add    $0x28,%al
  28290d:	00 00                	add    %al,(%eax)
  28290f:	00 28                	add    %ch,(%eax)
  282911:	02 00                	add    (%eax),%al
  282913:	00 6a dc             	add    %ch,-0x24(%edx)
  282916:	ff                   	(bad)  
  282917:	ff 62 00             	jmp    *0x0(%edx)
  28291a:	00 00                	add    %al,(%eax)
  28291c:	00 41 0e             	add    %al,0xe(%ecx)
  28291f:	08 85 02 44 0d 05    	or     %al,0x50d4402(%ebp)
  282925:	4b                   	dec    %ebx
  282926:	87 03                	xchg   %eax,(%ebx)
  282928:	86 04 83             	xchg   %al,(%ebx,%eax,4)
  28292b:	05 02 4e c3 41       	add    $0x41c34e02,%eax
  282930:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
  282934:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282937:	04 28                	add    $0x28,%al
  282939:	00 00                	add    %al,(%eax)
  28293b:	00 54 02 00          	add    %dl,0x0(%edx,%eax,1)
  28293f:	00 a0 dc ff ff aa    	add    %ah,-0x55000024(%eax)
  282945:	00 00                	add    %al,(%eax)
  282947:	00 00                	add    %al,(%eax)
  282949:	41                   	inc    %ecx
  28294a:	0e                   	push   %cs
  28294b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282951:	46                   	inc    %esi
  282952:	87 03                	xchg   %eax,(%ebx)
  282954:	86 04 83             	xchg   %al,(%ebx,%eax,4)
  282957:	05 02 9d c3 41       	add    $0x41c39d02,%eax
  28295c:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
  282960:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282963:	04 28                	add    $0x28,%al
  282965:	00 00                	add    %al,(%eax)
  282967:	00 80 02 00 00 1e    	add    %al,0x1e000002(%eax)
  28296d:	dd ff                	(bad)  
  28296f:	ff 62 00             	jmp    *0x0(%edx)
  282972:	00 00                	add    %al,(%eax)
  282974:	00 41 0e             	add    %al,0xe(%ecx)
  282977:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  28297d:	46                   	inc    %esi
  28297e:	87 03                	xchg   %eax,(%ebx)
  282980:	86 04 83             	xchg   %al,(%ebx,%eax,4)
  282983:	05 02 55 c3 41       	add    $0x41c35502,%eax
  282988:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
  28298c:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  28298f:	04 2c                	add    $0x2c,%al
  282991:	00 00                	add    %al,(%eax)
  282993:	00 ac 02 00 00 54 dd 	add    %ch,-0x22ac0000(%edx,%eax,1)
  28299a:	ff                   	(bad)  
  28299b:	ff 64 00 00          	jmp    *0x0(%eax,%eax,1)
  28299f:	00 00                	add    %al,(%eax)
  2829a1:	41                   	inc    %ecx
  2829a2:	0e                   	push   %cs
  2829a3:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  2829a9:	41                   	inc    %ecx
  2829aa:	87 03                	xchg   %eax,(%ebx)
  2829ac:	44                   	inc    %esp
  2829ad:	86 04 45 83 05 02 53 	xchg   %al,0x53020583(,%eax,2)
  2829b4:	c3                   	ret    
  2829b5:	41                   	inc    %ecx
  2829b6:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
  2829ba:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  2829bd:	04 00                	add    $0x0,%al
  2829bf:	00 20                	add    %ah,(%eax)
  2829c1:	00 00                	add    %al,(%eax)
  2829c3:	00 dc                	add    %bl,%ah
  2829c5:	02 00                	add    (%eax),%al
  2829c7:	00 88 dd ff ff 3a    	add    %cl,0x3affffdd(%eax)
  2829cd:	00 00                	add    %al,(%eax)
  2829cf:	00 00                	add    %al,(%eax)
  2829d1:	41                   	inc    %ecx
  2829d2:	0e                   	push   %cs
  2829d3:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  2829d9:	44                   	inc    %esp
  2829da:	83 03 72             	addl   $0x72,(%ebx)
  2829dd:	c5 c3 0c             	(bad)  
  2829e0:	04 04                	add    $0x4,%al
  2829e2:	00 00                	add    %al,(%eax)
  2829e4:	24 00                	and    $0x0,%al
  2829e6:	00 00                	add    %al,(%eax)
  2829e8:	00 03                	add    %al,(%ebx)
  2829ea:	00 00                	add    %al,(%eax)
  2829ec:	9e                   	sahf   
  2829ed:	dd ff                	(bad)  
  2829ef:	ff                   	(bad)  
  2829f0:	3f                   	aas    
  2829f1:	00 00                	add    %al,(%eax)
  2829f3:	00 00                	add    %al,(%eax)
  2829f5:	41                   	inc    %ecx
  2829f6:	0e                   	push   %cs
  2829f7:	08 85 02 44 0d 05    	or     %al,0x50d4402(%ebp)
  2829fd:	45                   	inc    %ebp
  2829fe:	86 03                	xchg   %al,(%ebx)
  282a00:	83 04 72 c3          	addl   $0xffffffc3,(%edx,%esi,2)
  282a04:	41                   	inc    %ecx
  282a05:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
  282a09:	04 04                	add    $0x4,%al
  282a0b:	00 2c 00             	add    %ch,(%eax,%eax,1)
  282a0e:	00 00                	add    %al,(%eax)
  282a10:	28 03                	sub    %al,(%ebx)
  282a12:	00 00                	add    %al,(%eax)
  282a14:	b5 dd                	mov    $0xdd,%ch
  282a16:	ff                   	(bad)  
  282a17:	ff 4f 00             	decl   0x0(%edi)
  282a1a:	00 00                	add    %al,(%eax)
  282a1c:	00 41 0e             	add    %al,0xe(%ecx)
  282a1f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282a25:	41                   	inc    %ecx
  282a26:	87 03                	xchg   %eax,(%ebx)
  282a28:	44                   	inc    %esp
  282a29:	86 04 44             	xchg   %al,(%esp,%eax,2)
  282a2c:	83 05 7f c3 41 c6 41 	addl   $0x41,0xc641c37f
  282a33:	c7 41 c5 0c 04 04 00 	movl   $0x4040c,-0x3b(%ecx)
  282a3a:	00 00                	add    %al,(%eax)
  282a3c:	2c 00                	sub    $0x0,%al
  282a3e:	00 00                	add    %al,(%eax)
  282a40:	58                   	pop    %eax
  282a41:	03 00                	add    (%eax),%eax
  282a43:	00 d4                	add    %dl,%ah
  282a45:	dd ff                	(bad)  
  282a47:	ff 54 00 00          	call   *0x0(%eax,%eax,1)
  282a4b:	00 00                	add    %al,(%eax)
  282a4d:	41                   	inc    %ecx
  282a4e:	0e                   	push   %cs
  282a4f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282a55:	48                   	dec    %eax
  282a56:	87 03                	xchg   %eax,(%ebx)
  282a58:	86 04 44             	xchg   %al,(%esp,%eax,2)
  282a5b:	83 05 02 41 c3 41 c6 	addl   $0xffffffc6,0x41c34102
  282a62:	41                   	inc    %ecx
  282a63:	c7 41 c5 0c 04 04 00 	movl   $0x4040c,-0x3b(%ecx)
  282a6a:	00 00                	add    %al,(%eax)
  282a6c:	1c 00                	sbb    $0x0,%al
  282a6e:	00 00                	add    %al,(%eax)
  282a70:	88 03                	mov    %al,(%ebx)
  282a72:	00 00                	add    %al,(%eax)
  282a74:	f8                   	clc    
  282a75:	dd ff                	(bad)  
  282a77:	ff 2a                	ljmp   *(%edx)
  282a79:	00 00                	add    %al,(%eax)
  282a7b:	00 00                	add    %al,(%eax)
  282a7d:	41                   	inc    %ecx
  282a7e:	0e                   	push   %cs
  282a7f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282a85:	66 c5 0c 04          	lds    (%esp,%eax,1),%cx
  282a89:	04 00                	add    $0x0,%al
  282a8b:	00 20                	add    %ah,(%eax)
  282a8d:	00 00                	add    %al,(%eax)
  282a8f:	00 a8 03 00 00 02    	add    %ch,0x2000003(%eax)
  282a95:	de ff                	fdivrp %st,%st(7)
  282a97:	ff 8b 01 00 00 00    	decl   0x1(%ebx)
  282a9d:	41                   	inc    %ecx
  282a9e:	0e                   	push   %cs
  282a9f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282aa5:	41                   	inc    %ecx
  282aa6:	83 03 03             	addl   $0x3,(%ebx)
  282aa9:	86 01                	xchg   %al,(%ecx)
  282aab:	c5 c3 0c             	(bad)  
  282aae:	04 04                	add    $0x4,%al
  282ab0:	1c 00                	sbb    $0x0,%al
  282ab2:	00 00                	add    %al,(%eax)
  282ab4:	cc                   	int3   
  282ab5:	03 00                	add    (%eax),%eax
  282ab7:	00 6c df ff          	add    %ch,-0x1(%edi,%ebx,8)
  282abb:	ff                   	(bad)  
  282abc:	3a 00                	cmp    (%eax),%al
  282abe:	00 00                	add    %al,(%eax)
  282ac0:	00 41 0e             	add    %al,0xe(%ecx)
  282ac3:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282ac9:	71 c5                	jno    282a90 <cursor.1343+0x4b8>
  282acb:	0c 04                	or     $0x4,%al
  282acd:	04 00                	add    $0x0,%al
  282acf:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282ad2:	00 00                	add    %al,(%eax)
  282ad4:	ec                   	in     (%dx),%al
  282ad5:	03 00                	add    (%eax),%eax
  282ad7:	00 86 df ff ff 24    	add    %al,0x24ffffdf(%esi)
  282add:	00 00                	add    %al,(%eax)
  282adf:	00 00                	add    %al,(%eax)
  282ae1:	41                   	inc    %ecx
  282ae2:	0e                   	push   %cs
  282ae3:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282ae9:	5b                   	pop    %ebx
  282aea:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282aed:	04 00                	add    $0x0,%al
  282aef:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282af2:	00 00                	add    %al,(%eax)
  282af4:	0c 04                	or     $0x4,%al
  282af6:	00 00                	add    %al,(%eax)
  282af8:	8a df                	mov    %bh,%bl
  282afa:	ff                   	(bad)  
  282afb:	ff 29                	ljmp   *(%ecx)
  282afd:	00 00                	add    %al,(%eax)
  282aff:	00 00                	add    %al,(%eax)
  282b01:	41                   	inc    %ecx
  282b02:	0e                   	push   %cs
  282b03:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282b09:	60                   	pusha  
  282b0a:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282b0d:	04 00                	add    $0x0,%al
  282b0f:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282b12:	00 00                	add    %al,(%eax)
  282b14:	2c 04                	sub    $0x4,%al
  282b16:	00 00                	add    %al,(%eax)
  282b18:	93                   	xchg   %eax,%ebx
  282b19:	df ff                	(bad)  
  282b1b:	ff 0d 00 00 00 00    	decl   0x0
  282b21:	41                   	inc    %ecx
  282b22:	0e                   	push   %cs
  282b23:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282b29:	44                   	inc    %esp
  282b2a:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282b2d:	04 00                	add    $0x0,%al
  282b2f:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282b32:	00 00                	add    %al,(%eax)
  282b34:	4c                   	dec    %esp
  282b35:	04 00                	add    $0x0,%al
  282b37:	00 f4                	add    %dh,%ah
  282b39:	df ff                	(bad)  
  282b3b:	ff 2b                	ljmp   *(%ebx)
  282b3d:	00 00                	add    %al,(%eax)
  282b3f:	00 00                	add    %al,(%eax)
  282b41:	41                   	inc    %ecx
  282b42:	0e                   	push   %cs
  282b43:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282b49:	67 c5 0c             	lds    (%si),%ecx
  282b4c:	04 04                	add    $0x4,%al
  282b4e:	00 00                	add    %al,(%eax)
  282b50:	20 00                	and    %al,(%eax)
  282b52:	00 00                	add    %al,(%eax)
  282b54:	6c                   	insb   (%dx),%es:(%edi)
  282b55:	04 00                	add    $0x0,%al
  282b57:	00 ff                	add    %bh,%bh
  282b59:	df ff                	(bad)  
  282b5b:	ff                   	(bad)  
  282b5c:	3e 00 00             	add    %al,%ds:(%eax)
  282b5f:	00 00                	add    %al,(%eax)
  282b61:	41                   	inc    %ecx
  282b62:	0e                   	push   %cs
  282b63:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282b69:	44                   	inc    %esp
  282b6a:	83 03 75             	addl   $0x75,(%ebx)
  282b6d:	c3                   	ret    
  282b6e:	41                   	inc    %ecx
  282b6f:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282b72:	04 00                	add    $0x0,%al
  282b74:	28 00                	sub    %al,(%eax)
  282b76:	00 00                	add    %al,(%eax)
  282b78:	90                   	nop
  282b79:	04 00                	add    $0x0,%al
  282b7b:	00 19                	add    %bl,(%ecx)
  282b7d:	e0 ff                	loopne 282b7e <cursor.1343+0x5a6>
  282b7f:	ff 35 00 00 00 00    	pushl  0x0
  282b85:	41                   	inc    %ecx
  282b86:	0e                   	push   %cs
  282b87:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282b8d:	46                   	inc    %esi
  282b8e:	87 03                	xchg   %eax,(%ebx)
  282b90:	86 04 83             	xchg   %al,(%ebx,%eax,4)
  282b93:	05 68 c3 41 c6       	add    $0xc641c368,%eax
  282b98:	41                   	inc    %ecx
  282b99:	c7 41 c5 0c 04 04 00 	movl   $0x4040c,-0x3b(%ecx)
  282ba0:	1c 00                	sbb    $0x0,%al
  282ba2:	00 00                	add    %al,(%eax)
  282ba4:	bc 04 00 00 22       	mov    $0x22000004,%esp
  282ba9:	e0 ff                	loopne 282baa <cursor.1343+0x5d2>
  282bab:	ff 0e                	decl   (%esi)
  282bad:	00 00                	add    %al,(%eax)
  282baf:	00 00                	add    %al,(%eax)
  282bb1:	41                   	inc    %ecx
  282bb2:	0e                   	push   %cs
  282bb3:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282bb9:	44                   	inc    %esp
  282bba:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282bbd:	04 00                	add    $0x0,%al
	...

Disassembly of section .data:

00282bc0 <bootp>:
  282bc0:	f0 0f 00 00          	lock sldt (%eax)

Disassembly of section .bss:

00282bc4 <keyfifo>:
	...

00282bdc <mousefifo>:
	...

Disassembly of section .stab:

00000000 <.stab>:
       0:	01 00                	add    %eax,(%eax)
       2:	00 00                	add    %al,(%eax)
       4:	00 00                	add    %al,(%eax)
       6:	99                   	cltd   
       7:	03 7f 0e             	add    0xe(%edi),%edi
       a:	00 00                	add    %al,(%eax)
       c:	01 00                	add    %eax,(%eax)
       e:	00 00                	add    %al,(%eax)
      10:	64 00 02             	add    %al,%fs:(%edx)
      13:	00 00                	add    %al,(%eax)
      15:	00 28                	add    %ch,(%eax)
      17:	00 08                	add    %cl,(%eax)
      19:	00 00                	add    %al,(%eax)
      1b:	00 3c 00             	add    %bh,(%eax,%eax,1)
      1e:	00 00                	add    %al,(%eax)
      20:	00 00                	add    %al,(%eax)
      22:	00 00                	add    %al,(%eax)
      24:	17                   	pop    %ss
      25:	00 00                	add    %al,(%eax)
      27:	00 80 00 00 00 00    	add    %al,0x0(%eax)
      2d:	00 00                	add    %al,(%eax)
      2f:	00 41 00             	add    %al,0x0(%ecx)
      32:	00 00                	add    %al,(%eax)
      34:	80 00 00             	addb   $0x0,(%eax)
      37:	00 00                	add    %al,(%eax)
      39:	00 00                	add    %al,(%eax)
      3b:	00 5b 00             	add    %bl,0x0(%ebx)
      3e:	00 00                	add    %al,(%eax)
      40:	80 00 00             	addb   $0x0,(%eax)
      43:	00 00                	add    %al,(%eax)
      45:	00 00                	add    %al,(%eax)
      47:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
      4d:	00 00                	add    %al,(%eax)
      4f:	00 00                	add    %al,(%eax)
      51:	00 00                	add    %al,(%eax)
      53:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
      59:	00 00                	add    %al,(%eax)
      5b:	00 00                	add    %al,(%eax)
      5d:	00 00                	add    %al,(%eax)
      5f:	00 e1                	add    %ah,%cl
      61:	00 00                	add    %al,(%eax)
      63:	00 80 00 00 00 00    	add    %al,0x0(%eax)
      69:	00 00                	add    %al,(%eax)
      6b:	00 0c 01             	add    %cl,(%ecx,%eax,1)
      6e:	00 00                	add    %al,(%eax)
      70:	80 00 00             	addb   $0x0,(%eax)
      73:	00 00                	add    %al,(%eax)
      75:	00 00                	add    %al,(%eax)
      77:	00 37                	add    %dh,(%edi)
      79:	01 00                	add    %eax,(%eax)
      7b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
      81:	00 00                	add    %al,(%eax)
      83:	00 5d 01             	add    %bl,0x1(%ebp)
      86:	00 00                	add    %al,(%eax)
      88:	80 00 00             	addb   $0x0,(%eax)
      8b:	00 00                	add    %al,(%eax)
      8d:	00 00                	add    %al,(%eax)
      8f:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
      95:	00 00                	add    %al,(%eax)
      97:	00 00                	add    %al,(%eax)
      99:	00 00                	add    %al,(%eax)
      9b:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
      a1:	00 00                	add    %al,(%eax)
      a3:	00 00                	add    %al,(%eax)
      a5:	00 00                	add    %al,(%eax)
      a7:	00 d2                	add    %dl,%dl
      a9:	01 00                	add    %eax,(%eax)
      ab:	00 80 00 00 00 00    	add    %al,0x0(%eax)
      b1:	00 00                	add    %al,(%eax)
      b3:	00 ec                	add    %ch,%ah
      b5:	01 00                	add    %eax,(%eax)
      b7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
      bd:	00 00                	add    %al,(%eax)
      bf:	00 07                	add    %al,(%edi)
      c1:	02 00                	add    (%eax),%al
      c3:	00 80 00 00 00 00    	add    %al,0x0(%eax)
      c9:	00 00                	add    %al,(%eax)
      cb:	00 28                	add    %ch,(%eax)
      cd:	02 00                	add    (%eax),%al
      cf:	00 80 00 00 00 00    	add    %al,0x0(%eax)
      d5:	00 00                	add    %al,(%eax)
      d7:	00 47 02             	add    %al,0x2(%edi)
      da:	00 00                	add    %al,(%eax)
      dc:	80 00 00             	addb   $0x0,(%eax)
      df:	00 00                	add    %al,(%eax)
      e1:	00 00                	add    %al,(%eax)
      e3:	00 66 02             	add    %ah,0x2(%esi)
      e6:	00 00                	add    %al,(%eax)
      e8:	80 00 00             	addb   $0x0,(%eax)
      eb:	00 00                	add    %al,(%eax)
      ed:	00 00                	add    %al,(%eax)
      ef:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
      f5:	00 00                	add    %al,(%eax)
      f7:	00 00                	add    %al,(%eax)
      f9:	00 00                	add    %al,(%eax)
      fb:	00 9b 02 00 00 82    	add    %bl,-0x7dfffffe(%ebx)
     101:	00 00                	add    %al,(%eax)
     103:	00 d4                	add    %dl,%ah
     105:	8c 00                	mov    %es,(%eax)
     107:	00 a4 02 00 00 82 00 	add    %ah,0x820000(%edx,%eax,1)
     10e:	00 00                	add    %al,(%eax)
     110:	00 00                	add    %al,(%eax)
     112:	00 00                	add    %al,(%eax)
     114:	aa                   	stos   %al,%es:(%edi)
     115:	02 00                	add    (%eax),%al
     117:	00 82 00 00 00 37    	add    %al,0x37000000(%edx)
     11d:	53                   	push   %ebx
     11e:	00 00                	add    %al,(%eax)
     120:	b2 02                	mov    $0x2,%dl
     122:	00 00                	add    %al,(%eax)
     124:	80 00 00             	addb   $0x0,(%eax)
     127:	00 00                	add    %al,(%eax)
     129:	00 00                	add    %al,(%eax)
     12b:	00 c4                	add    %al,%ah
     12d:	02 00                	add    (%eax),%al
     12f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     135:	00 00                	add    %al,(%eax)
     137:	00 d9                	add    %bl,%cl
     139:	02 00                	add    (%eax),%al
     13b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     141:	00 00                	add    %al,(%eax)
     143:	00 ef                	add    %ch,%bh
     145:	02 00                	add    (%eax),%al
     147:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     14d:	00 00                	add    %al,(%eax)
     14f:	00 04 03             	add    %al,(%ebx,%eax,1)
     152:	00 00                	add    %al,(%eax)
     154:	80 00 00             	addb   $0x0,(%eax)
     157:	00 00                	add    %al,(%eax)
     159:	00 00                	add    %al,(%eax)
     15b:	00 1a                	add    %bl,(%edx)
     15d:	03 00                	add    (%eax),%eax
     15f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     165:	00 00                	add    %al,(%eax)
     167:	00 2f                	add    %ch,(%edi)
     169:	03 00                	add    (%eax),%eax
     16b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     171:	00 00                	add    %al,(%eax)
     173:	00 45 03             	add    %al,0x3(%ebp)
     176:	00 00                	add    %al,(%eax)
     178:	80 00 00             	addb   $0x0,(%eax)
     17b:	00 00                	add    %al,(%eax)
     17d:	00 00                	add    %al,(%eax)
     17f:	00 5a 03             	add    %bl,0x3(%edx)
     182:	00 00                	add    %al,(%eax)
     184:	80 00 00             	addb   $0x0,(%eax)
     187:	00 00                	add    %al,(%eax)
     189:	00 00                	add    %al,(%eax)
     18b:	00 70 03             	add    %dh,0x3(%eax)
     18e:	00 00                	add    %al,(%eax)
     190:	80 00 00             	addb   $0x0,(%eax)
     193:	00 00                	add    %al,(%eax)
     195:	00 00                	add    %al,(%eax)
     197:	00 87 03 00 00 80    	add    %al,-0x7ffffffd(%edi)
     19d:	00 00                	add    %al,(%eax)
     19f:	00 00                	add    %al,(%eax)
     1a1:	00 00                	add    %al,(%eax)
     1a3:	00 9f 03 00 00 80    	add    %bl,-0x7ffffffd(%edi)
     1a9:	00 00                	add    %al,(%eax)
     1ab:	00 00                	add    %al,(%eax)
     1ad:	00 00                	add    %al,(%eax)
     1af:	00 b8 03 00 00 80    	add    %bh,-0x7ffffffd(%eax)
     1b5:	00 00                	add    %al,(%eax)
     1b7:	00 00                	add    %al,(%eax)
     1b9:	00 00                	add    %al,(%eax)
     1bb:	00 cc                	add    %cl,%ah
     1bd:	03 00                	add    (%eax),%eax
     1bf:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     1c5:	00 00                	add    %al,(%eax)
     1c7:	00 e1                	add    %ah,%cl
     1c9:	03 00                	add    (%eax),%eax
     1cb:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     1d1:	00 00                	add    %al,(%eax)
     1d3:	00 f7                	add    %dh,%bh
     1d5:	03 00                	add    (%eax),%eax
     1d7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     1dd:	00 00                	add    %al,(%eax)
     1df:	00 00                	add    %al,(%eax)
     1e1:	00 00                	add    %al,(%eax)
     1e3:	00 a2 00 00 00 00    	add    %ah,0x0(%edx)
     1e9:	00 00                	add    %al,(%eax)
     1eb:	00 00                	add    %al,(%eax)
     1ed:	00 00                	add    %al,(%eax)
     1ef:	00 a2 00 00 00 00    	add    %ah,0x0(%edx)
     1f5:	00 00                	add    %al,(%eax)
     1f7:	00 0b                	add    %cl,(%ebx)
     1f9:	04 00                	add    $0x0,%al
     1fb:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     201:	00 00                	add    %al,(%eax)
     203:	00 86 04 00 00 80    	add    %al,-0x7ffffffc(%esi)
     209:	00 00                	add    %al,(%eax)
     20b:	00 00                	add    %al,(%eax)
     20d:	00 00                	add    %al,(%eax)
     20f:	00 23                	add    %ah,(%ebx)
     211:	05 00 00 80 00       	add    $0x800000,%eax
     216:	00 00                	add    %al,(%eax)
     218:	00 00                	add    %al,(%eax)
     21a:	00 00                	add    %al,(%eax)
     21c:	b3 05                	mov    $0x5,%bl
     21e:	00 00                	add    %al,(%eax)
     220:	80 00 00             	addb   $0x0,(%eax)
	...
     22b:	00 a2 00 00 00 00    	add    %ah,0x0(%edx)
     231:	00 00                	add    %al,(%eax)
     233:	00 31                	add    %dh,(%ecx)
     235:	06                   	push   %es
     236:	00 00                	add    %al,(%eax)
     238:	24 00                	and    $0x0,%al
     23a:	00 00                	add    %al,(%eax)
     23c:	00 00                	add    %al,(%eax)
     23e:	28 00                	sub    %al,(%eax)
     240:	00 00                	add    %al,(%eax)
     242:	00 00                	add    %al,(%eax)
     244:	44                   	inc    %esp
     245:	00 67 00             	add    %ah,0x0(%edi)
     248:	00 00                	add    %al,(%eax)
     24a:	00 00                	add    %al,(%eax)
     24c:	a4                   	movsb  %ds:(%esi),%es:(%edi)
     24d:	02 00                	add    (%eax),%al
     24f:	00 84 00 00 00 01 00 	add    %al,0x10000(%eax,%eax,1)
     256:	28 00                	sub    %al,(%eax)
     258:	00 00                	add    %al,(%eax)
     25a:	00 00                	add    %al,(%eax)
     25c:	44                   	inc    %esp
     25d:	00 42 00             	add    %al,0x0(%edx)
     260:	01 00                	add    %eax,(%eax)
     262:	00 00                	add    %al,(%eax)
     264:	01 00                	add    %eax,(%eax)
     266:	00 00                	add    %al,(%eax)
     268:	84 00                	test   %al,(%eax)
     26a:	00 00                	add    %al,(%eax)
     26c:	06                   	push   %es
     26d:	00 28                	add    %ch,(%eax)
     26f:	00 00                	add    %al,(%eax)
     271:	00 00                	add    %al,(%eax)
     273:	00 44 00 67          	add    %al,0x67(%eax,%eax,1)
     277:	00 06                	add    %al,(%esi)
     279:	00 00                	add    %al,(%eax)
     27b:	00 a4 02 00 00 84 00 	add    %ah,0x840000(%edx,%eax,1)
     282:	00 00                	add    %al,(%eax)
     284:	08 00                	or     %al,(%eax)
     286:	28 00                	sub    %al,(%eax)
     288:	00 00                	add    %al,(%eax)
     28a:	00 00                	add    %al,(%eax)
     28c:	44                   	inc    %esp
     28d:	00 42 00             	add    %al,0x0(%edx)
     290:	08 00                	or     %al,(%eax)
     292:	00 00                	add    %al,(%eax)
     294:	01 00                	add    %eax,(%eax)
     296:	00 00                	add    %al,(%eax)
     298:	84 00                	test   %al,(%eax)
     29a:	00 00                	add    %al,(%eax)
     29c:	09 00                	or     %eax,(%eax)
     29e:	28 00                	sub    %al,(%eax)
     2a0:	00 00                	add    %al,(%eax)
     2a2:	00 00                	add    %al,(%eax)
     2a4:	44                   	inc    %esp
     2a5:	00 6a 00             	add    %ch,0x0(%edx)
     2a8:	09 00                	or     %eax,(%eax)
     2aa:	00 00                	add    %al,(%eax)
     2ac:	00 00                	add    %al,(%eax)
     2ae:	00 00                	add    %al,(%eax)
     2b0:	44                   	inc    %esp
     2b1:	00 6f 00             	add    %ch,0x0(%edi)
     2b4:	0d 00 00 00 4c       	or     $0x4c000000,%eax
     2b9:	06                   	push   %es
     2ba:	00 00                	add    %al,(%eax)
     2bc:	24 00                	and    $0x0,%al
     2be:	00 00                	add    %al,(%eax)
     2c0:	0f 00 28             	verw   (%eax)
     2c3:	00 00                	add    %al,(%eax)
     2c5:	00 00                	add    %al,(%eax)
     2c7:	00 44 00 72          	add    %al,0x72(%eax,%eax,1)
	...
     2d3:	00 44 00 74          	add    %al,0x74(%eax,%eax,1)
     2d7:	00 03                	add    %al,(%ebx)
     2d9:	00 00                	add    %al,(%eax)
     2db:	00 a4 02 00 00 84 00 	add    %ah,0x840000(%edx,%eax,1)
     2e2:	00 00                	add    %al,(%eax)
     2e4:	17                   	pop    %ss
     2e5:	00 28                	add    %ch,(%eax)
     2e7:	00 00                	add    %al,(%eax)
     2e9:	00 00                	add    %al,(%eax)
     2eb:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
     2ef:	00 08                	add    %cl,(%eax)
     2f1:	00 00                	add    %al,(%eax)
     2f3:	00 01                	add    %al,(%ecx)
     2f5:	00 00                	add    %al,(%eax)
     2f7:	00 84 00 00 00 1f 00 	add    %al,0x1f0000(%eax,%eax,1)
     2fe:	28 00                	sub    %al,(%eax)
     300:	00 00                	add    %al,(%eax)
     302:	00 00                	add    %al,(%eax)
     304:	44                   	inc    %esp
     305:	00 76 00             	add    %dh,0x0(%esi)
     308:	10 00                	adc    %al,(%eax)
     30a:	00 00                	add    %al,(%eax)
     30c:	a4                   	movsb  %ds:(%esi),%es:(%edi)
     30d:	02 00                	add    (%eax),%al
     30f:	00 84 00 00 00 24 00 	add    %al,0x240000(%eax,%eax,1)
     316:	28 00                	sub    %al,(%eax)
     318:	00 00                	add    %al,(%eax)
     31a:	00 00                	add    %al,(%eax)
     31c:	44                   	inc    %esp
     31d:	00 5c 00 15          	add    %bl,0x15(%eax,%eax,1)
     321:	00 00                	add    %al,(%eax)
     323:	00 01                	add    %al,(%ecx)
     325:	00 00                	add    %al,(%eax)
     327:	00 84 00 00 00 2c 00 	add    %al,0x2c0000(%eax,%eax,1)
     32e:	28 00                	sub    %al,(%eax)
     330:	00 00                	add    %al,(%eax)
     332:	00 00                	add    %al,(%eax)
     334:	44                   	inc    %esp
     335:	00 79 00             	add    %bh,0x0(%ecx)
     338:	1d 00 00 00 62       	sbb    $0x62000000,%eax
     33d:	06                   	push   %es
     33e:	00 00                	add    %al,(%eax)
     340:	24 00                	and    $0x0,%al
     342:	00 00                	add    %al,(%eax)
     344:	2e 00 28             	add    %ch,%cs:(%eax)
     347:	00 00                	add    %al,(%eax)
     349:	00 00                	add    %al,(%eax)
     34b:	00 44 00 7f          	add    %al,0x7f(%eax,%eax,1)
	...
     357:	00 44 00 81          	add    %al,-0x7f(%eax,%eax,1)
     35b:	00 03                	add    %al,(%ebx)
     35d:	00 00                	add    %al,(%eax)
     35f:	00 a4 02 00 00 84 00 	add    %ah,0x840000(%edx,%eax,1)
     366:	00 00                	add    %al,(%eax)
     368:	36 00 28             	add    %ch,%ss:(%eax)
     36b:	00 00                	add    %al,(%eax)
     36d:	00 00                	add    %al,(%eax)
     36f:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
     373:	00 08                	add    %cl,(%eax)
     375:	00 00                	add    %al,(%eax)
     377:	00 01                	add    %al,(%ecx)
     379:	00 00                	add    %al,(%eax)
     37b:	00 84 00 00 00 3e 00 	add    %al,0x3e0000(%eax,%eax,1)
     382:	28 00                	sub    %al,(%eax)
     384:	00 00                	add    %al,(%eax)
     386:	00 00                	add    %al,(%eax)
     388:	44                   	inc    %esp
     389:	00 83 00 10 00 00    	add    %al,0x1000(%ebx)
     38f:	00 a4 02 00 00 84 00 	add    %ah,0x840000(%edx,%eax,1)
     396:	00 00                	add    %al,(%eax)
     398:	43                   	inc    %ebx
     399:	00 28                	add    %ch,(%eax)
     39b:	00 00                	add    %al,(%eax)
     39d:	00 00                	add    %al,(%eax)
     39f:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
     3a3:	00 15 00 00 00 01    	add    %dl,0x1000000
     3a9:	00 00                	add    %al,(%eax)
     3ab:	00 84 00 00 00 4b 00 	add    %al,0x4b0000(%eax,%eax,1)
     3b2:	28 00                	sub    %al,(%eax)
     3b4:	00 00                	add    %al,(%eax)
     3b6:	00 00                	add    %al,(%eax)
     3b8:	44                   	inc    %esp
     3b9:	00 86 00 1d 00 00    	add    %al,0x1d00(%esi)
     3bf:	00 77 06             	add    %dh,0x6(%edi)
     3c2:	00 00                	add    %al,(%eax)
     3c4:	24 00                	and    $0x0,%al
     3c6:	00 00                	add    %al,(%eax)
     3c8:	4d                   	dec    %ebp
     3c9:	00 28                	add    %ch,(%eax)
     3cb:	00 00                	add    %al,(%eax)
     3cd:	00 00                	add    %al,(%eax)
     3cf:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
	...
     3db:	00 44 00 17          	add    %al,0x17(%eax,%eax,1)
     3df:	00 0a                	add    %cl,(%edx)
     3e1:	00 00                	add    %al,(%eax)
     3e3:	00 a4 02 00 00 84 00 	add    %ah,0x840000(%edx,%eax,1)
     3ea:	00 00                	add    %al,(%eax)
     3ec:	5e                   	pop    %esi
     3ed:	00 28                	add    %ch,(%eax)
     3ef:	00 00                	add    %al,(%eax)
     3f1:	00 00                	add    %al,(%eax)
     3f3:	00 44 00 35          	add    %al,0x35(%eax,%eax,1)
     3f7:	00 11                	add    %dl,(%ecx)
     3f9:	00 00                	add    %al,(%eax)
     3fb:	00 01                	add    %al,(%ecx)
     3fd:	00 00                	add    %al,(%eax)
     3ff:	00 84 00 00 00 5f 00 	add    %al,0x5f0000(%eax,%eax,1)
     406:	28 00                	sub    %al,(%eax)
     408:	00 00                	add    %al,(%eax)
     40a:	00 00                	add    %al,(%eax)
     40c:	44                   	inc    %esp
     40d:	00 1a                	add    %bl,(%edx)
     40f:	00 12                	add    %dl,(%edx)
     411:	00 00                	add    %al,(%eax)
     413:	00 00                	add    %al,(%eax)
     415:	00 00                	add    %al,(%eax)
     417:	00 44 00 1b          	add    %al,0x1b(%eax,%eax,1)
     41b:	00 28                	add    %ch,(%eax)
     41d:	00 00                	add    %al,(%eax)
     41f:	00 00                	add    %al,(%eax)
     421:	00 00                	add    %al,(%eax)
     423:	00 44 00 31          	add    %al,0x31(%eax,%eax,1)
     427:	00 41 00             	add    %al,0x0(%ecx)
     42a:	00 00                	add    %al,(%eax)
     42c:	00 00                	add    %al,(%eax)
     42e:	00 00                	add    %al,(%eax)
     430:	44                   	inc    %esp
     431:	00 1c 00             	add    %bl,(%eax,%eax,1)
     434:	47                   	inc    %edi
     435:	00 00                	add    %al,(%eax)
     437:	00 00                	add    %al,(%eax)
     439:	00 00                	add    %al,(%eax)
     43b:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
     43f:	00 53 00             	add    %dl,0x0(%ebx)
     442:	00 00                	add    %al,(%eax)
     444:	00 00                	add    %al,(%eax)
     446:	00 00                	add    %al,(%eax)
     448:	44                   	inc    %esp
     449:	00 1f                	add    %bl,(%edi)
     44b:	00 58 00             	add    %bl,0x0(%eax)
     44e:	00 00                	add    %al,(%eax)
     450:	00 00                	add    %al,(%eax)
     452:	00 00                	add    %al,(%eax)
     454:	44                   	inc    %esp
     455:	00 31                	add    %dh,(%ecx)
     457:	00 5d 00             	add    %bl,0x0(%ebp)
     45a:	00 00                	add    %al,(%eax)
     45c:	00 00                	add    %al,(%eax)
     45e:	00 00                	add    %al,(%eax)
     460:	44                   	inc    %esp
     461:	00 32                	add    %dh,(%edx)
     463:	00 67 00             	add    %ah,0x0(%edi)
     466:	00 00                	add    %al,(%eax)
     468:	00 00                	add    %al,(%eax)
     46a:	00 00                	add    %al,(%eax)
     46c:	44                   	inc    %esp
     46d:	00 33                	add    %dh,(%ebx)
     46f:	00 84 00 00 00 00 00 	add    %al,0x0(%eax,%eax,1)
     476:	00 00                	add    %al,(%eax)
     478:	44                   	inc    %esp
     479:	00 34 00             	add    %dh,(%eax,%eax,1)
     47c:	8c 00                	mov    %es,(%eax)
     47e:	00 00                	add    %al,(%eax)
     480:	a4                   	movsb  %ds:(%esi),%es:(%edi)
     481:	02 00                	add    (%eax),%al
     483:	00 84 00 00 00 de 00 	add    %al,0xde0000(%eax,%eax,1)
     48a:	28 00                	sub    %al,(%eax)
     48c:	00 00                	add    %al,(%eax)
     48e:	00 00                	add    %al,(%eax)
     490:	44                   	inc    %esp
     491:	00 5c 00 91          	add    %bl,-0x6f(%eax,%eax,1)
     495:	00 00                	add    %al,(%eax)
     497:	00 01                	add    %al,(%ecx)
     499:	00 00                	add    %al,(%eax)
     49b:	00 84 00 00 00 eb 00 	add    %al,0xeb0000(%eax,%eax,1)
     4a2:	28 00                	sub    %al,(%eax)
     4a4:	00 00                	add    %al,(%eax)
     4a6:	00 00                	add    %al,(%eax)
     4a8:	44                   	inc    %esp
     4a9:	00 41 00             	add    %al,0x0(%ecx)
     4ac:	9e                   	sahf   
     4ad:	00 00                	add    %al,(%eax)
     4af:	00 00                	add    %al,(%eax)
     4b1:	00 00                	add    %al,(%eax)
     4b3:	00 44 00 56          	add    %al,0x56(%eax,%eax,1)
     4b7:	00 a8 00 00 00 00    	add    %ch,0x0(%eax)
     4bd:	00 00                	add    %al,(%eax)
     4bf:	00 44 00 41          	add    %al,0x41(%eax,%eax,1)
     4c3:	00 ae 00 00 00 00    	add    %ch,0x0(%esi)
     4c9:	00 00                	add    %al,(%eax)
     4cb:	00 44 00 42          	add    %al,0x42(%eax,%eax,1)
     4cf:	00 b3 00 00 00 00    	add    %dh,0x0(%ebx)
     4d5:	00 00                	add    %al,(%eax)
     4d7:	00 44 00 45          	add    %al,0x45(%eax,%eax,1)
     4db:	00 c5                	add    %al,%ch
     4dd:	00 00                	add    %al,(%eax)
     4df:	00 00                	add    %al,(%eax)
     4e1:	00 00                	add    %al,(%eax)
     4e3:	00 44 00 46          	add    %al,0x46(%eax,%eax,1)
     4e7:	00 ca                	add    %cl,%dl
     4e9:	00 00                	add    %al,(%eax)
     4eb:	00 00                	add    %al,(%eax)
     4ed:	00 00                	add    %al,(%eax)
     4ef:	00 44 00 49          	add    %al,0x49(%eax,%eax,1)
     4f3:	00 d2                	add    %dl,%dl
     4f5:	00 00                	add    %al,(%eax)
     4f7:	00 00                	add    %al,(%eax)
     4f9:	00 00                	add    %al,(%eax)
     4fb:	00 44 00 4a          	add    %al,0x4a(%eax,%eax,1)
     4ff:	00 d3                	add    %dl,%bl
     501:	00 00                	add    %al,(%eax)
     503:	00 00                	add    %al,(%eax)
     505:	00 00                	add    %al,(%eax)
     507:	00 44 00 4b          	add    %al,0x4b(%eax,%eax,1)
     50b:	00 e7                	add    %ah,%bh
     50d:	00 00                	add    %al,(%eax)
     50f:	00 00                	add    %al,(%eax)
     511:	00 00                	add    %al,(%eax)
     513:	00 44 00 4a          	add    %al,0x4a(%eax,%eax,1)
     517:	00 ee                	add    %ch,%dh
     519:	00 00                	add    %al,(%eax)
     51b:	00 00                	add    %al,(%eax)
     51d:	00 00                	add    %al,(%eax)
     51f:	00 44 00 4d          	add    %al,0x4d(%eax,%eax,1)
     523:	00 02                	add    %al,(%edx)
     525:	01 00                	add    %eax,(%eax)
     527:	00 00                	add    %al,(%eax)
     529:	00 00                	add    %al,(%eax)
     52b:	00 44 00 4e          	add    %al,0x4e(%eax,%eax,1)
     52f:	00 16                	add    %dl,(%esi)
     531:	01 00                	add    %eax,(%eax)
     533:	00 00                	add    %al,(%eax)
     535:	00 00                	add    %al,(%eax)
     537:	00 44 00 4f          	add    %al,0x4f(%eax,%eax,1)
     53b:	00 23                	add    %ah,(%ebx)
     53d:	01 00                	add    %eax,(%eax)
     53f:	00 00                	add    %al,(%eax)
     541:	00 00                	add    %al,(%eax)
     543:	00 44 00 50          	add    %al,0x50(%eax,%eax,1)
     547:	00 24 01             	add    %ah,(%ecx,%eax,1)
     54a:	00 00                	add    %al,(%eax)
     54c:	00 00                	add    %al,(%eax)
     54e:	00 00                	add    %al,(%eax)
     550:	44                   	inc    %esp
     551:	00 51 00             	add    %dl,0x0(%ecx)
     554:	33 01                	xor    (%ecx),%eax
     556:	00 00                	add    %al,(%eax)
     558:	00 00                	add    %al,(%eax)
     55a:	00 00                	add    %al,(%eax)
     55c:	44                   	inc    %esp
     55d:	00 52 00             	add    %dl,0x0(%edx)
     560:	52                   	push   %edx
     561:	01 00                	add    %eax,(%eax)
     563:	00 00                	add    %al,(%eax)
     565:	00 00                	add    %al,(%eax)
     567:	00 44 00 53          	add    %al,0x53(%eax,%eax,1)
     56b:	00 63 01             	add    %ah,0x1(%ebx)
     56e:	00 00                	add    %al,(%eax)
     570:	00 00                	add    %al,(%eax)
     572:	00 00                	add    %al,(%eax)
     574:	44                   	inc    %esp
     575:	00 54 00 7b          	add    %dl,0x7b(%eax,%eax,1)
     579:	01 00                	add    %eax,(%eax)
     57b:	00 00                	add    %al,(%eax)
     57d:	00 00                	add    %al,(%eax)
     57f:	00 44 00 55          	add    %al,0x55(%eax,%eax,1)
     583:	00 88 01 00 00 00    	add    %cl,0x1(%eax)
     589:	00 00                	add    %al,(%eax)
     58b:	00 44 00 56          	add    %al,0x56(%eax,%eax,1)
     58f:	00 89 01 00 00 00    	add    %cl,0x1(%ecx)
     595:	00 00                	add    %al,(%eax)
     597:	00 44 00 57          	add    %al,0x57(%eax,%eax,1)
     59b:	00 98 01 00 00 00    	add    %bl,0x1(%eax)
     5a1:	00 00                	add    %al,(%eax)
     5a3:	00 44 00 58          	add    %al,0x58(%eax,%eax,1)
     5a7:	00 b7 01 00 00 88    	add    %dh,-0x77ffffff(%edi)
     5ad:	06                   	push   %es
     5ae:	00 00                	add    %al,(%eax)
     5b0:	80 00 00             	addb   $0x0,(%eax)
     5b3:	00 50 fe             	add    %dl,-0x2(%eax)
     5b6:	ff                   	(bad)  
     5b7:	ff                   	(bad)  
     5b8:	bb 06 00 00 80       	mov    $0x80000006,%ebx
     5bd:	00 00                	add    %al,(%eax)
     5bf:	00 f8                	add    %bh,%al
     5c1:	fe                   	(bad)  
     5c2:	ff                   	(bad)  
     5c3:	ff e0                	jmp    *%eax
     5c5:	06                   	push   %es
     5c6:	00 00                	add    %al,(%eax)
     5c8:	80 00 00             	addb   $0x0,(%eax)
     5cb:	00 30                	add    %dh,(%eax)
     5cd:	fe                   	(bad)  
     5ce:	ff                   	(bad)  
     5cf:	ff 02                	incl   (%edx)
     5d1:	07                   	pop    %es
     5d2:	00 00                	add    %al,(%eax)
     5d4:	80 00 00             	addb   $0x0,(%eax)
     5d7:	00 78 fe             	add    %bh,-0x2(%eax)
     5da:	ff                   	(bad)  
     5db:	ff 00                	incl   (%eax)
     5dd:	00 00                	add    %al,(%eax)
     5df:	00 c0                	add    %al,%al
	...
     5e9:	00 00                	add    %al,(%eax)
     5eb:	00 e0                	add    %ah,%al
     5ed:	00 00                	add    %al,(%eax)
     5ef:	00 db                	add    %bl,%bl
     5f1:	01 00                	add    %eax,(%eax)
     5f3:	00 27                	add    %ah,(%edi)
     5f5:	07                   	pop    %es
     5f6:	00 00                	add    %al,(%eax)
     5f8:	20 00                	and    %al,(%eax)
     5fa:	00 00                	add    %al,(%eax)
     5fc:	00 00                	add    %al,(%eax)
     5fe:	00 00                	add    %al,(%eax)
     600:	51                   	push   %ecx
     601:	07                   	pop    %es
     602:	00 00                	add    %al,(%eax)
     604:	20 00                	and    %al,(%eax)
     606:	00 00                	add    %al,(%eax)
     608:	00 00                	add    %al,(%eax)
     60a:	00 00                	add    %al,(%eax)
     60c:	79 07                	jns    615 <wait_KBC_sendready-0x27f9eb>
     60e:	00 00                	add    %al,(%eax)
     610:	20 00                	and    %al,(%eax)
	...
     61a:	00 00                	add    %al,(%eax)
     61c:	64 00 00             	add    %al,%fs:(%eax)
     61f:	00 28                	add    %ch,(%eax)
     621:	02 28                	add    (%eax),%ch
     623:	00 8e 07 00 00 64    	add    %cl,0x64000007(%esi)
     629:	00 02                	add    %al,(%edx)
     62b:	00 28                	add    %ch,(%eax)
     62d:	02 28                	add    (%eax),%ch
     62f:	00 08                	add    %cl,(%eax)
     631:	00 00                	add    %al,(%eax)
     633:	00 3c 00             	add    %bh,(%eax,%eax,1)
     636:	00 00                	add    %al,(%eax)
     638:	00 00                	add    %al,(%eax)
     63a:	00 00                	add    %al,(%eax)
     63c:	17                   	pop    %ss
     63d:	00 00                	add    %al,(%eax)
     63f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     645:	00 00                	add    %al,(%eax)
     647:	00 41 00             	add    %al,0x0(%ecx)
     64a:	00 00                	add    %al,(%eax)
     64c:	80 00 00             	addb   $0x0,(%eax)
     64f:	00 00                	add    %al,(%eax)
     651:	00 00                	add    %al,(%eax)
     653:	00 5b 00             	add    %bl,0x0(%ebx)
     656:	00 00                	add    %al,(%eax)
     658:	80 00 00             	addb   $0x0,(%eax)
     65b:	00 00                	add    %al,(%eax)
     65d:	00 00                	add    %al,(%eax)
     65f:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
     665:	00 00                	add    %al,(%eax)
     667:	00 00                	add    %al,(%eax)
     669:	00 00                	add    %al,(%eax)
     66b:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
     671:	00 00                	add    %al,(%eax)
     673:	00 00                	add    %al,(%eax)
     675:	00 00                	add    %al,(%eax)
     677:	00 e1                	add    %ah,%cl
     679:	00 00                	add    %al,(%eax)
     67b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     681:	00 00                	add    %al,(%eax)
     683:	00 0c 01             	add    %cl,(%ecx,%eax,1)
     686:	00 00                	add    %al,(%eax)
     688:	80 00 00             	addb   $0x0,(%eax)
     68b:	00 00                	add    %al,(%eax)
     68d:	00 00                	add    %al,(%eax)
     68f:	00 37                	add    %dh,(%edi)
     691:	01 00                	add    %eax,(%eax)
     693:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     699:	00 00                	add    %al,(%eax)
     69b:	00 5d 01             	add    %bl,0x1(%ebp)
     69e:	00 00                	add    %al,(%eax)
     6a0:	80 00 00             	addb   $0x0,(%eax)
     6a3:	00 00                	add    %al,(%eax)
     6a5:	00 00                	add    %al,(%eax)
     6a7:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
     6ad:	00 00                	add    %al,(%eax)
     6af:	00 00                	add    %al,(%eax)
     6b1:	00 00                	add    %al,(%eax)
     6b3:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
     6b9:	00 00                	add    %al,(%eax)
     6bb:	00 00                	add    %al,(%eax)
     6bd:	00 00                	add    %al,(%eax)
     6bf:	00 d2                	add    %dl,%dl
     6c1:	01 00                	add    %eax,(%eax)
     6c3:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     6c9:	00 00                	add    %al,(%eax)
     6cb:	00 ec                	add    %ch,%ah
     6cd:	01 00                	add    %eax,(%eax)
     6cf:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     6d5:	00 00                	add    %al,(%eax)
     6d7:	00 07                	add    %al,(%edi)
     6d9:	02 00                	add    (%eax),%al
     6db:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     6e1:	00 00                	add    %al,(%eax)
     6e3:	00 28                	add    %ch,(%eax)
     6e5:	02 00                	add    (%eax),%al
     6e7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     6ed:	00 00                	add    %al,(%eax)
     6ef:	00 47 02             	add    %al,0x2(%edi)
     6f2:	00 00                	add    %al,(%eax)
     6f4:	80 00 00             	addb   $0x0,(%eax)
     6f7:	00 00                	add    %al,(%eax)
     6f9:	00 00                	add    %al,(%eax)
     6fb:	00 66 02             	add    %ah,0x2(%esi)
     6fe:	00 00                	add    %al,(%eax)
     700:	80 00 00             	addb   $0x0,(%eax)
     703:	00 00                	add    %al,(%eax)
     705:	00 00                	add    %al,(%eax)
     707:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
     70d:	00 00                	add    %al,(%eax)
     70f:	00 00                	add    %al,(%eax)
     711:	00 00                	add    %al,(%eax)
     713:	00 97 07 00 00 82    	add    %dl,-0x7dfffff9(%edi)
     719:	00 00                	add    %al,(%eax)
     71b:	00 d4                	add    %dl,%ah
     71d:	8c 00                	mov    %es,(%eax)
     71f:	00 a2 07 00 00 82    	add    %ah,-0x7dfffff9(%edx)
     725:	00 00                	add    %al,(%eax)
     727:	00 00                	add    %al,(%eax)
     729:	00 00                	add    %al,(%eax)
     72b:	00 aa 07 00 00 82    	add    %ch,-0x7dfffff9(%edx)
     731:	00 00                	add    %al,(%eax)
     733:	00 37                	add    %dh,(%edi)
     735:	53                   	push   %ebx
     736:	00 00                	add    %al,(%eax)
     738:	b2 02                	mov    $0x2,%dl
     73a:	00 00                	add    %al,(%eax)
     73c:	80 00 00             	addb   $0x0,(%eax)
     73f:	00 00                	add    %al,(%eax)
     741:	00 00                	add    %al,(%eax)
     743:	00 c4                	add    %al,%ah
     745:	02 00                	add    (%eax),%al
     747:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     74d:	00 00                	add    %al,(%eax)
     74f:	00 d9                	add    %bl,%cl
     751:	02 00                	add    (%eax),%al
     753:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     759:	00 00                	add    %al,(%eax)
     75b:	00 ef                	add    %ch,%bh
     75d:	02 00                	add    (%eax),%al
     75f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     765:	00 00                	add    %al,(%eax)
     767:	00 04 03             	add    %al,(%ebx,%eax,1)
     76a:	00 00                	add    %al,(%eax)
     76c:	80 00 00             	addb   $0x0,(%eax)
     76f:	00 00                	add    %al,(%eax)
     771:	00 00                	add    %al,(%eax)
     773:	00 1a                	add    %bl,(%edx)
     775:	03 00                	add    (%eax),%eax
     777:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     77d:	00 00                	add    %al,(%eax)
     77f:	00 2f                	add    %ch,(%edi)
     781:	03 00                	add    (%eax),%eax
     783:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     789:	00 00                	add    %al,(%eax)
     78b:	00 45 03             	add    %al,0x3(%ebp)
     78e:	00 00                	add    %al,(%eax)
     790:	80 00 00             	addb   $0x0,(%eax)
     793:	00 00                	add    %al,(%eax)
     795:	00 00                	add    %al,(%eax)
     797:	00 5a 03             	add    %bl,0x3(%edx)
     79a:	00 00                	add    %al,(%eax)
     79c:	80 00 00             	addb   $0x0,(%eax)
     79f:	00 00                	add    %al,(%eax)
     7a1:	00 00                	add    %al,(%eax)
     7a3:	00 70 03             	add    %dh,0x3(%eax)
     7a6:	00 00                	add    %al,(%eax)
     7a8:	80 00 00             	addb   $0x0,(%eax)
     7ab:	00 00                	add    %al,(%eax)
     7ad:	00 00                	add    %al,(%eax)
     7af:	00 87 03 00 00 80    	add    %al,-0x7ffffffd(%edi)
     7b5:	00 00                	add    %al,(%eax)
     7b7:	00 00                	add    %al,(%eax)
     7b9:	00 00                	add    %al,(%eax)
     7bb:	00 9f 03 00 00 80    	add    %bl,-0x7ffffffd(%edi)
     7c1:	00 00                	add    %al,(%eax)
     7c3:	00 00                	add    %al,(%eax)
     7c5:	00 00                	add    %al,(%eax)
     7c7:	00 b8 03 00 00 80    	add    %bh,-0x7ffffffd(%eax)
     7cd:	00 00                	add    %al,(%eax)
     7cf:	00 00                	add    %al,(%eax)
     7d1:	00 00                	add    %al,(%eax)
     7d3:	00 cc                	add    %cl,%ah
     7d5:	03 00                	add    (%eax),%eax
     7d7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     7dd:	00 00                	add    %al,(%eax)
     7df:	00 e1                	add    %ah,%cl
     7e1:	03 00                	add    (%eax),%eax
     7e3:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     7e9:	00 00                	add    %al,(%eax)
     7eb:	00 f7                	add    %dh,%bh
     7ed:	03 00                	add    (%eax),%eax
     7ef:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     7f5:	00 00                	add    %al,(%eax)
     7f7:	00 00                	add    %al,(%eax)
     7f9:	00 00                	add    %al,(%eax)
     7fb:	00 a2 00 00 00 00    	add    %ah,0x0(%edx)
     801:	00 00                	add    %al,(%eax)
     803:	00 00                	add    %al,(%eax)
     805:	00 00                	add    %al,(%eax)
     807:	00 a2 00 00 00 00    	add    %ah,0x0(%edx)
     80d:	00 00                	add    %al,(%eax)
     80f:	00 0b                	add    %cl,(%ebx)
     811:	04 00                	add    $0x0,%al
     813:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     819:	00 00                	add    %al,(%eax)
     81b:	00 86 04 00 00 80    	add    %al,-0x7ffffffc(%esi)
     821:	00 00                	add    %al,(%eax)
     823:	00 00                	add    %al,(%eax)
     825:	00 00                	add    %al,(%eax)
     827:	00 23                	add    %ah,(%ebx)
     829:	05 00 00 80 00       	add    $0x800000,%eax
     82e:	00 00                	add    %al,(%eax)
     830:	00 00                	add    %al,(%eax)
     832:	00 00                	add    %al,(%eax)
     834:	b3 05                	mov    $0x5,%bl
     836:	00 00                	add    %al,(%eax)
     838:	80 00 00             	addb   $0x0,(%eax)
	...
     843:	00 a2 00 00 00 00    	add    %ah,0x0(%edx)
     849:	00 00                	add    %al,(%eax)
     84b:	00 b4 07 00 00 24 00 	add    %dh,0x240000(%edi,%eax,1)
     852:	00 00                	add    %al,(%eax)
     854:	28 02                	sub    %al,(%edx)
     856:	28 00                	sub    %al,(%eax)
     858:	c9                   	leave  
     859:	07                   	pop    %es
     85a:	00 00                	add    %al,(%eax)
     85c:	a0 00 00 00 08       	mov    0x8000000,%al
     861:	00 00                	add    %al,(%eax)
     863:	00 00                	add    %al,(%eax)
     865:	00 00                	add    %al,(%eax)
     867:	00 44 00 04          	add    %al,0x4(%eax,%eax,1)
	...
     873:	00 44 00 06          	add    %al,0x6(%eax,%eax,1)
     877:	00 01                	add    %al,(%ecx)
     879:	00 00                	add    %al,(%eax)
     87b:	00 00                	add    %al,(%eax)
     87d:	00 00                	add    %al,(%eax)
     87f:	00 44 00 04          	add    %al,0x4(%eax,%eax,1)
     883:	00 06                	add    %al,(%esi)
     885:	00 00                	add    %al,(%eax)
     887:	00 00                	add    %al,(%eax)
     889:	00 00                	add    %al,(%eax)
     88b:	00 44 00 04          	add    %al,0x4(%eax,%eax,1)
     88f:	00 08                	add    %cl,(%eax)
     891:	00 00                	add    %al,(%eax)
     893:	00 00                	add    %al,(%eax)
     895:	00 00                	add    %al,(%eax)
     897:	00 44 00 08          	add    %al,0x8(%eax,%eax,1)
     89b:	00 0b                	add    %cl,(%ebx)
     89d:	00 00                	add    %al,(%eax)
     89f:	00 00                	add    %al,(%eax)
     8a1:	00 00                	add    %al,(%eax)
     8a3:	00 44 00 06          	add    %al,0x6(%eax,%eax,1)
     8a7:	00 0d 00 00 00 00    	add    %cl,0x0
     8ad:	00 00                	add    %al,(%eax)
     8af:	00 44 00 0b          	add    %al,0xb(%eax,%eax,1)
     8b3:	00 15 00 00 00 d6    	add    %dl,0xd6000000
     8b9:	07                   	pop    %es
     8ba:	00 00                	add    %al,(%eax)
     8bc:	40                   	inc    %eax
     8bd:	00 00                	add    %al,(%eax)
     8bf:	00 00                	add    %al,(%eax)
     8c1:	00 00                	add    %al,(%eax)
     8c3:	00 df                	add    %bl,%bh
     8c5:	07                   	pop    %es
     8c6:	00 00                	add    %al,(%eax)
     8c8:	40                   	inc    %eax
     8c9:	00 00                	add    %al,(%eax)
     8cb:	00 02                	add    %al,(%edx)
     8cd:	00 00                	add    %al,(%eax)
     8cf:	00 00                	add    %al,(%eax)
     8d1:	00 00                	add    %al,(%eax)
     8d3:	00 c0                	add    %al,%al
	...
     8dd:	00 00                	add    %al,(%eax)
     8df:	00 e0                	add    %ah,%al
     8e1:	00 00                	add    %al,(%eax)
     8e3:	00 17                	add    %dl,(%edi)
     8e5:	00 00                	add    %al,(%eax)
     8e7:	00 ec                	add    %ch,%ah
     8e9:	07                   	pop    %es
     8ea:	00 00                	add    %al,(%eax)
     8ec:	24 00                	and    $0x0,%al
     8ee:	00 00                	add    %al,(%eax)
     8f0:	3f                   	aas    
     8f1:	02 28                	add    (%eax),%ch
     8f3:	00 c9                	add    %cl,%cl
     8f5:	07                   	pop    %es
     8f6:	00 00                	add    %al,(%eax)
     8f8:	a0 00 00 00 08       	mov    0x8000000,%al
     8fd:	00 00                	add    %al,(%eax)
     8ff:	00 00                	add    %al,(%eax)
     901:	00 00                	add    %al,(%eax)
     903:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
	...
     90f:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
     913:	00 01                	add    %al,(%ecx)
     915:	00 00                	add    %al,(%eax)
     917:	00 00                	add    %al,(%eax)
     919:	00 00                	add    %al,(%eax)
     91b:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
     91f:	00 06                	add    %al,(%esi)
     921:	00 00                	add    %al,(%eax)
     923:	00 00                	add    %al,(%eax)
     925:	00 00                	add    %al,(%eax)
     927:	00 44 00 13          	add    %al,0x13(%eax,%eax,1)
     92b:	00 08                	add    %cl,(%eax)
     92d:	00 00                	add    %al,(%eax)
     92f:	00 00                	add    %al,(%eax)
     931:	00 00                	add    %al,(%eax)
     933:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
     937:	00 0a                	add    %cl,(%edx)
     939:	00 00                	add    %al,(%eax)
     93b:	00 00                	add    %al,(%eax)
     93d:	00 00                	add    %al,(%eax)
     93f:	00 44 00 16          	add    %al,0x16(%eax,%eax,1)
     943:	00 12                	add    %dl,(%edx)
     945:	00 00                	add    %al,(%eax)
     947:	00 d6                	add    %dl,%dh
     949:	07                   	pop    %es
     94a:	00 00                	add    %al,(%eax)
     94c:	40                   	inc    %eax
	...
     955:	00 00                	add    %al,(%eax)
     957:	00 c0                	add    %al,%al
	...
     961:	00 00                	add    %al,(%eax)
     963:	00 e0                	add    %ah,%al
     965:	00 00                	add    %al,(%eax)
     967:	00 14 00             	add    %dl,(%eax,%eax,1)
     96a:	00 00                	add    %al,(%eax)
     96c:	01 08                	add    %ecx,(%eax)
     96e:	00 00                	add    %al,(%eax)
     970:	24 00                	and    $0x0,%al
     972:	00 00                	add    %al,(%eax)
     974:	53                   	push   %ebx
     975:	02 28                	add    (%eax),%ch
     977:	00 15 08 00 00 a0    	add    %dl,0xa0000008
     97d:	00 00                	add    %al,(%eax)
     97f:	00 08                	add    %cl,(%eax)
     981:	00 00                	add    %al,(%eax)
     983:	00 22                	add    %ah,(%edx)
     985:	08 00                	or     %al,(%eax)
     987:	00 a0 00 00 00 0c    	add    %ah,0xc000000(%eax)
     98d:	00 00                	add    %al,(%eax)
     98f:	00 2d 08 00 00 a0    	add    %ch,0xa0000008
     995:	00 00                	add    %al,(%eax)
     997:	00 10                	add    %dl,(%eax)
     999:	00 00                	add    %al,(%eax)
     99b:	00 00                	add    %al,(%eax)
     99d:	00 00                	add    %al,(%eax)
     99f:	00 44 00 37          	add    %al,0x37(%eax,%eax,1)
	...
     9ab:	00 44 00 37          	add    %al,0x37(%eax,%eax,1)
     9af:	00 08                	add    %cl,(%eax)
     9b1:	00 00                	add    %al,(%eax)
     9b3:	00 a2 07 00 00 84    	add    %ah,-0x7bfffff9(%edx)
     9b9:	00 00                	add    %al,(%eax)
     9bb:	00 5e 02             	add    %bl,0x2(%esi)
     9be:	28 00                	sub    %al,(%eax)
     9c0:	00 00                	add    %al,(%eax)
     9c2:	00 00                	add    %al,(%eax)
     9c4:	44                   	inc    %esp
     9c5:	00 2c 01             	add    %ch,(%ecx,%eax,1)
     9c8:	0b 00                	or     (%eax),%eax
     9ca:	00 00                	add    %al,(%eax)
     9cc:	8e 07                	mov    (%edi),%es
     9ce:	00 00                	add    %al,(%eax)
     9d0:	84 00                	test   %al,(%eax)
     9d2:	00 00                	add    %al,(%eax)
     9d4:	60                   	pusha  
     9d5:	02 28                	add    (%eax),%ch
     9d7:	00 00                	add    %al,(%eax)
     9d9:	00 00                	add    %al,(%eax)
     9db:	00 44 00 3b          	add    %al,0x3b(%eax,%eax,1)
     9df:	00 0d 00 00 00 a2    	add    %cl,0xa2000000
     9e5:	07                   	pop    %es
     9e6:	00 00                	add    %al,(%eax)
     9e8:	84 00                	test   %al,(%eax)
     9ea:	00 00                	add    %al,(%eax)
     9ec:	61                   	popa   
     9ed:	02 28                	add    (%eax),%ch
     9ef:	00 00                	add    %al,(%eax)
     9f1:	00 00                	add    %al,(%eax)
     9f3:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
     9f7:	00 0e                	add    %cl,(%esi)
     9f9:	00 00                	add    %al,(%eax)
     9fb:	00 8e 07 00 00 84    	add    %cl,-0x7bfffff9(%esi)
     a01:	00 00                	add    %al,(%eax)
     a03:	00 66 02             	add    %ah,0x2(%esi)
     a06:	28 00                	sub    %al,(%eax)
     a08:	00 00                	add    %al,(%eax)
     a0a:	00 00                	add    %al,(%eax)
     a0c:	44                   	inc    %esp
     a0d:	00 3f                	add    %bh,(%edi)
     a0f:	00 13                	add    %dl,(%ebx)
     a11:	00 00                	add    %al,(%eax)
     a13:	00 a2 07 00 00 84    	add    %ah,-0x7bfffff9(%edx)
     a19:	00 00                	add    %al,(%eax)
     a1b:	00 69 02             	add    %ch,0x2(%ecx)
     a1e:	28 00                	sub    %al,(%eax)
     a20:	00 00                	add    %al,(%eax)
     a22:	00 00                	add    %al,(%eax)
     a24:	44                   	inc    %esp
     a25:	00 5c 00 16          	add    %bl,0x16(%eax,%eax,1)
     a29:	00 00                	add    %al,(%eax)
     a2b:	00 8e 07 00 00 84    	add    %cl,-0x7bfffff9(%esi)
     a31:	00 00                	add    %al,(%eax)
     a33:	00 6c 02 28          	add    %ch,0x28(%edx,%eax,1)
     a37:	00 00                	add    %al,(%eax)
     a39:	00 00                	add    %al,(%eax)
     a3b:	00 44 00 40          	add    %al,0x40(%eax,%eax,1)
     a3f:	00 19                	add    %bl,(%ecx)
     a41:	00 00                	add    %al,(%eax)
     a43:	00 a2 07 00 00 84    	add    %ah,-0x7bfffff9(%edx)
     a49:	00 00                	add    %al,(%eax)
     a4b:	00 71 02             	add    %dh,0x2(%ecx)
     a4e:	28 00                	sub    %al,(%eax)
     a50:	00 00                	add    %al,(%eax)
     a52:	00 00                	add    %al,(%eax)
     a54:	44                   	inc    %esp
     a55:	00 5c 00 1e          	add    %bl,0x1e(%eax,%eax,1)
     a59:	00 00                	add    %al,(%eax)
     a5b:	00 8e 07 00 00 84    	add    %cl,-0x7bfffff9(%esi)
     a61:	00 00                	add    %al,(%eax)
     a63:	00 7c 02 28          	add    %bh,0x28(%edx,%eax,1)
     a67:	00 00                	add    %al,(%eax)
     a69:	00 00                	add    %al,(%eax)
     a6b:	00 44 00 45          	add    %al,0x45(%eax,%eax,1)
     a6f:	00 29                	add    %ch,(%ecx)
     a71:	00 00                	add    %al,(%eax)
     a73:	00 00                	add    %al,(%eax)
     a75:	00 00                	add    %al,(%eax)
     a77:	00 44 00 40          	add    %al,0x40(%eax,%eax,1)
     a7b:	00 2c 00             	add    %ch,(%eax,%eax,1)
     a7e:	00 00                	add    %al,(%eax)
     a80:	a2 07 00 00 84       	mov    %al,0x84000007
     a85:	00 00                	add    %al,(%eax)
     a87:	00 82 02 28 00 00    	add    %al,0x2802(%edx)
     a8d:	00 00                	add    %al,(%eax)
     a8f:	00 44 00 33          	add    %al,0x33(%eax,%eax,1)
     a93:	01 2f                	add    %ebp,(%edi)
     a95:	00 00                	add    %al,(%eax)
     a97:	00 8e 07 00 00 84    	add    %cl,-0x7bfffff9(%esi)
     a9d:	00 00                	add    %al,(%eax)
     a9f:	00 84 02 28 00 00 00 	add    %al,0x28(%edx,%eax,1)
     aa6:	00 00                	add    %al,(%eax)
     aa8:	44                   	inc    %esp
     aa9:	00 4b 00             	add    %cl,0x0(%ebx)
     aac:	31 00                	xor    %eax,(%eax)
     aae:	00 00                	add    %al,(%eax)
     ab0:	38 08                	cmp    %cl,(%eax)
     ab2:	00 00                	add    %al,(%eax)
     ab4:	40                   	inc    %eax
     ab5:	00 00                	add    %al,(%eax)
     ab7:	00 03                	add    %al,(%ebx)
     ab9:	00 00                	add    %al,(%eax)
     abb:	00 45 08             	add    %al,0x8(%ebp)
     abe:	00 00                	add    %al,(%eax)
     ac0:	40                   	inc    %eax
     ac1:	00 00                	add    %al,(%eax)
     ac3:	00 01                	add    %al,(%ecx)
     ac5:	00 00                	add    %al,(%eax)
     ac7:	00 50 08             	add    %dl,0x8(%eax)
     aca:	00 00                	add    %al,(%eax)
     acc:	24 00                	and    $0x0,%al
     ace:	00 00                	add    %al,(%eax)
     ad0:	88 02                	mov    %al,(%edx)
     ad2:	28 00                	sub    %al,(%eax)
     ad4:	00 00                	add    %al,(%eax)
     ad6:	00 00                	add    %al,(%eax)
     ad8:	44                   	inc    %esp
     ad9:	00 1b                	add    %bl,(%ebx)
	...
     ae3:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
     ae7:	00 01                	add    %al,(%ecx)
     ae9:	00 00                	add    %al,(%eax)
     aeb:	00 00                	add    %al,(%eax)
     aed:	00 00                	add    %al,(%eax)
     aef:	00 44 00 1b          	add    %al,0x1b(%eax,%eax,1)
     af3:	00 06                	add    %al,(%esi)
     af5:	00 00                	add    %al,(%eax)
     af7:	00 00                	add    %al,(%eax)
     af9:	00 00                	add    %al,(%eax)
     afb:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
     aff:	00 0a                	add    %cl,(%edx)
     b01:	00 00                	add    %al,(%eax)
     b03:	00 00                	add    %al,(%eax)
     b05:	00 00                	add    %al,(%eax)
     b07:	00 44 00 1b          	add    %al,0x1b(%eax,%eax,1)
     b0b:	00 0f                	add    %cl,(%edi)
     b0d:	00 00                	add    %al,(%eax)
     b0f:	00 00                	add    %al,(%eax)
     b11:	00 00                	add    %al,(%eax)
     b13:	00 44 00 32          	add    %al,0x32(%eax,%eax,1)
     b17:	00 12                	add    %dl,(%edx)
     b19:	00 00                	add    %al,(%eax)
     b1b:	00 00                	add    %al,(%eax)
     b1d:	00 00                	add    %al,(%eax)
     b1f:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
     b23:	00 15 00 00 00 00    	add    %dl,0x0
     b29:	00 00                	add    %al,(%eax)
     b2b:	00 44 00 32          	add    %al,0x32(%eax,%eax,1)
     b2f:	00 1a                	add    %bl,(%edx)
     b31:	00 00                	add    %al,(%eax)
     b33:	00 00                	add    %al,(%eax)
     b35:	00 00                	add    %al,(%eax)
     b37:	00 44 00 33          	add    %al,0x33(%eax,%eax,1)
     b3b:	00 2a                	add    %ch,(%edx)
     b3d:	00 00                	add    %al,(%eax)
     b3f:	00 65 08             	add    %ah,0x8(%ebp)
     b42:	00 00                	add    %al,(%eax)
     b44:	80 00 00             	addb   $0x0,(%eax)
     b47:	00 d0                	add    %dl,%al
     b49:	ff                   	(bad)  
     b4a:	ff                   	(bad)  
     b4b:	ff 00                	incl   (%eax)
     b4d:	00 00                	add    %al,(%eax)
     b4f:	00 c0                	add    %al,%al
	...
     b59:	00 00                	add    %al,(%eax)
     b5b:	00 e0                	add    %ah,%al
     b5d:	00 00                	add    %al,(%eax)
     b5f:	00 31                	add    %dh,(%ecx)
     b61:	00 00                	add    %al,(%eax)
     b63:	00 a1 08 00 00 24    	add    %ah,0x24000008(%ecx)
     b69:	00 00                	add    %al,(%eax)
     b6b:	00 b9 02 28 00 b2    	add    %bh,-0x4dffd7fe(%ecx)
     b71:	08 00                	or     %al,(%eax)
     b73:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
     b79:	00 00                	add    %al,(%eax)
     b7b:	00 be 08 00 00 a0    	add    %bh,-0x5ffffff8(%esi)
     b81:	00 00                	add    %al,(%eax)
     b83:	00 0c 00             	add    %cl,(%eax,%eax,1)
     b86:	00 00                	add    %al,(%eax)
     b88:	c9                   	leave  
     b89:	07                   	pop    %es
     b8a:	00 00                	add    %al,(%eax)
     b8c:	a0 00 00 00 10       	mov    0x10000000,%al
     b91:	00 00                	add    %al,(%eax)
     b93:	00 cb                	add    %cl,%bl
     b95:	08 00                	or     %al,(%eax)
     b97:	00 a0 00 00 00 14    	add    %ah,0x14000000(%eax)
     b9d:	00 00                	add    %al,(%eax)
     b9f:	00 d5                	add    %dl,%ch
     ba1:	08 00                	or     %al,(%eax)
     ba3:	00 a0 00 00 00 18    	add    %ah,0x18000000(%eax)
     ba9:	00 00                	add    %al,(%eax)
     bab:	00 df                	add    %bl,%bh
     bad:	08 00                	or     %al,(%eax)
     baf:	00 a0 00 00 00 1c    	add    %ah,0x1c000000(%eax)
     bb5:	00 00                	add    %al,(%eax)
     bb7:	00 e9                	add    %ch,%cl
     bb9:	08 00                	or     %al,(%eax)
     bbb:	00 a0 00 00 00 20    	add    %ah,0x20000000(%eax)
     bc1:	00 00                	add    %al,(%eax)
     bc3:	00 00                	add    %al,(%eax)
     bc5:	00 00                	add    %al,(%eax)
     bc7:	00 44 00 4e          	add    %al,0x4e(%eax,%eax,1)
	...
     bd3:	00 44 00 4e          	add    %al,0x4e(%eax,%eax,1)
     bd7:	00 0a                	add    %cl,(%edx)
     bd9:	00 00                	add    %al,(%eax)
     bdb:	00 00                	add    %al,(%eax)
     bdd:	00 00                	add    %al,(%eax)
     bdf:	00 44 00 50          	add    %al,0x50(%eax,%eax,1)
     be3:	00 13                	add    %dl,(%ebx)
     be5:	00 00                	add    %al,(%eax)
     be7:	00 00                	add    %al,(%eax)
     be9:	00 00                	add    %al,(%eax)
     beb:	00 44 00 50          	add    %al,0x50(%eax,%eax,1)
     bef:	00 18                	add    %bl,(%eax)
     bf1:	00 00                	add    %al,(%eax)
     bf3:	00 00                	add    %al,(%eax)
     bf5:	00 00                	add    %al,(%eax)
     bf7:	00 44 00 52          	add    %al,0x52(%eax,%eax,1)
     bfb:	00 1b                	add    %bl,(%ebx)
     bfd:	00 00                	add    %al,(%eax)
     bff:	00 00                	add    %al,(%eax)
     c01:	00 00                	add    %al,(%eax)
     c03:	00 44 00 54          	add    %al,0x54(%eax,%eax,1)
     c07:	00 20                	add    %ah,(%eax)
     c09:	00 00                	add    %al,(%eax)
     c0b:	00 00                	add    %al,(%eax)
     c0d:	00 00                	add    %al,(%eax)
     c0f:	00 44 00 52          	add    %al,0x52(%eax,%eax,1)
     c13:	00 23                	add    %ah,(%ebx)
     c15:	00 00                	add    %al,(%eax)
     c17:	00 00                	add    %al,(%eax)
     c19:	00 00                	add    %al,(%eax)
     c1b:	00 44 00 50          	add    %al,0x50(%eax,%eax,1)
     c1f:	00 26                	add    %ah,(%esi)
     c21:	00 00                	add    %al,(%eax)
     c23:	00 00                	add    %al,(%eax)
     c25:	00 00                	add    %al,(%eax)
     c27:	00 44 00 58          	add    %al,0x58(%eax,%eax,1)
     c2b:	00 2c 00             	add    %ch,(%eax,%eax,1)
     c2e:	00 00                	add    %al,(%eax)
     c30:	f3 08 00             	repz or %al,(%eax)
     c33:	00 40 00             	add    %al,0x0(%eax)
     c36:	00 00                	add    %al,(%eax)
     c38:	03 00                	add    (%eax),%eax
     c3a:	00 00                	add    %al,(%eax)
     c3c:	01 09                	add    %ecx,(%ecx)
     c3e:	00 00                	add    %al,(%eax)
     c40:	40                   	inc    %eax
     c41:	00 00                	add    %al,(%eax)
     c43:	00 01                	add    %al,(%ecx)
     c45:	00 00                	add    %al,(%eax)
     c47:	00 0b                	add    %cl,(%ebx)
     c49:	09 00                	or     %eax,(%eax)
     c4b:	00 24 00             	add    %ah,(%eax,%eax,1)
     c4e:	00 00                	add    %al,(%eax)
     c50:	e8 02 28 00 c9       	call   c9003457 <mousefifo+0xc8d8087b>
     c55:	07                   	pop    %es
     c56:	00 00                	add    %al,(%eax)
     c58:	a0 00 00 00 08       	mov    0x8000000,%al
     c5d:	00 00                	add    %al,(%eax)
     c5f:	00 cb                	add    %cl,%bl
     c61:	08 00                	or     %al,(%eax)
     c63:	00 a0 00 00 00 0c    	add    %ah,0xc000000(%eax)
     c69:	00 00                	add    %al,(%eax)
     c6b:	00 d5                	add    %dl,%ch
     c6d:	08 00                	or     %al,(%eax)
     c6f:	00 a0 00 00 00 10    	add    %ah,0x10000000(%eax)
     c75:	00 00                	add    %al,(%eax)
     c77:	00 df                	add    %bl,%bh
     c79:	08 00                	or     %al,(%eax)
     c7b:	00 a0 00 00 00 14    	add    %ah,0x14000000(%eax)
     c81:	00 00                	add    %al,(%eax)
     c83:	00 e9                	add    %ch,%cl
     c85:	08 00                	or     %al,(%eax)
     c87:	00 a0 00 00 00 18    	add    %ah,0x18000000(%eax)
     c8d:	00 00                	add    %al,(%eax)
     c8f:	00 00                	add    %al,(%eax)
     c91:	00 00                	add    %al,(%eax)
     c93:	00 44 00 5a          	add    %al,0x5a(%eax,%eax,1)
	...
     c9f:	00 44 00 5b          	add    %al,0x5b(%eax,%eax,1)
     ca3:	00 03                	add    %al,(%ebx)
     ca5:	00 00                	add    %al,(%eax)
     ca7:	00 00                	add    %al,(%eax)
     ca9:	00 00                	add    %al,(%eax)
     cab:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
     caf:	00 26                	add    %ah,(%esi)
     cb1:	00 00                	add    %al,(%eax)
     cb3:	00 1b                	add    %bl,(%ebx)
     cb5:	09 00                	or     %eax,(%eax)
     cb7:	00 24 00             	add    %ah,(%eax,%eax,1)
     cba:	00 00                	add    %al,(%eax)
     cbc:	10 03                	adc    %al,(%ebx)
     cbe:	28 00                	sub    %al,(%eax)
     cc0:	00 00                	add    %al,(%eax)
     cc2:	00 00                	add    %al,(%eax)
     cc4:	44                   	inc    %esp
     cc5:	00 5f 00             	add    %bl,0x0(%edi)
	...
     cd0:	44                   	inc    %esp
     cd1:	00 66 00             	add    %ah,0x0(%esi)
     cd4:	03 00                	add    (%eax),%eax
     cd6:	00 00                	add    %al,(%eax)
     cd8:	00 00                	add    %al,(%eax)
     cda:	00 00                	add    %al,(%eax)
     cdc:	44                   	inc    %esp
     cdd:	00 68 00             	add    %ch,0x0(%eax)
     ce0:	18 00                	sbb    %al,(%eax)
     ce2:	00 00                	add    %al,(%eax)
     ce4:	00 00                	add    %al,(%eax)
     ce6:	00 00                	add    %al,(%eax)
     ce8:	44                   	inc    %esp
     ce9:	00 69 00             	add    %ch,0x0(%ecx)
     cec:	30 00                	xor    %al,(%eax)
     cee:	00 00                	add    %al,(%eax)
     cf0:	00 00                	add    %al,(%eax)
     cf2:	00 00                	add    %al,(%eax)
     cf4:	44                   	inc    %esp
     cf5:	00 6a 00             	add    %ch,0x0(%edx)
     cf8:	4b                   	dec    %ebx
     cf9:	00 00                	add    %al,(%eax)
     cfb:	00 00                	add    %al,(%eax)
     cfd:	00 00                	add    %al,(%eax)
     cff:	00 44 00 6e          	add    %al,0x6e(%eax,%eax,1)
     d03:	00 63 00             	add    %ah,0x0(%ebx)
     d06:	00 00                	add    %al,(%eax)
     d08:	00 00                	add    %al,(%eax)
     d0a:	00 00                	add    %al,(%eax)
     d0c:	44                   	inc    %esp
     d0d:	00 6f 00             	add    %ch,0x0(%edi)
     d10:	7b 00                	jnp    d12 <wait_KBC_sendready-0x27f2ee>
     d12:	00 00                	add    %al,(%eax)
     d14:	00 00                	add    %al,(%eax)
     d16:	00 00                	add    %al,(%eax)
     d18:	44                   	inc    %esp
     d19:	00 70 00             	add    %dh,0x0(%eax)
     d1c:	90                   	nop
     d1d:	00 00                	add    %al,(%eax)
     d1f:	00 00                	add    %al,(%eax)
     d21:	00 00                	add    %al,(%eax)
     d23:	00 44 00 71          	add    %al,0x71(%eax,%eax,1)
     d27:	00 a8 00 00 00 00    	add    %ch,0x0(%eax)
     d2d:	00 00                	add    %al,(%eax)
     d2f:	00 44 00 72          	add    %al,0x72(%eax,%eax,1)
     d33:	00 bd 00 00 00 00    	add    %bh,0x0(%ebp)
     d39:	00 00                	add    %al,(%eax)
     d3b:	00 44 00 73          	add    %al,0x73(%eax,%eax,1)
     d3f:	00 d5                	add    %dl,%ch
     d41:	00 00                	add    %al,(%eax)
     d43:	00 00                	add    %al,(%eax)
     d45:	00 00                	add    %al,(%eax)
     d47:	00 44 00 77          	add    %al,0x77(%eax,%eax,1)
     d4b:	00 ea                	add    %ch,%dl
     d4d:	00 00                	add    %al,(%eax)
     d4f:	00 00                	add    %al,(%eax)
     d51:	00 00                	add    %al,(%eax)
     d53:	00 44 00 78          	add    %al,0x78(%eax,%eax,1)
     d57:	00 08                	add    %cl,(%eax)
     d59:	01 00                	add    %eax,(%eax)
     d5b:	00 00                	add    %al,(%eax)
     d5d:	00 00                	add    %al,(%eax)
     d5f:	00 44 00 79          	add    %al,0x79(%eax,%eax,1)
     d63:	00 23                	add    %ah,(%ebx)
     d65:	01 00                	add    %eax,(%eax)
     d67:	00 00                	add    %al,(%eax)
     d69:	00 00                	add    %al,(%eax)
     d6b:	00 44 00 7a          	add    %al,0x7a(%eax,%eax,1)
     d6f:	00 41 01             	add    %al,0x1(%ecx)
     d72:	00 00                	add    %al,(%eax)
     d74:	00 00                	add    %al,(%eax)
     d76:	00 00                	add    %al,(%eax)
     d78:	44                   	inc    %esp
     d79:	00 7b 00             	add    %bh,0x0(%ebx)
     d7c:	5f                   	pop    %edi
     d7d:	01 00                	add    %eax,(%eax)
     d7f:	00 2f                	add    %ch,(%edi)
     d81:	09 00                	or     %eax,(%eax)
     d83:	00 24 00             	add    %ah,(%eax,%eax,1)
     d86:	00 00                	add    %al,(%eax)
     d88:	71 04                	jno    d8e <wait_KBC_sendready-0x27f272>
     d8a:	28 00                	sub    %al,(%eax)
     d8c:	43                   	inc    %ebx
     d8d:	09 00                	or     %eax,(%eax)
     d8f:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
     d95:	00 00                	add    %al,(%eax)
     d97:	00 00                	add    %al,(%eax)
     d99:	00 00                	add    %al,(%eax)
     d9b:	00 44 00 7f          	add    %al,0x7f(%eax,%eax,1)
	...
     da7:	00 44 00 7f          	add    %al,0x7f(%eax,%eax,1)
     dab:	00 03                	add    %al,(%ebx)
     dad:	00 00                	add    %al,(%eax)
     daf:	00 00                	add    %al,(%eax)
     db1:	00 00                	add    %al,(%eax)
     db3:	00 44 00 80          	add    %al,-0x80(%eax,%eax,1)
     db7:	00 06                	add    %al,(%esi)
     db9:	00 00                	add    %al,(%eax)
     dbb:	00 00                	add    %al,(%eax)
     dbd:	00 00                	add    %al,(%eax)
     dbf:	00 44 00 81          	add    %al,-0x7f(%eax,%eax,1)
     dc3:	00 0d 00 00 00 00    	add    %cl,0x0
     dc9:	00 00                	add    %al,(%eax)
     dcb:	00 44 00 82          	add    %al,-0x7e(%eax,%eax,1)
     dcf:	00 11                	add    %dl,(%ecx)
     dd1:	00 00                	add    %al,(%eax)
     dd3:	00 00                	add    %al,(%eax)
     dd5:	00 00                	add    %al,(%eax)
     dd7:	00 44 00 83          	add    %al,-0x7d(%eax,%eax,1)
     ddb:	00 17                	add    %dl,(%edi)
     ddd:	00 00                	add    %al,(%eax)
     ddf:	00 00                	add    %al,(%eax)
     de1:	00 00                	add    %al,(%eax)
     de3:	00 44 00 85          	add    %al,-0x7b(%eax,%eax,1)
     de7:	00 1d 00 00 00 58    	add    %bl,0x58000000
     ded:	09 00                	or     %eax,(%eax)
     def:	00 40 00             	add    %al,0x0(%eax)
     df2:	00 00                	add    %al,(%eax)
     df4:	00 00                	add    %al,(%eax)
     df6:	00 00                	add    %al,(%eax)
     df8:	66 09 00             	or     %ax,(%eax)
     dfb:	00 24 00             	add    %ah,(%eax,%eax,1)
     dfe:	00 00                	add    %al,(%eax)
     e00:	90                   	nop
     e01:	04 28                	add    $0x28,%al
     e03:	00 79 09             	add    %bh,0x9(%ecx)
     e06:	00 00                	add    %al,(%eax)
     e08:	a0 00 00 00 08       	mov    0x8000000,%al
     e0d:	00 00                	add    %al,(%eax)
     e0f:	00 86 09 00 00 a0    	add    %al,-0x5ffffff7(%esi)
     e15:	00 00                	add    %al,(%eax)
     e17:	00 0c 00             	add    %cl,(%eax,%eax,1)
     e1a:	00 00                	add    %al,(%eax)
     e1c:	00 00                	add    %al,(%eax)
     e1e:	00 00                	add    %al,(%eax)
     e20:	44                   	inc    %esp
     e21:	00 89 00 00 00 00    	add    %cl,0x0(%ecx)
     e27:	00 00                	add    %al,(%eax)
     e29:	00 00                	add    %al,(%eax)
     e2b:	00 44 00 89          	add    %al,-0x77(%eax,%eax,1)
     e2f:	00 0d 00 00 00 00    	add    %cl,0x0
     e35:	00 00                	add    %al,(%eax)
     e37:	00 44 00 89          	add    %al,-0x77(%eax,%eax,1)
     e3b:	00 0f                	add    %cl,(%edi)
     e3d:	00 00                	add    %al,(%eax)
     e3f:	00 00                	add    %al,(%eax)
     e41:	00 00                	add    %al,(%eax)
     e43:	00 44 00 a5          	add    %al,-0x5b(%eax,%eax,1)
     e47:	00 11                	add    %dl,(%ecx)
     e49:	00 00                	add    %al,(%eax)
     e4b:	00 00                	add    %al,(%eax)
     e4d:	00 00                	add    %al,(%eax)
     e4f:	00 44 00 a8          	add    %al,-0x58(%eax,%eax,1)
     e53:	00 27                	add    %ah,(%edi)
     e55:	00 00                	add    %al,(%eax)
     e57:	00 00                	add    %al,(%eax)
     e59:	00 00                	add    %al,(%eax)
     e5b:	00 44 00 a7          	add    %al,-0x59(%eax,%eax,1)
     e5f:	00 2d 00 00 00 00    	add    %ch,0x0
     e65:	00 00                	add    %al,(%eax)
     e67:	00 44 00 a9          	add    %al,-0x57(%eax,%eax,1)
     e6b:	00 34 00             	add    %dh,(%eax,%eax,1)
     e6e:	00 00                	add    %al,(%eax)
     e70:	00 00                	add    %al,(%eax)
     e72:	00 00                	add    %al,(%eax)
     e74:	44                   	inc    %esp
     e75:	00 a3 00 38 00 00    	add    %ah,0x3800(%ebx)
     e7b:	00 00                	add    %al,(%eax)
     e7d:	00 00                	add    %al,(%eax)
     e7f:	00 44 00 a1          	add    %al,-0x5f(%eax,%eax,1)
     e83:	00 44 00 00          	add    %al,0x0(%eax,%eax,1)
     e87:	00 00                	add    %al,(%eax)
     e89:	00 00                	add    %al,(%eax)
     e8b:	00 44 00 b1          	add    %al,-0x4f(%eax,%eax,1)
     e8f:	00 4c 00 00          	add    %cl,0x0(%eax,%eax,1)
     e93:	00 90 09 00 00 26    	add    %dl,0x26000009(%eax)
     e99:	00 00                	add    %al,(%eax)
     e9b:	00 d8                	add    %bl,%al
     e9d:	25 28 00 c8 09       	and    $0x9c80028,%eax
     ea2:	00 00                	add    %al,(%eax)
     ea4:	40                   	inc    %eax
     ea5:	00 00                	add    %al,(%eax)
     ea7:	00 00                	add    %al,(%eax)
     ea9:	00 00                	add    %al,(%eax)
     eab:	00 d1                	add    %dl,%cl
     ead:	09 00                	or     %eax,(%eax)
     eaf:	00 40 00             	add    %al,0x0(%eax)
     eb2:	00 00                	add    %al,(%eax)
     eb4:	06                   	push   %es
     eb5:	00 00                	add    %al,(%eax)
     eb7:	00 00                	add    %al,(%eax)
     eb9:	00 00                	add    %al,(%eax)
     ebb:	00 c0                	add    %al,%al
	...
     ec5:	00 00                	add    %al,(%eax)
     ec7:	00 e0                	add    %ah,%al
     ec9:	00 00                	add    %al,(%eax)
     ecb:	00 50 00             	add    %dl,0x0(%eax)
     ece:	00 00                	add    %al,(%eax)
     ed0:	db 09                	fisttpl (%ecx)
     ed2:	00 00                	add    %al,(%eax)
     ed4:	24 00                	and    $0x0,%al
     ed6:	00 00                	add    %al,(%eax)
     ed8:	e0 04                	loopne ede <wait_KBC_sendready-0x27f122>
     eda:	28 00                	sub    %al,(%eax)
     edc:	f1                   	icebp  
     edd:	09 00                	or     %eax,(%eax)
     edf:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
     ee5:	00 00                	add    %al,(%eax)
     ee7:	00 be 08 00 00 a0    	add    %bh,-0x5ffffff8(%esi)
     eed:	00 00                	add    %al,(%eax)
     eef:	00 0c 00             	add    %cl,(%eax,%eax,1)
     ef2:	00 00                	add    %al,(%eax)
     ef4:	fd                   	std    
     ef5:	09 00                	or     %eax,(%eax)
     ef7:	00 a0 00 00 00 10    	add    %ah,0x10000000(%eax)
     efd:	00 00                	add    %al,(%eax)
     eff:	00 0b                	add    %cl,(%ebx)
     f01:	0a 00                	or     (%eax),%al
     f03:	00 a0 00 00 00 14    	add    %ah,0x14000000(%eax)
     f09:	00 00                	add    %al,(%eax)
     f0b:	00 19                	add    %bl,(%ecx)
     f0d:	0a 00                	or     (%eax),%al
     f0f:	00 a0 00 00 00 18    	add    %ah,0x18000000(%eax)
     f15:	00 00                	add    %al,(%eax)
     f17:	00 24 0a             	add    %ah,(%edx,%ecx,1)
     f1a:	00 00                	add    %al,(%eax)
     f1c:	a0 00 00 00 1c       	mov    0x1c000000,%al
     f21:	00 00                	add    %al,(%eax)
     f23:	00 2f                	add    %ch,(%edi)
     f25:	0a 00                	or     (%eax),%al
     f27:	00 a0 00 00 00 20    	add    %ah,0x20000000(%eax)
     f2d:	00 00                	add    %al,(%eax)
     f2f:	00 3a                	add    %bh,(%edx)
     f31:	0a 00                	or     (%eax),%al
     f33:	00 a0 00 00 00 24    	add    %ah,0x24000000(%eax)
     f39:	00 00                	add    %al,(%eax)
     f3b:	00 00                	add    %al,(%eax)
     f3d:	00 00                	add    %al,(%eax)
     f3f:	00 44 00 b4          	add    %al,-0x4c(%eax,%eax,1)
	...
     f4b:	00 44 00 b6          	add    %al,-0x4a(%eax,%eax,1)
     f4f:	00 07                	add    %al,(%edi)
     f51:	00 00                	add    %al,(%eax)
     f53:	00 00                	add    %al,(%eax)
     f55:	00 00                	add    %al,(%eax)
     f57:	00 44 00 b4          	add    %al,-0x4c(%eax,%eax,1)
     f5b:	00 09                	add    %cl,(%ecx)
     f5d:	00 00                	add    %al,(%eax)
     f5f:	00 00                	add    %al,(%eax)
     f61:	00 00                	add    %al,(%eax)
     f63:	00 44 00 b6          	add    %al,-0x4a(%eax,%eax,1)
     f67:	00 17                	add    %dl,(%edi)
     f69:	00 00                	add    %al,(%eax)
     f6b:	00 00                	add    %al,(%eax)
     f6d:	00 00                	add    %al,(%eax)
     f6f:	00 44 00 b6          	add    %al,-0x4a(%eax,%eax,1)
     f73:	00 1c 00             	add    %bl,(%eax,%eax,1)
     f76:	00 00                	add    %al,(%eax)
     f78:	00 00                	add    %al,(%eax)
     f7a:	00 00                	add    %al,(%eax)
     f7c:	44                   	inc    %esp
     f7d:	00 b8 00 1e 00 00    	add    %bh,0x1e00(%eax)
     f83:	00 00                	add    %al,(%eax)
     f85:	00 00                	add    %al,(%eax)
     f87:	00 44 00 ba          	add    %al,-0x46(%eax,%eax,1)
     f8b:	00 23                	add    %ah,(%ebx)
     f8d:	00 00                	add    %al,(%eax)
     f8f:	00 00                	add    %al,(%eax)
     f91:	00 00                	add    %al,(%eax)
     f93:	00 44 00 b8          	add    %al,-0x48(%eax,%eax,1)
     f97:	00 29                	add    %ch,(%ecx)
     f99:	00 00                	add    %al,(%eax)
     f9b:	00 00                	add    %al,(%eax)
     f9d:	00 00                	add    %al,(%eax)
     f9f:	00 44 00 b6          	add    %al,-0x4a(%eax,%eax,1)
     fa3:	00 2c 00             	add    %ch,(%eax,%eax,1)
     fa6:	00 00                	add    %al,(%eax)
     fa8:	00 00                	add    %al,(%eax)
     faa:	00 00                	add    %al,(%eax)
     fac:	44                   	inc    %esp
     fad:	00 be 00 35 00 00    	add    %bh,0x3500(%esi)
     fb3:	00 c8                	add    %cl,%al
     fb5:	09 00                	or     %eax,(%eax)
     fb7:	00 40 00             	add    %al,0x0(%eax)
     fba:	00 00                	add    %al,(%eax)
     fbc:	02 00                	add    (%eax),%al
     fbe:	00 00                	add    %al,(%eax)
     fc0:	48                   	dec    %eax
     fc1:	0a 00                	or     (%eax),%al
     fc3:	00 40 00             	add    %al,0x0(%eax)
     fc6:	00 00                	add    %al,(%eax)
     fc8:	06                   	push   %es
     fc9:	00 00                	add    %al,(%eax)
     fcb:	00 00                	add    %al,(%eax)
     fcd:	00 00                	add    %al,(%eax)
     fcf:	00 c0                	add    %al,%al
	...
     fd9:	00 00                	add    %al,(%eax)
     fdb:	00 e0                	add    %ah,%al
     fdd:	00 00                	add    %al,(%eax)
     fdf:	00 39                	add    %bh,(%ecx)
     fe1:	00 00                	add    %al,(%eax)
     fe3:	00 00                	add    %al,(%eax)
     fe5:	00 00                	add    %al,(%eax)
     fe7:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
     feb:	00 19                	add    %bl,(%ecx)
     fed:	05 28 00 51 0a       	add    $0xa510028,%eax
     ff2:	00 00                	add    %al,(%eax)
     ff4:	64 00 02             	add    %al,%fs:(%edx)
     ff7:	00 1c 05 28 00 08 00 	add    %bl,0x80028(,%eax,1)
     ffe:	00 00                	add    %al,(%eax)
    1000:	3c 00                	cmp    $0x0,%al
    1002:	00 00                	add    %al,(%eax)
    1004:	00 00                	add    %al,(%eax)
    1006:	00 00                	add    %al,(%eax)
    1008:	17                   	pop    %ss
    1009:	00 00                	add    %al,(%eax)
    100b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1011:	00 00                	add    %al,(%eax)
    1013:	00 41 00             	add    %al,0x0(%ecx)
    1016:	00 00                	add    %al,(%eax)
    1018:	80 00 00             	addb   $0x0,(%eax)
    101b:	00 00                	add    %al,(%eax)
    101d:	00 00                	add    %al,(%eax)
    101f:	00 5b 00             	add    %bl,0x0(%ebx)
    1022:	00 00                	add    %al,(%eax)
    1024:	80 00 00             	addb   $0x0,(%eax)
    1027:	00 00                	add    %al,(%eax)
    1029:	00 00                	add    %al,(%eax)
    102b:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
    1031:	00 00                	add    %al,(%eax)
    1033:	00 00                	add    %al,(%eax)
    1035:	00 00                	add    %al,(%eax)
    1037:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
    103d:	00 00                	add    %al,(%eax)
    103f:	00 00                	add    %al,(%eax)
    1041:	00 00                	add    %al,(%eax)
    1043:	00 e1                	add    %ah,%cl
    1045:	00 00                	add    %al,(%eax)
    1047:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    104d:	00 00                	add    %al,(%eax)
    104f:	00 0c 01             	add    %cl,(%ecx,%eax,1)
    1052:	00 00                	add    %al,(%eax)
    1054:	80 00 00             	addb   $0x0,(%eax)
    1057:	00 00                	add    %al,(%eax)
    1059:	00 00                	add    %al,(%eax)
    105b:	00 37                	add    %dh,(%edi)
    105d:	01 00                	add    %eax,(%eax)
    105f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1065:	00 00                	add    %al,(%eax)
    1067:	00 5d 01             	add    %bl,0x1(%ebp)
    106a:	00 00                	add    %al,(%eax)
    106c:	80 00 00             	addb   $0x0,(%eax)
    106f:	00 00                	add    %al,(%eax)
    1071:	00 00                	add    %al,(%eax)
    1073:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
    1079:	00 00                	add    %al,(%eax)
    107b:	00 00                	add    %al,(%eax)
    107d:	00 00                	add    %al,(%eax)
    107f:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
    1085:	00 00                	add    %al,(%eax)
    1087:	00 00                	add    %al,(%eax)
    1089:	00 00                	add    %al,(%eax)
    108b:	00 d2                	add    %dl,%dl
    108d:	01 00                	add    %eax,(%eax)
    108f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1095:	00 00                	add    %al,(%eax)
    1097:	00 ec                	add    %ch,%ah
    1099:	01 00                	add    %eax,(%eax)
    109b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    10a1:	00 00                	add    %al,(%eax)
    10a3:	00 07                	add    %al,(%edi)
    10a5:	02 00                	add    (%eax),%al
    10a7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    10ad:	00 00                	add    %al,(%eax)
    10af:	00 28                	add    %ch,(%eax)
    10b1:	02 00                	add    (%eax),%al
    10b3:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    10b9:	00 00                	add    %al,(%eax)
    10bb:	00 47 02             	add    %al,0x2(%edi)
    10be:	00 00                	add    %al,(%eax)
    10c0:	80 00 00             	addb   $0x0,(%eax)
    10c3:	00 00                	add    %al,(%eax)
    10c5:	00 00                	add    %al,(%eax)
    10c7:	00 66 02             	add    %ah,0x2(%esi)
    10ca:	00 00                	add    %al,(%eax)
    10cc:	80 00 00             	addb   $0x0,(%eax)
    10cf:	00 00                	add    %al,(%eax)
    10d1:	00 00                	add    %al,(%eax)
    10d3:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
    10d9:	00 00                	add    %al,(%eax)
    10db:	00 00                	add    %al,(%eax)
    10dd:	00 00                	add    %al,(%eax)
    10df:	00 9b 02 00 00 c2    	add    %bl,-0x3dfffffe(%ebx)
    10e5:	00 00                	add    %al,(%eax)
    10e7:	00 d4                	add    %dl,%ah
    10e9:	8c 00                	mov    %es,(%eax)
    10eb:	00 a4 02 00 00 c2 00 	add    %ah,0xc20000(%edx,%eax,1)
    10f2:	00 00                	add    %al,(%eax)
    10f4:	00 00                	add    %al,(%eax)
    10f6:	00 00                	add    %al,(%eax)
    10f8:	aa                   	stos   %al,%es:(%edi)
    10f9:	02 00                	add    (%eax),%al
    10fb:	00 c2                	add    %al,%dl
    10fd:	00 00                	add    %al,(%eax)
    10ff:	00 37                	add    %dh,(%edi)
    1101:	53                   	push   %ebx
    1102:	00 00                	add    %al,(%eax)
    1104:	00 00                	add    %al,(%eax)
    1106:	00 00                	add    %al,(%eax)
    1108:	64 00 00             	add    %al,%fs:(%eax)
    110b:	00 1c 05 28 00 58 0a 	add    %bl,0xa580028(,%eax,1)
    1112:	00 00                	add    %al,(%eax)
    1114:	64 00 02             	add    %al,%fs:(%edx)
    1117:	00 1c 05 28 00 08 00 	add    %bl,0x80028(,%eax,1)
    111e:	00 00                	add    %al,(%eax)
    1120:	3c 00                	cmp    $0x0,%al
    1122:	00 00                	add    %al,(%eax)
    1124:	00 00                	add    %al,(%eax)
    1126:	00 00                	add    %al,(%eax)
    1128:	17                   	pop    %ss
    1129:	00 00                	add    %al,(%eax)
    112b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1131:	00 00                	add    %al,(%eax)
    1133:	00 41 00             	add    %al,0x0(%ecx)
    1136:	00 00                	add    %al,(%eax)
    1138:	80 00 00             	addb   $0x0,(%eax)
    113b:	00 00                	add    %al,(%eax)
    113d:	00 00                	add    %al,(%eax)
    113f:	00 5b 00             	add    %bl,0x0(%ebx)
    1142:	00 00                	add    %al,(%eax)
    1144:	80 00 00             	addb   $0x0,(%eax)
    1147:	00 00                	add    %al,(%eax)
    1149:	00 00                	add    %al,(%eax)
    114b:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
    1151:	00 00                	add    %al,(%eax)
    1153:	00 00                	add    %al,(%eax)
    1155:	00 00                	add    %al,(%eax)
    1157:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
    115d:	00 00                	add    %al,(%eax)
    115f:	00 00                	add    %al,(%eax)
    1161:	00 00                	add    %al,(%eax)
    1163:	00 e1                	add    %ah,%cl
    1165:	00 00                	add    %al,(%eax)
    1167:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    116d:	00 00                	add    %al,(%eax)
    116f:	00 0c 01             	add    %cl,(%ecx,%eax,1)
    1172:	00 00                	add    %al,(%eax)
    1174:	80 00 00             	addb   $0x0,(%eax)
    1177:	00 00                	add    %al,(%eax)
    1179:	00 00                	add    %al,(%eax)
    117b:	00 37                	add    %dh,(%edi)
    117d:	01 00                	add    %eax,(%eax)
    117f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1185:	00 00                	add    %al,(%eax)
    1187:	00 5d 01             	add    %bl,0x1(%ebp)
    118a:	00 00                	add    %al,(%eax)
    118c:	80 00 00             	addb   $0x0,(%eax)
    118f:	00 00                	add    %al,(%eax)
    1191:	00 00                	add    %al,(%eax)
    1193:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
    1199:	00 00                	add    %al,(%eax)
    119b:	00 00                	add    %al,(%eax)
    119d:	00 00                	add    %al,(%eax)
    119f:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
    11a5:	00 00                	add    %al,(%eax)
    11a7:	00 00                	add    %al,(%eax)
    11a9:	00 00                	add    %al,(%eax)
    11ab:	00 d2                	add    %dl,%dl
    11ad:	01 00                	add    %eax,(%eax)
    11af:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    11b5:	00 00                	add    %al,(%eax)
    11b7:	00 ec                	add    %ch,%ah
    11b9:	01 00                	add    %eax,(%eax)
    11bb:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    11c1:	00 00                	add    %al,(%eax)
    11c3:	00 07                	add    %al,(%edi)
    11c5:	02 00                	add    (%eax),%al
    11c7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    11cd:	00 00                	add    %al,(%eax)
    11cf:	00 28                	add    %ch,(%eax)
    11d1:	02 00                	add    (%eax),%al
    11d3:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    11d9:	00 00                	add    %al,(%eax)
    11db:	00 47 02             	add    %al,0x2(%edi)
    11de:	00 00                	add    %al,(%eax)
    11e0:	80 00 00             	addb   $0x0,(%eax)
    11e3:	00 00                	add    %al,(%eax)
    11e5:	00 00                	add    %al,(%eax)
    11e7:	00 66 02             	add    %ah,0x2(%esi)
    11ea:	00 00                	add    %al,(%eax)
    11ec:	80 00 00             	addb   $0x0,(%eax)
    11ef:	00 00                	add    %al,(%eax)
    11f1:	00 00                	add    %al,(%eax)
    11f3:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
    11f9:	00 00                	add    %al,(%eax)
    11fb:	00 00                	add    %al,(%eax)
    11fd:	00 00                	add    %al,(%eax)
    11ff:	00 9b 02 00 00 c2    	add    %bl,-0x3dfffffe(%ebx)
    1205:	00 00                	add    %al,(%eax)
    1207:	00 d4                	add    %dl,%ah
    1209:	8c 00                	mov    %es,(%eax)
    120b:	00 a4 02 00 00 c2 00 	add    %ah,0xc20000(%edx,%eax,1)
    1212:	00 00                	add    %al,(%eax)
    1214:	00 00                	add    %al,(%eax)
    1216:	00 00                	add    %al,(%eax)
    1218:	aa                   	stos   %al,%es:(%edi)
    1219:	02 00                	add    (%eax),%al
    121b:	00 c2                	add    %al,%dl
    121d:	00 00                	add    %al,(%eax)
    121f:	00 37                	add    %dh,(%edi)
    1221:	53                   	push   %ebx
    1222:	00 00                	add    %al,(%eax)
    1224:	60                   	pusha  
    1225:	0a 00                	or     (%eax),%al
    1227:	00 24 00             	add    %ah,(%eax,%eax,1)
    122a:	00 00                	add    %al,(%eax)
    122c:	1c 05                	sbb    $0x5,%al
    122e:	28 00                	sub    %al,(%eax)
    1230:	6d                   	insl   (%dx),%es:(%edi)
    1231:	0a 00                	or     (%eax),%al
    1233:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    1239:	00 00                	add    %al,(%eax)
    123b:	00 2f                	add    %ch,(%edi)
    123d:	0a 00                	or     (%eax),%al
    123f:	00 a0 00 00 00 0c    	add    %ah,0xc000000(%eax)
    1245:	00 00                	add    %al,(%eax)
    1247:	00 00                	add    %al,(%eax)
    1249:	00 00                	add    %al,(%eax)
    124b:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
	...
    1257:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    125b:	00 01                	add    %al,(%ecx)
    125d:	00 00                	add    %al,(%eax)
    125f:	00 00                	add    %al,(%eax)
    1261:	00 00                	add    %al,(%eax)
    1263:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
    1267:	00 03                	add    %al,(%ebx)
    1269:	00 00                	add    %al,(%eax)
    126b:	00 00                	add    %al,(%eax)
    126d:	00 00                	add    %al,(%eax)
    126f:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    1273:	00 05 00 00 00 00    	add    %al,0x0
    1279:	00 00                	add    %al,(%eax)
    127b:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
    127f:	00 0a                	add    %cl,(%edx)
    1281:	00 00                	add    %al,(%eax)
    1283:	00 00                	add    %al,(%eax)
    1285:	00 00                	add    %al,(%eax)
    1287:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
    128b:	00 10                	add    %dl,(%eax)
    128d:	00 00                	add    %al,(%eax)
    128f:	00 00                	add    %al,(%eax)
    1291:	00 00                	add    %al,(%eax)
    1293:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    1297:	00 13                	add    %dl,(%ebx)
    1299:	00 00                	add    %al,(%eax)
    129b:	00 00                	add    %al,(%eax)
    129d:	00 00                	add    %al,(%eax)
    129f:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
    12a3:	00 16                	add    %dl,(%esi)
    12a5:	00 00                	add    %al,(%eax)
    12a7:	00 00                	add    %al,(%eax)
    12a9:	00 00                	add    %al,(%eax)
    12ab:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    12af:	00 19                	add    %bl,(%ecx)
    12b1:	00 00                	add    %al,(%eax)
    12b3:	00 00                	add    %al,(%eax)
    12b5:	00 00                	add    %al,(%eax)
    12b7:	00 44 00 0f          	add    %al,0xf(%eax,%eax,1)
    12bb:	00 1e                	add    %bl,(%esi)
    12bd:	00 00                	add    %al,(%eax)
    12bf:	00 00                	add    %al,(%eax)
    12c1:	00 00                	add    %al,(%eax)
    12c3:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
    12c7:	00 22                	add    %ah,(%edx)
    12c9:	00 00                	add    %al,(%eax)
    12cb:	00 00                	add    %al,(%eax)
    12cd:	00 00                	add    %al,(%eax)
    12cf:	00 44 00 12          	add    %al,0x12(%eax,%eax,1)
    12d3:	00 25 00 00 00 00    	add    %ah,0x0
    12d9:	00 00                	add    %al,(%eax)
    12db:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
    12df:	00 27                	add    %ah,(%edi)
    12e1:	00 00                	add    %al,(%eax)
    12e3:	00 00                	add    %al,(%eax)
    12e5:	00 00                	add    %al,(%eax)
    12e7:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
    12eb:	00 28                	add    %ch,(%eax)
    12ed:	00 00                	add    %al,(%eax)
    12ef:	00 00                	add    %al,(%eax)
    12f1:	00 00                	add    %al,(%eax)
    12f3:	00 44 00 17          	add    %al,0x17(%eax,%eax,1)
    12f7:	00 2a                	add    %ch,(%edx)
    12f9:	00 00                	add    %al,(%eax)
    12fb:	00 00                	add    %al,(%eax)
    12fd:	00 00                	add    %al,(%eax)
    12ff:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    1303:	00 38                	add    %bh,(%eax)
    1305:	00 00                	add    %al,(%eax)
    1307:	00 00                	add    %al,(%eax)
    1309:	00 00                	add    %al,(%eax)
    130b:	00 44 00 17          	add    %al,0x17(%eax,%eax,1)
    130f:	00 3a                	add    %bh,(%edx)
    1311:	00 00                	add    %al,(%eax)
    1313:	00 00                	add    %al,(%eax)
    1315:	00 00                	add    %al,(%eax)
    1317:	00 44 00 18          	add    %al,0x18(%eax,%eax,1)
    131b:	00 3d 00 00 00 00    	add    %bh,0x0
    1321:	00 00                	add    %al,(%eax)
    1323:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    1327:	00 3f                	add    %bh,(%edi)
    1329:	00 00                	add    %al,(%eax)
    132b:	00 00                	add    %al,(%eax)
    132d:	00 00                	add    %al,(%eax)
    132f:	00 44 00 17          	add    %al,0x17(%eax,%eax,1)
    1333:	00 41 00             	add    %al,0x0(%ecx)
    1336:	00 00                	add    %al,(%eax)
    1338:	00 00                	add    %al,(%eax)
    133a:	00 00                	add    %al,(%eax)
    133c:	44                   	inc    %esp
    133d:	00 1c 00             	add    %bl,(%eax,%eax,1)
    1340:	45                   	inc    %ebp
    1341:	00 00                	add    %al,(%eax)
    1343:	00 00                	add    %al,(%eax)
    1345:	00 00                	add    %al,(%eax)
    1347:	00 44 00 1e          	add    %al,0x1e(%eax,%eax,1)
    134b:	00 49 00             	add    %cl,0x0(%ecx)
    134e:	00 00                	add    %al,(%eax)
    1350:	00 00                	add    %al,(%eax)
    1352:	00 00                	add    %al,(%eax)
    1354:	44                   	inc    %esp
    1355:	00 1f                	add    %bl,(%edi)
    1357:	00 4a 00             	add    %cl,0x0(%edx)
    135a:	00 00                	add    %al,(%eax)
    135c:	00 00                	add    %al,(%eax)
    135e:	00 00                	add    %al,(%eax)
    1360:	44                   	inc    %esp
    1361:	00 22                	add    %ah,(%edx)
    1363:	00 56 00             	add    %dl,0x0(%esi)
    1366:	00 00                	add    %al,(%eax)
    1368:	00 00                	add    %al,(%eax)
    136a:	00 00                	add    %al,(%eax)
    136c:	44                   	inc    %esp
    136d:	00 25 00 5a 00 00    	add    %ah,0x5a00
    1373:	00 7a 0a             	add    %bh,0xa(%edx)
    1376:	00 00                	add    %al,(%eax)
    1378:	80 00 00             	addb   $0x0,(%eax)
    137b:	00 f6                	add    %dh,%dh
    137d:	ff                   	(bad)  
    137e:	ff                   	(bad)  
    137f:	ff b2 0a 00 00 40    	pushl  0x4000000a(%edx)
    1385:	00 00                	add    %al,(%eax)
    1387:	00 02                	add    %al,(%edx)
    1389:	00 00                	add    %al,(%eax)
    138b:	00 bf 0a 00 00 40    	add    %bh,0x4000000a(%edi)
    1391:	00 00                	add    %al,(%eax)
    1393:	00 03                	add    %al,(%ebx)
    1395:	00 00                	add    %al,(%eax)
    1397:	00 00                	add    %al,(%eax)
    1399:	00 00                	add    %al,(%eax)
    139b:	00 c0                	add    %al,%al
	...
    13a5:	00 00                	add    %al,(%eax)
    13a7:	00 e0                	add    %ah,%al
    13a9:	00 00                	add    %al,(%eax)
    13ab:	00 62 00             	add    %ah,0x0(%edx)
    13ae:	00 00                	add    %al,(%eax)
    13b0:	ca 0a 00             	lret   $0xa
    13b3:	00 24 00             	add    %ah,(%eax,%eax,1)
    13b6:	00 00                	add    %al,(%eax)
    13b8:	7e 05                	jle    13bf <wait_KBC_sendready-0x27ec41>
    13ba:	28 00                	sub    %al,(%eax)
    13bc:	d7                   	xlat   %ds:(%ebx)
    13bd:	0a 00                	or     (%eax),%al
    13bf:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    13c5:	00 00                	add    %al,(%eax)
    13c7:	00 2f                	add    %ch,(%edi)
    13c9:	0a 00                	or     (%eax),%al
    13cb:	00 a0 00 00 00 0c    	add    %ah,0xc000000(%eax)
    13d1:	00 00                	add    %al,(%eax)
    13d3:	00 00                	add    %al,(%eax)
    13d5:	00 00                	add    %al,(%eax)
    13d7:	00 44 00 2e          	add    %al,0x2e(%eax,%eax,1)
	...
    13e3:	00 44 00 2f          	add    %al,0x2f(%eax,%eax,1)
    13e7:	00 01                	add    %al,(%ecx)
    13e9:	00 00                	add    %al,(%eax)
    13eb:	00 00                	add    %al,(%eax)
    13ed:	00 00                	add    %al,(%eax)
    13ef:	00 44 00 2e          	add    %al,0x2e(%eax,%eax,1)
    13f3:	00 03                	add    %al,(%ebx)
    13f5:	00 00                	add    %al,(%eax)
    13f7:	00 00                	add    %al,(%eax)
    13f9:	00 00                	add    %al,(%eax)
    13fb:	00 44 00 2f          	add    %al,0x2f(%eax,%eax,1)
    13ff:	00 05 00 00 00 00    	add    %al,0x0
    1405:	00 00                	add    %al,(%eax)
    1407:	00 44 00 2e          	add    %al,0x2e(%eax,%eax,1)
    140b:	00 0a                	add    %cl,(%edx)
    140d:	00 00                	add    %al,(%eax)
    140f:	00 00                	add    %al,(%eax)
    1411:	00 00                	add    %al,(%eax)
    1413:	00 44 00 2e          	add    %al,0x2e(%eax,%eax,1)
    1417:	00 10                	add    %dl,(%eax)
    1419:	00 00                	add    %al,(%eax)
    141b:	00 00                	add    %al,(%eax)
    141d:	00 00                	add    %al,(%eax)
    141f:	00 44 00 2f          	add    %al,0x2f(%eax,%eax,1)
    1423:	00 13                	add    %dl,(%ebx)
    1425:	00 00                	add    %al,(%eax)
    1427:	00 00                	add    %al,(%eax)
    1429:	00 00                	add    %al,(%eax)
    142b:	00 44 00 30          	add    %al,0x30(%eax,%eax,1)
    142f:	00 18                	add    %bl,(%eax)
    1431:	00 00                	add    %al,(%eax)
    1433:	00 00                	add    %al,(%eax)
    1435:	00 00                	add    %al,(%eax)
    1437:	00 44 00 32          	add    %al,0x32(%eax,%eax,1)
    143b:	00 1b                	add    %bl,(%ebx)
    143d:	00 00                	add    %al,(%eax)
    143f:	00 00                	add    %al,(%eax)
    1441:	00 00                	add    %al,(%eax)
    1443:	00 44 00 33          	add    %al,0x33(%eax,%eax,1)
    1447:	00 1e                	add    %bl,(%esi)
    1449:	00 00                	add    %al,(%eax)
    144b:	00 00                	add    %al,(%eax)
    144d:	00 00                	add    %al,(%eax)
    144f:	00 44 00 38          	add    %al,0x38(%eax,%eax,1)
    1453:	00 25 00 00 00 00    	add    %ah,0x0
    1459:	00 00                	add    %al,(%eax)
    145b:	00 44 00 28          	add    %al,0x28(%eax,%eax,1)
    145f:	00 2c 00             	add    %ch,(%eax,%eax,1)
    1462:	00 00                	add    %al,(%eax)
    1464:	00 00                	add    %al,(%eax)
    1466:	00 00                	add    %al,(%eax)
    1468:	44                   	inc    %esp
    1469:	00 3c 00             	add    %bh,(%eax,%eax,1)
    146c:	38 00                	cmp    %al,(%eax)
    146e:	00 00                	add    %al,(%eax)
    1470:	00 00                	add    %al,(%eax)
    1472:	00 00                	add    %al,(%eax)
    1474:	44                   	inc    %esp
    1475:	00 2b                	add    %ch,(%ebx)
    1477:	00 3c 00             	add    %bh,(%eax,%eax,1)
    147a:	00 00                	add    %al,(%eax)
    147c:	00 00                	add    %al,(%eax)
    147e:	00 00                	add    %al,(%eax)
    1480:	44                   	inc    %esp
    1481:	00 3c 00             	add    %bh,(%eax,%eax,1)
    1484:	3f                   	aas    
    1485:	00 00                	add    %al,(%eax)
    1487:	00 00                	add    %al,(%eax)
    1489:	00 00                	add    %al,(%eax)
    148b:	00 44 00 38          	add    %al,0x38(%eax,%eax,1)
    148f:	00 41 00             	add    %al,0x0(%ecx)
    1492:	00 00                	add    %al,(%eax)
    1494:	00 00                	add    %al,(%eax)
    1496:	00 00                	add    %al,(%eax)
    1498:	44                   	inc    %esp
    1499:	00 3f                	add    %bh,(%edi)
    149b:	00 43 00             	add    %al,0x0(%ebx)
    149e:	00 00                	add    %al,(%eax)
    14a0:	00 00                	add    %al,(%eax)
    14a2:	00 00                	add    %al,(%eax)
    14a4:	44                   	inc    %esp
    14a5:	00 41 00             	add    %al,0x0(%ecx)
    14a8:	4a                   	dec    %edx
    14a9:	00 00                	add    %al,(%eax)
    14ab:	00 00                	add    %al,(%eax)
    14ad:	00 00                	add    %al,(%eax)
    14af:	00 44 00 42          	add    %al,0x42(%eax,%eax,1)
    14b3:	00 4b 00             	add    %cl,0x0(%ebx)
    14b6:	00 00                	add    %al,(%eax)
    14b8:	00 00                	add    %al,(%eax)
    14ba:	00 00                	add    %al,(%eax)
    14bc:	44                   	inc    %esp
    14bd:	00 45 00             	add    %al,0x0(%ebp)
    14c0:	55                   	push   %ebp
    14c1:	00 00                	add    %al,(%eax)
    14c3:	00 00                	add    %al,(%eax)
    14c5:	00 00                	add    %al,(%eax)
    14c7:	00 44 00 48          	add    %al,0x48(%eax,%eax,1)
    14cb:	00 5a 00             	add    %bl,0x0(%edx)
    14ce:	00 00                	add    %al,(%eax)
    14d0:	e4 0a                	in     $0xa,%al
    14d2:	00 00                	add    %al,(%eax)
    14d4:	80 00 00             	addb   $0x0,(%eax)
    14d7:	00 e2                	add    %ah,%dl
    14d9:	ff                   	(bad)  
    14da:	ff                   	(bad)  
    14db:	ff                   	(bad)  
    14dc:	bf 0a 00 00 40       	mov    $0x4000000a,%edi
    14e1:	00 00                	add    %al,(%eax)
    14e3:	00 02                	add    %al,(%edx)
    14e5:	00 00                	add    %al,(%eax)
    14e7:	00 00                	add    %al,(%eax)
    14e9:	00 00                	add    %al,(%eax)
    14eb:	00 c0                	add    %al,%al
    14ed:	00 00                	add    %al,(%eax)
    14ef:	00 00                	add    %al,(%eax)
    14f1:	00 00                	add    %al,(%eax)
    14f3:	00 b2 0a 00 00 40    	add    %dh,0x4000000a(%edx)
    14f9:	00 00                	add    %al,(%eax)
    14fb:	00 01                	add    %al,(%ecx)
    14fd:	00 00                	add    %al,(%eax)
    14ff:	00 00                	add    %al,(%eax)
    1501:	00 00                	add    %al,(%eax)
    1503:	00 c0                	add    %al,%al
    1505:	00 00                	add    %al,(%eax)
    1507:	00 2c 00             	add    %ch,(%eax,%eax,1)
    150a:	00 00                	add    %al,(%eax)
    150c:	00 00                	add    %al,(%eax)
    150e:	00 00                	add    %al,(%eax)
    1510:	e0 00                	loopne 1512 <wait_KBC_sendready-0x27eaee>
    1512:	00 00                	add    %al,(%eax)
    1514:	38 00                	cmp    %al,(%eax)
    1516:	00 00                	add    %al,(%eax)
    1518:	b2 0a                	mov    $0xa,%dl
    151a:	00 00                	add    %al,(%eax)
    151c:	40                   	inc    %eax
    151d:	00 00                	add    %al,(%eax)
    151f:	00 01                	add    %al,(%ecx)
    1521:	00 00                	add    %al,(%eax)
    1523:	00 00                	add    %al,(%eax)
    1525:	00 00                	add    %al,(%eax)
    1527:	00 c0                	add    %al,%al
    1529:	00 00                	add    %al,(%eax)
    152b:	00 3c 00             	add    %bh,(%eax,%eax,1)
    152e:	00 00                	add    %al,(%eax)
    1530:	00 00                	add    %al,(%eax)
    1532:	00 00                	add    %al,(%eax)
    1534:	e0 00                	loopne 1536 <wait_KBC_sendready-0x27eaca>
    1536:	00 00                	add    %al,(%eax)
    1538:	3f                   	aas    
    1539:	00 00                	add    %al,(%eax)
    153b:	00 00                	add    %al,(%eax)
    153d:	00 00                	add    %al,(%eax)
    153f:	00 e0                	add    %ah,%al
    1541:	00 00                	add    %al,(%eax)
    1543:	00 62 00             	add    %ah,0x0(%edx)
    1546:	00 00                	add    %al,(%eax)
    1548:	07                   	pop    %es
    1549:	0b 00                	or     (%eax),%eax
    154b:	00 24 00             	add    %ah,(%eax,%eax,1)
    154e:	00 00                	add    %al,(%eax)
    1550:	e0 05                	loopne 1557 <wait_KBC_sendready-0x27eaa9>
    1552:	28 00                	sub    %al,(%eax)
    1554:	17                   	pop    %ss
    1555:	0b 00                	or     (%eax),%eax
    1557:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    155d:	00 00                	add    %al,(%eax)
    155f:	00 22                	add    %ah,(%edx)
    1561:	0b 00                	or     (%eax),%eax
    1563:	00 a0 00 00 00 0c    	add    %ah,0xc000000(%eax)
    1569:	00 00                	add    %al,(%eax)
    156b:	00 00                	add    %al,(%eax)
    156d:	00 00                	add    %al,(%eax)
    156f:	00 44 00 4f          	add    %al,0x4f(%eax,%eax,1)
	...
    157b:	00 44 00 4f          	add    %al,0x4f(%eax,%eax,1)
    157f:	00 09                	add    %cl,(%ecx)
    1581:	00 00                	add    %al,(%eax)
    1583:	00 00                	add    %al,(%eax)
    1585:	00 00                	add    %al,(%eax)
    1587:	00 44 00 51          	add    %al,0x51(%eax,%eax,1)
    158b:	00 0c 00             	add    %cl,(%eax,%eax,1)
    158e:	00 00                	add    %al,(%eax)
    1590:	00 00                	add    %al,(%eax)
    1592:	00 00                	add    %al,(%eax)
    1594:	44                   	inc    %esp
    1595:	00 54 00 0f          	add    %dl,0xf(%eax,%eax,1)
    1599:	00 00                	add    %al,(%eax)
    159b:	00 00                	add    %al,(%eax)
    159d:	00 00                	add    %al,(%eax)
    159f:	00 44 00 56          	add    %al,0x56(%eax,%eax,1)
    15a3:	00 1f                	add    %bl,(%edi)
    15a5:	00 00                	add    %al,(%eax)
    15a7:	00 00                	add    %al,(%eax)
    15a9:	00 00                	add    %al,(%eax)
    15ab:	00 44 00 58          	add    %al,0x58(%eax,%eax,1)
    15af:	00 21                	add    %ah,(%ecx)
    15b1:	00 00                	add    %al,(%eax)
    15b3:	00 00                	add    %al,(%eax)
    15b5:	00 00                	add    %al,(%eax)
    15b7:	00 44 00 56          	add    %al,0x56(%eax,%eax,1)
    15bb:	00 24 00             	add    %ah,(%eax,%eax,1)
    15be:	00 00                	add    %al,(%eax)
    15c0:	00 00                	add    %al,(%eax)
    15c2:	00 00                	add    %al,(%eax)
    15c4:	44                   	inc    %esp
    15c5:	00 58 00             	add    %bl,0x0(%eax)
    15c8:	26 00 00             	add    %al,%es:(%eax)
    15cb:	00 00                	add    %al,(%eax)
    15cd:	00 00                	add    %al,(%eax)
    15cf:	00 44 00 59          	add    %al,0x59(%eax,%eax,1)
    15d3:	00 29                	add    %ch,(%ecx)
    15d5:	00 00                	add    %al,(%eax)
    15d7:	00 00                	add    %al,(%eax)
    15d9:	00 00                	add    %al,(%eax)
    15db:	00 44 00 5e          	add    %al,0x5e(%eax,%eax,1)
    15df:	00 2b                	add    %ch,(%ebx)
    15e1:	00 00                	add    %al,(%eax)
    15e3:	00 00                	add    %al,(%eax)
    15e5:	00 00                	add    %al,(%eax)
    15e7:	00 44 00 60          	add    %al,0x60(%eax,%eax,1)
    15eb:	00 3a                	add    %bh,(%edx)
    15ed:	00 00                	add    %al,(%eax)
    15ef:	00 00                	add    %al,(%eax)
    15f1:	00 00                	add    %al,(%eax)
    15f3:	00 44 00 60          	add    %al,0x60(%eax,%eax,1)
    15f7:	00 4c 00 00          	add    %cl,0x0(%eax,%eax,1)
    15fb:	00 00                	add    %al,(%eax)
    15fd:	00 00                	add    %al,(%eax)
    15ff:	00 44 00 60          	add    %al,0x60(%eax,%eax,1)
    1603:	00 52 00             	add    %dl,0x0(%edx)
    1606:	00 00                	add    %al,(%eax)
    1608:	00 00                	add    %al,(%eax)
    160a:	00 00                	add    %al,(%eax)
    160c:	44                   	inc    %esp
    160d:	00 61 00             	add    %ah,0x0(%ecx)
    1610:	59                   	pop    %ecx
    1611:	00 00                	add    %al,(%eax)
    1613:	00 00                	add    %al,(%eax)
    1615:	00 00                	add    %al,(%eax)
    1617:	00 44 00 61          	add    %al,0x61(%eax,%eax,1)
    161b:	00 6b 00             	add    %ch,0x0(%ebx)
    161e:	00 00                	add    %al,(%eax)
    1620:	00 00                	add    %al,(%eax)
    1622:	00 00                	add    %al,(%eax)
    1624:	44                   	inc    %esp
    1625:	00 61 00             	add    %ah,0x0(%ecx)
    1628:	71 00                	jno    162a <wait_KBC_sendready-0x27e9d6>
    162a:	00 00                	add    %al,(%eax)
    162c:	00 00                	add    %al,(%eax)
    162e:	00 00                	add    %al,(%eax)
    1630:	44                   	inc    %esp
    1631:	00 62 00             	add    %ah,0x0(%edx)
    1634:	78 00                	js     1636 <wait_KBC_sendready-0x27e9ca>
    1636:	00 00                	add    %al,(%eax)
    1638:	00 00                	add    %al,(%eax)
    163a:	00 00                	add    %al,(%eax)
    163c:	44                   	inc    %esp
    163d:	00 62 00             	add    %ah,0x0(%edx)
    1640:	80 00 00             	addb   $0x0,(%eax)
    1643:	00 00                	add    %al,(%eax)
    1645:	00 00                	add    %al,(%eax)
    1647:	00 44 00 62          	add    %al,0x62(%eax,%eax,1)
    164b:	00 87 00 00 00 00    	add    %al,0x0(%edi)
    1651:	00 00                	add    %al,(%eax)
    1653:	00 44 00 5e          	add    %al,0x5e(%eax,%eax,1)
    1657:	00 8d 00 00 00 00    	add    %cl,0x0(%ebp)
    165d:	00 00                	add    %al,(%eax)
    165f:	00 44 00 67          	add    %al,0x67(%eax,%eax,1)
    1663:	00 8f 00 00 00 00    	add    %cl,0x0(%edi)
    1669:	00 00                	add    %al,(%eax)
    166b:	00 44 00 66          	add    %al,0x66(%eax,%eax,1)
    166f:	00 92 00 00 00 00    	add    %dl,0x0(%edx)
    1675:	00 00                	add    %al,(%eax)
    1677:	00 44 00 67          	add    %al,0x67(%eax,%eax,1)
    167b:	00 95 00 00 00 00    	add    %dl,0x0(%ebp)
    1681:	00 00                	add    %al,(%eax)
    1683:	00 44 00 6c          	add    %al,0x6c(%eax,%eax,1)
    1687:	00 9f 00 00 00 00    	add    %bl,0x0(%edi)
    168d:	00 00                	add    %al,(%eax)
    168f:	00 44 00 6e          	add    %al,0x6e(%eax,%eax,1)
    1693:	00 a2 00 00 00 30    	add    %ah,0x30000000(%edx)
    1699:	0b 00                	or     (%eax),%eax
    169b:	00 40 00             	add    %al,0x0(%eax)
    169e:	00 00                	add    %al,(%eax)
    16a0:	06                   	push   %es
    16a1:	00 00                	add    %al,(%eax)
    16a3:	00 43 0b             	add    %al,0xb(%ebx)
    16a6:	00 00                	add    %al,(%eax)
    16a8:	80 00 00             	addb   $0x0,(%eax)
    16ab:	00 f6                	add    %dh,%dh
    16ad:	ff                   	(bad)  
    16ae:	ff                   	(bad)  
    16af:	ff 51 0b             	call   *0xb(%ecx)
    16b2:	00 00                	add    %al,(%eax)
    16b4:	40                   	inc    %eax
    16b5:	00 00                	add    %al,(%eax)
    16b7:	00 03                	add    %al,(%ebx)
    16b9:	00 00                	add    %al,(%eax)
    16bb:	00 00                	add    %al,(%eax)
    16bd:	00 00                	add    %al,(%eax)
    16bf:	00 c0                	add    %al,%al
	...
    16c9:	00 00                	add    %al,(%eax)
    16cb:	00 e0                	add    %ah,%al
    16cd:	00 00                	add    %al,(%eax)
    16cf:	00 aa 00 00 00 5c    	add    %ch,0x5c000000(%edx)
    16d5:	0b 00                	or     (%eax),%eax
    16d7:	00 24 00             	add    %ah,(%eax,%eax,1)
    16da:	00 00                	add    %al,(%eax)
    16dc:	8a 06                	mov    (%esi),%al
    16de:	28 00                	sub    %al,(%eax)
    16e0:	f1                   	icebp  
    16e1:	09 00                	or     %eax,(%eax)
    16e3:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    16e9:	00 00                	add    %al,(%eax)
    16eb:	00 be 08 00 00 a0    	add    %bh,-0x5ffffff8(%esi)
    16f1:	00 00                	add    %al,(%eax)
    16f3:	00 0c 00             	add    %cl,(%eax,%eax,1)
    16f6:	00 00                	add    %al,(%eax)
    16f8:	6d                   	insl   (%dx),%es:(%edi)
    16f9:	0b 00                	or     (%eax),%eax
    16fb:	00 a0 00 00 00 10    	add    %ah,0x10000000(%eax)
    1701:	00 00                	add    %al,(%eax)
    1703:	00 76 0b             	add    %dh,0xb(%esi)
    1706:	00 00                	add    %al,(%eax)
    1708:	a0 00 00 00 14       	mov    0x14000000,%al
    170d:	00 00                	add    %al,(%eax)
    170f:	00 c9                	add    %cl,%cl
    1711:	07                   	pop    %es
    1712:	00 00                	add    %al,(%eax)
    1714:	a0 00 00 00 18       	mov    0x18000000,%al
    1719:	00 00                	add    %al,(%eax)
    171b:	00 7f 0b             	add    %bh,0xb(%edi)
    171e:	00 00                	add    %al,(%eax)
    1720:	a0 00 00 00 1c       	mov    0x1c000000,%al
    1725:	00 00                	add    %al,(%eax)
    1727:	00 00                	add    %al,(%eax)
    1729:	00 00                	add    %al,(%eax)
    172b:	00 44 00 92          	add    %al,-0x6e(%eax,%eax,1)
	...
    1737:	00 44 00 92          	add    %al,-0x6e(%eax,%eax,1)
    173b:	00 0c 00             	add    %cl,(%eax,%eax,1)
    173e:	00 00                	add    %al,(%eax)
    1740:	00 00                	add    %al,(%eax)
    1742:	00 00                	add    %al,(%eax)
    1744:	44                   	inc    %esp
    1745:	00 95 00 26 00 00    	add    %dl,0x2600(%ebp)
    174b:	00 00                	add    %al,(%eax)
    174d:	00 00                	add    %al,(%eax)
    174f:	00 44 00 98          	add    %al,-0x68(%eax,%eax,1)
    1753:	00 2b                	add    %ch,(%ebx)
    1755:	00 00                	add    %al,(%eax)
    1757:	00 00                	add    %al,(%eax)
    1759:	00 00                	add    %al,(%eax)
    175b:	00 44 00 9a          	add    %al,-0x66(%eax,%eax,1)
    175f:	00 30                	add    %dh,(%eax)
    1761:	00 00                	add    %al,(%eax)
    1763:	00 00                	add    %al,(%eax)
    1765:	00 00                	add    %al,(%eax)
    1767:	00 44 00 9c          	add    %al,-0x64(%eax,%eax,1)
    176b:	00 42 00             	add    %al,0x0(%edx)
    176e:	00 00                	add    %al,(%eax)
    1770:	00 00                	add    %al,(%eax)
    1772:	00 00                	add    %al,(%eax)
    1774:	44                   	inc    %esp
    1775:	00 98 00 48 00 00    	add    %bl,0x4800(%eax)
    177b:	00 00                	add    %al,(%eax)
    177d:	00 00                	add    %al,(%eax)
    177f:	00 44 00 95          	add    %al,-0x6b(%eax,%eax,1)
    1783:	00 4e 00             	add    %cl,0x0(%esi)
    1786:	00 00                	add    %al,(%eax)
    1788:	00 00                	add    %al,(%eax)
    178a:	00 00                	add    %al,(%eax)
    178c:	44                   	inc    %esp
    178d:	00 a8 00 5a 00 00    	add    %ch,0x5a00(%eax)
    1793:	00 8b 0b 00 00 40    	add    %cl,0x4000000b(%ebx)
    1799:	00 00                	add    %al,(%eax)
    179b:	00 00                	add    %al,(%eax)
    179d:	00 00                	add    %al,(%eax)
    179f:	00 96 0b 00 00 40    	add    %dl,0x4000000b(%esi)
    17a5:	00 00                	add    %al,(%eax)
    17a7:	00 01                	add    %al,(%ecx)
    17a9:	00 00                	add    %al,(%eax)
    17ab:	00 00                	add    %al,(%eax)
    17ad:	00 00                	add    %al,(%eax)
    17af:	00 c0                	add    %al,%al
	...
    17b9:	00 00                	add    %al,(%eax)
    17bb:	00 e0                	add    %ah,%al
    17bd:	00 00                	add    %al,(%eax)
    17bf:	00 62 00             	add    %ah,0x0(%edx)
    17c2:	00 00                	add    %al,(%eax)
    17c4:	a1 0b 00 00 24       	mov    0x2400000b,%eax
    17c9:	00 00                	add    %al,(%eax)
    17cb:	00 ec                	add    %ch,%ah
    17cd:	06                   	push   %es
    17ce:	28 00                	sub    %al,(%eax)
    17d0:	f1                   	icebp  
    17d1:	09 00                	or     %eax,(%eax)
    17d3:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    17d9:	00 00                	add    %al,(%eax)
    17db:	00 be 08 00 00 a0    	add    %bh,-0x5ffffff8(%esi)
    17e1:	00 00                	add    %al,(%eax)
    17e3:	00 0c 00             	add    %cl,(%eax,%eax,1)
    17e6:	00 00                	add    %al,(%eax)
    17e8:	6d                   	insl   (%dx),%es:(%edi)
    17e9:	0b 00                	or     (%eax),%eax
    17eb:	00 a0 00 00 00 10    	add    %ah,0x10000000(%eax)
    17f1:	00 00                	add    %al,(%eax)
    17f3:	00 76 0b             	add    %dh,0xb(%esi)
    17f6:	00 00                	add    %al,(%eax)
    17f8:	a0 00 00 00 14       	mov    0x14000000,%al
    17fd:	00 00                	add    %al,(%eax)
    17ff:	00 c9                	add    %cl,%cl
    1801:	07                   	pop    %es
    1802:	00 00                	add    %al,(%eax)
    1804:	a0 00 00 00 18       	mov    0x18000000,%al
    1809:	00 00                	add    %al,(%eax)
    180b:	00 7f 0b             	add    %bh,0xb(%edi)
    180e:	00 00                	add    %al,(%eax)
    1810:	a0 00 00 00 1c       	mov    0x1c000000,%al
    1815:	00 00                	add    %al,(%eax)
    1817:	00 00                	add    %al,(%eax)
    1819:	00 00                	add    %al,(%eax)
    181b:	00 44 00 71          	add    %al,0x71(%eax,%eax,1)
	...
    1827:	00 44 00 7d          	add    %al,0x7d(%eax,%eax,1)
    182b:	00 08                	add    %cl,(%eax)
    182d:	00 00                	add    %al,(%eax)
    182f:	00 00                	add    %al,(%eax)
    1831:	00 00                	add    %al,(%eax)
    1833:	00 44 00 71          	add    %al,0x71(%eax,%eax,1)
    1837:	00 0c 00             	add    %cl,(%eax,%eax,1)
    183a:	00 00                	add    %al,(%eax)
    183c:	00 00                	add    %al,(%eax)
    183e:	00 00                	add    %al,(%eax)
    1840:	44                   	inc    %esp
    1841:	00 71 00             	add    %dh,0x0(%ecx)
    1844:	0d 00 00 00 00       	or     $0x0,%eax
    1849:	00 00                	add    %al,(%eax)
    184b:	00 44 00 73          	add    %al,0x73(%eax,%eax,1)
    184f:	00 10                	add    %dl,(%eax)
    1851:	00 00                	add    %al,(%eax)
    1853:	00 00                	add    %al,(%eax)
    1855:	00 00                	add    %al,(%eax)
    1857:	00 44 00 75          	add    %al,0x75(%eax,%eax,1)
    185b:	00 1a                	add    %bl,(%edx)
    185d:	00 00                	add    %al,(%eax)
    185f:	00 00                	add    %al,(%eax)
    1861:	00 00                	add    %al,(%eax)
    1863:	00 44 00 78          	add    %al,0x78(%eax,%eax,1)
    1867:	00 1e                	add    %bl,(%esi)
    1869:	00 00                	add    %al,(%eax)
    186b:	00 00                	add    %al,(%eax)
    186d:	00 00                	add    %al,(%eax)
    186f:	00 44 00 7d          	add    %al,0x7d(%eax,%eax,1)
    1873:	00 23                	add    %ah,(%ebx)
    1875:	00 00                	add    %al,(%eax)
    1877:	00 00                	add    %al,(%eax)
    1879:	00 00                	add    %al,(%eax)
    187b:	00 44 00 7e          	add    %al,0x7e(%eax,%eax,1)
    187f:	00 2f                	add    %ch,(%edi)
    1881:	00 00                	add    %al,(%eax)
    1883:	00 00                	add    %al,(%eax)
    1885:	00 00                	add    %al,(%eax)
    1887:	00 44 00 7d          	add    %al,0x7d(%eax,%eax,1)
    188b:	00 32                	add    %dh,(%edx)
    188d:	00 00                	add    %al,(%eax)
    188f:	00 00                	add    %al,(%eax)
    1891:	00 00                	add    %al,(%eax)
    1893:	00 44 00 7f          	add    %al,0x7f(%eax,%eax,1)
    1897:	00 3d 00 00 00 00    	add    %bh,0x0
    189d:	00 00                	add    %al,(%eax)
    189f:	00 44 00 82          	add    %al,-0x7e(%eax,%eax,1)
    18a3:	00 48 00             	add    %cl,0x0(%eax)
    18a6:	00 00                	add    %al,(%eax)
    18a8:	00 00                	add    %al,(%eax)
    18aa:	00 00                	add    %al,(%eax)
    18ac:	44                   	inc    %esp
    18ad:	00 83 00 4b 00 00    	add    %al,0x4b00(%ebx)
    18b3:	00 00                	add    %al,(%eax)
    18b5:	00 00                	add    %al,(%eax)
    18b7:	00 44 00 86          	add    %al,-0x7a(%eax,%eax,1)
    18bb:	00 53 00             	add    %dl,0x0(%ebx)
    18be:	00 00                	add    %al,(%eax)
    18c0:	00 00                	add    %al,(%eax)
    18c2:	00 00                	add    %al,(%eax)
    18c4:	44                   	inc    %esp
    18c5:	00 85 00 55 00 00    	add    %al,0x5500(%ebp)
    18cb:	00 00                	add    %al,(%eax)
    18cd:	00 00                	add    %al,(%eax)
    18cf:	00 44 00 8c          	add    %al,-0x74(%eax,%eax,1)
    18d3:	00 57 00             	add    %dl,0x0(%edi)
    18d6:	00 00                	add    %al,(%eax)
    18d8:	00 00                	add    %al,(%eax)
    18da:	00 00                	add    %al,(%eax)
    18dc:	44                   	inc    %esp
    18dd:	00 8f 00 5c 00 00    	add    %cl,0x5c00(%edi)
    18e3:	00 c8                	add    %cl,%al
    18e5:	09 00                	or     %eax,(%eax)
    18e7:	00 40 00             	add    %al,0x0(%eax)
    18ea:	00 00                	add    %al,(%eax)
    18ec:	03 00                	add    (%eax),%eax
    18ee:	00 00                	add    %al,(%eax)
    18f0:	48                   	dec    %eax
    18f1:	0a 00                	or     (%eax),%al
    18f3:	00 40 00             	add    %al,0x0(%eax)
    18f6:	00 00                	add    %al,(%eax)
    18f8:	07                   	pop    %es
    18f9:	00 00                	add    %al,(%eax)
    18fb:	00 af 0b 00 00 24    	add    %ch,0x2400000b(%edi)
    1901:	00 00                	add    %al,(%eax)
    1903:	00 50 07             	add    %dl,0x7(%eax)
    1906:	28 00                	sub    %al,(%eax)
    1908:	c2 0b 00             	ret    $0xb
    190b:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    1911:	00 00                	add    %al,(%eax)
    1913:	00 6d 0b             	add    %ch,0xb(%ebp)
    1916:	00 00                	add    %al,(%eax)
    1918:	a0 00 00 00 0c       	mov    0xc000000,%al
    191d:	00 00                	add    %al,(%eax)
    191f:	00 00                	add    %al,(%eax)
    1921:	00 00                	add    %al,(%eax)
    1923:	00 44 00 05          	add    %al,0x5(%eax,%eax,1)
	...
    192f:	00 44 00 07          	add    %al,0x7(%eax,%eax,1)
    1933:	00 07                	add    %al,(%edi)
    1935:	00 00                	add    %al,(%eax)
    1937:	00 00                	add    %al,(%eax)
    1939:	00 00                	add    %al,(%eax)
    193b:	00 44 00 08          	add    %al,0x8(%eax,%eax,1)
    193f:	00 18                	add    %bl,(%eax)
    1941:	00 00                	add    %al,(%eax)
    1943:	00 00                	add    %al,(%eax)
    1945:	00 00                	add    %al,(%eax)
    1947:	00 44 00 0a          	add    %al,0xa(%eax,%eax,1)
    194b:	00 35 00 00 00 cb    	add    %dh,0xcb000000
    1951:	0b 00                	or     (%eax),%eax
    1953:	00 80 00 00 00 e2    	add    %al,-0x1e000000(%eax)
    1959:	ff                   	(bad)  
    195a:	ff                   	(bad)  
    195b:	ff 00                	incl   (%eax)
    195d:	00 00                	add    %al,(%eax)
    195f:	00 c0                	add    %al,%al
	...
    1969:	00 00                	add    %al,(%eax)
    196b:	00 e0                	add    %ah,%al
    196d:	00 00                	add    %al,(%eax)
    196f:	00 3a                	add    %bh,(%edx)
    1971:	00 00                	add    %al,(%eax)
    1973:	00 d7                	add    %dl,%bh
    1975:	0b 00                	or     (%eax),%eax
    1977:	00 24 00             	add    %ah,(%eax,%eax,1)
    197a:	00 00                	add    %al,(%eax)
    197c:	8a 07                	mov    (%edi),%al
    197e:	28 00                	sub    %al,(%eax)
    1980:	f1                   	icebp  
    1981:	09 00                	or     %eax,(%eax)
    1983:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    1989:	00 00                	add    %al,(%eax)
    198b:	00 be 08 00 00 a0    	add    %bh,-0x5ffffff8(%esi)
    1991:	00 00                	add    %al,(%eax)
    1993:	00 0c 00             	add    %cl,(%eax,%eax,1)
    1996:	00 00                	add    %al,(%eax)
    1998:	6d                   	insl   (%dx),%es:(%edi)
    1999:	0b 00                	or     (%eax),%eax
    199b:	00 a0 00 00 00 10    	add    %ah,0x10000000(%eax)
    19a1:	00 00                	add    %al,(%eax)
    19a3:	00 76 0b             	add    %dh,0xb(%esi)
    19a6:	00 00                	add    %al,(%eax)
    19a8:	a0 00 00 00 14       	mov    0x14000000,%al
    19ad:	00 00                	add    %al,(%eax)
    19af:	00 c9                	add    %cl,%cl
    19b1:	07                   	pop    %es
    19b2:	00 00                	add    %al,(%eax)
    19b4:	a0 00 00 00 18       	mov    0x18000000,%al
    19b9:	00 00                	add    %al,(%eax)
    19bb:	00 e9                	add    %ch,%cl
    19bd:	0b 00                	or     (%eax),%eax
    19bf:	00 a0 00 00 00 1c    	add    %ah,0x1c000000(%eax)
    19c5:	00 00                	add    %al,(%eax)
    19c7:	00 00                	add    %al,(%eax)
    19c9:	00 00                	add    %al,(%eax)
    19cb:	00 44 00 c4          	add    %al,-0x3c(%eax,%eax,1)
	...
    19d7:	00 44 00 c8          	add    %al,-0x38(%eax,%eax,1)
    19db:	00 01                	add    %al,(%ecx)
    19dd:	00 00                	add    %al,(%eax)
    19df:	00 00                	add    %al,(%eax)
    19e1:	00 00                	add    %al,(%eax)
    19e3:	00 44 00 c4          	add    %al,-0x3c(%eax,%eax,1)
    19e7:	00 03                	add    %al,(%ebx)
    19e9:	00 00                	add    %al,(%eax)
    19eb:	00 00                	add    %al,(%eax)
    19ed:	00 00                	add    %al,(%eax)
    19ef:	00 44 00 c4          	add    %al,-0x3c(%eax,%eax,1)
    19f3:	00 0a                	add    %cl,(%edx)
    19f5:	00 00                	add    %al,(%eax)
    19f7:	00 00                	add    %al,(%eax)
    19f9:	00 00                	add    %al,(%eax)
    19fb:	00 44 00 cd          	add    %al,-0x33(%eax,%eax,1)
    19ff:	00 17                	add    %dl,(%edi)
    1a01:	00 00                	add    %al,(%eax)
    1a03:	00 00                	add    %al,(%eax)
    1a05:	00 00                	add    %al,(%eax)
    1a07:	00 44 00 cb          	add    %al,-0x35(%eax,%eax,1)
    1a0b:	00 1a                	add    %bl,(%edx)
    1a0d:	00 00                	add    %al,(%eax)
    1a0f:	00 00                	add    %al,(%eax)
    1a11:	00 00                	add    %al,(%eax)
    1a13:	00 44 00 cd          	add    %al,-0x33(%eax,%eax,1)
    1a17:	00 1c 00             	add    %bl,(%eax,%eax,1)
    1a1a:	00 00                	add    %al,(%eax)
    1a1c:	00 00                	add    %al,(%eax)
    1a1e:	00 00                	add    %al,(%eax)
    1a20:	44                   	inc    %esp
    1a21:	00 d0                	add    %dl,%al
    1a23:	00 29                	add    %ch,(%ecx)
    1a25:	00 00                	add    %al,(%eax)
    1a27:	00 00                	add    %al,(%eax)
    1a29:	00 00                	add    %al,(%eax)
    1a2b:	00 44 00 cb          	add    %al,-0x35(%eax,%eax,1)
    1a2f:	00 2c 00             	add    %ch,(%eax,%eax,1)
    1a32:	00 00                	add    %al,(%eax)
    1a34:	00 00                	add    %al,(%eax)
    1a36:	00 00                	add    %al,(%eax)
    1a38:	44                   	inc    %esp
    1a39:	00 c8                	add    %cl,%al
    1a3b:	00 32                	add    %dh,(%edx)
    1a3d:	00 00                	add    %al,(%eax)
    1a3f:	00 00                	add    %al,(%eax)
    1a41:	00 00                	add    %al,(%eax)
    1a43:	00 44 00 dc          	add    %al,-0x24(%eax,%eax,1)
    1a47:	00 3b                	add    %bh,(%ebx)
    1a49:	00 00                	add    %al,(%eax)
    1a4b:	00 8b 0b 00 00 40    	add    %cl,0x4000000b(%ebx)
    1a51:	00 00                	add    %al,(%eax)
    1a53:	00 01                	add    %al,(%ecx)
    1a55:	00 00                	add    %al,(%eax)
    1a57:	00 96 0b 00 00 40    	add    %dl,0x4000000b(%esi)
    1a5d:	00 00                	add    %al,(%eax)
    1a5f:	00 02                	add    %al,(%edx)
    1a61:	00 00                	add    %al,(%eax)
    1a63:	00 df                	add    %bl,%bh
    1a65:	07                   	pop    %es
    1a66:	00 00                	add    %al,(%eax)
    1a68:	40                   	inc    %eax
    1a69:	00 00                	add    %al,(%eax)
    1a6b:	00 03                	add    %al,(%ebx)
    1a6d:	00 00                	add    %al,(%eax)
    1a6f:	00 00                	add    %al,(%eax)
    1a71:	00 00                	add    %al,(%eax)
    1a73:	00 c0                	add    %al,%al
	...
    1a7d:	00 00                	add    %al,(%eax)
    1a7f:	00 e0                	add    %ah,%al
    1a81:	00 00                	add    %al,(%eax)
    1a83:	00 3f                	add    %bh,(%edi)
    1a85:	00 00                	add    %al,(%eax)
    1a87:	00 fd                	add    %bh,%ch
    1a89:	0b 00                	or     (%eax),%eax
    1a8b:	00 24 00             	add    %ah,(%eax,%eax,1)
    1a8e:	00 00                	add    %al,(%eax)
    1a90:	c9                   	leave  
    1a91:	07                   	pop    %es
    1a92:	28 00                	sub    %al,(%eax)
    1a94:	f1                   	icebp  
    1a95:	09 00                	or     %eax,(%eax)
    1a97:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    1a9d:	00 00                	add    %al,(%eax)
    1a9f:	00 be 08 00 00 a0    	add    %bh,-0x5ffffff8(%esi)
    1aa5:	00 00                	add    %al,(%eax)
    1aa7:	00 0c 00             	add    %cl,(%eax,%eax,1)
    1aaa:	00 00                	add    %al,(%eax)
    1aac:	6d                   	insl   (%dx),%es:(%edi)
    1aad:	0b 00                	or     (%eax),%eax
    1aaf:	00 a0 00 00 00 10    	add    %ah,0x10000000(%eax)
    1ab5:	00 00                	add    %al,(%eax)
    1ab7:	00 76 0b             	add    %dh,0xb(%esi)
    1aba:	00 00                	add    %al,(%eax)
    1abc:	a0 00 00 00 14       	mov    0x14000000,%al
    1ac1:	00 00                	add    %al,(%eax)
    1ac3:	00 c9                	add    %cl,%cl
    1ac5:	07                   	pop    %es
    1ac6:	00 00                	add    %al,(%eax)
    1ac8:	a0 00 00 00 18       	mov    0x18000000,%al
    1acd:	00 00                	add    %al,(%eax)
    1acf:	00 7f 0b             	add    %bh,0xb(%edi)
    1ad2:	00 00                	add    %al,(%eax)
    1ad4:	a0 00 00 00 1c       	mov    0x1c000000,%al
    1ad9:	00 00                	add    %al,(%eax)
    1adb:	00 00                	add    %al,(%eax)
    1add:	00 00                	add    %al,(%eax)
    1adf:	00 44 00 ab          	add    %al,-0x55(%eax,%eax,1)
	...
    1aeb:	00 44 00 b8          	add    %al,-0x48(%eax,%eax,1)
    1aef:	00 0c 00             	add    %cl,(%eax,%eax,1)
    1af2:	00 00                	add    %al,(%eax)
    1af4:	00 00                	add    %al,(%eax)
    1af6:	00 00                	add    %al,(%eax)
    1af8:	44                   	inc    %esp
    1af9:	00 ad 00 10 00 00    	add    %ch,0x1000(%ebp)
    1aff:	00 00                	add    %al,(%eax)
    1b01:	00 00                	add    %al,(%eax)
    1b03:	00 44 00 af          	add    %al,-0x51(%eax,%eax,1)
    1b07:	00 1a                	add    %bl,(%edx)
    1b09:	00 00                	add    %al,(%eax)
    1b0b:	00 00                	add    %al,(%eax)
    1b0d:	00 00                	add    %al,(%eax)
    1b0f:	00 44 00 b2          	add    %al,-0x4e(%eax,%eax,1)
    1b13:	00 1e                	add    %bl,(%esi)
    1b15:	00 00                	add    %al,(%eax)
    1b17:	00 00                	add    %al,(%eax)
    1b19:	00 00                	add    %al,(%eax)
    1b1b:	00 44 00 b1          	add    %al,-0x4f(%eax,%eax,1)
    1b1f:	00 21                	add    %ah,(%ecx)
    1b21:	00 00                	add    %al,(%eax)
    1b23:	00 00                	add    %al,(%eax)
    1b25:	00 00                	add    %al,(%eax)
    1b27:	00 44 00 b7          	add    %al,-0x49(%eax,%eax,1)
    1b2b:	00 25 00 00 00 00    	add    %ah,0x0
    1b31:	00 00                	add    %al,(%eax)
    1b33:	00 44 00 b8          	add    %al,-0x48(%eax,%eax,1)
    1b37:	00 2d 00 00 00 00    	add    %ch,0x0
    1b3d:	00 00                	add    %al,(%eax)
    1b3f:	00 44 00 b9          	add    %al,-0x47(%eax,%eax,1)
    1b43:	00 31                	add    %dh,(%ecx)
    1b45:	00 00                	add    %al,(%eax)
    1b47:	00 00                	add    %al,(%eax)
    1b49:	00 00                	add    %al,(%eax)
    1b4b:	00 44 00 b8          	add    %al,-0x48(%eax,%eax,1)
    1b4f:	00 34 00             	add    %dh,(%eax,%eax,1)
    1b52:	00 00                	add    %al,(%eax)
    1b54:	00 00                	add    %al,(%eax)
    1b56:	00 00                	add    %al,(%eax)
    1b58:	44                   	inc    %esp
    1b59:	00 b9 00 3f 00 00    	add    %bh,0x3f00(%ecx)
    1b5f:	00 00                	add    %al,(%eax)
    1b61:	00 00                	add    %al,(%eax)
    1b63:	00 44 00 be          	add    %al,-0x42(%eax,%eax,1)
    1b67:	00 42 00             	add    %al,0x0(%edx)
    1b6a:	00 00                	add    %al,(%eax)
    1b6c:	00 00                	add    %al,(%eax)
    1b6e:	00 00                	add    %al,(%eax)
    1b70:	44                   	inc    %esp
    1b71:	00 c2                	add    %al,%dl
    1b73:	00 47 00             	add    %al,0x0(%edi)
    1b76:	00 00                	add    %al,(%eax)
    1b78:	c8 09 00 00          	enter  $0x9,$0x0
    1b7c:	40                   	inc    %eax
    1b7d:	00 00                	add    %al,(%eax)
    1b7f:	00 07                	add    %al,(%edi)
    1b81:	00 00                	add    %al,(%eax)
    1b83:	00 48 0a             	add    %cl,0xa(%eax)
    1b86:	00 00                	add    %al,(%eax)
    1b88:	40                   	inc    %eax
    1b89:	00 00                	add    %al,(%eax)
    1b8b:	00 06                	add    %al,(%esi)
    1b8d:	00 00                	add    %al,(%eax)
    1b8f:	00 00                	add    %al,(%eax)
    1b91:	00 00                	add    %al,(%eax)
    1b93:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
    1b97:	00 18                	add    %bl,(%eax)
    1b99:	08 28                	or     %ch,(%eax)
    1b9b:	00 0c 0c             	add    %cl,(%esp,%ecx,1)
    1b9e:	00 00                	add    %al,(%eax)
    1ba0:	64 00 02             	add    %al,%fs:(%edx)
    1ba3:	00 18                	add    %bl,(%eax)
    1ba5:	08 28                	or     %ch,(%eax)
    1ba7:	00 08                	add    %cl,(%eax)
    1ba9:	00 00                	add    %al,(%eax)
    1bab:	00 3c 00             	add    %bh,(%eax,%eax,1)
    1bae:	00 00                	add    %al,(%eax)
    1bb0:	00 00                	add    %al,(%eax)
    1bb2:	00 00                	add    %al,(%eax)
    1bb4:	17                   	pop    %ss
    1bb5:	00 00                	add    %al,(%eax)
    1bb7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1bbd:	00 00                	add    %al,(%eax)
    1bbf:	00 41 00             	add    %al,0x0(%ecx)
    1bc2:	00 00                	add    %al,(%eax)
    1bc4:	80 00 00             	addb   $0x0,(%eax)
    1bc7:	00 00                	add    %al,(%eax)
    1bc9:	00 00                	add    %al,(%eax)
    1bcb:	00 5b 00             	add    %bl,0x0(%ebx)
    1bce:	00 00                	add    %al,(%eax)
    1bd0:	80 00 00             	addb   $0x0,(%eax)
    1bd3:	00 00                	add    %al,(%eax)
    1bd5:	00 00                	add    %al,(%eax)
    1bd7:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
    1bdd:	00 00                	add    %al,(%eax)
    1bdf:	00 00                	add    %al,(%eax)
    1be1:	00 00                	add    %al,(%eax)
    1be3:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
    1be9:	00 00                	add    %al,(%eax)
    1beb:	00 00                	add    %al,(%eax)
    1bed:	00 00                	add    %al,(%eax)
    1bef:	00 e1                	add    %ah,%cl
    1bf1:	00 00                	add    %al,(%eax)
    1bf3:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1bf9:	00 00                	add    %al,(%eax)
    1bfb:	00 0c 01             	add    %cl,(%ecx,%eax,1)
    1bfe:	00 00                	add    %al,(%eax)
    1c00:	80 00 00             	addb   $0x0,(%eax)
    1c03:	00 00                	add    %al,(%eax)
    1c05:	00 00                	add    %al,(%eax)
    1c07:	00 37                	add    %dh,(%edi)
    1c09:	01 00                	add    %eax,(%eax)
    1c0b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1c11:	00 00                	add    %al,(%eax)
    1c13:	00 5d 01             	add    %bl,0x1(%ebp)
    1c16:	00 00                	add    %al,(%eax)
    1c18:	80 00 00             	addb   $0x0,(%eax)
    1c1b:	00 00                	add    %al,(%eax)
    1c1d:	00 00                	add    %al,(%eax)
    1c1f:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
    1c25:	00 00                	add    %al,(%eax)
    1c27:	00 00                	add    %al,(%eax)
    1c29:	00 00                	add    %al,(%eax)
    1c2b:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
    1c31:	00 00                	add    %al,(%eax)
    1c33:	00 00                	add    %al,(%eax)
    1c35:	00 00                	add    %al,(%eax)
    1c37:	00 d2                	add    %dl,%dl
    1c39:	01 00                	add    %eax,(%eax)
    1c3b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1c41:	00 00                	add    %al,(%eax)
    1c43:	00 ec                	add    %ch,%ah
    1c45:	01 00                	add    %eax,(%eax)
    1c47:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1c4d:	00 00                	add    %al,(%eax)
    1c4f:	00 07                	add    %al,(%edi)
    1c51:	02 00                	add    (%eax),%al
    1c53:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1c59:	00 00                	add    %al,(%eax)
    1c5b:	00 28                	add    %ch,(%eax)
    1c5d:	02 00                	add    (%eax),%al
    1c5f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1c65:	00 00                	add    %al,(%eax)
    1c67:	00 47 02             	add    %al,0x2(%edi)
    1c6a:	00 00                	add    %al,(%eax)
    1c6c:	80 00 00             	addb   $0x0,(%eax)
    1c6f:	00 00                	add    %al,(%eax)
    1c71:	00 00                	add    %al,(%eax)
    1c73:	00 66 02             	add    %ah,0x2(%esi)
    1c76:	00 00                	add    %al,(%eax)
    1c78:	80 00 00             	addb   $0x0,(%eax)
    1c7b:	00 00                	add    %al,(%eax)
    1c7d:	00 00                	add    %al,(%eax)
    1c7f:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
    1c85:	00 00                	add    %al,(%eax)
    1c87:	00 00                	add    %al,(%eax)
    1c89:	00 00                	add    %al,(%eax)
    1c8b:	00 9b 02 00 00 c2    	add    %bl,-0x3dfffffe(%ebx)
    1c91:	00 00                	add    %al,(%eax)
    1c93:	00 d4                	add    %dl,%ah
    1c95:	8c 00                	mov    %es,(%eax)
    1c97:	00 a4 02 00 00 c2 00 	add    %ah,0xc20000(%edx,%eax,1)
    1c9e:	00 00                	add    %al,(%eax)
    1ca0:	00 00                	add    %al,(%eax)
    1ca2:	00 00                	add    %al,(%eax)
    1ca4:	aa                   	stos   %al,%es:(%edi)
    1ca5:	02 00                	add    (%eax),%al
    1ca7:	00 c2                	add    %al,%dl
    1ca9:	00 00                	add    %al,(%eax)
    1cab:	00 37                	add    %dh,(%edi)
    1cad:	53                   	push   %ebx
    1cae:	00 00                	add    %al,(%eax)
    1cb0:	15 0c 00 00 24       	adc    $0x2400000c,%eax
    1cb5:	00 00                	add    %al,(%eax)
    1cb7:	00 18                	add    %bl,(%eax)
    1cb9:	08 28                	or     %ch,(%eax)
    1cbb:	00 24 0c             	add    %ah,(%esp,%ecx,1)
    1cbe:	00 00                	add    %al,(%eax)
    1cc0:	a0 00 00 00 08       	mov    0x8000000,%al
    1cc5:	00 00                	add    %al,(%eax)
    1cc7:	00 36                	add    %dh,(%esi)
    1cc9:	0c 00                	or     $0x0,%al
    1ccb:	00 a0 00 00 00 0c    	add    %ah,0xc000000(%eax)
    1cd1:	00 00                	add    %al,(%eax)
    1cd3:	00 43 0c             	add    %al,0xc(%ebx)
    1cd6:	00 00                	add    %al,(%eax)
    1cd8:	a0 00 00 00 10       	mov    0x10000000,%al
    1cdd:	00 00                	add    %al,(%eax)
    1cdf:	00 4f 0c             	add    %cl,0xc(%edi)
    1ce2:	00 00                	add    %al,(%eax)
    1ce4:	a0 00 00 00 14       	mov    0x14000000,%al
    1ce9:	00 00                	add    %al,(%eax)
    1ceb:	00 00                	add    %al,(%eax)
    1ced:	00 00                	add    %al,(%eax)
    1cef:	00 44 00 07          	add    %al,0x7(%eax,%eax,1)
	...
    1cfb:	00 44 00 07          	add    %al,0x7(%eax,%eax,1)
    1cff:	00 0f                	add    %cl,(%edi)
    1d01:	00 00                	add    %al,(%eax)
    1d03:	00 00                	add    %al,(%eax)
    1d05:	00 00                	add    %al,(%eax)
    1d07:	00 44 00 08          	add    %al,0x8(%eax,%eax,1)
    1d0b:	00 12                	add    %dl,(%edx)
    1d0d:	00 00                	add    %al,(%eax)
    1d0f:	00 00                	add    %al,(%eax)
    1d11:	00 00                	add    %al,(%eax)
    1d13:	00 44 00 0a          	add    %al,0xa(%eax,%eax,1)
    1d17:	00 1a                	add    %bl,(%edx)
    1d19:	00 00                	add    %al,(%eax)
    1d1b:	00 00                	add    %al,(%eax)
    1d1d:	00 00                	add    %al,(%eax)
    1d1f:	00 44 00 0b          	add    %al,0xb(%eax,%eax,1)
    1d23:	00 20                	add    %ah,(%eax)
    1d25:	00 00                	add    %al,(%eax)
    1d27:	00 00                	add    %al,(%eax)
    1d29:	00 00                	add    %al,(%eax)
    1d2b:	00 44 00 0f          	add    %al,0xf(%eax,%eax,1)
    1d2f:	00 23                	add    %ah,(%ebx)
    1d31:	00 00                	add    %al,(%eax)
    1d33:	00 00                	add    %al,(%eax)
    1d35:	00 00                	add    %al,(%eax)
    1d37:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
    1d3b:	00 2d 00 00 00 00    	add    %ch,0x0
    1d41:	00 00                	add    %al,(%eax)
    1d43:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
    1d47:	00 2f                	add    %ch,(%edi)
    1d49:	00 00                	add    %al,(%eax)
    1d4b:	00 00                	add    %al,(%eax)
    1d4d:	00 00                	add    %al,(%eax)
    1d4f:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
    1d53:	00 32                	add    %dh,(%edx)
    1d55:	00 00                	add    %al,(%eax)
    1d57:	00 00                	add    %al,(%eax)
    1d59:	00 00                	add    %al,(%eax)
    1d5b:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
    1d5f:	00 35 00 00 00 00    	add    %dh,0x0
    1d65:	00 00                	add    %al,(%eax)
    1d67:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    1d6b:	00 37                	add    %dh,(%edi)
    1d6d:	00 00                	add    %al,(%eax)
    1d6f:	00 00                	add    %al,(%eax)
    1d71:	00 00                	add    %al,(%eax)
    1d73:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
    1d77:	00 3a                	add    %bh,(%edx)
    1d79:	00 00                	add    %al,(%eax)
    1d7b:	00 00                	add    %al,(%eax)
    1d7d:	00 00                	add    %al,(%eax)
    1d7f:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
    1d83:	00 40 00             	add    %al,0x0(%eax)
    1d86:	00 00                	add    %al,(%eax)
    1d88:	00 00                	add    %al,(%eax)
    1d8a:	00 00                	add    %al,(%eax)
    1d8c:	44                   	inc    %esp
    1d8d:	00 11                	add    %dl,(%ecx)
    1d8f:	00 44 00 00          	add    %al,0x0(%eax,%eax,1)
    1d93:	00 00                	add    %al,(%eax)
    1d95:	00 00                	add    %al,(%eax)
    1d97:	00 44 00 12          	add    %al,0x12(%eax,%eax,1)
    1d9b:	00 46 00             	add    %al,0x0(%esi)
    1d9e:	00 00                	add    %al,(%eax)
    1da0:	00 00                	add    %al,(%eax)
    1da2:	00 00                	add    %al,(%eax)
    1da4:	44                   	inc    %esp
    1da5:	00 11                	add    %dl,(%ecx)
    1da7:	00 49 00             	add    %cl,0x0(%ecx)
    1daa:	00 00                	add    %al,(%eax)
    1dac:	00 00                	add    %al,(%eax)
    1dae:	00 00                	add    %al,(%eax)
    1db0:	44                   	inc    %esp
    1db1:	00 12                	add    %dl,(%edx)
    1db3:	00 4c 00 00          	add    %cl,0x0(%eax,%eax,1)
    1db7:	00 00                	add    %al,(%eax)
    1db9:	00 00                	add    %al,(%eax)
    1dbb:	00 44 00 14          	add    %al,0x14(%eax,%eax,1)
    1dbf:	00 4f 00             	add    %cl,0x0(%edi)
    1dc2:	00 00                	add    %al,(%eax)
    1dc4:	5d                   	pop    %ebp
    1dc5:	0c 00                	or     $0x0,%al
    1dc7:	00 40 00             	add    %al,0x0(%eax)
    1dca:	00 00                	add    %al,(%eax)
    1dcc:	00 00                	add    %al,(%eax)
    1dce:	00 00                	add    %al,(%eax)
    1dd0:	68 0c 00 00 40       	push   $0x4000000c
    1dd5:	00 00                	add    %al,(%eax)
    1dd7:	00 02                	add    %al,(%edx)
    1dd9:	00 00                	add    %al,(%eax)
    1ddb:	00 75 0c             	add    %dh,0xc(%ebp)
    1dde:	00 00                	add    %al,(%eax)
    1de0:	40                   	inc    %eax
    1de1:	00 00                	add    %al,(%eax)
    1de3:	00 03                	add    %al,(%ebx)
    1de5:	00 00                	add    %al,(%eax)
    1de7:	00 81 0c 00 00 40    	add    %al,0x4000000c(%ecx)
    1ded:	00 00                	add    %al,(%eax)
    1def:	00 07                	add    %al,(%edi)
    1df1:	00 00                	add    %al,(%eax)
    1df3:	00 8f 0c 00 00 24    	add    %cl,0x2400000c(%edi)
    1df9:	00 00                	add    %al,(%eax)
    1dfb:	00 6c 08 28          	add    %ch,0x28(%eax,%ecx,1)
    1dff:	00 9e 0c 00 00 a0    	add    %bl,-0x5ffffff4(%esi)
    1e05:	00 00                	add    %al,(%eax)
    1e07:	00 08                	add    %cl,(%eax)
    1e09:	00 00                	add    %al,(%eax)
    1e0b:	00 b0 0c 00 00 a0    	add    %dh,-0x5ffffff4(%eax)
    1e11:	00 00                	add    %al,(%eax)
    1e13:	00 0c 00             	add    %cl,(%eax,%eax,1)
    1e16:	00 00                	add    %al,(%eax)
    1e18:	be 0c 00 00 a0       	mov    $0xa000000c,%esi
    1e1d:	00 00                	add    %al,(%eax)
    1e1f:	00 10                	add    %dl,(%eax)
    1e21:	00 00                	add    %al,(%eax)
    1e23:	00 4f 0c             	add    %cl,0xc(%edi)
    1e26:	00 00                	add    %al,(%eax)
    1e28:	a0 00 00 00 14       	mov    0x14000000,%al
    1e2d:	00 00                	add    %al,(%eax)
    1e2f:	00 00                	add    %al,(%eax)
    1e31:	00 00                	add    %al,(%eax)
    1e33:	00 44 00 17          	add    %al,0x17(%eax,%eax,1)
	...
    1e3f:	00 44 00 17          	add    %al,0x17(%eax,%eax,1)
    1e43:	00 03                	add    %al,(%ebx)
    1e45:	00 00                	add    %al,(%eax)
    1e47:	00 00                	add    %al,(%eax)
    1e49:	00 00                	add    %al,(%eax)
    1e4b:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    1e4f:	00 0c 00             	add    %cl,(%eax,%eax,1)
    1e52:	00 00                	add    %al,(%eax)
    1e54:	00 00                	add    %al,(%eax)
    1e56:	00 00                	add    %al,(%eax)
    1e58:	44                   	inc    %esp
    1e59:	00 1a                	add    %bl,(%edx)
    1e5b:	00 0f                	add    %cl,(%edi)
    1e5d:	00 00                	add    %al,(%eax)
    1e5f:	00 00                	add    %al,(%eax)
    1e61:	00 00                	add    %al,(%eax)
    1e63:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
    1e67:	00 16                	add    %dl,(%esi)
    1e69:	00 00                	add    %al,(%eax)
    1e6b:	00 00                	add    %al,(%eax)
    1e6d:	00 00                	add    %al,(%eax)
    1e6f:	00 44 00 20          	add    %al,0x20(%eax,%eax,1)
    1e73:	00 19                	add    %bl,(%ecx)
    1e75:	00 00                	add    %al,(%eax)
    1e77:	00 00                	add    %al,(%eax)
    1e79:	00 00                	add    %al,(%eax)
    1e7b:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
    1e7f:	00 1c 00             	add    %bl,(%eax,%eax,1)
    1e82:	00 00                	add    %al,(%eax)
    1e84:	00 00                	add    %al,(%eax)
    1e86:	00 00                	add    %al,(%eax)
    1e88:	44                   	inc    %esp
    1e89:	00 1f                	add    %bl,(%edi)
    1e8b:	00 20                	add    %ah,(%eax)
    1e8d:	00 00                	add    %al,(%eax)
    1e8f:	00 00                	add    %al,(%eax)
    1e91:	00 00                	add    %al,(%eax)
    1e93:	00 44 00 23          	add    %al,0x23(%eax,%eax,1)
    1e97:	00 28                	add    %ch,(%eax)
    1e99:	00 00                	add    %al,(%eax)
    1e9b:	00 ce                	add    %cl,%dh
    1e9d:	0c 00                	or     $0x0,%al
    1e9f:	00 40 00             	add    %al,0x0(%eax)
    1ea2:	00 00                	add    %al,(%eax)
    1ea4:	00 00                	add    %al,(%eax)
    1ea6:	00 00                	add    %al,(%eax)
    1ea8:	d9 0c 00             	(bad)  (%eax,%eax,1)
    1eab:	00 40 00             	add    %al,0x0(%eax)
    1eae:	00 00                	add    %al,(%eax)
    1eb0:	01 00                	add    %eax,(%eax)
    1eb2:	00 00                	add    %al,(%eax)
    1eb4:	e7 0c                	out    %eax,$0xc
    1eb6:	00 00                	add    %al,(%eax)
    1eb8:	40                   	inc    %eax
    1eb9:	00 00                	add    %al,(%eax)
    1ebb:	00 01                	add    %al,(%ecx)
    1ebd:	00 00                	add    %al,(%eax)
    1ebf:	00 81 0c 00 00 40    	add    %al,0x4000000c(%ecx)
    1ec5:	00 00                	add    %al,(%eax)
    1ec7:	00 02                	add    %al,(%edx)
    1ec9:	00 00                	add    %al,(%eax)
    1ecb:	00 f7                	add    %dh,%bh
    1ecd:	0c 00                	or     $0x0,%al
    1ecf:	00 24 00             	add    %ah,(%eax,%eax,1)
    1ed2:	00 00                	add    %al,(%eax)
    1ed4:	96                   	xchg   %eax,%esi
    1ed5:	08 28                	or     %ch,(%eax)
    1ed7:	00 00                	add    %al,(%eax)
    1ed9:	00 00                	add    %al,(%eax)
    1edb:	00 44 00 28          	add    %al,0x28(%eax,%eax,1)
	...
    1ee7:	00 44 00 28          	add    %al,0x28(%eax,%eax,1)
    1eeb:	00 05 00 00 00 00    	add    %al,0x0
    1ef1:	00 00                	add    %al,(%eax)
    1ef3:	00 44 00 2e          	add    %al,0x2e(%eax,%eax,1)
    1ef7:	00 0a                	add    %cl,(%edx)
    1ef9:	00 00                	add    %al,(%eax)
    1efb:	00 00                	add    %al,(%eax)
    1efd:	00 00                	add    %al,(%eax)
    1eff:	00 44 00 2c          	add    %al,0x2c(%eax,%eax,1)
    1f03:	00 19                	add    %bl,(%ecx)
    1f05:	00 00                	add    %al,(%eax)
    1f07:	00 00                	add    %al,(%eax)
    1f09:	00 00                	add    %al,(%eax)
    1f0b:	00 44 00 30          	add    %al,0x30(%eax,%eax,1)
    1f0f:	00 24 00             	add    %ah,(%eax,%eax,1)
    1f12:	00 00                	add    %al,(%eax)
    1f14:	00 00                	add    %al,(%eax)
    1f16:	00 00                	add    %al,(%eax)
    1f18:	44                   	inc    %esp
    1f19:	00 31                	add    %dh,(%ecx)
    1f1b:	00 37                	add    %dh,(%edi)
    1f1d:	00 00                	add    %al,(%eax)
    1f1f:	00 00                	add    %al,(%eax)
    1f21:	00 00                	add    %al,(%eax)
    1f23:	00 44 00 32          	add    %al,0x32(%eax,%eax,1)
    1f27:	00 4d 00             	add    %cl,0x0(%ebp)
    1f2a:	00 00                	add    %al,(%eax)
    1f2c:	00 00                	add    %al,(%eax)
    1f2e:	00 00                	add    %al,(%eax)
    1f30:	44                   	inc    %esp
    1f31:	00 34 00             	add    %dh,(%eax,%eax,1)
    1f34:	69 00 00 00 00 00    	imul   $0x0,(%eax),%eax
    1f3a:	00 00                	add    %al,(%eax)
    1f3c:	44                   	inc    %esp
    1f3d:	00 19                	add    %bl,(%ecx)
    1f3f:	00 7f 00             	add    %bh,0x0(%edi)
    1f42:	00 00                	add    %al,(%eax)
    1f44:	00 00                	add    %al,(%eax)
    1f46:	00 00                	add    %al,(%eax)
    1f48:	44                   	inc    %esp
    1f49:	00 1a                	add    %bl,(%edx)
    1f4b:	00 8b 00 00 00 00    	add    %cl,0x0(%ebx)
    1f51:	00 00                	add    %al,(%eax)
    1f53:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
    1f57:	00 94 00 00 00 00 00 	add    %dl,0x0(%eax,%eax,1)
    1f5e:	00 00                	add    %al,(%eax)
    1f60:	44                   	inc    %esp
    1f61:	00 1f                	add    %bl,(%edi)
    1f63:	00 9d 00 00 00 00    	add    %bl,0x0(%ebp)
    1f69:	00 00                	add    %al,(%eax)
    1f6b:	00 44 00 20          	add    %al,0x20(%eax,%eax,1)
    1f6f:	00 a4 00 00 00 00 00 	add    %ah,0x0(%eax,%eax,1)
    1f76:	00 00                	add    %al,(%eax)
    1f78:	44                   	inc    %esp
    1f79:	00 36                	add    %dh,(%esi)
    1f7b:	00 ab 00 00 00 00    	add    %ch,0x0(%ebx)
    1f81:	00 00                	add    %al,(%eax)
    1f83:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
    1f87:	00 b2 00 00 00 00    	add    %dh,0x0(%edx)
    1f8d:	00 00                	add    %al,(%eax)
    1f8f:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    1f93:	00 bd 00 00 00 00    	add    %bh,0x0(%ebp)
    1f99:	00 00                	add    %al,(%eax)
    1f9b:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    1f9f:	00 c2                	add    %al,%dl
    1fa1:	00 00                	add    %al,(%eax)
    1fa3:	00 00                	add    %al,(%eax)
    1fa5:	00 00                	add    %al,(%eax)
    1fa7:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
    1fab:	00 cc                	add    %cl,%ah
    1fad:	00 00                	add    %al,(%eax)
    1faf:	00 00                	add    %al,(%eax)
    1fb1:	00 00                	add    %al,(%eax)
    1fb3:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
    1fb7:	00 d3                	add    %dl,%bl
    1fb9:	00 00                	add    %al,(%eax)
    1fbb:	00 00                	add    %al,(%eax)
    1fbd:	00 00                	add    %al,(%eax)
    1fbf:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
    1fc3:	00 dc                	add    %bl,%ah
    1fc5:	00 00                	add    %al,(%eax)
    1fc7:	00 00                	add    %al,(%eax)
    1fc9:	00 00                	add    %al,(%eax)
    1fcb:	00 44 00 20          	add    %al,0x20(%eax,%eax,1)
    1fcf:	00 e3                	add    %ah,%bl
    1fd1:	00 00                	add    %al,(%eax)
    1fd3:	00 00                	add    %al,(%eax)
    1fd5:	00 00                	add    %al,(%eax)
    1fd7:	00 44 00 3b          	add    %al,0x3b(%eax,%eax,1)
    1fdb:	00 ea                	add    %ch,%dl
    1fdd:	00 00                	add    %al,(%eax)
    1fdf:	00 00                	add    %al,(%eax)
    1fe1:	00 00                	add    %al,(%eax)
    1fe3:	00 44 00 40          	add    %al,0x40(%eax,%eax,1)
    1fe7:	00 f1                	add    %dh,%cl
    1fe9:	00 00                	add    %al,(%eax)
    1feb:	00 00                	add    %al,(%eax)
    1fed:	00 00                	add    %al,(%eax)
    1fef:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    1ff3:	00 f6                	add    %dh,%dh
    1ff5:	00 00                	add    %al,(%eax)
    1ff7:	00 00                	add    %al,(%eax)
    1ff9:	00 00                	add    %al,(%eax)
    1ffb:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
    1fff:	00 fc                	add    %bh,%ah
    2001:	00 00                	add    %al,(%eax)
    2003:	00 00                	add    %al,(%eax)
    2005:	00 00                	add    %al,(%eax)
    2007:	00 44 00 41          	add    %al,0x41(%eax,%eax,1)
    200b:	00 05 01 00 00 00    	add    %al,0x1
    2011:	00 00                	add    %al,(%eax)
    2013:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    2017:	00 0a                	add    %cl,(%edx)
    2019:	01 00                	add    %eax,(%eax)
    201b:	00 00                	add    %al,(%eax)
    201d:	00 00                	add    %al,(%eax)
    201f:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
    2023:	00 10                	add    %dl,(%eax)
    2025:	01 00                	add    %eax,(%eax)
    2027:	00 00                	add    %al,(%eax)
    2029:	00 00                	add    %al,(%eax)
    202b:	00 44 00 42          	add    %al,0x42(%eax,%eax,1)
    202f:	00 19                	add    %bl,(%ecx)
    2031:	01 00                	add    %eax,(%eax)
    2033:	00 00                	add    %al,(%eax)
    2035:	00 00                	add    %al,(%eax)
    2037:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    203b:	00 1e                	add    %bl,(%esi)
    203d:	01 00                	add    %eax,(%eax)
    203f:	00 00                	add    %al,(%eax)
    2041:	00 00                	add    %al,(%eax)
    2043:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
    2047:	00 24 01             	add    %ah,(%ecx,%eax,1)
    204a:	00 00                	add    %al,(%eax)
    204c:	00 00                	add    %al,(%eax)
    204e:	00 00                	add    %al,(%eax)
    2050:	44                   	inc    %esp
    2051:	00 1d 00 2d 01 00    	add    %bl,0x12d00
    2057:	00 00                	add    %al,(%eax)
    2059:	00 00                	add    %al,(%eax)
    205b:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
    205f:	00 36                	add    %dh,(%esi)
    2061:	01 00                	add    %eax,(%eax)
    2063:	00 00                	add    %al,(%eax)
    2065:	00 00                	add    %al,(%eax)
    2067:	00 44 00 20          	add    %al,0x20(%eax,%eax,1)
    206b:	00 3d 01 00 00 00    	add    %bh,0x1
    2071:	00 00                	add    %al,(%eax)
    2073:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
    2077:	00 44 01 00          	add    %al,0x0(%ecx,%eax,1)
    207b:	00 00                	add    %al,(%eax)
    207d:	00 00                	add    %al,(%eax)
    207f:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
    2083:	00 4d 01             	add    %cl,0x1(%ebp)
    2086:	00 00                	add    %al,(%eax)
    2088:	00 00                	add    %al,(%eax)
    208a:	00 00                	add    %al,(%eax)
    208c:	44                   	inc    %esp
    208d:	00 20                	add    %ah,(%eax)
    208f:	00 54 01 00          	add    %dl,0x0(%ecx,%eax,1)
    2093:	00 00                	add    %al,(%eax)
    2095:	00 00                	add    %al,(%eax)
    2097:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
    209b:	00 5b 01             	add    %bl,0x1(%ebx)
    209e:	00 00                	add    %al,(%eax)
    20a0:	00 00                	add    %al,(%eax)
    20a2:	00 00                	add    %al,(%eax)
    20a4:	44                   	inc    %esp
    20a5:	00 1f                	add    %bl,(%edi)
    20a7:	00 64 01 00          	add    %ah,0x0(%ecx,%eax,1)
    20ab:	00 00                	add    %al,(%eax)
    20ad:	00 00                	add    %al,(%eax)
    20af:	00 44 00 20          	add    %al,0x20(%eax,%eax,1)
    20b3:	00 6b 01             	add    %ch,0x1(%ebx)
    20b6:	00 00                	add    %al,(%eax)
    20b8:	00 00                	add    %al,(%eax)
    20ba:	00 00                	add    %al,(%eax)
    20bc:	44                   	inc    %esp
    20bd:	00 43 00             	add    %al,0x0(%ebx)
    20c0:	72 01                	jb     20c3 <wait_KBC_sendready-0x27df3d>
    20c2:	00 00                	add    %al,(%eax)
    20c4:	00 00                	add    %al,(%eax)
    20c6:	00 00                	add    %al,(%eax)
    20c8:	44                   	inc    %esp
    20c9:	00 47 00             	add    %al,0x0(%edi)
    20cc:	86 01                	xchg   %al,(%ecx)
    20ce:	00 00                	add    %al,(%eax)
    20d0:	00 00                	add    %al,(%eax)
    20d2:	00 00                	add    %al,(%eax)
    20d4:	64 00 00             	add    %al,%fs:(%eax)
    20d7:	00 21                	add    %ah,(%ecx)
    20d9:	0a 28                	or     (%eax),%ch
    20db:	00 0b                	add    %cl,(%ebx)
    20dd:	0d 00 00 64 00       	or     $0x640000,%eax
    20e2:	02 00                	add    (%eax),%al
    20e4:	24 0a                	and    $0xa,%al
    20e6:	28 00                	sub    %al,(%eax)
    20e8:	08 00                	or     %al,(%eax)
    20ea:	00 00                	add    %al,(%eax)
    20ec:	3c 00                	cmp    $0x0,%al
    20ee:	00 00                	add    %al,(%eax)
    20f0:	00 00                	add    %al,(%eax)
    20f2:	00 00                	add    %al,(%eax)
    20f4:	17                   	pop    %ss
    20f5:	00 00                	add    %al,(%eax)
    20f7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    20fd:	00 00                	add    %al,(%eax)
    20ff:	00 41 00             	add    %al,0x0(%ecx)
    2102:	00 00                	add    %al,(%eax)
    2104:	80 00 00             	addb   $0x0,(%eax)
    2107:	00 00                	add    %al,(%eax)
    2109:	00 00                	add    %al,(%eax)
    210b:	00 5b 00             	add    %bl,0x0(%ebx)
    210e:	00 00                	add    %al,(%eax)
    2110:	80 00 00             	addb   $0x0,(%eax)
    2113:	00 00                	add    %al,(%eax)
    2115:	00 00                	add    %al,(%eax)
    2117:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
    211d:	00 00                	add    %al,(%eax)
    211f:	00 00                	add    %al,(%eax)
    2121:	00 00                	add    %al,(%eax)
    2123:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
    2129:	00 00                	add    %al,(%eax)
    212b:	00 00                	add    %al,(%eax)
    212d:	00 00                	add    %al,(%eax)
    212f:	00 e1                	add    %ah,%cl
    2131:	00 00                	add    %al,(%eax)
    2133:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2139:	00 00                	add    %al,(%eax)
    213b:	00 0c 01             	add    %cl,(%ecx,%eax,1)
    213e:	00 00                	add    %al,(%eax)
    2140:	80 00 00             	addb   $0x0,(%eax)
    2143:	00 00                	add    %al,(%eax)
    2145:	00 00                	add    %al,(%eax)
    2147:	00 37                	add    %dh,(%edi)
    2149:	01 00                	add    %eax,(%eax)
    214b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2151:	00 00                	add    %al,(%eax)
    2153:	00 5d 01             	add    %bl,0x1(%ebp)
    2156:	00 00                	add    %al,(%eax)
    2158:	80 00 00             	addb   $0x0,(%eax)
    215b:	00 00                	add    %al,(%eax)
    215d:	00 00                	add    %al,(%eax)
    215f:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
    2165:	00 00                	add    %al,(%eax)
    2167:	00 00                	add    %al,(%eax)
    2169:	00 00                	add    %al,(%eax)
    216b:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
    2171:	00 00                	add    %al,(%eax)
    2173:	00 00                	add    %al,(%eax)
    2175:	00 00                	add    %al,(%eax)
    2177:	00 d2                	add    %dl,%dl
    2179:	01 00                	add    %eax,(%eax)
    217b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2181:	00 00                	add    %al,(%eax)
    2183:	00 ec                	add    %ch,%ah
    2185:	01 00                	add    %eax,(%eax)
    2187:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    218d:	00 00                	add    %al,(%eax)
    218f:	00 07                	add    %al,(%edi)
    2191:	02 00                	add    (%eax),%al
    2193:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2199:	00 00                	add    %al,(%eax)
    219b:	00 28                	add    %ch,(%eax)
    219d:	02 00                	add    (%eax),%al
    219f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    21a5:	00 00                	add    %al,(%eax)
    21a7:	00 47 02             	add    %al,0x2(%edi)
    21aa:	00 00                	add    %al,(%eax)
    21ac:	80 00 00             	addb   $0x0,(%eax)
    21af:	00 00                	add    %al,(%eax)
    21b1:	00 00                	add    %al,(%eax)
    21b3:	00 66 02             	add    %ah,0x2(%esi)
    21b6:	00 00                	add    %al,(%eax)
    21b8:	80 00 00             	addb   $0x0,(%eax)
    21bb:	00 00                	add    %al,(%eax)
    21bd:	00 00                	add    %al,(%eax)
    21bf:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
    21c5:	00 00                	add    %al,(%eax)
    21c7:	00 00                	add    %al,(%eax)
    21c9:	00 00                	add    %al,(%eax)
    21cb:	00 9b 02 00 00 c2    	add    %bl,-0x3dfffffe(%ebx)
    21d1:	00 00                	add    %al,(%eax)
    21d3:	00 d4                	add    %dl,%ah
    21d5:	8c 00                	mov    %es,(%eax)
    21d7:	00 a4 02 00 00 c2 00 	add    %ah,0xc20000(%edx,%eax,1)
    21de:	00 00                	add    %al,(%eax)
    21e0:	00 00                	add    %al,(%eax)
    21e2:	00 00                	add    %al,(%eax)
    21e4:	aa                   	stos   %al,%es:(%edi)
    21e5:	02 00                	add    (%eax),%al
    21e7:	00 c2                	add    %al,%dl
    21e9:	00 00                	add    %al,(%eax)
    21eb:	00 37                	add    %dh,(%edi)
    21ed:	53                   	push   %ebx
    21ee:	00 00                	add    %al,(%eax)
    21f0:	11 0d 00 00 24 00    	adc    %ecx,0x240000
    21f6:	00 00                	add    %al,(%eax)
    21f8:	24 0a                	and    $0xa,%al
    21fa:	28 00                	sub    %al,(%eax)
    21fc:	00 00                	add    %al,(%eax)
    21fe:	00 00                	add    %al,(%eax)
    2200:	44                   	inc    %esp
    2201:	00 05 00 00 00 00    	add    %al,0x0
    2207:	00 a4 02 00 00 84 00 	add    %ah,0x840000(%edx,%eax,1)
    220e:	00 00                	add    %al,(%eax)
    2210:	25 0a 28 00 00       	and    $0x280a,%eax
    2215:	00 00                	add    %al,(%eax)
    2217:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    221b:	00 01                	add    %al,(%ecx)
    221d:	00 00                	add    %al,(%eax)
    221f:	00 0b                	add    %cl,(%ebx)
    2221:	0d 00 00 84 00       	or     $0x840000,%eax
    2226:	00 00                	add    %al,(%eax)
    2228:	2a 0a                	sub    (%edx),%cl
    222a:	28 00                	sub    %al,(%eax)
    222c:	00 00                	add    %al,(%eax)
    222e:	00 00                	add    %al,(%eax)
    2230:	44                   	inc    %esp
    2231:	00 05 00 06 00 00    	add    %al,0x600
    2237:	00 a4 02 00 00 84 00 	add    %ah,0x840000(%edx,%eax,1)
    223e:	00 00                	add    %al,(%eax)
    2240:	2c 0a                	sub    $0xa,%al
    2242:	28 00                	sub    %al,(%eax)
    2244:	00 00                	add    %al,(%eax)
    2246:	00 00                	add    %al,(%eax)
    2248:	44                   	inc    %esp
    2249:	00 5c 00 08          	add    %bl,0x8(%eax,%eax,1)
    224d:	00 00                	add    %al,(%eax)
    224f:	00 0b                	add    %cl,(%ebx)
    2251:	0d 00 00 84 00       	or     $0x840000,%eax
    2256:	00 00                	add    %al,(%eax)
    2258:	5c                   	pop    %esp
    2259:	0a 28                	or     (%eax),%ch
    225b:	00 00                	add    %al,(%eax)
    225d:	00 00                	add    %al,(%eax)
    225f:	00 44 00 4a          	add    %al,0x4a(%eax,%eax,1)
    2263:	00 38                	add    %bh,(%eax)
    2265:	00 00                	add    %al,(%eax)
    2267:	00 22                	add    %ah,(%edx)
    2269:	0d 00 00 24 00       	or     $0x240000,%eax
    226e:	00 00                	add    %al,(%eax)
    2270:	5e                   	pop    %esi
    2271:	0a 28                	or     (%eax),%ch
    2273:	00 37                	add    %dh,(%edi)
    2275:	0d 00 00 a0 00       	or     $0xa00000,%eax
    227a:	00 00                	add    %al,(%eax)
    227c:	08 00                	or     %al,(%eax)
    227e:	00 00                	add    %al,(%eax)
    2280:	00 00                	add    %al,(%eax)
    2282:	00 00                	add    %al,(%eax)
    2284:	44                   	inc    %esp
    2285:	00 51 00             	add    %dl,0x0(%ecx)
    2288:	00 00                	add    %al,(%eax)
    228a:	00 00                	add    %al,(%eax)
    228c:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    228d:	02 00                	add    (%eax),%al
    228f:	00 84 00 00 00 5f 0a 	add    %al,0xa5f0000(%eax,%eax,1)
    2296:	28 00                	sub    %al,(%eax)
    2298:	00 00                	add    %al,(%eax)
    229a:	00 00                	add    %al,(%eax)
    229c:	44                   	inc    %esp
    229d:	00 5c 00 01          	add    %bl,0x1(%eax,%eax,1)
    22a1:	00 00                	add    %al,(%eax)
    22a3:	00 0b                	add    %cl,(%ebx)
    22a5:	0d 00 00 84 00       	or     $0x840000,%eax
    22aa:	00 00                	add    %al,(%eax)
    22ac:	64 0a 28             	or     %fs:(%eax),%ch
    22af:	00 00                	add    %al,(%eax)
    22b1:	00 00                	add    %al,(%eax)
    22b3:	00 44 00 51          	add    %al,0x51(%eax,%eax,1)
    22b7:	00 06                	add    %al,(%esi)
    22b9:	00 00                	add    %al,(%eax)
    22bb:	00 a4 02 00 00 84 00 	add    %ah,0x840000(%edx,%eax,1)
    22c2:	00 00                	add    %al,(%eax)
    22c4:	66                   	data16
    22c5:	0a 28                	or     (%eax),%ch
    22c7:	00 00                	add    %al,(%eax)
    22c9:	00 00                	add    %al,(%eax)
    22cb:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    22cf:	00 08                	add    %cl,(%eax)
    22d1:	00 00                	add    %al,(%eax)
    22d3:	00 0b                	add    %cl,(%ebx)
    22d5:	0d 00 00 84 00       	or     $0x840000,%eax
    22da:	00 00                	add    %al,(%eax)
    22dc:	68 0a 28 00 00       	push   $0x280a
    22e1:	00 00                	add    %al,(%eax)
    22e3:	00 44 00 51          	add    %al,0x51(%eax,%eax,1)
    22e7:	00 0a                	add    %cl,(%edx)
    22e9:	00 00                	add    %al,(%eax)
    22eb:	00 a4 02 00 00 84 00 	add    %ah,0x840000(%edx,%eax,1)
    22f2:	00 00                	add    %al,(%eax)
    22f4:	6b 0a 28             	imul   $0x28,(%edx),%ecx
    22f7:	00 00                	add    %al,(%eax)
    22f9:	00 00                	add    %al,(%eax)
    22fb:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    22ff:	00 0d 00 00 00 00    	add    %cl,0x0
    2305:	00 00                	add    %al,(%eax)
    2307:	00 44 00 42          	add    %al,0x42(%eax,%eax,1)
    230b:	00 0e                	add    %cl,(%esi)
    230d:	00 00                	add    %al,(%eax)
    230f:	00 0b                	add    %cl,(%ebx)
    2311:	0d 00 00 84 00       	or     $0x840000,%eax
    2316:	00 00                	add    %al,(%eax)
    2318:	6f                   	outsl  %ds:(%esi),(%dx)
    2319:	0a 28                	or     (%eax),%ch
    231b:	00 00                	add    %al,(%eax)
    231d:	00 00                	add    %al,(%eax)
    231f:	00 44 00 55          	add    %al,0x55(%eax,%eax,1)
    2323:	00 11                	add    %dl,(%ecx)
    2325:	00 00                	add    %al,(%eax)
    2327:	00 00                	add    %al,(%eax)
    2329:	00 00                	add    %al,(%eax)
    232b:	00 44 00 57          	add    %al,0x57(%eax,%eax,1)
    232f:	00 22                	add    %ah,(%edx)
    2331:	00 00                	add    %al,(%eax)
    2333:	00 4a 0d             	add    %cl,0xd(%edx)
    2336:	00 00                	add    %al,(%eax)
    2338:	24 00                	and    $0x0,%al
    233a:	00 00                	add    %al,(%eax)
    233c:	82                   	(bad)  
    233d:	0a 28                	or     (%eax),%ch
    233f:	00 5f 0d             	add    %bl,0xd(%edi)
    2342:	00 00                	add    %al,(%eax)
    2344:	a0 00 00 00 08       	mov    0x8000000,%al
    2349:	00 00                	add    %al,(%eax)
    234b:	00 00                	add    %al,(%eax)
    234d:	00 00                	add    %al,(%eax)
    234f:	00 44 00 5b          	add    %al,0x5b(%eax,%eax,1)
    2353:	00 00                	add    %al,(%eax)
    2355:	00 00                	add    %al,(%eax)
    2357:	00 a4 02 00 00 84 00 	add    %ah,0x840000(%edx,%eax,1)
    235e:	00 00                	add    %al,(%eax)
    2360:	83 0a 28             	orl    $0x28,(%edx)
    2363:	00 00                	add    %al,(%eax)
    2365:	00 00                	add    %al,(%eax)
    2367:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    236b:	00 01                	add    %al,(%ecx)
    236d:	00 00                	add    %al,(%eax)
    236f:	00 0b                	add    %cl,(%ebx)
    2371:	0d 00 00 84 00       	or     $0x840000,%eax
    2376:	00 00                	add    %al,(%eax)
    2378:	88 0a                	mov    %cl,(%edx)
    237a:	28 00                	sub    %al,(%eax)
    237c:	00 00                	add    %al,(%eax)
    237e:	00 00                	add    %al,(%eax)
    2380:	44                   	inc    %esp
    2381:	00 5b 00             	add    %bl,0x0(%ebx)
    2384:	06                   	push   %es
    2385:	00 00                	add    %al,(%eax)
    2387:	00 a4 02 00 00 84 00 	add    %ah,0x840000(%edx,%eax,1)
    238e:	00 00                	add    %al,(%eax)
    2390:	8a 0a                	mov    (%edx),%cl
    2392:	28 00                	sub    %al,(%eax)
    2394:	00 00                	add    %al,(%eax)
    2396:	00 00                	add    %al,(%eax)
    2398:	44                   	inc    %esp
    2399:	00 5c 00 08          	add    %bl,0x8(%eax,%eax,1)
    239d:	00 00                	add    %al,(%eax)
    239f:	00 0b                	add    %cl,(%ebx)
    23a1:	0d 00 00 84 00       	or     $0x840000,%eax
    23a6:	00 00                	add    %al,(%eax)
    23a8:	8c 0a                	mov    %cs,(%edx)
    23aa:	28 00                	sub    %al,(%eax)
    23ac:	00 00                	add    %al,(%eax)
    23ae:	00 00                	add    %al,(%eax)
    23b0:	44                   	inc    %esp
    23b1:	00 5b 00             	add    %bl,0x0(%ebx)
    23b4:	0a 00                	or     (%eax),%al
    23b6:	00 00                	add    %al,(%eax)
    23b8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    23b9:	02 00                	add    (%eax),%al
    23bb:	00 84 00 00 00 8f 0a 	add    %al,0xa8f0000(%eax,%eax,1)
    23c2:	28 00                	sub    %al,(%eax)
    23c4:	00 00                	add    %al,(%eax)
    23c6:	00 00                	add    %al,(%eax)
    23c8:	44                   	inc    %esp
    23c9:	00 5c 00 0d          	add    %bl,0xd(%eax,%eax,1)
    23cd:	00 00                	add    %al,(%eax)
    23cf:	00 00                	add    %al,(%eax)
    23d1:	00 00                	add    %al,(%eax)
    23d3:	00 44 00 42          	add    %al,0x42(%eax,%eax,1)
    23d7:	00 13                	add    %dl,(%ebx)
    23d9:	00 00                	add    %al,(%eax)
    23db:	00 0b                	add    %cl,(%ebx)
    23dd:	0d 00 00 84 00       	or     $0x840000,%eax
    23e2:	00 00                	add    %al,(%eax)
    23e4:	98                   	cwtl   
    23e5:	0a 28                	or     (%eax),%ch
    23e7:	00 00                	add    %al,(%eax)
    23e9:	00 00                	add    %al,(%eax)
    23eb:	00 44 00 60          	add    %al,0x60(%eax,%eax,1)
    23ef:	00 16                	add    %dl,(%esi)
    23f1:	00 00                	add    %al,(%eax)
    23f3:	00 00                	add    %al,(%eax)
    23f5:	00 00                	add    %al,(%eax)
    23f7:	00 44 00 62          	add    %al,0x62(%eax,%eax,1)
    23fb:	00 27                	add    %ah,(%edi)
    23fd:	00 00                	add    %al,(%eax)
    23ff:	00 6b 0d             	add    %ch,0xd(%ebx)
    2402:	00 00                	add    %al,(%eax)
    2404:	24 00                	and    $0x0,%al
    2406:	00 00                	add    %al,(%eax)
    2408:	ab                   	stos   %eax,%es:(%edi)
    2409:	0a 28                	or     (%eax),%ch
    240b:	00 5f 0d             	add    %bl,0xd(%edi)
    240e:	00 00                	add    %al,(%eax)
    2410:	a0 00 00 00 08       	mov    0x8000000,%al
    2415:	00 00                	add    %al,(%eax)
    2417:	00 00                	add    %al,(%eax)
    2419:	00 00                	add    %al,(%eax)
    241b:	00 44 00 65          	add    %al,0x65(%eax,%eax,1)
    241f:	00 00                	add    %al,(%eax)
    2421:	00 00                	add    %al,(%eax)
    2423:	00 a4 02 00 00 84 00 	add    %ah,0x840000(%edx,%eax,1)
    242a:	00 00                	add    %al,(%eax)
    242c:	ac                   	lods   %ds:(%esi),%al
    242d:	0a 28                	or     (%eax),%ch
    242f:	00 00                	add    %al,(%eax)
    2431:	00 00                	add    %al,(%eax)
    2433:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    2437:	00 01                	add    %al,(%ecx)
    2439:	00 00                	add    %al,(%eax)
    243b:	00 0b                	add    %cl,(%ebx)
    243d:	0d 00 00 84 00       	or     $0x840000,%eax
    2442:	00 00                	add    %al,(%eax)
    2444:	b1 0a                	mov    $0xa,%cl
    2446:	28 00                	sub    %al,(%eax)
    2448:	00 00                	add    %al,(%eax)
    244a:	00 00                	add    %al,(%eax)
    244c:	44                   	inc    %esp
    244d:	00 65 00             	add    %ah,0x0(%ebp)
    2450:	06                   	push   %es
    2451:	00 00                	add    %al,(%eax)
    2453:	00 a4 02 00 00 84 00 	add    %ah,0x840000(%edx,%eax,1)
    245a:	00 00                	add    %al,(%eax)
    245c:	b3 0a                	mov    $0xa,%bl
    245e:	28 00                	sub    %al,(%eax)
    2460:	00 00                	add    %al,(%eax)
    2462:	00 00                	add    %al,(%eax)
    2464:	44                   	inc    %esp
    2465:	00 5c 00 08          	add    %bl,0x8(%eax,%eax,1)
    2469:	00 00                	add    %al,(%eax)
    246b:	00 0b                	add    %cl,(%ebx)
    246d:	0d 00 00 84 00       	or     $0x840000,%eax
    2472:	00 00                	add    %al,(%eax)
    2474:	b6 0a                	mov    $0xa,%dh
    2476:	28 00                	sub    %al,(%eax)
    2478:	00 00                	add    %al,(%eax)
    247a:	00 00                	add    %al,(%eax)
    247c:	44                   	inc    %esp
    247d:	00 68 00             	add    %ch,0x0(%eax)
    2480:	0b 00                	or     (%eax),%eax
    2482:	00 00                	add    %al,(%eax)
    2484:	80 0d 00 00 20 00 00 	orb    $0x0,0x200000
    248b:	00 00                	add    %al,(%eax)
    248d:	00 00                	add    %al,(%eax)
    248f:	00 8f 0d 00 00 20    	add    %cl,0x2000000d(%edi)
	...
    249d:	00 00                	add    %al,(%eax)
    249f:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
    24a3:	00 b8 0a 28 00 a0    	add    %bh,-0x5fffd7f6(%eax)
    24a9:	0d 00 00 64 00       	or     $0x640000,%eax
    24ae:	00 00                	add    %al,(%eax)
    24b0:	b8 0a 28 00 b0       	mov    $0xb000280a,%eax
    24b5:	0d 00 00 84 00       	or     $0x840000,%eax
    24ba:	00 00                	add    %al,(%eax)
    24bc:	b8 0a 28 00 00       	mov    $0x280a,%eax
    24c1:	00 00                	add    %al,(%eax)
    24c3:	00 44 00 09          	add    %al,0x9(%eax,%eax,1)
    24c7:	00 b8 0a 28 00 00    	add    %bh,0x280a(%eax)
    24cd:	00 00                	add    %al,(%eax)
    24cf:	00 44 00 0a          	add    %al,0xa(%eax,%eax,1)
    24d3:	00 ba 0a 28 00 00    	add    %bh,0x280a(%edx)
    24d9:	00 00                	add    %al,(%eax)
    24db:	00 44 00 0b          	add    %al,0xb(%eax,%eax,1)
    24df:	00 bc 0a 28 00 00 00 	add    %bh,0x28(%edx,%ecx,1)
    24e6:	00 00                	add    %al,(%eax)
    24e8:	44                   	inc    %esp
    24e9:	00 0c 00             	add    %cl,(%eax,%eax,1)
    24ec:	bd 0a 28 00 00       	mov    $0x280a,%ebp
    24f1:	00 00                	add    %al,(%eax)
    24f3:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    24f7:	00 bf 0a 28 00 00    	add    %bh,0x280a(%edi)
    24fd:	00 00                	add    %al,(%eax)
    24ff:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
    2503:	00 c0                	add    %al,%al
    2505:	0a 28                	or     (%eax),%ch
    2507:	00 00                	add    %al,(%eax)
    2509:	00 00                	add    %al,(%eax)
    250b:	00 44 00 0f          	add    %al,0xf(%eax,%eax,1)
    250f:	00 c3                	add    %al,%bl
    2511:	0a 28                	or     (%eax),%ch
    2513:	00 00                	add    %al,(%eax)
    2515:	00 00                	add    %al,(%eax)
    2517:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
    251b:	00 c5                	add    %al,%ch
    251d:	0a 28                	or     (%eax),%ch
    251f:	00 00                	add    %al,(%eax)
    2521:	00 00                	add    %al,(%eax)
    2523:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
    2527:	00 c7                	add    %al,%bh
    2529:	0a 28                	or     (%eax),%ch
    252b:	00 00                	add    %al,(%eax)
    252d:	00 00                	add    %al,(%eax)
    252f:	00 44 00 12          	add    %al,0x12(%eax,%eax,1)
    2533:	00 cc                	add    %cl,%ah
    2535:	0a 28                	or     (%eax),%ch
    2537:	00 00                	add    %al,(%eax)
    2539:	00 00                	add    %al,(%eax)
    253b:	00 44 00 13          	add    %al,0x13(%eax,%eax,1)
    253f:	00 cd                	add    %cl,%ch
    2541:	0a 28                	or     (%eax),%ch
    2543:	00 00                	add    %al,(%eax)
    2545:	00 00                	add    %al,(%eax)
    2547:	00 44 00 14          	add    %al,0x14(%eax,%eax,1)
    254b:	00 ce                	add    %cl,%dh
    254d:	0a 28                	or     (%eax),%ch
    254f:	00 00                	add    %al,(%eax)
    2551:	00 00                	add    %al,(%eax)
    2553:	00 44 00 15          	add    %al,0x15(%eax,%eax,1)
    2557:	00 d0                	add    %dl,%al
    2559:	0a 28                	or     (%eax),%ch
    255b:	00 00                	add    %al,(%eax)
    255d:	00 00                	add    %al,(%eax)
    255f:	00 44 00 16          	add    %al,0x16(%eax,%eax,1)
    2563:	00 d2                	add    %dl,%dl
    2565:	0a 28                	or     (%eax),%ch
    2567:	00 00                	add    %al,(%eax)
    2569:	00 00                	add    %al,(%eax)
    256b:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    256f:	00 d3                	add    %dl,%bl
    2571:	0a 28                	or     (%eax),%ch
    2573:	00 00                	add    %al,(%eax)
    2575:	00 00                	add    %al,(%eax)
    2577:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
    257b:	00 d5                	add    %dl,%ch
    257d:	0a 28                	or     (%eax),%ch
    257f:	00 00                	add    %al,(%eax)
    2581:	00 00                	add    %al,(%eax)
    2583:	00 44 00 1b          	add    %al,0x1b(%eax,%eax,1)
    2587:	00 d7                	add    %dl,%bh
    2589:	0a 28                	or     (%eax),%ch
    258b:	00 00                	add    %al,(%eax)
    258d:	00 00                	add    %al,(%eax)
    258f:	00 44 00 1c          	add    %al,0x1c(%eax,%eax,1)
    2593:	00 d8                	add    %bl,%al
    2595:	0a 28                	or     (%eax),%ch
    2597:	00 00                	add    %al,(%eax)
    2599:	00 00                	add    %al,(%eax)
    259b:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
    259f:	00 da                	add    %bl,%dl
    25a1:	0a 28                	or     (%eax),%ch
    25a3:	00 00                	add    %al,(%eax)
    25a5:	00 00                	add    %al,(%eax)
    25a7:	00 44 00 1e          	add    %al,0x1e(%eax,%eax,1)
    25ab:	00 db                	add    %bl,%bl
    25ad:	0a 28                	or     (%eax),%ch
    25af:	00 00                	add    %al,(%eax)
    25b1:	00 00                	add    %al,(%eax)
    25b3:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
    25b7:	00 de                	add    %bl,%dh
    25b9:	0a 28                	or     (%eax),%ch
    25bb:	00 00                	add    %al,(%eax)
    25bd:	00 00                	add    %al,(%eax)
    25bf:	00 44 00 20          	add    %al,0x20(%eax,%eax,1)
    25c3:	00 e0                	add    %ah,%al
    25c5:	0a 28                	or     (%eax),%ch
    25c7:	00 00                	add    %al,(%eax)
    25c9:	00 00                	add    %al,(%eax)
    25cb:	00 44 00 21          	add    %al,0x21(%eax,%eax,1)
    25cf:	00 e2                	add    %ah,%dl
    25d1:	0a 28                	or     (%eax),%ch
    25d3:	00 00                	add    %al,(%eax)
    25d5:	00 00                	add    %al,(%eax)
    25d7:	00 44 00 22          	add    %al,0x22(%eax,%eax,1)
    25db:	00 e7                	add    %ah,%bh
    25dd:	0a 28                	or     (%eax),%ch
    25df:	00 00                	add    %al,(%eax)
    25e1:	00 00                	add    %al,(%eax)
    25e3:	00 44 00 23          	add    %al,0x23(%eax,%eax,1)
    25e7:	00 e8                	add    %ch,%al
    25e9:	0a 28                	or     (%eax),%ch
    25eb:	00 00                	add    %al,(%eax)
    25ed:	00 00                	add    %al,(%eax)
    25ef:	00 44 00 24          	add    %al,0x24(%eax,%eax,1)
    25f3:	00 e9                	add    %ch,%cl
    25f5:	0a 28                	or     (%eax),%ch
    25f7:	00 00                	add    %al,(%eax)
    25f9:	00 00                	add    %al,(%eax)
    25fb:	00 44 00 25          	add    %al,0x25(%eax,%eax,1)
    25ff:	00 eb                	add    %ch,%bl
    2601:	0a 28                	or     (%eax),%ch
    2603:	00 00                	add    %al,(%eax)
    2605:	00 00                	add    %al,(%eax)
    2607:	00 44 00 26          	add    %al,0x26(%eax,%eax,1)
    260b:	00 ed                	add    %ch,%ch
    260d:	0a 28                	or     (%eax),%ch
    260f:	00 00                	add    %al,(%eax)
    2611:	00 00                	add    %al,(%eax)
    2613:	00 44 00 29          	add    %al,0x29(%eax,%eax,1)
    2617:	00 ee                	add    %ch,%dh
    2619:	0a 28                	or     (%eax),%ch
    261b:	00 00                	add    %al,(%eax)
    261d:	00 00                	add    %al,(%eax)
    261f:	00 44 00 2a          	add    %al,0x2a(%eax,%eax,1)
    2623:	00 f0                	add    %dh,%al
    2625:	0a 28                	or     (%eax),%ch
    2627:	00 00                	add    %al,(%eax)
    2629:	00 00                	add    %al,(%eax)
    262b:	00 44 00 2b          	add    %al,0x2b(%eax,%eax,1)
    262f:	00 f2                	add    %dh,%dl
    2631:	0a 28                	or     (%eax),%ch
    2633:	00 00                	add    %al,(%eax)
    2635:	00 00                	add    %al,(%eax)
    2637:	00 44 00 2c          	add    %al,0x2c(%eax,%eax,1)
    263b:	00 f3                	add    %dh,%bl
    263d:	0a 28                	or     (%eax),%ch
    263f:	00 00                	add    %al,(%eax)
    2641:	00 00                	add    %al,(%eax)
    2643:	00 44 00 2d          	add    %al,0x2d(%eax,%eax,1)
    2647:	00 f5                	add    %dh,%ch
    2649:	0a 28                	or     (%eax),%ch
    264b:	00 00                	add    %al,(%eax)
    264d:	00 00                	add    %al,(%eax)
    264f:	00 44 00 2e          	add    %al,0x2e(%eax,%eax,1)
    2653:	00 f6                	add    %dh,%dh
    2655:	0a 28                	or     (%eax),%ch
    2657:	00 00                	add    %al,(%eax)
    2659:	00 00                	add    %al,(%eax)
    265b:	00 44 00 2f          	add    %al,0x2f(%eax,%eax,1)
    265f:	00 f9                	add    %bh,%cl
    2661:	0a 28                	or     (%eax),%ch
    2663:	00 00                	add    %al,(%eax)
    2665:	00 00                	add    %al,(%eax)
    2667:	00 44 00 30          	add    %al,0x30(%eax,%eax,1)
    266b:	00 fb                	add    %bh,%bl
    266d:	0a 28                	or     (%eax),%ch
    266f:	00 00                	add    %al,(%eax)
    2671:	00 00                	add    %al,(%eax)
    2673:	00 44 00 31          	add    %al,0x31(%eax,%eax,1)
    2677:	00 fd                	add    %bh,%ch
    2679:	0a 28                	or     (%eax),%ch
    267b:	00 00                	add    %al,(%eax)
    267d:	00 00                	add    %al,(%eax)
    267f:	00 44 00 32          	add    %al,0x32(%eax,%eax,1)
    2683:	00 02                	add    %al,(%edx)
    2685:	0b 28                	or     (%eax),%ebp
    2687:	00 00                	add    %al,(%eax)
    2689:	00 00                	add    %al,(%eax)
    268b:	00 44 00 33          	add    %al,0x33(%eax,%eax,1)
    268f:	00 03                	add    %al,(%ebx)
    2691:	0b 28                	or     (%eax),%ebp
    2693:	00 00                	add    %al,(%eax)
    2695:	00 00                	add    %al,(%eax)
    2697:	00 44 00 34          	add    %al,0x34(%eax,%eax,1)
    269b:	00 04 0b             	add    %al,(%ebx,%ecx,1)
    269e:	28 00                	sub    %al,(%eax)
    26a0:	00 00                	add    %al,(%eax)
    26a2:	00 00                	add    %al,(%eax)
    26a4:	44                   	inc    %esp
    26a5:	00 35 00 06 0b 28    	add    %dh,0x280b0600
    26ab:	00 00                	add    %al,(%eax)
    26ad:	00 00                	add    %al,(%eax)
    26af:	00 44 00 36          	add    %al,0x36(%eax,%eax,1)
    26b3:	00 08                	add    %cl,(%eax)
    26b5:	0b 28                	or     (%eax),%ebp
    26b7:	00 00                	add    %al,(%eax)
    26b9:	00 00                	add    %al,(%eax)
    26bb:	00 44 00 39          	add    %al,0x39(%eax,%eax,1)
    26bf:	00 09                	add    %cl,(%ecx)
    26c1:	0b 28                	or     (%eax),%ebp
    26c3:	00 00                	add    %al,(%eax)
    26c5:	00 00                	add    %al,(%eax)
    26c7:	00 44 00 3a          	add    %al,0x3a(%eax,%eax,1)
    26cb:	00 0e                	add    %cl,(%esi)
    26cd:	0b 28                	or     (%eax),%ebp
    26cf:	00 00                	add    %al,(%eax)
    26d1:	00 00                	add    %al,(%eax)
    26d3:	00 44 00 3b          	add    %al,0x3b(%eax,%eax,1)
    26d7:	00 13                	add    %dl,(%ebx)
    26d9:	0b 28                	or     (%eax),%ebp
    26db:	00 00                	add    %al,(%eax)
    26dd:	00 00                	add    %al,(%eax)
    26df:	00 44 00 3c          	add    %al,0x3c(%eax,%eax,1)
    26e3:	00 18                	add    %bl,(%eax)
    26e5:	0b 28                	or     (%eax),%ebp
    26e7:	00 00                	add    %al,(%eax)
    26e9:	00 00                	add    %al,(%eax)
    26eb:	00 44 00 3f          	add    %al,0x3f(%eax,%eax,1)
    26ef:	00 19                	add    %bl,(%ecx)
    26f1:	0b 28                	or     (%eax),%ebp
    26f3:	00 00                	add    %al,(%eax)
    26f5:	00 00                	add    %al,(%eax)
    26f7:	00 44 00 40          	add    %al,0x40(%eax,%eax,1)
    26fb:	00 1e                	add    %bl,(%esi)
    26fd:	0b 28                	or     (%eax),%ebp
    26ff:	00 00                	add    %al,(%eax)
    2701:	00 00                	add    %al,(%eax)
    2703:	00 44 00 41          	add    %al,0x41(%eax,%eax,1)
    2707:	00 23                	add    %ah,(%ebx)
    2709:	0b 28                	or     (%eax),%ebp
    270b:	00 00                	add    %al,(%eax)
    270d:	00 00                	add    %al,(%eax)
    270f:	00 44 00 42          	add    %al,0x42(%eax,%eax,1)
    2713:	00 28                	add    %ch,(%eax)
    2715:	0b 28                	or     (%eax),%ebp
    2717:	00 00                	add    %al,(%eax)
    2719:	00 00                	add    %al,(%eax)
    271b:	00 44 00 45          	add    %al,0x45(%eax,%eax,1)
    271f:	00 29                	add    %ch,(%ecx)
    2721:	0b 28                	or     (%eax),%ebp
    2723:	00 00                	add    %al,(%eax)
    2725:	00 00                	add    %al,(%eax)
    2727:	00 44 00 46          	add    %al,0x46(%eax,%eax,1)
    272b:	00 2a                	add    %ch,(%edx)
    272d:	0b 28                	or     (%eax),%ebp
    272f:	00 00                	add    %al,(%eax)
    2731:	00 00                	add    %al,(%eax)
    2733:	00 44 00 47          	add    %al,0x47(%eax,%eax,1)
    2737:	00 2b                	add    %ch,(%ebx)
    2739:	0b 28                	or     (%eax),%ebp
    273b:	00 bb 0d 00 00 64    	add    %bh,0x6400000d(%ebx)
    2741:	00 02                	add    %al,(%edx)
    2743:	00 2c 0b             	add    %ch,(%ebx,%ecx,1)
    2746:	28 00                	sub    %al,(%eax)
    2748:	08 00                	or     %al,(%eax)
    274a:	00 00                	add    %al,(%eax)
    274c:	3c 00                	cmp    $0x0,%al
    274e:	00 00                	add    %al,(%eax)
    2750:	00 00                	add    %al,(%eax)
    2752:	00 00                	add    %al,(%eax)
    2754:	17                   	pop    %ss
    2755:	00 00                	add    %al,(%eax)
    2757:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    275d:	00 00                	add    %al,(%eax)
    275f:	00 41 00             	add    %al,0x0(%ecx)
    2762:	00 00                	add    %al,(%eax)
    2764:	80 00 00             	addb   $0x0,(%eax)
    2767:	00 00                	add    %al,(%eax)
    2769:	00 00                	add    %al,(%eax)
    276b:	00 5b 00             	add    %bl,0x0(%ebx)
    276e:	00 00                	add    %al,(%eax)
    2770:	80 00 00             	addb   $0x0,(%eax)
    2773:	00 00                	add    %al,(%eax)
    2775:	00 00                	add    %al,(%eax)
    2777:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
    277d:	00 00                	add    %al,(%eax)
    277f:	00 00                	add    %al,(%eax)
    2781:	00 00                	add    %al,(%eax)
    2783:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
    2789:	00 00                	add    %al,(%eax)
    278b:	00 00                	add    %al,(%eax)
    278d:	00 00                	add    %al,(%eax)
    278f:	00 e1                	add    %ah,%cl
    2791:	00 00                	add    %al,(%eax)
    2793:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2799:	00 00                	add    %al,(%eax)
    279b:	00 0c 01             	add    %cl,(%ecx,%eax,1)
    279e:	00 00                	add    %al,(%eax)
    27a0:	80 00 00             	addb   $0x0,(%eax)
    27a3:	00 00                	add    %al,(%eax)
    27a5:	00 00                	add    %al,(%eax)
    27a7:	00 37                	add    %dh,(%edi)
    27a9:	01 00                	add    %eax,(%eax)
    27ab:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    27b1:	00 00                	add    %al,(%eax)
    27b3:	00 5d 01             	add    %bl,0x1(%ebp)
    27b6:	00 00                	add    %al,(%eax)
    27b8:	80 00 00             	addb   $0x0,(%eax)
    27bb:	00 00                	add    %al,(%eax)
    27bd:	00 00                	add    %al,(%eax)
    27bf:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
    27c5:	00 00                	add    %al,(%eax)
    27c7:	00 00                	add    %al,(%eax)
    27c9:	00 00                	add    %al,(%eax)
    27cb:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
    27d1:	00 00                	add    %al,(%eax)
    27d3:	00 00                	add    %al,(%eax)
    27d5:	00 00                	add    %al,(%eax)
    27d7:	00 d2                	add    %dl,%dl
    27d9:	01 00                	add    %eax,(%eax)
    27db:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    27e1:	00 00                	add    %al,(%eax)
    27e3:	00 ec                	add    %ch,%ah
    27e5:	01 00                	add    %eax,(%eax)
    27e7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    27ed:	00 00                	add    %al,(%eax)
    27ef:	00 07                	add    %al,(%edi)
    27f1:	02 00                	add    (%eax),%al
    27f3:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    27f9:	00 00                	add    %al,(%eax)
    27fb:	00 28                	add    %ch,(%eax)
    27fd:	02 00                	add    (%eax),%al
    27ff:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2805:	00 00                	add    %al,(%eax)
    2807:	00 47 02             	add    %al,0x2(%edi)
    280a:	00 00                	add    %al,(%eax)
    280c:	80 00 00             	addb   $0x0,(%eax)
    280f:	00 00                	add    %al,(%eax)
    2811:	00 00                	add    %al,(%eax)
    2813:	00 66 02             	add    %ah,0x2(%esi)
    2816:	00 00                	add    %al,(%eax)
    2818:	80 00 00             	addb   $0x0,(%eax)
    281b:	00 00                	add    %al,(%eax)
    281d:	00 00                	add    %al,(%eax)
    281f:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
    2825:	00 00                	add    %al,(%eax)
    2827:	00 00                	add    %al,(%eax)
    2829:	00 00                	add    %al,(%eax)
    282b:	00 9b 02 00 00 c2    	add    %bl,-0x3dfffffe(%ebx)
    2831:	00 00                	add    %al,(%eax)
    2833:	00 d4                	add    %dl,%ah
    2835:	8c 00                	mov    %es,(%eax)
    2837:	00 a4 02 00 00 c2 00 	add    %ah,0xc20000(%edx,%eax,1)
    283e:	00 00                	add    %al,(%eax)
    2840:	00 00                	add    %al,(%eax)
    2842:	00 00                	add    %al,(%eax)
    2844:	aa                   	stos   %al,%es:(%edi)
    2845:	02 00                	add    (%eax),%al
    2847:	00 c2                	add    %al,%dl
    2849:	00 00                	add    %al,(%eax)
    284b:	00 37                	add    %dh,(%edi)
    284d:	53                   	push   %ebx
    284e:	00 00                	add    %al,(%eax)
    2850:	c2 0d 00             	ret    $0xd
    2853:	00 24 00             	add    %ah,(%eax,%eax,1)
    2856:	00 00                	add    %al,(%eax)
    2858:	2c 0b                	sub    $0xb,%al
    285a:	28 00                	sub    %al,(%eax)
    285c:	d5 0d                	aad    $0xd
    285e:	00 00                	add    %al,(%eax)
    2860:	a0 00 00 00 08       	mov    0x8000000,%al
    2865:	00 00                	add    %al,(%eax)
    2867:	00 e9                	add    %ch,%cl
    2869:	0d 00 00 a0 00       	or     $0xa00000,%eax
    286e:	00 00                	add    %al,(%eax)
    2870:	0c 00                	or     $0x0,%al
    2872:	00 00                	add    %al,(%eax)
    2874:	f5                   	cmc    
    2875:	0d 00 00 a0 00       	or     $0xa00000,%eax
    287a:	00 00                	add    %al,(%eax)
    287c:	10 00                	adc    %al,(%eax)
    287e:	00 00                	add    %al,(%eax)
    2880:	00 00                	add    %al,(%eax)
    2882:	00 00                	add    %al,(%eax)
    2884:	44                   	inc    %esp
    2885:	00 08                	add    %cl,(%eax)
	...
    288f:	00 44 00 08          	add    %al,0x8(%eax,%eax,1)
    2893:	00 03                	add    %al,(%ebx)
    2895:	00 00                	add    %al,(%eax)
    2897:	00 00                	add    %al,(%eax)
    2899:	00 00                	add    %al,(%eax)
    289b:	00 44 00 0a          	add    %al,0xa(%eax,%eax,1)
    289f:	00 09                	add    %cl,(%ecx)
    28a1:	00 00                	add    %al,(%eax)
    28a3:	00 00                	add    %al,(%eax)
    28a5:	00 00                	add    %al,(%eax)
    28a7:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
    28ab:	00 0c 00             	add    %cl,(%eax,%eax,1)
    28ae:	00 00                	add    %al,(%eax)
    28b0:	00 00                	add    %al,(%eax)
    28b2:	00 00                	add    %al,(%eax)
    28b4:	44                   	inc    %esp
    28b5:	00 09                	add    %cl,(%ecx)
    28b7:	00 13                	add    %dl,(%ebx)
    28b9:	00 00                	add    %al,(%eax)
    28bb:	00 00                	add    %al,(%eax)
    28bd:	00 00                	add    %al,(%eax)
    28bf:	00 44 00 0a          	add    %al,0xa(%eax,%eax,1)
    28c3:	00 16                	add    %dl,(%esi)
    28c5:	00 00                	add    %al,(%eax)
    28c7:	00 00                	add    %al,(%eax)
    28c9:	00 00                	add    %al,(%eax)
    28cb:	00 44 00 0b          	add    %al,0xb(%eax,%eax,1)
    28cf:	00 18                	add    %bl,(%eax)
    28d1:	00 00                	add    %al,(%eax)
    28d3:	00 00                	add    %al,(%eax)
    28d5:	00 00                	add    %al,(%eax)
    28d7:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    28db:	00 1b                	add    %bl,(%ebx)
    28dd:	00 00                	add    %al,(%eax)
    28df:	00 00                	add    %al,(%eax)
    28e1:	00 00                	add    %al,(%eax)
    28e3:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
    28e7:	00 22                	add    %ah,(%edx)
    28e9:	00 00                	add    %al,(%eax)
    28eb:	00 00                	add    %al,(%eax)
    28ed:	00 00                	add    %al,(%eax)
    28ef:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
    28f3:	00 29                	add    %ch,(%ecx)
    28f5:	00 00                	add    %al,(%eax)
    28f7:	00 00                	add    %al,(%eax)
    28f9:	0e                   	push   %cs
    28fa:	00 00                	add    %al,(%eax)
    28fc:	40                   	inc    %eax
    28fd:	00 00                	add    %al,(%eax)
    28ff:	00 00                	add    %al,(%eax)
    2901:	00 00                	add    %al,(%eax)
    2903:	00 0d 0e 00 00 40    	add    %cl,0x4000000e
    2909:	00 00                	add    %al,(%eax)
    290b:	00 02                	add    %al,(%edx)
    290d:	00 00                	add    %al,(%eax)
    290f:	00 19                	add    %bl,(%ecx)
    2911:	0e                   	push   %cs
    2912:	00 00                	add    %al,(%eax)
    2914:	40                   	inc    %eax
    2915:	00 00                	add    %al,(%eax)
    2917:	00 01                	add    %al,(%ecx)
    2919:	00 00                	add    %al,(%eax)
    291b:	00 24 0e             	add    %ah,(%esi,%ecx,1)
    291e:	00 00                	add    %al,(%eax)
    2920:	24 00                	and    $0x0,%al
    2922:	00 00                	add    %al,(%eax)
    2924:	57                   	push   %edi
    2925:	0b 28                	or     (%eax),%ebp
    2927:	00 35 0e 00 00 a0    	add    %dh,0xa000000e
    292d:	00 00                	add    %al,(%eax)
    292f:	00 08                	add    %cl,(%eax)
    2931:	00 00                	add    %al,(%eax)
    2933:	00 42 0e             	add    %al,0xe(%edx)
    2936:	00 00                	add    %al,(%eax)
    2938:	a0 00 00 00 0c       	mov    0xc000000,%al
    293d:	00 00                	add    %al,(%eax)
    293f:	00 00                	add    %al,(%eax)
    2941:	00 00                	add    %al,(%eax)
    2943:	00 44 00 13          	add    %al,0x13(%eax,%eax,1)
	...
    294f:	00 44 00 13          	add    %al,0x13(%eax,%eax,1)
    2953:	00 07                	add    %al,(%edi)
    2955:	00 00                	add    %al,(%eax)
    2957:	00 00                	add    %al,(%eax)
    2959:	00 00                	add    %al,(%eax)
    295b:	00 44 00 14          	add    %al,0x14(%eax,%eax,1)
    295f:	00 0a                	add    %cl,(%edx)
    2961:	00 00                	add    %al,(%eax)
    2963:	00 00                	add    %al,(%eax)
    2965:	00 00                	add    %al,(%eax)
    2967:	00 44 00 16          	add    %al,0x16(%eax,%eax,1)
    296b:	00 10                	add    %dl,(%eax)
    296d:	00 00                	add    %al,(%eax)
    296f:	00 00                	add    %al,(%eax)
    2971:	00 00                	add    %al,(%eax)
    2973:	00 44 00 17          	add    %al,0x17(%eax,%eax,1)
    2977:	00 14 00             	add    %dl,(%eax,%eax,1)
    297a:	00 00                	add    %al,(%eax)
    297c:	00 00                	add    %al,(%eax)
    297e:	00 00                	add    %al,(%eax)
    2980:	44                   	inc    %esp
    2981:	00 19                	add    %bl,(%ecx)
    2983:	00 19                	add    %bl,(%ecx)
    2985:	00 00                	add    %al,(%eax)
    2987:	00 00                	add    %al,(%eax)
    2989:	00 00                	add    %al,(%eax)
    298b:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
    298f:	00 21                	add    %ah,(%ecx)
    2991:	00 00                	add    %al,(%eax)
    2993:	00 00                	add    %al,(%eax)
    2995:	00 00                	add    %al,(%eax)
    2997:	00 44 00 1b          	add    %al,0x1b(%eax,%eax,1)
    299b:	00 27                	add    %ah,(%edi)
    299d:	00 00                	add    %al,(%eax)
    299f:	00 00                	add    %al,(%eax)
    29a1:	00 00                	add    %al,(%eax)
    29a3:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
    29a7:	00 2a                	add    %ch,(%edx)
    29a9:	00 00                	add    %al,(%eax)
    29ab:	00 00                	add    %al,(%eax)
    29ad:	00 00                	add    %al,(%eax)
    29af:	00 44 00 1b          	add    %al,0x1b(%eax,%eax,1)
    29b3:	00 2d 00 00 00 00    	add    %ch,0x0
    29b9:	00 00                	add    %al,(%eax)
    29bb:	00 44 00 1c          	add    %al,0x1c(%eax,%eax,1)
    29bf:	00 2f                	add    %ch,(%edi)
    29c1:	00 00                	add    %al,(%eax)
    29c3:	00 00                	add    %al,(%eax)
    29c5:	00 00                	add    %al,(%eax)
    29c7:	00 44 00 1e          	add    %al,0x1e(%eax,%eax,1)
    29cb:	00 36                	add    %dh,(%esi)
    29cd:	00 00                	add    %al,(%eax)
    29cf:	00 00                	add    %al,(%eax)
    29d1:	00 00                	add    %al,(%eax)
    29d3:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
    29d7:	00 39                	add    %bh,(%ecx)
    29d9:	00 00                	add    %al,(%eax)
    29db:	00 00                	add    %al,(%eax)
    29dd:	00 00                	add    %al,(%eax)
    29df:	00 44 00 20          	add    %al,0x20(%eax,%eax,1)
    29e3:	00 3b                	add    %bh,(%ebx)
    29e5:	00 00                	add    %al,(%eax)
    29e7:	00 00                	add    %al,(%eax)
    29e9:	0e                   	push   %cs
    29ea:	00 00                	add    %al,(%eax)
    29ec:	40                   	inc    %eax
    29ed:	00 00                	add    %al,(%eax)
    29ef:	00 00                	add    %al,(%eax)
    29f1:	00 00                	add    %al,(%eax)
    29f3:	00 4e 0e             	add    %cl,0xe(%esi)
    29f6:	00 00                	add    %al,(%eax)
    29f8:	24 00                	and    $0x0,%al
    29fa:	00 00                	add    %al,(%eax)
    29fc:	95                   	xchg   %eax,%ebp
    29fd:	0b 28                	or     (%eax),%ebp
    29ff:	00 35 0e 00 00 a0    	add    %dh,0xa000000e
    2a05:	00 00                	add    %al,(%eax)
    2a07:	00 08                	add    %cl,(%eax)
    2a09:	00 00                	add    %al,(%eax)
    2a0b:	00 00                	add    %al,(%eax)
    2a0d:	00 00                	add    %al,(%eax)
    2a0f:	00 44 00 23          	add    %al,0x23(%eax,%eax,1)
	...
    2a1b:	00 44 00 25          	add    %al,0x25(%eax,%eax,1)
    2a1f:	00 09                	add    %cl,(%ecx)
    2a21:	00 00                	add    %al,(%eax)
    2a23:	00 00                	add    %al,(%eax)
    2a25:	00 00                	add    %al,(%eax)
    2a27:	00 44 00 29          	add    %al,0x29(%eax,%eax,1)
    2a2b:	00 13                	add    %dl,(%ebx)
    2a2d:	00 00                	add    %al,(%eax)
    2a2f:	00 00                	add    %al,(%eax)
    2a31:	00 00                	add    %al,(%eax)
    2a33:	00 44 00 2a          	add    %al,0x2a(%eax,%eax,1)
    2a37:	00 16                	add    %dl,(%esi)
    2a39:	00 00                	add    %al,(%eax)
    2a3b:	00 00                	add    %al,(%eax)
    2a3d:	00 00                	add    %al,(%eax)
    2a3f:	00 44 00 29          	add    %al,0x29(%eax,%eax,1)
    2a43:	00 18                	add    %bl,(%eax)
    2a45:	00 00                	add    %al,(%eax)
    2a47:	00 00                	add    %al,(%eax)
    2a49:	00 00                	add    %al,(%eax)
    2a4b:	00 44 00 2a          	add    %al,0x2a(%eax,%eax,1)
    2a4f:	00 1e                	add    %bl,(%esi)
    2a51:	00 00                	add    %al,(%eax)
    2a53:	00 00                	add    %al,(%eax)
    2a55:	00 00                	add    %al,(%eax)
    2a57:	00 44 00 2e          	add    %al,0x2e(%eax,%eax,1)
    2a5b:	00 24 00             	add    %ah,(%eax,%eax,1)
    2a5e:	00 00                	add    %al,(%eax)
    2a60:	00 00                	add    %al,(%eax)
    2a62:	00 00                	add    %al,(%eax)
    2a64:	44                   	inc    %esp
    2a65:	00 2a                	add    %ch,(%edx)
    2a67:	00 25 00 00 00 00    	add    %ah,0x0
    2a6d:	00 00                	add    %al,(%eax)
    2a6f:	00 44 00 2e          	add    %al,0x2e(%eax,%eax,1)
    2a73:	00 28                	add    %ch,(%eax)
    2a75:	00 00                	add    %al,(%eax)
    2a77:	00 00                	add    %al,(%eax)
    2a79:	00 00                	add    %al,(%eax)
    2a7b:	00 44 00 2f          	add    %al,0x2f(%eax,%eax,1)
    2a7f:	00 2b                	add    %ch,(%ebx)
    2a81:	00 00                	add    %al,(%eax)
    2a83:	00 00                	add    %al,(%eax)
    2a85:	00 00                	add    %al,(%eax)
    2a87:	00 44 00 27          	add    %al,0x27(%eax,%eax,1)
    2a8b:	00 2d 00 00 00 00    	add    %ch,0x0
    2a91:	00 00                	add    %al,(%eax)
    2a93:	00 44 00 30          	add    %al,0x30(%eax,%eax,1)
    2a97:	00 30                	add    %dh,(%eax)
    2a99:	00 00                	add    %al,(%eax)
    2a9b:	00 5f 0e             	add    %bl,0xe(%edi)
    2a9e:	00 00                	add    %al,(%eax)
    2aa0:	40                   	inc    %eax
	...
    2aa9:	0e                   	push   %cs
    2aaa:	00 00                	add    %al,(%eax)
    2aac:	40                   	inc    %eax
    2aad:	00 00                	add    %al,(%eax)
    2aaf:	00 02                	add    %al,(%edx)
    2ab1:	00 00                	add    %al,(%eax)
    2ab3:	00 00                	add    %al,(%eax)
    2ab5:	00 00                	add    %al,(%eax)
    2ab7:	00 c0                	add    %al,%al
	...
    2ac1:	00 00                	add    %al,(%eax)
    2ac3:	00 e0                	add    %ah,%al
    2ac5:	00 00                	add    %al,(%eax)
    2ac7:	00 35 00 00 00 6b    	add    %dh,0x6b000000
    2acd:	0e                   	push   %cs
    2ace:	00 00                	add    %al,(%eax)
    2ad0:	24 00                	and    $0x0,%al
    2ad2:	00 00                	add    %al,(%eax)
    2ad4:	ca 0b 28             	lret   $0x280b
    2ad7:	00 35 0e 00 00 a0    	add    %dh,0xa000000e
    2add:	00 00                	add    %al,(%eax)
    2adf:	00 08                	add    %cl,(%eax)
    2ae1:	00 00                	add    %al,(%eax)
    2ae3:	00 00                	add    %al,(%eax)
    2ae5:	00 00                	add    %al,(%eax)
    2ae7:	00 44 00 34          	add    %al,0x34(%eax,%eax,1)
	...
    2af3:	00 44 00 34          	add    %al,0x34(%eax,%eax,1)
    2af7:	00 03                	add    %al,(%ebx)
    2af9:	00 00                	add    %al,(%eax)
    2afb:	00 00                	add    %al,(%eax)
    2afd:	00 00                	add    %al,(%eax)
    2aff:	00 44 00 36          	add    %al,0x36(%eax,%eax,1)
    2b03:	00 06                	add    %al,(%esi)
    2b05:	00 00                	add    %al,(%eax)
    2b07:	00 00                	add    %al,(%eax)
    2b09:	00 00                	add    %al,(%eax)
    2b0b:	00 44 00 35          	add    %al,0x35(%eax,%eax,1)
    2b0f:	00 07                	add    %al,(%edi)
    2b11:	00 00                	add    %al,(%eax)
    2b13:	00 00                	add    %al,(%eax)
    2b15:	00 00                	add    %al,(%eax)
    2b17:	00 44 00 36          	add    %al,0x36(%eax,%eax,1)
    2b1b:	00 0d 00 00 00 00    	add    %cl,0x0
    2b21:	0e                   	push   %cs
    2b22:	00 00                	add    %al,(%eax)
    2b24:	40                   	inc    %eax
    2b25:	00 00                	add    %al,(%eax)
    2b27:	00 02                	add    %al,(%edx)
    2b29:	00 00                	add    %al,(%eax)
    2b2b:	00 00                	add    %al,(%eax)
    2b2d:	00 00                	add    %al,(%eax)
    2b2f:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
    2b33:	00 d8                	add    %bl,%al
    2b35:	0b 28                	or     (%eax),%ebp
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	47                   	inc    %edi
   1:	43                   	inc    %ebx
   2:	43                   	inc    %ebx
   3:	3a 20                	cmp    (%eax),%ah
   5:	28 47 4e             	sub    %al,0x4e(%edi)
   8:	55                   	push   %ebp
   9:	29 20                	sub    %esp,(%eax)
   b:	34 2e                	xor    $0x2e,%al
   d:	38 2e                	cmp    %ch,(%esi)
   f:	32 20                	xor    (%eax),%ah
  11:	32 30                	xor    (%eax),%dh
  13:	31 33                	xor    %esi,(%ebx)
  15:	31 30                	xor    %esi,(%eax)
  17:	31 37                	xor    %esi,(%edi)
  19:	20 28                	and    %ch,(%eax)
  1b:	52                   	push   %edx
  1c:	65 64 20 48 61       	gs and %cl,%fs:%gs:0x61(%eax)
  21:	74 20                	je     43 <wait_KBC_sendready-0x27ffbd>
  23:	34 2e                	xor    $0x2e,%al
  25:	38 2e                	cmp    %ch,(%esi)
  27:	32                   	.byte 0x32
  28:	2d                   	.byte 0x2d
  29:	31 29                	xor    %ebp,(%ecx)
	...

Disassembly of section .stabstr:

00000000 <.stabstr>:
   0:	00 6d 61             	add    %ch,0x61(%ebp)
   3:	69 6e 2e 63 00 67 63 	imul   $0x63670063,0x2e(%esi),%ebp
   a:	63 32                	arpl   %si,(%edx)
   c:	5f                   	pop    %edi
   d:	63 6f 6d             	arpl   %bp,0x6d(%edi)
  10:	70 69                	jo     7b <wait_KBC_sendready-0x27ff85>
  12:	6c                   	insb   (%dx),%es:(%edi)
  13:	65 64 2e 00 69 6e    	gs fs add %ch,%cs:%fs:%gs:0x6e(%ecx)
  19:	74 3a                	je     55 <wait_KBC_sendready-0x27ffab>
  1b:	74 28                	je     45 <wait_KBC_sendready-0x27ffbb>
  1d:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
  20:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
  26:	31 29                	xor    %ebp,(%ecx)
  28:	3b 2d 32 31 34 37    	cmp    0x37343132,%ebp
  2e:	34 38                	xor    $0x38,%al
  30:	33 36                	xor    (%esi),%esi
  32:	34 38                	xor    $0x38,%al
  34:	3b 32                	cmp    (%edx),%esi
  36:	31 34 37             	xor    %esi,(%edi,%esi,1)
  39:	34 38                	xor    $0x38,%al
  3b:	33 36                	xor    (%esi),%esi
  3d:	34 37                	xor    $0x37,%al
  3f:	3b 00                	cmp    (%eax),%eax
  41:	63 68 61             	arpl   %bp,0x61(%eax)
  44:	72 3a                	jb     80 <wait_KBC_sendready-0x27ff80>
  46:	74 28                	je     70 <wait_KBC_sendready-0x27ff90>
  48:	30 2c 32             	xor    %ch,(%edx,%esi,1)
  4b:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
  51:	32 29                	xor    (%ecx),%ch
  53:	3b 30                	cmp    (%eax),%esi
  55:	3b 31                	cmp    (%ecx),%esi
  57:	32 37                	xor    (%edi),%dh
  59:	3b 00                	cmp    (%eax),%eax
  5b:	6c                   	insb   (%dx),%es:(%edi)
  5c:	6f                   	outsl  %ds:(%esi),(%dx)
  5d:	6e                   	outsb  %ds:(%esi),(%dx)
  5e:	67 20 69 6e          	and    %ch,0x6e(%bx,%di)
  62:	74 3a                	je     9e <wait_KBC_sendready-0x27ff62>
  64:	74 28                	je     8e <wait_KBC_sendready-0x27ff72>
  66:	30 2c 33             	xor    %ch,(%ebx,%esi,1)
  69:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
  6f:	33 29                	xor    (%ecx),%ebp
  71:	3b 2d 32 31 34 37    	cmp    0x37343132,%ebp
  77:	34 38                	xor    $0x38,%al
  79:	33 36                	xor    (%esi),%esi
  7b:	34 38                	xor    $0x38,%al
  7d:	3b 32                	cmp    (%edx),%esi
  7f:	31 34 37             	xor    %esi,(%edi,%esi,1)
  82:	34 38                	xor    $0x38,%al
  84:	33 36                	xor    (%esi),%esi
  86:	34 37                	xor    $0x37,%al
  88:	3b 00                	cmp    (%eax),%eax
  8a:	75 6e                	jne    fa <wait_KBC_sendready-0x27ff06>
  8c:	73 69                	jae    f7 <wait_KBC_sendready-0x27ff09>
  8e:	67 6e                	outsb  %ds:(%si),(%dx)
  90:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
  95:	74 3a                	je     d1 <wait_KBC_sendready-0x27ff2f>
  97:	74 28                	je     c1 <wait_KBC_sendready-0x27ff3f>
  99:	30 2c 34             	xor    %ch,(%esp,%esi,1)
  9c:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
  a2:	34 29                	xor    $0x29,%al
  a4:	3b 30                	cmp    (%eax),%esi
  a6:	3b 34 32             	cmp    (%edx,%esi,1),%esi
  a9:	39 34 39             	cmp    %esi,(%ecx,%edi,1)
  ac:	36                   	ss
  ad:	37                   	aaa    
  ae:	32 39                	xor    (%ecx),%bh
  b0:	35 3b 00 6c 6f       	xor    $0x6f6c003b,%eax
  b5:	6e                   	outsb  %ds:(%esi),(%dx)
  b6:	67 20 75 6e          	and    %dh,0x6e(%di)
  ba:	73 69                	jae    125 <wait_KBC_sendready-0x27fedb>
  bc:	67 6e                	outsb  %ds:(%si),(%dx)
  be:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
  c3:	74 3a                	je     ff <wait_KBC_sendready-0x27ff01>
  c5:	74 28                	je     ef <wait_KBC_sendready-0x27ff11>
  c7:	30 2c 35 29 3d 72 28 	xor    %ch,0x28723d29(,%esi,1)
  ce:	30 2c 35 29 3b 30 3b 	xor    %ch,0x3b303b29(,%esi,1)
  d5:	34 32                	xor    $0x32,%al
  d7:	39 34 39             	cmp    %esi,(%ecx,%edi,1)
  da:	36                   	ss
  db:	37                   	aaa    
  dc:	32 39                	xor    (%ecx),%bh
  de:	35 3b 00 6c 6f       	xor    $0x6f6c003b,%eax
  e3:	6e                   	outsb  %ds:(%esi),(%dx)
  e4:	67 20 6c 6f          	and    %ch,0x6f(%si)
  e8:	6e                   	outsb  %ds:(%esi),(%dx)
  e9:	67 20 69 6e          	and    %ch,0x6e(%bx,%di)
  ed:	74 3a                	je     129 <wait_KBC_sendready-0x27fed7>
  ef:	74 28                	je     119 <wait_KBC_sendready-0x27fee7>
  f1:	30 2c 36             	xor    %ch,(%esi,%esi,1)
  f4:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
  fa:	36 29 3b             	sub    %edi,%ss:(%ebx)
  fd:	2d 30 3b 34 32       	sub    $0x32343b30,%eax
 102:	39 34 39             	cmp    %esi,(%ecx,%edi,1)
 105:	36                   	ss
 106:	37                   	aaa    
 107:	32 39                	xor    (%ecx),%bh
 109:	35 3b 00 6c 6f       	xor    $0x6f6c003b,%eax
 10e:	6e                   	outsb  %ds:(%esi),(%dx)
 10f:	67 20 6c 6f          	and    %ch,0x6f(%si)
 113:	6e                   	outsb  %ds:(%esi),(%dx)
 114:	67 20 75 6e          	and    %dh,0x6e(%di)
 118:	73 69                	jae    183 <wait_KBC_sendready-0x27fe7d>
 11a:	67 6e                	outsb  %ds:(%si),(%dx)
 11c:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
 121:	74 3a                	je     15d <wait_KBC_sendready-0x27fea3>
 123:	74 28                	je     14d <wait_KBC_sendready-0x27feb3>
 125:	30 2c 37             	xor    %ch,(%edi,%esi,1)
 128:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
 12e:	37                   	aaa    
 12f:	29 3b                	sub    %edi,(%ebx)
 131:	30 3b                	xor    %bh,(%ebx)
 133:	2d 31 3b 00 73       	sub    $0x73003b31,%eax
 138:	68 6f 72 74 20       	push   $0x2074726f
 13d:	69 6e 74 3a 74 28 30 	imul   $0x3028743a,0x74(%esi),%ebp
 144:	2c 38                	sub    $0x38,%al
 146:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
 14c:	38 29                	cmp    %ch,(%ecx)
 14e:	3b 2d 33 32 37 36    	cmp    0x36373233,%ebp
 154:	38 3b                	cmp    %bh,(%ebx)
 156:	33 32                	xor    (%edx),%esi
 158:	37                   	aaa    
 159:	36                   	ss
 15a:	37                   	aaa    
 15b:	3b 00                	cmp    (%eax),%eax
 15d:	73 68                	jae    1c7 <wait_KBC_sendready-0x27fe39>
 15f:	6f                   	outsl  %ds:(%esi),(%dx)
 160:	72 74                	jb     1d6 <wait_KBC_sendready-0x27fe2a>
 162:	20 75 6e             	and    %dh,0x6e(%ebp)
 165:	73 69                	jae    1d0 <wait_KBC_sendready-0x27fe30>
 167:	67 6e                	outsb  %ds:(%si),(%dx)
 169:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
 16e:	74 3a                	je     1aa <wait_KBC_sendready-0x27fe56>
 170:	74 28                	je     19a <wait_KBC_sendready-0x27fe66>
 172:	30 2c 39             	xor    %ch,(%ecx,%edi,1)
 175:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
 17b:	39 29                	cmp    %ebp,(%ecx)
 17d:	3b 30                	cmp    (%eax),%esi
 17f:	3b 36                	cmp    (%esi),%esi
 181:	35 35 33 35 3b       	xor    $0x3b353335,%eax
 186:	00 73 69             	add    %dh,0x69(%ebx)
 189:	67 6e                	outsb  %ds:(%si),(%dx)
 18b:	65 64 20 63 68       	gs and %ah,%fs:%gs:0x68(%ebx)
 190:	61                   	popa   
 191:	72 3a                	jb     1cd <wait_KBC_sendready-0x27fe33>
 193:	74 28                	je     1bd <wait_KBC_sendready-0x27fe43>
 195:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 198:	30 29                	xor    %ch,(%ecx)
 19a:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 19f:	31 30                	xor    %esi,(%eax)
 1a1:	29 3b                	sub    %edi,(%ebx)
 1a3:	2d 31 32 38 3b       	sub    $0x3b383231,%eax
 1a8:	31 32                	xor    %esi,(%edx)
 1aa:	37                   	aaa    
 1ab:	3b 00                	cmp    (%eax),%eax
 1ad:	75 6e                	jne    21d <wait_KBC_sendready-0x27fde3>
 1af:	73 69                	jae    21a <wait_KBC_sendready-0x27fde6>
 1b1:	67 6e                	outsb  %ds:(%si),(%dx)
 1b3:	65 64 20 63 68       	gs and %ah,%fs:%gs:0x68(%ebx)
 1b8:	61                   	popa   
 1b9:	72 3a                	jb     1f5 <wait_KBC_sendready-0x27fe0b>
 1bb:	74 28                	je     1e5 <wait_KBC_sendready-0x27fe1b>
 1bd:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 1c0:	31 29                	xor    %ebp,(%ecx)
 1c2:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 1c7:	31 31                	xor    %esi,(%ecx)
 1c9:	29 3b                	sub    %edi,(%ebx)
 1cb:	30 3b                	xor    %bh,(%ebx)
 1cd:	32 35 35 3b 00 66    	xor    0x66003b35,%dh
 1d3:	6c                   	insb   (%dx),%es:(%edi)
 1d4:	6f                   	outsl  %ds:(%esi),(%dx)
 1d5:	61                   	popa   
 1d6:	74 3a                	je     212 <wait_KBC_sendready-0x27fdee>
 1d8:	74 28                	je     202 <wait_KBC_sendready-0x27fdfe>
 1da:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 1dd:	32 29                	xor    (%ecx),%ch
 1df:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 1e4:	31 29                	xor    %ebp,(%ecx)
 1e6:	3b 34 3b             	cmp    (%ebx,%edi,1),%esi
 1e9:	30 3b                	xor    %bh,(%ebx)
 1eb:	00 64 6f 75          	add    %ah,0x75(%edi,%ebp,2)
 1ef:	62 6c 65 3a          	bound  %ebp,0x3a(%ebp,%eiz,2)
 1f3:	74 28                	je     21d <wait_KBC_sendready-0x27fde3>
 1f5:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 1f8:	33 29                	xor    (%ecx),%ebp
 1fa:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 1ff:	31 29                	xor    %ebp,(%ecx)
 201:	3b 38                	cmp    (%eax),%edi
 203:	3b 30                	cmp    (%eax),%esi
 205:	3b 00                	cmp    (%eax),%eax
 207:	6c                   	insb   (%dx),%es:(%edi)
 208:	6f                   	outsl  %ds:(%esi),(%dx)
 209:	6e                   	outsb  %ds:(%esi),(%dx)
 20a:	67 20 64 6f          	and    %ah,0x6f(%si)
 20e:	75 62                	jne    272 <wait_KBC_sendready-0x27fd8e>
 210:	6c                   	insb   (%dx),%es:(%edi)
 211:	65 3a 74 28 30       	cmp    %gs:0x30(%eax,%ebp,1),%dh
 216:	2c 31                	sub    $0x31,%al
 218:	34 29                	xor    $0x29,%al
 21a:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 21f:	31 29                	xor    %ebp,(%ecx)
 221:	3b 31                	cmp    (%ecx),%esi
 223:	32 3b                	xor    (%ebx),%bh
 225:	30 3b                	xor    %bh,(%ebx)
 227:	00 5f 44             	add    %bl,0x44(%edi)
 22a:	65 63 69 6d          	arpl   %bp,%gs:0x6d(%ecx)
 22e:	61                   	popa   
 22f:	6c                   	insb   (%dx),%es:(%edi)
 230:	33 32                	xor    (%edx),%esi
 232:	3a 74 28 30          	cmp    0x30(%eax,%ebp,1),%dh
 236:	2c 31                	sub    $0x31,%al
 238:	35 29 3d 72 28       	xor    $0x28723d29,%eax
 23d:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 240:	29 3b                	sub    %edi,(%ebx)
 242:	34 3b                	xor    $0x3b,%al
 244:	30 3b                	xor    %bh,(%ebx)
 246:	00 5f 44             	add    %bl,0x44(%edi)
 249:	65 63 69 6d          	arpl   %bp,%gs:0x6d(%ecx)
 24d:	61                   	popa   
 24e:	6c                   	insb   (%dx),%es:(%edi)
 24f:	36                   	ss
 250:	34 3a                	xor    $0x3a,%al
 252:	74 28                	je     27c <wait_KBC_sendready-0x27fd84>
 254:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 257:	36 29 3d 72 28 30 2c 	sub    %edi,%ss:0x2c302872
 25e:	31 29                	xor    %ebp,(%ecx)
 260:	3b 38                	cmp    (%eax),%edi
 262:	3b 30                	cmp    (%eax),%esi
 264:	3b 00                	cmp    (%eax),%eax
 266:	5f                   	pop    %edi
 267:	44                   	inc    %esp
 268:	65 63 69 6d          	arpl   %bp,%gs:0x6d(%ecx)
 26c:	61                   	popa   
 26d:	6c                   	insb   (%dx),%es:(%edi)
 26e:	31 32                	xor    %esi,(%edx)
 270:	38 3a                	cmp    %bh,(%edx)
 272:	74 28                	je     29c <wait_KBC_sendready-0x27fd64>
 274:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 277:	37                   	aaa    
 278:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
 27e:	31 29                	xor    %ebp,(%ecx)
 280:	3b 31                	cmp    (%ecx),%esi
 282:	36 3b 30             	cmp    %ss:(%eax),%esi
 285:	3b 00                	cmp    (%eax),%eax
 287:	76 6f                	jbe    2f8 <wait_KBC_sendready-0x27fd08>
 289:	69 64 3a 74 28 30 2c 	imul   $0x312c3028,0x74(%edx,%edi,1),%esp
 290:	31 
 291:	38 29                	cmp    %ch,(%ecx)
 293:	3d 28 30 2c 31       	cmp    $0x312c3028,%eax
 298:	38 29                	cmp    %ch,(%ecx)
 29a:	00 68 65             	add    %ch,0x65(%eax)
 29d:	61                   	popa   
 29e:	64                   	fs
 29f:	65                   	gs
 2a0:	72 2e                	jb     2d0 <wait_KBC_sendready-0x27fd30>
 2a2:	68 00 78 38 36       	push   $0x36387800
 2a7:	2e                   	cs
 2a8:	68 00 74 79 70       	push   $0x70797400
 2ad:	65                   	gs
 2ae:	73 2e                	jae    2de <wait_KBC_sendready-0x27fd22>
 2b0:	68 00 62 6f 6f       	push   $0x6f6f6200
 2b5:	6c                   	insb   (%dx),%es:(%edi)
 2b6:	3a 74 28 33          	cmp    0x33(%eax,%ebp,1),%dh
 2ba:	2c 31                	sub    $0x31,%al
 2bc:	29 3d 28 30 2c 31    	sub    %edi,0x312c3028
 2c2:	29 00                	sub    %eax,(%eax)
 2c4:	69 6e 74 38 5f 74 3a 	imul   $0x3a745f38,0x74(%esi),%ebp
 2cb:	74 28                	je     2f5 <wait_KBC_sendready-0x27fd0b>
 2cd:	33 2c 32             	xor    (%edx,%esi,1),%ebp
 2d0:	29 3d 28 30 2c 31    	sub    %edi,0x312c3028
 2d6:	30 29                	xor    %ch,(%ecx)
 2d8:	00 75 69             	add    %dh,0x69(%ebp)
 2db:	6e                   	outsb  %ds:(%esi),(%dx)
 2dc:	74 38                	je     316 <wait_KBC_sendready-0x27fcea>
 2de:	5f                   	pop    %edi
 2df:	74 3a                	je     31b <wait_KBC_sendready-0x27fce5>
 2e1:	74 28                	je     30b <wait_KBC_sendready-0x27fcf5>
 2e3:	33 2c 33             	xor    (%ebx,%esi,1),%ebp
 2e6:	29 3d 28 30 2c 31    	sub    %edi,0x312c3028
 2ec:	31 29                	xor    %ebp,(%ecx)
 2ee:	00 69 6e             	add    %ch,0x6e(%ecx)
 2f1:	74 31                	je     324 <wait_KBC_sendready-0x27fcdc>
 2f3:	36                   	ss
 2f4:	5f                   	pop    %edi
 2f5:	74 3a                	je     331 <wait_KBC_sendready-0x27fccf>
 2f7:	74 28                	je     321 <wait_KBC_sendready-0x27fcdf>
 2f9:	33 2c 34             	xor    (%esp,%esi,1),%ebp
 2fc:	29 3d 28 30 2c 38    	sub    %edi,0x382c3028
 302:	29 00                	sub    %eax,(%eax)
 304:	75 69                	jne    36f <wait_KBC_sendready-0x27fc91>
 306:	6e                   	outsb  %ds:(%esi),(%dx)
 307:	74 31                	je     33a <wait_KBC_sendready-0x27fcc6>
 309:	36                   	ss
 30a:	5f                   	pop    %edi
 30b:	74 3a                	je     347 <wait_KBC_sendready-0x27fcb9>
 30d:	74 28                	je     337 <wait_KBC_sendready-0x27fcc9>
 30f:	33 2c 35 29 3d 28 30 	xor    0x30283d29(,%esi,1),%ebp
 316:	2c 39                	sub    $0x39,%al
 318:	29 00                	sub    %eax,(%eax)
 31a:	69 6e 74 33 32 5f 74 	imul   $0x745f3233,0x74(%esi),%ebp
 321:	3a 74 28 33          	cmp    0x33(%eax,%ebp,1),%dh
 325:	2c 36                	sub    $0x36,%al
 327:	29 3d 28 30 2c 31    	sub    %edi,0x312c3028
 32d:	29 00                	sub    %eax,(%eax)
 32f:	75 69                	jne    39a <wait_KBC_sendready-0x27fc66>
 331:	6e                   	outsb  %ds:(%esi),(%dx)
 332:	74 33                	je     367 <wait_KBC_sendready-0x27fc99>
 334:	32 5f 74             	xor    0x74(%edi),%bl
 337:	3a 74 28 33          	cmp    0x33(%eax,%ebp,1),%dh
 33b:	2c 37                	sub    $0x37,%al
 33d:	29 3d 28 30 2c 34    	sub    %edi,0x342c3028
 343:	29 00                	sub    %eax,(%eax)
 345:	69 6e 74 36 34 5f 74 	imul   $0x745f3436,0x74(%esi),%ebp
 34c:	3a 74 28 33          	cmp    0x33(%eax,%ebp,1),%dh
 350:	2c 38                	sub    $0x38,%al
 352:	29 3d 28 30 2c 36    	sub    %edi,0x362c3028
 358:	29 00                	sub    %eax,(%eax)
 35a:	75 69                	jne    3c5 <wait_KBC_sendready-0x27fc3b>
 35c:	6e                   	outsb  %ds:(%esi),(%dx)
 35d:	74 36                	je     395 <wait_KBC_sendready-0x27fc6b>
 35f:	34 5f                	xor    $0x5f,%al
 361:	74 3a                	je     39d <wait_KBC_sendready-0x27fc63>
 363:	74 28                	je     38d <wait_KBC_sendready-0x27fc73>
 365:	33 2c 39             	xor    (%ecx,%edi,1),%ebp
 368:	29 3d 28 30 2c 37    	sub    %edi,0x372c3028
 36e:	29 00                	sub    %eax,(%eax)
 370:	69 6e 74 70 74 72 5f 	imul   $0x5f727470,0x74(%esi),%ebp
 377:	74 3a                	je     3b3 <wait_KBC_sendready-0x27fc4d>
 379:	74 28                	je     3a3 <wait_KBC_sendready-0x27fc5d>
 37b:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 37e:	30 29                	xor    %ch,(%ecx)
 380:	3d 28 33 2c 36       	cmp    $0x362c3328,%eax
 385:	29 00                	sub    %eax,(%eax)
 387:	75 69                	jne    3f2 <wait_KBC_sendready-0x27fc0e>
 389:	6e                   	outsb  %ds:(%esi),(%dx)
 38a:	74 70                	je     3fc <wait_KBC_sendready-0x27fc04>
 38c:	74 72                	je     400 <wait_KBC_sendready-0x27fc00>
 38e:	5f                   	pop    %edi
 38f:	74 3a                	je     3cb <wait_KBC_sendready-0x27fc35>
 391:	74 28                	je     3bb <wait_KBC_sendready-0x27fc45>
 393:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 396:	31 29                	xor    %ebp,(%ecx)
 398:	3d 28 33 2c 37       	cmp    $0x372c3328,%eax
 39d:	29 00                	sub    %eax,(%eax)
 39f:	70 68                	jo     409 <wait_KBC_sendready-0x27fbf7>
 3a1:	79 73                	jns    416 <wait_KBC_sendready-0x27fbea>
 3a3:	61                   	popa   
 3a4:	64                   	fs
 3a5:	64                   	fs
 3a6:	72 5f                	jb     407 <wait_KBC_sendready-0x27fbf9>
 3a8:	74 3a                	je     3e4 <wait_KBC_sendready-0x27fc1c>
 3aa:	74 28                	je     3d4 <wait_KBC_sendready-0x27fc2c>
 3ac:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 3af:	32 29                	xor    (%ecx),%ch
 3b1:	3d 28 33 2c 37       	cmp    $0x372c3328,%eax
 3b6:	29 00                	sub    %eax,(%eax)
 3b8:	70 70                	jo     42a <wait_KBC_sendready-0x27fbd6>
 3ba:	6e                   	outsb  %ds:(%esi),(%dx)
 3bb:	5f                   	pop    %edi
 3bc:	74 3a                	je     3f8 <wait_KBC_sendready-0x27fc08>
 3be:	74 28                	je     3e8 <wait_KBC_sendready-0x27fc18>
 3c0:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 3c3:	33 29                	xor    (%ecx),%ebp
 3c5:	3d 28 33 2c 37       	cmp    $0x372c3328,%eax
 3ca:	29 00                	sub    %eax,(%eax)
 3cc:	73 69                	jae    437 <wait_KBC_sendready-0x27fbc9>
 3ce:	7a 65                	jp     435 <wait_KBC_sendready-0x27fbcb>
 3d0:	5f                   	pop    %edi
 3d1:	74 3a                	je     40d <wait_KBC_sendready-0x27fbf3>
 3d3:	74 28                	je     3fd <wait_KBC_sendready-0x27fc03>
 3d5:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 3d8:	34 29                	xor    $0x29,%al
 3da:	3d 28 33 2c 37       	cmp    $0x372c3328,%eax
 3df:	29 00                	sub    %eax,(%eax)
 3e1:	73 73                	jae    456 <wait_KBC_sendready-0x27fbaa>
 3e3:	69 7a 65 5f 74 3a 74 	imul   $0x743a745f,0x65(%edx),%edi
 3ea:	28 33                	sub    %dh,(%ebx)
 3ec:	2c 31                	sub    $0x31,%al
 3ee:	35 29 3d 28 33       	xor    $0x33283d29,%eax
 3f3:	2c 36                	sub    $0x36,%al
 3f5:	29 00                	sub    %eax,(%eax)
 3f7:	6f                   	outsl  %ds:(%esi),(%dx)
 3f8:	66 66 5f             	data32 pop %di
 3fb:	74 3a                	je     437 <wait_KBC_sendready-0x27fbc9>
 3fd:	74 28                	je     427 <wait_KBC_sendready-0x27fbd9>
 3ff:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 402:	36 29 3d 28 33 2c 36 	sub    %edi,%ss:0x362c3328
 409:	29 00                	sub    %eax,(%eax)
 40b:	46                   	inc    %esi
 40c:	49                   	dec    %ecx
 40d:	46                   	inc    %esi
 40e:	4f                   	dec    %edi
 40f:	38 3a                	cmp    %bh,(%edx)
 411:	54                   	push   %esp
 412:	28 31                	sub    %dh,(%ecx)
 414:	2c 31                	sub    $0x31,%al
 416:	29 3d 73 32 34 62    	sub    %edi,0x62343273
 41c:	75 66                	jne    484 <wait_KBC_sendready-0x27fb7c>
 41e:	3a 28                	cmp    (%eax),%ch
 420:	31 2c 32             	xor    %ebp,(%edx,%esi,1)
 423:	29 3d 2a 28 30 2c    	sub    %edi,0x2c30282a
 429:	31 31                	xor    %esi,(%ecx)
 42b:	29 2c 30             	sub    %ebp,(%eax,%esi,1)
 42e:	2c 33                	sub    $0x33,%al
 430:	32 3b                	xor    (%ebx),%bh
 432:	70 3a                	jo     46e <wait_KBC_sendready-0x27fb92>
 434:	28 30                	sub    %dh,(%eax)
 436:	2c 31                	sub    $0x31,%al
 438:	29 2c 33             	sub    %ebp,(%ebx,%esi,1)
 43b:	32 2c 33             	xor    (%ebx,%esi,1),%ch
 43e:	32 3b                	xor    (%ebx),%bh
 440:	71 3a                	jno    47c <wait_KBC_sendready-0x27fb84>
 442:	28 30                	sub    %dh,(%eax)
 444:	2c 31                	sub    $0x31,%al
 446:	29 2c 36             	sub    %ebp,(%esi,%esi,1)
 449:	34 2c                	xor    $0x2c,%al
 44b:	33 32                	xor    (%edx),%esi
 44d:	3b 73 69             	cmp    0x69(%ebx),%esi
 450:	7a 65                	jp     4b7 <wait_KBC_sendready-0x27fb49>
 452:	3a 28                	cmp    (%eax),%ch
 454:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 457:	29 2c 39             	sub    %ebp,(%ecx,%edi,1)
 45a:	36                   	ss
 45b:	2c 33                	sub    $0x33,%al
 45d:	32 3b                	xor    (%ebx),%bh
 45f:	66                   	data16
 460:	72 65                	jb     4c7 <wait_KBC_sendready-0x27fb39>
 462:	65 3a 28             	cmp    %gs:(%eax),%ch
 465:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 468:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 46b:	32 38                	xor    (%eax),%bh
 46d:	2c 33                	sub    $0x33,%al
 46f:	32 3b                	xor    (%ebx),%bh
 471:	66                   	data16
 472:	6c                   	insb   (%dx),%es:(%edi)
 473:	61                   	popa   
 474:	67 73 3a             	addr16 jae 4b1 <wait_KBC_sendready-0x27fb4f>
 477:	28 30                	sub    %dh,(%eax)
 479:	2c 31                	sub    $0x31,%al
 47b:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 47e:	36 30 2c 33          	xor    %ch,%ss:(%ebx,%esi,1)
 482:	32 3b                	xor    (%ebx),%bh
 484:	3b 00                	cmp    (%eax),%eax
 486:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 489:	74 5f                	je     4ea <wait_KBC_sendready-0x27fb16>
 48b:	69 6e 66 6f 3a 54 28 	imul   $0x28543a6f,0x66(%esi),%ebp
 492:	31 2c 33             	xor    %ebp,(%ebx,%esi,1)
 495:	29 3d 73 31 32 63    	sub    %edi,0x63323173
 49b:	79 6c                	jns    509 <wait_KBC_sendready-0x27faf7>
 49d:	69 6e 64 65 72 3a 28 	imul   $0x283a7265,0x64(%esi),%ebp
 4a4:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 4a7:	29 2c 30             	sub    %ebp,(%eax,%esi,1)
 4aa:	2c 38                	sub    $0x38,%al
 4ac:	3b 6c 65 64          	cmp    0x64(%ebp,%eiz,2),%ebp
 4b0:	3a 28                	cmp    (%eax),%ch
 4b2:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 4b5:	29 2c 38             	sub    %ebp,(%eax,%edi,1)
 4b8:	2c 38                	sub    $0x38,%al
 4ba:	3b 63 6f             	cmp    0x6f(%ebx),%esp
 4bd:	6c                   	insb   (%dx),%es:(%edi)
 4be:	6f                   	outsl  %ds:(%esi),(%dx)
 4bf:	72 5f                	jb     520 <wait_KBC_sendready-0x27fae0>
 4c1:	6d                   	insl   (%dx),%es:(%edi)
 4c2:	6f                   	outsl  %ds:(%esi),(%dx)
 4c3:	64 65 3a 28          	fs cmp %fs:%gs:(%eax),%ch
 4c7:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 4ca:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 4cd:	36                   	ss
 4ce:	2c 38                	sub    $0x38,%al
 4d0:	3b 72 65             	cmp    0x65(%edx),%esi
 4d3:	73 65                	jae    53a <wait_KBC_sendready-0x27fac6>
 4d5:	72 76                	jb     54d <wait_KBC_sendready-0x27fab3>
 4d7:	65 64 3a 28          	gs cmp %fs:%gs:(%eax),%ch
 4db:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 4de:	29 2c 32             	sub    %ebp,(%edx,%esi,1)
 4e1:	34 2c                	xor    $0x2c,%al
 4e3:	38 3b                	cmp    %bh,(%ebx)
 4e5:	78 73                	js     55a <wait_KBC_sendready-0x27faa6>
 4e7:	69 7a 65 3a 28 30 2c 	imul   $0x2c30283a,0x65(%edx),%edi
 4ee:	38 29                	cmp    %ch,(%ecx)
 4f0:	2c 33                	sub    $0x33,%al
 4f2:	32 2c 31             	xor    (%ecx,%esi,1),%ch
 4f5:	36 3b 79 73          	cmp    %ss:0x73(%ecx),%edi
 4f9:	69 7a 65 3a 28 30 2c 	imul   $0x2c30283a,0x65(%edx),%edi
 500:	38 29                	cmp    %ch,(%ecx)
 502:	2c 34                	sub    $0x34,%al
 504:	38 2c 31             	cmp    %ch,(%ecx,%esi,1)
 507:	36 3b 76 72          	cmp    %ss:0x72(%esi),%esi
 50b:	61                   	popa   
 50c:	6d                   	insl   (%dx),%es:(%edi)
 50d:	3a 28                	cmp    (%eax),%ch
 50f:	31 2c 34             	xor    %ebp,(%esp,%esi,1)
 512:	29 3d 2a 28 30 2c    	sub    %edi,0x2c30282a
 518:	32 29                	xor    (%ecx),%ch
 51a:	2c 36                	sub    $0x36,%al
 51c:	34 2c                	xor    $0x2c,%al
 51e:	33 32                	xor    (%edx),%esi
 520:	3b 3b                	cmp    (%ebx),%edi
 522:	00 47 44             	add    %al,0x44(%edi)
 525:	54                   	push   %esp
 526:	3a 54 28 31          	cmp    0x31(%eax,%ebp,1),%dl
 52a:	2c 35                	sub    $0x35,%al
 52c:	29 3d 73 38 6c 69    	sub    %edi,0x696c3873
 532:	6d                   	insl   (%dx),%es:(%edi)
 533:	69 74 5f 6c 6f 77 3a 	imul   $0x283a776f,0x6c(%edi,%ebx,2),%esi
 53a:	28 
 53b:	30 2c 38             	xor    %ch,(%eax,%edi,1)
 53e:	29 2c 30             	sub    %ebp,(%eax,%esi,1)
 541:	2c 31                	sub    $0x31,%al
 543:	36 3b 62 61          	cmp    %ss:0x61(%edx),%esp
 547:	73 65                	jae    5ae <wait_KBC_sendready-0x27fa52>
 549:	5f                   	pop    %edi
 54a:	6c                   	insb   (%dx),%es:(%edi)
 54b:	6f                   	outsl  %ds:(%esi),(%dx)
 54c:	77 3a                	ja     588 <wait_KBC_sendready-0x27fa78>
 54e:	28 30                	sub    %dh,(%eax)
 550:	2c 38                	sub    $0x38,%al
 552:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 555:	36                   	ss
 556:	2c 31                	sub    $0x31,%al
 558:	36 3b 62 61          	cmp    %ss:0x61(%edx),%esp
 55c:	73 65                	jae    5c3 <wait_KBC_sendready-0x27fa3d>
 55e:	5f                   	pop    %edi
 55f:	6d                   	insl   (%dx),%es:(%edi)
 560:	69 64 3a 28 30 2c 32 	imul   $0x29322c30,0x28(%edx,%edi,1),%esp
 567:	29 
 568:	2c 33                	sub    $0x33,%al
 56a:	32 2c 38             	xor    (%eax,%edi,1),%ch
 56d:	3b 61 63             	cmp    0x63(%ecx),%esp
 570:	63 65 73             	arpl   %sp,0x73(%ebp)
 573:	73 5f                	jae    5d4 <wait_KBC_sendready-0x27fa2c>
 575:	72 69                	jb     5e0 <wait_KBC_sendready-0x27fa20>
 577:	67 68 74 3a 28 30    	addr16 push $0x30283a74
 57d:	2c 32                	sub    $0x32,%al
 57f:	29 2c 34             	sub    %ebp,(%esp,%esi,1)
 582:	30 2c 38             	xor    %ch,(%eax,%edi,1)
 585:	3b 6c 69 6d          	cmp    0x6d(%ecx,%ebp,2),%ebp
 589:	69 74 5f 68 69 67 68 	imul   $0x3a686769,0x68(%edi,%ebx,2),%esi
 590:	3a 
 591:	28 30                	sub    %dh,(%eax)
 593:	2c 32                	sub    $0x32,%al
 595:	29 2c 34             	sub    %ebp,(%esp,%esi,1)
 598:	38 2c 38             	cmp    %ch,(%eax,%edi,1)
 59b:	3b 62 61             	cmp    0x61(%edx),%esp
 59e:	73 65                	jae    605 <wait_KBC_sendready-0x27f9fb>
 5a0:	5f                   	pop    %edi
 5a1:	68 69 67 68 3a       	push   $0x3a686769
 5a6:	28 30                	sub    %dh,(%eax)
 5a8:	2c 32                	sub    $0x32,%al
 5aa:	29 2c 35 36 2c 38 3b 	sub    %ebp,0x3b382c36(,%esi,1)
 5b1:	3b 00                	cmp    (%eax),%eax
 5b3:	49                   	dec    %ecx
 5b4:	44                   	inc    %esp
 5b5:	54                   	push   %esp
 5b6:	3a 54 28 31          	cmp    0x31(%eax,%ebp,1),%dl
 5ba:	2c 36                	sub    $0x36,%al
 5bc:	29 3d 73 38 6f 66    	sub    %edi,0x666f3873
 5c2:	66                   	data16
 5c3:	73 65                	jae    62a <wait_KBC_sendready-0x27f9d6>
 5c5:	74 5f                	je     626 <wait_KBC_sendready-0x27f9da>
 5c7:	6c                   	insb   (%dx),%es:(%edi)
 5c8:	6f                   	outsl  %ds:(%esi),(%dx)
 5c9:	77 3a                	ja     605 <wait_KBC_sendready-0x27f9fb>
 5cb:	28 30                	sub    %dh,(%eax)
 5cd:	2c 38                	sub    $0x38,%al
 5cf:	29 2c 30             	sub    %ebp,(%eax,%esi,1)
 5d2:	2c 31                	sub    $0x31,%al
 5d4:	36 3b 73 65          	cmp    %ss:0x65(%ebx),%esi
 5d8:	6c                   	insb   (%dx),%es:(%edi)
 5d9:	65 63 74 6f 72       	arpl   %si,%gs:0x72(%edi,%ebp,2)
 5de:	3a 28                	cmp    (%eax),%ch
 5e0:	30 2c 38             	xor    %ch,(%eax,%edi,1)
 5e3:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 5e6:	36                   	ss
 5e7:	2c 31                	sub    $0x31,%al
 5e9:	36 3b 64 77 5f       	cmp    %ss:0x5f(%edi,%esi,2),%esp
 5ee:	63 6f 75             	arpl   %bp,0x75(%edi)
 5f1:	6e                   	outsb  %ds:(%esi),(%dx)
 5f2:	74 3a                	je     62e <wait_KBC_sendready-0x27f9d2>
 5f4:	28 30                	sub    %dh,(%eax)
 5f6:	2c 32                	sub    $0x32,%al
 5f8:	29 2c 33             	sub    %ebp,(%ebx,%esi,1)
 5fb:	32 2c 38             	xor    (%eax,%edi,1),%ch
 5fe:	3b 61 63             	cmp    0x63(%ecx),%esp
 601:	63 65 73             	arpl   %sp,0x73(%ebp)
 604:	73 5f                	jae    665 <wait_KBC_sendready-0x27f99b>
 606:	72 69                	jb     671 <wait_KBC_sendready-0x27f98f>
 608:	67 68 74 3a 28 30    	addr16 push $0x30283a74
 60e:	2c 32                	sub    $0x32,%al
 610:	29 2c 34             	sub    %ebp,(%esp,%esi,1)
 613:	30 2c 38             	xor    %ch,(%eax,%edi,1)
 616:	3b 6f 66             	cmp    0x66(%edi),%ebp
 619:	66                   	data16
 61a:	73 65                	jae    681 <wait_KBC_sendready-0x27f97f>
 61c:	74 5f                	je     67d <wait_KBC_sendready-0x27f983>
 61e:	68 69 67 68 3a       	push   $0x3a686769
 623:	28 30                	sub    %dh,(%eax)
 625:	2c 38                	sub    $0x38,%al
 627:	29 2c 34             	sub    %ebp,(%esp,%esi,1)
 62a:	38 2c 31             	cmp    %ch,(%ecx,%esi,1)
 62d:	36 3b 3b             	cmp    %ss:(%ebx),%edi
 630:	00 77 61             	add    %dh,0x61(%edi)
 633:	69 74 5f 4b 42 43 5f 	imul   $0x735f4342,0x4b(%edi,%ebx,2),%esi
 63a:	73 
 63b:	65 6e                	outsb  %gs:(%esi),(%dx)
 63d:	64                   	fs
 63e:	72 65                	jb     6a5 <wait_KBC_sendready-0x27f95b>
 640:	61                   	popa   
 641:	64                   	fs
 642:	79 3a                	jns    67e <wait_KBC_sendready-0x27f982>
 644:	46                   	inc    %esi
 645:	28 30                	sub    %dh,(%eax)
 647:	2c 31                	sub    $0x31,%al
 649:	38 29                	cmp    %ch,(%ecx)
 64b:	00 69 6e             	add    %ch,0x6e(%ecx)
 64e:	69 74 5f 6b 65 79 62 	imul   $0x6f627965,0x6b(%edi,%ebx,2),%esi
 655:	6f 
 656:	61                   	popa   
 657:	72 64                	jb     6bd <wait_KBC_sendready-0x27f943>
 659:	3a 46 28             	cmp    0x28(%esi),%al
 65c:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 65f:	38 29                	cmp    %ch,(%ecx)
 661:	00 65 6e             	add    %ah,0x6e(%ebp)
 664:	61                   	popa   
 665:	62 6c 65 5f          	bound  %ebp,0x5f(%ebp,%eiz,2)
 669:	6d                   	insl   (%dx),%es:(%edi)
 66a:	6f                   	outsl  %ds:(%esi),(%dx)
 66b:	75 73                	jne    6e0 <wait_KBC_sendready-0x27f920>
 66d:	65 3a 46 28          	cmp    %gs:0x28(%esi),%al
 671:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 674:	38 29                	cmp    %ch,(%ecx)
 676:	00 62 6f             	add    %ah,0x6f(%edx)
 679:	6f                   	outsl  %ds:(%esi),(%dx)
 67a:	74 6d                	je     6e9 <wait_KBC_sendready-0x27f917>
 67c:	61                   	popa   
 67d:	69 6e 3a 46 28 30 2c 	imul   $0x2c302846,0x3a(%esi),%ebp
 684:	31 38                	xor    %edi,(%eax)
 686:	29 00                	sub    %eax,(%eax)
 688:	73 3a                	jae    6c4 <wait_KBC_sendready-0x27f93c>
 68a:	28 30                	sub    %dh,(%eax)
 68c:	2c 31                	sub    $0x31,%al
 68e:	39 29                	cmp    %ebp,(%ecx)
 690:	3d 61 72 28 30       	cmp    $0x30287261,%eax
 695:	2c 32                	sub    $0x32,%al
 697:	30 29                	xor    %ch,(%ecx)
 699:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 69e:	32 30                	xor    (%eax),%dh
 6a0:	29 3b                	sub    %edi,(%ebx)
 6a2:	30 3b                	xor    %bh,(%ebx)
 6a4:	34 32                	xor    $0x32,%al
 6a6:	39 34 39             	cmp    %esi,(%ecx,%edi,1)
 6a9:	36                   	ss
 6aa:	37                   	aaa    
 6ab:	32 39                	xor    (%ecx),%bh
 6ad:	35 3b 3b 30 3b       	xor    $0x3b303b3b,%eax
 6b2:	33 39                	xor    (%ecx),%edi
 6b4:	3b 28                	cmp    (%eax),%ebp
 6b6:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 6b9:	29 00                	sub    %eax,(%eax)
 6bb:	6d                   	insl   (%dx),%es:(%edi)
 6bc:	6f                   	outsl  %ds:(%esi),(%dx)
 6bd:	75 73                	jne    732 <wait_KBC_sendready-0x27f8ce>
 6bf:	65                   	gs
 6c0:	70 69                	jo     72b <wait_KBC_sendready-0x27f8d5>
 6c2:	63 3a                	arpl   %di,(%edx)
 6c4:	28 30                	sub    %dh,(%eax)
 6c6:	2c 32                	sub    $0x32,%al
 6c8:	31 29                	xor    %ebp,(%ecx)
 6ca:	3d 61 72 28 30       	cmp    $0x30287261,%eax
 6cf:	2c 32                	sub    $0x32,%al
 6d1:	30 29                	xor    %ch,(%ecx)
 6d3:	3b 30                	cmp    (%eax),%esi
 6d5:	3b 32                	cmp    (%edx),%esi
 6d7:	35 35 3b 28 30       	xor    $0x30283b35,%eax
 6dc:	2c 32                	sub    $0x32,%al
 6de:	29 00                	sub    %eax,(%eax)
 6e0:	6b 65 79 62          	imul   $0x62,0x79(%ebp),%esp
 6e4:	75 66                	jne    74c <wait_KBC_sendready-0x27f8b4>
 6e6:	3a 28                	cmp    (%eax),%ch
 6e8:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 6eb:	32 29                	xor    (%ecx),%ch
 6ed:	3d 61 72 28 30       	cmp    $0x30287261,%eax
 6f2:	2c 32                	sub    $0x32,%al
 6f4:	30 29                	xor    %ch,(%ecx)
 6f6:	3b 30                	cmp    (%eax),%esi
 6f8:	3b 33                	cmp    (%ebx),%esi
 6fa:	31 3b                	xor    %edi,(%ebx)
 6fc:	28 30                	sub    %dh,(%eax)
 6fe:	2c 32                	sub    $0x32,%al
 700:	29 00                	sub    %eax,(%eax)
 702:	6d                   	insl   (%dx),%es:(%edi)
 703:	6f                   	outsl  %ds:(%esi),(%dx)
 704:	75 73                	jne    779 <wait_KBC_sendready-0x27f887>
 706:	65 62 75 66          	bound  %esi,%gs:0x66(%ebp)
 70a:	3a 28                	cmp    (%eax),%ch
 70c:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 70f:	33 29                	xor    (%ecx),%ebp
 711:	3d 61 72 28 30       	cmp    $0x30287261,%eax
 716:	2c 32                	sub    $0x32,%al
 718:	30 29                	xor    %ch,(%ecx)
 71a:	3b 30                	cmp    (%eax),%esi
 71c:	3b 31                	cmp    (%ecx),%esi
 71e:	32 37                	xor    (%edi),%dh
 720:	3b 28                	cmp    (%eax),%ebp
 722:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 725:	29 00                	sub    %eax,(%eax)
 727:	41                   	inc    %ecx
 728:	53                   	push   %ebx
 729:	43                   	inc    %ebx
 72a:	49                   	dec    %ecx
 72b:	49                   	dec    %ecx
 72c:	5f                   	pop    %edi
 72d:	54                   	push   %esp
 72e:	61                   	popa   
 72f:	62 6c 65 3a          	bound  %ebp,0x3a(%ebp,%eiz,2)
 733:	47                   	inc    %edi
 734:	28 30                	sub    %dh,(%eax)
 736:	2c 32                	sub    $0x32,%al
 738:	34 29                	xor    $0x29,%al
 73a:	3d 61 72 28 30       	cmp    $0x30287261,%eax
 73f:	2c 32                	sub    $0x32,%al
 741:	30 29                	xor    %ch,(%ecx)
 743:	3b 30                	cmp    (%eax),%esi
 745:	3b 32                	cmp    (%edx),%esi
 747:	32 37                	xor    (%edi),%dh
 749:	39 3b                	cmp    %edi,(%ebx)
 74b:	28 30                	sub    %dh,(%eax)
 74d:	2c 39                	sub    $0x39,%al
 74f:	29 00                	sub    %eax,(%eax)
 751:	46                   	inc    %esi
 752:	6f                   	outsl  %ds:(%esi),(%dx)
 753:	6e                   	outsb  %ds:(%esi),(%dx)
 754:	74 38                	je     78e <wait_KBC_sendready-0x27f872>
 756:	78 31                	js     789 <wait_KBC_sendready-0x27f877>
 758:	36 3a 47 28          	cmp    %ss:0x28(%edi),%al
 75c:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 75f:	35 29 3d 61 72       	xor    $0x72613d29,%eax
 764:	28 30                	sub    %dh,(%eax)
 766:	2c 32                	sub    $0x32,%al
 768:	30 29                	xor    %ch,(%ecx)
 76a:	3b 30                	cmp    (%eax),%esi
 76c:	3b 32                	cmp    (%edx),%esi
 76e:	30 34 37             	xor    %dh,(%edi,%esi,1)
 771:	3b 28                	cmp    (%eax),%ebp
 773:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 776:	31 29                	xor    %ebp,(%ecx)
 778:	00 62 6f             	add    %ah,0x6f(%edx)
 77b:	6f                   	outsl  %ds:(%esi),(%dx)
 77c:	74 70                	je     7ee <wait_KBC_sendready-0x27f812>
 77e:	3a 47 28             	cmp    0x28(%edi),%al
 781:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 784:	36 29 3d 2a 28 31 2c 	sub    %edi,%ss:0x2c31282a
 78b:	33 29                	xor    (%ecx),%ebp
 78d:	00 73 63             	add    %dh,0x63(%ebx)
 790:	72 65                	jb     7f7 <wait_KBC_sendready-0x27f809>
 792:	65 6e                	outsb  %gs:(%esi),(%dx)
 794:	2e 63 00             	arpl   %ax,%cs:(%eax)
 797:	2e                   	cs
 798:	2f                   	das    
 799:	68 65 61 64 65       	push   $0x65646165
 79e:	72 2e                	jb     7ce <wait_KBC_sendready-0x27f832>
 7a0:	68 00 2e 2f 78       	push   $0x782f2e00
 7a5:	38 36                	cmp    %dh,(%esi)
 7a7:	2e                   	cs
 7a8:	68 00 2e 2f 74       	push   $0x742f2e00
 7ad:	79 70                	jns    81f <wait_KBC_sendready-0x27f7e1>
 7af:	65                   	gs
 7b0:	73 2e                	jae    7e0 <wait_KBC_sendready-0x27f820>
 7b2:	68 00 63 6c 65       	push   $0x656c6300
 7b7:	61                   	popa   
 7b8:	72 5f                	jb     819 <wait_KBC_sendready-0x27f7e7>
 7ba:	73 63                	jae    81f <wait_KBC_sendready-0x27f7e1>
 7bc:	72 65                	jb     823 <wait_KBC_sendready-0x27f7dd>
 7be:	65 6e                	outsb  %gs:(%esi),(%dx)
 7c0:	3a 46 28             	cmp    0x28(%esi),%al
 7c3:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 7c6:	38 29                	cmp    %ch,(%ecx)
 7c8:	00 63 6f             	add    %ah,0x6f(%ebx)
 7cb:	6c                   	insb   (%dx),%es:(%edi)
 7cc:	6f                   	outsl  %ds:(%esi),(%dx)
 7cd:	72 3a                	jb     809 <wait_KBC_sendready-0x27f7f7>
 7cf:	70 28                	jo     7f9 <wait_KBC_sendready-0x27f807>
 7d1:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 7d4:	29 00                	sub    %eax,(%eax)
 7d6:	69 3a 72 28 30 2c    	imul   $0x2c302872,(%edx),%edi
 7dc:	31 29                	xor    %ebp,(%ecx)
 7de:	00 63 6f             	add    %ah,0x6f(%ebx)
 7e1:	6c                   	insb   (%dx),%es:(%edi)
 7e2:	6f                   	outsl  %ds:(%esi),(%dx)
 7e3:	72 3a                	jb     81f <wait_KBC_sendready-0x27f7e1>
 7e5:	72 28                	jb     80f <wait_KBC_sendready-0x27f7f1>
 7e7:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 7ea:	29 00                	sub    %eax,(%eax)
 7ec:	63 6f 6c             	arpl   %bp,0x6c(%edi)
 7ef:	6f                   	outsl  %ds:(%esi),(%dx)
 7f0:	72 5f                	jb     851 <wait_KBC_sendready-0x27f7af>
 7f2:	73 63                	jae    857 <wait_KBC_sendready-0x27f7a9>
 7f4:	72 65                	jb     85b <wait_KBC_sendready-0x27f7a5>
 7f6:	65 6e                	outsb  %gs:(%esi),(%dx)
 7f8:	3a 46 28             	cmp    0x28(%esi),%al
 7fb:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 7fe:	38 29                	cmp    %ch,(%ecx)
 800:	00 73 65             	add    %dh,0x65(%ebx)
 803:	74 5f                	je     864 <wait_KBC_sendready-0x27f79c>
 805:	70 61                	jo     868 <wait_KBC_sendready-0x27f798>
 807:	6c                   	insb   (%dx),%es:(%edi)
 808:	65                   	gs
 809:	74 74                	je     87f <wait_KBC_sendready-0x27f781>
 80b:	65 3a 46 28          	cmp    %gs:0x28(%esi),%al
 80f:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 812:	38 29                	cmp    %ch,(%ecx)
 814:	00 73 74             	add    %dh,0x74(%ebx)
 817:	61                   	popa   
 818:	72 74                	jb     88e <wait_KBC_sendready-0x27f772>
 81a:	3a 70 28             	cmp    0x28(%eax),%dh
 81d:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 820:	29 00                	sub    %eax,(%eax)
 822:	65 6e                	outsb  %gs:(%esi),(%dx)
 824:	64 3a 70 28          	cmp    %fs:0x28(%eax),%dh
 828:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 82b:	29 00                	sub    %eax,(%eax)
 82d:	72 67                	jb     896 <wait_KBC_sendready-0x27f76a>
 82f:	62 3a                	bound  %edi,(%edx)
 831:	70 28                	jo     85b <wait_KBC_sendready-0x27f7a5>
 833:	31 2c 32             	xor    %ebp,(%edx,%esi,1)
 836:	29 00                	sub    %eax,(%eax)
 838:	73 74                	jae    8ae <wait_KBC_sendready-0x27f752>
 83a:	61                   	popa   
 83b:	72 74                	jb     8b1 <wait_KBC_sendready-0x27f74f>
 83d:	3a 72 28             	cmp    0x28(%edx),%dh
 840:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 843:	29 00                	sub    %eax,(%eax)
 845:	72 67                	jb     8ae <wait_KBC_sendready-0x27f752>
 847:	62 3a                	bound  %edi,(%edx)
 849:	72 28                	jb     873 <wait_KBC_sendready-0x27f78d>
 84b:	31 2c 32             	xor    %ebp,(%edx,%esi,1)
 84e:	29 00                	sub    %eax,(%eax)
 850:	69 6e 69 74 5f 70 61 	imul   $0x61705f74,0x69(%esi),%ebp
 857:	6c                   	insb   (%dx),%es:(%edi)
 858:	65                   	gs
 859:	74 74                	je     8cf <wait_KBC_sendready-0x27f731>
 85b:	65 3a 46 28          	cmp    %gs:0x28(%esi),%al
 85f:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 862:	38 29                	cmp    %ch,(%ecx)
 864:	00 74 61 62          	add    %dh,0x62(%ecx,%eiz,2)
 868:	6c                   	insb   (%dx),%es:(%edi)
 869:	65                   	gs
 86a:	5f                   	pop    %edi
 86b:	72 67                	jb     8d4 <wait_KBC_sendready-0x27f72c>
 86d:	62 3a                	bound  %edi,(%edx)
 86f:	28 30                	sub    %dh,(%eax)
 871:	2c 31                	sub    $0x31,%al
 873:	39 29                	cmp    %ebp,(%ecx)
 875:	3d 61 72 28 30       	cmp    $0x30287261,%eax
 87a:	2c 32                	sub    $0x32,%al
 87c:	30 29                	xor    %ch,(%ecx)
 87e:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 883:	32 30                	xor    (%eax),%dh
 885:	29 3b                	sub    %edi,(%ebx)
 887:	30 3b                	xor    %bh,(%ebx)
 889:	34 32                	xor    $0x32,%al
 88b:	39 34 39             	cmp    %esi,(%ecx,%edi,1)
 88e:	36                   	ss
 88f:	37                   	aaa    
 890:	32 39                	xor    (%ecx),%bh
 892:	35 3b 3b 30 3b       	xor    $0x3b303b3b,%eax
 897:	34 37                	xor    $0x37,%al
 899:	3b 28                	cmp    (%eax),%ebp
 89b:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 89e:	31 29                	xor    %ebp,(%ecx)
 8a0:	00 62 6f             	add    %ah,0x6f(%edx)
 8a3:	78 66                	js     90b <wait_KBC_sendready-0x27f6f5>
 8a5:	69 6c 6c 38 3a 46 28 	imul   $0x3028463a,0x38(%esp,%ebp,2),%ebp
 8ac:	30 
 8ad:	2c 31                	sub    $0x31,%al
 8af:	38 29                	cmp    %ch,(%ecx)
 8b1:	00 76 72             	add    %dh,0x72(%esi)
 8b4:	61                   	popa   
 8b5:	6d                   	insl   (%dx),%es:(%edi)
 8b6:	3a 70 28             	cmp    0x28(%eax),%dh
 8b9:	31 2c 32             	xor    %ebp,(%edx,%esi,1)
 8bc:	29 00                	sub    %eax,(%eax)
 8be:	78 73                	js     933 <wait_KBC_sendready-0x27f6cd>
 8c0:	69 7a 65 3a 70 28 30 	imul   $0x3028703a,0x65(%edx),%edi
 8c7:	2c 31                	sub    $0x31,%al
 8c9:	29 00                	sub    %eax,(%eax)
 8cb:	78 30                	js     8fd <wait_KBC_sendready-0x27f703>
 8cd:	3a 70 28             	cmp    0x28(%eax),%dh
 8d0:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 8d3:	29 00                	sub    %eax,(%eax)
 8d5:	79 30                	jns    907 <wait_KBC_sendready-0x27f6f9>
 8d7:	3a 70 28             	cmp    0x28(%eax),%dh
 8da:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 8dd:	29 00                	sub    %eax,(%eax)
 8df:	78 31                	js     912 <wait_KBC_sendready-0x27f6ee>
 8e1:	3a 70 28             	cmp    0x28(%eax),%dh
 8e4:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 8e7:	29 00                	sub    %eax,(%eax)
 8e9:	79 31                	jns    91c <wait_KBC_sendready-0x27f6e4>
 8eb:	3a 70 28             	cmp    0x28(%eax),%dh
 8ee:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 8f1:	29 00                	sub    %eax,(%eax)
 8f3:	63 6f 6c             	arpl   %bp,0x6c(%edi)
 8f6:	6f                   	outsl  %ds:(%esi),(%dx)
 8f7:	72 3a                	jb     933 <wait_KBC_sendready-0x27f6cd>
 8f9:	72 28                	jb     923 <wait_KBC_sendready-0x27f6dd>
 8fb:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 8fe:	31 29                	xor    %ebp,(%ecx)
 900:	00 79 30             	add    %bh,0x30(%ecx)
 903:	3a 72 28             	cmp    0x28(%edx),%dh
 906:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 909:	29 00                	sub    %eax,(%eax)
 90b:	62 6f 78             	bound  %ebp,0x78(%edi)
 90e:	66 69 6c 6c 3a 46 28 	imul   $0x2846,0x3a(%esp,%ebp,2),%bp
 915:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 918:	38 29                	cmp    %ch,(%ecx)
 91a:	00 64 72 61          	add    %ah,0x61(%edx,%esi,2)
 91e:	77 5f                	ja     97f <wait_KBC_sendready-0x27f681>
 920:	77 69                	ja     98b <wait_KBC_sendready-0x27f675>
 922:	6e                   	outsb  %ds:(%esi),(%dx)
 923:	64 6f                	outsl  %fs:(%esi),(%dx)
 925:	77 3a                	ja     961 <wait_KBC_sendready-0x27f69f>
 927:	46                   	inc    %esi
 928:	28 30                	sub    %dh,(%eax)
 92a:	2c 31                	sub    $0x31,%al
 92c:	38 29                	cmp    %ch,(%ecx)
 92e:	00 69 6e             	add    %ch,0x6e(%ecx)
 931:	69 74 5f 73 63 72 65 	imul   $0x65657263,0x73(%edi,%ebx,2),%esi
 938:	65 
 939:	6e                   	outsb  %ds:(%esi),(%dx)
 93a:	3a 46 28             	cmp    0x28(%esi),%al
 93d:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 940:	38 29                	cmp    %ch,(%ecx)
 942:	00 62 6f             	add    %ah,0x6f(%edx)
 945:	6f                   	outsl  %ds:(%esi),(%dx)
 946:	74 70                	je     9b8 <wait_KBC_sendready-0x27f648>
 948:	3a 70 28             	cmp    0x28(%eax),%dh
 94b:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 94e:	31 29                	xor    %ebp,(%ecx)
 950:	3d 2a 28 31 2c       	cmp    $0x2c31282a,%eax
 955:	33 29                	xor    (%ecx),%ebp
 957:	00 62 6f             	add    %ah,0x6f(%edx)
 95a:	6f                   	outsl  %ds:(%esi),(%dx)
 95b:	74 70                	je     9cd <wait_KBC_sendready-0x27f633>
 95d:	3a 72 28             	cmp    0x28(%edx),%dh
 960:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 963:	31 29                	xor    %ebp,(%ecx)
 965:	00 69 6e             	add    %ch,0x6e(%ecx)
 968:	69 74 5f 6d 6f 75 73 	imul   $0x6573756f,0x6d(%edi,%ebx,2),%esi
 96f:	65 
 970:	3a 46 28             	cmp    0x28(%esi),%al
 973:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 976:	38 29                	cmp    %ch,(%ecx)
 978:	00 6d 6f             	add    %ch,0x6f(%ebp)
 97b:	75 73                	jne    9f0 <wait_KBC_sendready-0x27f610>
 97d:	65 3a 70 28          	cmp    %gs:0x28(%eax),%dh
 981:	31 2c 34             	xor    %ebp,(%esp,%esi,1)
 984:	29 00                	sub    %eax,(%eax)
 986:	62 67 3a             	bound  %esp,0x3a(%edi)
 989:	70 28                	jo     9b3 <wait_KBC_sendready-0x27f64d>
 98b:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 98e:	29 00                	sub    %eax,(%eax)
 990:	63 75 72             	arpl   %si,0x72(%ebp)
 993:	73 6f                	jae    a04 <wait_KBC_sendready-0x27f5fc>
 995:	72 3a                	jb     9d1 <wait_KBC_sendready-0x27f62f>
 997:	56                   	push   %esi
 998:	28 30                	sub    %dh,(%eax)
 99a:	2c 32                	sub    $0x32,%al
 99c:	32 29                	xor    (%ecx),%ch
 99e:	3d 61 72 28 30       	cmp    $0x30287261,%eax
 9a3:	2c 32                	sub    $0x32,%al
 9a5:	30 29                	xor    %ch,(%ecx)
 9a7:	3b 30                	cmp    (%eax),%esi
 9a9:	3b 31                	cmp    (%ecx),%esi
 9ab:	35 3b 28 30 2c       	xor    $0x2c30283b,%eax
 9b0:	32 33                	xor    (%ebx),%dh
 9b2:	29 3d 61 72 28 30    	sub    %edi,0x30287261
 9b8:	2c 32                	sub    $0x32,%al
 9ba:	30 29                	xor    %ch,(%ecx)
 9bc:	3b 30                	cmp    (%eax),%esi
 9be:	3b 31                	cmp    (%ecx),%esi
 9c0:	35 3b 28 30 2c       	xor    $0x2c30283b,%eax
 9c5:	32 29                	xor    (%ecx),%ch
 9c7:	00 78 3a             	add    %bh,0x3a(%eax)
 9ca:	72 28                	jb     9f4 <wait_KBC_sendready-0x27f60c>
 9cc:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 9cf:	29 00                	sub    %eax,(%eax)
 9d1:	62 67 3a             	bound  %esp,0x3a(%edi)
 9d4:	72 28                	jb     9fe <wait_KBC_sendready-0x27f602>
 9d6:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 9d9:	29 00                	sub    %eax,(%eax)
 9db:	64 69 73 70 6c 61 79 	imul   $0x5f79616c,%fs:0x70(%ebx),%esi
 9e2:	5f 
 9e3:	6d                   	insl   (%dx),%es:(%edi)
 9e4:	6f                   	outsl  %ds:(%esi),(%dx)
 9e5:	75 73                	jne    a5a <wait_KBC_sendready-0x27f5a6>
 9e7:	65 3a 46 28          	cmp    %gs:0x28(%esi),%al
 9eb:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 9ee:	38 29                	cmp    %ch,(%ecx)
 9f0:	00 76 72             	add    %dh,0x72(%esi)
 9f3:	61                   	popa   
 9f4:	6d                   	insl   (%dx),%es:(%edi)
 9f5:	3a 70 28             	cmp    0x28(%eax),%dh
 9f8:	31 2c 34             	xor    %ebp,(%esp,%esi,1)
 9fb:	29 00                	sub    %eax,(%eax)
 9fd:	70 78                	jo     a77 <wait_KBC_sendready-0x27f589>
 9ff:	73 69                	jae    a6a <wait_KBC_sendready-0x27f596>
 a01:	7a 65                	jp     a68 <wait_KBC_sendready-0x27f598>
 a03:	3a 70 28             	cmp    0x28(%eax),%dh
 a06:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 a09:	29 00                	sub    %eax,(%eax)
 a0b:	70 79                	jo     a86 <wait_KBC_sendready-0x27f57a>
 a0d:	73 69                	jae    a78 <wait_KBC_sendready-0x27f588>
 a0f:	7a 65                	jp     a76 <wait_KBC_sendready-0x27f58a>
 a11:	3a 70 28             	cmp    0x28(%eax),%dh
 a14:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 a17:	29 00                	sub    %eax,(%eax)
 a19:	70 78                	jo     a93 <wait_KBC_sendready-0x27f56d>
 a1b:	30 3a                	xor    %bh,(%edx)
 a1d:	70 28                	jo     a47 <wait_KBC_sendready-0x27f5b9>
 a1f:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 a22:	29 00                	sub    %eax,(%eax)
 a24:	70 79                	jo     a9f <wait_KBC_sendready-0x27f561>
 a26:	30 3a                	xor    %bh,(%edx)
 a28:	70 28                	jo     a52 <wait_KBC_sendready-0x27f5ae>
 a2a:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 a2d:	29 00                	sub    %eax,(%eax)
 a2f:	62 75 66             	bound  %esi,0x66(%ebp)
 a32:	3a 70 28             	cmp    0x28(%eax),%dh
 a35:	31 2c 34             	xor    %ebp,(%esp,%esi,1)
 a38:	29 00                	sub    %eax,(%eax)
 a3a:	62 78 73             	bound  %edi,0x73(%eax)
 a3d:	69 7a 65 3a 70 28 30 	imul   $0x3028703a,0x65(%edx),%edi
 a44:	2c 31                	sub    $0x31,%al
 a46:	29 00                	sub    %eax,(%eax)
 a48:	79 3a                	jns    a84 <wait_KBC_sendready-0x27f57c>
 a4a:	72 28                	jb     a74 <wait_KBC_sendready-0x27f58c>
 a4c:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 a4f:	29 00                	sub    %eax,(%eax)
 a51:	66 6f                	outsw  %ds:(%esi),(%dx)
 a53:	6e                   	outsb  %ds:(%esi),(%dx)
 a54:	74 2e                	je     a84 <wait_KBC_sendready-0x27f57c>
 a56:	63 00                	arpl   %ax,(%eax)
 a58:	70 72                	jo     acc <wait_KBC_sendready-0x27f534>
 a5a:	69 6e 74 2e 63 00 69 	imul   $0x6900632e,0x74(%esi),%ebp
 a61:	74 6f                	je     ad2 <wait_KBC_sendready-0x27f52e>
 a63:	61                   	popa   
 a64:	3a 46 28             	cmp    0x28(%esi),%al
 a67:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 a6a:	38 29                	cmp    %ch,(%ecx)
 a6c:	00 76 61             	add    %dh,0x61(%esi)
 a6f:	6c                   	insb   (%dx),%es:(%edi)
 a70:	75 65                	jne    ad7 <wait_KBC_sendready-0x27f529>
 a72:	3a 70 28             	cmp    0x28(%eax),%dh
 a75:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 a78:	29 00                	sub    %eax,(%eax)
 a7a:	74 6d                	je     ae9 <wait_KBC_sendready-0x27f517>
 a7c:	70 5f                	jo     add <wait_KBC_sendready-0x27f523>
 a7e:	62 75 66             	bound  %esi,0x66(%ebp)
 a81:	3a 28                	cmp    (%eax),%ch
 a83:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 a86:	39 29                	cmp    %ebp,(%ecx)
 a88:	3d 61 72 28 30       	cmp    $0x30287261,%eax
 a8d:	2c 32                	sub    $0x32,%al
 a8f:	30 29                	xor    %ch,(%ecx)
 a91:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 a96:	32 30                	xor    (%eax),%dh
 a98:	29 3b                	sub    %edi,(%ebx)
 a9a:	30 3b                	xor    %bh,(%ebx)
 a9c:	34 32                	xor    $0x32,%al
 a9e:	39 34 39             	cmp    %esi,(%ecx,%edi,1)
 aa1:	36                   	ss
 aa2:	37                   	aaa    
 aa3:	32 39                	xor    (%ecx),%bh
 aa5:	35 3b 3b 30 3b       	xor    $0x3b303b3b,%eax
 aaa:	39 3b                	cmp    %edi,(%ebx)
 aac:	28 30                	sub    %dh,(%eax)
 aae:	2c 32                	sub    $0x32,%al
 ab0:	29 00                	sub    %eax,(%eax)
 ab2:	76 61                	jbe    b15 <wait_KBC_sendready-0x27f4eb>
 ab4:	6c                   	insb   (%dx),%es:(%edi)
 ab5:	75 65                	jne    b1c <wait_KBC_sendready-0x27f4e4>
 ab7:	3a 72 28             	cmp    0x28(%edx),%dh
 aba:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 abd:	29 00                	sub    %eax,(%eax)
 abf:	62 75 66             	bound  %esi,0x66(%ebp)
 ac2:	3a 72 28             	cmp    0x28(%edx),%dh
 ac5:	31 2c 34             	xor    %ebp,(%esp,%esi,1)
 ac8:	29 00                	sub    %eax,(%eax)
 aca:	78 74                	js     b40 <wait_KBC_sendready-0x27f4c0>
 acc:	6f                   	outsl  %ds:(%esi),(%dx)
 acd:	61                   	popa   
 ace:	3a 46 28             	cmp    0x28(%esi),%al
 ad1:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 ad4:	38 29                	cmp    %ch,(%ecx)
 ad6:	00 76 61             	add    %dh,0x61(%esi)
 ad9:	6c                   	insb   (%dx),%es:(%edi)
 ada:	75 65                	jne    b41 <wait_KBC_sendready-0x27f4bf>
 adc:	3a 70 28             	cmp    0x28(%eax),%dh
 adf:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 ae2:	29 00                	sub    %eax,(%eax)
 ae4:	74 6d                	je     b53 <wait_KBC_sendready-0x27f4ad>
 ae6:	70 5f                	jo     b47 <wait_KBC_sendready-0x27f4b9>
 ae8:	62 75 66             	bound  %esi,0x66(%ebp)
 aeb:	3a 28                	cmp    (%eax),%ch
 aed:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 af0:	31 29                	xor    %ebp,(%ecx)
 af2:	3d 61 72 28 30       	cmp    $0x30287261,%eax
 af7:	2c 32                	sub    $0x32,%al
 af9:	30 29                	xor    %ch,(%ecx)
 afb:	3b 30                	cmp    (%eax),%esi
 afd:	3b 32                	cmp    (%edx),%esi
 aff:	39 3b                	cmp    %edi,(%ebx)
 b01:	28 30                	sub    %dh,(%eax)
 b03:	2c 32                	sub    $0x32,%al
 b05:	29 00                	sub    %eax,(%eax)
 b07:	73 70                	jae    b79 <wait_KBC_sendready-0x27f487>
 b09:	72 69                	jb     b74 <wait_KBC_sendready-0x27f48c>
 b0b:	6e                   	outsb  %ds:(%esi),(%dx)
 b0c:	74 66                	je     b74 <wait_KBC_sendready-0x27f48c>
 b0e:	3a 46 28             	cmp    0x28(%esi),%al
 b11:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 b14:	38 29                	cmp    %ch,(%ecx)
 b16:	00 73 74             	add    %dh,0x74(%ebx)
 b19:	72 3a                	jb     b55 <wait_KBC_sendready-0x27f4ab>
 b1b:	70 28                	jo     b45 <wait_KBC_sendready-0x27f4bb>
 b1d:	31 2c 34             	xor    %ebp,(%esp,%esi,1)
 b20:	29 00                	sub    %eax,(%eax)
 b22:	66 6f                	outsw  %ds:(%esi),(%dx)
 b24:	72 6d                	jb     b93 <wait_KBC_sendready-0x27f46d>
 b26:	61                   	popa   
 b27:	74 3a                	je     b63 <wait_KBC_sendready-0x27f49d>
 b29:	70 28                	jo     b53 <wait_KBC_sendready-0x27f4ad>
 b2b:	31 2c 34             	xor    %ebp,(%esp,%esi,1)
 b2e:	29 00                	sub    %eax,(%eax)
 b30:	76 61                	jbe    b93 <wait_KBC_sendready-0x27f46d>
 b32:	72 3a                	jb     b6e <wait_KBC_sendready-0x27f492>
 b34:	72 28                	jb     b5e <wait_KBC_sendready-0x27f4a2>
 b36:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 b39:	32 29                	xor    (%ecx),%ch
 b3b:	3d 2a 28 30 2c       	cmp    $0x2c30282a,%eax
 b40:	31 29                	xor    %ebp,(%ecx)
 b42:	00 62 75             	add    %ah,0x75(%edx)
 b45:	66                   	data16
 b46:	66                   	data16
 b47:	65                   	gs
 b48:	72 3a                	jb     b84 <wait_KBC_sendready-0x27f47c>
 b4a:	28 30                	sub    %dh,(%eax)
 b4c:	2c 31                	sub    $0x31,%al
 b4e:	39 29                	cmp    %ebp,(%ecx)
 b50:	00 73 74             	add    %dh,0x74(%ebx)
 b53:	72 3a                	jb     b8f <wait_KBC_sendready-0x27f471>
 b55:	72 28                	jb     b7f <wait_KBC_sendready-0x27f481>
 b57:	31 2c 34             	xor    %ebp,(%esp,%esi,1)
 b5a:	29 00                	sub    %eax,(%eax)
 b5c:	70 75                	jo     bd3 <wait_KBC_sendready-0x27f42d>
 b5e:	74 66                	je     bc6 <wait_KBC_sendready-0x27f43a>
 b60:	6f                   	outsl  %ds:(%esi),(%dx)
 b61:	6e                   	outsb  %ds:(%esi),(%dx)
 b62:	74 38                	je     b9c <wait_KBC_sendready-0x27f464>
 b64:	3a 46 28             	cmp    0x28(%esi),%al
 b67:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 b6a:	38 29                	cmp    %ch,(%ecx)
 b6c:	00 78 3a             	add    %bh,0x3a(%eax)
 b6f:	70 28                	jo     b99 <wait_KBC_sendready-0x27f467>
 b71:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 b74:	29 00                	sub    %eax,(%eax)
 b76:	79 3a                	jns    bb2 <wait_KBC_sendready-0x27f44e>
 b78:	70 28                	jo     ba2 <wait_KBC_sendready-0x27f45e>
 b7a:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 b7d:	29 00                	sub    %eax,(%eax)
 b7f:	66 6f                	outsw  %ds:(%esi),(%dx)
 b81:	6e                   	outsb  %ds:(%esi),(%dx)
 b82:	74 3a                	je     bbe <wait_KBC_sendready-0x27f442>
 b84:	70 28                	jo     bae <wait_KBC_sendready-0x27f452>
 b86:	31 2c 34             	xor    %ebp,(%esp,%esi,1)
 b89:	29 00                	sub    %eax,(%eax)
 b8b:	72 6f                	jb     bfc <wait_KBC_sendready-0x27f404>
 b8d:	77 3a                	ja     bc9 <wait_KBC_sendready-0x27f437>
 b8f:	72 28                	jb     bb9 <wait_KBC_sendready-0x27f447>
 b91:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 b94:	29 00                	sub    %eax,(%eax)
 b96:	63 6f 6c             	arpl   %bp,0x6c(%edi)
 b99:	3a 72 28             	cmp    0x28(%edx),%dh
 b9c:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 b9f:	29 00                	sub    %eax,(%eax)
 ba1:	70 75                	jo     c18 <wait_KBC_sendready-0x27f3e8>
 ba3:	74 73                	je     c18 <wait_KBC_sendready-0x27f3e8>
 ba5:	38 3a                	cmp    %bh,(%edx)
 ba7:	46                   	inc    %esi
 ba8:	28 30                	sub    %dh,(%eax)
 baa:	2c 31                	sub    $0x31,%al
 bac:	38 29                	cmp    %ch,(%ecx)
 bae:	00 70 72             	add    %dh,0x72(%eax)
 bb1:	69 6e 74 64 65 62 75 	imul   $0x75626564,0x74(%esi),%ebp
 bb8:	67 3a 46 28          	cmp    0x28(%bp),%al
 bbc:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 bbf:	38 29                	cmp    %ch,(%ecx)
 bc1:	00 69 3a             	add    %ch,0x3a(%ecx)
 bc4:	70 28                	jo     bee <wait_KBC_sendready-0x27f412>
 bc6:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 bc9:	29 00                	sub    %eax,(%eax)
 bcb:	66 6f                	outsw  %ds:(%esi),(%dx)
 bcd:	6e                   	outsb  %ds:(%esi),(%dx)
 bce:	74 3a                	je     c0a <wait_KBC_sendready-0x27f3f6>
 bd0:	28 30                	sub    %dh,(%eax)
 bd2:	2c 32                	sub    $0x32,%al
 bd4:	31 29                	xor    %ebp,(%ecx)
 bd6:	00 70 75             	add    %dh,0x75(%eax)
 bd9:	74 66                	je     c41 <wait_KBC_sendready-0x27f3bf>
 bdb:	6f                   	outsl  %ds:(%esi),(%dx)
 bdc:	6e                   	outsb  %ds:(%esi),(%dx)
 bdd:	74 31                	je     c10 <wait_KBC_sendready-0x27f3f0>
 bdf:	36 3a 46 28          	cmp    %ss:0x28(%esi),%al
 be3:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 be6:	38 29                	cmp    %ch,(%ecx)
 be8:	00 66 6f             	add    %ah,0x6f(%esi)
 beb:	6e                   	outsb  %ds:(%esi),(%dx)
 bec:	74 3a                	je     c28 <wait_KBC_sendready-0x27f3d8>
 bee:	70 28                	jo     c18 <wait_KBC_sendready-0x27f3e8>
 bf0:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 bf3:	33 29                	xor    (%ecx),%ebp
 bf5:	3d 2a 28 30 2c       	cmp    $0x2c30282a,%eax
 bfa:	39 29                	cmp    %ebp,(%ecx)
 bfc:	00 70 75             	add    %dh,0x75(%eax)
 bff:	74 73                	je     c74 <wait_KBC_sendready-0x27f38c>
 c01:	31 36                	xor    %esi,(%esi)
 c03:	3a 46 28             	cmp    0x28(%esi),%al
 c06:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c09:	38 29                	cmp    %ch,(%ecx)
 c0b:	00 69 64             	add    %ch,0x64(%ecx)
 c0e:	74 67                	je     c77 <wait_KBC_sendready-0x27f389>
 c10:	64                   	fs
 c11:	74 2e                	je     c41 <wait_KBC_sendready-0x27f3bf>
 c13:	63 00                	arpl   %ax,(%eax)
 c15:	73 65                	jae    c7c <wait_KBC_sendready-0x27f384>
 c17:	74 67                	je     c80 <wait_KBC_sendready-0x27f380>
 c19:	64                   	fs
 c1a:	74 3a                	je     c56 <wait_KBC_sendready-0x27f3aa>
 c1c:	46                   	inc    %esi
 c1d:	28 30                	sub    %dh,(%eax)
 c1f:	2c 31                	sub    $0x31,%al
 c21:	38 29                	cmp    %ch,(%ecx)
 c23:	00 73 64             	add    %dh,0x64(%ebx)
 c26:	3a 70 28             	cmp    0x28(%eax),%dh
 c29:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c2c:	39 29                	cmp    %ebp,(%ecx)
 c2e:	3d 2a 28 31 2c       	cmp    $0x2c31282a,%eax
 c33:	35 29 00 6c 69       	xor    $0x696c0029,%eax
 c38:	6d                   	insl   (%dx),%es:(%edi)
 c39:	69 74 3a 70 28 30 2c 	imul   $0x342c3028,0x70(%edx,%edi,1),%esi
 c40:	34 
 c41:	29 00                	sub    %eax,(%eax)
 c43:	62 61 73             	bound  %esp,0x73(%ecx)
 c46:	65 3a 70 28          	cmp    %gs:0x28(%eax),%dh
 c4a:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c4d:	29 00                	sub    %eax,(%eax)
 c4f:	61                   	popa   
 c50:	63 63 65             	arpl   %sp,0x65(%ebx)
 c53:	73 73                	jae    cc8 <wait_KBC_sendready-0x27f338>
 c55:	3a 70 28             	cmp    0x28(%eax),%dh
 c58:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c5b:	29 00                	sub    %eax,(%eax)
 c5d:	73 64                	jae    cc3 <wait_KBC_sendready-0x27f33d>
 c5f:	3a 72 28             	cmp    0x28(%edx),%dh
 c62:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c65:	39 29                	cmp    %ebp,(%ecx)
 c67:	00 6c 69 6d          	add    %ch,0x6d(%ecx,%ebp,2)
 c6b:	69 74 3a 72 28 30 2c 	imul   $0x342c3028,0x72(%edx,%edi,1),%esi
 c72:	34 
 c73:	29 00                	sub    %eax,(%eax)
 c75:	62 61 73             	bound  %esp,0x73(%ecx)
 c78:	65 3a 72 28          	cmp    %gs:0x28(%edx),%dh
 c7c:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c7f:	29 00                	sub    %eax,(%eax)
 c81:	61                   	popa   
 c82:	63 63 65             	arpl   %sp,0x65(%ebx)
 c85:	73 73                	jae    cfa <wait_KBC_sendready-0x27f306>
 c87:	3a 72 28             	cmp    0x28(%edx),%dh
 c8a:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c8d:	29 00                	sub    %eax,(%eax)
 c8f:	73 65                	jae    cf6 <wait_KBC_sendready-0x27f30a>
 c91:	74 69                	je     cfc <wait_KBC_sendready-0x27f304>
 c93:	64                   	fs
 c94:	74 3a                	je     cd0 <wait_KBC_sendready-0x27f330>
 c96:	46                   	inc    %esi
 c97:	28 30                	sub    %dh,(%eax)
 c99:	2c 31                	sub    $0x31,%al
 c9b:	38 29                	cmp    %ch,(%ecx)
 c9d:	00 67 64             	add    %ah,0x64(%edi)
 ca0:	3a 70 28             	cmp    0x28(%eax),%dh
 ca3:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 ca6:	30 29                	xor    %ch,(%ecx)
 ca8:	3d 2a 28 31 2c       	cmp    $0x2c31282a,%eax
 cad:	36 29 00             	sub    %eax,%ss:(%eax)
 cb0:	6f                   	outsl  %ds:(%esi),(%dx)
 cb1:	66                   	data16
 cb2:	66                   	data16
 cb3:	73 65                	jae    d1a <wait_KBC_sendready-0x27f2e6>
 cb5:	74 3a                	je     cf1 <wait_KBC_sendready-0x27f30f>
 cb7:	70 28                	jo     ce1 <wait_KBC_sendready-0x27f31f>
 cb9:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 cbc:	29 00                	sub    %eax,(%eax)
 cbe:	73 65                	jae    d25 <wait_KBC_sendready-0x27f2db>
 cc0:	6c                   	insb   (%dx),%es:(%edi)
 cc1:	65 63 74 6f 72       	arpl   %si,%gs:0x72(%edi,%ebp,2)
 cc6:	3a 70 28             	cmp    0x28(%eax),%dh
 cc9:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 ccc:	29 00                	sub    %eax,(%eax)
 cce:	67 64 3a 72 28       	cmp    %fs:0x28(%bp,%si),%dh
 cd3:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 cd6:	30 29                	xor    %ch,(%ecx)
 cd8:	00 6f 66             	add    %ch,0x66(%edi)
 cdb:	66                   	data16
 cdc:	73 65                	jae    d43 <wait_KBC_sendready-0x27f2bd>
 cde:	74 3a                	je     d1a <wait_KBC_sendready-0x27f2e6>
 ce0:	72 28                	jb     d0a <wait_KBC_sendready-0x27f2f6>
 ce2:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 ce5:	29 00                	sub    %eax,(%eax)
 ce7:	73 65                	jae    d4e <wait_KBC_sendready-0x27f2b2>
 ce9:	6c                   	insb   (%dx),%es:(%edi)
 cea:	65 63 74 6f 72       	arpl   %si,%gs:0x72(%edi,%ebp,2)
 cef:	3a 72 28             	cmp    0x28(%edx),%dh
 cf2:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 cf5:	29 00                	sub    %eax,(%eax)
 cf7:	69 6e 69 74 5f 67 64 	imul   $0x64675f74,0x69(%esi),%ebp
 cfe:	74 69                	je     d69 <wait_KBC_sendready-0x27f297>
 d00:	64                   	fs
 d01:	74 3a                	je     d3d <wait_KBC_sendready-0x27f2c3>
 d03:	46                   	inc    %esi
 d04:	28 30                	sub    %dh,(%eax)
 d06:	2c 31                	sub    $0x31,%al
 d08:	38 29                	cmp    %ch,(%ecx)
 d0a:	00 69 6e             	add    %ch,0x6e(%ecx)
 d0d:	74 2e                	je     d3d <wait_KBC_sendready-0x27f2c3>
 d0f:	63 00                	arpl   %ax,(%eax)
 d11:	69 6e 69 74 5f 70 69 	imul   $0x69705f74,0x69(%esi),%ebp
 d18:	63 3a                	arpl   %di,(%edx)
 d1a:	46                   	inc    %esi
 d1b:	28 30                	sub    %dh,(%eax)
 d1d:	2c 31                	sub    $0x31,%al
 d1f:	38 29                	cmp    %ch,(%ecx)
 d21:	00 69 6e             	add    %ch,0x6e(%ecx)
 d24:	74 68                	je     d8e <wait_KBC_sendready-0x27f272>
 d26:	61                   	popa   
 d27:	6e                   	outsb  %ds:(%esi),(%dx)
 d28:	64                   	fs
 d29:	6c                   	insb   (%dx),%es:(%edi)
 d2a:	65                   	gs
 d2b:	72 32                	jb     d5f <wait_KBC_sendready-0x27f2a1>
 d2d:	31 3a                	xor    %edi,(%edx)
 d2f:	46                   	inc    %esi
 d30:	28 30                	sub    %dh,(%eax)
 d32:	2c 31                	sub    $0x31,%al
 d34:	38 29                	cmp    %ch,(%ecx)
 d36:	00 65 73             	add    %ah,0x73(%ebp)
 d39:	70 3a                	jo     d75 <wait_KBC_sendready-0x27f28b>
 d3b:	70 28                	jo     d65 <wait_KBC_sendready-0x27f29b>
 d3d:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 d40:	39 29                	cmp    %ebp,(%ecx)
 d42:	3d 2a 28 30 2c       	cmp    $0x2c30282a,%eax
 d47:	31 29                	xor    %ebp,(%ecx)
 d49:	00 69 6e             	add    %ch,0x6e(%ecx)
 d4c:	74 68                	je     db6 <wait_KBC_sendready-0x27f24a>
 d4e:	61                   	popa   
 d4f:	6e                   	outsb  %ds:(%esi),(%dx)
 d50:	64                   	fs
 d51:	6c                   	insb   (%dx),%es:(%edi)
 d52:	65                   	gs
 d53:	72 32                	jb     d87 <wait_KBC_sendready-0x27f279>
 d55:	63 3a                	arpl   %di,(%edx)
 d57:	46                   	inc    %esi
 d58:	28 30                	sub    %dh,(%eax)
 d5a:	2c 31                	sub    $0x31,%al
 d5c:	38 29                	cmp    %ch,(%ecx)
 d5e:	00 65 73             	add    %ah,0x73(%ebp)
 d61:	70 3a                	jo     d9d <wait_KBC_sendready-0x27f263>
 d63:	70 28                	jo     d8d <wait_KBC_sendready-0x27f273>
 d65:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 d68:	39 29                	cmp    %ebp,(%ecx)
 d6a:	00 69 6e             	add    %ch,0x6e(%ecx)
 d6d:	74 68                	je     dd7 <wait_KBC_sendready-0x27f229>
 d6f:	61                   	popa   
 d70:	6e                   	outsb  %ds:(%esi),(%dx)
 d71:	64                   	fs
 d72:	6c                   	insb   (%dx),%es:(%edi)
 d73:	65                   	gs
 d74:	72 32                	jb     da8 <wait_KBC_sendready-0x27f258>
 d76:	37                   	aaa    
 d77:	3a 46 28             	cmp    0x28(%esi),%al
 d7a:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 d7d:	38 29                	cmp    %ch,(%ecx)
 d7f:	00 6b 65             	add    %ch,0x65(%ebx)
 d82:	79 66                	jns    dea <wait_KBC_sendready-0x27f216>
 d84:	69 66 6f 3a 47 28 31 	imul   $0x3128473a,0x6f(%esi),%esp
 d8b:	2c 31                	sub    $0x31,%al
 d8d:	29 00                	sub    %eax,(%eax)
 d8f:	6d                   	insl   (%dx),%es:(%edi)
 d90:	6f                   	outsl  %ds:(%esi),(%dx)
 d91:	75 73                	jne    e06 <wait_KBC_sendready-0x27f1fa>
 d93:	65 66 69 66 6f 3a 47 	imul   $0x473a,%gs:0x6f(%esi),%sp
 d9a:	28 31                	sub    %dh,(%ecx)
 d9c:	2c 31                	sub    $0x31,%al
 d9e:	29 00                	sub    %eax,(%eax)
 da0:	2f                   	das    
 da1:	74 6d                	je     e10 <wait_KBC_sendready-0x27f1f0>
 da3:	70 2f                	jo     dd4 <wait_KBC_sendready-0x27f22c>
 da5:	63 63 79             	arpl   %sp,0x79(%ebx)
 da8:	75 47                	jne    df1 <wait_KBC_sendready-0x27f20f>
 daa:	6c                   	insb   (%dx),%es:(%edi)
 dab:	6e                   	outsb  %ds:(%esi),(%dx)
 dac:	6c                   	insb   (%dx),%es:(%edi)
 dad:	2e 73 00             	jae,pn db0 <wait_KBC_sendready-0x27f250>
 db0:	61                   	popa   
 db1:	73 6d                	jae    e20 <wait_KBC_sendready-0x27f1e0>
 db3:	69 6e 74 33 32 2e 53 	imul   $0x532e3233,0x74(%esi),%ebp
 dba:	00 66 69             	add    %ah,0x69(%esi)
 dbd:	66 6f                	outsw  %ds:(%esi),(%dx)
 dbf:	2e 63 00             	arpl   %ax,%cs:(%eax)
 dc2:	66 69 66 6f 38 5f    	imul   $0x5f38,0x6f(%esi),%sp
 dc8:	69 6e 69 74 3a 46 28 	imul   $0x28463a74,0x69(%esi),%ebp
 dcf:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 dd2:	38 29                	cmp    %ch,(%ecx)
 dd4:	00 66 69             	add    %ah,0x69(%esi)
 dd7:	66 6f                	outsw  %ds:(%esi),(%dx)
 dd9:	3a 70 28             	cmp    0x28(%eax),%dh
 ddc:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 ddf:	39 29                	cmp    %ebp,(%ecx)
 de1:	3d 2a 28 31 2c       	cmp    $0x2c31282a,%eax
 de6:	31 29                	xor    %ebp,(%ecx)
 de8:	00 73 69             	add    %dh,0x69(%ebx)
 deb:	7a 65                	jp     e52 <wait_KBC_sendready-0x27f1ae>
 ded:	3a 70 28             	cmp    0x28(%eax),%dh
 df0:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 df3:	29 00                	sub    %eax,(%eax)
 df5:	62 75 66             	bound  %esi,0x66(%ebp)
 df8:	3a 70 28             	cmp    0x28(%eax),%dh
 dfb:	31 2c 32             	xor    %ebp,(%edx,%esi,1)
 dfe:	29 00                	sub    %eax,(%eax)
 e00:	66 69 66 6f 3a 72    	imul   $0x723a,0x6f(%esi),%sp
 e06:	28 30                	sub    %dh,(%eax)
 e08:	2c 31                	sub    $0x31,%al
 e0a:	39 29                	cmp    %ebp,(%ecx)
 e0c:	00 73 69             	add    %dh,0x69(%ebx)
 e0f:	7a 65                	jp     e76 <wait_KBC_sendready-0x27f18a>
 e11:	3a 72 28             	cmp    0x28(%edx),%dh
 e14:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 e17:	29 00                	sub    %eax,(%eax)
 e19:	62 75 66             	bound  %esi,0x66(%ebp)
 e1c:	3a 72 28             	cmp    0x28(%edx),%dh
 e1f:	31 2c 32             	xor    %ebp,(%edx,%esi,1)
 e22:	29 00                	sub    %eax,(%eax)
 e24:	66 69 66 6f 38 5f    	imul   $0x5f38,0x6f(%esi),%sp
 e2a:	70 75                	jo     ea1 <wait_KBC_sendready-0x27f15f>
 e2c:	74 3a                	je     e68 <wait_KBC_sendready-0x27f198>
 e2e:	46                   	inc    %esi
 e2f:	28 30                	sub    %dh,(%eax)
 e31:	2c 31                	sub    $0x31,%al
 e33:	29 00                	sub    %eax,(%eax)
 e35:	66 69 66 6f 3a 70    	imul   $0x703a,0x6f(%esi),%sp
 e3b:	28 30                	sub    %dh,(%eax)
 e3d:	2c 31                	sub    $0x31,%al
 e3f:	39 29                	cmp    %ebp,(%ecx)
 e41:	00 64 61 74          	add    %ah,0x74(%ecx,%eiz,2)
 e45:	61                   	popa   
 e46:	3a 70 28             	cmp    0x28(%eax),%dh
 e49:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 e4c:	29 00                	sub    %eax,(%eax)
 e4e:	66 69 66 6f 38 5f    	imul   $0x5f38,0x6f(%esi),%sp
 e54:	67                   	addr16
 e55:	65                   	gs
 e56:	74 3a                	je     e92 <wait_KBC_sendready-0x27f16e>
 e58:	46                   	inc    %esi
 e59:	28 30                	sub    %dh,(%eax)
 e5b:	2c 31                	sub    $0x31,%al
 e5d:	29 00                	sub    %eax,(%eax)
 e5f:	64                   	fs
 e60:	61                   	popa   
 e61:	74 61                	je     ec4 <wait_KBC_sendready-0x27f13c>
 e63:	3a 72 28             	cmp    0x28(%edx),%dh
 e66:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 e69:	29 00                	sub    %eax,(%eax)
 e6b:	66 69 66 6f 38 5f    	imul   $0x5f38,0x6f(%esi),%sp
 e71:	73 74                	jae    ee7 <wait_KBC_sendready-0x27f119>
 e73:	61                   	popa   
 e74:	74 75                	je     eeb <wait_KBC_sendready-0x27f115>
 e76:	73 3a                	jae    eb2 <wait_KBC_sendready-0x27f14e>
 e78:	46                   	inc    %esi
 e79:	28 30                	sub    %dh,(%eax)
 e7b:	2c 31                	sub    $0x31,%al
 e7d:	29 00                	sub    %eax,(%eax)
