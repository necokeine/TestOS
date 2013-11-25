
cobj.out：     文件格式 elf32-i386


Disassembly of section .text:

00280000 <bootmain>:
#define red   1
#define green 2
struct boot_info *bootp=(struct boot_info *) ADDR_BOOT;
extern struct MOUSE_DEC glob;
void bootmain(void)
{
  280000:	55                   	push   %ebp
  280001:	89 e5                	mov    %esp,%ebp
  280003:	57                   	push   %edi
  280004:	56                   	push   %esi
  280005:	53                   	push   %ebx
  280006:	81 ec e8 00 00 00    	sub    $0xe8,%esp
	static char font[40];	//sprintf buffer
	char s[40];
	int i=124567;		//sprintf variable i for test
	//char mousepic[256];     //mouse logo buffer
	char keybuf[32], mousebuf[128];
	clear_screen(40);   	//read
  28000c:	6a 28                	push   $0x28
  28000e:	e8 9d 02 00 00       	call   2802b0 <clear_screen>

static __inline void
sti(void)
{

	__asm __volatile("sti");
  280013:	fb                   	sti    

	sti();		//enable cpu interrupt
	fifo8_init(&keyfifo, 32, keybuf);
  280014:	83 c4 0c             	add    $0xc,%esp
  280017:	8d 85 20 ff ff ff    	lea    -0xe0(%ebp),%eax
  28001d:	50                   	push   %eax
  28001e:	6a 20                	push   $0x20
  280020:	68 28 2f 28 00       	push   $0x282f28
  280025:	e8 9a 0b 00 00       	call   280bc4 <fifo8_init>
	fifo8_init(&mousefifo, 128, mousebuf);
  28002a:	83 c4 0c             	add    $0xc,%esp
  28002d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  280033:	50                   	push   %eax
  280034:	68 80 00 00 00       	push   $0x80
  280039:	68 40 2f 28 00       	push   $0x282f40
  28003e:	e8 81 0b 00 00       	call   280bc4 <fifo8_init>
	init_screen((struct boot_info * )bootp);
	init_palette();  //color table from 0 to 15

	sprintf(s, "MEM TEST...");
  280043:	8d 9d 40 ff ff ff    	lea    -0xc0(%ebp),%ebx
	clear_screen(40);   	//read

	sti();		//enable cpu interrupt
	fifo8_init(&keyfifo, 32, keybuf);
	fifo8_init(&mousefifo, 128, mousebuf);
	init_screen((struct boot_info * )bootp);
  280049:	58                   	pop    %eax
  28004a:	ff 35 24 2f 28 00    	pushl  0x282f24
  280050:	e8 a4 04 00 00       	call   2804f9 <init_screen>
	init_palette();  //color table from 0 to 15
  280055:	e8 b6 02 00 00       	call   280310 <init_palette>

	sprintf(s, "MEM TEST...");
  28005a:	5a                   	pop    %edx
  28005b:	59                   	pop    %ecx
  28005c:	68 a0 29 28 00       	push   $0x2829a0
  280061:	53                   	push   %ebx
  280062:	e8 11 06 00 00       	call   280678 <sprintf>
	boxfill8(bootp->vram, bootp->xsize, COL8_008484,  32, 48, 200, 63);
  280067:	83 c4 0c             	add    $0xc,%esp
  28006a:	a1 24 2f 28 00       	mov    0x282f24,%eax
  28006f:	6a 3f                	push   $0x3f
  280071:	68 c8 00 00 00       	push   $0xc8
  280076:	6a 30                	push   $0x30
  280078:	6a 20                	push   $0x20
  28007a:	6a 0e                	push   $0xe
  28007c:	0f bf 50 04          	movswl 0x4(%eax),%edx
  280080:	52                   	push   %edx
  280081:	ff 70 08             	pushl  0x8(%eax)
  280084:	e8 b8 02 00 00       	call   280341 <boxfill8>
	puts8(bootp->vram, bootp->xsize, 32, 48, COL8_FFFFFF, s);
  280089:	83 c4 18             	add    $0x18,%esp
  28008c:	a1 24 2f 28 00       	mov    0x282f24,%eax
  280091:	53                   	push   %ebx
  280092:	6a 07                	push   $0x7
  280094:	6a 30                	push   $0x30
  280096:	6a 20                	push   $0x20
  280098:	0f bf 50 04          	movswl 0x4(%eax),%edx
  28009c:	52                   	push   %edx
  28009d:	ff 70 08             	pushl  0x8(%eax)
  2800a0:	e8 df 06 00 00       	call   280784 <puts8>
	i=memtest(0x01000000, 0xbffffffff)/(1024*1024);
  2800a5:	83 c4 1c             	add    $0x1c,%esp
  2800a8:	6a 0b                	push   $0xb
  2800aa:	6a ff                	push   $0xffffffff
  2800ac:	68 00 00 00 01       	push   $0x1000000
  2800b1:	e8 8a 0d 00 00       	call   280e40 <memtest>
  2800b6:	b9 00 00 10 00       	mov    $0x100000,%ecx
	sprintf(s, "MEM: %dM", i);
  2800bb:	83 c4 0c             	add    $0xc,%esp
	init_palette();  //color table from 0 to 15

	sprintf(s, "MEM TEST...");
	boxfill8(bootp->vram, bootp->xsize, COL8_008484,  32, 48, 200, 63);
	puts8(bootp->vram, bootp->xsize, 32, 48, COL8_FFFFFF, s);
	i=memtest(0x01000000, 0xbffffffff)/(1024*1024);
  2800be:	99                   	cltd   
  2800bf:	f7 f9                	idiv   %ecx
	sprintf(s, "MEM: %dM", i);
  2800c1:	50                   	push   %eax
  2800c2:	68 ac 29 28 00       	push   $0x2829ac
  2800c7:	53                   	push   %ebx
  2800c8:	e8 ab 05 00 00       	call   280678 <sprintf>
	boxfill8(bootp->vram, bootp->xsize, COL8_008484,  32, 48, 200, 63);
  2800cd:	83 c4 0c             	add    $0xc,%esp
  2800d0:	a1 24 2f 28 00       	mov    0x282f24,%eax
  2800d5:	6a 3f                	push   $0x3f
  2800d7:	68 c8 00 00 00       	push   $0xc8
  2800dc:	6a 30                	push   $0x30
  2800de:	6a 20                	push   $0x20
  2800e0:	6a 0e                	push   $0xe
  2800e2:	0f bf 50 04          	movswl 0x4(%eax),%edx
  2800e6:	52                   	push   %edx
  2800e7:	ff 70 08             	pushl  0x8(%eax)
  2800ea:	e8 52 02 00 00       	call   280341 <boxfill8>
	puts8(bootp->vram, bootp->xsize, 32, 48, COL8_FFFFFF, s);
  2800ef:	83 c4 18             	add    $0x18,%esp
  2800f2:	a1 24 2f 28 00       	mov    0x282f24,%eax
  2800f7:	53                   	push   %ebx
  2800f8:	6a 07                	push   $0x7
  2800fa:	6a 30                	push   $0x30
  2800fc:	6a 20                	push   $0x20
  2800fe:	0f bf 50 04          	movswl 0x4(%eax),%edx
  280102:	52                   	push   %edx
  280103:	ff 70 08             	pushl  0x8(%eax)
  280106:	e8 79 06 00 00       	call   280784 <puts8>


	//display mouse logo
	//init_mouse(mousepic,7);//7　means background color:white
	//display_mouse(bootp->vram,bootp->xsize,16,16,60,60,mousepic,16);
	init_gdtidt();
  28010b:	83 c4 20             	add    $0x20,%esp
  28010e:	e8 1b 08 00 00       	call   28092e <init_gdtidt>
	init_pic();//函数中：　irq 1(keyboard)对应设置中断号int0x21,    irq　12(mouse)对应的中断号是int0x2c 要写中断服务程序了。
  280113:	e8 a4 09 00 00       	call   280abc <init_pic>
// out:write a data to a port
static __inline void
outb(int port, uint8_t data)
{
  //data是变量0%0 , port是变量word１%w1
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  280118:	ba 21 00 00 00       	mov    $0x21,%edx
  28011d:	b0 f9                	mov    $0xf9,%al
  28011f:	ee                   	out    %al,(%dx)
  280120:	b0 ef                	mov    $0xef,%al
  280122:	b2 a1                	mov    $0xa1,%dl
  280124:	ee                   	out    %al,(%dx)
	int * addr=(int *)(0x0026f800+8*0x21);
	//printdebug(*(addr),0);
	//printdebug(*(addr+1),160);
	int mouse_tot=-1;
	//io_halt();
	init_keyboard();
  280125:	e8 c5 0c 00 00       	call   280def <init_keyboard>
	enable_mouse(bootp);
  28012a:	83 ec 0c             	sub    $0xc,%esp

	//打印出int0x21处的idt值，主要看offset是否与　asm_inthandler21一样（看反汇编，可以看到地址）
	int * addr=(int *)(0x0026f800+8*0x21);
	//printdebug(*(addr),0);
	//printdebug(*(addr+1),160);
	int mouse_tot=-1;
  28012d:	83 cb ff             	or     $0xffffffff,%ebx
	//io_halt();
	init_keyboard();
	enable_mouse(bootp);
  280130:	ff 35 24 2f 28 00    	pushl  0x282f24
  280136:	8d b5 40 ff ff ff    	lea    -0xc0(%ebp),%esi
  28013c:	e8 2f 0b 00 00       	call   280c70 <enable_mouse>
  280141:	83 c4 10             	add    $0x10,%esp

	for (;;) {
		io_cli();
  280144:	fa                   	cli    
		if (fifo8_status(&keyfifo) + fifo8_status(&mousefifo) == 0) {
  280145:	83 ec 0c             	sub    $0xc,%esp
  280148:	68 28 2f 28 00       	push   $0x282f28
  28014d:	e8 10 0b 00 00       	call   280c62 <fifo8_status>
  280152:	c7 04 24 40 2f 28 00 	movl   $0x282f40,(%esp)
  280159:	89 c7                	mov    %eax,%edi
  28015b:	e8 02 0b 00 00       	call   280c62 <fifo8_status>
  280160:	83 c4 10             	add    $0x10,%esp
  280163:	01 c7                	add    %eax,%edi
  280165:	85 ff                	test   %edi,%edi
  280167:	75 07                	jne    280170 <bootmain+0x170>
			io_stihlt();
  280169:	e8 53 0a 00 00       	call   280bc1 <io_stihlt>
  28016e:	eb d4                	jmp    280144 <bootmain+0x144>
		} else {
			if (fifo8_status(&keyfifo) != 0) {
  280170:	83 ec 0c             	sub    $0xc,%esp
  280173:	68 28 2f 28 00       	push   $0x282f28
  280178:	e8 e5 0a 00 00       	call   280c62 <fifo8_status>
  28017d:	83 c4 10             	add    $0x10,%esp
  280180:	85 c0                	test   %eax,%eax
  280182:	74 60                	je     2801e4 <bootmain+0x1e4>
				i = fifo8_get(&keyfifo);
  280184:	83 ec 0c             	sub    $0xc,%esp
  280187:	68 28 2f 28 00       	push   $0x282f28
  28018c:	e8 9c 0a 00 00       	call   280c2d <fifo8_get>
				io_sti();
  280191:	fb                   	sti    
				sprintf(s, "%x", i);
  280192:	83 c4 0c             	add    $0xc,%esp
  280195:	50                   	push   %eax
  280196:	68 c6 29 28 00       	push   $0x2829c6
  28019b:	56                   	push   %esi
  28019c:	e8 d7 04 00 00       	call   280678 <sprintf>
				boxfill8(bootp->vram, bootp->xsize, COL8_008484,  0, 16, 40, 31);
  2801a1:	83 c4 0c             	add    $0xc,%esp
  2801a4:	a1 24 2f 28 00       	mov    0x282f24,%eax
  2801a9:	6a 1f                	push   $0x1f
  2801ab:	6a 28                	push   $0x28
  2801ad:	6a 10                	push   $0x10
  2801af:	6a 00                	push   $0x0
  2801b1:	6a 0e                	push   $0xe
  2801b3:	0f bf 50 04          	movswl 0x4(%eax),%edx
  2801b7:	52                   	push   %edx
  2801b8:	ff 70 08             	pushl  0x8(%eax)
  2801bb:	e8 81 01 00 00       	call   280341 <boxfill8>
				puts8(bootp->vram, bootp->xsize, 0, 16, COL8_FFFFFF, s);
  2801c0:	83 c4 18             	add    $0x18,%esp
  2801c3:	a1 24 2f 28 00       	mov    0x282f24,%eax
  2801c8:	56                   	push   %esi
  2801c9:	6a 07                	push   $0x7
  2801cb:	6a 10                	push   $0x10
  2801cd:	6a 00                	push   $0x0
  2801cf:	0f bf 50 04          	movswl 0x4(%eax),%edx
  2801d3:	52                   	push   %edx
  2801d4:	ff 70 08             	pushl  0x8(%eax)
  2801d7:	e8 a8 05 00 00       	call   280784 <puts8>
  2801dc:	83 c4 20             	add    $0x20,%esp
  2801df:	e9 60 ff ff ff       	jmp    280144 <bootmain+0x144>
			} else if (fifo8_status(&mousefifo) != 0) {
  2801e4:	83 ec 0c             	sub    $0xc,%esp
  2801e7:	68 40 2f 28 00       	push   $0x282f40
  2801ec:	e8 71 0a 00 00       	call   280c62 <fifo8_status>
  2801f1:	83 c4 10             	add    $0x10,%esp
  2801f4:	85 c0                	test   %eax,%eax
  2801f6:	0f 84 48 ff ff ff    	je     280144 <bootmain+0x144>
				i = fifo8_get(&mousefifo);
  2801fc:	83 ec 0c             	sub    $0xc,%esp
  2801ff:	68 40 2f 28 00       	push   $0x282f40
  280204:	e8 24 0a 00 00       	call   280c2d <fifo8_get>
				io_sti();
  280209:	fb                   	sti    
				if (mouse_tot==-1){
  28020a:	83 c4 10             	add    $0x10,%esp
  28020d:	83 fb ff             	cmp    $0xffffffff,%ebx
  280210:	75 11                	jne    280223 <bootmain+0x223>
					if (i == 0xfa) mouse_tot=0;
  280212:	31 db                	xor    %ebx,%ebx
  280214:	3d fa 00 00 00       	cmp    $0xfa,%eax
  280219:	0f 95 c3             	setne  %bl
  28021c:	f7 db                	neg    %ebx
  28021e:	e9 21 ff ff ff       	jmp    280144 <bootmain+0x144>
				}else{
					glob.buf[mouse_tot++]=i;
  280223:	88 83 58 2f 28 00    	mov    %al,0x282f58(%ebx)
  280229:	43                   	inc    %ebx
					if (mouse_tot==3){
  28022a:	83 fb 03             	cmp    $0x3,%ebx
  28022d:	0f 85 11 ff ff ff    	jne    280144 <bootmain+0x144>
						mouse_tot=0;
						sprintf(s, "%x%x%x", glob.buf[0], glob.buf[1], glob.buf[2]);
  280233:	0f b6 05 5a 2f 28 00 	movzbl 0x282f5a,%eax
  28023a:	83 ec 0c             	sub    $0xc,%esp
				if (mouse_tot==-1){
					if (i == 0xfa) mouse_tot=0;
				}else{
					glob.buf[mouse_tot++]=i;
					if (mouse_tot==3){
						mouse_tot=0;
  28023d:	30 db                	xor    %bl,%bl
						sprintf(s, "%x%x%x", glob.buf[0], glob.buf[1], glob.buf[2]);
  28023f:	50                   	push   %eax
  280240:	0f b6 05 59 2f 28 00 	movzbl 0x282f59,%eax
  280247:	50                   	push   %eax
  280248:	0f b6 05 58 2f 28 00 	movzbl 0x282f58,%eax
  28024f:	50                   	push   %eax
  280250:	68 b5 29 28 00       	push   $0x2829b5
  280255:	56                   	push   %esi
  280256:	e8 1d 04 00 00       	call   280678 <sprintf>
						boxfill8(bootp->vram, bootp->xsize, COL8_008484, 50, 16, 210, 31);
  28025b:	83 c4 1c             	add    $0x1c,%esp
  28025e:	a1 24 2f 28 00       	mov    0x282f24,%eax
  280263:	6a 1f                	push   $0x1f
  280265:	68 d2 00 00 00       	push   $0xd2
  28026a:	6a 10                	push   $0x10
  28026c:	6a 32                	push   $0x32
  28026e:	6a 0e                	push   $0xe
  280270:	0f bf 50 04          	movswl 0x4(%eax),%edx
  280274:	52                   	push   %edx
  280275:	ff 70 08             	pushl  0x8(%eax)
  280278:	e8 c4 00 00 00       	call   280341 <boxfill8>
						puts8(bootp->vram, bootp->xsize, 50, 16, COL8_FFFFFF, s);
  28027d:	83 c4 18             	add    $0x18,%esp
  280280:	a1 24 2f 28 00       	mov    0x282f24,%eax
  280285:	56                   	push   %esi
  280286:	6a 07                	push   $0x7
  280288:	6a 10                	push   $0x10
  28028a:	6a 32                	push   $0x32
  28028c:	0f bf 50 04          	movswl 0x4(%eax),%edx
  280290:	52                   	push   %edx
  280291:	ff 70 08             	pushl  0x8(%eax)
  280294:	e8 eb 04 00 00       	call   280784 <puts8>
						mouse_move(bootp);
  280299:	83 c4 14             	add    $0x14,%esp
  28029c:	ff 35 24 2f 28 00    	pushl  0x282f24
  2802a2:	e8 38 0a 00 00       	call   280cdf <mouse_move>
  2802a7:	83 c4 10             	add    $0x10,%esp
  2802aa:	e9 95 fe ff ff       	jmp    280144 <bootmain+0x144>
  2802af:	90                   	nop

002802b0 <clear_screen>:
#include<header.h>

void clear_screen(char color) //15:pure white
{
  2802b0:	55                   	push   %ebp
  int i;
  for(i=0xa0000;i<0xaffff;i++)
  2802b1:	b8 00 00 0a 00       	mov    $0xa0000,%eax
#include<header.h>

void clear_screen(char color) //15:pure white
{
  2802b6:	89 e5                	mov    %esp,%ebp
  2802b8:	8a 55 08             	mov    0x8(%ebp),%dl
  int i;
  for(i=0xa0000;i<0xaffff;i++)
  {
  write_mem8(i,color);  //if we write 15 ,all pixels color will be white,15 mens pure white ,so the screen changes into white
  2802bb:	88 10                	mov    %dl,(%eax)
#include<header.h>

void clear_screen(char color) //15:pure white
{
  int i;
  for(i=0xa0000;i<0xaffff;i++)
  2802bd:	40                   	inc    %eax
  2802be:	3d ff ff 0a 00       	cmp    $0xaffff,%eax
  2802c3:	75 f6                	jne    2802bb <clear_screen+0xb>
  {
  write_mem8(i,color);  //if we write 15 ,all pixels color will be white,15 mens pure white ,so the screen changes into white

  }
}
  2802c5:	5d                   	pop    %ebp
  2802c6:	c3                   	ret    

002802c7 <color_screen>:

void color_screen(char color) //15:pure white
{
  2802c7:	55                   	push   %ebp
  int i;
  color=color;
  for(i=0xa0000;i<0xaffff;i++)
  2802c8:	b8 00 00 0a 00       	mov    $0xa0000,%eax

  }
}

void color_screen(char color) //15:pure white
{
  2802cd:	89 e5                	mov    %esp,%ebp
  int i;
  color=color;
  for(i=0xa0000;i<0xaffff;i++)
  {
  write_mem8(i,i);  //if we write 15 ,all pixels color will be white,15 mens pure white ,so the screen changes into white
  2802cf:	88 00                	mov    %al,(%eax)

void color_screen(char color) //15:pure white
{
  int i;
  color=color;
  for(i=0xa0000;i<0xaffff;i++)
  2802d1:	40                   	inc    %eax
  2802d2:	3d ff ff 0a 00       	cmp    $0xaffff,%eax
  2802d7:	75 f6                	jne    2802cf <color_screen+0x8>
  {
  write_mem8(i,i);  //if we write 15 ,all pixels color will be white,15 mens pure white ,so the screen changes into white

  }
}
  2802d9:	5d                   	pop    %ebp
  2802da:	c3                   	ret    

002802db <set_palette>:
   set_palette(0,255,table_rgb);
}

//设置调色板，  只用到了16个color,后面的都没有用到。
void set_palette(int start,int end, unsigned char *rgb)
{
  2802db:	55                   	push   %ebp
  2802dc:	89 e5                	mov    %esp,%ebp
  2802de:	56                   	push   %esi
  2802df:	8b 4d 10             	mov    0x10(%ebp),%ecx
  2802e2:	53                   	push   %ebx
  2802e3:	8b 5d 08             	mov    0x8(%ebp),%ebx
//read eflags and write_eflags
static __inline uint32_t
read_eflags(void)
{
        uint32_t eflags;
        __asm __volatile("pushfl; popl %0" : "=r" (eflags));
  2802e6:	9c                   	pushf  
  2802e7:	5e                   	pop    %esi
  int i,eflag;
  eflag=read_eflags();   //记录从前的cpsr值
 
  io_cli(); // disable interrupt
  2802e8:	fa                   	cli    
// out:write a data to a port
static __inline void
outb(int port, uint8_t data)
{
  //data是变量0%0 , port是变量word１%w1
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  2802e9:	ba c8 03 00 00       	mov    $0x3c8,%edx
  //为什么写port 0x03c8
  
  //rgb=rgb+;
  outb(0x03c8,start);
  2802ee:	0f b6 c3             	movzbl %bl,%eax
  2802f1:	ee                   	out    %al,(%dx)
  2802f2:	b2 c9                	mov    $0xc9,%dl
  for(i=start;i<=end;i++)
  2802f4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
  2802f7:	7f 11                	jg     28030a <set_palette+0x2f>
  2802f9:	8a 01                	mov    (%ecx),%al
  2802fb:	ee                   	out    %al,(%dx)
  2802fc:	8a 41 01             	mov    0x1(%ecx),%al
  2802ff:	ee                   	out    %al,(%dx)
  280300:	8a 41 02             	mov    0x2(%ecx),%al
  280303:	ee                   	out    %al,(%dx)
  {
    outb(0x03c9,*(rgb));    //outb函数是往指定的设备，送数据。
    outb(0x03c9,*(rgb+1));   
    outb(0x03c9,*(rgb+2));   
    rgb=rgb+3;
  280304:	83 c1 03             	add    $0x3,%ecx
  io_cli(); // disable interrupt
  //为什么写port 0x03c8
  
  //rgb=rgb+;
  outb(0x03c8,start);
  for(i=start;i<=end;i++)
  280307:	43                   	inc    %ebx
  280308:	eb ea                	jmp    2802f4 <set_palette+0x19>
}

static __inline void
write_eflags(uint32_t eflags)
{
        __asm __volatile("pushl %0; popfl" : : "r" (eflags));
  28030a:	56                   	push   %esi
  28030b:	9d                   	popf   
  }
  
write_eflags(eflag);  //恢复从前的cpsr
  return;
  
}
  28030c:	5b                   	pop    %ebx
  28030d:	5e                   	pop    %esi
  28030e:	5d                   	pop    %ebp
  28030f:	c3                   	ret    

00280310 <init_palette>:
}

//初始化调色板，table_rgb[]保存了16种color的编码。
//什么调色板是这样进行设置，这个与x86的port 0x03c8 0x03c9
void init_palette(void)
{
  280310:	55                   	push   %ebp
  //16种color，每个color三个字节。
unsigned char table_rgb[16*3]={
  280311:	b9 0c 00 00 00       	mov    $0xc,%ecx
}

//初始化调色板，table_rgb[]保存了16种color的编码。
//什么调色板是这样进行设置，这个与x86的port 0x03c8 0x03c9
void init_palette(void)
{
  280316:	89 e5                	mov    %esp,%ebp
  280318:	57                   	push   %edi
  280319:	56                   	push   %esi
  //16种color，每个color三个字节。
unsigned char table_rgb[16*3]={
  28031a:	be 70 28 28 00       	mov    $0x282870,%esi
}

//初始化调色板，table_rgb[]保存了16种color的编码。
//什么调色板是这样进行设置，这个与x86的port 0x03c8 0x03c9
void init_palette(void)
{
  28031f:	83 ec 30             	sub    $0x30,%esp
    0x00,0x00,0x84,   /*12:dark 青*/
    0x84,0x00,0x84,   /*13:dark purper*/
    0x00,0x84,0x84,   /*14:light blue*/
    0x84,0x84,0x84,   /*15:dark gray*/
  };
   set_palette(0,255,table_rgb);
  280322:	8d 45 c8             	lea    -0x38(%ebp),%eax
//初始化调色板，table_rgb[]保存了16种color的编码。
//什么调色板是这样进行设置，这个与x86的port 0x03c8 0x03c9
void init_palette(void)
{
  //16种color，每个color三个字节。
unsigned char table_rgb[16*3]={
  280325:	8d 7d c8             	lea    -0x38(%ebp),%edi
  280328:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    0x00,0x00,0x84,   /*12:dark 青*/
    0x84,0x00,0x84,   /*13:dark purper*/
    0x00,0x84,0x84,   /*14:light blue*/
    0x84,0x84,0x84,   /*15:dark gray*/
  };
   set_palette(0,255,table_rgb);
  28032a:	50                   	push   %eax
  28032b:	68 ff 00 00 00       	push   $0xff
  280330:	6a 00                	push   $0x0
  280332:	e8 a4 ff ff ff       	call   2802db <set_palette>
  280337:	83 c4 0c             	add    $0xc,%esp
}
  28033a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  28033d:	5e                   	pop    %esi
  28033e:	5f                   	pop    %edi
  28033f:	5d                   	pop    %ebp
  280340:	c3                   	ret    

00280341 <boxfill8>:
  return;
  
}

void boxfill8(unsigned char *vram,int xsize,unsigned char color,int x0,int y0,int x1,int y1)
{
  280341:	55                   	push   %ebp
  280342:	89 e5                	mov    %esp,%ebp
  280344:	8b 4d 18             	mov    0x18(%ebp),%ecx
  280347:	8b 45 0c             	mov    0xc(%ebp),%eax
  28034a:	53                   	push   %ebx
  28034b:	8a 5d 10             	mov    0x10(%ebp),%bl
  28034e:	0f af c1             	imul   %ecx,%eax
  280351:	03 45 08             	add    0x8(%ebp),%eax
 int x,y;
 for(y=y0;y<=y1;y++)
  280354:	3b 4d 20             	cmp    0x20(%ebp),%ecx
  280357:	7f 14                	jg     28036d <boxfill8+0x2c>
  280359:	8b 55 14             	mov    0x14(%ebp),%edx
 {
   for(x=x0;x<=x1;x++)
  28035c:	3b 55 1c             	cmp    0x1c(%ebp),%edx
  28035f:	7f 06                	jg     280367 <boxfill8+0x26>
   {
      vram[y*xsize+x]=color;
  280361:	88 1c 10             	mov    %bl,(%eax,%edx,1)
void boxfill8(unsigned char *vram,int xsize,unsigned char color,int x0,int y0,int x1,int y1)
{
 int x,y;
 for(y=y0;y<=y1;y++)
 {
   for(x=x0;x<=x1;x++)
  280364:	42                   	inc    %edx
  280365:	eb f5                	jmp    28035c <boxfill8+0x1b>
}

void boxfill8(unsigned char *vram,int xsize,unsigned char color,int x0,int y0,int x1,int y1)
{
 int x,y;
 for(y=y0;y<=y1;y++)
  280367:	41                   	inc    %ecx
  280368:	03 45 0c             	add    0xc(%ebp),%eax
  28036b:	eb e7                	jmp    280354 <boxfill8+0x13>
   {
      vram[y*xsize+x]=color;
   }
 }
   
}
  28036d:	5b                   	pop    %ebx
  28036e:	5d                   	pop    %ebp
  28036f:	c3                   	ret    

00280370 <boxfill>:
void boxfill(unsigned char color,int x0,int y0,int x1,int y1)
{
  280370:	55                   	push   %ebp
  280371:	89 e5                	mov    %esp,%ebp
  boxfill8((unsigned char *)VRAM,320,color,x0,y0,x1,y1);
  280373:	ff 75 18             	pushl  0x18(%ebp)
  280376:	ff 75 14             	pushl  0x14(%ebp)
  280379:	ff 75 10             	pushl  0x10(%ebp)
  28037c:	ff 75 0c             	pushl  0xc(%ebp)
  28037f:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
  280383:	50                   	push   %eax
  280384:	68 40 01 00 00       	push   $0x140
  280389:	68 00 00 0a 00       	push   $0xa0000
  28038e:	e8 ae ff ff ff       	call   280341 <boxfill8>
  280393:	83 c4 1c             	add    $0x1c,%esp
}
  280396:	c9                   	leave  
  280397:	c3                   	ret    

00280398 <draw_window>:

void draw_window()
{ 
  280398:	55                   	push   %ebp
  280399:	89 e5                	mov    %esp,%ebp
  int x=320,y=200;
    p=(unsigned char*)VRAM;
//     boxfill8(p,320,110,20,20,250,150);
    
    //draw a window
    boxfill(7 ,0, 0   ,x-1,y-29);
  28039b:	68 ab 00 00 00       	push   $0xab
  2803a0:	68 3f 01 00 00       	push   $0x13f
  2803a5:	6a 00                	push   $0x0
  2803a7:	6a 00                	push   $0x0
  2803a9:	6a 07                	push   $0x7
  2803ab:	e8 c0 ff ff ff       	call   280370 <boxfill>
//task button    
    boxfill(8  ,0, y-28,x-1,y-28);
  2803b0:	68 ac 00 00 00       	push   $0xac
  2803b5:	68 3f 01 00 00       	push   $0x13f
  2803ba:	68 ac 00 00 00       	push   $0xac
  2803bf:	6a 00                	push   $0x0
  2803c1:	6a 08                	push   $0x8
  2803c3:	e8 a8 ff ff ff       	call   280370 <boxfill>
    boxfill(7  ,0, y-27,x-1,y-27);
  2803c8:	83 c4 28             	add    $0x28,%esp
  2803cb:	68 ad 00 00 00       	push   $0xad
  2803d0:	68 3f 01 00 00       	push   $0x13f
  2803d5:	68 ad 00 00 00       	push   $0xad
  2803da:	6a 00                	push   $0x0
  2803dc:	6a 07                	push   $0x7
  2803de:	e8 8d ff ff ff       	call   280370 <boxfill>
    boxfill(8  ,0, y-26,x-1,y-1);
  2803e3:	68 c7 00 00 00       	push   $0xc7
  2803e8:	68 3f 01 00 00       	push   $0x13f
  2803ed:	68 ae 00 00 00       	push   $0xae
  2803f2:	6a 00                	push   $0x0
  2803f4:	6a 08                	push   $0x8
  2803f6:	e8 75 ff ff ff       	call   280370 <boxfill>
    
    
//left button    
    boxfill(7, 3,  y-24, 59,  y-24);
  2803fb:	83 c4 28             	add    $0x28,%esp
  2803fe:	68 b0 00 00 00       	push   $0xb0
  280403:	6a 3b                	push   $0x3b
  280405:	68 b0 00 00 00       	push   $0xb0
  28040a:	6a 03                	push   $0x3
  28040c:	6a 07                	push   $0x7
  28040e:	e8 5d ff ff ff       	call   280370 <boxfill>
    boxfill(7, 2,  y-24, 2 ,  y-4);  
  280413:	68 c4 00 00 00       	push   $0xc4
  280418:	6a 02                	push   $0x2
  28041a:	68 b0 00 00 00       	push   $0xb0
  28041f:	6a 02                	push   $0x2
  280421:	6a 07                	push   $0x7
  280423:	e8 48 ff ff ff       	call   280370 <boxfill>
    boxfill(15, 3,  y-4,  59,  y-4);
  280428:	83 c4 28             	add    $0x28,%esp
  28042b:	68 c4 00 00 00       	push   $0xc4
  280430:	6a 3b                	push   $0x3b
  280432:	68 c4 00 00 00       	push   $0xc4
  280437:	6a 03                	push   $0x3
  280439:	6a 0f                	push   $0xf
  28043b:	e8 30 ff ff ff       	call   280370 <boxfill>
    boxfill(15, 59, y-23, 59,  y-5);
  280440:	68 c3 00 00 00       	push   $0xc3
  280445:	6a 3b                	push   $0x3b
  280447:	68 b1 00 00 00       	push   $0xb1
  28044c:	6a 3b                	push   $0x3b
  28044e:	6a 0f                	push   $0xf
  280450:	e8 1b ff ff ff       	call   280370 <boxfill>
    boxfill(0, 2,  y-3,  59,  y-3);
  280455:	83 c4 28             	add    $0x28,%esp
  280458:	68 c5 00 00 00       	push   $0xc5
  28045d:	6a 3b                	push   $0x3b
  28045f:	68 c5 00 00 00       	push   $0xc5
  280464:	6a 02                	push   $0x2
  280466:	6a 00                	push   $0x0
  280468:	e8 03 ff ff ff       	call   280370 <boxfill>
    boxfill(0, 60, y-24, 60,  y-3);  
  28046d:	68 c5 00 00 00       	push   $0xc5
  280472:	6a 3c                	push   $0x3c
  280474:	68 b0 00 00 00       	push   $0xb0
  280479:	6a 3c                	push   $0x3c
  28047b:	6a 00                	push   $0x0
  28047d:	e8 ee fe ff ff       	call   280370 <boxfill>

// 
//right button    
    boxfill(15, x-47, y-24,x-4,y-24);
  280482:	83 c4 28             	add    $0x28,%esp
  280485:	68 b0 00 00 00       	push   $0xb0
  28048a:	68 3c 01 00 00       	push   $0x13c
  28048f:	68 b0 00 00 00       	push   $0xb0
  280494:	68 11 01 00 00       	push   $0x111
  280499:	6a 0f                	push   $0xf
  28049b:	e8 d0 fe ff ff       	call   280370 <boxfill>
    boxfill(15, x-47, y-23,x-47,y-4);  
  2804a0:	68 c4 00 00 00       	push   $0xc4
  2804a5:	68 11 01 00 00       	push   $0x111
  2804aa:	68 b1 00 00 00       	push   $0xb1
  2804af:	68 11 01 00 00       	push   $0x111
  2804b4:	6a 0f                	push   $0xf
  2804b6:	e8 b5 fe ff ff       	call   280370 <boxfill>
    boxfill(7, x-47, y-3,x-4,y-3);
  2804bb:	83 c4 28             	add    $0x28,%esp
  2804be:	68 c5 00 00 00       	push   $0xc5
  2804c3:	68 3c 01 00 00       	push   $0x13c
  2804c8:	68 c5 00 00 00       	push   $0xc5
  2804cd:	68 11 01 00 00       	push   $0x111
  2804d2:	6a 07                	push   $0x7
  2804d4:	e8 97 fe ff ff       	call   280370 <boxfill>
    boxfill(7, x-3, y-24,x-3,y-3);
  2804d9:	68 c5 00 00 00       	push   $0xc5
  2804de:	68 3d 01 00 00       	push   $0x13d
  2804e3:	68 b0 00 00 00       	push   $0xb0
  2804e8:	68 3d 01 00 00       	push   $0x13d
  2804ed:	6a 07                	push   $0x7
  2804ef:	e8 7c fe ff ff       	call   280370 <boxfill>
  2804f4:	83 c4 28             	add    $0x28,%esp
}
  2804f7:	c9                   	leave  
  2804f8:	c3                   	ret    

002804f9 <init_screen>:


void init_screen(struct boot_info * bootp)
{
  2804f9:	55                   	push   %ebp
  2804fa:	89 e5                	mov    %esp,%ebp
  2804fc:	8b 45 08             	mov    0x8(%ebp),%eax
  bootp->vram=(char *)VRAM;
  2804ff:	c7 40 08 00 00 0a 00 	movl   $0xa0000,0x8(%eax)
  bootp->color_mode=8;
  280506:	c6 40 02 08          	movb   $0x8,0x2(%eax)
  bootp->xsize=320;
  28050a:	66 c7 40 04 40 01    	movw   $0x140,0x4(%eax)
  bootp->ysize=200;
  280510:	66 c7 40 06 c8 00    	movw   $0xc8,0x6(%eax)
  
}
  280516:	5d                   	pop    %ebp
  280517:	c3                   	ret    

00280518 <init_mouse>:
	"*..........*OOO*",
	"............*OO*",
	".............***"
};
void init_mouse(char *mouse,char bg)
{
  280518:	55                   	push   %ebp
  280519:	31 c9                	xor    %ecx,%ecx
  28051b:	89 e5                	mov    %esp,%ebp
  28051d:	8a 45 0c             	mov    0xc(%ebp),%al
  280520:	8b 55 08             	mov    0x8(%ebp),%edx
  280523:	56                   	push   %esi
  280524:	53                   	push   %ebx
  280525:	89 c6                	mov    %eax,%esi
  280527:	31 c0                	xor    %eax,%eax
	int x,y;
	for(y=0;y<16;y++)
	{
	  for(x=0;x<16;x++)
	  {
	    switch (cursor[y][x])
  280529:	8a 9c 01 a0 28 28 00 	mov    0x2828a0(%ecx,%eax,1),%bl
  280530:	80 fb 2e             	cmp    $0x2e,%bl
  280533:	74 10                	je     280545 <init_mouse+0x2d>
  280535:	80 fb 4f             	cmp    $0x4f,%bl
  280538:	74 12                	je     28054c <init_mouse+0x34>
  28053a:	80 fb 2a             	cmp    $0x2a,%bl
  28053d:	75 11                	jne    280550 <init_mouse+0x38>
	    {
	      case '.':mouse[x+16*y]=bg;break;  //background
	      case '*':mouse[x+16*y]=outline;break;   //outline
  28053f:	c6 04 02 00          	movb   $0x0,(%edx,%eax,1)
  280543:	eb 0b                	jmp    280550 <init_mouse+0x38>
	{
	  for(x=0;x<16;x++)
	  {
	    switch (cursor[y][x])
	    {
	      case '.':mouse[x+16*y]=bg;break;  //background
  280545:	89 f3                	mov    %esi,%ebx
  280547:	88 1c 02             	mov    %bl,(%edx,%eax,1)
  28054a:	eb 04                	jmp    280550 <init_mouse+0x38>
	      case '*':mouse[x+16*y]=outline;break;   //outline
	      case 'O':mouse[x+16*y]=inside;break;  //inside
  28054c:	c6 04 02 02          	movb   $0x2,(%edx,%eax,1)
#define outline    0
#define inside     2
	int x,y;
	for(y=0;y<16;y++)
	{
	  for(x=0;x<16;x++)
  280550:	40                   	inc    %eax
  280551:	83 f8 10             	cmp    $0x10,%eax
  280554:	75 d3                	jne    280529 <init_mouse+0x11>
  280556:	83 c1 10             	add    $0x10,%ecx
  280559:	83 c2 10             	add    $0x10,%edx
{
#define background 7
#define outline    0
#define inside     2
	int x,y;
	for(y=0;y<16;y++)
  28055c:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
  280562:	75 c3                	jne    280527 <init_mouse+0xf>
	    
	  }
	  
	}
  
}
  280564:	5b                   	pop    %ebx
  280565:	5e                   	pop    %esi
  280566:	5d                   	pop    %ebp
  280567:	c3                   	ret    

00280568 <display_mouse>:

void display_mouse(char *vram,int xsize,int pxsize,int pysize,int px0,int py0,char *buf,int bxsize)
{
  280568:	55                   	push   %ebp
  280569:	89 e5                	mov    %esp,%ebp
  28056b:	57                   	push   %edi
  28056c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  int x,y;
  for(y=0;y<pysize;y++)
  28056f:	31 ff                	xor    %edi,%edi
	}
  
}

void display_mouse(char *vram,int xsize,int pxsize,int pysize,int px0,int py0,char *buf,int bxsize)
{
  280571:	56                   	push   %esi
  280572:	53                   	push   %ebx
  280573:	8b 5d 20             	mov    0x20(%ebp),%ebx
  280576:	0f af 45 0c          	imul   0xc(%ebp),%eax
  28057a:	03 45 18             	add    0x18(%ebp),%eax
  28057d:	03 45 08             	add    0x8(%ebp),%eax
  int x,y;
  for(y=0;y<pysize;y++)
  280580:	3b 7d 14             	cmp    0x14(%ebp),%edi
  280583:	7d 28                	jge    2805ad <display_mouse+0x45>
  280585:	89 fe                	mov    %edi,%esi
  280587:	31 d2                	xor    %edx,%edx
  280589:	c1 e6 04             	shl    $0x4,%esi
  {
    for(x=0;x<pxsize;x++)
  28058c:	3b 55 10             	cmp    0x10(%ebp),%edx
  28058f:	7d 13                	jge    2805a4 <display_mouse+0x3c>
    {
		if (cursor[y][x]!='.')
  280591:	80 bc 16 a0 28 28 00 	cmpb   $0x2e,0x2828a0(%esi,%edx,1)
  280598:	2e 
  280599:	74 06                	je     2805a1 <display_mouse+0x39>
     		vram[(py0+y)*xsize+(px0+x)]=buf[y*bxsize+x];
  28059b:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  28059e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
void display_mouse(char *vram,int xsize,int pxsize,int pysize,int px0,int py0,char *buf,int bxsize)
{
  int x,y;
  for(y=0;y<pysize;y++)
  {
    for(x=0;x<pxsize;x++)
  2805a1:	42                   	inc    %edx
  2805a2:	eb e8                	jmp    28058c <display_mouse+0x24>
}

void display_mouse(char *vram,int xsize,int pxsize,int pysize,int px0,int py0,char *buf,int bxsize)
{
  int x,y;
  for(y=0;y<pysize;y++)
  2805a4:	47                   	inc    %edi
  2805a5:	03 5d 24             	add    0x24(%ebp),%ebx
  2805a8:	03 45 0c             	add    0xc(%ebp),%eax
  2805ab:	eb d3                	jmp    280580 <display_mouse+0x18>
		if (cursor[y][x]!='.')
     		vram[(py0+y)*xsize+(px0+x)]=buf[y*bxsize+x];
    }
  }
  
}
  2805ad:	5b                   	pop    %ebx
  2805ae:	5e                   	pop    %esi
  2805af:	5f                   	pop    %edi
  2805b0:	5d                   	pop    %ebp
  2805b1:	c3                   	ret    
  2805b2:	66 90                	xchg   %ax,%ax

002805b4 <itoa>:
sprintf(font,"Debug:var=%x" ,i);
puts8((char *)VRAM ,320,x,150,1,font);

}

void itoa(int value,char *buf){
  2805b4:	55                   	push   %ebp
    char tmp_buf[10] = {0};
  2805b5:	31 c0                	xor    %eax,%eax
sprintf(font,"Debug:var=%x" ,i);
puts8((char *)VRAM ,320,x,150,1,font);

}

void itoa(int value,char *buf){
  2805b7:	89 e5                	mov    %esp,%ebp
    char tmp_buf[10] = {0};
  2805b9:	b9 0a 00 00 00       	mov    $0xa,%ecx
sprintf(font,"Debug:var=%x" ,i);
puts8((char *)VRAM ,320,x,150,1,font);

}

void itoa(int value,char *buf){
  2805be:	57                   	push   %edi
  2805bf:	56                   	push   %esi
  2805c0:	53                   	push   %ebx
  2805c1:	83 ec 10             	sub    $0x10,%esp
  2805c4:	8b 55 08             	mov    0x8(%ebp),%edx
    char tmp_buf[10] = {0};
  2805c7:	8d 7d ea             	lea    -0x16(%ebp),%edi
sprintf(font,"Debug:var=%x" ,i);
puts8((char *)VRAM ,320,x,150,1,font);

}

void itoa(int value,char *buf){
  2805ca:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    char tmp_buf[10] = {0};
  2805cd:	f3 aa                	rep stos %al,%es:(%edi)
  2805cf:	8d 7d ea             	lea    -0x16(%ebp),%edi
    char *tbp = tmp_buf;
    if((value >> 31) & 0x1)
  2805d2:	85 d2                	test   %edx,%edx
  2805d4:	79 06                	jns    2805dc <itoa+0x28>
    { /* neg num */
        *buf++ = '-';//得到负号
  2805d6:	c6 03 2d             	movb   $0x2d,(%ebx)
        value = ~value + 1; //将负数变为正数
  2805d9:	f7 da                	neg    %edx
void itoa(int value,char *buf){
    char tmp_buf[10] = {0};
    char *tbp = tmp_buf;
    if((value >> 31) & 0x1)
    { /* neg num */
        *buf++ = '-';//得到负号
  2805db:	43                   	inc    %ebx
  2805dc:	89 f9                	mov    %edi,%ecx
    
    
  
    do
    {
        *tbp++ = ('0' + (char)(value % 10));//得到低位数字
  2805de:	be 0a 00 00 00       	mov    $0xa,%esi
  2805e3:	89 d0                	mov    %edx,%eax
  2805e5:	41                   	inc    %ecx
  2805e6:	99                   	cltd   
  2805e7:	f7 fe                	idiv   %esi
  2805e9:	83 c2 30             	add    $0x30,%edx
        value /= 10;
    }while(value);
  2805ec:	85 c0                	test   %eax,%eax
    
    
  
    do
    {
        *tbp++ = ('0' + (char)(value % 10));//得到低位数字
  2805ee:	88 51 ff             	mov    %dl,-0x1(%ecx)
        value /= 10;
  2805f1:	89 c2                	mov    %eax,%edx
    }while(value);
  2805f3:	75 ee                	jne    2805e3 <itoa+0x2f>
    
    
  
    do
    {
        *tbp++ = ('0' + (char)(value % 10));//得到低位数字
  2805f5:	89 ce                	mov    %ecx,%esi
  2805f7:	89 d8                	mov    %ebx,%eax
        value /= 10;
    }while(value);
    
    
    while(tmp_buf != tbp)
  2805f9:	39 f9                	cmp    %edi,%ecx
  2805fb:	74 09                	je     280606 <itoa+0x52>
    {
      tbp--;
  2805fd:	49                   	dec    %ecx
      *buf++ = *tbp;
  2805fe:	8a 11                	mov    (%ecx),%dl
  280600:	40                   	inc    %eax
  280601:	88 50 ff             	mov    %dl,-0x1(%eax)
  280604:	eb f3                	jmp    2805f9 <itoa+0x45>
  280606:	89 f0                	mov    %esi,%eax
  280608:	29 c8                	sub    %ecx,%eax

    }
    *buf='\0';
  28060a:	c6 04 03 00          	movb   $0x0,(%ebx,%eax,1)
    
    
}
  28060e:	83 c4 10             	add    $0x10,%esp
  280611:	5b                   	pop    %ebx
  280612:	5e                   	pop    %esi
  280613:	5f                   	pop    %edi
  280614:	5d                   	pop    %ebp
  280615:	c3                   	ret    

00280616 <xtoa>:
    else
        value = value + 48;
    return value;
}

void xtoa(unsigned int value,char *buf){
  280616:	55                   	push   %ebp
    char tmp_buf[30] = {0};
  280617:	31 c0                	xor    %eax,%eax
    else
        value = value + 48;
    return value;
}

void xtoa(unsigned int value,char *buf){
  280619:	89 e5                	mov    %esp,%ebp
    char tmp_buf[30] = {0};
  28061b:	b9 1e 00 00 00       	mov    $0x1e,%ecx
    else
        value = value + 48;
    return value;
}

void xtoa(unsigned int value,char *buf){
  280620:	57                   	push   %edi
  280621:	56                   	push   %esi
  280622:	53                   	push   %ebx
  280623:	83 ec 20             	sub    $0x20,%esp
  280626:	8b 55 0c             	mov    0xc(%ebp),%edx
    char tmp_buf[30] = {0};
  280629:	8d 7d d6             	lea    -0x2a(%ebp),%edi
  28062c:	f3 aa                	rep stos %al,%es:(%edi)
    char *tbp = tmp_buf;
  28062e:	8d 45 d6             	lea    -0x2a(%ebp),%eax

    *buf++='0';
  280631:	c6 02 30             	movb   $0x30,(%edx)
    *buf++='x';
  280634:	8d 72 02             	lea    0x2(%edx),%esi
  280637:	c6 42 01 78          	movb   $0x78,0x1(%edx)
  
    do
    {
        // *tbp++ = ('0' + (char)(value % 16));//得到低位数字
	*tbp++=fourbtoc(value&0x0000000f);
  28063b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  28063e:	40                   	inc    %eax
  28063f:	83 e3 0f             	and    $0xf,%ebx
    
    
}
static  inline char fourbtoc(int value){
    if(value >= 10)
        value = value - 10 + 65;
  280642:	83 fb 0a             	cmp    $0xa,%ebx
  280645:	8d 4b 37             	lea    0x37(%ebx),%ecx
  280648:	8d 7b 30             	lea    0x30(%ebx),%edi
  28064b:	0f 4c cf             	cmovl  %edi,%ecx
        // *tbp++ = ('0' + (char)(value % 16));//得到低位数字
	*tbp++=fourbtoc(value&0x0000000f);
        
        //*tbp++ = ((value % 16)>9)?('A' + (char)(value % 16-10)):('0' + (char)(value % 16));//得到低位数字
        value >>= 4;
    }while(value);
  28064e:	c1 6d 08 04          	shrl   $0x4,0x8(%ebp)
static  inline char fourbtoc(int value){
    if(value >= 10)
        value = value - 10 + 65;
    else
        value = value + 48;
    return value;
  280652:	88 48 ff             	mov    %cl,-0x1(%eax)
        // *tbp++ = ('0' + (char)(value % 16));//得到低位数字
	*tbp++=fourbtoc(value&0x0000000f);
        
        //*tbp++ = ((value % 16)>9)?('A' + (char)(value % 16-10)):('0' + (char)(value % 16));//得到低位数字
        value >>= 4;
    }while(value);
  280655:	75 e4                	jne    28063b <xtoa+0x25>
    *buf++='x';
  
    do
    {
        // *tbp++ = ('0' + (char)(value % 16));//得到低位数字
	*tbp++=fourbtoc(value&0x0000000f);
  280657:	89 c3                	mov    %eax,%ebx
        //*tbp++ = ((value % 16)>9)?('A' + (char)(value % 16-10)):('0' + (char)(value % 16));//得到低位数字
        value >>= 4;
    }while(value);
    
    
    while(tmp_buf != tbp)
  280659:	8d 7d d6             	lea    -0x2a(%ebp),%edi
  28065c:	39 f8                	cmp    %edi,%eax
  28065e:	74 09                	je     280669 <xtoa+0x53>
    {
      tbp--;
  280660:	48                   	dec    %eax
      *buf++ = *tbp;
  280661:	8a 08                	mov    (%eax),%cl
  280663:	46                   	inc    %esi
  280664:	88 4e ff             	mov    %cl,-0x1(%esi)
  280667:	eb f0                	jmp    280659 <xtoa+0x43>
  280669:	29 c3                	sub    %eax,%ebx

    }
    *buf='\0';
  28066b:	c6 44 1a 02 00       	movb   $0x0,0x2(%edx,%ebx,1)
    
    
}
  280670:	83 c4 20             	add    $0x20,%esp
  280673:	5b                   	pop    %ebx
  280674:	5e                   	pop    %esi
  280675:	5f                   	pop    %edi
  280676:	5d                   	pop    %ebp
  280677:	c3                   	ret    

00280678 <sprintf>:



//实现可变参数的打印，主要是为了观察打印的变量。
void sprintf(char *str,char *format ,...)
{
  280678:	55                   	push   %ebp
  280679:	89 e5                	mov    %esp,%ebp
  28067b:	57                   	push   %edi
  28067c:	56                   	push   %esi
  28067d:	53                   	push   %ebx
  28067e:	83 ec 10             	sub    $0x10,%esp
  280681:	8b 5d 08             	mov    0x8(%ebp),%ebx
  
   int *var=(int *)(&format)+1; //得到第一个可变参数的地址
  280684:	8d 75 10             	lea    0x10(%ebp),%esi
   char buffer[10];
   char *buf=buffer;
  while(*format)
  280687:	8b 7d 0c             	mov    0xc(%ebp),%edi
  28068a:	8a 07                	mov    (%edi),%al
  28068c:	84 c0                	test   %al,%al
  28068e:	0f 84 83 00 00 00    	je     280717 <sprintf+0x9f>
  280694:	8d 4f 01             	lea    0x1(%edi),%ecx
  {
      if(*format!='%')
  280697:	3c 25                	cmp    $0x25,%al
      {
	*str++=*format++;
  280699:	89 4d 0c             	mov    %ecx,0xc(%ebp)
   int *var=(int *)(&format)+1; //得到第一个可变参数的地址
   char buffer[10];
   char *buf=buffer;
  while(*format)
  {
      if(*format!='%')
  28069c:	74 05                	je     2806a3 <sprintf+0x2b>
      {
	*str++=*format++;
  28069e:	88 03                	mov    %al,(%ebx)
  2806a0:	43                   	inc    %ebx
	continue;
  2806a1:	eb e4                	jmp    280687 <sprintf+0xf>
      }
      else
      {
	format++;
	switch (*format)
  2806a3:	8a 47 01             	mov    0x1(%edi),%al
  2806a6:	3c 73                	cmp    $0x73,%al
  2806a8:	74 46                	je     2806f0 <sprintf+0x78>
  2806aa:	3c 78                	cmp    $0x78,%al
  2806ac:	74 23                	je     2806d1 <sprintf+0x59>
  2806ae:	3c 64                	cmp    $0x64,%al
  2806b0:	75 53                	jne    280705 <sprintf+0x8d>
	{
	  case 'd':itoa(*var,buf);while(*buf){*str++=*buf++;};break;
  2806b2:	8d 45 ea             	lea    -0x16(%ebp),%eax
  2806b5:	50                   	push   %eax
  2806b6:	ff 36                	pushl  (%esi)
  2806b8:	e8 f7 fe ff ff       	call   2805b4 <itoa>
  2806bd:	59                   	pop    %ecx
  2806be:	8d 4d ea             	lea    -0x16(%ebp),%ecx
  2806c1:	58                   	pop    %eax
  2806c2:	89 d8                	mov    %ebx,%eax
  2806c4:	8a 19                	mov    (%ecx),%bl
  2806c6:	84 db                	test   %bl,%bl
  2806c8:	74 3d                	je     280707 <sprintf+0x8f>
  2806ca:	40                   	inc    %eax
  2806cb:	41                   	inc    %ecx
  2806cc:	88 58 ff             	mov    %bl,-0x1(%eax)
  2806cf:	eb f3                	jmp    2806c4 <sprintf+0x4c>
	  case 'x':xtoa(*var,buf);while(*buf){*str++=*buf++;};break;
  2806d1:	8d 45 ea             	lea    -0x16(%ebp),%eax
  2806d4:	50                   	push   %eax
  2806d5:	ff 36                	pushl  (%esi)
  2806d7:	e8 3a ff ff ff       	call   280616 <xtoa>
  2806dc:	8d 4d ea             	lea    -0x16(%ebp),%ecx
  2806df:	58                   	pop    %eax
  2806e0:	89 d8                	mov    %ebx,%eax
  2806e2:	5a                   	pop    %edx
  2806e3:	8a 19                	mov    (%ecx),%bl
  2806e5:	84 db                	test   %bl,%bl
  2806e7:	74 1e                	je     280707 <sprintf+0x8f>
  2806e9:	40                   	inc    %eax
  2806ea:	41                   	inc    %ecx
  2806eb:	88 58 ff             	mov    %bl,-0x1(%eax)
  2806ee:	eb f3                	jmp    2806e3 <sprintf+0x6b>
	  case 's':buf=(char*)(*var);while(*buf){*str++=*buf++;};break;
  2806f0:	8b 16                	mov    (%esi),%edx
  2806f2:	89 d8                	mov    %ebx,%eax
  2806f4:	89 c1                	mov    %eax,%ecx
  2806f6:	29 d9                	sub    %ebx,%ecx
  2806f8:	8a 0c 11             	mov    (%ecx,%edx,1),%cl
  2806fb:	84 c9                	test   %cl,%cl
  2806fd:	74 08                	je     280707 <sprintf+0x8f>
  2806ff:	40                   	inc    %eax
  280700:	88 48 ff             	mov    %cl,-0x1(%eax)
  280703:	eb ef                	jmp    2806f4 <sprintf+0x7c>
	continue;
      }
      else
      {
	format++;
	switch (*format)
  280705:	89 d8                	mov    %ebx,%eax
	  case 's':buf=(char*)(*var);while(*buf){*str++=*buf++;};break;
	  
	}
	buf=buffer;
	var++;
	format++;
  280707:	83 c7 02             	add    $0x2,%edi
	  case 'x':xtoa(*var,buf);while(*buf){*str++=*buf++;};break;
	  case 's':buf=(char*)(*var);while(*buf){*str++=*buf++;};break;
	  
	}
	buf=buffer;
	var++;
  28070a:	83 c6 04             	add    $0x4,%esi
	format++;
  28070d:	89 7d 0c             	mov    %edi,0xc(%ebp)
  280710:	89 c3                	mov    %eax,%ebx
  280712:	e9 70 ff ff ff       	jmp    280687 <sprintf+0xf>
	
      }
    
  }
  *str='\0';
  280717:	c6 03 00             	movb   $0x0,(%ebx)
  
}
  28071a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  28071d:	5b                   	pop    %ebx
  28071e:	5e                   	pop    %esi
  28071f:	5f                   	pop    %edi
  280720:	5d                   	pop    %ebp
  280721:	c3                   	ret    

00280722 <putfont8>:
}
  
}

void putfont8(char *vram ,int xsize,int x,int y,char color,char *font)//x=0 311 y=0 183
{
  280722:	55                   	push   %ebp
  280723:	89 e5                	mov    %esp,%ebp
  280725:	57                   	push   %edi
  280726:	56                   	push   %esi
  280727:	53                   	push   %ebx
  280728:	83 ec 05             	sub    $0x5,%esp
  28072b:	8b 55 14             	mov    0x14(%ebp),%edx
  28072e:	8b 45 10             	mov    0x10(%ebp),%eax
  280731:	8a 5d 18             	mov    0x18(%ebp),%bl
  280734:	0f af 55 0c          	imul   0xc(%ebp),%edx
  280738:	03 45 08             	add    0x8(%ebp),%eax
  28073b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  280742:	88 5d ef             	mov    %bl,-0x11(%ebp)
  280745:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  int row,col;
  char d;
  for(row=0;row<16;row++)
  280748:	31 c0                	xor    %eax,%eax
  28074a:	8b 75 f0             	mov    -0x10(%ebp),%esi
  {
    d=font[row];
    for(col=0;col<8;col++)
  28074d:	31 c9                	xor    %ecx,%ecx
  28074f:	8d 1c 3e             	lea    (%esi,%edi,1),%ebx
    {
      if(d&(0x80>>col))
  280752:	8b 75 1c             	mov    0x1c(%ebp),%esi
  280755:	0f be 34 06          	movsbl (%esi,%eax,1),%esi
  280759:	ba 80 00 00 00       	mov    $0x80,%edx
  28075e:	d3 fa                	sar    %cl,%edx
  280760:	85 f2                	test   %esi,%edx
  280762:	74 06                	je     28076a <putfont8+0x48>
      {
	vram[(y+row)*xsize+x+col]=color;
  280764:	8a 55 ef             	mov    -0x11(%ebp),%dl
  280767:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  int row,col;
  char d;
  for(row=0;row<16;row++)
  {
    d=font[row];
    for(col=0;col<8;col++)
  28076a:	41                   	inc    %ecx
  28076b:	83 f9 08             	cmp    $0x8,%ecx
  28076e:	75 e9                	jne    280759 <putfont8+0x37>

void putfont8(char *vram ,int xsize,int x,int y,char color,char *font)//x=0 311 y=0 183
{
  int row,col;
  char d;
  for(row=0;row<16;row++)
  280770:	40                   	inc    %eax
  280771:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  280774:	01 5d f0             	add    %ebx,-0x10(%ebp)
  280777:	83 f8 10             	cmp    $0x10,%eax
  28077a:	75 ce                	jne    28074a <putfont8+0x28>
    }
    
  }
  return;
  
}
  28077c:	83 c4 05             	add    $0x5,%esp
  28077f:	5b                   	pop    %ebx
  280780:	5e                   	pop    %esi
  280781:	5f                   	pop    %edi
  280782:	5d                   	pop    %ebp
  280783:	c3                   	ret    

00280784 <puts8>:
  *str='\0';
  
}

void puts8(char *vram ,int xsize,int x,int y,char color,char *font)//x=0 311 y=0 183
{
  280784:	55                   	push   %ebp
  280785:	89 e5                	mov    %esp,%ebp
  280787:	57                   	push   %edi
  280788:	8b 7d 14             	mov    0x14(%ebp),%edi
  28078b:	56                   	push   %esi
      y=y+16;
      
    }
    else
    {  
    putfont8((char *)vram ,xsize,x,y,color,(char *)(Font8x16+(*font)*16));
  28078c:	0f be 75 18          	movsbl 0x18(%ebp),%esi
  *str='\0';
  
}

void puts8(char *vram ,int xsize,int x,int y,char color,char *font)//x=0 311 y=0 183
{
  280790:	53                   	push   %ebx
  280791:	8b 5d 10             	mov    0x10(%ebp),%ebx
  
 while(*font)
  280794:	8b 45 1c             	mov    0x1c(%ebp),%eax
  280797:	0f be 00             	movsbl (%eax),%eax
  28079a:	84 c0                	test   %al,%al
  28079c:	74 42                	je     2807e0 <puts8+0x5c>
 {
    if(*font=='\n')
  28079e:	3c 0a                	cmp    $0xa,%al
  2807a0:	75 05                	jne    2807a7 <puts8+0x23>
    {
      x=0;
      y=y+16;
  2807a2:	83 c7 10             	add    $0x10,%edi
  2807a5:	eb 32                	jmp    2807d9 <puts8+0x55>
      
    }
    else
    {  
    putfont8((char *)vram ,xsize,x,y,color,(char *)(Font8x16+(*font)*16));
  2807a7:	c1 e0 04             	shl    $0x4,%eax
  2807aa:	05 a0 0e 28 00       	add    $0x280ea0,%eax
  2807af:	50                   	push   %eax
  2807b0:	56                   	push   %esi
  2807b1:	57                   	push   %edi
  2807b2:	53                   	push   %ebx
    x+=8;
  2807b3:	83 c3 08             	add    $0x8,%ebx
      y=y+16;
      
    }
    else
    {  
    putfont8((char *)vram ,xsize,x,y,color,(char *)(Font8x16+(*font)*16));
  2807b6:	ff 75 0c             	pushl  0xc(%ebp)
  2807b9:	ff 75 08             	pushl  0x8(%ebp)
  2807bc:	e8 61 ff ff ff       	call   280722 <putfont8>
    x+=8;
    if(x>312)
  2807c1:	83 c4 18             	add    $0x18,%esp
  2807c4:	81 fb 38 01 00 00    	cmp    $0x138,%ebx
  2807ca:	7e 0f                	jle    2807db <puts8+0x57>
       {
	  x=0;
	  y+=16;
  2807cc:	83 c7 10             	add    $0x10,%edi
	  if(y>183)
  2807cf:	81 ff b7 00 00 00    	cmp    $0xb7,%edi
  2807d5:	7e 02                	jle    2807d9 <puts8+0x55>
	  {
	    x=0;
	    y=0;
  2807d7:	31 ff                	xor    %edi,%edi
       {
	  x=0;
	  y+=16;
	  if(y>183)
	  {
	    x=0;
  2807d9:	31 db                	xor    %ebx,%ebx
	    
	  }
        }    
    }
    
    font++;
  2807db:	ff 45 1c             	incl   0x1c(%ebp)
  2807de:	eb b4                	jmp    280794 <puts8+0x10>
}
  
}
  2807e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  2807e3:	5b                   	pop    %ebx
  2807e4:	5e                   	pop    %esi
  2807e5:	5f                   	pop    %edi
  2807e6:	5d                   	pop    %ebp
  2807e7:	c3                   	ret    

002807e8 <printdebug>:
#include<header.h>


void printdebug(int i,int x)
{
  2807e8:	55                   	push   %ebp
  2807e9:	89 e5                	mov    %esp,%ebp
  2807eb:	53                   	push   %ebx
  2807ec:	83 ec 20             	sub    $0x20,%esp
char font[30];
sprintf(font,"Debug:var=%x" ,i);
  2807ef:	ff 75 08             	pushl  0x8(%ebp)
  2807f2:	8d 5d de             	lea    -0x22(%ebp),%ebx
  2807f5:	68 bc 29 28 00       	push   $0x2829bc
  2807fa:	53                   	push   %ebx
  2807fb:	e8 78 fe ff ff       	call   280678 <sprintf>
puts8((char *)VRAM ,320,x,150,1,font);
  280800:	53                   	push   %ebx
  280801:	6a 01                	push   $0x1
  280803:	68 96 00 00 00       	push   $0x96
  280808:	ff 75 0c             	pushl  0xc(%ebp)
  28080b:	68 40 01 00 00       	push   $0x140
  280810:	68 00 00 0a 00       	push   $0xa0000
  280815:	e8 6a ff ff ff       	call   280784 <puts8>
  28081a:	83 c4 24             	add    $0x24,%esp

}
  28081d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  280820:	c9                   	leave  
  280821:	c3                   	ret    

00280822 <putfont16>:
      
  }
  
}
void putfont16(char *vram ,int xsize,int x,int y,char color,unsigned short *font)//x=0 311 y=0 183
{
  280822:	55                   	push   %ebp
  int row,col;
  unsigned short  d;
  unsigned short *pt=(unsigned short *)(font-32*24);
  for(row=0;row<24;row++)
  280823:	31 c9                	xor    %ecx,%ecx
      
  }
  
}
void putfont16(char *vram ,int xsize,int x,int y,char color,unsigned short *font)//x=0 311 y=0 183
{
  280825:	89 e5                	mov    %esp,%ebp
  280827:	8b 45 14             	mov    0x14(%ebp),%eax
  28082a:	56                   	push   %esi
  28082b:	53                   	push   %ebx
  28082c:	8a 5d 18             	mov    0x18(%ebp),%bl
  28082f:	0f af 45 0c          	imul   0xc(%ebp),%eax
  280833:	03 45 10             	add    0x10(%ebp),%eax
  280836:	03 45 08             	add    0x8(%ebp),%eax
  for(row=0;row<24;row++)
  {
    d=pt[row];
    for(col=0;col<16;col++)
    {
       if( (d&(1 << col) ))
  280839:	8b 75 1c             	mov    0x1c(%ebp),%esi
  unsigned short  d;
  unsigned short *pt=(unsigned short *)(font-32*24);
  for(row=0;row<24;row++)
  {
    d=pt[row];
    for(col=0;col<16;col++)
  28083c:	31 d2                	xor    %edx,%edx
    {
       if( (d&(1 << col) ))
  28083e:	0f b7 b4 4e 00 fa ff 	movzwl -0x600(%esi,%ecx,2),%esi
  280845:	ff 
  280846:	0f a3 d6             	bt     %edx,%esi
  280849:	73 03                	jae    28084e <putfont16+0x2c>
     // if((d<<col)&0x0001)
      {
	vram[(y+row)*xsize+x+col]=color;
  28084b:	88 1c 10             	mov    %bl,(%eax,%edx,1)
  unsigned short  d;
  unsigned short *pt=(unsigned short *)(font-32*24);
  for(row=0;row<24;row++)
  {
    d=pt[row];
    for(col=0;col<16;col++)
  28084e:	42                   	inc    %edx
  28084f:	83 fa 10             	cmp    $0x10,%edx
  280852:	75 f2                	jne    280846 <putfont16+0x24>
void putfont16(char *vram ,int xsize,int x,int y,char color,unsigned short *font)//x=0 311 y=0 183
{
  int row,col;
  unsigned short  d;
  unsigned short *pt=(unsigned short *)(font-32*24);
  for(row=0;row<24;row++)
  280854:	41                   	inc    %ecx
  280855:	03 45 0c             	add    0xc(%ebp),%eax
  280858:	83 f9 18             	cmp    $0x18,%ecx
  28085b:	75 dc                	jne    280839 <putfont16+0x17>
    }
    
  }
  return;
  
}
  28085d:	5b                   	pop    %ebx
  28085e:	5e                   	pop    %esi
  28085f:	5d                   	pop    %ebp
  280860:	c3                   	ret    

00280861 <puts16>:
  return;
  
}
//print string: big string
void puts16(char *vram ,int xsize,int x,int y,char color,char *font)
{
  280861:	55                   	push   %ebp
  280862:	89 e5                	mov    %esp,%ebp
  280864:	57                   	push   %edi
  280865:	8b 7d 10             	mov    0x10(%ebp),%edi
  280868:	56                   	push   %esi
  280869:	8b 75 14             	mov    0x14(%ebp),%esi
  28086c:	53                   	push   %ebx
      
    }
    else
    {
	pt=(unsigned short *)((*font)*24+ASCII_Table);
	putfont16(vram ,xsize,x,y,color,pt);
  28086d:	0f be 5d 18          	movsbl 0x18(%ebp),%ebx
}
//print string: big string
void puts16(char *vram ,int xsize,int x,int y,char color,char *font)
{
  unsigned short  *pt;
  while(*font)
  280871:	8b 45 1c             	mov    0x1c(%ebp),%eax
  280874:	0f be 00             	movsbl (%eax),%eax
  280877:	84 c0                	test   %al,%al
  280879:	74 2d                	je     2808a8 <puts16+0x47>
  {
    if(*font=='\n')
  28087b:	3c 0a                	cmp    $0xa,%al
  28087d:	75 07                	jne    280886 <puts16+0x25>
    {
      x=0;
      y=y+24;
  28087f:	83 c6 18             	add    $0x18,%esi
  unsigned short  *pt;
  while(*font)
  {
    if(*font=='\n')
    {
      x=0;
  280882:	31 ff                	xor    %edi,%edi
  280884:	eb 1d                	jmp    2808a3 <puts16+0x42>
      y=y+24;
      
    }
    else
    {
	pt=(unsigned short *)((*font)*24+ASCII_Table);
  280886:	6b c0 30             	imul   $0x30,%eax,%eax
  280889:	05 a0 16 28 00       	add    $0x2816a0,%eax
	putfont16(vram ,xsize,x,y,color,pt);
  28088e:	50                   	push   %eax
  28088f:	53                   	push   %ebx
  280890:	56                   	push   %esi
  280891:	57                   	push   %edi
	x=x+16;
  280892:	83 c7 10             	add    $0x10,%edi
      
    }
    else
    {
	pt=(unsigned short *)((*font)*24+ASCII_Table);
	putfont16(vram ,xsize,x,y,color,pt);
  280895:	ff 75 0c             	pushl  0xc(%ebp)
  280898:	ff 75 08             	pushl  0x8(%ebp)
  28089b:	e8 82 ff ff ff       	call   280822 <putfont16>
	x=x+16;
  2808a0:	83 c4 18             	add    $0x18,%esp
	   
	   
    }
    
     font++;
  2808a3:	ff 45 1c             	incl   0x1c(%ebp)
  2808a6:	eb c9                	jmp    280871 <puts16+0x10>
      
  }
  
}
  2808a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  2808ab:	5b                   	pop    %ebx
  2808ac:	5e                   	pop    %esi
  2808ad:	5f                   	pop    %edi
  2808ae:	5d                   	pop    %ebp
  2808af:	c3                   	ret    

002808b0 <setgdt>:
#include<header.h>



void setgdt(struct GDT *sd ,unsigned int limit,int base,int access)//sd: selector describe
{
  2808b0:	55                   	push   %ebp
  2808b1:	89 e5                	mov    %esp,%ebp
  2808b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  2808b6:	57                   	push   %edi
  2808b7:	8b 45 08             	mov    0x8(%ebp),%eax
  2808ba:	56                   	push   %esi
  2808bb:	8b 7d 14             	mov    0x14(%ebp),%edi
  2808be:	53                   	push   %ebx
  2808bf:	8b 5d 10             	mov    0x10(%ebp),%ebx
	if(limit>0xffff)
  2808c2:	81 fa ff ff 00 00    	cmp    $0xffff,%edx
  2808c8:	76 09                	jbe    2808d3 <setgdt+0x23>
	{
		access|=0x8000;
  2808ca:	81 cf 00 80 00 00    	or     $0x8000,%edi
		limit /=0x1000;
  2808d0:	c1 ea 0c             	shr    $0xc,%edx
	}
	sd->limit_low=limit&0xffff;
	sd->base_low=base &0xffff;
	sd->base_mid=(base>>16)&0xff;
  2808d3:	89 de                	mov    %ebx,%esi
  2808d5:	c1 fe 10             	sar    $0x10,%esi
  2808d8:	89 f1                	mov    %esi,%ecx
  2808da:	88 48 04             	mov    %cl,0x4(%eax)
	sd->access_right=access&0xff;
  2808dd:	89 f9                	mov    %edi,%ecx
	sd->limit_high=((limit>>16)&0x0f)|((access>>8)&0xf0);//低４位是limt的高位，高４位是访问的权限设置。
  2808df:	c1 ff 08             	sar    $0x8,%edi
		limit /=0x1000;
	}
	sd->limit_low=limit&0xffff;
	sd->base_low=base &0xffff;
	sd->base_mid=(base>>16)&0xff;
	sd->access_right=access&0xff;
  2808e2:	88 48 05             	mov    %cl,0x5(%eax)
	sd->limit_high=((limit>>16)&0x0f)|((access>>8)&0xf0);//低４位是limt的高位，高４位是访问的权限设置。
  2808e5:	89 f9                	mov    %edi,%ecx
	if(limit>0xffff)
	{
		access|=0x8000;
		limit /=0x1000;
	}
	sd->limit_low=limit&0xffff;
  2808e7:	66 89 10             	mov    %dx,(%eax)
	sd->base_low=base &0xffff;
	sd->base_mid=(base>>16)&0xff;
	sd->access_right=access&0xff;
	sd->limit_high=((limit>>16)&0x0f)|((access>>8)&0xf0);//低４位是limt的高位，高４位是访问的权限设置。
  2808ea:	83 e1 f0             	and    $0xfffffff0,%ecx
  2808ed:	c1 ea 10             	shr    $0x10,%edx
	{
		access|=0x8000;
		limit /=0x1000;
	}
	sd->limit_low=limit&0xffff;
	sd->base_low=base &0xffff;
  2808f0:	66 89 58 02          	mov    %bx,0x2(%eax)
	sd->base_mid=(base>>16)&0xff;
	sd->access_right=access&0xff;
	sd->limit_high=((limit>>16)&0x0f)|((access>>8)&0xf0);//低４位是limt的高位，高４位是访问的权限设置。
  2808f4:	09 d1                	or     %edx,%ecx
	sd->base_high=(base>>24)&0xff;
  2808f6:	c1 eb 18             	shr    $0x18,%ebx
	}
	sd->limit_low=limit&0xffff;
	sd->base_low=base &0xffff;
	sd->base_mid=(base>>16)&0xff;
	sd->access_right=access&0xff;
	sd->limit_high=((limit>>16)&0x0f)|((access>>8)&0xf0);//低４位是limt的高位，高４位是访问的权限设置。
  2808f9:	88 48 06             	mov    %cl,0x6(%eax)
	sd->base_high=(base>>24)&0xff;
  2808fc:	88 58 07             	mov    %bl,0x7(%eax)

}
  2808ff:	5b                   	pop    %ebx
  280900:	5e                   	pop    %esi
  280901:	5f                   	pop    %edi
  280902:	5d                   	pop    %ebp
  280903:	c3                   	ret    

00280904 <setidt>:

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
  280904:	55                   	push   %ebp
  280905:	89 e5                	mov    %esp,%ebp
  280907:	8b 45 08             	mov    0x8(%ebp),%eax
  28090a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  28090d:	8b 55 14             	mov    0x14(%ebp),%edx
	//idt中有32位的offset address
	gd->offset_low=offset & 0xffff;
  280910:	66 89 08             	mov    %cx,(%eax)
	gd->offset_high=(offset>>16)&0xffff;
  280913:	c1 e9 10             	shr    $0x10,%ecx
  280916:	66 89 48 06          	mov    %cx,0x6(%eax)

	//16位的selector决定了base address
	gd->selector=selector;
  28091a:	8b 4d 10             	mov    0x10(%ebp),%ecx

	gd->dw_count=(access>>8)&0xff;
	gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的
  28091d:	88 50 05             	mov    %dl,0x5(%eax)
	//idt中有32位的offset address
	gd->offset_low=offset & 0xffff;
	gd->offset_high=(offset>>16)&0xffff;

	//16位的selector决定了base address
	gd->selector=selector;
  280920:	66 89 48 02          	mov    %cx,0x2(%eax)

	gd->dw_count=(access>>8)&0xff;
  280924:	89 d1                	mov    %edx,%ecx
  280926:	c1 f9 08             	sar    $0x8,%ecx
  280929:	88 48 04             	mov    %cl,0x4(%eax)
	gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的


}
  28092c:	5d                   	pop    %ebp
  28092d:	c3                   	ret    

0028092e <init_gdtidt>:



void  init_gdtidt()
{
  28092e:	55                   	push   %ebp
  28092f:	89 e5                	mov    %esp,%ebp
  280931:	53                   	push   %ebx
  280932:	53                   	push   %ebx
  280933:	bb 00 00 27 00       	mov    $0x270000,%ebx
	struct GDT *gdt=(struct GDT *)(0x00270000);
	struct IDT *idt=(struct IDT *)(0x0026f800);
	int i;
	for(i=0;i<8192;i++)
	{
		setgdt(gdt+i,0,0,0);
  280938:	6a 00                	push   $0x0
  28093a:	6a 00                	push   $0x0
  28093c:	6a 00                	push   $0x0
  28093e:	53                   	push   %ebx
  28093f:	83 c3 08             	add    $0x8,%ebx
  280942:	e8 69 ff ff ff       	call   2808b0 <setgdt>
void  init_gdtidt()
{
	struct GDT *gdt=(struct GDT *)(0x00270000);
	struct IDT *idt=(struct IDT *)(0x0026f800);
	int i;
	for(i=0;i<8192;i++)
  280947:	83 c4 10             	add    $0x10,%esp
  28094a:	81 fb 00 00 28 00    	cmp    $0x280000,%ebx
  280950:	75 e6                	jne    280938 <init_gdtidt+0xa>
	{
		setgdt(gdt+i,0,0,0);
	}
	setgdt(gdt+1,0xffffffff   ,0x00000000,0x4092);//entry.s main.c data 4GB空间的数据都能访问
  280952:	68 92 40 00 00       	push   $0x4092
  280957:	6a 00                	push   $0x0
  280959:	6a ff                	push   $0xffffffff
  28095b:	68 08 00 27 00       	push   $0x270008
  280960:	e8 4b ff ff ff       	call   2808b0 <setgdt>
	setgdt(gdt+2,0x000fffff   ,0x00000000,0x409a);//entry.S code
  280965:	68 9a 40 00 00       	push   $0x409a
  28096a:	6a 00                	push   $0x0
  28096c:	68 ff ff 0f 00       	push   $0xfffff
  280971:	68 10 00 27 00       	push   $0x270010
  280976:	e8 35 ff ff ff       	call   2808b0 <setgdt>
	setgdt(gdt+3,0x000fffff   ,0x00280000,0x409a);  //main.c code　 0x7ffff=512kB
  28097b:	83 c4 20             	add    $0x20,%esp
  28097e:	68 9a 40 00 00       	push   $0x409a
  280983:	68 00 00 28 00       	push   $0x280000
  280988:	68 ff ff 0f 00       	push   $0xfffff
  28098d:	68 18 00 27 00       	push   $0x270018
  280992:	e8 19 ff ff ff       	call   2808b0 <setgdt>

	load_gdtr(0xfff,0X00270000);//this is right
  280997:	5a                   	pop    %edx
  280998:	59                   	pop    %ecx
  280999:	68 00 00 27 00       	push   $0x270000
  28099e:	68 ff 0f 00 00       	push   $0xfff
  2809a3:	e8 f9 01 00 00       	call   280ba1 <load_gdtr>
  2809a8:	83 c4 10             	add    $0x10,%esp
  2809ab:	31 c0                	xor    %eax,%eax
}

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
	//idt中有32位的offset address
	gd->offset_low=offset & 0xffff;
  2809ad:	66 c7 80 00 f8 26 00 	movw   $0x0,0x26f800(%eax)
  2809b4:	00 00 
  2809b6:	83 c0 08             	add    $0x8,%eax
	gd->offset_high=(offset>>16)&0xffff;
  2809b9:	66 c7 80 fe f7 26 00 	movw   $0x0,0x26f7fe(%eax)
  2809c0:	00 00 

	//16位的selector决定了base address
	gd->selector=selector;
  2809c2:	66 c7 80 fa f7 26 00 	movw   $0x0,0x26f7fa(%eax)
  2809c9:	00 00 

	gd->dw_count=(access>>8)&0xff;
  2809cb:	c6 80 fc f7 26 00 00 	movb   $0x0,0x26f7fc(%eax)
	gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的
  2809d2:	c6 80 fd f7 26 00 00 	movb   $0x0,0x26f7fd(%eax)
	setgdt(gdt+2,0x000fffff   ,0x00000000,0x409a);//entry.S code
	setgdt(gdt+3,0x000fffff   ,0x00280000,0x409a);  //main.c code　 0x7ffff=512kB

	load_gdtr(0xfff,0X00270000);//this is right

	for(i=0;i<256;i++)
  2809d9:	3d 00 08 00 00       	cmp    $0x800,%eax
  2809de:	75 cd                	jne    2809ad <init_gdtidt+0x7f>

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
	//idt中有32位的offset address
	gd->offset_low=offset & 0xffff;
	gd->offset_high=(offset>>16)&0xffff;
  2809e0:	ba 50 0b 28 00       	mov    $0x280b50,%edx
  2809e5:	66 31 c0             	xor    %ax,%ax
  2809e8:	c1 ea 10             	shr    $0x10,%edx
}

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
	//idt中有32位的offset address
	gd->offset_low=offset & 0xffff;
  2809eb:	b9 50 0b 28 00       	mov    $0x280b50,%ecx
  2809f0:	66 89 88 00 f8 26 00 	mov    %cx,0x26f800(%eax)
  2809f7:	83 c0 08             	add    $0x8,%eax
	gd->offset_high=(offset>>16)&0xffff;
  2809fa:	66 89 90 fe f7 26 00 	mov    %dx,0x26f7fe(%eax)

	//16位的selector决定了base address
	gd->selector=selector;
  280a01:	66 c7 80 fa f7 26 00 	movw   $0x18,0x26f7fa(%eax)
  280a08:	18 00 

	gd->dw_count=(access>>8)&0xff;
  280a0a:	c6 80 fc f7 26 00 00 	movb   $0x0,0x26f7fc(%eax)
	gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的
  280a11:	c6 80 fd f7 26 00 8e 	movb   $0x8e,0x26f7fd(%eax)
	for(i=0;i<256;i++)
	{
		setidt(idt+i,0,0,0);
	}

	for(i=0;i<256;i++)
  280a18:	3d 00 08 00 00       	cmp    $0x800,%eax
  280a1d:	75 d1                	jne    2809f0 <init_gdtidt+0xc2>
	{
		setidt(idt+i,(int)asm_inthandler21,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了

	}
	setidt(idt+0x21,(int)asm_inthandler21-0x280000,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了
  280a1f:	b8 50 0b 00 00       	mov    $0xb50,%eax
}

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
	//idt中有32位的offset address
	gd->offset_low=offset & 0xffff;
  280a24:	66 a3 08 f9 26 00    	mov    %ax,0x26f908
	gd->offset_high=(offset>>16)&0xffff;
  280a2a:	c1 e8 10             	shr    $0x10,%eax
  280a2d:	66 a3 0e f9 26 00    	mov    %ax,0x26f90e
	{
		setidt(idt+i,(int)asm_inthandler21,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了

	}
	setidt(idt+0x21,(int)asm_inthandler21-0x280000,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了
	setidt(idt+0x27,(int)asm_inthandler27-0x280000,3*8,0x008e);//
  280a33:	b8 6b 0b 00 00       	mov    $0xb6b,%eax
}

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
	//idt中有32位的offset address
	gd->offset_low=offset & 0xffff;
  280a38:	66 a3 38 f9 26 00    	mov    %ax,0x26f938
	gd->offset_high=(offset>>16)&0xffff;
  280a3e:	c1 e8 10             	shr    $0x10,%eax
  280a41:	66 a3 3e f9 26 00    	mov    %ax,0x26f93e
		setidt(idt+i,(int)asm_inthandler21,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了

	}
	setidt(idt+0x21,(int)asm_inthandler21-0x280000,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了
	setidt(idt+0x27,(int)asm_inthandler27-0x280000,3*8,0x008e);//
	setidt(idt+0x2c,(int)asm_inthandler2c-0x280000,3*8,0x008e);
  280a47:	b8 86 0b 00 00       	mov    $0xb86,%eax
}

void setidt(struct IDT *gd,int offset,int selector,int access)//gd: gate describe
{
	//idt中有32位的offset address
	gd->offset_low=offset & 0xffff;
  280a4c:	66 a3 60 f9 26 00    	mov    %ax,0x26f960
	gd->offset_high=(offset>>16)&0xffff;
  280a52:	c1 e8 10             	shr    $0x10,%eax
  280a55:	66 a3 66 f9 26 00    	mov    %ax,0x26f966

	//16位的selector决定了base address
	gd->selector=selector;
  280a5b:	66 c7 05 0a f9 26 00 	movw   $0x18,0x26f90a
  280a62:	18 00 

	gd->dw_count=(access>>8)&0xff;
  280a64:	c6 05 0c f9 26 00 00 	movb   $0x0,0x26f90c
	gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的
  280a6b:	c6 05 0d f9 26 00 8e 	movb   $0x8e,0x26f90d
	//idt中有32位的offset address
	gd->offset_low=offset & 0xffff;
	gd->offset_high=(offset>>16)&0xffff;

	//16位的selector决定了base address
	gd->selector=selector;
  280a72:	66 c7 05 3a f9 26 00 	movw   $0x18,0x26f93a
  280a79:	18 00 

	gd->dw_count=(access>>8)&0xff;
  280a7b:	c6 05 3c f9 26 00 00 	movb   $0x0,0x26f93c
	gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的
  280a82:	c6 05 3d f9 26 00 8e 	movb   $0x8e,0x26f93d
	//idt中有32位的offset address
	gd->offset_low=offset & 0xffff;
	gd->offset_high=(offset>>16)&0xffff;

	//16位的selector决定了base address
	gd->selector=selector;
  280a89:	66 c7 05 62 f9 26 00 	movw   $0x18,0x26f962
  280a90:	18 00 

	gd->dw_count=(access>>8)&0xff;
  280a92:	c6 05 64 f9 26 00 00 	movb   $0x0,0x26f964
	gd->access_right=(char)(access&0xff);//晕倒啊，是不是啊，天啊，访问权限是一个非常重要的量，错一点都不行的
  280a99:	c6 05 65 f9 26 00 8e 	movb   $0x8e,0x26f965

	}
	setidt(idt+0x21,(int)asm_inthandler21-0x280000,3*8,0x008e);//用printdebug显示之后，证明这一部分是写进去了
	setidt(idt+0x27,(int)asm_inthandler27-0x280000,3*8,0x008e);//
	setidt(idt+0x2c,(int)asm_inthandler2c-0x280000,3*8,0x008e);
	load_idtr(0x7ff,0x0026f800);//this is right
  280aa0:	50                   	push   %eax
  280aa1:	50                   	push   %eax
  280aa2:	68 00 f8 26 00       	push   $0x26f800
  280aa7:	68 ff 07 00 00       	push   $0x7ff
  280aac:	e8 00 01 00 00       	call   280bb1 <load_idtr>
  280ab1:	83 c4 10             	add    $0x10,%esp

	return;

}
  280ab4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  280ab7:	c9                   	leave  
  280ab8:	c3                   	ret    
  280ab9:	66 90                	xchg   %ax,%ax
  280abb:	90                   	nop

00280abc <init_pic>:
#include "header.h"

extern struct boot_info *bootp;
void init_pic()
{
  280abc:	55                   	push   %ebp
// out:write a data to a port
static __inline void
outb(int port, uint8_t data)
{
  //data是变量0%0 , port是变量word１%w1
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  280abd:	ba 21 00 00 00       	mov    $0x21,%edx
  280ac2:	89 e5                	mov    %esp,%ebp
  280ac4:	b0 ff                	mov    $0xff,%al
  280ac6:	ee                   	out    %al,(%dx)
  280ac7:	b2 a1                	mov    $0xa1,%dl
  280ac9:	ee                   	out    %al,(%dx)
  280aca:	b0 11                	mov    $0x11,%al
  280acc:	b2 20                	mov    $0x20,%dl
  280ace:	ee                   	out    %al,(%dx)
  280acf:	b0 20                	mov    $0x20,%al
  280ad1:	b2 21                	mov    $0x21,%dl
  280ad3:	ee                   	out    %al,(%dx)
  280ad4:	b0 04                	mov    $0x4,%al
  280ad6:	ee                   	out    %al,(%dx)
  280ad7:	b0 01                	mov    $0x1,%al
  280ad9:	ee                   	out    %al,(%dx)
  280ada:	b0 11                	mov    $0x11,%al
  280adc:	b2 a0                	mov    $0xa0,%dl
  280ade:	ee                   	out    %al,(%dx)
  280adf:	b0 28                	mov    $0x28,%al
  280ae1:	b2 a1                	mov    $0xa1,%dl
  280ae3:	ee                   	out    %al,(%dx)
  280ae4:	b0 02                	mov    $0x2,%al
  280ae6:	ee                   	out    %al,(%dx)
  280ae7:	b0 01                	mov    $0x1,%al
  280ae9:	ee                   	out    %al,(%dx)
  280aea:	b0 fb                	mov    $0xfb,%al
  280aec:	b2 21                	mov    $0x21,%dl
  280aee:	ee                   	out    %al,(%dx)
  280aef:	b0 ff                	mov    $0xff,%al
  280af1:	b2 a1                	mov    $0xa1,%dl
  280af3:	ee                   	out    %al,(%dx)
这是因为int 0x00-0x1f不能用于irq,因为这２０个Int是留给系统的，是给mi（not mask interrupt）用的。

所以cpu发现是产生了int 0到int0x1f时，就知道是非常重要的中断产生了，是不可mask的，一定要执行的。

   */
}
  280af4:	5d                   	pop    %ebp
  280af5:	c3                   	ret    

00280af6 <inthandler21>:
#define PORT_KEYDAT	0x0060
struct FIFO8 keyfifo;

//interrupt service procedure for keyboard
void inthandler21(int *esp)
{
  280af6:	55                   	push   %ebp
  280af7:	ba 20 00 00 00       	mov    $0x20,%edx
  280afc:	89 e5                	mov    %esp,%ebp
  280afe:	b0 61                	mov    $0x61,%al
  280b00:	83 ec 10             	sub    $0x10,%esp
  280b03:	ee                   	out    %al,(%dx)
static __inline uint8_t
inb(int port)
{
  //read a byte from port
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  280b04:	b2 60                	mov    $0x60,%dl
  280b06:	ec                   	in     (%dx),%al
  unsigned char data;
  io_out8(PIC0_OCW2, 0x61);
  data=io_in8(PORT_KEYDAT);
  fifo8_put(&keyfifo, data);
  280b07:	0f b6 c0             	movzbl %al,%eax
  280b0a:	50                   	push   %eax
  280b0b:	68 28 2f 28 00       	push   $0x282f28
  280b10:	e8 da 00 00 00       	call   280bef <fifo8_put>
  280b15:	83 c4 10             	add    $0x10,%esp
  return;  
}
  280b18:	c9                   	leave  
  280b19:	c3                   	ret    

00280b1a <inthandler2c>:

struct FIFO8 mousefifo;
void inthandler2c(int *esp)
{
  280b1a:	55                   	push   %ebp
// out:write a data to a port
static __inline void
outb(int port, uint8_t data)
{
  //data是变量0%0 , port是变量word１%w1
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  280b1b:	ba a0 00 00 00       	mov    $0xa0,%edx
  280b20:	89 e5                	mov    %esp,%ebp
  280b22:	b0 64                	mov    $0x64,%al
  280b24:	83 ec 10             	sub    $0x10,%esp
  280b27:	ee                   	out    %al,(%dx)
  280b28:	b0 62                	mov    $0x62,%al
  280b2a:	b2 20                	mov    $0x20,%dl
  280b2c:	ee                   	out    %al,(%dx)
static __inline uint8_t
inb(int port)
{
  //read a byte from port
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  280b2d:	b2 60                	mov    $0x60,%dl
  280b2f:	ec                   	in     (%dx),%al
  unsigned char data;
  io_out8(PIC1_OCW2, 0x64);
  io_out8(PIC0_OCW2, 0x62);
  data=io_in8(PORT_KEYDAT);
  fifo8_put(&mousefifo, data);
  280b30:	0f b6 c0             	movzbl %al,%eax
  280b33:	50                   	push   %eax
  280b34:	68 40 2f 28 00       	push   $0x282f40
  280b39:	e8 b1 00 00 00       	call   280bef <fifo8_put>
  280b3e:	83 c4 10             	add    $0x10,%esp
  return;    
}
  280b41:	c9                   	leave  
  280b42:	c3                   	ret    

00280b43 <inthandler27>:

void inthandler27(int *esp)
{
  280b43:	55                   	push   %ebp
// out:write a data to a port
static __inline void
outb(int port, uint8_t data)
{
  //data是变量0%0 , port是变量word１%w1
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  280b44:	ba 20 00 00 00       	mov    $0x20,%edx
  280b49:	89 e5                	mov    %esp,%ebp
  280b4b:	b0 67                	mov    $0x67,%al
  280b4d:	ee                   	out    %al,(%dx)
  io_out8(PIC0_OCW2, 0x67);
  return;
}
  280b4e:	5d                   	pop    %ebp
  280b4f:	c3                   	ret    

00280b50 <asm_inthandler21>:
.global load_gdtr 
.global load_idtr
.global io_stihlt
.code32
asm_inthandler21:
  pushw %es
  280b50:	66 06                	pushw  %es
  pushw %ds
  280b52:	66 1e                	pushw  %ds
  pushal
  280b54:	60                   	pusha  
  movl %esp,%eax
  280b55:	89 e0                	mov    %esp,%eax
  pushl %eax
  280b57:	50                   	push   %eax
  movw %ss,%ax
  280b58:	66 8c d0             	mov    %ss,%ax
  movw %ax,%ds
  280b5b:	8e d8                	mov    %eax,%ds
  movw %ax,%es
  280b5d:	8e c0                	mov    %eax,%es
  call inthandler21
  280b5f:	e8 92 ff ff ff       	call   280af6 <inthandler21>
  popl %eax
  280b64:	58                   	pop    %eax
  popal
  280b65:	61                   	popa   
  popw %ds
  280b66:	66 1f                	popw   %ds
  popW %es
  280b68:	66 07                	popw   %es
  iret
  280b6a:	cf                   	iret   

00280b6b <asm_inthandler27>:

asm_inthandler27:
  pushw %es
  280b6b:	66 06                	pushw  %es
  pushw %ds
  280b6d:	66 1e                	pushw  %ds
  pushal
  280b6f:	60                   	pusha  
  movl %esp,%eax
  280b70:	89 e0                	mov    %esp,%eax
  pushl %eax
  280b72:	50                   	push   %eax
  movw %ss,%ax
  280b73:	66 8c d0             	mov    %ss,%ax
  movw %ax,%ds
  280b76:	8e d8                	mov    %eax,%ds
  movw %ax,%es
  280b78:	8e c0                	mov    %eax,%es
  call inthandler27
  280b7a:	e8 c4 ff ff ff       	call   280b43 <inthandler27>
  popl %eax
  280b7f:	58                   	pop    %eax
  popal
  280b80:	61                   	popa   
  popw %ds
  280b81:	66 1f                	popw   %ds
  popW %es
  280b83:	66 07                	popw   %es
  iret
  280b85:	cf                   	iret   

00280b86 <asm_inthandler2c>:

asm_inthandler2c:
  pushw %es
  280b86:	66 06                	pushw  %es
  pushw %ds
  280b88:	66 1e                	pushw  %ds
  pushal
  280b8a:	60                   	pusha  
  movl %esp,%eax
  280b8b:	89 e0                	mov    %esp,%eax
  pushl %eax
  280b8d:	50                   	push   %eax
  movw %ss,%ax
  280b8e:	66 8c d0             	mov    %ss,%ax
  movw %ax,%ds
  280b91:	8e d8                	mov    %eax,%ds
  movw %ax,%es
  280b93:	8e c0                	mov    %eax,%es
  call inthandler2c
  280b95:	e8 80 ff ff ff       	call   280b1a <inthandler2c>
  popl %eax
  280b9a:	58                   	pop    %eax
  popal
  280b9b:	61                   	popa   
  popw %ds
  280b9c:	66 1f                	popw   %ds
  popW %es
  280b9e:	66 07                	popw   %es
  iret
  280ba0:	cf                   	iret   

00280ba1 <load_gdtr>:

load_gdtr:		#; void load_gdtr(int limit, int addr);
  mov 4(%esp) ,%ax
  280ba1:	66 8b 44 24 04       	mov    0x4(%esp),%ax
  mov %ax,6(%esp)
  280ba6:	66 89 44 24 06       	mov    %ax,0x6(%esp)
  lgdt 6(%esp)
  280bab:	0f 01 54 24 06       	lgdtl  0x6(%esp)
  ret
  280bb0:	c3                   	ret    

00280bb1 <load_idtr>:

load_idtr:		#; void load_idtr(int limit, int addr);
  mov 4(%esp) ,%ax
  280bb1:	66 8b 44 24 04       	mov    0x4(%esp),%ax
  mov %ax,6(%esp)
  280bb6:	66 89 44 24 06       	mov    %ax,0x6(%esp)
  lidt 6(%esp)
  280bbb:	0f 01 5c 24 06       	lidtl  0x6(%esp)
  ret
  280bc0:	c3                   	ret    

00280bc1 <io_stihlt>:

io_stihlt:
  sti
  280bc1:	fb                   	sti    
  hlt
  280bc2:	f4                   	hlt    
  ret
  280bc3:	c3                   	ret    

00280bc4 <fifo8_init>:
#include "header.h"

#define FLAGS_OVERRUN		0x0001

void fifo8_init(struct FIFO8 *fifo, int size, unsigned char *buf)
{
  280bc4:	55                   	push   %ebp
  280bc5:	89 e5                	mov    %esp,%ebp
  280bc7:	8b 45 08             	mov    0x8(%ebp),%eax
  280bca:	8b 55 0c             	mov    0xc(%ebp),%edx
	fifo->size = size;
	fifo->buf = buf;
  280bcd:	8b 4d 10             	mov    0x10(%ebp),%ecx
	fifo->free = size; 
	fifo->flags = 0;
  280bd0:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

#define FLAGS_OVERRUN		0x0001

void fifo8_init(struct FIFO8 *fifo, int size, unsigned char *buf)
{
	fifo->size = size;
  280bd7:	89 50 0c             	mov    %edx,0xc(%eax)
	fifo->buf = buf;
  280bda:	89 08                	mov    %ecx,(%eax)
	fifo->free = size; 
  280bdc:	89 50 10             	mov    %edx,0x10(%eax)
	fifo->flags = 0;
	fifo->p = 0; /* next write */
  280bdf:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	fifo->q = 0; /* next read */
  280be6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	return;
}
  280bed:	5d                   	pop    %ebp
  280bee:	c3                   	ret    

00280bef <fifo8_put>:

int fifo8_put(struct FIFO8 *fifo, unsigned char data)
{
  280bef:	55                   	push   %ebp
  280bf0:	89 e5                	mov    %esp,%ebp
  280bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  280bf5:	53                   	push   %ebx
  280bf6:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	if (fifo->free == 0) {
  280bf9:	83 78 10 00          	cmpl   $0x0,0x10(%eax)
  280bfd:	75 09                	jne    280c08 <fifo8_put+0x19>
		/* no free space */
		fifo->flags |= FLAGS_OVERRUN;
  280bff:	83 48 14 01          	orl    $0x1,0x14(%eax)
		return -1;
  280c03:	83 c8 ff             	or     $0xffffffff,%eax
  280c06:	eb 22                	jmp    280c2a <fifo8_put+0x3b>
	}
	fifo->buf[fifo->p] = data;
  280c08:	8b 50 04             	mov    0x4(%eax),%edx
  280c0b:	8b 08                	mov    (%eax),%ecx
  280c0d:	88 1c 11             	mov    %bl,(%ecx,%edx,1)
	fifo->p++;
  280c10:	8b 48 04             	mov    0x4(%eax),%ecx
  280c13:	8d 51 01             	lea    0x1(%ecx),%edx
	if (fifo->p == fifo->size) {
  280c16:	3b 50 0c             	cmp    0xc(%eax),%edx
		/* no free space */
		fifo->flags |= FLAGS_OVERRUN;
		return -1;
	}
	fifo->buf[fifo->p] = data;
	fifo->p++;
  280c19:	89 50 04             	mov    %edx,0x4(%eax)
	if (fifo->p == fifo->size) {
  280c1c:	75 07                	jne    280c25 <fifo8_put+0x36>
		fifo->p = 0;
  280c1e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	}
	fifo->free--;
  280c25:	ff 48 10             	decl   0x10(%eax)
	return 0;
  280c28:	31 c0                	xor    %eax,%eax
}
  280c2a:	5b                   	pop    %ebx
  280c2b:	5d                   	pop    %ebp
  280c2c:	c3                   	ret    

00280c2d <fifo8_get>:

int fifo8_get(struct FIFO8 *fifo)
{
  280c2d:	55                   	push   %ebp
  280c2e:	89 e5                	mov    %esp,%ebp
  280c30:	8b 55 08             	mov    0x8(%ebp),%edx
  280c33:	57                   	push   %edi
  280c34:	56                   	push   %esi
  280c35:	53                   	push   %ebx
	int data;
	if (fifo->free == fifo->size) {
  280c36:	8b 5a 10             	mov    0x10(%edx),%ebx
  280c39:	8b 7a 0c             	mov    0xc(%edx),%edi
  280c3c:	39 fb                	cmp    %edi,%ebx
  280c3e:	74 1a                	je     280c5a <fifo8_get+0x2d>
		/* if buffer empty, return -1 */
		return -1;
	}
	data = fifo->buf[fifo->q];
  280c40:	8b 72 08             	mov    0x8(%edx),%esi
	fifo->q++;
  280c43:	31 c9                	xor    %ecx,%ecx
	int data;
	if (fifo->free == fifo->size) {
		/* if buffer empty, return -1 */
		return -1;
	}
	data = fifo->buf[fifo->q];
  280c45:	8b 02                	mov    (%edx),%eax
  280c47:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
	fifo->q++;
  280c4b:	46                   	inc    %esi
  280c4c:	39 fe                	cmp    %edi,%esi
  280c4e:	0f 45 ce             	cmovne %esi,%ecx
	if (fifo->q == fifo->size) {
		fifo->q = 0;
	}
	fifo->free++;
  280c51:	43                   	inc    %ebx
	if (fifo->free == fifo->size) {
		/* if buffer empty, return -1 */
		return -1;
	}
	data = fifo->buf[fifo->q];
	fifo->q++;
  280c52:	89 4a 08             	mov    %ecx,0x8(%edx)
	if (fifo->q == fifo->size) {
		fifo->q = 0;
	}
	fifo->free++;
  280c55:	89 5a 10             	mov    %ebx,0x10(%edx)
	return data;
  280c58:	eb 03                	jmp    280c5d <fifo8_get+0x30>
int fifo8_get(struct FIFO8 *fifo)
{
	int data;
	if (fifo->free == fifo->size) {
		/* if buffer empty, return -1 */
		return -1;
  280c5a:	83 c8 ff             	or     $0xffffffff,%eax
	if (fifo->q == fifo->size) {
		fifo->q = 0;
	}
	fifo->free++;
	return data;
}
  280c5d:	5b                   	pop    %ebx
  280c5e:	5e                   	pop    %esi
  280c5f:	5f                   	pop    %edi
  280c60:	5d                   	pop    %ebp
  280c61:	c3                   	ret    

00280c62 <fifo8_status>:

int fifo8_status(struct FIFO8 *fifo)
/* return how much data in buffer */
{
  280c62:	55                   	push   %ebp
  280c63:	89 e5                	mov    %esp,%ebp
  280c65:	8b 55 08             	mov    0x8(%ebp),%edx
	return fifo->size - fifo->free;
}
  280c68:	5d                   	pop    %ebp
}

int fifo8_status(struct FIFO8 *fifo)
/* return how much data in buffer */
{
	return fifo->size - fifo->free;
  280c69:	8b 42 0c             	mov    0xc(%edx),%eax
  280c6c:	2b 42 10             	sub    0x10(%edx),%eax
}
  280c6f:	c3                   	ret    

00280c70 <enable_mouse>:
#define KEYCMD_SENDTO_MOUSE		0xd4
#define MOUSECMD_ENABLE			0xf4
unsigned char mousepic[256];     //mouse logo buffer

void enable_mouse(struct boot_info *bootp)
{
  280c70:	55                   	push   %ebp
  280c71:	89 e5                	mov    %esp,%ebp
  280c73:	53                   	push   %ebx
  280c74:	83 ec 0c             	sub    $0xc,%esp
  280c77:	8b 5d 08             	mov    0x8(%ebp),%ebx
	/* 儅僂僗桳岠 */
	init_mouse(mousepic,0);//7　means background color:white
  280c7a:	6a 00                	push   $0x0
  280c7c:	68 68 2f 28 00       	push   $0x282f68
  280c81:	e8 92 f8 ff ff       	call   280518 <init_mouse>
	wait_KBC_sendready();
  280c86:	e8 55 01 00 00       	call   280de0 <wait_KBC_sendready>
  280c8b:	ba 64 00 00 00       	mov    $0x64,%edx
  280c90:	b0 d4                	mov    $0xd4,%al
  280c92:	ee                   	out    %al,(%dx)
	io_out8(PORT_KEYCMD, KEYCMD_SENDTO_MOUSE);
	wait_KBC_sendready();
  280c93:	e8 48 01 00 00       	call   280de0 <wait_KBC_sendready>
  280c98:	ba 60 00 00 00       	mov    $0x60,%edx
  280c9d:	b0 f4                	mov    $0xf4,%al
  280c9f:	ee                   	out    %al,(%dx)
	io_out8(PORT_KEYDAT, MOUSECMD_ENABLE);
	glob.phase=-1;
	glob.x=60;
	glob.y=60;
	display_mouse(bootp->vram,bootp->xsize,16,16,60,60,mousepic,16);
  280ca0:	6a 10                	push   $0x10
  280ca2:	68 68 2f 28 00       	push   $0x282f68
  280ca7:	6a 3c                	push   $0x3c
  280ca9:	6a 3c                	push   $0x3c
  280cab:	6a 10                	push   $0x10
  280cad:	6a 10                	push   $0x10
  280caf:	0f bf 43 04          	movswl 0x4(%ebx),%eax
	init_mouse(mousepic,0);//7　means background color:white
	wait_KBC_sendready();
	io_out8(PORT_KEYCMD, KEYCMD_SENDTO_MOUSE);
	wait_KBC_sendready();
	io_out8(PORT_KEYDAT, MOUSECMD_ENABLE);
	glob.phase=-1;
  280cb3:	c6 05 5b 2f 28 00 ff 	movb   $0xff,0x282f5b
	glob.x=60;
  280cba:	c7 05 5c 2f 28 00 3c 	movl   $0x3c,0x282f5c
  280cc1:	00 00 00 
	glob.y=60;
	display_mouse(bootp->vram,bootp->xsize,16,16,60,60,mousepic,16);
  280cc4:	50                   	push   %eax
  280cc5:	ff 73 08             	pushl  0x8(%ebx)
	io_out8(PORT_KEYCMD, KEYCMD_SENDTO_MOUSE);
	wait_KBC_sendready();
	io_out8(PORT_KEYDAT, MOUSECMD_ENABLE);
	glob.phase=-1;
	glob.x=60;
	glob.y=60;
  280cc8:	c7 05 60 2f 28 00 3c 	movl   $0x3c,0x282f60
  280ccf:	00 00 00 
	display_mouse(bootp->vram,bootp->xsize,16,16,60,60,mousepic,16);
  280cd2:	e8 91 f8 ff ff       	call   280568 <display_mouse>
  280cd7:	83 c4 30             	add    $0x30,%esp
	return; /* 偆傑偔偄偔偲ACK(0xfa)偑憲怣偝傟偰偔傞 */
}
  280cda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  280cdd:	c9                   	leave  
  280cde:	c3                   	ret    

00280cdf <mouse_move>:

void mouse_move(struct boot_info *bootp){
	boxfill8(bootp->vram,bootp->xsize,COL8_000000, glob.x,glob.y,glob.x+15,glob.y+15);//bg is black
  280cdf:	8b 15 60 2f 28 00    	mov    0x282f60,%edx
	glob.y=60;
	display_mouse(bootp->vram,bootp->xsize,16,16,60,60,mousepic,16);
	return; /* 偆傑偔偄偔偲ACK(0xfa)偑憲怣偝傟偰偔傞 */
}

void mouse_move(struct boot_info *bootp){
  280ce5:	55                   	push   %ebp
	boxfill8(bootp->vram,bootp->xsize,COL8_000000, glob.x,glob.y,glob.x+15,glob.y+15);//bg is black
  280ce6:	a1 5c 2f 28 00       	mov    0x282f5c,%eax
	glob.y=60;
	display_mouse(bootp->vram,bootp->xsize,16,16,60,60,mousepic,16);
	return; /* 偆傑偔偄偔偲ACK(0xfa)偑憲怣偝傟偰偔傞 */
}

void mouse_move(struct boot_info *bootp){
  280ceb:	89 e5                	mov    %esp,%ebp
  280ced:	56                   	push   %esi
  280cee:	53                   	push   %ebx
  280cef:	8b 5d 08             	mov    0x8(%ebp),%ebx
	boxfill8(bootp->vram,bootp->xsize,COL8_000000, glob.x,glob.y,glob.x+15,glob.y+15);//bg is black
  280cf2:	51                   	push   %ecx
  280cf3:	8d 4a 0f             	lea    0xf(%edx),%ecx
  280cf6:	51                   	push   %ecx
  280cf7:	8d 48 0f             	lea    0xf(%eax),%ecx
  280cfa:	51                   	push   %ecx
  280cfb:	52                   	push   %edx
  280cfc:	50                   	push   %eax
  280cfd:	6a 00                	push   $0x0
  280cff:	0f bf 43 04          	movswl 0x4(%ebx),%eax
  280d03:	50                   	push   %eax
  280d04:	ff 73 08             	pushl  0x8(%ebx)
  280d07:	e8 35 f6 ff ff       	call   280341 <boxfill8>
  280d0c:	0f b6 15 59 2f 28 00 	movzbl 0x282f59,%edx
	int i = glob.buf[1];
	if ((glob.buf[0] & 0x10) != 0 ) i |= 0xffffff00;
  280d13:	83 c4 20             	add    $0x20,%esp
  280d16:	a0 58 2f 28 00       	mov    0x282f58,%al
	return; /* 偆傑偔偄偔偲ACK(0xfa)偑憲怣偝傟偰偔傞 */
}

void mouse_move(struct boot_info *bootp){
	boxfill8(bootp->vram,bootp->xsize,COL8_000000, glob.x,glob.y,glob.x+15,glob.y+15);//bg is black
	int i = glob.buf[1];
  280d1b:	89 d1                	mov    %edx,%ecx
  280d1d:	81 c9 00 ff ff ff    	or     $0xffffff00,%ecx
  280d23:	a8 10                	test   $0x10,%al
  280d25:	0f 45 d1             	cmovne %ecx,%edx
  280d28:	0f b6 0d 5a 2f 28 00 	movzbl 0x282f5a,%ecx
	if ((glob.buf[0] & 0x10) != 0 ) i |= 0xffffff00;
	glob.x += i;
  280d2f:	03 15 5c 2f 28 00    	add    0x282f5c,%edx
	i = glob.buf[2];
  280d35:	89 ce                	mov    %ecx,%esi
  280d37:	81 ce 00 ff ff ff    	or     $0xffffff00,%esi
  280d3d:	a8 20                	test   $0x20,%al
	if ((glob.buf[0] & 0x20) != 0 ) i |= 0xffffff00;
	glob.y -= i;
  280d3f:	a1 60 2f 28 00       	mov    0x282f60,%eax
void mouse_move(struct boot_info *bootp){
	boxfill8(bootp->vram,bootp->xsize,COL8_000000, glob.x,glob.y,glob.x+15,glob.y+15);//bg is black
	int i = glob.buf[1];
	if ((glob.buf[0] & 0x10) != 0 ) i |= 0xffffff00;
	glob.x += i;
	i = glob.buf[2];
  280d44:	0f 45 ce             	cmovne %esi,%ecx

void mouse_move(struct boot_info *bootp){
	boxfill8(bootp->vram,bootp->xsize,COL8_000000, glob.x,glob.y,glob.x+15,glob.y+15);//bg is black
	int i = glob.buf[1];
	if ((glob.buf[0] & 0x10) != 0 ) i |= 0xffffff00;
	glob.x += i;
  280d47:	89 15 5c 2f 28 00    	mov    %edx,0x282f5c
	i = glob.buf[2];
	if ((glob.buf[0] & 0x20) != 0 ) i |= 0xffffff00;
	glob.y -= i;
  280d4d:	29 c8                	sub    %ecx,%eax
	if (glob.x<0) glob.x=0;
  280d4f:	85 d2                	test   %edx,%edx
	int i = glob.buf[1];
	if ((glob.buf[0] & 0x10) != 0 ) i |= 0xffffff00;
	glob.x += i;
	i = glob.buf[2];
	if ((glob.buf[0] & 0x20) != 0 ) i |= 0xffffff00;
	glob.y -= i;
  280d51:	a3 60 2f 28 00       	mov    %eax,0x282f60
	if (glob.x<0) glob.x=0;
  280d56:	79 0a                	jns    280d62 <mouse_move+0x83>
  280d58:	c7 05 5c 2f 28 00 00 	movl   $0x0,0x282f5c
  280d5f:	00 00 00 
	if (glob.y<0) glob.y=0;
  280d62:	85 c0                	test   %eax,%eax
  280d64:	79 0a                	jns    280d70 <mouse_move+0x91>
  280d66:	c7 05 60 2f 28 00 00 	movl   $0x0,0x282f60
  280d6d:	00 00 00 
	if (glob.x>bootp->xsize-16) glob.x=bootp->xsize-16;
  280d70:	0f bf 43 04          	movswl 0x4(%ebx),%eax
  280d74:	8d 50 f1             	lea    -0xf(%eax),%edx
  280d77:	3b 15 5c 2f 28 00    	cmp    0x282f5c,%edx
  280d7d:	7f 09                	jg     280d88 <mouse_move+0xa9>
  280d7f:	8d 50 f0             	lea    -0x10(%eax),%edx
  280d82:	89 15 5c 2f 28 00    	mov    %edx,0x282f5c
	if (glob.y>bootp->ysize-16) glob.y=bootp->ysize-16;
  280d88:	0f bf 53 06          	movswl 0x6(%ebx),%edx
  280d8c:	8d 4a f1             	lea    -0xf(%edx),%ecx
  280d8f:	3b 0d 60 2f 28 00    	cmp    0x282f60,%ecx
  280d95:	7f 09                	jg     280da0 <mouse_move+0xc1>
  280d97:	83 ea 10             	sub    $0x10,%edx
  280d9a:	89 15 60 2f 28 00    	mov    %edx,0x282f60
	display_mouse(bootp->vram,bootp->xsize,16,16,glob.x,glob.y,mousepic,16);
  280da0:	6a 10                	push   $0x10
  280da2:	68 68 2f 28 00       	push   $0x282f68
  280da7:	ff 35 60 2f 28 00    	pushl  0x282f60
  280dad:	ff 35 5c 2f 28 00    	pushl  0x282f5c
  280db3:	6a 10                	push   $0x10
  280db5:	6a 10                	push   $0x10
  280db7:	50                   	push   %eax
  280db8:	ff 73 08             	pushl  0x8(%ebx)
  280dbb:	e8 a8 f7 ff ff       	call   280568 <display_mouse>
	glob.buf[0]=glob.buf[1]=glob.buf[2]=0;
  280dc0:	83 c4 20             	add    $0x20,%esp
  280dc3:	c6 05 5a 2f 28 00 00 	movb   $0x0,0x282f5a
  280dca:	c6 05 59 2f 28 00 00 	movb   $0x0,0x282f59
  280dd1:	c6 05 58 2f 28 00 00 	movb   $0x0,0x282f58
}
  280dd8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  280ddb:	5b                   	pop    %ebx
  280ddc:	5e                   	pop    %esi
  280ddd:	5d                   	pop    %ebp
  280dde:	c3                   	ret    
  280ddf:	90                   	nop

00280de0 <wait_KBC_sendready>:
#define KEYCMD_WRITE_MODE		0x60
#define KBC_MODE				0x47


void wait_KBC_sendready(void)
{
  280de0:	55                   	push   %ebp
static __inline uint8_t
inb(int port)
{
  //read a byte from port
	uint8_t data;
	__asm __volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  280de1:	ba 64 00 00 00       	mov    $0x64,%edx
  280de6:	89 e5                	mov    %esp,%ebp
  280de8:	ec                   	in     (%dx),%al
	/* 僉乕儃乕僪僐儞僩儘乕儔偑僨乕僞憲怣壜擻偵側傞偺傪懸偮 */
	for (;;) {
		if ((io_in8(PORT_KEYSTA) & KEYSTA_SEND_NOTREADY) == 0) {
  280de9:	a8 02                	test   $0x2,%al
  280deb:	75 fb                	jne    280de8 <wait_KBC_sendready+0x8>
			break;
		}
	}
	return;
}
  280ded:	5d                   	pop    %ebp
  280dee:	c3                   	ret    

00280def <init_keyboard>:

void init_keyboard(void)
{
  280def:	55                   	push   %ebp
  280df0:	89 e5                	mov    %esp,%ebp
	/* 僉乕儃乕僪僐儞僩儘乕儔偺弶婜壔 */
	wait_KBC_sendready();
  280df2:	e8 e9 ff ff ff       	call   280de0 <wait_KBC_sendready>
// out:write a data to a port
static __inline void
outb(int port, uint8_t data)
{
  //data是变量0%0 , port是变量word１%w1
	__asm __volatile("outb %0,%w1" : : "a" (data), "d" (port));
  280df7:	ba 64 00 00 00       	mov    $0x64,%edx
  280dfc:	b0 60                	mov    $0x60,%al
  280dfe:	ee                   	out    %al,(%dx)
	io_out8(PORT_KEYCMD, KEYCMD_WRITE_MODE);
	wait_KBC_sendready();
  280dff:	e8 dc ff ff ff       	call   280de0 <wait_KBC_sendready>
  280e04:	ba 60 00 00 00       	mov    $0x60,%edx
  280e09:	b0 47                	mov    $0x47,%al
  280e0b:	ee                   	out    %al,(%dx)
	io_out8(PORT_KEYDAT, KBC_MODE);
	return;
}
  280e0c:	5d                   	pop    %ebp
  280e0d:	c3                   	ret    
  280e0e:	66 90                	xchg   %ax,%ax

00280e10 <memtest_sub>:
#include <header.h>
#define EFLAGS_AC_BIT		0x00040000
#define CR0_CACHE_DISABLE	0x60000000

unsigned int hehe,heihei;
unsigned int memtest_sub(unsigned int start, unsigned int end){
  280e10:	55                   	push   %ebp
  280e11:	89 e5                	mov    %esp,%ebp
  280e13:	8b 45 08             	mov    0x8(%ebp),%eax
	unsigned int i,*p,old,pat0 = 0xaa55aa55,pat1 = 0x55aa55aa;
	for (i = start;i<=end; i+=4){
  280e16:	3b 45 0c             	cmp    0xc(%ebp),%eax
  280e19:	77 21                	ja     280e3c <memtest_sub+0x2c>
		p = (unsigned int *) i;
		old = *p;
  280e1b:	8b 10                	mov    (%eax),%edx
		*p = pat0;
		*p ^= 0xffffffff;
  280e1d:	c7 00 aa 55 aa 55    	movl   $0x55aa55aa,(%eax)
		hehe = *p;
  280e23:	c7 05 6c 30 28 00 aa 	movl   $0x55aa55aa,0x28306c
  280e2a:	55 aa 55 
		if (*p != pat1){
  280e2d:	81 38 aa 55 aa 55    	cmpl   $0x55aa55aa,(%eax)
			*p = old;
  280e33:	89 10                	mov    %edx,(%eax)
		p = (unsigned int *) i;
		old = *p;
		*p = pat0;
		*p ^= 0xffffffff;
		hehe = *p;
		if (*p != pat1){
  280e35:	75 07                	jne    280e3e <memtest_sub+0x2e>
#define CR0_CACHE_DISABLE	0x60000000

unsigned int hehe,heihei;
unsigned int memtest_sub(unsigned int start, unsigned int end){
	unsigned int i,*p,old,pat0 = 0xaa55aa55,pat1 = 0x55aa55aa;
	for (i = start;i<=end; i+=4){
  280e37:	83 c0 04             	add    $0x4,%eax
  280e3a:	eb da                	jmp    280e16 <memtest_sub+0x6>
			*p = old;
			return i;
		}
		*p = old;
	}
	return 0;
  280e3c:	31 c0                	xor    %eax,%eax
}
  280e3e:	5d                   	pop    %ebp
  280e3f:	c3                   	ret    

00280e40 <memtest>:

unsigned int memtest(unsigned int start,unsigned int end){
  280e40:	55                   	push   %ebp
  280e41:	89 e5                	mov    %esp,%ebp
  280e43:	56                   	push   %esi
  280e44:	8b 75 0c             	mov    0xc(%ebp),%esi
  280e47:	53                   	push   %ebx
//read eflags and write_eflags
static __inline uint32_t
read_eflags(void)
{
        uint32_t eflags;
        __asm __volatile("pushfl; popl %0" : "=r" (eflags));
  280e48:	9c                   	pushf  
  280e49:	58                   	pop    %eax
	char flg486 = 0;
	unsigned int eflg,cr0,i;
	eflg = read_eflags();
	eflg |= EFLAGS_AC_BIT;
  280e4a:	0d 00 00 04 00       	or     $0x40000,%eax
}

static __inline void
write_eflags(uint32_t eflags)
{
        __asm __volatile("pushl %0; popfl" : : "r" (eflags));
  280e4f:	50                   	push   %eax
  280e50:	9d                   	popf   
//read eflags and write_eflags
static __inline uint32_t
read_eflags(void)
{
        uint32_t eflags;
        __asm __volatile("pushfl; popl %0" : "=r" (eflags));
  280e51:	9c                   	pushf  
  280e52:	58                   	pop    %eax
	write_eflags(eflg);
	eflg = read_eflags();
	if ((eflg & EFLAGS_AC_BIT) != 0){
  280e53:	89 c1                	mov    %eax,%ecx
		flg486 = 1;
	}
	eflg &= ~EFLAGS_AC_BIT;
  280e55:	25 ff ff fb ff       	and    $0xfffbffff,%eax
	unsigned int eflg,cr0,i;
	eflg = read_eflags();
	eflg |= EFLAGS_AC_BIT;
	write_eflags(eflg);
	eflg = read_eflags();
	if ((eflg & EFLAGS_AC_BIT) != 0){
  280e5a:	c1 e9 12             	shr    $0x12,%ecx
  280e5d:	88 cb                	mov    %cl,%bl
  280e5f:	83 e3 01             	and    $0x1,%ebx
}

static __inline void
write_eflags(uint32_t eflags)
{
        __asm __volatile("pushl %0; popfl" : : "r" (eflags));
  280e62:	50                   	push   %eax
  280e63:	9d                   	popf   
		flg486 = 1;
	}
	eflg &= ~EFLAGS_AC_BIT;
	write_eflags(eflg);
	if (flg486 != 0){
  280e64:	84 db                	test   %bl,%bl
  280e66:	74 0c                	je     280e74 <memtest+0x34>

static __inline uint32_t
rcr0(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr0,%0" : "=r" (val));
  280e68:	0f 20 c2             	mov    %cr0,%edx
		cr0 = rcr0();
		cr0 |= CR0_CACHE_DISABLE;
  280e6b:	81 ca 00 00 00 60    	or     $0x60000000,%edx
}

static __inline void
lcr0(uint32_t val)
{
	__asm __volatile("movl %0,%%cr0" : : "r" (val));
  280e71:	0f 22 c2             	mov    %edx,%cr0
		lcr0(cr0);
	}

	unsigned int ret = memtest_sub(start,end);
  280e74:	56                   	push   %esi
  280e75:	ff 75 08             	pushl  0x8(%ebp)
  280e78:	e8 93 ff ff ff       	call   280e10 <memtest_sub>
	
	if (flg486 != 0){
  280e7d:	84 db                	test   %bl,%bl
  280e7f:	5a                   	pop    %edx
  280e80:	59                   	pop    %ecx
  280e81:	74 0c                	je     280e8f <memtest+0x4f>

static __inline uint32_t
rcr0(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr0,%0" : "=r" (val));
  280e83:	0f 20 c2             	mov    %cr0,%edx
		cr0 = rcr0();
		cr0 &= ~CR0_CACHE_DISABLE;
  280e86:	81 e2 ff ff ff 9f    	and    $0x9fffffff,%edx
}

static __inline void
lcr0(uint32_t val)
{
	__asm __volatile("movl %0,%%cr0" : : "r" (val));
  280e8c:	0f 22 c2             	mov    %edx,%cr0
		lcr0(cr0);
	}
	if (ret==0) return end;
	else return ret -4;
  280e8f:	85 c0                	test   %eax,%eax
  280e91:	8d 50 fc             	lea    -0x4(%eax),%edx
  280e94:	89 f0                	mov    %esi,%eax
  280e96:	0f 45 c2             	cmovne %edx,%eax
}
  280e99:	8d 65 f8             	lea    -0x8(%ebp),%esp
  280e9c:	5b                   	pop    %ebx
  280e9d:	5e                   	pop    %esi
  280e9e:	5d                   	pop    %ebp
  280e9f:	c3                   	ret    

Disassembly of section .rodata:

00280ea0 <Font8x16>:
	...
  2810b0:	00 00                	add    %al,(%eax)
  2810b2:	00 10                	add    %dl,(%eax)
  2810b4:	10 10                	adc    %dl,(%eax)
  2810b6:	10 10                	adc    %dl,(%eax)
  2810b8:	10 00                	adc    %al,(%eax)
  2810ba:	10 10                	adc    %dl,(%eax)
  2810bc:	00 00                	add    %al,(%eax)
  2810be:	00 00                	add    %al,(%eax)
  2810c0:	00 00                	add    %al,(%eax)
  2810c2:	00 24 24             	add    %ah,(%esp)
  2810c5:	24 00                	and    $0x0,%al
	...
  2810d3:	24 24                	and    $0x24,%al
  2810d5:	7e 24                	jle    2810fb <Font8x16+0x25b>
  2810d7:	24 24                	and    $0x24,%al
  2810d9:	7e 24                	jle    2810ff <Font8x16+0x25f>
  2810db:	24 00                	and    $0x0,%al
  2810dd:	00 00                	add    %al,(%eax)
  2810df:	00 00                	add    %al,(%eax)
  2810e1:	00 00                	add    %al,(%eax)
  2810e3:	10 7c 90 90          	adc    %bh,-0x70(%eax,%edx,4)
  2810e7:	7c 12                	jl     2810fb <Font8x16+0x25b>
  2810e9:	12 7c 10 00          	adc    0x0(%eax,%edx,1),%bh
  2810ed:	00 00                	add    %al,(%eax)
  2810ef:	00 00                	add    %al,(%eax)
  2810f1:	00 00                	add    %al,(%eax)
  2810f3:	00 62 64             	add    %ah,0x64(%edx)
  2810f6:	08 10                	or     %dl,(%eax)
  2810f8:	20 4c 8c 00          	and    %cl,0x0(%esp,%ecx,4)
	...
  281104:	18 24 20             	sbb    %ah,(%eax,%eiz,1)
  281107:	50                   	push   %eax
  281108:	8a 84 4a 30 00 00 00 	mov    0x30(%edx,%ecx,2),%al
  28110f:	00 00                	add    %al,(%eax)
  281111:	00 00                	add    %al,(%eax)
  281113:	10 10                	adc    %dl,(%eax)
  281115:	20 00                	and    %al,(%eax)
	...
  28111f:	00 00                	add    %al,(%eax)
  281121:	00 08                	add    %cl,(%eax)
  281123:	10 20                	adc    %ah,(%eax)
  281125:	20 20                	and    %ah,(%eax)
  281127:	20 20                	and    %ah,(%eax)
  281129:	20 20                	and    %ah,(%eax)
  28112b:	10 08                	adc    %cl,(%eax)
  28112d:	00 00                	add    %al,(%eax)
  28112f:	00 00                	add    %al,(%eax)
  281131:	00 20                	add    %ah,(%eax)
  281133:	10 08                	adc    %cl,(%eax)
  281135:	08 08                	or     %cl,(%eax)
  281137:	08 08                	or     %cl,(%eax)
  281139:	08 08                	or     %cl,(%eax)
  28113b:	10 20                	adc    %ah,(%eax)
	...
  281145:	10 54 38 38          	adc    %dl,0x38(%eax,%edi,1)
  281149:	54                   	push   %esp
  28114a:	10 00                	adc    %al,(%eax)
	...
  281154:	00 10                	add    %dl,(%eax)
  281156:	10 7c 10 10          	adc    %bh,0x10(%eax,%edx,1)
	...
  28116a:	10 10                	adc    %dl,(%eax)
  28116c:	20 00                	and    %al,(%eax)
	...
  281176:	00 7c 00 00          	add    %bh,0x0(%eax,%eax,1)
	...
  28118a:	00 10                	add    %dl,(%eax)
	...
  281194:	00 02                	add    %al,(%edx)
  281196:	04 08                	add    $0x8,%al
  281198:	10 20                	adc    %ah,(%eax)
  28119a:	40                   	inc    %eax
	...
  2811a3:	38 44 44 4c          	cmp    %al,0x4c(%esp,%eax,2)
  2811a7:	54                   	push   %esp
  2811a8:	64                   	fs
  2811a9:	44                   	inc    %esp
  2811aa:	44                   	inc    %esp
  2811ab:	38 00                	cmp    %al,(%eax)
  2811ad:	00 00                	add    %al,(%eax)
  2811af:	00 00                	add    %al,(%eax)
  2811b1:	00 00                	add    %al,(%eax)
  2811b3:	10 30                	adc    %dh,(%eax)
  2811b5:	10 10                	adc    %dl,(%eax)
  2811b7:	10 10                	adc    %dl,(%eax)
  2811b9:	10 10                	adc    %dl,(%eax)
  2811bb:	38 00                	cmp    %al,(%eax)
  2811bd:	00 00                	add    %al,(%eax)
  2811bf:	00 00                	add    %al,(%eax)
  2811c1:	00 00                	add    %al,(%eax)
  2811c3:	38 44 04 04          	cmp    %al,0x4(%esp,%eax,1)
  2811c7:	08 10                	or     %dl,(%eax)
  2811c9:	20 40 7c             	and    %al,0x7c(%eax)
  2811cc:	00 00                	add    %al,(%eax)
  2811ce:	00 00                	add    %al,(%eax)
  2811d0:	00 00                	add    %al,(%eax)
  2811d2:	00 7c 04 08          	add    %bh,0x8(%esp,%eax,1)
  2811d6:	10 38                	adc    %bh,(%eax)
  2811d8:	04 04                	add    $0x4,%al
  2811da:	04 78                	add    $0x78,%al
  2811dc:	00 00                	add    %al,(%eax)
  2811de:	00 00                	add    %al,(%eax)
  2811e0:	00 00                	add    %al,(%eax)
  2811e2:	00 08                	add    %cl,(%eax)
  2811e4:	18 28                	sbb    %ch,(%eax)
  2811e6:	48                   	dec    %eax
  2811e7:	48                   	dec    %eax
  2811e8:	7c 08                	jl     2811f2 <Font8x16+0x352>
  2811ea:	08 08                	or     %cl,(%eax)
  2811ec:	00 00                	add    %al,(%eax)
  2811ee:	00 00                	add    %al,(%eax)
  2811f0:	00 00                	add    %al,(%eax)
  2811f2:	00 7c 40 40          	add    %bh,0x40(%eax,%eax,2)
  2811f6:	40                   	inc    %eax
  2811f7:	78 04                	js     2811fd <Font8x16+0x35d>
  2811f9:	04 04                	add    $0x4,%al
  2811fb:	78 00                	js     2811fd <Font8x16+0x35d>
  2811fd:	00 00                	add    %al,(%eax)
  2811ff:	00 00                	add    %al,(%eax)
  281201:	00 00                	add    %al,(%eax)
  281203:	3c 40                	cmp    $0x40,%al
  281205:	40                   	inc    %eax
  281206:	40                   	inc    %eax
  281207:	78 44                	js     28124d <Font8x16+0x3ad>
  281209:	44                   	inc    %esp
  28120a:	44                   	inc    %esp
  28120b:	38 00                	cmp    %al,(%eax)
  28120d:	00 00                	add    %al,(%eax)
  28120f:	00 00                	add    %al,(%eax)
  281211:	00 00                	add    %al,(%eax)
  281213:	7c 04                	jl     281219 <Font8x16+0x379>
  281215:	04 08                	add    $0x8,%al
  281217:	10 20                	adc    %ah,(%eax)
  281219:	20 20                	and    %ah,(%eax)
  28121b:	20 00                	and    %al,(%eax)
  28121d:	00 00                	add    %al,(%eax)
  28121f:	00 00                	add    %al,(%eax)
  281221:	00 00                	add    %al,(%eax)
  281223:	38 44 44 44          	cmp    %al,0x44(%esp,%eax,2)
  281227:	38 44 44 44          	cmp    %al,0x44(%esp,%eax,2)
  28122b:	38 00                	cmp    %al,(%eax)
  28122d:	00 00                	add    %al,(%eax)
  28122f:	00 00                	add    %al,(%eax)
  281231:	00 00                	add    %al,(%eax)
  281233:	38 44 44 44          	cmp    %al,0x44(%esp,%eax,2)
  281237:	3c 04                	cmp    $0x4,%al
  281239:	04 04                	add    $0x4,%al
  28123b:	38 00                	cmp    %al,(%eax)
	...
  281245:	00 00                	add    %al,(%eax)
  281247:	10 00                	adc    %al,(%eax)
  281249:	00 10                	add    %dl,(%eax)
	...
  281257:	00 10                	add    %dl,(%eax)
  281259:	00 10                	add    %dl,(%eax)
  28125b:	10 20                	adc    %ah,(%eax)
	...
  281265:	04 08                	add    $0x8,%al
  281267:	10 20                	adc    %ah,(%eax)
  281269:	10 08                	adc    %cl,(%eax)
  28126b:	04 00                	add    $0x0,%al
	...
  281275:	00 00                	add    %al,(%eax)
  281277:	7c 00                	jl     281279 <Font8x16+0x3d9>
  281279:	7c 00                	jl     28127b <Font8x16+0x3db>
	...
  281283:	00 00                	add    %al,(%eax)
  281285:	20 10                	and    %dl,(%eax)
  281287:	08 04 08             	or     %al,(%eax,%ecx,1)
  28128a:	10 20                	adc    %ah,(%eax)
  28128c:	00 00                	add    %al,(%eax)
  28128e:	00 00                	add    %al,(%eax)
  281290:	00 00                	add    %al,(%eax)
  281292:	38 44 44 04          	cmp    %al,0x4(%esp,%eax,2)
  281296:	08 10                	or     %dl,(%eax)
  281298:	10 00                	adc    %al,(%eax)
  28129a:	10 10                	adc    %dl,(%eax)
	...
  2812a4:	00 38                	add    %bh,(%eax)
  2812a6:	44                   	inc    %esp
  2812a7:	5c                   	pop    %esp
  2812a8:	54                   	push   %esp
  2812a9:	5c                   	pop    %esp
  2812aa:	40                   	inc    %eax
  2812ab:	3c 00                	cmp    $0x0,%al
  2812ad:	00 00                	add    %al,(%eax)
  2812af:	00 00                	add    %al,(%eax)
  2812b1:	00 18                	add    %bl,(%eax)
  2812b3:	24 42                	and    $0x42,%al
  2812b5:	42                   	inc    %edx
  2812b6:	42                   	inc    %edx
  2812b7:	7e 42                	jle    2812fb <Font8x16+0x45b>
  2812b9:	42                   	inc    %edx
  2812ba:	42                   	inc    %edx
  2812bb:	42                   	inc    %edx
  2812bc:	00 00                	add    %al,(%eax)
  2812be:	00 00                	add    %al,(%eax)
  2812c0:	00 00                	add    %al,(%eax)
  2812c2:	7c 42                	jl     281306 <Font8x16+0x466>
  2812c4:	42                   	inc    %edx
  2812c5:	42                   	inc    %edx
  2812c6:	7c 42                	jl     28130a <Font8x16+0x46a>
  2812c8:	42                   	inc    %edx
  2812c9:	42                   	inc    %edx
  2812ca:	42                   	inc    %edx
  2812cb:	7c 00                	jl     2812cd <Font8x16+0x42d>
  2812cd:	00 00                	add    %al,(%eax)
  2812cf:	00 00                	add    %al,(%eax)
  2812d1:	00 3c 42             	add    %bh,(%edx,%eax,2)
  2812d4:	40                   	inc    %eax
  2812d5:	40                   	inc    %eax
  2812d6:	40                   	inc    %eax
  2812d7:	40                   	inc    %eax
  2812d8:	40                   	inc    %eax
  2812d9:	40                   	inc    %eax
  2812da:	42                   	inc    %edx
  2812db:	3c 00                	cmp    $0x0,%al
  2812dd:	00 00                	add    %al,(%eax)
  2812df:	00 00                	add    %al,(%eax)
  2812e1:	00 7c 42 42          	add    %bh,0x42(%edx,%eax,2)
  2812e5:	42                   	inc    %edx
  2812e6:	42                   	inc    %edx
  2812e7:	42                   	inc    %edx
  2812e8:	42                   	inc    %edx
  2812e9:	42                   	inc    %edx
  2812ea:	42                   	inc    %edx
  2812eb:	7c 00                	jl     2812ed <Font8x16+0x44d>
  2812ed:	00 00                	add    %al,(%eax)
  2812ef:	00 00                	add    %al,(%eax)
  2812f1:	00 7e 40             	add    %bh,0x40(%esi)
  2812f4:	40                   	inc    %eax
  2812f5:	40                   	inc    %eax
  2812f6:	78 40                	js     281338 <Font8x16+0x498>
  2812f8:	40                   	inc    %eax
  2812f9:	40                   	inc    %eax
  2812fa:	40                   	inc    %eax
  2812fb:	7e 00                	jle    2812fd <Font8x16+0x45d>
  2812fd:	00 00                	add    %al,(%eax)
  2812ff:	00 00                	add    %al,(%eax)
  281301:	00 7e 40             	add    %bh,0x40(%esi)
  281304:	40                   	inc    %eax
  281305:	40                   	inc    %eax
  281306:	78 40                	js     281348 <Font8x16+0x4a8>
  281308:	40                   	inc    %eax
  281309:	40                   	inc    %eax
  28130a:	40                   	inc    %eax
  28130b:	40                   	inc    %eax
  28130c:	00 00                	add    %al,(%eax)
  28130e:	00 00                	add    %al,(%eax)
  281310:	00 00                	add    %al,(%eax)
  281312:	3c 42                	cmp    $0x42,%al
  281314:	40                   	inc    %eax
  281315:	40                   	inc    %eax
  281316:	5e                   	pop    %esi
  281317:	42                   	inc    %edx
  281318:	42                   	inc    %edx
  281319:	42                   	inc    %edx
  28131a:	42                   	inc    %edx
  28131b:	3c 00                	cmp    $0x0,%al
  28131d:	00 00                	add    %al,(%eax)
  28131f:	00 00                	add    %al,(%eax)
  281321:	00 42 42             	add    %al,0x42(%edx)
  281324:	42                   	inc    %edx
  281325:	42                   	inc    %edx
  281326:	7e 42                	jle    28136a <Font8x16+0x4ca>
  281328:	42                   	inc    %edx
  281329:	42                   	inc    %edx
  28132a:	42                   	inc    %edx
  28132b:	42                   	inc    %edx
  28132c:	00 00                	add    %al,(%eax)
  28132e:	00 00                	add    %al,(%eax)
  281330:	00 00                	add    %al,(%eax)
  281332:	38 10                	cmp    %dl,(%eax)
  281334:	10 10                	adc    %dl,(%eax)
  281336:	10 10                	adc    %dl,(%eax)
  281338:	10 10                	adc    %dl,(%eax)
  28133a:	10 38                	adc    %bh,(%eax)
  28133c:	00 00                	add    %al,(%eax)
  28133e:	00 00                	add    %al,(%eax)
  281340:	00 00                	add    %al,(%eax)
  281342:	1c 08                	sbb    $0x8,%al
  281344:	08 08                	or     %cl,(%eax)
  281346:	08 08                	or     %cl,(%eax)
  281348:	08 08                	or     %cl,(%eax)
  28134a:	48                   	dec    %eax
  28134b:	30 00                	xor    %al,(%eax)
  28134d:	00 00                	add    %al,(%eax)
  28134f:	00 00                	add    %al,(%eax)
  281351:	00 42 44             	add    %al,0x44(%edx)
  281354:	48                   	dec    %eax
  281355:	50                   	push   %eax
  281356:	60                   	pusha  
  281357:	60                   	pusha  
  281358:	50                   	push   %eax
  281359:	48                   	dec    %eax
  28135a:	44                   	inc    %esp
  28135b:	42                   	inc    %edx
  28135c:	00 00                	add    %al,(%eax)
  28135e:	00 00                	add    %al,(%eax)
  281360:	00 00                	add    %al,(%eax)
  281362:	40                   	inc    %eax
  281363:	40                   	inc    %eax
  281364:	40                   	inc    %eax
  281365:	40                   	inc    %eax
  281366:	40                   	inc    %eax
  281367:	40                   	inc    %eax
  281368:	40                   	inc    %eax
  281369:	40                   	inc    %eax
  28136a:	40                   	inc    %eax
  28136b:	7e 00                	jle    28136d <Font8x16+0x4cd>
  28136d:	00 00                	add    %al,(%eax)
  28136f:	00 00                	add    %al,(%eax)
  281371:	00 82 82 c6 c6 aa    	add    %al,-0x5539397e(%edx)
  281377:	aa                   	stos   %al,%es:(%edi)
  281378:	92                   	xchg   %eax,%edx
  281379:	92                   	xchg   %eax,%edx
  28137a:	82                   	(bad)  
  28137b:	82                   	(bad)  
  28137c:	00 00                	add    %al,(%eax)
  28137e:	00 00                	add    %al,(%eax)
  281380:	00 00                	add    %al,(%eax)
  281382:	42                   	inc    %edx
  281383:	62 62 52             	bound  %esp,0x52(%edx)
  281386:	52                   	push   %edx
  281387:	4a                   	dec    %edx
  281388:	4a                   	dec    %edx
  281389:	46                   	inc    %esi
  28138a:	46                   	inc    %esi
  28138b:	42                   	inc    %edx
  28138c:	00 00                	add    %al,(%eax)
  28138e:	00 00                	add    %al,(%eax)
  281390:	00 00                	add    %al,(%eax)
  281392:	3c 42                	cmp    $0x42,%al
  281394:	42                   	inc    %edx
  281395:	42                   	inc    %edx
  281396:	42                   	inc    %edx
  281397:	42                   	inc    %edx
  281398:	42                   	inc    %edx
  281399:	42                   	inc    %edx
  28139a:	42                   	inc    %edx
  28139b:	3c 00                	cmp    $0x0,%al
  28139d:	00 00                	add    %al,(%eax)
  28139f:	00 00                	add    %al,(%eax)
  2813a1:	00 7c 42 42          	add    %bh,0x42(%edx,%eax,2)
  2813a5:	42                   	inc    %edx
  2813a6:	42                   	inc    %edx
  2813a7:	7c 40                	jl     2813e9 <Font8x16+0x549>
  2813a9:	40                   	inc    %eax
  2813aa:	40                   	inc    %eax
  2813ab:	40                   	inc    %eax
  2813ac:	00 00                	add    %al,(%eax)
  2813ae:	00 00                	add    %al,(%eax)
  2813b0:	00 00                	add    %al,(%eax)
  2813b2:	3c 42                	cmp    $0x42,%al
  2813b4:	42                   	inc    %edx
  2813b5:	42                   	inc    %edx
  2813b6:	42                   	inc    %edx
  2813b7:	42                   	inc    %edx
  2813b8:	42                   	inc    %edx
  2813b9:	42                   	inc    %edx
  2813ba:	4a                   	dec    %edx
  2813bb:	3c 0e                	cmp    $0xe,%al
  2813bd:	00 00                	add    %al,(%eax)
  2813bf:	00 00                	add    %al,(%eax)
  2813c1:	00 7c 42 42          	add    %bh,0x42(%edx,%eax,2)
  2813c5:	42                   	inc    %edx
  2813c6:	42                   	inc    %edx
  2813c7:	7c 50                	jl     281419 <Font8x16+0x579>
  2813c9:	48                   	dec    %eax
  2813ca:	44                   	inc    %esp
  2813cb:	42                   	inc    %edx
  2813cc:	00 00                	add    %al,(%eax)
  2813ce:	00 00                	add    %al,(%eax)
  2813d0:	00 00                	add    %al,(%eax)
  2813d2:	3c 42                	cmp    $0x42,%al
  2813d4:	40                   	inc    %eax
  2813d5:	40                   	inc    %eax
  2813d6:	3c 02                	cmp    $0x2,%al
  2813d8:	02 02                	add    (%edx),%al
  2813da:	42                   	inc    %edx
  2813db:	3c 00                	cmp    $0x0,%al
  2813dd:	00 00                	add    %al,(%eax)
  2813df:	00 00                	add    %al,(%eax)
  2813e1:	00 7c 10 10          	add    %bh,0x10(%eax,%edx,1)
  2813e5:	10 10                	adc    %dl,(%eax)
  2813e7:	10 10                	adc    %dl,(%eax)
  2813e9:	10 10                	adc    %dl,(%eax)
  2813eb:	10 00                	adc    %al,(%eax)
  2813ed:	00 00                	add    %al,(%eax)
  2813ef:	00 00                	add    %al,(%eax)
  2813f1:	00 42 42             	add    %al,0x42(%edx)
  2813f4:	42                   	inc    %edx
  2813f5:	42                   	inc    %edx
  2813f6:	42                   	inc    %edx
  2813f7:	42                   	inc    %edx
  2813f8:	42                   	inc    %edx
  2813f9:	42                   	inc    %edx
  2813fa:	42                   	inc    %edx
  2813fb:	3c 00                	cmp    $0x0,%al
  2813fd:	00 00                	add    %al,(%eax)
  2813ff:	00 00                	add    %al,(%eax)
  281401:	00 44 44 44          	add    %al,0x44(%esp,%eax,2)
  281405:	44                   	inc    %esp
  281406:	28 28                	sub    %ch,(%eax)
  281408:	28 10                	sub    %dl,(%eax)
  28140a:	10 10                	adc    %dl,(%eax)
  28140c:	00 00                	add    %al,(%eax)
  28140e:	00 00                	add    %al,(%eax)
  281410:	00 00                	add    %al,(%eax)
  281412:	82                   	(bad)  
  281413:	82                   	(bad)  
  281414:	82                   	(bad)  
  281415:	82                   	(bad)  
  281416:	54                   	push   %esp
  281417:	54                   	push   %esp
  281418:	54                   	push   %esp
  281419:	28 28                	sub    %ch,(%eax)
  28141b:	28 00                	sub    %al,(%eax)
  28141d:	00 00                	add    %al,(%eax)
  28141f:	00 00                	add    %al,(%eax)
  281421:	00 42 42             	add    %al,0x42(%edx)
  281424:	24 18                	and    $0x18,%al
  281426:	18 18                	sbb    %bl,(%eax)
  281428:	24 24                	and    $0x24,%al
  28142a:	42                   	inc    %edx
  28142b:	42                   	inc    %edx
  28142c:	00 00                	add    %al,(%eax)
  28142e:	00 00                	add    %al,(%eax)
  281430:	00 00                	add    %al,(%eax)
  281432:	44                   	inc    %esp
  281433:	44                   	inc    %esp
  281434:	44                   	inc    %esp
  281435:	44                   	inc    %esp
  281436:	28 28                	sub    %ch,(%eax)
  281438:	10 10                	adc    %dl,(%eax)
  28143a:	10 10                	adc    %dl,(%eax)
  28143c:	00 00                	add    %al,(%eax)
  28143e:	00 00                	add    %al,(%eax)
  281440:	00 00                	add    %al,(%eax)
  281442:	7e 02                	jle    281446 <Font8x16+0x5a6>
  281444:	02 04 08             	add    (%eax,%ecx,1),%al
  281447:	10 20                	adc    %ah,(%eax)
  281449:	40                   	inc    %eax
  28144a:	40                   	inc    %eax
  28144b:	7e 00                	jle    28144d <Font8x16+0x5ad>
  28144d:	00 00                	add    %al,(%eax)
  28144f:	00 00                	add    %al,(%eax)
  281451:	00 38                	add    %bh,(%eax)
  281453:	20 20                	and    %ah,(%eax)
  281455:	20 20                	and    %ah,(%eax)
  281457:	20 20                	and    %ah,(%eax)
  281459:	20 20                	and    %ah,(%eax)
  28145b:	38 00                	cmp    %al,(%eax)
	...
  281465:	00 40 20             	add    %al,0x20(%eax)
  281468:	10 08                	adc    %cl,(%eax)
  28146a:	04 02                	add    $0x2,%al
  28146c:	00 00                	add    %al,(%eax)
  28146e:	00 00                	add    %al,(%eax)
  281470:	00 00                	add    %al,(%eax)
  281472:	1c 04                	sbb    $0x4,%al
  281474:	04 04                	add    $0x4,%al
  281476:	04 04                	add    $0x4,%al
  281478:	04 04                	add    $0x4,%al
  28147a:	04 1c                	add    $0x1c,%al
	...
  281484:	10 28                	adc    %ch,(%eax)
  281486:	44                   	inc    %esp
	...
  28149b:	00 ff                	add    %bh,%bh
  28149d:	00 00                	add    %al,(%eax)
  28149f:	00 00                	add    %al,(%eax)
  2814a1:	00 00                	add    %al,(%eax)
  2814a3:	10 10                	adc    %dl,(%eax)
  2814a5:	08 00                	or     %al,(%eax)
	...
  2814b3:	00 00                	add    %al,(%eax)
  2814b5:	78 04                	js     2814bb <Font8x16+0x61b>
  2814b7:	3c 44                	cmp    $0x44,%al
  2814b9:	44                   	inc    %esp
  2814ba:	44                   	inc    %esp
  2814bb:	3a 00                	cmp    (%eax),%al
  2814bd:	00 00                	add    %al,(%eax)
  2814bf:	00 00                	add    %al,(%eax)
  2814c1:	00 40 40             	add    %al,0x40(%eax)
  2814c4:	40                   	inc    %eax
  2814c5:	5c                   	pop    %esp
  2814c6:	62 42 42             	bound  %eax,0x42(%edx)
  2814c9:	42                   	inc    %edx
  2814ca:	62 5c 00 00          	bound  %ebx,0x0(%eax,%eax,1)
  2814ce:	00 00                	add    %al,(%eax)
  2814d0:	00 00                	add    %al,(%eax)
  2814d2:	00 00                	add    %al,(%eax)
  2814d4:	00 3c 42             	add    %bh,(%edx,%eax,2)
  2814d7:	40                   	inc    %eax
  2814d8:	40                   	inc    %eax
  2814d9:	40                   	inc    %eax
  2814da:	42                   	inc    %edx
  2814db:	3c 00                	cmp    $0x0,%al
  2814dd:	00 00                	add    %al,(%eax)
  2814df:	00 00                	add    %al,(%eax)
  2814e1:	00 02                	add    %al,(%edx)
  2814e3:	02 02                	add    (%edx),%al
  2814e5:	3a 46 42             	cmp    0x42(%esi),%al
  2814e8:	42                   	inc    %edx
  2814e9:	42                   	inc    %edx
  2814ea:	46                   	inc    %esi
  2814eb:	3a 00                	cmp    (%eax),%al
	...
  2814f5:	3c 42                	cmp    $0x42,%al
  2814f7:	42                   	inc    %edx
  2814f8:	7e 40                	jle    28153a <Font8x16+0x69a>
  2814fa:	42                   	inc    %edx
  2814fb:	3c 00                	cmp    $0x0,%al
  2814fd:	00 00                	add    %al,(%eax)
  2814ff:	00 00                	add    %al,(%eax)
  281501:	00 0e                	add    %cl,(%esi)
  281503:	10 10                	adc    %dl,(%eax)
  281505:	10 3c 10             	adc    %bh,(%eax,%edx,1)
  281508:	10 10                	adc    %dl,(%eax)
  28150a:	10 10                	adc    %dl,(%eax)
	...
  281514:	00 3e                	add    %bh,(%esi)
  281516:	42                   	inc    %edx
  281517:	42                   	inc    %edx
  281518:	42                   	inc    %edx
  281519:	42                   	inc    %edx
  28151a:	3e 02 02             	add    %ds:(%edx),%al
  28151d:	3c 00                	cmp    $0x0,%al
  28151f:	00 00                	add    %al,(%eax)
  281521:	00 40 40             	add    %al,0x40(%eax)
  281524:	40                   	inc    %eax
  281525:	5c                   	pop    %esp
  281526:	62 42 42             	bound  %eax,0x42(%edx)
  281529:	42                   	inc    %edx
  28152a:	42                   	inc    %edx
  28152b:	42                   	inc    %edx
  28152c:	00 00                	add    %al,(%eax)
  28152e:	00 00                	add    %al,(%eax)
  281530:	00 00                	add    %al,(%eax)
  281532:	00 08                	add    %cl,(%eax)
  281534:	00 08                	add    %cl,(%eax)
  281536:	08 08                	or     %cl,(%eax)
  281538:	08 08                	or     %cl,(%eax)
  28153a:	08 08                	or     %cl,(%eax)
  28153c:	00 00                	add    %al,(%eax)
  28153e:	00 00                	add    %al,(%eax)
  281540:	00 00                	add    %al,(%eax)
  281542:	00 04 00             	add    %al,(%eax,%eax,1)
  281545:	04 04                	add    $0x4,%al
  281547:	04 04                	add    $0x4,%al
  281549:	04 04                	add    $0x4,%al
  28154b:	04 44                	add    $0x44,%al
  28154d:	38 00                	cmp    %al,(%eax)
  28154f:	00 00                	add    %al,(%eax)
  281551:	00 40 40             	add    %al,0x40(%eax)
  281554:	40                   	inc    %eax
  281555:	42                   	inc    %edx
  281556:	44                   	inc    %esp
  281557:	48                   	dec    %eax
  281558:	50                   	push   %eax
  281559:	68 44 42 00 00       	push   $0x4244
  28155e:	00 00                	add    %al,(%eax)
  281560:	00 00                	add    %al,(%eax)
  281562:	10 10                	adc    %dl,(%eax)
  281564:	10 10                	adc    %dl,(%eax)
  281566:	10 10                	adc    %dl,(%eax)
  281568:	10 10                	adc    %dl,(%eax)
  28156a:	10 10                	adc    %dl,(%eax)
	...
  281574:	00 ec                	add    %ch,%ah
  281576:	92                   	xchg   %eax,%edx
  281577:	92                   	xchg   %eax,%edx
  281578:	92                   	xchg   %eax,%edx
  281579:	92                   	xchg   %eax,%edx
  28157a:	92                   	xchg   %eax,%edx
  28157b:	92                   	xchg   %eax,%edx
	...
  281584:	00 7c 42 42          	add    %bh,0x42(%edx,%eax,2)
  281588:	42                   	inc    %edx
  281589:	42                   	inc    %edx
  28158a:	42                   	inc    %edx
  28158b:	42                   	inc    %edx
	...
  281594:	00 3c 42             	add    %bh,(%edx,%eax,2)
  281597:	42                   	inc    %edx
  281598:	42                   	inc    %edx
  281599:	42                   	inc    %edx
  28159a:	42                   	inc    %edx
  28159b:	3c 00                	cmp    $0x0,%al
	...
  2815a5:	5c                   	pop    %esp
  2815a6:	62 42 42             	bound  %eax,0x42(%edx)
  2815a9:	42                   	inc    %edx
  2815aa:	62 5c 40 40          	bound  %ebx,0x40(%eax,%eax,2)
  2815ae:	00 00                	add    %al,(%eax)
  2815b0:	00 00                	add    %al,(%eax)
  2815b2:	00 00                	add    %al,(%eax)
  2815b4:	00 3a                	add    %bh,(%edx)
  2815b6:	46                   	inc    %esi
  2815b7:	42                   	inc    %edx
  2815b8:	42                   	inc    %edx
  2815b9:	42                   	inc    %edx
  2815ba:	46                   	inc    %esi
  2815bb:	3a 02                	cmp    (%edx),%al
  2815bd:	02 00                	add    (%eax),%al
  2815bf:	00 00                	add    %al,(%eax)
  2815c1:	00 00                	add    %al,(%eax)
  2815c3:	00 00                	add    %al,(%eax)
  2815c5:	5c                   	pop    %esp
  2815c6:	62 40 40             	bound  %eax,0x40(%eax)
  2815c9:	40                   	inc    %eax
  2815ca:	40                   	inc    %eax
  2815cb:	40                   	inc    %eax
	...
  2815d4:	00 3c 42             	add    %bh,(%edx,%eax,2)
  2815d7:	40                   	inc    %eax
  2815d8:	3c 02                	cmp    $0x2,%al
  2815da:	42                   	inc    %edx
  2815db:	3c 00                	cmp    $0x0,%al
  2815dd:	00 00                	add    %al,(%eax)
  2815df:	00 00                	add    %al,(%eax)
  2815e1:	00 00                	add    %al,(%eax)
  2815e3:	20 20                	and    %ah,(%eax)
  2815e5:	78 20                	js     281607 <Font8x16+0x767>
  2815e7:	20 20                	and    %ah,(%eax)
  2815e9:	20 22                	and    %ah,(%edx)
  2815eb:	1c 00                	sbb    $0x0,%al
	...
  2815f5:	42                   	inc    %edx
  2815f6:	42                   	inc    %edx
  2815f7:	42                   	inc    %edx
  2815f8:	42                   	inc    %edx
  2815f9:	42                   	inc    %edx
  2815fa:	42                   	inc    %edx
  2815fb:	3e 00 00             	add    %al,%ds:(%eax)
  2815fe:	00 00                	add    %al,(%eax)
  281600:	00 00                	add    %al,(%eax)
  281602:	00 00                	add    %al,(%eax)
  281604:	00 42 42             	add    %al,0x42(%edx)
  281607:	42                   	inc    %edx
  281608:	42                   	inc    %edx
  281609:	42                   	inc    %edx
  28160a:	24 18                	and    $0x18,%al
	...
  281614:	00 82 82 82 92 92    	add    %al,-0x6d6d7d7e(%edx)
  28161a:	aa                   	stos   %al,%es:(%edi)
  28161b:	44                   	inc    %esp
	...
  281624:	00 42 42             	add    %al,0x42(%edx)
  281627:	24 18                	and    $0x18,%al
  281629:	24 42                	and    $0x42,%al
  28162b:	42                   	inc    %edx
	...
  281634:	00 42 42             	add    %al,0x42(%edx)
  281637:	42                   	inc    %edx
  281638:	42                   	inc    %edx
  281639:	42                   	inc    %edx
  28163a:	3e 02 02             	add    %ds:(%edx),%al
  28163d:	3c 00                	cmp    $0x0,%al
  28163f:	00 00                	add    %al,(%eax)
  281641:	00 00                	add    %al,(%eax)
  281643:	00 00                	add    %al,(%eax)
  281645:	7e 02                	jle    281649 <Font8x16+0x7a9>
  281647:	04 18                	add    $0x18,%al
  281649:	20 40 7e             	and    %al,0x7e(%eax)
  28164c:	00 00                	add    %al,(%eax)
  28164e:	00 00                	add    %al,(%eax)
  281650:	00 00                	add    %al,(%eax)
  281652:	08 10                	or     %dl,(%eax)
  281654:	10 10                	adc    %dl,(%eax)
  281656:	20 40 20             	and    %al,0x20(%eax)
  281659:	10 10                	adc    %dl,(%eax)
  28165b:	10 08                	adc    %cl,(%eax)
  28165d:	00 00                	add    %al,(%eax)
  28165f:	00 00                	add    %al,(%eax)
  281661:	10 10                	adc    %dl,(%eax)
  281663:	10 10                	adc    %dl,(%eax)
  281665:	10 10                	adc    %dl,(%eax)
  281667:	10 10                	adc    %dl,(%eax)
  281669:	10 10                	adc    %dl,(%eax)
  28166b:	10 10                	adc    %dl,(%eax)
  28166d:	10 10                	adc    %dl,(%eax)
  28166f:	00 00                	add    %al,(%eax)
  281671:	00 20                	add    %ah,(%eax)
  281673:	10 10                	adc    %dl,(%eax)
  281675:	10 08                	adc    %cl,(%eax)
  281677:	04 08                	add    $0x8,%al
  281679:	10 10                	adc    %dl,(%eax)
  28167b:	10 20                	adc    %ah,(%eax)
	...
  281685:	00 22                	add    %ah,(%edx)
  281687:	54                   	push   %esp
  281688:	88 00                	mov    %al,(%eax)
	...

002816a0 <ASCII_Table>:
	...
  2816d0:	00 00                	add    %al,(%eax)
  2816d2:	80 01 80             	addb   $0x80,(%ecx)
  2816d5:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2816db:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2816e1:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2816e7:	01 80 01 80 01 00    	add    %eax,0x18001(%eax)
  2816ed:	00 00                	add    %al,(%eax)
  2816ef:	00 80 01 80 01 00    	add    %al,0x18001(%eax)
	...
  281701:	00 00                	add    %al,(%eax)
  281703:	00 cc                	add    %cl,%ah
  281705:	00 cc                	add    %cl,%ah
  281707:	00 cc                	add    %cl,%ah
  281709:	00 cc                	add    %cl,%ah
  28170b:	00 cc                	add    %cl,%ah
  28170d:	00 cc                	add    %cl,%ah
	...
  28173b:	00 60 0c             	add    %ah,0xc(%eax)
  28173e:	60                   	pusha  
  28173f:	0c 60                	or     $0x60,%al
  281741:	0c 30                	or     $0x30,%al
  281743:	06                   	push   %es
  281744:	30 06                	xor    %al,(%esi)
  281746:	fe                   	(bad)  
  281747:	1f                   	pop    %ds
  281748:	fe                   	(bad)  
  281749:	1f                   	pop    %ds
  28174a:	30 06                	xor    %al,(%esi)
  28174c:	38 07                	cmp    %al,(%edi)
  28174e:	18 03                	sbb    %al,(%ebx)
  281750:	fe                   	(bad)  
  281751:	1f                   	pop    %ds
  281752:	fe                   	(bad)  
  281753:	1f                   	pop    %ds
  281754:	18 03                	sbb    %al,(%ebx)
  281756:	18 03                	sbb    %al,(%ebx)
  281758:	8c 01                	mov    %es,(%ecx)
  28175a:	8c 01                	mov    %es,(%ecx)
  28175c:	8c 01                	mov    %es,(%ecx)
  28175e:	00 00                	add    %al,(%eax)
  281760:	00 00                	add    %al,(%eax)
  281762:	80 00 e0             	addb   $0xe0,(%eax)
  281765:	03 f8                	add    %eax,%edi
  281767:	0f 9c 0e             	setl   (%esi)
  28176a:	8c 1c 8c             	mov    %ds,(%esp,%ecx,4)
  28176d:	18 8c 00 98 00 f8 01 	sbb    %cl,0x1f80098(%eax,%eax,1)
  281774:	e0 07                	loopne 28177d <ASCII_Table+0xdd>
  281776:	80 0e 80             	orb    $0x80,(%esi)
  281779:	1c 8c                	sbb    $0x8c,%al
  28177b:	18 8c 18 9c 18 b8 0c 	sbb    %cl,0xcb8189c(%eax,%ebx,1)
  281782:	f0 0f e0 03          	lock pavgb (%ebx),%mm0
  281786:	80 00 80             	addb   $0x80,(%eax)
	...
  281795:	00 0e                	add    %cl,(%esi)
  281797:	18 1b                	sbb    %bl,(%ebx)
  281799:	0c 11                	or     $0x11,%al
  28179b:	0c 11                	or     $0x11,%al
  28179d:	06                   	push   %es
  28179e:	11 06                	adc    %eax,(%esi)
  2817a0:	11 03                	adc    %eax,(%ebx)
  2817a2:	11 03                	adc    %eax,(%ebx)
  2817a4:	9b                   	fwait
  2817a5:	01 8e 01 c0 38 c0    	add    %ecx,-0x3fc73fff(%esi)
  2817ab:	6c                   	insb   (%dx),%es:(%edi)
  2817ac:	60                   	pusha  
  2817ad:	44                   	inc    %esp
  2817ae:	60                   	pusha  
  2817af:	44                   	inc    %esp
  2817b0:	30 44 30 44          	xor    %al,0x44(%eax,%esi,1)
  2817b4:	18 44 18 6c          	sbb    %al,0x6c(%eax,%ebx,1)
  2817b8:	0c 38                	or     $0x38,%al
	...
  2817c2:	e0 01                	loopne 2817c5 <ASCII_Table+0x125>
  2817c4:	f0 03 38             	lock add (%eax),%edi
  2817c7:	07                   	pop    %es
  2817c8:	18 06                	sbb    %al,(%esi)
  2817ca:	18 06                	sbb    %al,(%esi)
  2817cc:	30 03                	xor    %al,(%ebx)
  2817ce:	f0 01 f0             	lock add %esi,%eax
  2817d1:	00 f8                	add    %bh,%al
  2817d3:	00 9c 31 0e 33 06 1e 	add    %bl,0x1e06330e(%ecx,%esi,1)
  2817da:	06                   	push   %es
  2817db:	1c 06                	sbb    $0x6,%al
  2817dd:	1c 06                	sbb    $0x6,%al
  2817df:	3f                   	aas    
  2817e0:	fc                   	cld    
  2817e1:	73 f0                	jae    2817d3 <ASCII_Table+0x133>
  2817e3:	21 00                	and    %eax,(%eax)
	...
  2817f1:	00 00                	add    %al,(%eax)
  2817f3:	00 0c 00             	add    %cl,(%eax,%eax,1)
  2817f6:	0c 00                	or     $0x0,%al
  2817f8:	0c 00                	or     $0x0,%al
  2817fa:	0c 00                	or     $0x0,%al
  2817fc:	0c 00                	or     $0x0,%al
  2817fe:	0c 00                	or     $0x0,%al
	...
  281820:	00 00                	add    %al,(%eax)
  281822:	00 02                	add    %al,(%edx)
  281824:	00 03                	add    %al,(%ebx)
  281826:	80 01 c0             	addb   $0xc0,(%ecx)
  281829:	00 c0                	add    %al,%al
  28182b:	00 60 00             	add    %ah,0x0(%eax)
  28182e:	60                   	pusha  
  28182f:	00 30                	add    %dh,(%eax)
  281831:	00 30                	add    %dh,(%eax)
  281833:	00 30                	add    %dh,(%eax)
  281835:	00 30                	add    %dh,(%eax)
  281837:	00 30                	add    %dh,(%eax)
  281839:	00 30                	add    %dh,(%eax)
  28183b:	00 30                	add    %dh,(%eax)
  28183d:	00 30                	add    %dh,(%eax)
  28183f:	00 60 00             	add    %ah,0x0(%eax)
  281842:	60                   	pusha  
  281843:	00 c0                	add    %al,%al
  281845:	00 c0                	add    %al,%al
  281847:	00 80 01 00 03 00    	add    %al,0x30001(%eax)
  28184d:	02 00                	add    (%eax),%al
  28184f:	00 00                	add    %al,(%eax)
  281851:	00 20                	add    %ah,(%eax)
  281853:	00 60 00             	add    %ah,0x0(%eax)
  281856:	c0 00 80             	rolb   $0x80,(%eax)
  281859:	01 80 01 00 03 00    	add    %eax,0x30001(%eax)
  28185f:	03 00                	add    (%eax),%eax
  281861:	06                   	push   %es
  281862:	00 06                	add    %al,(%esi)
  281864:	00 06                	add    %al,(%esi)
  281866:	00 06                	add    %al,(%esi)
  281868:	00 06                	add    %al,(%esi)
  28186a:	00 06                	add    %al,(%esi)
  28186c:	00 06                	add    %al,(%esi)
  28186e:	00 06                	add    %al,(%esi)
  281870:	00 03                	add    %al,(%ebx)
  281872:	00 03                	add    %al,(%ebx)
  281874:	80 01 80             	addb   $0x80,(%ecx)
  281877:	01 c0                	add    %eax,%eax
  281879:	00 60 00             	add    %ah,0x0(%eax)
  28187c:	20 00                	and    %al,(%eax)
	...
  28188a:	00 00                	add    %al,(%eax)
  28188c:	c0 00 c0             	rolb   $0xc0,(%eax)
  28188f:	00 d8                	add    %bl,%al
  281891:	06                   	push   %es
  281892:	f8                   	clc    
  281893:	07                   	pop    %es
  281894:	e0 01                	loopne 281897 <ASCII_Table+0x1f7>
  281896:	30 03                	xor    %al,(%ebx)
  281898:	38 07                	cmp    %al,(%edi)
	...
  2818ba:	00 00                	add    %al,(%eax)
  2818bc:	80 01 80             	addb   $0x80,(%ecx)
  2818bf:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2818c5:	01 fc                	add    %edi,%esp
  2818c7:	3f                   	aas    
  2818c8:	fc                   	cld    
  2818c9:	3f                   	aas    
  2818ca:	80 01 80             	addb   $0x80,(%ecx)
  2818cd:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2818d3:	01 00                	add    %eax,(%eax)
	...
  281901:	00 80 01 80 01 00    	add    %al,0x18001(%eax)
  281907:	01 00                	add    %eax,(%eax)
  281909:	01 80 00 00 00 00    	add    %eax,0x0(%eax)
	...
  281927:	00 e0                	add    %ah,%al
  281929:	07                   	pop    %es
  28192a:	e0 07                	loopne 281933 <ASCII_Table+0x293>
	...
  281960:	00 00                	add    %al,(%eax)
  281962:	c0 00 c0             	rolb   $0xc0,(%eax)
	...
  281971:	00 00                	add    %al,(%eax)
  281973:	0c 00                	or     $0x0,%al
  281975:	0c 00                	or     $0x0,%al
  281977:	06                   	push   %es
  281978:	00 06                	add    %al,(%esi)
  28197a:	00 06                	add    %al,(%esi)
  28197c:	00 03                	add    %al,(%ebx)
  28197e:	00 03                	add    %al,(%ebx)
  281980:	00 03                	add    %al,(%ebx)
  281982:	80 03 80             	addb   $0x80,(%ebx)
  281985:	01 80 01 80 01 c0    	add    %eax,-0x3ffe7fff(%eax)
  28198b:	00 c0                	add    %al,%al
  28198d:	00 c0                	add    %al,%al
  28198f:	00 60 00             	add    %ah,0x0(%eax)
  281992:	60                   	pusha  
	...
  28199f:	00 00                	add    %al,(%eax)
  2819a1:	00 e0                	add    %ah,%al
  2819a3:	03 f0                	add    %eax,%esi
  2819a5:	07                   	pop    %es
  2819a6:	38 0e                	cmp    %cl,(%esi)
  2819a8:	18 0c 0c             	sbb    %cl,(%esp,%ecx,1)
  2819ab:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  2819ae:	0c 18                	or     $0x18,%al
  2819b0:	0c 18                	or     $0x18,%al
  2819b2:	0c 18                	or     $0x18,%al
  2819b4:	0c 18                	or     $0x18,%al
  2819b6:	0c 18                	or     $0x18,%al
  2819b8:	0c 18                	or     $0x18,%al
  2819ba:	0c 18                	or     $0x18,%al
  2819bc:	18 0c 38             	sbb    %cl,(%eax,%edi,1)
  2819bf:	0e                   	push   %cs
  2819c0:	f0 07                	lock pop %es
  2819c2:	e0 03                	loopne 2819c7 <ASCII_Table+0x327>
	...
  2819d0:	00 00                	add    %al,(%eax)
  2819d2:	00 01                	add    %al,(%ecx)
  2819d4:	80 01 c0             	addb   $0xc0,(%ecx)
  2819d7:	01 f0                	add    %esi,%eax
  2819d9:	01 98 01 88 01 80    	add    %ebx,-0x7ffe77ff(%eax)
  2819df:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2819e5:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2819eb:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2819f1:	01 80 01 00 00 00    	add    %eax,0x1(%eax)
	...
  2819ff:	00 00                	add    %al,(%eax)
  281a01:	00 e0                	add    %ah,%al
  281a03:	03 f8                	add    %eax,%edi
  281a05:	0f 18 0c 0c          	prefetcht0 (%esp,%ecx,1)
  281a09:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281a0c:	00 18                	add    %bl,(%eax)
  281a0e:	00 18                	add    %bl,(%eax)
  281a10:	00 0c 00             	add    %cl,(%eax,%eax,1)
  281a13:	06                   	push   %es
  281a14:	00 03                	add    %al,(%ebx)
  281a16:	80 01 c0             	addb   $0xc0,(%ecx)
  281a19:	00 60 00             	add    %ah,0x0(%eax)
  281a1c:	30 00                	xor    %al,(%eax)
  281a1e:	18 00                	sbb    %al,(%eax)
  281a20:	fc                   	cld    
  281a21:	1f                   	pop    %ds
  281a22:	fc                   	cld    
  281a23:	1f                   	pop    %ds
	...
  281a30:	00 00                	add    %al,(%eax)
  281a32:	e0 01                	loopne 281a35 <ASCII_Table+0x395>
  281a34:	f8                   	clc    
  281a35:	07                   	pop    %es
  281a36:	18 0e                	sbb    %cl,(%esi)
  281a38:	0c 0c                	or     $0xc,%al
  281a3a:	0c 0c                	or     $0xc,%al
  281a3c:	00 0c 00             	add    %cl,(%eax,%eax,1)
  281a3f:	06                   	push   %es
  281a40:	c0 03 c0             	rolb   $0xc0,(%ebx)
  281a43:	07                   	pop    %es
  281a44:	00 0c 00             	add    %cl,(%eax,%eax,1)
  281a47:	18 00                	sbb    %al,(%eax)
  281a49:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281a4c:	0c 18                	or     $0x18,%al
  281a4e:	18 0c f8             	sbb    %cl,(%eax,%edi,8)
  281a51:	07                   	pop    %es
  281a52:	e0 03                	loopne 281a57 <ASCII_Table+0x3b7>
	...
  281a60:	00 00                	add    %al,(%eax)
  281a62:	00 0c 00             	add    %cl,(%eax,%eax,1)
  281a65:	0e                   	push   %cs
  281a66:	00 0f                	add    %cl,(%edi)
  281a68:	00 0f                	add    %cl,(%edi)
  281a6a:	80 0d c0 0c 60 0c 60 	orb    $0x60,0xc600cc0
  281a71:	0c 30                	or     $0x30,%al
  281a73:	0c 18                	or     $0x18,%al
  281a75:	0c 0c                	or     $0xc,%al
  281a77:	0c fc                	or     $0xfc,%al
  281a79:	3f                   	aas    
  281a7a:	fc                   	cld    
  281a7b:	3f                   	aas    
  281a7c:	00 0c 00             	add    %cl,(%eax,%eax,1)
  281a7f:	0c 00                	or     $0x0,%al
  281a81:	0c 00                	or     $0x0,%al
  281a83:	0c 00                	or     $0x0,%al
	...
  281a91:	00 f8                	add    %bh,%al
  281a93:	0f f8 0f             	psubb  (%edi),%mm1
  281a96:	18 00                	sbb    %al,(%eax)
  281a98:	18 00                	sbb    %al,(%eax)
  281a9a:	0c 00                	or     $0x0,%al
  281a9c:	ec                   	in     (%dx),%al
  281a9d:	03 fc                	add    %esp,%edi
  281a9f:	07                   	pop    %es
  281aa0:	1c 0e                	sbb    $0xe,%al
  281aa2:	00 1c 00             	add    %bl,(%eax,%eax,1)
  281aa5:	18 00                	sbb    %al,(%eax)
  281aa7:	18 00                	sbb    %al,(%eax)
  281aa9:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281aac:	1c 0c                	sbb    $0xc,%al
  281aae:	18 0e                	sbb    %cl,(%esi)
  281ab0:	f8                   	clc    
  281ab1:	07                   	pop    %es
  281ab2:	e0 03                	loopne 281ab7 <ASCII_Table+0x417>
	...
  281ac0:	00 00                	add    %al,(%eax)
  281ac2:	c0 07 f0             	rolb   $0xf0,(%edi)
  281ac5:	0f 38 1c 18          	pabsb  (%eax),%mm3
  281ac9:	18 18                	sbb    %bl,(%eax)
  281acb:	00 0c 00             	add    %cl,(%eax,%eax,1)
  281ace:	cc                   	int3   
  281acf:	03 ec                	add    %esp,%ebp
  281ad1:	0f 3c                	(bad)  
  281ad3:	0e                   	push   %cs
  281ad4:	1c 1c                	sbb    $0x1c,%al
  281ad6:	0c 18                	or     $0x18,%al
  281ad8:	0c 18                	or     $0x18,%al
  281ada:	0c 18                	or     $0x18,%al
  281adc:	18 1c 38             	sbb    %bl,(%eax,%edi,1)
  281adf:	0e                   	push   %cs
  281ae0:	f0 07                	lock pop %es
  281ae2:	e0 03                	loopne 281ae7 <ASCII_Table+0x447>
	...
  281af0:	00 00                	add    %al,(%eax)
  281af2:	fc                   	cld    
  281af3:	1f                   	pop    %ds
  281af4:	fc                   	cld    
  281af5:	1f                   	pop    %ds
  281af6:	00 0c 00             	add    %cl,(%eax,%eax,1)
  281af9:	06                   	push   %es
  281afa:	00 06                	add    %al,(%esi)
  281afc:	00 03                	add    %al,(%ebx)
  281afe:	80 03 80             	addb   $0x80,(%ebx)
  281b01:	01 c0                	add    %eax,%eax
  281b03:	01 c0                	add    %eax,%eax
  281b05:	00 e0                	add    %ah,%al
  281b07:	00 60 00             	add    %ah,0x0(%eax)
  281b0a:	60                   	pusha  
  281b0b:	00 70 00             	add    %dh,0x0(%eax)
  281b0e:	30 00                	xor    %al,(%eax)
  281b10:	30 00                	xor    %al,(%eax)
  281b12:	30 00                	xor    %al,(%eax)
	...
  281b20:	00 00                	add    %al,(%eax)
  281b22:	e0 03                	loopne 281b27 <ASCII_Table+0x487>
  281b24:	f0 07                	lock pop %es
  281b26:	38 0e                	cmp    %cl,(%esi)
  281b28:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281b2b:	0c 18                	or     $0x18,%al
  281b2d:	0c 38                	or     $0x38,%al
  281b2f:	06                   	push   %es
  281b30:	f0 07                	lock pop %es
  281b32:	f0 07                	lock pop %es
  281b34:	18 0c 0c             	sbb    %cl,(%esp,%ecx,1)
  281b37:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281b3a:	0c 18                	or     $0x18,%al
  281b3c:	0c 18                	or     $0x18,%al
  281b3e:	38 0c f8             	cmp    %cl,(%eax,%edi,8)
  281b41:	0f e0 03             	pavgb  (%ebx),%mm0
	...
  281b50:	00 00                	add    %al,(%eax)
  281b52:	e0 03                	loopne 281b57 <ASCII_Table+0x4b7>
  281b54:	f0 07                	lock pop %es
  281b56:	38 0e                	cmp    %cl,(%esi)
  281b58:	1c 0c                	sbb    $0xc,%al
  281b5a:	0c 18                	or     $0x18,%al
  281b5c:	0c 18                	or     $0x18,%al
  281b5e:	0c 18                	or     $0x18,%al
  281b60:	1c 1c                	sbb    $0x1c,%al
  281b62:	38 1e                	cmp    %bl,(%esi)
  281b64:	f8                   	clc    
  281b65:	1b e0                	sbb    %eax,%esp
  281b67:	19 00                	sbb    %eax,(%eax)
  281b69:	18 00                	sbb    %al,(%eax)
  281b6b:	0c 00                	or     $0x0,%al
  281b6d:	0c 1c                	or     $0x1c,%al
  281b6f:	0e                   	push   %cs
  281b70:	f8                   	clc    
  281b71:	07                   	pop    %es
  281b72:	f0 01 00             	lock add %eax,(%eax)
	...
  281b89:	00 00                	add    %al,(%eax)
  281b8b:	00 80 01 80 01 00    	add    %al,0x18001(%eax)
	...
  281b9d:	00 00                	add    %al,(%eax)
  281b9f:	00 80 01 80 01 00    	add    %al,0x18001(%eax)
	...
  281bb9:	00 00                	add    %al,(%eax)
  281bbb:	00 80 01 80 01 00    	add    %al,0x18001(%eax)
	...
  281bcd:	00 00                	add    %al,(%eax)
  281bcf:	00 80 01 80 01 00    	add    %al,0x18001(%eax)
  281bd5:	01 00                	add    %eax,(%eax)
  281bd7:	01 80 00 00 00 00    	add    %eax,0x0(%eax)
	...
  281bf1:	10 00                	adc    %al,(%eax)
  281bf3:	1c 80                	sbb    $0x80,%al
  281bf5:	0f e0 03             	pavgb  (%ebx),%mm0
  281bf8:	f8                   	clc    
  281bf9:	00 18                	add    %bl,(%eax)
  281bfb:	00 f8                	add    %bh,%al
  281bfd:	00 e0                	add    %ah,%al
  281bff:	03 80 0f 00 1c 00    	add    0x1c000f(%eax),%eax
  281c05:	10 00                	adc    %al,(%eax)
	...
  281c1f:	00 f8                	add    %bh,%al
  281c21:	1f                   	pop    %ds
  281c22:	00 00                	add    %al,(%eax)
  281c24:	00 00                	add    %al,(%eax)
  281c26:	00 00                	add    %al,(%eax)
  281c28:	f8                   	clc    
  281c29:	1f                   	pop    %ds
	...
  281c4e:	00 00                	add    %al,(%eax)
  281c50:	08 00                	or     %al,(%eax)
  281c52:	38 00                	cmp    %al,(%eax)
  281c54:	f0 01 c0             	lock add %eax,%eax
  281c57:	07                   	pop    %es
  281c58:	00 1f                	add    %bl,(%edi)
  281c5a:	00 18                	add    %bl,(%eax)
  281c5c:	00 1f                	add    %bl,(%edi)
  281c5e:	c0 07 f0             	rolb   $0xf0,(%edi)
  281c61:	01 38                	add    %edi,(%eax)
  281c63:	00 08                	add    %cl,(%eax)
	...
  281c71:	00 e0                	add    %ah,%al
  281c73:	03 f8                	add    %eax,%edi
  281c75:	0f 18 0c 0c          	prefetcht0 (%esp,%ecx,1)
  281c79:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281c7c:	00 18                	add    %bl,(%eax)
  281c7e:	00 0c 00             	add    %cl,(%eax,%eax,1)
  281c81:	06                   	push   %es
  281c82:	00 03                	add    %al,(%ebx)
  281c84:	80 01 c0             	addb   $0xc0,(%ecx)
  281c87:	00 c0                	add    %al,%al
  281c89:	00 c0                	add    %al,%al
  281c8b:	00 00                	add    %al,(%eax)
  281c8d:	00 00                	add    %al,(%eax)
  281c8f:	00 c0                	add    %al,%al
  281c91:	00 c0                	add    %al,%al
	...
  281ca3:	00 e0                	add    %ah,%al
  281ca5:	07                   	pop    %es
  281ca6:	18 18                	sbb    %bl,(%eax)
  281ca8:	04 20                	add    $0x20,%al
  281caa:	c2 29 22             	ret    $0x2229
  281cad:	4a                   	dec    %edx
  281cae:	11 44 09 44          	adc    %eax,0x44(%ecx,%ecx,1)
  281cb2:	09 44 09 44          	or     %eax,0x44(%ecx,%ecx,1)
  281cb6:	09 22                	or     %esp,(%edx)
  281cb8:	11 13                	adc    %edx,(%ebx)
  281cba:	e2 0c                	loop   281cc8 <ASCII_Table+0x628>
  281cbc:	02 40 04             	add    0x4(%eax),%al
  281cbf:	20 18                	and    %bl,(%eax)
  281cc1:	18 e0                	sbb    %ah,%al
  281cc3:	07                   	pop    %es
	...
  281cd0:	00 00                	add    %al,(%eax)
  281cd2:	80 03 80             	addb   $0x80,(%ebx)
  281cd5:	03 c0                	add    %eax,%eax
  281cd7:	06                   	push   %es
  281cd8:	c0 06 c0             	rolb   $0xc0,(%esi)
  281cdb:	06                   	push   %es
  281cdc:	60                   	pusha  
  281cdd:	0c 60                	or     $0x60,%al
  281cdf:	0c 30                	or     $0x30,%al
  281ce1:	18 30                	sbb    %dh,(%eax)
  281ce3:	18 30                	sbb    %dh,(%eax)
  281ce5:	18 f8                	sbb    %bh,%al
  281ce7:	3f                   	aas    
  281ce8:	f8                   	clc    
  281ce9:	3f                   	aas    
  281cea:	1c 70                	sbb    $0x70,%al
  281cec:	0c 60                	or     $0x60,%al
  281cee:	0c 60                	or     $0x60,%al
  281cf0:	06                   	push   %es
  281cf1:	c0 06 c0             	rolb   $0xc0,(%esi)
	...
  281d00:	00 00                	add    %al,(%eax)
  281d02:	fc                   	cld    
  281d03:	03 fc                	add    %esp,%edi
  281d05:	0f 0c                	(bad)  
  281d07:	0c 0c                	or     $0xc,%al
  281d09:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  281d0c:	0c 18                	or     $0x18,%al
  281d0e:	0c 0c                	or     $0xc,%al
  281d10:	fc                   	cld    
  281d11:	07                   	pop    %es
  281d12:	fc                   	cld    
  281d13:	0f 0c                	(bad)  
  281d15:	18 0c 30             	sbb    %cl,(%eax,%esi,1)
  281d18:	0c 30                	or     $0x30,%al
  281d1a:	0c 30                	or     $0x30,%al
  281d1c:	0c 30                	or     $0x30,%al
  281d1e:	0c 18                	or     $0x18,%al
  281d20:	fc                   	cld    
  281d21:	1f                   	pop    %ds
  281d22:	fc                   	cld    
  281d23:	07                   	pop    %es
	...
  281d30:	00 00                	add    %al,(%eax)
  281d32:	c0 07 f0             	rolb   $0xf0,(%edi)
  281d35:	1f                   	pop    %ds
  281d36:	38 38                	cmp    %bh,(%eax)
  281d38:	1c 30                	sbb    $0x30,%al
  281d3a:	0c 70                	or     $0x70,%al
  281d3c:	06                   	push   %es
  281d3d:	60                   	pusha  
  281d3e:	06                   	push   %es
  281d3f:	00 06                	add    %al,(%esi)
  281d41:	00 06                	add    %al,(%esi)
  281d43:	00 06                	add    %al,(%esi)
  281d45:	00 06                	add    %al,(%esi)
  281d47:	00 06                	add    %al,(%esi)
  281d49:	00 06                	add    %al,(%esi)
  281d4b:	60                   	pusha  
  281d4c:	0c 70                	or     $0x70,%al
  281d4e:	1c 30                	sbb    $0x30,%al
  281d50:	f0 1f                	lock pop %ds
  281d52:	e0 07                	loopne 281d5b <ASCII_Table+0x6bb>
	...
  281d60:	00 00                	add    %al,(%eax)
  281d62:	fe 03                	incb   (%ebx)
  281d64:	fe 0f                	decb   (%edi)
  281d66:	06                   	push   %es
  281d67:	0e                   	push   %cs
  281d68:	06                   	push   %es
  281d69:	18 06                	sbb    %al,(%esi)
  281d6b:	18 06                	sbb    %al,(%esi)
  281d6d:	30 06                	xor    %al,(%esi)
  281d6f:	30 06                	xor    %al,(%esi)
  281d71:	30 06                	xor    %al,(%esi)
  281d73:	30 06                	xor    %al,(%esi)
  281d75:	30 06                	xor    %al,(%esi)
  281d77:	30 06                	xor    %al,(%esi)
  281d79:	30 06                	xor    %al,(%esi)
  281d7b:	18 06                	sbb    %al,(%esi)
  281d7d:	18 06                	sbb    %al,(%esi)
  281d7f:	0e                   	push   %cs
  281d80:	fe 0f                	decb   (%edi)
  281d82:	fe 03                	incb   (%ebx)
	...
  281d90:	00 00                	add    %al,(%eax)
  281d92:	fc                   	cld    
  281d93:	3f                   	aas    
  281d94:	fc                   	cld    
  281d95:	3f                   	aas    
  281d96:	0c 00                	or     $0x0,%al
  281d98:	0c 00                	or     $0x0,%al
  281d9a:	0c 00                	or     $0x0,%al
  281d9c:	0c 00                	or     $0x0,%al
  281d9e:	0c 00                	or     $0x0,%al
  281da0:	fc                   	cld    
  281da1:	1f                   	pop    %ds
  281da2:	fc                   	cld    
  281da3:	1f                   	pop    %ds
  281da4:	0c 00                	or     $0x0,%al
  281da6:	0c 00                	or     $0x0,%al
  281da8:	0c 00                	or     $0x0,%al
  281daa:	0c 00                	or     $0x0,%al
  281dac:	0c 00                	or     $0x0,%al
  281dae:	0c 00                	or     $0x0,%al
  281db0:	fc                   	cld    
  281db1:	3f                   	aas    
  281db2:	fc                   	cld    
  281db3:	3f                   	aas    
	...
  281dc0:	00 00                	add    %al,(%eax)
  281dc2:	f8                   	clc    
  281dc3:	3f                   	aas    
  281dc4:	f8                   	clc    
  281dc5:	3f                   	aas    
  281dc6:	18 00                	sbb    %al,(%eax)
  281dc8:	18 00                	sbb    %al,(%eax)
  281dca:	18 00                	sbb    %al,(%eax)
  281dcc:	18 00                	sbb    %al,(%eax)
  281dce:	18 00                	sbb    %al,(%eax)
  281dd0:	f8                   	clc    
  281dd1:	1f                   	pop    %ds
  281dd2:	f8                   	clc    
  281dd3:	1f                   	pop    %ds
  281dd4:	18 00                	sbb    %al,(%eax)
  281dd6:	18 00                	sbb    %al,(%eax)
  281dd8:	18 00                	sbb    %al,(%eax)
  281dda:	18 00                	sbb    %al,(%eax)
  281ddc:	18 00                	sbb    %al,(%eax)
  281dde:	18 00                	sbb    %al,(%eax)
  281de0:	18 00                	sbb    %al,(%eax)
  281de2:	18 00                	sbb    %al,(%eax)
	...
  281df0:	00 00                	add    %al,(%eax)
  281df2:	e0 0f                	loopne 281e03 <ASCII_Table+0x763>
  281df4:	f8                   	clc    
  281df5:	3f                   	aas    
  281df6:	3c 78                	cmp    $0x78,%al
  281df8:	0e                   	push   %cs
  281df9:	60                   	pusha  
  281dfa:	06                   	push   %es
  281dfb:	e0 07                	loopne 281e04 <ASCII_Table+0x764>
  281dfd:	c0 03 00             	rolb   $0x0,(%ebx)
  281e00:	03 00                	add    (%eax),%eax
  281e02:	03 fe                	add    %esi,%edi
  281e04:	03 fe                	add    %esi,%edi
  281e06:	03 c0                	add    %eax,%eax
  281e08:	07                   	pop    %es
  281e09:	c0 06 c0             	rolb   $0xc0,(%esi)
  281e0c:	0e                   	push   %cs
  281e0d:	c0 3c f0 f8          	sarb   $0xf8,(%eax,%esi,8)
  281e11:	3f                   	aas    
  281e12:	e0 0f                	loopne 281e23 <ASCII_Table+0x783>
	...
  281e20:	00 00                	add    %al,(%eax)
  281e22:	0c 30                	or     $0x30,%al
  281e24:	0c 30                	or     $0x30,%al
  281e26:	0c 30                	or     $0x30,%al
  281e28:	0c 30                	or     $0x30,%al
  281e2a:	0c 30                	or     $0x30,%al
  281e2c:	0c 30                	or     $0x30,%al
  281e2e:	0c 30                	or     $0x30,%al
  281e30:	fc                   	cld    
  281e31:	3f                   	aas    
  281e32:	fc                   	cld    
  281e33:	3f                   	aas    
  281e34:	0c 30                	or     $0x30,%al
  281e36:	0c 30                	or     $0x30,%al
  281e38:	0c 30                	or     $0x30,%al
  281e3a:	0c 30                	or     $0x30,%al
  281e3c:	0c 30                	or     $0x30,%al
  281e3e:	0c 30                	or     $0x30,%al
  281e40:	0c 30                	or     $0x30,%al
  281e42:	0c 30                	or     $0x30,%al
	...
  281e50:	00 00                	add    %al,(%eax)
  281e52:	80 01 80             	addb   $0x80,(%ecx)
  281e55:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281e5b:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281e61:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281e67:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281e6d:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  281e73:	01 00                	add    %eax,(%eax)
	...
  281e81:	00 00                	add    %al,(%eax)
  281e83:	06                   	push   %es
  281e84:	00 06                	add    %al,(%esi)
  281e86:	00 06                	add    %al,(%esi)
  281e88:	00 06                	add    %al,(%esi)
  281e8a:	00 06                	add    %al,(%esi)
  281e8c:	00 06                	add    %al,(%esi)
  281e8e:	00 06                	add    %al,(%esi)
  281e90:	00 06                	add    %al,(%esi)
  281e92:	00 06                	add    %al,(%esi)
  281e94:	00 06                	add    %al,(%esi)
  281e96:	00 06                	add    %al,(%esi)
  281e98:	00 06                	add    %al,(%esi)
  281e9a:	18 06                	sbb    %al,(%esi)
  281e9c:	18 06                	sbb    %al,(%esi)
  281e9e:	38 07                	cmp    %al,(%edi)
  281ea0:	f0 03 e0             	lock add %eax,%esp
  281ea3:	01 00                	add    %eax,(%eax)
	...
  281eb1:	00 06                	add    %al,(%esi)
  281eb3:	30 06                	xor    %al,(%esi)
  281eb5:	18 06                	sbb    %al,(%esi)
  281eb7:	0c 06                	or     $0x6,%al
  281eb9:	06                   	push   %es
  281eba:	06                   	push   %es
  281ebb:	03 86 01 c6 00 66    	add    0x6600c601(%esi),%eax
  281ec1:	00 76 00             	add    %dh,0x0(%esi)
  281ec4:	de 00                	fiadd  (%eax)
  281ec6:	8e 01                	mov    (%ecx),%es
  281ec8:	06                   	push   %es
  281ec9:	03 06                	add    (%esi),%eax
  281ecb:	06                   	push   %es
  281ecc:	06                   	push   %es
  281ecd:	0c 06                	or     $0x6,%al
  281ecf:	18 06                	sbb    %al,(%esi)
  281ed1:	30 06                	xor    %al,(%esi)
  281ed3:	60                   	pusha  
	...
  281ee0:	00 00                	add    %al,(%eax)
  281ee2:	18 00                	sbb    %al,(%eax)
  281ee4:	18 00                	sbb    %al,(%eax)
  281ee6:	18 00                	sbb    %al,(%eax)
  281ee8:	18 00                	sbb    %al,(%eax)
  281eea:	18 00                	sbb    %al,(%eax)
  281eec:	18 00                	sbb    %al,(%eax)
  281eee:	18 00                	sbb    %al,(%eax)
  281ef0:	18 00                	sbb    %al,(%eax)
  281ef2:	18 00                	sbb    %al,(%eax)
  281ef4:	18 00                	sbb    %al,(%eax)
  281ef6:	18 00                	sbb    %al,(%eax)
  281ef8:	18 00                	sbb    %al,(%eax)
  281efa:	18 00                	sbb    %al,(%eax)
  281efc:	18 00                	sbb    %al,(%eax)
  281efe:	18 00                	sbb    %al,(%eax)
  281f00:	f8                   	clc    
  281f01:	1f                   	pop    %ds
  281f02:	f8                   	clc    
  281f03:	1f                   	pop    %ds
	...
  281f10:	00 00                	add    %al,(%eax)
  281f12:	0e                   	push   %cs
  281f13:	e0 1e                	loopne 281f33 <ASCII_Table+0x893>
  281f15:	f0 1e                	lock push %ds
  281f17:	f0 1e                	lock push %ds
  281f19:	f0 36 d8 36          	lock fdivs %ss:(%esi)
  281f1d:	d8 36                	fdivs  (%esi)
  281f1f:	d8 36                	fdivs  (%esi)
  281f21:	d8 66 cc             	fsubs  -0x34(%esi)
  281f24:	66                   	data16
  281f25:	cc                   	int3   
  281f26:	66                   	data16
  281f27:	cc                   	int3   
  281f28:	c6 c6 c6             	mov    $0xc6,%dh
  281f2b:	c6 c6 c6             	mov    $0xc6,%dh
  281f2e:	c6 c6 86             	mov    $0x86,%dh
  281f31:	c3                   	ret    
  281f32:	86 c3                	xchg   %al,%bl
	...
  281f40:	00 00                	add    %al,(%eax)
  281f42:	0c 30                	or     $0x30,%al
  281f44:	1c 30                	sbb    $0x30,%al
  281f46:	3c 30                	cmp    $0x30,%al
  281f48:	3c 30                	cmp    $0x30,%al
  281f4a:	6c                   	insb   (%dx),%es:(%edi)
  281f4b:	30 6c 30 cc          	xor    %ch,-0x34(%eax,%esi,1)
  281f4f:	30 cc                	xor    %cl,%ah
  281f51:	30 8c 31 0c 33 0c 33 	xor    %cl,0x330c330c(%ecx,%esi,1)
  281f58:	0c 36                	or     $0x36,%al
  281f5a:	0c 36                	or     $0x36,%al
  281f5c:	0c 3c                	or     $0x3c,%al
  281f5e:	0c 3c                	or     $0x3c,%al
  281f60:	0c 38                	or     $0x38,%al
  281f62:	0c 30                	or     $0x30,%al
	...
  281f70:	00 00                	add    %al,(%eax)
  281f72:	e0 07                	loopne 281f7b <ASCII_Table+0x8db>
  281f74:	f8                   	clc    
  281f75:	1f                   	pop    %ds
  281f76:	1c 38                	sbb    $0x38,%al
  281f78:	0e                   	push   %cs
  281f79:	70 06                	jo     281f81 <ASCII_Table+0x8e1>
  281f7b:	60                   	pusha  
  281f7c:	03 c0                	add    %eax,%eax
  281f7e:	03 c0                	add    %eax,%eax
  281f80:	03 c0                	add    %eax,%eax
  281f82:	03 c0                	add    %eax,%eax
  281f84:	03 c0                	add    %eax,%eax
  281f86:	03 c0                	add    %eax,%eax
  281f88:	03 c0                	add    %eax,%eax
  281f8a:	06                   	push   %es
  281f8b:	60                   	pusha  
  281f8c:	0e                   	push   %cs
  281f8d:	70 1c                	jo     281fab <ASCII_Table+0x90b>
  281f8f:	38 f8                	cmp    %bh,%al
  281f91:	1f                   	pop    %ds
  281f92:	e0 07                	loopne 281f9b <ASCII_Table+0x8fb>
	...
  281fa0:	00 00                	add    %al,(%eax)
  281fa2:	fc                   	cld    
  281fa3:	0f fc 1f             	paddb  (%edi),%mm3
  281fa6:	0c 38                	or     $0x38,%al
  281fa8:	0c 30                	or     $0x30,%al
  281faa:	0c 30                	or     $0x30,%al
  281fac:	0c 30                	or     $0x30,%al
  281fae:	0c 30                	or     $0x30,%al
  281fb0:	0c 18                	or     $0x18,%al
  281fb2:	fc                   	cld    
  281fb3:	1f                   	pop    %ds
  281fb4:	fc                   	cld    
  281fb5:	07                   	pop    %es
  281fb6:	0c 00                	or     $0x0,%al
  281fb8:	0c 00                	or     $0x0,%al
  281fba:	0c 00                	or     $0x0,%al
  281fbc:	0c 00                	or     $0x0,%al
  281fbe:	0c 00                	or     $0x0,%al
  281fc0:	0c 00                	or     $0x0,%al
  281fc2:	0c 00                	or     $0x0,%al
	...
  281fd0:	00 00                	add    %al,(%eax)
  281fd2:	e0 07                	loopne 281fdb <ASCII_Table+0x93b>
  281fd4:	f8                   	clc    
  281fd5:	1f                   	pop    %ds
  281fd6:	1c 38                	sbb    $0x38,%al
  281fd8:	0e                   	push   %cs
  281fd9:	70 06                	jo     281fe1 <ASCII_Table+0x941>
  281fdb:	60                   	pusha  
  281fdc:	03 e0                	add    %eax,%esp
  281fde:	03 c0                	add    %eax,%eax
  281fe0:	03 c0                	add    %eax,%eax
  281fe2:	03 c0                	add    %eax,%eax
  281fe4:	03 c0                	add    %eax,%eax
  281fe6:	03 c0                	add    %eax,%eax
  281fe8:	07                   	pop    %es
  281fe9:	e0 06                	loopne 281ff1 <ASCII_Table+0x951>
  281feb:	63 0e                	arpl   %cx,(%esi)
  281fed:	3f                   	aas    
  281fee:	1c 3c                	sbb    $0x3c,%al
  281ff0:	f8                   	clc    
  281ff1:	3f                   	aas    
  281ff2:	e0 f7                	loopne 281feb <ASCII_Table+0x94b>
  281ff4:	00 c0                	add    %al,%al
	...
  282002:	fe 0f                	decb   (%edi)
  282004:	fe                   	(bad)  
  282005:	1f                   	pop    %ds
  282006:	06                   	push   %es
  282007:	38 06                	cmp    %al,(%esi)
  282009:	30 06                	xor    %al,(%esi)
  28200b:	30 06                	xor    %al,(%esi)
  28200d:	30 06                	xor    %al,(%esi)
  28200f:	38 fe                	cmp    %bh,%dh
  282011:	1f                   	pop    %ds
  282012:	fe 07                	incb   (%edi)
  282014:	06                   	push   %es
  282015:	03 06                	add    (%esi),%eax
  282017:	06                   	push   %es
  282018:	06                   	push   %es
  282019:	0c 06                	or     $0x6,%al
  28201b:	18 06                	sbb    %al,(%esi)
  28201d:	18 06                	sbb    %al,(%esi)
  28201f:	30 06                	xor    %al,(%esi)
  282021:	30 06                	xor    %al,(%esi)
  282023:	60                   	pusha  
	...
  282030:	00 00                	add    %al,(%eax)
  282032:	e0 03                	loopne 282037 <ASCII_Table+0x997>
  282034:	f8                   	clc    
  282035:	0f 1c 0c 0c          	nopl   (%esp,%ecx,1)
  282039:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  28203c:	0c 00                	or     $0x0,%al
  28203e:	1c 00                	sbb    $0x0,%al
  282040:	f8                   	clc    
  282041:	03 e0                	add    %eax,%esp
  282043:	0f 00 1e             	ltr    (%esi)
  282046:	00 38                	add    %bh,(%eax)
  282048:	06                   	push   %es
  282049:	30 06                	xor    %al,(%esi)
  28204b:	30 0e                	xor    %cl,(%esi)
  28204d:	30 1c 1c             	xor    %bl,(%esp,%ebx,1)
  282050:	f8                   	clc    
  282051:	0f e0 07             	pavgb  (%edi),%mm0
	...
  282060:	00 00                	add    %al,(%eax)
  282062:	fe                   	(bad)  
  282063:	7f fe                	jg     282063 <ASCII_Table+0x9c3>
  282065:	7f 80                	jg     281fe7 <ASCII_Table+0x947>
  282067:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  28206d:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  282073:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  282079:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  28207f:	01 80 01 80 01 00    	add    %eax,0x18001(%eax)
	...
  282091:	00 0c 30             	add    %cl,(%eax,%esi,1)
  282094:	0c 30                	or     $0x30,%al
  282096:	0c 30                	or     $0x30,%al
  282098:	0c 30                	or     $0x30,%al
  28209a:	0c 30                	or     $0x30,%al
  28209c:	0c 30                	or     $0x30,%al
  28209e:	0c 30                	or     $0x30,%al
  2820a0:	0c 30                	or     $0x30,%al
  2820a2:	0c 30                	or     $0x30,%al
  2820a4:	0c 30                	or     $0x30,%al
  2820a6:	0c 30                	or     $0x30,%al
  2820a8:	0c 30                	or     $0x30,%al
  2820aa:	0c 30                	or     $0x30,%al
  2820ac:	0c 30                	or     $0x30,%al
  2820ae:	18 18                	sbb    %bl,(%eax)
  2820b0:	f8                   	clc    
  2820b1:	1f                   	pop    %ds
  2820b2:	e0 07                	loopne 2820bb <ASCII_Table+0xa1b>
	...
  2820c0:	00 00                	add    %al,(%eax)
  2820c2:	03 60 06             	add    0x6(%eax),%esp
  2820c5:	30 06                	xor    %al,(%esi)
  2820c7:	30 06                	xor    %al,(%esi)
  2820c9:	30 0c 18             	xor    %cl,(%eax,%ebx,1)
  2820cc:	0c 18                	or     $0x18,%al
  2820ce:	0c 18                	or     $0x18,%al
  2820d0:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  2820d3:	0c 38                	or     $0x38,%al
  2820d5:	0e                   	push   %cs
  2820d6:	30 06                	xor    %al,(%esi)
  2820d8:	30 06                	xor    %al,(%esi)
  2820da:	70 07                	jo     2820e3 <ASCII_Table+0xa43>
  2820dc:	60                   	pusha  
  2820dd:	03 60 03             	add    0x3(%eax),%esp
  2820e0:	c0 01 c0             	rolb   $0xc0,(%ecx)
  2820e3:	01 00                	add    %eax,(%eax)
	...
  2820f1:	00 03                	add    %al,(%ebx)
  2820f3:	60                   	pusha  
  2820f4:	c3                   	ret    
  2820f5:	61                   	popa   
  2820f6:	c3                   	ret    
  2820f7:	61                   	popa   
  2820f8:	c3                   	ret    
  2820f9:	61                   	popa   
  2820fa:	66 33 66 33          	xor    0x33(%esi),%sp
  2820fe:	66 33 66 33          	xor    0x33(%esi),%sp
  282102:	66 33 66 33          	xor    0x33(%esi),%sp
  282106:	6c                   	insb   (%dx),%es:(%edi)
  282107:	1b 6c 1b 6c          	sbb    0x6c(%ebx,%ebx,1),%ebp
  28210b:	1b 2c 1a             	sbb    (%edx,%ebx,1),%ebp
  28210e:	3c 1e                	cmp    $0x1e,%al
  282110:	38 0e                	cmp    %cl,(%esi)
  282112:	38 0e                	cmp    %cl,(%esi)
	...
  282120:	00 00                	add    %al,(%eax)
  282122:	0f e0 0c 70          	pavgb  (%eax,%esi,2),%mm1
  282126:	18 30                	sbb    %dh,(%eax)
  282128:	30 18                	xor    %bl,(%eax)
  28212a:	70 0c                	jo     282138 <ASCII_Table+0xa98>
  28212c:	60                   	pusha  
  28212d:	0e                   	push   %cs
  28212e:	c0 07 80             	rolb   $0x80,(%edi)
  282131:	03 80 03 c0 03 e0    	add    -0x1ffc3ffd(%eax),%eax
  282137:	06                   	push   %es
  282138:	70 0c                	jo     282146 <ASCII_Table+0xaa6>
  28213a:	30 1c 18             	xor    %bl,(%eax,%ebx,1)
  28213d:	18 0c 30             	sbb    %cl,(%eax,%esi,1)
  282140:	0e                   	push   %cs
  282141:	60                   	pusha  
  282142:	07                   	pop    %es
  282143:	e0 00                	loopne 282145 <ASCII_Table+0xaa5>
	...
  282151:	00 03                	add    %al,(%ebx)
  282153:	c0 06 60             	rolb   $0x60,(%esi)
  282156:	0c 30                	or     $0x30,%al
  282158:	1c 38                	sbb    $0x38,%al
  28215a:	38 18                	cmp    %bl,(%eax)
  28215c:	30 0c 60             	xor    %cl,(%eax,%eiz,2)
  28215f:	06                   	push   %es
  282160:	e0 07                	loopne 282169 <ASCII_Table+0xac9>
  282162:	c0 03 80             	rolb   $0x80,(%ebx)
  282165:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  28216b:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  282171:	01 80 01 00 00 00    	add    %eax,0x1(%eax)
	...
  28217f:	00 00                	add    %al,(%eax)
  282181:	00 fc                	add    %bh,%ah
  282183:	7f fc                	jg     282181 <ASCII_Table+0xae1>
  282185:	7f 00                	jg     282187 <ASCII_Table+0xae7>
  282187:	60                   	pusha  
  282188:	00 30                	add    %dh,(%eax)
  28218a:	00 18                	add    %bl,(%eax)
  28218c:	00 0c 00             	add    %cl,(%eax,%eax,1)
  28218f:	06                   	push   %es
  282190:	00 03                	add    %al,(%ebx)
  282192:	80 01 c0             	addb   $0xc0,(%ecx)
  282195:	00 60 00             	add    %ah,0x0(%eax)
  282198:	30 00                	xor    %al,(%eax)
  28219a:	18 00                	sbb    %al,(%eax)
  28219c:	0c 00                	or     $0x0,%al
  28219e:	06                   	push   %es
  28219f:	00 fe                	add    %bh,%dh
  2821a1:	7f fe                	jg     2821a1 <ASCII_Table+0xb01>
  2821a3:	7f 00                	jg     2821a5 <ASCII_Table+0xb05>
	...
  2821b1:	00 e0                	add    %ah,%al
  2821b3:	03 e0                	add    %eax,%esp
  2821b5:	03 60 00             	add    0x0(%eax),%esp
  2821b8:	60                   	pusha  
  2821b9:	00 60 00             	add    %ah,0x0(%eax)
  2821bc:	60                   	pusha  
  2821bd:	00 60 00             	add    %ah,0x0(%eax)
  2821c0:	60                   	pusha  
  2821c1:	00 60 00             	add    %ah,0x0(%eax)
  2821c4:	60                   	pusha  
  2821c5:	00 60 00             	add    %ah,0x0(%eax)
  2821c8:	60                   	pusha  
  2821c9:	00 60 00             	add    %ah,0x0(%eax)
  2821cc:	60                   	pusha  
  2821cd:	00 60 00             	add    %ah,0x0(%eax)
  2821d0:	60                   	pusha  
  2821d1:	00 60 00             	add    %ah,0x0(%eax)
  2821d4:	60                   	pusha  
  2821d5:	00 60 00             	add    %ah,0x0(%eax)
  2821d8:	60                   	pusha  
  2821d9:	00 e0                	add    %ah,%al
  2821db:	03 e0                	add    %eax,%esp
  2821dd:	03 00                	add    (%eax),%eax
  2821df:	00 00                	add    %al,(%eax)
  2821e1:	00 30                	add    %dh,(%eax)
  2821e3:	00 30                	add    %dh,(%eax)
  2821e5:	00 60 00             	add    %ah,0x0(%eax)
  2821e8:	60                   	pusha  
  2821e9:	00 60 00             	add    %ah,0x0(%eax)
  2821ec:	c0 00 c0             	rolb   $0xc0,(%eax)
  2821ef:	00 c0                	add    %al,%al
  2821f1:	00 c0                	add    %al,%al
  2821f3:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2821f9:	01 00                	add    %eax,(%eax)
  2821fb:	03 00                	add    (%eax),%eax
  2821fd:	03 00                	add    (%eax),%eax
  2821ff:	03 00                	add    (%eax),%eax
  282201:	06                   	push   %es
  282202:	00 06                	add    %al,(%esi)
	...
  282210:	00 00                	add    %al,(%eax)
  282212:	e0 03                	loopne 282217 <ASCII_Table+0xb77>
  282214:	e0 03                	loopne 282219 <ASCII_Table+0xb79>
  282216:	00 03                	add    %al,(%ebx)
  282218:	00 03                	add    %al,(%ebx)
  28221a:	00 03                	add    %al,(%ebx)
  28221c:	00 03                	add    %al,(%ebx)
  28221e:	00 03                	add    %al,(%ebx)
  282220:	00 03                	add    %al,(%ebx)
  282222:	00 03                	add    %al,(%ebx)
  282224:	00 03                	add    %al,(%ebx)
  282226:	00 03                	add    %al,(%ebx)
  282228:	00 03                	add    %al,(%ebx)
  28222a:	00 03                	add    %al,(%ebx)
  28222c:	00 03                	add    %al,(%ebx)
  28222e:	00 03                	add    %al,(%ebx)
  282230:	00 03                	add    %al,(%ebx)
  282232:	00 03                	add    %al,(%ebx)
  282234:	00 03                	add    %al,(%ebx)
  282236:	00 03                	add    %al,(%ebx)
  282238:	00 03                	add    %al,(%ebx)
  28223a:	e0 03                	loopne 28223f <ASCII_Table+0xb9f>
  28223c:	e0 03                	loopne 282241 <ASCII_Table+0xba1>
  28223e:	00 00                	add    %al,(%eax)
  282240:	00 00                	add    %al,(%eax)
  282242:	00 00                	add    %al,(%eax)
  282244:	c0 01 c0             	rolb   $0xc0,(%ecx)
  282247:	01 60 03             	add    %esp,0x3(%eax)
  28224a:	60                   	pusha  
  28224b:	03 60 03             	add    0x3(%eax),%esp
  28224e:	30 06                	xor    %al,(%esi)
  282250:	30 06                	xor    %al,(%esi)
  282252:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  282255:	0c 00                	or     $0x0,%al
	...
  28228f:	00 00                	add    %al,(%eax)
  282291:	00 ff                	add    %bh,%bh
  282293:	ff                   	(bad)  
  282294:	ff                   	(bad)  
  282295:	ff 00                	incl   (%eax)
	...
  28229f:	00 00                	add    %al,(%eax)
  2822a1:	00 0c 00             	add    %cl,(%eax,%eax,1)
  2822a4:	0c 00                	or     $0x0,%al
  2822a6:	0c 00                	or     $0x0,%al
  2822a8:	0c 00                	or     $0x0,%al
  2822aa:	0c 00                	or     $0x0,%al
  2822ac:	0c 00                	or     $0x0,%al
	...
  2822da:	00 00                	add    %al,(%eax)
  2822dc:	f0 03 f8             	lock add %eax,%edi
  2822df:	07                   	pop    %es
  2822e0:	1c 0c                	sbb    $0xc,%al
  2822e2:	0c 0c                	or     $0xc,%al
  2822e4:	00 0f                	add    %cl,(%edi)
  2822e6:	f0 0f f8 0c 0c       	lock psubb (%esp,%ecx,1),%mm1
  2822eb:	0c 0c                	or     $0xc,%al
  2822ed:	0c 1c                	or     $0x1c,%al
  2822ef:	0f f8 0f             	psubb  (%edi),%mm1
  2822f2:	f0 18 00             	lock sbb %al,(%eax)
	...
  282301:	00 18                	add    %bl,(%eax)
  282303:	00 18                	add    %bl,(%eax)
  282305:	00 18                	add    %bl,(%eax)
  282307:	00 18                	add    %bl,(%eax)
  282309:	00 18                	add    %bl,(%eax)
  28230b:	00 d8                	add    %bl,%al
  28230d:	03 f8                	add    %eax,%edi
  28230f:	0f 38 0c             	(bad)  
  282312:	18 18                	sbb    %bl,(%eax)
  282314:	18 18                	sbb    %bl,(%eax)
  282316:	18 18                	sbb    %bl,(%eax)
  282318:	18 18                	sbb    %bl,(%eax)
  28231a:	18 18                	sbb    %bl,(%eax)
  28231c:	18 18                	sbb    %bl,(%eax)
  28231e:	38 0c f8             	cmp    %cl,(%eax,%edi,8)
  282321:	0f d8 03             	psubusb (%ebx),%mm0
	...
  28233c:	c0 03 f0             	rolb   $0xf0,(%ebx)
  28233f:	07                   	pop    %es
  282340:	30 0e                	xor    %cl,(%esi)
  282342:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  282345:	00 18                	add    %bl,(%eax)
  282347:	00 18                	add    %bl,(%eax)
  282349:	00 18                	add    %bl,(%eax)
  28234b:	00 18                	add    %bl,(%eax)
  28234d:	0c 30                	or     $0x30,%al
  28234f:	0e                   	push   %cs
  282350:	f0 07                	lock pop %es
  282352:	c0 03 00             	rolb   $0x0,(%ebx)
	...
  282361:	00 00                	add    %al,(%eax)
  282363:	18 00                	sbb    %al,(%eax)
  282365:	18 00                	sbb    %al,(%eax)
  282367:	18 00                	sbb    %al,(%eax)
  282369:	18 00                	sbb    %al,(%eax)
  28236b:	18 c0                	sbb    %al,%al
  28236d:	1b f0                	sbb    %eax,%esi
  28236f:	1f                   	pop    %ds
  282370:	30 1c 18             	xor    %bl,(%eax,%ebx,1)
  282373:	18 18                	sbb    %bl,(%eax)
  282375:	18 18                	sbb    %bl,(%eax)
  282377:	18 18                	sbb    %bl,(%eax)
  282379:	18 18                	sbb    %bl,(%eax)
  28237b:	18 18                	sbb    %bl,(%eax)
  28237d:	18 30                	sbb    %dh,(%eax)
  28237f:	1c f0                	sbb    $0xf0,%al
  282381:	1f                   	pop    %ds
  282382:	c0 1b 00             	rcrb   $0x0,(%ebx)
	...
  282399:	00 00                	add    %al,(%eax)
  28239b:	00 c0                	add    %al,%al
  28239d:	03 f0                	add    %eax,%esi
  28239f:	0f 30                	wrmsr  
  2823a1:	0c 18                	or     $0x18,%al
  2823a3:	18 f8                	sbb    %bh,%al
  2823a5:	1f                   	pop    %ds
  2823a6:	f8                   	clc    
  2823a7:	1f                   	pop    %ds
  2823a8:	18 00                	sbb    %al,(%eax)
  2823aa:	18 00                	sbb    %al,(%eax)
  2823ac:	38 18                	cmp    %bl,(%eax)
  2823ae:	30 1c f0             	xor    %bl,(%eax,%esi,8)
  2823b1:	0f c0 07             	xadd   %al,(%edi)
	...
  2823c0:	00 00                	add    %al,(%eax)
  2823c2:	80 0f c0             	orb    $0xc0,(%edi)
  2823c5:	0f c0 00             	xadd   %al,(%eax)
  2823c8:	c0 00 c0             	rolb   $0xc0,(%eax)
  2823cb:	00 f0                	add    %dh,%al
  2823cd:	07                   	pop    %es
  2823ce:	f0 07                	lock pop %es
  2823d0:	c0 00 c0             	rolb   $0xc0,(%eax)
  2823d3:	00 c0                	add    %al,%al
  2823d5:	00 c0                	add    %al,%al
  2823d7:	00 c0                	add    %al,%al
  2823d9:	00 c0                	add    %al,%al
  2823db:	00 c0                	add    %al,%al
  2823dd:	00 c0                	add    %al,%al
  2823df:	00 c0                	add    %al,%al
  2823e1:	00 c0                	add    %al,%al
	...
  2823fb:	00 e0                	add    %ah,%al
  2823fd:	0d f8 0f 18 0e       	or     $0xe180ff8,%eax
  282402:	0c 0c                	or     $0xc,%al
  282404:	0c 0c                	or     $0xc,%al
  282406:	0c 0c                	or     $0xc,%al
  282408:	0c 0c                	or     $0xc,%al
  28240a:	0c 0c                	or     $0xc,%al
  28240c:	0c 0c                	or     $0xc,%al
  28240e:	18 0e                	sbb    %cl,(%esi)
  282410:	f8                   	clc    
  282411:	0f e0 0d 00 0c 0c 0c 	pavgb  0xc0c0c00,%mm1
  282418:	1c 06                	sbb    $0x6,%al
  28241a:	f8                   	clc    
  28241b:	07                   	pop    %es
  28241c:	f0 01 00             	lock add %eax,(%eax)
  28241f:	00 00                	add    %al,(%eax)
  282421:	00 18                	add    %bl,(%eax)
  282423:	00 18                	add    %bl,(%eax)
  282425:	00 18                	add    %bl,(%eax)
  282427:	00 18                	add    %bl,(%eax)
  282429:	00 18                	add    %bl,(%eax)
  28242b:	00 d8                	add    %bl,%al
  28242d:	07                   	pop    %es
  28242e:	f8                   	clc    
  28242f:	0f 38 1c 18          	pabsb  (%eax),%mm3
  282433:	18 18                	sbb    %bl,(%eax)
  282435:	18 18                	sbb    %bl,(%eax)
  282437:	18 18                	sbb    %bl,(%eax)
  282439:	18 18                	sbb    %bl,(%eax)
  28243b:	18 18                	sbb    %bl,(%eax)
  28243d:	18 18                	sbb    %bl,(%eax)
  28243f:	18 18                	sbb    %bl,(%eax)
  282441:	18 18                	sbb    %bl,(%eax)
  282443:	18 00                	sbb    %al,(%eax)
	...
  282451:	00 c0                	add    %al,%al
  282453:	00 c0                	add    %al,%al
  282455:	00 00                	add    %al,(%eax)
  282457:	00 00                	add    %al,(%eax)
  282459:	00 00                	add    %al,(%eax)
  28245b:	00 c0                	add    %al,%al
  28245d:	00 c0                	add    %al,%al
  28245f:	00 c0                	add    %al,%al
  282461:	00 c0                	add    %al,%al
  282463:	00 c0                	add    %al,%al
  282465:	00 c0                	add    %al,%al
  282467:	00 c0                	add    %al,%al
  282469:	00 c0                	add    %al,%al
  28246b:	00 c0                	add    %al,%al
  28246d:	00 c0                	add    %al,%al
  28246f:	00 c0                	add    %al,%al
  282471:	00 c0                	add    %al,%al
	...
  28247f:	00 00                	add    %al,(%eax)
  282481:	00 c0                	add    %al,%al
  282483:	00 c0                	add    %al,%al
  282485:	00 00                	add    %al,(%eax)
  282487:	00 00                	add    %al,(%eax)
  282489:	00 00                	add    %al,(%eax)
  28248b:	00 c0                	add    %al,%al
  28248d:	00 c0                	add    %al,%al
  28248f:	00 c0                	add    %al,%al
  282491:	00 c0                	add    %al,%al
  282493:	00 c0                	add    %al,%al
  282495:	00 c0                	add    %al,%al
  282497:	00 c0                	add    %al,%al
  282499:	00 c0                	add    %al,%al
  28249b:	00 c0                	add    %al,%al
  28249d:	00 c0                	add    %al,%al
  28249f:	00 c0                	add    %al,%al
  2824a1:	00 c0                	add    %al,%al
  2824a3:	00 c0                	add    %al,%al
  2824a5:	00 c0                	add    %al,%al
  2824a7:	00 c0                	add    %al,%al
  2824a9:	00 f8                	add    %bh,%al
  2824ab:	00 78 00             	add    %bh,0x0(%eax)
  2824ae:	00 00                	add    %al,(%eax)
  2824b0:	00 00                	add    %al,(%eax)
  2824b2:	0c 00                	or     $0x0,%al
  2824b4:	0c 00                	or     $0x0,%al
  2824b6:	0c 00                	or     $0x0,%al
  2824b8:	0c 00                	or     $0x0,%al
  2824ba:	0c 00                	or     $0x0,%al
  2824bc:	0c 0c                	or     $0xc,%al
  2824be:	0c 06                	or     $0x6,%al
  2824c0:	0c 03                	or     $0x3,%al
  2824c2:	8c 01                	mov    %es,(%ecx)
  2824c4:	cc                   	int3   
  2824c5:	00 6c 00 fc          	add    %ch,-0x4(%eax,%eax,1)
  2824c9:	00 9c 01 8c 03 0c 03 	add    %bl,0x30c038c(%ecx,%eax,1)
  2824d0:	0c 06                	or     $0x6,%al
  2824d2:	0c 0c                	or     $0xc,%al
	...
  2824e0:	00 00                	add    %al,(%eax)
  2824e2:	c0 00 c0             	rolb   $0xc0,(%eax)
  2824e5:	00 c0                	add    %al,%al
  2824e7:	00 c0                	add    %al,%al
  2824e9:	00 c0                	add    %al,%al
  2824eb:	00 c0                	add    %al,%al
  2824ed:	00 c0                	add    %al,%al
  2824ef:	00 c0                	add    %al,%al
  2824f1:	00 c0                	add    %al,%al
  2824f3:	00 c0                	add    %al,%al
  2824f5:	00 c0                	add    %al,%al
  2824f7:	00 c0                	add    %al,%al
  2824f9:	00 c0                	add    %al,%al
  2824fb:	00 c0                	add    %al,%al
  2824fd:	00 c0                	add    %al,%al
  2824ff:	00 c0                	add    %al,%al
  282501:	00 c0                	add    %al,%al
	...
  28251b:	00 7c 3c ff          	add    %bh,-0x1(%esp,%edi,1)
  28251f:	7e c7                	jle    2824e8 <ASCII_Table+0xe48>
  282521:	e3 83                	jecxz  2824a6 <ASCII_Table+0xe06>
  282523:	c1 83 c1 83 c1 83 c1 	roll   $0xc1,-0x7c3e7c3f(%ebx)
  28252a:	83 c1 83             	add    $0xffffff83,%ecx
  28252d:	c1 83 c1 83 c1 83 c1 	roll   $0xc1,-0x7c3e7c3f(%ebx)
	...
  28254c:	98                   	cwtl   
  28254d:	07                   	pop    %es
  28254e:	f8                   	clc    
  28254f:	0f 38 1c 18          	pabsb  (%eax),%mm3
  282553:	18 18                	sbb    %bl,(%eax)
  282555:	18 18                	sbb    %bl,(%eax)
  282557:	18 18                	sbb    %bl,(%eax)
  282559:	18 18                	sbb    %bl,(%eax)
  28255b:	18 18                	sbb    %bl,(%eax)
  28255d:	18 18                	sbb    %bl,(%eax)
  28255f:	18 18                	sbb    %bl,(%eax)
  282561:	18 18                	sbb    %bl,(%eax)
  282563:	18 00                	sbb    %al,(%eax)
	...
  282579:	00 00                	add    %al,(%eax)
  28257b:	00 c0                	add    %al,%al
  28257d:	03 f0                	add    %eax,%esi
  28257f:	0f 30                	wrmsr  
  282581:	0c 18                	or     $0x18,%al
  282583:	18 18                	sbb    %bl,(%eax)
  282585:	18 18                	sbb    %bl,(%eax)
  282587:	18 18                	sbb    %bl,(%eax)
  282589:	18 18                	sbb    %bl,(%eax)
  28258b:	18 18                	sbb    %bl,(%eax)
  28258d:	18 30                	sbb    %dh,(%eax)
  28258f:	0c f0                	or     $0xf0,%al
  282591:	0f c0 03             	xadd   %al,(%ebx)
	...
  2825ac:	d8 03                	fadds  (%ebx)
  2825ae:	f8                   	clc    
  2825af:	0f 38 0c             	(bad)  
  2825b2:	18 18                	sbb    %bl,(%eax)
  2825b4:	18 18                	sbb    %bl,(%eax)
  2825b6:	18 18                	sbb    %bl,(%eax)
  2825b8:	18 18                	sbb    %bl,(%eax)
  2825ba:	18 18                	sbb    %bl,(%eax)
  2825bc:	18 18                	sbb    %bl,(%eax)
  2825be:	38 0c f8             	cmp    %cl,(%eax,%edi,8)
  2825c1:	0f d8 03             	psubusb (%ebx),%mm0
  2825c4:	18 00                	sbb    %al,(%eax)
  2825c6:	18 00                	sbb    %al,(%eax)
  2825c8:	18 00                	sbb    %al,(%eax)
  2825ca:	18 00                	sbb    %al,(%eax)
  2825cc:	18 00                	sbb    %al,(%eax)
	...
  2825da:	00 00                	add    %al,(%eax)
  2825dc:	c0 1b f0             	rcrb   $0xf0,(%ebx)
  2825df:	1f                   	pop    %ds
  2825e0:	30 1c 18             	xor    %bl,(%eax,%ebx,1)
  2825e3:	18 18                	sbb    %bl,(%eax)
  2825e5:	18 18                	sbb    %bl,(%eax)
  2825e7:	18 18                	sbb    %bl,(%eax)
  2825e9:	18 18                	sbb    %bl,(%eax)
  2825eb:	18 18                	sbb    %bl,(%eax)
  2825ed:	18 30                	sbb    %dh,(%eax)
  2825ef:	1c f0                	sbb    $0xf0,%al
  2825f1:	1f                   	pop    %ds
  2825f2:	c0 1b 00             	rcrb   $0x0,(%ebx)
  2825f5:	18 00                	sbb    %al,(%eax)
  2825f7:	18 00                	sbb    %al,(%eax)
  2825f9:	18 00                	sbb    %al,(%eax)
  2825fb:	18 00                	sbb    %al,(%eax)
  2825fd:	18 00                	sbb    %al,(%eax)
	...
  28260b:	00 b0 07 f0 03 70    	add    %dh,0x7003f007(%eax)
  282611:	00 30                	add    %dh,(%eax)
  282613:	00 30                	add    %dh,(%eax)
  282615:	00 30                	add    %dh,(%eax)
  282617:	00 30                	add    %dh,(%eax)
  282619:	00 30                	add    %dh,(%eax)
  28261b:	00 30                	add    %dh,(%eax)
  28261d:	00 30                	add    %dh,(%eax)
  28261f:	00 30                	add    %dh,(%eax)
  282621:	00 30                	add    %dh,(%eax)
	...
  28263b:	00 e0                	add    %ah,%al
  28263d:	03 f0                	add    %eax,%esi
  28263f:	03 38                	add    (%eax),%edi
  282641:	0e                   	push   %cs
  282642:	18 0c 38             	sbb    %cl,(%eax,%edi,1)
  282645:	00 f0                	add    %dh,%al
  282647:	03 c0                	add    %eax,%eax
  282649:	07                   	pop    %es
  28264a:	00 0c 18             	add    %cl,(%eax,%ebx,1)
  28264d:	0c 38                	or     $0x38,%al
  28264f:	0e                   	push   %cs
  282650:	f0 07                	lock pop %es
  282652:	e0 03                	loopne 282657 <ASCII_Table+0xfb7>
	...
  282664:	80 00 c0             	addb   $0xc0,(%eax)
  282667:	00 c0                	add    %al,%al
  282669:	00 c0                	add    %al,%al
  28266b:	00 f0                	add    %dh,%al
  28266d:	07                   	pop    %es
  28266e:	f0 07                	lock pop %es
  282670:	c0 00 c0             	rolb   $0xc0,(%eax)
  282673:	00 c0                	add    %al,%al
  282675:	00 c0                	add    %al,%al
  282677:	00 c0                	add    %al,%al
  282679:	00 c0                	add    %al,%al
  28267b:	00 c0                	add    %al,%al
  28267d:	00 c0                	add    %al,%al
  28267f:	00 c0                	add    %al,%al
  282681:	07                   	pop    %es
  282682:	80 07 00             	addb   $0x0,(%edi)
	...
  282699:	00 00                	add    %al,(%eax)
  28269b:	00 18                	add    %bl,(%eax)
  28269d:	18 18                	sbb    %bl,(%eax)
  28269f:	18 18                	sbb    %bl,(%eax)
  2826a1:	18 18                	sbb    %bl,(%eax)
  2826a3:	18 18                	sbb    %bl,(%eax)
  2826a5:	18 18                	sbb    %bl,(%eax)
  2826a7:	18 18                	sbb    %bl,(%eax)
  2826a9:	18 18                	sbb    %bl,(%eax)
  2826ab:	18 18                	sbb    %bl,(%eax)
  2826ad:	18 38                	sbb    %bh,(%eax)
  2826af:	1c f0                	sbb    $0xf0,%al
  2826b1:	1f                   	pop    %ds
  2826b2:	e0 19                	loopne 2826cd <ASCII_Table+0x102d>
	...
  2826cc:	0c 18                	or     $0x18,%al
  2826ce:	18 0c 18             	sbb    %cl,(%eax,%ebx,1)
  2826d1:	0c 18                	or     $0x18,%al
  2826d3:	0c 30                	or     $0x30,%al
  2826d5:	06                   	push   %es
  2826d6:	30 06                	xor    %al,(%esi)
  2826d8:	30 06                	xor    %al,(%esi)
  2826da:	60                   	pusha  
  2826db:	03 60 03             	add    0x3(%eax),%esp
  2826de:	60                   	pusha  
  2826df:	03 c0                	add    %eax,%eax
  2826e1:	01 c0                	add    %eax,%eax
  2826e3:	01 00                	add    %eax,(%eax)
	...
  2826f9:	00 00                	add    %al,(%eax)
  2826fb:	00 c1                	add    %al,%cl
  2826fd:	41                   	inc    %ecx
  2826fe:	c1 41 c3 61          	roll   $0x61,-0x3d(%ecx)
  282702:	63 63 63             	arpl   %sp,0x63(%ebx)
  282705:	63 63 63             	arpl   %sp,0x63(%ebx)
  282708:	36                   	ss
  282709:	36                   	ss
  28270a:	36                   	ss
  28270b:	36                   	ss
  28270c:	36                   	ss
  28270d:	36                   	ss
  28270e:	1c 1c                	sbb    $0x1c,%al
  282710:	1c 1c                	sbb    $0x1c,%al
  282712:	1c 1c                	sbb    $0x1c,%al
	...
  28272c:	1c 38                	sbb    $0x38,%al
  28272e:	38 1c 30             	cmp    %bl,(%eax,%esi,1)
  282731:	0c 60                	or     $0x60,%al
  282733:	06                   	push   %es
  282734:	60                   	pusha  
  282735:	03 60 03             	add    0x3(%eax),%esp
  282738:	60                   	pusha  
  282739:	03 60 03             	add    0x3(%eax),%esp
  28273c:	60                   	pusha  
  28273d:	06                   	push   %es
  28273e:	30 0c 38             	xor    %cl,(%eax,%edi,1)
  282741:	1c 1c                	sbb    $0x1c,%al
  282743:	38 00                	cmp    %al,(%eax)
	...
  282759:	00 00                	add    %al,(%eax)
  28275b:	00 18                	add    %bl,(%eax)
  28275d:	30 30                	xor    %dh,(%eax)
  28275f:	18 30                	sbb    %dh,(%eax)
  282761:	18 70 18             	sbb    %dh,0x18(%eax)
  282764:	60                   	pusha  
  282765:	0c 60                	or     $0x60,%al
  282767:	0c e0                	or     $0xe0,%al
  282769:	0c c0                	or     $0xc0,%al
  28276b:	06                   	push   %es
  28276c:	c0 06 80             	rolb   $0x80,(%esi)
  28276f:	03 80 03 80 03 80    	add    -0x7ffc7ffd(%eax),%eax
  282775:	01 80 01 c0 01 f0    	add    %eax,-0xffe3fff(%eax)
  28277b:	00 70 00             	add    %dh,0x0(%eax)
	...
  28278a:	00 00                	add    %al,(%eax)
  28278c:	fc                   	cld    
  28278d:	1f                   	pop    %ds
  28278e:	fc                   	cld    
  28278f:	1f                   	pop    %ds
  282790:	00 0c 00             	add    %cl,(%eax,%eax,1)
  282793:	06                   	push   %es
  282794:	00 03                	add    %al,(%ebx)
  282796:	80 01 c0             	addb   $0xc0,(%ecx)
  282799:	00 60 00             	add    %ah,0x0(%eax)
  28279c:	30 00                	xor    %al,(%eax)
  28279e:	18 00                	sbb    %al,(%eax)
  2827a0:	fc                   	cld    
  2827a1:	1f                   	pop    %ds
  2827a2:	fc                   	cld    
  2827a3:	1f                   	pop    %ds
	...
  2827b0:	00 00                	add    %al,(%eax)
  2827b2:	00 03                	add    %al,(%ebx)
  2827b4:	80 01 c0             	addb   $0xc0,(%ecx)
  2827b7:	00 c0                	add    %al,%al
  2827b9:	00 c0                	add    %al,%al
  2827bb:	00 c0                	add    %al,%al
  2827bd:	00 c0                	add    %al,%al
  2827bf:	00 c0                	add    %al,%al
  2827c1:	00 60 00             	add    %ah,0x0(%eax)
  2827c4:	60                   	pusha  
  2827c5:	00 30                	add    %dh,(%eax)
  2827c7:	00 60 00             	add    %ah,0x0(%eax)
  2827ca:	40                   	inc    %eax
  2827cb:	00 c0                	add    %al,%al
  2827cd:	00 c0                	add    %al,%al
  2827cf:	00 c0                	add    %al,%al
  2827d1:	00 c0                	add    %al,%al
  2827d3:	00 c0                	add    %al,%al
  2827d5:	00 c0                	add    %al,%al
  2827d7:	00 80 01 00 03 00    	add    %al,0x30001(%eax)
  2827dd:	00 00                	add    %al,(%eax)
  2827df:	00 00                	add    %al,(%eax)
  2827e1:	00 80 01 80 01 80    	add    %al,-0x7ffe7fff(%eax)
  2827e7:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2827ed:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2827f3:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2827f9:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  2827ff:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  282805:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  28280b:	01 80 01 00 00 00    	add    %eax,0x1(%eax)
  282811:	00 60 00             	add    %ah,0x0(%eax)
  282814:	c0 00 c0             	rolb   $0xc0,(%eax)
  282817:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  28281d:	01 80 01 80 01 00    	add    %eax,0x18001(%eax)
  282823:	03 00                	add    (%eax),%eax
  282825:	03 00                	add    (%eax),%eax
  282827:	06                   	push   %es
  282828:	00 03                	add    %al,(%ebx)
  28282a:	00 01                	add    %al,(%ecx)
  28282c:	80 01 80             	addb   $0x80,(%ecx)
  28282f:	01 80 01 80 01 80    	add    %eax,-0x7ffe7fff(%eax)
  282835:	01 80 01 c0 00 60    	add    %eax,0x6000c001(%eax)
	...
  28284f:	00 f0                	add    %dh,%al
  282851:	10 f8                	adc    %bh,%al
  282853:	1f                   	pop    %ds
  282854:	08 0f                	or     %cl,(%edi)
	...
  282872:	00 ff                	add    %bh,%bh
  282874:	00 00                	add    %al,(%eax)
  282876:	00 ff                	add    %bh,%bh
  282878:	00 ff                	add    %bh,%bh
  28287a:	ff 00                	incl   (%eax)
  28287c:	00 00                	add    %al,(%eax)
  28287e:	ff                   	(bad)  
  28287f:	ff 00                	incl   (%eax)
  282881:	ff 00                	incl   (%eax)
  282883:	ff                   	(bad)  
  282884:	ff                   	(bad)  
  282885:	ff                   	(bad)  
  282886:	ff                   	(bad)  
  282887:	ff c6                	inc    %esi
  282889:	c6 c6 84             	mov    $0x84,%dh
  28288c:	00 00                	add    %al,(%eax)
  28288e:	00 84 00 84 84 00 00 	add    %al,0x8484(%eax,%eax,1)
  282895:	00 84 84 00 84 00 84 	add    %al,-0x7bff7c00(%esp,%eax,4)
  28289c:	84 84 84 84 2a 2a 2a 	test   %al,0x2a2a2a84(%esp,%eax,4)

002828a0 <cursor>:
  2828a0:	2a 2a                	sub    (%edx),%ch
  2828a2:	2a 2a                	sub    (%edx),%ch
  2828a4:	2a 2a                	sub    (%edx),%ch
  2828a6:	2a 2a                	sub    (%edx),%ch
  2828a8:	2a 2a                	sub    (%edx),%ch
  2828aa:	2a 2a                	sub    (%edx),%ch
  2828ac:	2a 2a                	sub    (%edx),%ch
  2828ae:	2e 2e 2a 4f 4f       	cs sub %cs:0x4f(%edi),%cl
  2828b3:	4f                   	dec    %edi
  2828b4:	4f                   	dec    %edi
  2828b5:	4f                   	dec    %edi
  2828b6:	4f                   	dec    %edi
  2828b7:	4f                   	dec    %edi
  2828b8:	4f                   	dec    %edi
  2828b9:	4f                   	dec    %edi
  2828ba:	4f                   	dec    %edi
  2828bb:	4f                   	dec    %edi
  2828bc:	2a 2e                	sub    (%esi),%ch
  2828be:	2e 2e 2a 4f 4f       	cs sub %cs:0x4f(%edi),%cl
  2828c3:	4f                   	dec    %edi
  2828c4:	4f                   	dec    %edi
  2828c5:	4f                   	dec    %edi
  2828c6:	4f                   	dec    %edi
  2828c7:	4f                   	dec    %edi
  2828c8:	4f                   	dec    %edi
  2828c9:	4f                   	dec    %edi
  2828ca:	4f                   	dec    %edi
  2828cb:	2a 2e                	sub    (%esi),%ch
  2828cd:	2e 2e 2e 2a 4f 4f    	cs cs sub %cs:0x4f(%edi),%cl
  2828d3:	4f                   	dec    %edi
  2828d4:	4f                   	dec    %edi
  2828d5:	4f                   	dec    %edi
  2828d6:	4f                   	dec    %edi
  2828d7:	4f                   	dec    %edi
  2828d8:	4f                   	dec    %edi
  2828d9:	4f                   	dec    %edi
  2828da:	2a 2e                	sub    (%esi),%ch
  2828dc:	2e 2e 2e 2e 2a 4f 4f 	cs cs cs sub %cs:0x4f(%edi),%cl
  2828e3:	4f                   	dec    %edi
  2828e4:	4f                   	dec    %edi
  2828e5:	4f                   	dec    %edi
  2828e6:	4f                   	dec    %edi
  2828e7:	4f                   	dec    %edi
  2828e8:	4f                   	dec    %edi
  2828e9:	2a 2e                	sub    (%esi),%ch
  2828eb:	2e 2e 2e 2e 2e 2a 4f 	cs cs cs cs sub %cs:0x4f(%edi),%cl
  2828f2:	4f 
  2828f3:	4f                   	dec    %edi
  2828f4:	4f                   	dec    %edi
  2828f5:	4f                   	dec    %edi
  2828f6:	4f                   	dec    %edi
  2828f7:	4f                   	dec    %edi
  2828f8:	2a 2e                	sub    (%esi),%ch
  2828fa:	2e 2e 2e 2e 2e 2e 2a 	cs cs cs cs cs sub %cs:0x4f(%edi),%cl
  282901:	4f 4f 
  282903:	4f                   	dec    %edi
  282904:	4f                   	dec    %edi
  282905:	4f                   	dec    %edi
  282906:	4f                   	dec    %edi
  282907:	4f                   	dec    %edi
  282908:	2a 2e                	sub    (%esi),%ch
  28290a:	2e 2e 2e 2e 2e 2e 2a 	cs cs cs cs cs sub %cs:0x4f(%edi),%cl
  282911:	4f 4f 
  282913:	4f                   	dec    %edi
  282914:	4f                   	dec    %edi
  282915:	4f                   	dec    %edi
  282916:	4f                   	dec    %edi
  282917:	4f                   	dec    %edi
  282918:	4f                   	dec    %edi
  282919:	2a 2e                	sub    (%esi),%ch
  28291b:	2e 2e 2e 2e 2e 2a 4f 	cs cs cs cs sub %cs:0x4f(%edi),%cl
  282922:	4f 
  282923:	4f                   	dec    %edi
  282924:	4f                   	dec    %edi
  282925:	2a 2a                	sub    (%edx),%ch
  282927:	4f                   	dec    %edi
  282928:	4f                   	dec    %edi
  282929:	4f                   	dec    %edi
  28292a:	2a 2e                	sub    (%esi),%ch
  28292c:	2e 2e 2e 2e 2a 4f 4f 	cs cs cs sub %cs:0x4f(%edi),%cl
  282933:	4f                   	dec    %edi
  282934:	2a 2e                	sub    (%esi),%ch
  282936:	2e 2a 4f 4f          	sub    %cs:0x4f(%edi),%cl
  28293a:	4f                   	dec    %edi
  28293b:	2a 2e                	sub    (%esi),%ch
  28293d:	2e 2e 2e 2a 4f 4f    	cs cs sub %cs:0x4f(%edi),%cl
  282943:	2a 2e                	sub    (%esi),%ch
  282945:	2e 2e 2e 2a 4f 4f    	cs cs sub %cs:0x4f(%edi),%cl
  28294b:	4f                   	dec    %edi
  28294c:	2a 2e                	sub    (%esi),%ch
  28294e:	2e 2e 2a 4f 2a       	cs sub %cs:0x2a(%edi),%cl
  282953:	2e 2e 2e 2e 2e 2e 2a 	cs cs cs cs cs sub %cs:0x4f(%edi),%cl
  28295a:	4f 4f 
  28295c:	4f                   	dec    %edi
  28295d:	2a 2e                	sub    (%esi),%ch
  28295f:	2e 2a 2a             	sub    %cs:(%edx),%ch
  282962:	2e 2e 2e 2e 2e 2e 2e 	cs cs cs cs cs cs cs sub %cs:0x4f(%edi),%cl
  282969:	2e 2a 4f 4f 
  28296d:	4f                   	dec    %edi
  28296e:	2a 2e                	sub    (%esi),%ch
  282970:	2a 2e                	sub    (%esi),%ch
  282972:	2e 2e 2e 2e 2e 2e 2e 	cs cs cs cs cs cs cs cs sub %cs:0x4f(%edi),%cl
  282979:	2e 2e 2a 4f 4f 
  28297e:	4f                   	dec    %edi
  28297f:	2a 2e                	sub    (%esi),%ch
  282981:	2e 2e 2e 2e 2e 2e 2e 	cs cs cs cs cs cs cs cs cs cs sub %cs:0x4f(%edi),%cl
  282988:	2e 2e 2e 2e 2a 4f 4f 
  28298f:	2a 2e                	sub    (%esi),%ch
  282991:	2e 2e 2e 2e 2e 2e 2e 	cs cs cs cs cs cs cs cs cs cs cs sub %cs:(%edx),%ch
  282998:	2e 2e 2e 2e 2e 2a 2a 
  28299f:	2a                   	.byte 0x2a

Disassembly of section .rodata.str1.1:

002829a0 <.rodata.str1.1>:
  2829a0:	4d                   	dec    %ebp
  2829a1:	45                   	inc    %ebp
  2829a2:	4d                   	dec    %ebp
  2829a3:	20 54 45 53          	and    %dl,0x53(%ebp,%eax,2)
  2829a7:	54                   	push   %esp
  2829a8:	2e 2e 2e 00 4d 45    	cs cs add %cl,%cs:0x45(%ebp)
  2829ae:	4d                   	dec    %ebp
  2829af:	3a 20                	cmp    (%eax),%ah
  2829b1:	25 64 4d 00 25       	and    $0x25004d64,%eax
  2829b6:	78 25                	js     2829dd <cursor+0x13d>
  2829b8:	78 25                	js     2829df <cursor+0x13f>
  2829ba:	78 00                	js     2829bc <cursor+0x11c>
  2829bc:	44                   	inc    %esp
  2829bd:	65 62 75 67          	bound  %esi,%gs:0x67(%ebp)
  2829c1:	3a 76 61             	cmp    0x61(%esi),%dh
  2829c4:	72 3d                	jb     282a03 <cursor+0x163>
  2829c6:	25                   	.byte 0x25
  2829c7:	78 00                	js     2829c9 <cursor+0x129>

Disassembly of section .eh_frame:

002829cc <.eh_frame>:
  2829cc:	14 00                	adc    $0x0,%al
  2829ce:	00 00                	add    %al,(%eax)
  2829d0:	00 00                	add    %al,(%eax)
  2829d2:	00 00                	add    %al,(%eax)
  2829d4:	01 7a 52             	add    %edi,0x52(%edx)
  2829d7:	00 01                	add    %al,(%ecx)
  2829d9:	7c 08                	jl     2829e3 <cursor+0x143>
  2829db:	01 1b                	add    %ebx,(%ebx)
  2829dd:	0c 04                	or     $0x4,%al
  2829df:	04 88                	add    $0x88,%al
  2829e1:	01 00                	add    %eax,(%eax)
  2829e3:	00 1c 00             	add    %bl,(%eax,%eax,1)
  2829e6:	00 00                	add    %al,(%eax)
  2829e8:	1c 00                	sbb    $0x0,%al
  2829ea:	00 00                	add    %al,(%eax)
  2829ec:	14 d6                	adc    $0xd6,%al
  2829ee:	ff                   	(bad)  
  2829ef:	ff af 02 00 00 00    	ljmp   *0x2(%edi)
  2829f5:	41                   	inc    %ecx
  2829f6:	0e                   	push   %cs
  2829f7:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  2829fd:	49                   	dec    %ecx
  2829fe:	87 03                	xchg   %eax,(%ebx)
  282a00:	86 04 83             	xchg   %al,(%ebx,%eax,4)
  282a03:	05 1c 00 00 00       	add    $0x1c,%eax
  282a08:	3c 00                	cmp    $0x0,%al
  282a0a:	00 00                	add    %al,(%eax)
  282a0c:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  282a0d:	d8 ff                	fdivr  %st(7),%st
  282a0f:	ff 17                	call   *(%edi)
  282a11:	00 00                	add    %al,(%eax)
  282a13:	00 00                	add    %al,(%eax)
  282a15:	41                   	inc    %ecx
  282a16:	0e                   	push   %cs
  282a17:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282a1d:	4e                   	dec    %esi
  282a1e:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282a21:	04 00                	add    $0x0,%al
  282a23:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282a26:	00 00                	add    %al,(%eax)
  282a28:	5c                   	pop    %esp
  282a29:	00 00                	add    %al,(%eax)
  282a2b:	00 9b d8 ff ff 14    	add    %bl,0x14ffffd8(%ebx)
  282a31:	00 00                	add    %al,(%eax)
  282a33:	00 00                	add    %al,(%eax)
  282a35:	41                   	inc    %ecx
  282a36:	0e                   	push   %cs
  282a37:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282a3d:	4b                   	dec    %ebx
  282a3e:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282a41:	04 00                	add    $0x0,%al
  282a43:	00 24 00             	add    %ah,(%eax,%eax,1)
  282a46:	00 00                	add    %al,(%eax)
  282a48:	7c 00                	jl     282a4a <cursor+0x1aa>
  282a4a:	00 00                	add    %al,(%eax)
  282a4c:	8f                   	(bad)  
  282a4d:	d8 ff                	fdivr  %st(7),%st
  282a4f:	ff 35 00 00 00 00    	pushl  0x0
  282a55:	41                   	inc    %ecx
  282a56:	0e                   	push   %cs
  282a57:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282a5d:	45                   	inc    %ebp
  282a5e:	86 03                	xchg   %al,(%ebx)
  282a60:	83 04 6a c3          	addl   $0xffffffc3,(%edx,%ebp,2)
  282a64:	41                   	inc    %ecx
  282a65:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
  282a69:	04 04                	add    $0x4,%al
  282a6b:	00 24 00             	add    %ah,(%eax,%eax,1)
  282a6e:	00 00                	add    %al,(%eax)
  282a70:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  282a71:	00 00                	add    %al,(%eax)
  282a73:	00 9c d8 ff ff 31 00 	add    %bl,0x31ffff(%eax,%ebx,8)
  282a7a:	00 00                	add    %al,(%eax)
  282a7c:	00 41 0e             	add    %al,0xe(%ecx)
  282a7f:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282a85:	42                   	inc    %edx
  282a86:	87 03                	xchg   %eax,(%ebx)
  282a88:	86 04 64             	xchg   %al,(%esp,%eiz,2)
  282a8b:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
  282a8f:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282a92:	04 00                	add    $0x0,%al
  282a94:	20 00                	and    %al,(%eax)
  282a96:	00 00                	add    %al,(%eax)
  282a98:	cc                   	int3   
  282a99:	00 00                	add    %al,(%eax)
  282a9b:	00 a5 d8 ff ff 2f    	add    %ah,0x2fffffd8(%ebp)
  282aa1:	00 00                	add    %al,(%eax)
  282aa3:	00 00                	add    %al,(%eax)
  282aa5:	41                   	inc    %ecx
  282aa6:	0e                   	push   %cs
  282aa7:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282aad:	47                   	inc    %edi
  282aae:	83 03 63             	addl   $0x63,(%ebx)
  282ab1:	c3                   	ret    
  282ab2:	41                   	inc    %ecx
  282ab3:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282ab6:	04 00                	add    $0x0,%al
  282ab8:	1c 00                	sbb    $0x0,%al
  282aba:	00 00                	add    %al,(%eax)
  282abc:	f0 00 00             	lock add %al,(%eax)
  282abf:	00 b0 d8 ff ff 28    	add    %dh,0x28ffffd8(%eax)
  282ac5:	00 00                	add    %al,(%eax)
  282ac7:	00 00                	add    %al,(%eax)
  282ac9:	41                   	inc    %ecx
  282aca:	0e                   	push   %cs
  282acb:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282ad1:	64 c5 0c 04          	lds    %fs:(%esp,%eax,1),%ecx
  282ad5:	04 00                	add    $0x0,%al
  282ad7:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282ada:	00 00                	add    %al,(%eax)
  282adc:	10 01                	adc    %al,(%ecx)
  282ade:	00 00                	add    %al,(%eax)
  282ae0:	b8 d8 ff ff 61       	mov    $0x61ffffd8,%eax
  282ae5:	01 00                	add    %eax,(%eax)
  282ae7:	00 00                	add    %al,(%eax)
  282ae9:	41                   	inc    %ecx
  282aea:	0e                   	push   %cs
  282aeb:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282af1:	03 5d 01             	add    0x1(%ebp),%ebx
  282af4:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282af7:	04 1c                	add    $0x1c,%al
  282af9:	00 00                	add    %al,(%eax)
  282afb:	00 30                	add    %dh,(%eax)
  282afd:	01 00                	add    %eax,(%eax)
  282aff:	00 f9                	add    %bh,%cl
  282b01:	d9 ff                	fcos   
  282b03:	ff 1f                	lcall  *(%edi)
  282b05:	00 00                	add    %al,(%eax)
  282b07:	00 00                	add    %al,(%eax)
  282b09:	41                   	inc    %ecx
  282b0a:	0e                   	push   %cs
  282b0b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282b11:	5b                   	pop    %ebx
  282b12:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282b15:	04 00                	add    $0x0,%al
  282b17:	00 24 00             	add    %ah,(%eax,%eax,1)
  282b1a:	00 00                	add    %al,(%eax)
  282b1c:	50                   	push   %eax
  282b1d:	01 00                	add    %eax,(%eax)
  282b1f:	00 f8                	add    %bh,%al
  282b21:	d9 ff                	fcos   
  282b23:	ff 50 00             	call   *0x0(%eax)
  282b26:	00 00                	add    %al,(%eax)
  282b28:	00 41 0e             	add    %al,0xe(%ecx)
  282b2b:	08 85 02 44 0d 05    	or     %al,0x50d4402(%ebp)
  282b31:	48                   	dec    %eax
  282b32:	86 03                	xchg   %al,(%ebx)
  282b34:	83 04 02 40          	addl   $0x40,(%edx,%eax,1)
  282b38:	c3                   	ret    
  282b39:	41                   	inc    %ecx
  282b3a:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
  282b3e:	04 04                	add    $0x4,%al
  282b40:	28 00                	sub    %al,(%eax)
  282b42:	00 00                	add    %al,(%eax)
  282b44:	78 01                	js     282b47 <cursor+0x2a7>
  282b46:	00 00                	add    %al,(%eax)
  282b48:	20 da                	and    %bl,%dl
  282b4a:	ff                   	(bad)  
  282b4b:	ff 4a 00             	decl   0x0(%edx)
  282b4e:	00 00                	add    %al,(%eax)
  282b50:	00 41 0e             	add    %al,0xe(%ecx)
  282b53:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282b59:	44                   	inc    %esp
  282b5a:	87 03                	xchg   %eax,(%ebx)
  282b5c:	44                   	inc    %esp
  282b5d:	86 04 83             	xchg   %al,(%ebx,%eax,4)
  282b60:	05 7b c3 41 c6       	add    $0xc641c37b,%eax
  282b65:	41                   	inc    %ecx
  282b66:	c7 41 c5 0c 04 04 28 	movl   $0x2804040c,-0x3b(%ecx)
  282b6d:	00 00                	add    %al,(%eax)
  282b6f:	00 a4 01 00 00 40 da 	add    %ah,-0x25c00000(%ecx,%eax,1)
  282b76:	ff                   	(bad)  
  282b77:	ff 62 00             	jmp    *0x0(%edx)
  282b7a:	00 00                	add    %al,(%eax)
  282b7c:	00 41 0e             	add    %al,0xe(%ecx)
  282b7f:	08 85 02 44 0d 05    	or     %al,0x50d4402(%ebp)
  282b85:	4b                   	dec    %ebx
  282b86:	87 03                	xchg   %eax,(%ebx)
  282b88:	86 04 83             	xchg   %al,(%ebx,%eax,4)
  282b8b:	05 02 4e c3 41       	add    $0x41c34e02,%eax
  282b90:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
  282b94:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282b97:	04 28                	add    $0x28,%al
  282b99:	00 00                	add    %al,(%eax)
  282b9b:	00 d0                	add    %dl,%al
  282b9d:	01 00                	add    %eax,(%eax)
  282b9f:	00 76 da             	add    %dh,-0x26(%esi)
  282ba2:	ff                   	(bad)  
  282ba3:	ff 62 00             	jmp    *0x0(%edx)
  282ba6:	00 00                	add    %al,(%eax)
  282ba8:	00 41 0e             	add    %al,0xe(%ecx)
  282bab:	08 85 02 44 0d 05    	or     %al,0x50d4402(%ebp)
  282bb1:	4b                   	dec    %ebx
  282bb2:	87 03                	xchg   %eax,(%ebx)
  282bb4:	86 04 83             	xchg   %al,(%ebx,%eax,4)
  282bb7:	05 02 4e c3 41       	add    $0x41c34e02,%eax
  282bbc:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
  282bc0:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282bc3:	04 28                	add    $0x28,%al
  282bc5:	00 00                	add    %al,(%eax)
  282bc7:	00 fc                	add    %bh,%ah
  282bc9:	01 00                	add    %eax,(%eax)
  282bcb:	00 ac da ff ff aa 00 	add    %ch,0xaaffff(%edx,%ebx,8)
  282bd2:	00 00                	add    %al,(%eax)
  282bd4:	00 41 0e             	add    %al,0xe(%ecx)
  282bd7:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282bdd:	46                   	inc    %esi
  282bde:	87 03                	xchg   %eax,(%ebx)
  282be0:	86 04 83             	xchg   %al,(%ebx,%eax,4)
  282be3:	05 02 9d c3 41       	add    $0x41c39d02,%eax
  282be8:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
  282bec:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282bef:	04 28                	add    $0x28,%al
  282bf1:	00 00                	add    %al,(%eax)
  282bf3:	00 28                	add    %ch,(%eax)
  282bf5:	02 00                	add    (%eax),%al
  282bf7:	00 2a                	add    %ch,(%edx)
  282bf9:	db ff                	(bad)  
  282bfb:	ff 62 00             	jmp    *0x0(%edx)
  282bfe:	00 00                	add    %al,(%eax)
  282c00:	00 41 0e             	add    %al,0xe(%ecx)
  282c03:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282c09:	46                   	inc    %esi
  282c0a:	87 03                	xchg   %eax,(%ebx)
  282c0c:	86 04 83             	xchg   %al,(%ebx,%eax,4)
  282c0f:	05 02 55 c3 41       	add    $0x41c35502,%eax
  282c14:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
  282c18:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282c1b:	04 2c                	add    $0x2c,%al
  282c1d:	00 00                	add    %al,(%eax)
  282c1f:	00 54 02 00          	add    %dl,0x0(%edx,%eax,1)
  282c23:	00 60 db             	add    %ah,-0x25(%eax)
  282c26:	ff                   	(bad)  
  282c27:	ff 64 00 00          	jmp    *0x0(%eax,%eax,1)
  282c2b:	00 00                	add    %al,(%eax)
  282c2d:	41                   	inc    %ecx
  282c2e:	0e                   	push   %cs
  282c2f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282c35:	41                   	inc    %ecx
  282c36:	87 03                	xchg   %eax,(%ebx)
  282c38:	44                   	inc    %esp
  282c39:	86 04 45 83 05 02 53 	xchg   %al,0x53020583(,%eax,2)
  282c40:	c3                   	ret    
  282c41:	41                   	inc    %ecx
  282c42:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
  282c46:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282c49:	04 00                	add    $0x0,%al
  282c4b:	00 20                	add    %ah,(%eax)
  282c4d:	00 00                	add    %al,(%eax)
  282c4f:	00 84 02 00 00 94 db 	add    %al,-0x246c0000(%edx,%eax,1)
  282c56:	ff                   	(bad)  
  282c57:	ff                   	(bad)  
  282c58:	3a 00                	cmp    (%eax),%al
  282c5a:	00 00                	add    %al,(%eax)
  282c5c:	00 41 0e             	add    %al,0xe(%ecx)
  282c5f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282c65:	44                   	inc    %esp
  282c66:	83 03 72             	addl   $0x72,(%ebx)
  282c69:	c5 c3 0c             	(bad)  
  282c6c:	04 04                	add    $0x4,%al
  282c6e:	00 00                	add    %al,(%eax)
  282c70:	24 00                	and    $0x0,%al
  282c72:	00 00                	add    %al,(%eax)
  282c74:	a8 02                	test   $0x2,%al
  282c76:	00 00                	add    %al,(%eax)
  282c78:	aa                   	stos   %al,%es:(%edi)
  282c79:	db ff                	(bad)  
  282c7b:	ff                   	(bad)  
  282c7c:	3f                   	aas    
  282c7d:	00 00                	add    %al,(%eax)
  282c7f:	00 00                	add    %al,(%eax)
  282c81:	41                   	inc    %ecx
  282c82:	0e                   	push   %cs
  282c83:	08 85 02 44 0d 05    	or     %al,0x50d4402(%ebp)
  282c89:	45                   	inc    %ebp
  282c8a:	86 03                	xchg   %al,(%ebx)
  282c8c:	83 04 72 c3          	addl   $0xffffffc3,(%edx,%esi,2)
  282c90:	41                   	inc    %ecx
  282c91:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
  282c95:	04 04                	add    $0x4,%al
  282c97:	00 2c 00             	add    %ch,(%eax,%eax,1)
  282c9a:	00 00                	add    %al,(%eax)
  282c9c:	d0 02                	rolb   (%edx)
  282c9e:	00 00                	add    %al,(%eax)
  282ca0:	c1 db ff             	rcr    $0xff,%ebx
  282ca3:	ff 4f 00             	decl   0x0(%edi)
  282ca6:	00 00                	add    %al,(%eax)
  282ca8:	00 41 0e             	add    %al,0xe(%ecx)
  282cab:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282cb1:	41                   	inc    %ecx
  282cb2:	87 03                	xchg   %eax,(%ebx)
  282cb4:	44                   	inc    %esp
  282cb5:	86 04 44             	xchg   %al,(%esp,%eax,2)
  282cb8:	83 05 7f c3 41 c6 41 	addl   $0x41,0xc641c37f
  282cbf:	c7 41 c5 0c 04 04 00 	movl   $0x4040c,-0x3b(%ecx)
  282cc6:	00 00                	add    %al,(%eax)
  282cc8:	2c 00                	sub    $0x0,%al
  282cca:	00 00                	add    %al,(%eax)
  282ccc:	00 03                	add    %al,(%ebx)
  282cce:	00 00                	add    %al,(%eax)
  282cd0:	e0 db                	loopne 282cad <cursor+0x40d>
  282cd2:	ff                   	(bad)  
  282cd3:	ff 54 00 00          	call   *0x0(%eax,%eax,1)
  282cd7:	00 00                	add    %al,(%eax)
  282cd9:	41                   	inc    %ecx
  282cda:	0e                   	push   %cs
  282cdb:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282ce1:	48                   	dec    %eax
  282ce2:	87 03                	xchg   %eax,(%ebx)
  282ce4:	86 04 44             	xchg   %al,(%esp,%eax,2)
  282ce7:	83 05 02 41 c3 41 c6 	addl   $0xffffffc6,0x41c34102
  282cee:	41                   	inc    %ecx
  282cef:	c7 41 c5 0c 04 04 00 	movl   $0x4040c,-0x3b(%ecx)
  282cf6:	00 00                	add    %al,(%eax)
  282cf8:	1c 00                	sbb    $0x0,%al
  282cfa:	00 00                	add    %al,(%eax)
  282cfc:	30 03                	xor    %al,(%ebx)
  282cfe:	00 00                	add    %al,(%eax)
  282d00:	04 dc                	add    $0xdc,%al
  282d02:	ff                   	(bad)  
  282d03:	ff 2a                	ljmp   *(%edx)
  282d05:	00 00                	add    %al,(%eax)
  282d07:	00 00                	add    %al,(%eax)
  282d09:	41                   	inc    %ecx
  282d0a:	0e                   	push   %cs
  282d0b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282d11:	66 c5 0c 04          	lds    (%esp,%eax,1),%cx
  282d15:	04 00                	add    $0x0,%al
  282d17:	00 20                	add    %ah,(%eax)
  282d19:	00 00                	add    %al,(%eax)
  282d1b:	00 50 03             	add    %dl,0x3(%eax)
  282d1e:	00 00                	add    %al,(%eax)
  282d20:	0e                   	push   %cs
  282d21:	dc ff                	fdivr  %st,%st(7)
  282d23:	ff 8b 01 00 00 00    	decl   0x1(%ebx)
  282d29:	41                   	inc    %ecx
  282d2a:	0e                   	push   %cs
  282d2b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282d31:	41                   	inc    %ecx
  282d32:	83 03 03             	addl   $0x3,(%ebx)
  282d35:	86 01                	xchg   %al,(%ecx)
  282d37:	c5 c3 0c             	(bad)  
  282d3a:	04 04                	add    $0x4,%al
  282d3c:	1c 00                	sbb    $0x0,%al
  282d3e:	00 00                	add    %al,(%eax)
  282d40:	74 03                	je     282d45 <cursor+0x4a5>
  282d42:	00 00                	add    %al,(%eax)
  282d44:	78 dd                	js     282d23 <cursor+0x483>
  282d46:	ff                   	(bad)  
  282d47:	ff                   	(bad)  
  282d48:	3a 00                	cmp    (%eax),%al
  282d4a:	00 00                	add    %al,(%eax)
  282d4c:	00 41 0e             	add    %al,0xe(%ecx)
  282d4f:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282d55:	71 c5                	jno    282d1c <cursor+0x47c>
  282d57:	0c 04                	or     $0x4,%al
  282d59:	04 00                	add    $0x0,%al
  282d5b:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282d5e:	00 00                	add    %al,(%eax)
  282d60:	94                   	xchg   %eax,%esp
  282d61:	03 00                	add    (%eax),%eax
  282d63:	00 92 dd ff ff 24    	add    %dl,0x24ffffdd(%edx)
  282d69:	00 00                	add    %al,(%eax)
  282d6b:	00 00                	add    %al,(%eax)
  282d6d:	41                   	inc    %ecx
  282d6e:	0e                   	push   %cs
  282d6f:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282d75:	5b                   	pop    %ebx
  282d76:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282d79:	04 00                	add    $0x0,%al
  282d7b:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282d7e:	00 00                	add    %al,(%eax)
  282d80:	b4 03                	mov    $0x3,%ah
  282d82:	00 00                	add    %al,(%eax)
  282d84:	96                   	xchg   %eax,%esi
  282d85:	dd ff                	(bad)  
  282d87:	ff 29                	ljmp   *(%ecx)
  282d89:	00 00                	add    %al,(%eax)
  282d8b:	00 00                	add    %al,(%eax)
  282d8d:	41                   	inc    %ecx
  282d8e:	0e                   	push   %cs
  282d8f:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282d95:	60                   	pusha  
  282d96:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282d99:	04 00                	add    $0x0,%al
  282d9b:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282d9e:	00 00                	add    %al,(%eax)
  282da0:	d4 03                	aam    $0x3
  282da2:	00 00                	add    %al,(%eax)
  282da4:	9f                   	lahf   
  282da5:	dd ff                	(bad)  
  282da7:	ff 0d 00 00 00 00    	decl   0x0
  282dad:	41                   	inc    %ecx
  282dae:	0e                   	push   %cs
  282daf:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282db5:	44                   	inc    %esp
  282db6:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282db9:	04 00                	add    $0x0,%al
  282dbb:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282dbe:	00 00                	add    %al,(%eax)
  282dc0:	f4                   	hlt    
  282dc1:	03 00                	add    (%eax),%eax
  282dc3:	00 00                	add    %al,(%eax)
  282dc5:	de ff                	fdivrp %st,%st(7)
  282dc7:	ff 2b                	ljmp   *(%ebx)
  282dc9:	00 00                	add    %al,(%eax)
  282dcb:	00 00                	add    %al,(%eax)
  282dcd:	41                   	inc    %ecx
  282dce:	0e                   	push   %cs
  282dcf:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282dd5:	67 c5 0c             	lds    (%si),%ecx
  282dd8:	04 04                	add    $0x4,%al
  282dda:	00 00                	add    %al,(%eax)
  282ddc:	20 00                	and    %al,(%eax)
  282dde:	00 00                	add    %al,(%eax)
  282de0:	14 04                	adc    $0x4,%al
  282de2:	00 00                	add    %al,(%eax)
  282de4:	0b de                	or     %esi,%ebx
  282de6:	ff                   	(bad)  
  282de7:	ff                   	(bad)  
  282de8:	3e 00 00             	add    %al,%ds:(%eax)
  282deb:	00 00                	add    %al,(%eax)
  282ded:	41                   	inc    %ecx
  282dee:	0e                   	push   %cs
  282def:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282df5:	44                   	inc    %esp
  282df6:	83 03 75             	addl   $0x75,(%ebx)
  282df9:	c3                   	ret    
  282dfa:	41                   	inc    %ecx
  282dfb:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282dfe:	04 00                	add    $0x0,%al
  282e00:	28 00                	sub    %al,(%eax)
  282e02:	00 00                	add    %al,(%eax)
  282e04:	38 04 00             	cmp    %al,(%eax,%eax,1)
  282e07:	00 25 de ff ff 35    	add    %ah,0x35ffffde
  282e0d:	00 00                	add    %al,(%eax)
  282e0f:	00 00                	add    %al,(%eax)
  282e11:	41                   	inc    %ecx
  282e12:	0e                   	push   %cs
  282e13:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282e19:	46                   	inc    %esi
  282e1a:	87 03                	xchg   %eax,(%ebx)
  282e1c:	86 04 83             	xchg   %al,(%ebx,%eax,4)
  282e1f:	05 68 c3 41 c6       	add    $0xc641c368,%eax
  282e24:	41                   	inc    %ecx
  282e25:	c7 41 c5 0c 04 04 00 	movl   $0x4040c,-0x3b(%ecx)
  282e2c:	1c 00                	sbb    $0x0,%al
  282e2e:	00 00                	add    %al,(%eax)
  282e30:	64                   	fs
  282e31:	04 00                	add    $0x0,%al
  282e33:	00 2e                	add    %ch,(%esi)
  282e35:	de ff                	fdivrp %st,%st(7)
  282e37:	ff 0e                	decl   (%esi)
  282e39:	00 00                	add    %al,(%eax)
  282e3b:	00 00                	add    %al,(%eax)
  282e3d:	41                   	inc    %ecx
  282e3e:	0e                   	push   %cs
  282e3f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282e45:	44                   	inc    %esp
  282e46:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282e49:	04 00                	add    $0x0,%al
  282e4b:	00 20                	add    %ah,(%eax)
  282e4d:	00 00                	add    %al,(%eax)
  282e4f:	00 84 04 00 00 1c de 	add    %al,-0x21e40000(%esp,%eax,1)
  282e56:	ff                   	(bad)  
  282e57:	ff 6f 00             	ljmp   *0x0(%edi)
  282e5a:	00 00                	add    %al,(%eax)
  282e5c:	00 41 0e             	add    %al,0xe(%ecx)
  282e5f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282e65:	44                   	inc    %esp
  282e66:	83 03 02             	addl   $0x2,(%ebx)
  282e69:	67 c5 c3 0c          	addr16 (bad) 
  282e6d:	04 04                	add    $0x4,%al
  282e6f:	00 24 00             	add    %ah,(%eax,%eax,1)
  282e72:	00 00                	add    %al,(%eax)
  282e74:	a8 04                	test   $0x4,%al
  282e76:	00 00                	add    %al,(%eax)
  282e78:	67 de ff             	addr16 fdivrp %st,%st(7)
  282e7b:	ff 00                	incl   (%eax)
  282e7d:	01 00                	add    %eax,(%eax)
  282e7f:	00 00                	add    %al,(%eax)
  282e81:	47                   	inc    %edi
  282e82:	0e                   	push   %cs
  282e83:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282e89:	42                   	inc    %edx
  282e8a:	86 03                	xchg   %al,(%ebx)
  282e8c:	83 04 02 ed          	addl   $0xffffffed,(%edx,%eax,1)
  282e90:	c3                   	ret    
  282e91:	41                   	inc    %ecx
  282e92:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
  282e96:	04 04                	add    $0x4,%al
  282e98:	1c 00                	sbb    $0x0,%al
  282e9a:	00 00                	add    %al,(%eax)
  282e9c:	d0 04 00             	rolb   (%eax,%eax,1)
  282e9f:	00 40 df             	add    %al,-0x21(%eax)
  282ea2:	ff                   	(bad)  
  282ea3:	ff 0f                	decl   (%edi)
  282ea5:	00 00                	add    %al,(%eax)
  282ea7:	00 00                	add    %al,(%eax)
  282ea9:	41                   	inc    %ecx
  282eaa:	0e                   	push   %cs
  282eab:	08 85 02 47 0d 05    	or     %al,0x50d4702(%ebp)
  282eb1:	46                   	inc    %esi
  282eb2:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282eb5:	04 00                	add    $0x0,%al
  282eb7:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282eba:	00 00                	add    %al,(%eax)
  282ebc:	f0 04 00             	lock add $0x0,%al
  282ebf:	00 2f                	add    %ch,(%edi)
  282ec1:	df ff                	(bad)  
  282ec3:	ff 1f                	lcall  *(%edi)
  282ec5:	00 00                	add    %al,(%eax)
  282ec7:	00 00                	add    %al,(%eax)
  282ec9:	41                   	inc    %ecx
  282eca:	0e                   	push   %cs
  282ecb:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282ed1:	5b                   	pop    %ebx
  282ed2:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282ed5:	04 00                	add    $0x0,%al
  282ed7:	00 1c 00             	add    %bl,(%eax,%eax,1)
  282eda:	00 00                	add    %al,(%eax)
  282edc:	10 05 00 00 30 df    	adc    %al,0xdf300000
  282ee2:	ff                   	(bad)  
  282ee3:	ff 30                	pushl  (%eax)
  282ee5:	00 00                	add    %al,(%eax)
  282ee7:	00 00                	add    %al,(%eax)
  282ee9:	41                   	inc    %ecx
  282eea:	0e                   	push   %cs
  282eeb:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282ef1:	6c                   	insb   (%dx),%es:(%edi)
  282ef2:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  282ef5:	04 00                	add    $0x0,%al
  282ef7:	00 28                	add    %ch,(%eax)
  282ef9:	00 00                	add    %al,(%eax)
  282efb:	00 30                	add    %dh,(%eax)
  282efd:	05 00 00 40 df       	add    $0xdf400000,%eax
  282f02:	ff                   	(bad)  
  282f03:	ff 60 00             	jmp    *0x0(%eax)
  282f06:	00 00                	add    %al,(%eax)
  282f08:	00 41 0e             	add    %al,0xe(%ecx)
  282f0b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  282f11:	41                   	inc    %ecx
  282f12:	86 03                	xchg   %al,(%ebx)
  282f14:	44                   	inc    %esp
  282f15:	83 04 02 55          	addl   $0x55,(%edx,%eax,1)
  282f19:	c3                   	ret    
  282f1a:	41                   	inc    %ecx
  282f1b:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
  282f1f:	04 04                	add    $0x4,%al
  282f21:	00 00                	add    %al,(%eax)
	...

Disassembly of section .data:

00282f24 <bootp>:
  282f24:	f0 0f 00 00          	lock sldt (%eax)

Disassembly of section .bss:

00282f28 <keyfifo>:
	...

00282f40 <mousefifo>:
	...

00282f58 <glob>:
	...

00282f68 <mousepic>:
	...

00283068 <heihei>:
  283068:	00 00                	add    %al,(%eax)
	...

0028306c <hehe>:
  28306c:	00 00                	add    %al,(%eax)
	...

Disassembly of section .stab:

00000000 <.stab>:
       0:	01 00                	add    %eax,(%eax)
       2:	00 00                	add    %al,(%eax)
       4:	00 00                	add    %al,(%eax)
       6:	43                   	inc    %ebx
       7:	04 9c                	add    $0x9c,%al
       9:	0f 00 00             	sldt   (%eax)
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
     103:	00 f2                	add    %dh,%dl
     105:	aa                   	stos   %al,%es:(%edi)
     106:	00 00                	add    %al,(%eax)
     108:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
     109:	02 00                	add    (%eax),%al
     10b:	00 82 00 00 00 00    	add    %al,0x0(%edx)
     111:	00 00                	add    %al,(%eax)
     113:	00 ae 02 00 00 82    	add    %ch,-0x7dfffffe(%esi)
     119:	00 00                	add    %al,(%eax)
     11b:	00 37                	add    %dh,(%edi)
     11d:	53                   	push   %ebx
     11e:	00 00                	add    %al,(%eax)
     120:	b8 02 00 00 80       	mov    $0x80000002,%eax
     125:	00 00                	add    %al,(%eax)
     127:	00 00                	add    %al,(%eax)
     129:	00 00                	add    %al,(%eax)
     12b:	00 ca                	add    %cl,%dl
     12d:	02 00                	add    (%eax),%al
     12f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     135:	00 00                	add    %al,(%eax)
     137:	00 df                	add    %bl,%bh
     139:	02 00                	add    (%eax),%al
     13b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     141:	00 00                	add    %al,(%eax)
     143:	00 f5                	add    %dh,%ch
     145:	02 00                	add    (%eax),%al
     147:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     14d:	00 00                	add    %al,(%eax)
     14f:	00 0a                	add    %cl,(%edx)
     151:	03 00                	add    (%eax),%eax
     153:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     159:	00 00                	add    %al,(%eax)
     15b:	00 20                	add    %ah,(%eax)
     15d:	03 00                	add    (%eax),%eax
     15f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     165:	00 00                	add    %al,(%eax)
     167:	00 35 03 00 00 80    	add    %dh,0x80000003
     16d:	00 00                	add    %al,(%eax)
     16f:	00 00                	add    %al,(%eax)
     171:	00 00                	add    %al,(%eax)
     173:	00 4b 03             	add    %cl,0x3(%ebx)
     176:	00 00                	add    %al,(%eax)
     178:	80 00 00             	addb   $0x0,(%eax)
     17b:	00 00                	add    %al,(%eax)
     17d:	00 00                	add    %al,(%eax)
     17f:	00 60 03             	add    %ah,0x3(%eax)
     182:	00 00                	add    %al,(%eax)
     184:	80 00 00             	addb   $0x0,(%eax)
     187:	00 00                	add    %al,(%eax)
     189:	00 00                	add    %al,(%eax)
     18b:	00 76 03             	add    %dh,0x3(%esi)
     18e:	00 00                	add    %al,(%eax)
     190:	80 00 00             	addb   $0x0,(%eax)
     193:	00 00                	add    %al,(%eax)
     195:	00 00                	add    %al,(%eax)
     197:	00 8d 03 00 00 80    	add    %cl,-0x7ffffffd(%ebp)
     19d:	00 00                	add    %al,(%eax)
     19f:	00 00                	add    %al,(%eax)
     1a1:	00 00                	add    %al,(%eax)
     1a3:	00 a5 03 00 00 80    	add    %ah,-0x7ffffffd(%ebp)
     1a9:	00 00                	add    %al,(%eax)
     1ab:	00 00                	add    %al,(%eax)
     1ad:	00 00                	add    %al,(%eax)
     1af:	00 be 03 00 00 80    	add    %bh,-0x7ffffffd(%esi)
     1b5:	00 00                	add    %al,(%eax)
     1b7:	00 00                	add    %al,(%eax)
     1b9:	00 00                	add    %al,(%eax)
     1bb:	00 d2                	add    %dl,%dl
     1bd:	03 00                	add    (%eax),%eax
     1bf:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     1c5:	00 00                	add    %al,(%eax)
     1c7:	00 e7                	add    %ah,%bh
     1c9:	03 00                	add    (%eax),%eax
     1cb:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     1d1:	00 00                	add    %al,(%eax)
     1d3:	00 fd                	add    %bh,%ch
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
     1f7:	00 11                	add    %dl,(%ecx)
     1f9:	04 00                	add    $0x0,%al
     1fb:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     201:	00 00                	add    %al,(%eax)
     203:	00 8c 04 00 00 80 00 	add    %cl,0x800000(%esp,%eax,1)
     20a:	00 00                	add    %al,(%eax)
     20c:	00 00                	add    %al,(%eax)
     20e:	00 00                	add    %al,(%eax)
     210:	17                   	pop    %ss
     211:	05 00 00 80 00       	add    $0x800000,%eax
     216:	00 00                	add    %al,(%eax)
     218:	00 00                	add    %al,(%eax)
     21a:	00 00                	add    %al,(%eax)
     21c:	b4 05                	mov    $0x5,%ah
     21e:	00 00                	add    %al,(%eax)
     220:	80 00 00             	addb   $0x0,(%eax)
     223:	00 00                	add    %al,(%eax)
     225:	00 00                	add    %al,(%eax)
     227:	00 44 06 00          	add    %al,0x0(%esi,%eax,1)
     22b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     231:	00 00                	add    %al,(%eax)
     233:	00 00                	add    %al,(%eax)
     235:	00 00                	add    %al,(%eax)
     237:	00 a2 00 00 00 00    	add    %ah,0x0(%edx)
     23d:	00 00                	add    %al,(%eax)
     23f:	00 c2                	add    %al,%dl
     241:	06                   	push   %es
     242:	00 00                	add    %al,(%eax)
     244:	24 00                	and    $0x0,%al
     246:	00 00                	add    %al,(%eax)
     248:	00 00                	add    %al,(%eax)
     24a:	28 00                	sub    %al,(%eax)
     24c:	00 00                	add    %al,(%eax)
     24e:	00 00                	add    %al,(%eax)
     250:	44                   	inc    %esp
     251:	00 0e                	add    %cl,(%esi)
	...
     25b:	00 44 00 14          	add    %al,0x14(%eax,%eax,1)
     25f:	00 0c 00             	add    %cl,(%eax,%eax,1)
     262:	00 00                	add    %al,(%eax)
     264:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
     265:	02 00                	add    (%eax),%al
     267:	00 84 00 00 00 13 00 	add    %al,0x130000(%eax,%eax,1)
     26e:	28 00                	sub    %al,(%eax)
     270:	00 00                	add    %al,(%eax)
     272:	00 00                	add    %al,(%eax)
     274:	44                   	inc    %esp
     275:	00 35 00 13 00 00    	add    %dh,0x1300
     27b:	00 01                	add    %al,(%ecx)
     27d:	00 00                	add    %al,(%eax)
     27f:	00 84 00 00 00 14 00 	add    %al,0x140000(%eax,%eax,1)
     286:	28 00                	sub    %al,(%eax)
     288:	00 00                	add    %al,(%eax)
     28a:	00 00                	add    %al,(%eax)
     28c:	44                   	inc    %esp
     28d:	00 17                	add    %dl,(%edi)
     28f:	00 14 00             	add    %dl,(%eax,%eax,1)
     292:	00 00                	add    %al,(%eax)
     294:	00 00                	add    %al,(%eax)
     296:	00 00                	add    %al,(%eax)
     298:	44                   	inc    %esp
     299:	00 18                	add    %bl,(%eax)
     29b:	00 2a                	add    %ch,(%edx)
     29d:	00 00                	add    %al,(%eax)
     29f:	00 00                	add    %al,(%eax)
     2a1:	00 00                	add    %al,(%eax)
     2a3:	00 44 00 1c          	add    %al,0x1c(%eax,%eax,1)
     2a7:	00 43 00             	add    %al,0x0(%ebx)
     2aa:	00 00                	add    %al,(%eax)
     2ac:	00 00                	add    %al,(%eax)
     2ae:	00 00                	add    %al,(%eax)
     2b0:	44                   	inc    %esp
     2b1:	00 19                	add    %bl,(%ecx)
     2b3:	00 49 00             	add    %cl,0x0(%ecx)
     2b6:	00 00                	add    %al,(%eax)
     2b8:	00 00                	add    %al,(%eax)
     2ba:	00 00                	add    %al,(%eax)
     2bc:	44                   	inc    %esp
     2bd:	00 1a                	add    %bl,(%edx)
     2bf:	00 55 00             	add    %dl,0x0(%ebp)
     2c2:	00 00                	add    %al,(%eax)
     2c4:	00 00                	add    %al,(%eax)
     2c6:	00 00                	add    %al,(%eax)
     2c8:	44                   	inc    %esp
     2c9:	00 1c 00             	add    %bl,(%eax,%eax,1)
     2cc:	5a                   	pop    %edx
     2cd:	00 00                	add    %al,(%eax)
     2cf:	00 00                	add    %al,(%eax)
     2d1:	00 00                	add    %al,(%eax)
     2d3:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
     2d7:	00 67 00             	add    %ah,0x0(%edi)
     2da:	00 00                	add    %al,(%eax)
     2dc:	00 00                	add    %al,(%eax)
     2de:	00 00                	add    %al,(%eax)
     2e0:	44                   	inc    %esp
     2e1:	00 1e                	add    %bl,(%esi)
     2e3:	00 89 00 00 00 00    	add    %cl,0x0(%ecx)
     2e9:	00 00                	add    %al,(%eax)
     2eb:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
     2ef:	00 a5 00 00 00 00    	add    %ah,0x0(%ebp)
     2f5:	00 00                	add    %al,(%eax)
     2f7:	00 44 00 20          	add    %al,0x20(%eax,%eax,1)
     2fb:	00 bb 00 00 00 00    	add    %bh,0x0(%ebx)
     301:	00 00                	add    %al,(%eax)
     303:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
     307:	00 be 00 00 00 00    	add    %bh,0x0(%esi)
     30d:	00 00                	add    %al,(%eax)
     30f:	00 44 00 20          	add    %al,0x20(%eax,%eax,1)
     313:	00 c1                	add    %al,%cl
     315:	00 00                	add    %al,(%eax)
     317:	00 00                	add    %al,(%eax)
     319:	00 00                	add    %al,(%eax)
     31b:	00 44 00 21          	add    %al,0x21(%eax,%eax,1)
     31f:	00 cd                	add    %cl,%ch
     321:	00 00                	add    %al,(%eax)
     323:	00 00                	add    %al,(%eax)
     325:	00 00                	add    %al,(%eax)
     327:	00 44 00 22          	add    %al,0x22(%eax,%eax,1)
     32b:	00 ef                	add    %ch,%bh
     32d:	00 00                	add    %al,(%eax)
     32f:	00 00                	add    %al,(%eax)
     331:	00 00                	add    %al,(%eax)
     333:	00 44 00 37          	add    %al,0x37(%eax,%eax,1)
     337:	00 0b                	add    %cl,(%ebx)
     339:	01 00                	add    %eax,(%eax)
     33b:	00 00                	add    %al,(%eax)
     33d:	00 00                	add    %al,(%eax)
     33f:	00 44 00 38          	add    %al,0x38(%eax,%eax,1)
     343:	00 13                	add    %dl,(%ebx)
     345:	01 00                	add    %eax,(%eax)
     347:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
     34d:	00 00                	add    %al,(%eax)
     34f:	00 18                	add    %bl,(%eax)
     351:	01 28                	add    %ebp,(%eax)
     353:	00 00                	add    %al,(%eax)
     355:	00 00                	add    %al,(%eax)
     357:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
     35b:	00 18                	add    %bl,(%eax)
     35d:	01 00                	add    %eax,(%eax)
     35f:	00 01                	add    %al,(%ecx)
     361:	00 00                	add    %al,(%eax)
     363:	00 84 00 00 00 25 01 	add    %al,0x1250000(%eax,%eax,1)
     36a:	28 00                	sub    %al,(%eax)
     36c:	00 00                	add    %al,(%eax)
     36e:	00 00                	add    %al,(%eax)
     370:	44                   	inc    %esp
     371:	00 48 00             	add    %cl,0x0(%eax)
     374:	25 01 00 00 00       	and    $0x1,%eax
     379:	00 00                	add    %al,(%eax)
     37b:	00 44 00 49          	add    %al,0x49(%eax,%eax,1)
     37f:	00 2a                	add    %ch,(%edx)
     381:	01 00                	add    %eax,(%eax)
     383:	00 00                	add    %al,(%eax)
     385:	00 00                	add    %al,(%eax)
     387:	00 44 00 46          	add    %al,0x46(%eax,%eax,1)
     38b:	00 2d 01 00 00 00    	add    %ch,0x1
     391:	00 00                	add    %al,(%eax)
     393:	00 44 00 49          	add    %al,0x49(%eax,%eax,1)
     397:	00 30                	add    %dh,(%eax)
     399:	01 00                	add    %eax,(%eax)
     39b:	00 00                	add    %al,(%eax)
     39d:	00 00                	add    %al,(%eax)
     39f:	00 44 00 4c          	add    %al,0x4c(%eax,%eax,1)
     3a3:	00 44 01 00          	add    %al,0x0(%ecx,%eax,1)
     3a7:	00 00                	add    %al,(%eax)
     3a9:	00 00                	add    %al,(%eax)
     3ab:	00 44 00 4d          	add    %al,0x4d(%eax,%eax,1)
     3af:	00 45 01             	add    %al,0x1(%ebp)
     3b2:	00 00                	add    %al,(%eax)
     3b4:	00 00                	add    %al,(%eax)
     3b6:	00 00                	add    %al,(%eax)
     3b8:	44                   	inc    %esp
     3b9:	00 4e 00             	add    %cl,0x0(%esi)
     3bc:	69 01 00 00 00 00    	imul   $0x0,(%ecx),%eax
     3c2:	00 00                	add    %al,(%eax)
     3c4:	44                   	inc    %esp
     3c5:	00 50 00             	add    %dl,0x0(%eax)
     3c8:	70 01                	jo     3cb <bootmain-0x27fc35>
     3ca:	00 00                	add    %al,(%eax)
     3cc:	00 00                	add    %al,(%eax)
     3ce:	00 00                	add    %al,(%eax)
     3d0:	44                   	inc    %esp
     3d1:	00 51 00             	add    %dl,0x0(%ecx)
     3d4:	84 01                	test   %al,(%ecx)
     3d6:	00 00                	add    %al,(%eax)
     3d8:	00 00                	add    %al,(%eax)
     3da:	00 00                	add    %al,(%eax)
     3dc:	44                   	inc    %esp
     3dd:	00 52 00             	add    %dl,0x0(%edx)
     3e0:	91                   	xchg   %eax,%ecx
     3e1:	01 00                	add    %eax,(%eax)
     3e3:	00 00                	add    %al,(%eax)
     3e5:	00 00                	add    %al,(%eax)
     3e7:	00 44 00 53          	add    %al,0x53(%eax,%eax,1)
     3eb:	00 92 01 00 00 00    	add    %dl,0x1(%edx)
     3f1:	00 00                	add    %al,(%eax)
     3f3:	00 44 00 54          	add    %al,0x54(%eax,%eax,1)
     3f7:	00 a1 01 00 00 00    	add    %ah,0x1(%ecx)
     3fd:	00 00                	add    %al,(%eax)
     3ff:	00 44 00 55          	add    %al,0x55(%eax,%eax,1)
     403:	00 c0                	add    %al,%al
     405:	01 00                	add    %eax,(%eax)
     407:	00 00                	add    %al,(%eax)
     409:	00 00                	add    %al,(%eax)
     40b:	00 44 00 56          	add    %al,0x56(%eax,%eax,1)
     40f:	00 e4                	add    %ah,%ah
     411:	01 00                	add    %eax,(%eax)
     413:	00 00                	add    %al,(%eax)
     415:	00 00                	add    %al,(%eax)
     417:	00 44 00 57          	add    %al,0x57(%eax,%eax,1)
     41b:	00 fc                	add    %bh,%ah
     41d:	01 00                	add    %eax,(%eax)
     41f:	00 00                	add    %al,(%eax)
     421:	00 00                	add    %al,(%eax)
     423:	00 44 00 58          	add    %al,0x58(%eax,%eax,1)
     427:	00 09                	add    %cl,(%ecx)
     429:	02 00                	add    (%eax),%al
     42b:	00 00                	add    %al,(%eax)
     42d:	00 00                	add    %al,(%eax)
     42f:	00 44 00 59          	add    %al,0x59(%eax,%eax,1)
     433:	00 0a                	add    %cl,(%edx)
     435:	02 00                	add    (%eax),%al
     437:	00 00                	add    %al,(%eax)
     439:	00 00                	add    %al,(%eax)
     43b:	00 44 00 5a          	add    %al,0x5a(%eax,%eax,1)
     43f:	00 12                	add    %dl,(%edx)
     441:	02 00                	add    (%eax),%al
     443:	00 00                	add    %al,(%eax)
     445:	00 00                	add    %al,(%eax)
     447:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
     44b:	00 23                	add    %ah,(%ebx)
     44d:	02 00                	add    (%eax),%al
     44f:	00 00                	add    %al,(%eax)
     451:	00 00                	add    %al,(%eax)
     453:	00 44 00 5d          	add    %al,0x5d(%eax,%eax,1)
     457:	00 2a                	add    %ch,(%edx)
     459:	02 00                	add    (%eax),%al
     45b:	00 00                	add    %al,(%eax)
     45d:	00 00                	add    %al,(%eax)
     45f:	00 44 00 5f          	add    %al,0x5f(%eax,%eax,1)
     463:	00 33                	add    %dh,(%ebx)
     465:	02 00                	add    (%eax),%al
     467:	00 00                	add    %al,(%eax)
     469:	00 00                	add    %al,(%eax)
     46b:	00 44 00 5e          	add    %al,0x5e(%eax,%eax,1)
     46f:	00 3d 02 00 00 00    	add    %bh,0x2
     475:	00 00                	add    %al,(%eax)
     477:	00 44 00 5f          	add    %al,0x5f(%eax,%eax,1)
     47b:	00 3f                	add    %bh,(%edi)
     47d:	02 00                	add    (%eax),%al
     47f:	00 00                	add    %al,(%eax)
     481:	00 00                	add    %al,(%eax)
     483:	00 44 00 60          	add    %al,0x60(%eax,%eax,1)
     487:	00 5b 02             	add    %bl,0x2(%ebx)
     48a:	00 00                	add    %al,(%eax)
     48c:	00 00                	add    %al,(%eax)
     48e:	00 00                	add    %al,(%eax)
     490:	44                   	inc    %esp
     491:	00 61 00             	add    %ah,0x0(%ecx)
     494:	7d 02                	jge    498 <bootmain-0x27fb68>
     496:	00 00                	add    %al,(%eax)
     498:	00 00                	add    %al,(%eax)
     49a:	00 00                	add    %al,(%eax)
     49c:	44                   	inc    %esp
     49d:	00 62 00             	add    %ah,0x0(%edx)
     4a0:	99                   	cltd   
     4a1:	02 00                	add    (%eax),%al
     4a3:	00 d3                	add    %dl,%bl
     4a5:	06                   	push   %es
     4a6:	00 00                	add    %al,(%eax)
     4a8:	80 00 00             	addb   $0x0,(%eax)
     4ab:	00 50 ff             	add    %dl,-0x1(%eax)
     4ae:	ff                   	(bad)  
     4af:	ff ef                	ljmp   *<反汇编器内部错误>
     4b1:	06                   	push   %es
     4b2:	00 00                	add    %al,(%eax)
     4b4:	80 00 00             	addb   $0x0,(%eax)
     4b7:	00 30                	add    %dh,(%eax)
     4b9:	ff                   	(bad)  
     4ba:	ff                   	(bad)  
     4bb:	ff 10                	call   *(%eax)
     4bd:	07                   	pop    %es
     4be:	00 00                	add    %al,(%eax)
     4c0:	80 00 00             	addb   $0x0,(%eax)
     4c3:	00 78 ff             	add    %bh,-0x1(%eax)
     4c6:	ff                   	(bad)  
     4c7:	ff 00                	incl   (%eax)
     4c9:	00 00                	add    %al,(%eax)
     4cb:	00 c0                	add    %al,%al
	...
     4d5:	00 00                	add    %al,(%eax)
     4d7:	00 e0                	add    %ah,%al
     4d9:	00 00                	add    %al,(%eax)
     4db:	00 af 02 00 00 34    	add    %ch,0x34000002(%edi)
     4e1:	07                   	pop    %es
     4e2:	00 00                	add    %al,(%eax)
     4e4:	20 00                	and    %al,(%eax)
     4e6:	00 00                	add    %al,(%eax)
     4e8:	00 00                	add    %al,(%eax)
     4ea:	00 00                	add    %al,(%eax)
     4ec:	5d                   	pop    %ebp
     4ed:	07                   	pop    %es
     4ee:	00 00                	add    %al,(%eax)
     4f0:	20 00                	and    %al,(%eax)
     4f2:	00 00                	add    %al,(%eax)
     4f4:	00 00                	add    %al,(%eax)
     4f6:	00 00                	add    %al,(%eax)
     4f8:	84 07                	test   %al,(%edi)
     4fa:	00 00                	add    %al,(%eax)
     4fc:	20 00                	and    %al,(%eax)
	...
     506:	00 00                	add    %al,(%eax)
     508:	64 00 00             	add    %al,%fs:(%eax)
     50b:	00 af 02 28 00 99    	add    %ch,-0x66ffd7fe(%edi)
     511:	07                   	pop    %es
     512:	00 00                	add    %al,(%eax)
     514:	64 00 02             	add    %al,%fs:(%edx)
     517:	00 b0 02 28 00 08    	add    %dh,0x8002802(%eax)
     51d:	00 00                	add    %al,(%eax)
     51f:	00 3c 00             	add    %bh,(%eax,%eax,1)
     522:	00 00                	add    %al,(%eax)
     524:	00 00                	add    %al,(%eax)
     526:	00 00                	add    %al,(%eax)
     528:	17                   	pop    %ss
     529:	00 00                	add    %al,(%eax)
     52b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     531:	00 00                	add    %al,(%eax)
     533:	00 41 00             	add    %al,0x0(%ecx)
     536:	00 00                	add    %al,(%eax)
     538:	80 00 00             	addb   $0x0,(%eax)
     53b:	00 00                	add    %al,(%eax)
     53d:	00 00                	add    %al,(%eax)
     53f:	00 5b 00             	add    %bl,0x0(%ebx)
     542:	00 00                	add    %al,(%eax)
     544:	80 00 00             	addb   $0x0,(%eax)
     547:	00 00                	add    %al,(%eax)
     549:	00 00                	add    %al,(%eax)
     54b:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
     551:	00 00                	add    %al,(%eax)
     553:	00 00                	add    %al,(%eax)
     555:	00 00                	add    %al,(%eax)
     557:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
     55d:	00 00                	add    %al,(%eax)
     55f:	00 00                	add    %al,(%eax)
     561:	00 00                	add    %al,(%eax)
     563:	00 e1                	add    %ah,%cl
     565:	00 00                	add    %al,(%eax)
     567:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     56d:	00 00                	add    %al,(%eax)
     56f:	00 0c 01             	add    %cl,(%ecx,%eax,1)
     572:	00 00                	add    %al,(%eax)
     574:	80 00 00             	addb   $0x0,(%eax)
     577:	00 00                	add    %al,(%eax)
     579:	00 00                	add    %al,(%eax)
     57b:	00 37                	add    %dh,(%edi)
     57d:	01 00                	add    %eax,(%eax)
     57f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     585:	00 00                	add    %al,(%eax)
     587:	00 5d 01             	add    %bl,0x1(%ebp)
     58a:	00 00                	add    %al,(%eax)
     58c:	80 00 00             	addb   $0x0,(%eax)
     58f:	00 00                	add    %al,(%eax)
     591:	00 00                	add    %al,(%eax)
     593:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
     599:	00 00                	add    %al,(%eax)
     59b:	00 00                	add    %al,(%eax)
     59d:	00 00                	add    %al,(%eax)
     59f:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
     5a5:	00 00                	add    %al,(%eax)
     5a7:	00 00                	add    %al,(%eax)
     5a9:	00 00                	add    %al,(%eax)
     5ab:	00 d2                	add    %dl,%dl
     5ad:	01 00                	add    %eax,(%eax)
     5af:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     5b5:	00 00                	add    %al,(%eax)
     5b7:	00 ec                	add    %ch,%ah
     5b9:	01 00                	add    %eax,(%eax)
     5bb:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     5c1:	00 00                	add    %al,(%eax)
     5c3:	00 07                	add    %al,(%edi)
     5c5:	02 00                	add    (%eax),%al
     5c7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     5cd:	00 00                	add    %al,(%eax)
     5cf:	00 28                	add    %ch,(%eax)
     5d1:	02 00                	add    (%eax),%al
     5d3:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     5d9:	00 00                	add    %al,(%eax)
     5db:	00 47 02             	add    %al,0x2(%edi)
     5de:	00 00                	add    %al,(%eax)
     5e0:	80 00 00             	addb   $0x0,(%eax)
     5e3:	00 00                	add    %al,(%eax)
     5e5:	00 00                	add    %al,(%eax)
     5e7:	00 66 02             	add    %ah,0x2(%esi)
     5ea:	00 00                	add    %al,(%eax)
     5ec:	80 00 00             	addb   $0x0,(%eax)
     5ef:	00 00                	add    %al,(%eax)
     5f1:	00 00                	add    %al,(%eax)
     5f3:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
     5f9:	00 00                	add    %al,(%eax)
     5fb:	00 00                	add    %al,(%eax)
     5fd:	00 00                	add    %al,(%eax)
     5ff:	00 9b 02 00 00 c2    	add    %bl,-0x3dfffffe(%ebx)
     605:	00 00                	add    %al,(%eax)
     607:	00 f2                	add    %dh,%dl
     609:	aa                   	stos   %al,%es:(%edi)
     60a:	00 00                	add    %al,(%eax)
     60c:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
     60d:	02 00                	add    (%eax),%al
     60f:	00 c2                	add    %al,%dl
     611:	00 00                	add    %al,(%eax)
     613:	00 00                	add    %al,(%eax)
     615:	00 00                	add    %al,(%eax)
     617:	00 ae 02 00 00 c2    	add    %ch,-0x3dfffffe(%esi)
     61d:	00 00                	add    %al,(%eax)
     61f:	00 37                	add    %dh,(%edi)
     621:	53                   	push   %ebx
     622:	00 00                	add    %al,(%eax)
     624:	a2 07 00 00 24       	mov    %al,0x24000007
     629:	00 00                	add    %al,(%eax)
     62b:	00 b0 02 28 00 b7    	add    %dh,-0x48ffd7fe(%eax)
     631:	07                   	pop    %es
     632:	00 00                	add    %al,(%eax)
     634:	a0 00 00 00 08       	mov    0x8000000,%al
     639:	00 00                	add    %al,(%eax)
     63b:	00 00                	add    %al,(%eax)
     63d:	00 00                	add    %al,(%eax)
     63f:	00 44 00 04          	add    %al,0x4(%eax,%eax,1)
	...
     64b:	00 44 00 06          	add    %al,0x6(%eax,%eax,1)
     64f:	00 01                	add    %al,(%ecx)
     651:	00 00                	add    %al,(%eax)
     653:	00 00                	add    %al,(%eax)
     655:	00 00                	add    %al,(%eax)
     657:	00 44 00 04          	add    %al,0x4(%eax,%eax,1)
     65b:	00 06                	add    %al,(%esi)
     65d:	00 00                	add    %al,(%eax)
     65f:	00 00                	add    %al,(%eax)
     661:	00 00                	add    %al,(%eax)
     663:	00 44 00 04          	add    %al,0x4(%eax,%eax,1)
     667:	00 08                	add    %cl,(%eax)
     669:	00 00                	add    %al,(%eax)
     66b:	00 00                	add    %al,(%eax)
     66d:	00 00                	add    %al,(%eax)
     66f:	00 44 00 08          	add    %al,0x8(%eax,%eax,1)
     673:	00 0b                	add    %cl,(%ebx)
     675:	00 00                	add    %al,(%eax)
     677:	00 00                	add    %al,(%eax)
     679:	00 00                	add    %al,(%eax)
     67b:	00 44 00 06          	add    %al,0x6(%eax,%eax,1)
     67f:	00 0d 00 00 00 00    	add    %cl,0x0
     685:	00 00                	add    %al,(%eax)
     687:	00 44 00 0b          	add    %al,0xb(%eax,%eax,1)
     68b:	00 15 00 00 00 c4    	add    %dl,0xc4000000
     691:	07                   	pop    %es
     692:	00 00                	add    %al,(%eax)
     694:	40                   	inc    %eax
     695:	00 00                	add    %al,(%eax)
     697:	00 00                	add    %al,(%eax)
     699:	00 00                	add    %al,(%eax)
     69b:	00 cd                	add    %cl,%ch
     69d:	07                   	pop    %es
     69e:	00 00                	add    %al,(%eax)
     6a0:	40                   	inc    %eax
     6a1:	00 00                	add    %al,(%eax)
     6a3:	00 02                	add    %al,(%edx)
     6a5:	00 00                	add    %al,(%eax)
     6a7:	00 00                	add    %al,(%eax)
     6a9:	00 00                	add    %al,(%eax)
     6ab:	00 c0                	add    %al,%al
	...
     6b5:	00 00                	add    %al,(%eax)
     6b7:	00 e0                	add    %ah,%al
     6b9:	00 00                	add    %al,(%eax)
     6bb:	00 17                	add    %dl,(%edi)
     6bd:	00 00                	add    %al,(%eax)
     6bf:	00 da                	add    %bl,%dl
     6c1:	07                   	pop    %es
     6c2:	00 00                	add    %al,(%eax)
     6c4:	24 00                	and    $0x0,%al
     6c6:	00 00                	add    %al,(%eax)
     6c8:	c7 02 28 00 b7 07    	movl   $0x7b70028,(%edx)
     6ce:	00 00                	add    %al,(%eax)
     6d0:	a0 00 00 00 08       	mov    0x8000000,%al
     6d5:	00 00                	add    %al,(%eax)
     6d7:	00 00                	add    %al,(%eax)
     6d9:	00 00                	add    %al,(%eax)
     6db:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
	...
     6e7:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
     6eb:	00 01                	add    %al,(%ecx)
     6ed:	00 00                	add    %al,(%eax)
     6ef:	00 00                	add    %al,(%eax)
     6f1:	00 00                	add    %al,(%eax)
     6f3:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
     6f7:	00 06                	add    %al,(%esi)
     6f9:	00 00                	add    %al,(%eax)
     6fb:	00 00                	add    %al,(%eax)
     6fd:	00 00                	add    %al,(%eax)
     6ff:	00 44 00 13          	add    %al,0x13(%eax,%eax,1)
     703:	00 08                	add    %cl,(%eax)
     705:	00 00                	add    %al,(%eax)
     707:	00 00                	add    %al,(%eax)
     709:	00 00                	add    %al,(%eax)
     70b:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
     70f:	00 0a                	add    %cl,(%edx)
     711:	00 00                	add    %al,(%eax)
     713:	00 00                	add    %al,(%eax)
     715:	00 00                	add    %al,(%eax)
     717:	00 44 00 16          	add    %al,0x16(%eax,%eax,1)
     71b:	00 12                	add    %dl,(%edx)
     71d:	00 00                	add    %al,(%eax)
     71f:	00 c4                	add    %al,%ah
     721:	07                   	pop    %es
     722:	00 00                	add    %al,(%eax)
     724:	40                   	inc    %eax
	...
     72d:	00 00                	add    %al,(%eax)
     72f:	00 c0                	add    %al,%al
	...
     739:	00 00                	add    %al,(%eax)
     73b:	00 e0                	add    %ah,%al
     73d:	00 00                	add    %al,(%eax)
     73f:	00 14 00             	add    %dl,(%eax,%eax,1)
     742:	00 00                	add    %al,(%eax)
     744:	ef                   	out    %eax,(%dx)
     745:	07                   	pop    %es
     746:	00 00                	add    %al,(%eax)
     748:	24 00                	and    $0x0,%al
     74a:	00 00                	add    %al,(%eax)
     74c:	db 02                	fildl  (%edx)
     74e:	28 00                	sub    %al,(%eax)
     750:	03 08                	add    (%eax),%ecx
     752:	00 00                	add    %al,(%eax)
     754:	a0 00 00 00 08       	mov    0x8000000,%al
     759:	00 00                	add    %al,(%eax)
     75b:	00 10                	add    %dl,(%eax)
     75d:	08 00                	or     %al,(%eax)
     75f:	00 a0 00 00 00 0c    	add    %ah,0xc000000(%eax)
     765:	00 00                	add    %al,(%eax)
     767:	00 1b                	add    %bl,(%ebx)
     769:	08 00                	or     %al,(%eax)
     76b:	00 a0 00 00 00 10    	add    %ah,0x10000000(%eax)
     771:	00 00                	add    %al,(%eax)
     773:	00 00                	add    %al,(%eax)
     775:	00 00                	add    %al,(%eax)
     777:	00 44 00 37          	add    %al,0x37(%eax,%eax,1)
	...
     783:	00 44 00 37          	add    %al,0x37(%eax,%eax,1)
     787:	00 08                	add    %cl,(%eax)
     789:	00 00                	add    %al,(%eax)
     78b:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
     791:	00 00                	add    %al,(%eax)
     793:	00 e6                	add    %ah,%dh
     795:	02 28                	add    (%eax),%ch
     797:	00 00                	add    %al,(%eax)
     799:	00 00                	add    %al,(%eax)
     79b:	00 44 00 2c          	add    %al,0x2c(%eax,%eax,1)
     79f:	01 0b                	add    %ecx,(%ebx)
     7a1:	00 00                	add    %al,(%eax)
     7a3:	00 99 07 00 00 84    	add    %bl,-0x7bfffff9(%ecx)
     7a9:	00 00                	add    %al,(%eax)
     7ab:	00 e8                	add    %ch,%al
     7ad:	02 28                	add    (%eax),%ch
     7af:	00 00                	add    %al,(%eax)
     7b1:	00 00                	add    %al,(%eax)
     7b3:	00 44 00 3b          	add    %al,0x3b(%eax,%eax,1)
     7b7:	00 0d 00 00 00 a6    	add    %cl,0xa6000000
     7bd:	02 00                	add    (%eax),%al
     7bf:	00 84 00 00 00 e9 02 	add    %al,0x2e90000(%eax,%eax,1)
     7c6:	28 00                	sub    %al,(%eax)
     7c8:	00 00                	add    %al,(%eax)
     7ca:	00 00                	add    %al,(%eax)
     7cc:	44                   	inc    %esp
     7cd:	00 5c 00 0e          	add    %bl,0xe(%eax,%eax,1)
     7d1:	00 00                	add    %al,(%eax)
     7d3:	00 99 07 00 00 84    	add    %bl,-0x7bfffff9(%ecx)
     7d9:	00 00                	add    %al,(%eax)
     7db:	00 ee                	add    %ch,%dh
     7dd:	02 28                	add    (%eax),%ch
     7df:	00 00                	add    %al,(%eax)
     7e1:	00 00                	add    %al,(%eax)
     7e3:	00 44 00 3f          	add    %al,0x3f(%eax,%eax,1)
     7e7:	00 13                	add    %dl,(%ebx)
     7e9:	00 00                	add    %al,(%eax)
     7eb:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
     7f1:	00 00                	add    %al,(%eax)
     7f3:	00 f1                	add    %dh,%cl
     7f5:	02 28                	add    (%eax),%ch
     7f7:	00 00                	add    %al,(%eax)
     7f9:	00 00                	add    %al,(%eax)
     7fb:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
     7ff:	00 16                	add    %dl,(%esi)
     801:	00 00                	add    %al,(%eax)
     803:	00 99 07 00 00 84    	add    %bl,-0x7bfffff9(%ecx)
     809:	00 00                	add    %al,(%eax)
     80b:	00 f4                	add    %dh,%ah
     80d:	02 28                	add    (%eax),%ch
     80f:	00 00                	add    %al,(%eax)
     811:	00 00                	add    %al,(%eax)
     813:	00 44 00 40          	add    %al,0x40(%eax,%eax,1)
     817:	00 19                	add    %bl,(%ecx)
     819:	00 00                	add    %al,(%eax)
     81b:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
     821:	00 00                	add    %al,(%eax)
     823:	00 f9                	add    %bh,%cl
     825:	02 28                	add    (%eax),%ch
     827:	00 00                	add    %al,(%eax)
     829:	00 00                	add    %al,(%eax)
     82b:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
     82f:	00 1e                	add    %bl,(%esi)
     831:	00 00                	add    %al,(%eax)
     833:	00 99 07 00 00 84    	add    %bl,-0x7bfffff9(%ecx)
     839:	00 00                	add    %al,(%eax)
     83b:	00 04 03             	add    %al,(%ebx,%eax,1)
     83e:	28 00                	sub    %al,(%eax)
     840:	00 00                	add    %al,(%eax)
     842:	00 00                	add    %al,(%eax)
     844:	44                   	inc    %esp
     845:	00 45 00             	add    %al,0x0(%ebp)
     848:	29 00                	sub    %eax,(%eax)
     84a:	00 00                	add    %al,(%eax)
     84c:	00 00                	add    %al,(%eax)
     84e:	00 00                	add    %al,(%eax)
     850:	44                   	inc    %esp
     851:	00 40 00             	add    %al,0x0(%eax)
     854:	2c 00                	sub    $0x0,%al
     856:	00 00                	add    %al,(%eax)
     858:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
     859:	02 00                	add    (%eax),%al
     85b:	00 84 00 00 00 0a 03 	add    %al,0x30a0000(%eax,%eax,1)
     862:	28 00                	sub    %al,(%eax)
     864:	00 00                	add    %al,(%eax)
     866:	00 00                	add    %al,(%eax)
     868:	44                   	inc    %esp
     869:	00 33                	add    %dh,(%ebx)
     86b:	01 2f                	add    %ebp,(%edi)
     86d:	00 00                	add    %al,(%eax)
     86f:	00 99 07 00 00 84    	add    %bl,-0x7bfffff9(%ecx)
     875:	00 00                	add    %al,(%eax)
     877:	00 0c 03             	add    %cl,(%ebx,%eax,1)
     87a:	28 00                	sub    %al,(%eax)
     87c:	00 00                	add    %al,(%eax)
     87e:	00 00                	add    %al,(%eax)
     880:	44                   	inc    %esp
     881:	00 4b 00             	add    %cl,0x0(%ebx)
     884:	31 00                	xor    %eax,(%eax)
     886:	00 00                	add    %al,(%eax)
     888:	26 08 00             	or     %al,%es:(%eax)
     88b:	00 40 00             	add    %al,0x0(%eax)
     88e:	00 00                	add    %al,(%eax)
     890:	03 00                	add    (%eax),%eax
     892:	00 00                	add    %al,(%eax)
     894:	33 08                	xor    (%eax),%ecx
     896:	00 00                	add    %al,(%eax)
     898:	40                   	inc    %eax
     899:	00 00                	add    %al,(%eax)
     89b:	00 01                	add    %al,(%ecx)
     89d:	00 00                	add    %al,(%eax)
     89f:	00 3e                	add    %bh,(%esi)
     8a1:	08 00                	or     %al,(%eax)
     8a3:	00 24 00             	add    %ah,(%eax,%eax,1)
     8a6:	00 00                	add    %al,(%eax)
     8a8:	10 03                	adc    %al,(%ebx)
     8aa:	28 00                	sub    %al,(%eax)
     8ac:	00 00                	add    %al,(%eax)
     8ae:	00 00                	add    %al,(%eax)
     8b0:	44                   	inc    %esp
     8b1:	00 1b                	add    %bl,(%ebx)
	...
     8bb:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
     8bf:	00 01                	add    %al,(%ecx)
     8c1:	00 00                	add    %al,(%eax)
     8c3:	00 00                	add    %al,(%eax)
     8c5:	00 00                	add    %al,(%eax)
     8c7:	00 44 00 1b          	add    %al,0x1b(%eax,%eax,1)
     8cb:	00 06                	add    %al,(%esi)
     8cd:	00 00                	add    %al,(%eax)
     8cf:	00 00                	add    %al,(%eax)
     8d1:	00 00                	add    %al,(%eax)
     8d3:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
     8d7:	00 0a                	add    %cl,(%edx)
     8d9:	00 00                	add    %al,(%eax)
     8db:	00 00                	add    %al,(%eax)
     8dd:	00 00                	add    %al,(%eax)
     8df:	00 44 00 1b          	add    %al,0x1b(%eax,%eax,1)
     8e3:	00 0f                	add    %cl,(%edi)
     8e5:	00 00                	add    %al,(%eax)
     8e7:	00 00                	add    %al,(%eax)
     8e9:	00 00                	add    %al,(%eax)
     8eb:	00 44 00 32          	add    %al,0x32(%eax,%eax,1)
     8ef:	00 12                	add    %dl,(%edx)
     8f1:	00 00                	add    %al,(%eax)
     8f3:	00 00                	add    %al,(%eax)
     8f5:	00 00                	add    %al,(%eax)
     8f7:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
     8fb:	00 15 00 00 00 00    	add    %dl,0x0
     901:	00 00                	add    %al,(%eax)
     903:	00 44 00 32          	add    %al,0x32(%eax,%eax,1)
     907:	00 1a                	add    %bl,(%edx)
     909:	00 00                	add    %al,(%eax)
     90b:	00 00                	add    %al,(%eax)
     90d:	00 00                	add    %al,(%eax)
     90f:	00 44 00 33          	add    %al,0x33(%eax,%eax,1)
     913:	00 2a                	add    %ch,(%edx)
     915:	00 00                	add    %al,(%eax)
     917:	00 53 08             	add    %dl,0x8(%ebx)
     91a:	00 00                	add    %al,(%eax)
     91c:	80 00 00             	addb   $0x0,(%eax)
     91f:	00 d0                	add    %dl,%al
     921:	ff                   	(bad)  
     922:	ff                   	(bad)  
     923:	ff 00                	incl   (%eax)
     925:	00 00                	add    %al,(%eax)
     927:	00 c0                	add    %al,%al
	...
     931:	00 00                	add    %al,(%eax)
     933:	00 e0                	add    %ah,%al
     935:	00 00                	add    %al,(%eax)
     937:	00 31                	add    %dh,(%ecx)
     939:	00 00                	add    %al,(%eax)
     93b:	00 78 08             	add    %bh,0x8(%eax)
     93e:	00 00                	add    %al,(%eax)
     940:	24 00                	and    $0x0,%al
     942:	00 00                	add    %al,(%eax)
     944:	41                   	inc    %ecx
     945:	03 28                	add    (%eax),%ebp
     947:	00 89 08 00 00 a0    	add    %cl,-0x5ffffff8(%ecx)
     94d:	00 00                	add    %al,(%eax)
     94f:	00 08                	add    %cl,(%eax)
     951:	00 00                	add    %al,(%eax)
     953:	00 95 08 00 00 a0    	add    %dl,-0x5ffffff8(%ebp)
     959:	00 00                	add    %al,(%eax)
     95b:	00 0c 00             	add    %cl,(%eax,%eax,1)
     95e:	00 00                	add    %al,(%eax)
     960:	b7 07                	mov    $0x7,%bh
     962:	00 00                	add    %al,(%eax)
     964:	a0 00 00 00 10       	mov    0x10000000,%al
     969:	00 00                	add    %al,(%eax)
     96b:	00 a2 08 00 00 a0    	add    %ah,-0x5ffffff8(%edx)
     971:	00 00                	add    %al,(%eax)
     973:	00 14 00             	add    %dl,(%eax,%eax,1)
     976:	00 00                	add    %al,(%eax)
     978:	ac                   	lods   %ds:(%esi),%al
     979:	08 00                	or     %al,(%eax)
     97b:	00 a0 00 00 00 18    	add    %ah,0x18000000(%eax)
     981:	00 00                	add    %al,(%eax)
     983:	00 b6 08 00 00 a0    	add    %dh,-0x5ffffff8(%esi)
     989:	00 00                	add    %al,(%eax)
     98b:	00 1c 00             	add    %bl,(%eax,%eax,1)
     98e:	00 00                	add    %al,(%eax)
     990:	c0 08 00             	rorb   $0x0,(%eax)
     993:	00 a0 00 00 00 20    	add    %ah,0x20000000(%eax)
     999:	00 00                	add    %al,(%eax)
     99b:	00 00                	add    %al,(%eax)
     99d:	00 00                	add    %al,(%eax)
     99f:	00 44 00 4e          	add    %al,0x4e(%eax,%eax,1)
	...
     9ab:	00 44 00 4e          	add    %al,0x4e(%eax,%eax,1)
     9af:	00 0a                	add    %cl,(%edx)
     9b1:	00 00                	add    %al,(%eax)
     9b3:	00 00                	add    %al,(%eax)
     9b5:	00 00                	add    %al,(%eax)
     9b7:	00 44 00 50          	add    %al,0x50(%eax,%eax,1)
     9bb:	00 13                	add    %dl,(%ebx)
     9bd:	00 00                	add    %al,(%eax)
     9bf:	00 00                	add    %al,(%eax)
     9c1:	00 00                	add    %al,(%eax)
     9c3:	00 44 00 50          	add    %al,0x50(%eax,%eax,1)
     9c7:	00 18                	add    %bl,(%eax)
     9c9:	00 00                	add    %al,(%eax)
     9cb:	00 00                	add    %al,(%eax)
     9cd:	00 00                	add    %al,(%eax)
     9cf:	00 44 00 52          	add    %al,0x52(%eax,%eax,1)
     9d3:	00 1b                	add    %bl,(%ebx)
     9d5:	00 00                	add    %al,(%eax)
     9d7:	00 00                	add    %al,(%eax)
     9d9:	00 00                	add    %al,(%eax)
     9db:	00 44 00 54          	add    %al,0x54(%eax,%eax,1)
     9df:	00 20                	add    %ah,(%eax)
     9e1:	00 00                	add    %al,(%eax)
     9e3:	00 00                	add    %al,(%eax)
     9e5:	00 00                	add    %al,(%eax)
     9e7:	00 44 00 52          	add    %al,0x52(%eax,%eax,1)
     9eb:	00 23                	add    %ah,(%ebx)
     9ed:	00 00                	add    %al,(%eax)
     9ef:	00 00                	add    %al,(%eax)
     9f1:	00 00                	add    %al,(%eax)
     9f3:	00 44 00 50          	add    %al,0x50(%eax,%eax,1)
     9f7:	00 26                	add    %ah,(%esi)
     9f9:	00 00                	add    %al,(%eax)
     9fb:	00 00                	add    %al,(%eax)
     9fd:	00 00                	add    %al,(%eax)
     9ff:	00 44 00 58          	add    %al,0x58(%eax,%eax,1)
     a03:	00 2c 00             	add    %ch,(%eax,%eax,1)
     a06:	00 00                	add    %al,(%eax)
     a08:	ca 08 00             	lret   $0x8
     a0b:	00 40 00             	add    %al,0x0(%eax)
     a0e:	00 00                	add    %al,(%eax)
     a10:	03 00                	add    (%eax),%eax
     a12:	00 00                	add    %al,(%eax)
     a14:	d8 08                	fmuls  (%eax)
     a16:	00 00                	add    %al,(%eax)
     a18:	40                   	inc    %eax
     a19:	00 00                	add    %al,(%eax)
     a1b:	00 01                	add    %al,(%ecx)
     a1d:	00 00                	add    %al,(%eax)
     a1f:	00 e2                	add    %ah,%dl
     a21:	08 00                	or     %al,(%eax)
     a23:	00 24 00             	add    %ah,(%eax,%eax,1)
     a26:	00 00                	add    %al,(%eax)
     a28:	70 03                	jo     a2d <bootmain-0x27f5d3>
     a2a:	28 00                	sub    %al,(%eax)
     a2c:	b7 07                	mov    $0x7,%bh
     a2e:	00 00                	add    %al,(%eax)
     a30:	a0 00 00 00 08       	mov    0x8000000,%al
     a35:	00 00                	add    %al,(%eax)
     a37:	00 a2 08 00 00 a0    	add    %ah,-0x5ffffff8(%edx)
     a3d:	00 00                	add    %al,(%eax)
     a3f:	00 0c 00             	add    %cl,(%eax,%eax,1)
     a42:	00 00                	add    %al,(%eax)
     a44:	ac                   	lods   %ds:(%esi),%al
     a45:	08 00                	or     %al,(%eax)
     a47:	00 a0 00 00 00 10    	add    %ah,0x10000000(%eax)
     a4d:	00 00                	add    %al,(%eax)
     a4f:	00 b6 08 00 00 a0    	add    %dh,-0x5ffffff8(%esi)
     a55:	00 00                	add    %al,(%eax)
     a57:	00 14 00             	add    %dl,(%eax,%eax,1)
     a5a:	00 00                	add    %al,(%eax)
     a5c:	c0 08 00             	rorb   $0x0,(%eax)
     a5f:	00 a0 00 00 00 18    	add    %ah,0x18000000(%eax)
     a65:	00 00                	add    %al,(%eax)
     a67:	00 00                	add    %al,(%eax)
     a69:	00 00                	add    %al,(%eax)
     a6b:	00 44 00 5a          	add    %al,0x5a(%eax,%eax,1)
	...
     a77:	00 44 00 5b          	add    %al,0x5b(%eax,%eax,1)
     a7b:	00 03                	add    %al,(%ebx)
     a7d:	00 00                	add    %al,(%eax)
     a7f:	00 00                	add    %al,(%eax)
     a81:	00 00                	add    %al,(%eax)
     a83:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
     a87:	00 26                	add    %ah,(%esi)
     a89:	00 00                	add    %al,(%eax)
     a8b:	00 f2                	add    %dh,%dl
     a8d:	08 00                	or     %al,(%eax)
     a8f:	00 24 00             	add    %ah,(%eax,%eax,1)
     a92:	00 00                	add    %al,(%eax)
     a94:	98                   	cwtl   
     a95:	03 28                	add    (%eax),%ebp
     a97:	00 00                	add    %al,(%eax)
     a99:	00 00                	add    %al,(%eax)
     a9b:	00 44 00 5f          	add    %al,0x5f(%eax,%eax,1)
	...
     aa7:	00 44 00 66          	add    %al,0x66(%eax,%eax,1)
     aab:	00 03                	add    %al,(%ebx)
     aad:	00 00                	add    %al,(%eax)
     aaf:	00 00                	add    %al,(%eax)
     ab1:	00 00                	add    %al,(%eax)
     ab3:	00 44 00 68          	add    %al,0x68(%eax,%eax,1)
     ab7:	00 18                	add    %bl,(%eax)
     ab9:	00 00                	add    %al,(%eax)
     abb:	00 00                	add    %al,(%eax)
     abd:	00 00                	add    %al,(%eax)
     abf:	00 44 00 69          	add    %al,0x69(%eax,%eax,1)
     ac3:	00 30                	add    %dh,(%eax)
     ac5:	00 00                	add    %al,(%eax)
     ac7:	00 00                	add    %al,(%eax)
     ac9:	00 00                	add    %al,(%eax)
     acb:	00 44 00 6a          	add    %al,0x6a(%eax,%eax,1)
     acf:	00 4b 00             	add    %cl,0x0(%ebx)
     ad2:	00 00                	add    %al,(%eax)
     ad4:	00 00                	add    %al,(%eax)
     ad6:	00 00                	add    %al,(%eax)
     ad8:	44                   	inc    %esp
     ad9:	00 6e 00             	add    %ch,0x0(%esi)
     adc:	63 00                	arpl   %ax,(%eax)
     ade:	00 00                	add    %al,(%eax)
     ae0:	00 00                	add    %al,(%eax)
     ae2:	00 00                	add    %al,(%eax)
     ae4:	44                   	inc    %esp
     ae5:	00 6f 00             	add    %ch,0x0(%edi)
     ae8:	7b 00                	jnp    aea <bootmain-0x27f516>
     aea:	00 00                	add    %al,(%eax)
     aec:	00 00                	add    %al,(%eax)
     aee:	00 00                	add    %al,(%eax)
     af0:	44                   	inc    %esp
     af1:	00 70 00             	add    %dh,0x0(%eax)
     af4:	90                   	nop
     af5:	00 00                	add    %al,(%eax)
     af7:	00 00                	add    %al,(%eax)
     af9:	00 00                	add    %al,(%eax)
     afb:	00 44 00 71          	add    %al,0x71(%eax,%eax,1)
     aff:	00 a8 00 00 00 00    	add    %ch,0x0(%eax)
     b05:	00 00                	add    %al,(%eax)
     b07:	00 44 00 72          	add    %al,0x72(%eax,%eax,1)
     b0b:	00 bd 00 00 00 00    	add    %bh,0x0(%ebp)
     b11:	00 00                	add    %al,(%eax)
     b13:	00 44 00 73          	add    %al,0x73(%eax,%eax,1)
     b17:	00 d5                	add    %dl,%ch
     b19:	00 00                	add    %al,(%eax)
     b1b:	00 00                	add    %al,(%eax)
     b1d:	00 00                	add    %al,(%eax)
     b1f:	00 44 00 77          	add    %al,0x77(%eax,%eax,1)
     b23:	00 ea                	add    %ch,%dl
     b25:	00 00                	add    %al,(%eax)
     b27:	00 00                	add    %al,(%eax)
     b29:	00 00                	add    %al,(%eax)
     b2b:	00 44 00 78          	add    %al,0x78(%eax,%eax,1)
     b2f:	00 08                	add    %cl,(%eax)
     b31:	01 00                	add    %eax,(%eax)
     b33:	00 00                	add    %al,(%eax)
     b35:	00 00                	add    %al,(%eax)
     b37:	00 44 00 79          	add    %al,0x79(%eax,%eax,1)
     b3b:	00 23                	add    %ah,(%ebx)
     b3d:	01 00                	add    %eax,(%eax)
     b3f:	00 00                	add    %al,(%eax)
     b41:	00 00                	add    %al,(%eax)
     b43:	00 44 00 7a          	add    %al,0x7a(%eax,%eax,1)
     b47:	00 41 01             	add    %al,0x1(%ecx)
     b4a:	00 00                	add    %al,(%eax)
     b4c:	00 00                	add    %al,(%eax)
     b4e:	00 00                	add    %al,(%eax)
     b50:	44                   	inc    %esp
     b51:	00 7b 00             	add    %bh,0x0(%ebx)
     b54:	5f                   	pop    %edi
     b55:	01 00                	add    %eax,(%eax)
     b57:	00 06                	add    %al,(%esi)
     b59:	09 00                	or     %eax,(%eax)
     b5b:	00 24 00             	add    %ah,(%eax,%eax,1)
     b5e:	00 00                	add    %al,(%eax)
     b60:	f9                   	stc    
     b61:	04 28                	add    $0x28,%al
     b63:	00 1a                	add    %bl,(%edx)
     b65:	09 00                	or     %eax,(%eax)
     b67:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
     b6d:	00 00                	add    %al,(%eax)
     b6f:	00 00                	add    %al,(%eax)
     b71:	00 00                	add    %al,(%eax)
     b73:	00 44 00 7f          	add    %al,0x7f(%eax,%eax,1)
	...
     b7f:	00 44 00 7f          	add    %al,0x7f(%eax,%eax,1)
     b83:	00 03                	add    %al,(%ebx)
     b85:	00 00                	add    %al,(%eax)
     b87:	00 00                	add    %al,(%eax)
     b89:	00 00                	add    %al,(%eax)
     b8b:	00 44 00 80          	add    %al,-0x80(%eax,%eax,1)
     b8f:	00 06                	add    %al,(%esi)
     b91:	00 00                	add    %al,(%eax)
     b93:	00 00                	add    %al,(%eax)
     b95:	00 00                	add    %al,(%eax)
     b97:	00 44 00 81          	add    %al,-0x7f(%eax,%eax,1)
     b9b:	00 0d 00 00 00 00    	add    %cl,0x0
     ba1:	00 00                	add    %al,(%eax)
     ba3:	00 44 00 82          	add    %al,-0x7e(%eax,%eax,1)
     ba7:	00 11                	add    %dl,(%ecx)
     ba9:	00 00                	add    %al,(%eax)
     bab:	00 00                	add    %al,(%eax)
     bad:	00 00                	add    %al,(%eax)
     baf:	00 44 00 83          	add    %al,-0x7d(%eax,%eax,1)
     bb3:	00 17                	add    %dl,(%edi)
     bb5:	00 00                	add    %al,(%eax)
     bb7:	00 00                	add    %al,(%eax)
     bb9:	00 00                	add    %al,(%eax)
     bbb:	00 44 00 85          	add    %al,-0x7b(%eax,%eax,1)
     bbf:	00 1d 00 00 00 2f    	add    %bl,0x2f000000
     bc5:	09 00                	or     %eax,(%eax)
     bc7:	00 40 00             	add    %al,0x0(%eax)
     bca:	00 00                	add    %al,(%eax)
     bcc:	00 00                	add    %al,(%eax)
     bce:	00 00                	add    %al,(%eax)
     bd0:	3d 09 00 00 24       	cmp    $0x24000009,%eax
     bd5:	00 00                	add    %al,(%eax)
     bd7:	00 18                	add    %bl,(%eax)
     bd9:	05 28 00 50 09       	add    $0x9500028,%eax
     bde:	00 00                	add    %al,(%eax)
     be0:	a0 00 00 00 08       	mov    0x8000000,%al
     be5:	00 00                	add    %al,(%eax)
     be7:	00 5d 09             	add    %bl,0x9(%ebp)
     bea:	00 00                	add    %al,(%eax)
     bec:	a0 00 00 00 0c       	mov    0xc000000,%al
     bf1:	00 00                	add    %al,(%eax)
     bf3:	00 00                	add    %al,(%eax)
     bf5:	00 00                	add    %al,(%eax)
     bf7:	00 44 00 9c          	add    %al,-0x64(%eax,%eax,1)
	...
     c03:	00 44 00 9c          	add    %al,-0x64(%eax,%eax,1)
     c07:	00 0d 00 00 00 00    	add    %cl,0x0
     c0d:	00 00                	add    %al,(%eax)
     c0f:	00 44 00 9c          	add    %al,-0x64(%eax,%eax,1)
     c13:	00 0f                	add    %cl,(%edi)
     c15:	00 00                	add    %al,(%eax)
     c17:	00 00                	add    %al,(%eax)
     c19:	00 00                	add    %al,(%eax)
     c1b:	00 44 00 a5          	add    %al,-0x5b(%eax,%eax,1)
     c1f:	00 11                	add    %dl,(%ecx)
     c21:	00 00                	add    %al,(%eax)
     c23:	00 00                	add    %al,(%eax)
     c25:	00 00                	add    %al,(%eax)
     c27:	00 44 00 a8          	add    %al,-0x58(%eax,%eax,1)
     c2b:	00 27                	add    %ah,(%edi)
     c2d:	00 00                	add    %al,(%eax)
     c2f:	00 00                	add    %al,(%eax)
     c31:	00 00                	add    %al,(%eax)
     c33:	00 44 00 a7          	add    %al,-0x59(%eax,%eax,1)
     c37:	00 2d 00 00 00 00    	add    %ch,0x0
     c3d:	00 00                	add    %al,(%eax)
     c3f:	00 44 00 a9          	add    %al,-0x57(%eax,%eax,1)
     c43:	00 34 00             	add    %dh,(%eax,%eax,1)
     c46:	00 00                	add    %al,(%eax)
     c48:	00 00                	add    %al,(%eax)
     c4a:	00 00                	add    %al,(%eax)
     c4c:	44                   	inc    %esp
     c4d:	00 a3 00 38 00 00    	add    %ah,0x3800(%ebx)
     c53:	00 00                	add    %al,(%eax)
     c55:	00 00                	add    %al,(%eax)
     c57:	00 44 00 a1          	add    %al,-0x5f(%eax,%eax,1)
     c5b:	00 44 00 00          	add    %al,0x0(%eax,%eax,1)
     c5f:	00 00                	add    %al,(%eax)
     c61:	00 00                	add    %al,(%eax)
     c63:	00 44 00 b1          	add    %al,-0x4f(%eax,%eax,1)
     c67:	00 4c 00 00          	add    %cl,0x0(%eax,%eax,1)
     c6b:	00 67 09             	add    %ah,0x9(%edi)
     c6e:	00 00                	add    %al,(%eax)
     c70:	40                   	inc    %eax
     c71:	00 00                	add    %al,(%eax)
     c73:	00 00                	add    %al,(%eax)
     c75:	00 00                	add    %al,(%eax)
     c77:	00 70 09             	add    %dh,0x9(%eax)
     c7a:	00 00                	add    %al,(%eax)
     c7c:	40                   	inc    %eax
     c7d:	00 00                	add    %al,(%eax)
     c7f:	00 06                	add    %al,(%esi)
     c81:	00 00                	add    %al,(%eax)
     c83:	00 00                	add    %al,(%eax)
     c85:	00 00                	add    %al,(%eax)
     c87:	00 c0                	add    %al,%al
	...
     c91:	00 00                	add    %al,(%eax)
     c93:	00 e0                	add    %ah,%al
     c95:	00 00                	add    %al,(%eax)
     c97:	00 50 00             	add    %dl,0x0(%eax)
     c9a:	00 00                	add    %al,(%eax)
     c9c:	7a 09                	jp     ca7 <bootmain-0x27f359>
     c9e:	00 00                	add    %al,(%eax)
     ca0:	24 00                	and    $0x0,%al
     ca2:	00 00                	add    %al,(%eax)
     ca4:	68 05 28 00 90       	push   $0x90002805
     ca9:	09 00                	or     %eax,(%eax)
     cab:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
     cb1:	00 00                	add    %al,(%eax)
     cb3:	00 95 08 00 00 a0    	add    %dl,-0x5ffffff8(%ebp)
     cb9:	00 00                	add    %al,(%eax)
     cbb:	00 0c 00             	add    %cl,(%eax,%eax,1)
     cbe:	00 00                	add    %al,(%eax)
     cc0:	9c                   	pushf  
     cc1:	09 00                	or     %eax,(%eax)
     cc3:	00 a0 00 00 00 10    	add    %ah,0x10000000(%eax)
     cc9:	00 00                	add    %al,(%eax)
     ccb:	00 aa 09 00 00 a0    	add    %ch,-0x5ffffff7(%edx)
     cd1:	00 00                	add    %al,(%eax)
     cd3:	00 14 00             	add    %dl,(%eax,%eax,1)
     cd6:	00 00                	add    %al,(%eax)
     cd8:	b8 09 00 00 a0       	mov    $0xa0000009,%eax
     cdd:	00 00                	add    %al,(%eax)
     cdf:	00 18                	add    %bl,(%eax)
     ce1:	00 00                	add    %al,(%eax)
     ce3:	00 c3                	add    %al,%bl
     ce5:	09 00                	or     %eax,(%eax)
     ce7:	00 a0 00 00 00 1c    	add    %ah,0x1c000000(%eax)
     ced:	00 00                	add    %al,(%eax)
     cef:	00 ce                	add    %cl,%dh
     cf1:	09 00                	or     %eax,(%eax)
     cf3:	00 a0 00 00 00 20    	add    %ah,0x20000000(%eax)
     cf9:	00 00                	add    %al,(%eax)
     cfb:	00 d9                	add    %bl,%cl
     cfd:	09 00                	or     %eax,(%eax)
     cff:	00 a0 00 00 00 24    	add    %ah,0x24000000(%eax)
     d05:	00 00                	add    %al,(%eax)
     d07:	00 00                	add    %al,(%eax)
     d09:	00 00                	add    %al,(%eax)
     d0b:	00 44 00 b4          	add    %al,-0x4c(%eax,%eax,1)
	...
     d17:	00 44 00 b6          	add    %al,-0x4a(%eax,%eax,1)
     d1b:	00 07                	add    %al,(%edi)
     d1d:	00 00                	add    %al,(%eax)
     d1f:	00 00                	add    %al,(%eax)
     d21:	00 00                	add    %al,(%eax)
     d23:	00 44 00 b4          	add    %al,-0x4c(%eax,%eax,1)
     d27:	00 09                	add    %cl,(%ecx)
     d29:	00 00                	add    %al,(%eax)
     d2b:	00 00                	add    %al,(%eax)
     d2d:	00 00                	add    %al,(%eax)
     d2f:	00 44 00 b6          	add    %al,-0x4a(%eax,%eax,1)
     d33:	00 18                	add    %bl,(%eax)
     d35:	00 00                	add    %al,(%eax)
     d37:	00 00                	add    %al,(%eax)
     d39:	00 00                	add    %al,(%eax)
     d3b:	00 44 00 b6          	add    %al,-0x4a(%eax,%eax,1)
     d3f:	00 1f                	add    %bl,(%edi)
     d41:	00 00                	add    %al,(%eax)
     d43:	00 00                	add    %al,(%eax)
     d45:	00 00                	add    %al,(%eax)
     d47:	00 44 00 b8          	add    %al,-0x48(%eax,%eax,1)
     d4b:	00 24 00             	add    %ah,(%eax,%eax,1)
     d4e:	00 00                	add    %al,(%eax)
     d50:	00 00                	add    %al,(%eax)
     d52:	00 00                	add    %al,(%eax)
     d54:	44                   	inc    %esp
     d55:	00 ba 00 29 00 00    	add    %bh,0x2900(%edx)
     d5b:	00 00                	add    %al,(%eax)
     d5d:	00 00                	add    %al,(%eax)
     d5f:	00 44 00 bb          	add    %al,-0x45(%eax,%eax,1)
     d63:	00 33                	add    %dh,(%ebx)
     d65:	00 00                	add    %al,(%eax)
     d67:	00 00                	add    %al,(%eax)
     d69:	00 00                	add    %al,(%eax)
     d6b:	00 44 00 b8          	add    %al,-0x48(%eax,%eax,1)
     d6f:	00 39                	add    %bh,(%ecx)
     d71:	00 00                	add    %al,(%eax)
     d73:	00 00                	add    %al,(%eax)
     d75:	00 00                	add    %al,(%eax)
     d77:	00 44 00 b6          	add    %al,-0x4a(%eax,%eax,1)
     d7b:	00 3c 00             	add    %bh,(%eax,%eax,1)
     d7e:	00 00                	add    %al,(%eax)
     d80:	00 00                	add    %al,(%eax)
     d82:	00 00                	add    %al,(%eax)
     d84:	44                   	inc    %esp
     d85:	00 bf 00 45 00 00    	add    %bh,0x4500(%edi)
     d8b:	00 67 09             	add    %ah,0x9(%edi)
     d8e:	00 00                	add    %al,(%eax)
     d90:	40                   	inc    %eax
     d91:	00 00                	add    %al,(%eax)
     d93:	00 02                	add    %al,(%edx)
     d95:	00 00                	add    %al,(%eax)
     d97:	00 e7                	add    %ah,%bh
     d99:	09 00                	or     %eax,(%eax)
     d9b:	00 40 00             	add    %al,0x0(%eax)
     d9e:	00 00                	add    %al,(%eax)
     da0:	07                   	pop    %es
     da1:	00 00                	add    %al,(%eax)
     da3:	00 00                	add    %al,(%eax)
     da5:	00 00                	add    %al,(%eax)
     da7:	00 c0                	add    %al,%al
	...
     db1:	00 00                	add    %al,(%eax)
     db3:	00 e0                	add    %ah,%al
     db5:	00 00                	add    %al,(%eax)
     db7:	00 4a 00             	add    %cl,0x0(%edx)
     dba:	00 00                	add    %al,(%eax)
     dbc:	f0 09 00             	lock or %eax,(%eax)
     dbf:	00 26                	add    %ah,(%esi)
     dc1:	00 00                	add    %al,(%eax)
     dc3:	00 a0 28 28 00 00    	add    %ah,0x2828(%eax)
     dc9:	00 00                	add    %al,(%eax)
     dcb:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
     dcf:	00 b2 05 28 00 26    	add    %dh,0x26002805(%edx)
     dd5:	0a 00                	or     (%eax),%al
     dd7:	00 64 00 02          	add    %ah,0x2(%eax,%eax,1)
     ddb:	00 b4 05 28 00 08 00 	add    %dh,0x80028(%ebp,%eax,1)
     de2:	00 00                	add    %al,(%eax)
     de4:	3c 00                	cmp    $0x0,%al
     de6:	00 00                	add    %al,(%eax)
     de8:	00 00                	add    %al,(%eax)
     dea:	00 00                	add    %al,(%eax)
     dec:	17                   	pop    %ss
     ded:	00 00                	add    %al,(%eax)
     def:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     df5:	00 00                	add    %al,(%eax)
     df7:	00 41 00             	add    %al,0x0(%ecx)
     dfa:	00 00                	add    %al,(%eax)
     dfc:	80 00 00             	addb   $0x0,(%eax)
     dff:	00 00                	add    %al,(%eax)
     e01:	00 00                	add    %al,(%eax)
     e03:	00 5b 00             	add    %bl,0x0(%ebx)
     e06:	00 00                	add    %al,(%eax)
     e08:	80 00 00             	addb   $0x0,(%eax)
     e0b:	00 00                	add    %al,(%eax)
     e0d:	00 00                	add    %al,(%eax)
     e0f:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
     e15:	00 00                	add    %al,(%eax)
     e17:	00 00                	add    %al,(%eax)
     e19:	00 00                	add    %al,(%eax)
     e1b:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
     e21:	00 00                	add    %al,(%eax)
     e23:	00 00                	add    %al,(%eax)
     e25:	00 00                	add    %al,(%eax)
     e27:	00 e1                	add    %ah,%cl
     e29:	00 00                	add    %al,(%eax)
     e2b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     e31:	00 00                	add    %al,(%eax)
     e33:	00 0c 01             	add    %cl,(%ecx,%eax,1)
     e36:	00 00                	add    %al,(%eax)
     e38:	80 00 00             	addb   $0x0,(%eax)
     e3b:	00 00                	add    %al,(%eax)
     e3d:	00 00                	add    %al,(%eax)
     e3f:	00 37                	add    %dh,(%edi)
     e41:	01 00                	add    %eax,(%eax)
     e43:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     e49:	00 00                	add    %al,(%eax)
     e4b:	00 5d 01             	add    %bl,0x1(%ebp)
     e4e:	00 00                	add    %al,(%eax)
     e50:	80 00 00             	addb   $0x0,(%eax)
     e53:	00 00                	add    %al,(%eax)
     e55:	00 00                	add    %al,(%eax)
     e57:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
     e5d:	00 00                	add    %al,(%eax)
     e5f:	00 00                	add    %al,(%eax)
     e61:	00 00                	add    %al,(%eax)
     e63:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
     e69:	00 00                	add    %al,(%eax)
     e6b:	00 00                	add    %al,(%eax)
     e6d:	00 00                	add    %al,(%eax)
     e6f:	00 d2                	add    %dl,%dl
     e71:	01 00                	add    %eax,(%eax)
     e73:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     e79:	00 00                	add    %al,(%eax)
     e7b:	00 ec                	add    %ch,%ah
     e7d:	01 00                	add    %eax,(%eax)
     e7f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     e85:	00 00                	add    %al,(%eax)
     e87:	00 07                	add    %al,(%edi)
     e89:	02 00                	add    (%eax),%al
     e8b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     e91:	00 00                	add    %al,(%eax)
     e93:	00 28                	add    %ch,(%eax)
     e95:	02 00                	add    (%eax),%al
     e97:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     e9d:	00 00                	add    %al,(%eax)
     e9f:	00 47 02             	add    %al,0x2(%edi)
     ea2:	00 00                	add    %al,(%eax)
     ea4:	80 00 00             	addb   $0x0,(%eax)
     ea7:	00 00                	add    %al,(%eax)
     ea9:	00 00                	add    %al,(%eax)
     eab:	00 66 02             	add    %ah,0x2(%esi)
     eae:	00 00                	add    %al,(%eax)
     eb0:	80 00 00             	addb   $0x0,(%eax)
     eb3:	00 00                	add    %al,(%eax)
     eb5:	00 00                	add    %al,(%eax)
     eb7:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
     ebd:	00 00                	add    %al,(%eax)
     ebf:	00 00                	add    %al,(%eax)
     ec1:	00 00                	add    %al,(%eax)
     ec3:	00 9b 02 00 00 c2    	add    %bl,-0x3dfffffe(%ebx)
     ec9:	00 00                	add    %al,(%eax)
     ecb:	00 f2                	add    %dh,%dl
     ecd:	aa                   	stos   %al,%es:(%edi)
     ece:	00 00                	add    %al,(%eax)
     ed0:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
     ed1:	02 00                	add    (%eax),%al
     ed3:	00 c2                	add    %al,%dl
     ed5:	00 00                	add    %al,(%eax)
     ed7:	00 00                	add    %al,(%eax)
     ed9:	00 00                	add    %al,(%eax)
     edb:	00 ae 02 00 00 c2    	add    %ch,-0x3dfffffe(%esi)
     ee1:	00 00                	add    %al,(%eax)
     ee3:	00 37                	add    %dh,(%edi)
     ee5:	53                   	push   %ebx
     ee6:	00 00                	add    %al,(%eax)
     ee8:	00 00                	add    %al,(%eax)
     eea:	00 00                	add    %al,(%eax)
     eec:	64 00 00             	add    %al,%fs:(%eax)
     eef:	00 b4 05 28 00 2d 0a 	add    %dh,0xa2d0028(%ebp,%eax,1)
     ef6:	00 00                	add    %al,(%eax)
     ef8:	64 00 02             	add    %al,%fs:(%edx)
     efb:	00 b4 05 28 00 08 00 	add    %dh,0x80028(%ebp,%eax,1)
     f02:	00 00                	add    %al,(%eax)
     f04:	3c 00                	cmp    $0x0,%al
     f06:	00 00                	add    %al,(%eax)
     f08:	00 00                	add    %al,(%eax)
     f0a:	00 00                	add    %al,(%eax)
     f0c:	17                   	pop    %ss
     f0d:	00 00                	add    %al,(%eax)
     f0f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     f15:	00 00                	add    %al,(%eax)
     f17:	00 41 00             	add    %al,0x0(%ecx)
     f1a:	00 00                	add    %al,(%eax)
     f1c:	80 00 00             	addb   $0x0,(%eax)
     f1f:	00 00                	add    %al,(%eax)
     f21:	00 00                	add    %al,(%eax)
     f23:	00 5b 00             	add    %bl,0x0(%ebx)
     f26:	00 00                	add    %al,(%eax)
     f28:	80 00 00             	addb   $0x0,(%eax)
     f2b:	00 00                	add    %al,(%eax)
     f2d:	00 00                	add    %al,(%eax)
     f2f:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
     f35:	00 00                	add    %al,(%eax)
     f37:	00 00                	add    %al,(%eax)
     f39:	00 00                	add    %al,(%eax)
     f3b:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
     f41:	00 00                	add    %al,(%eax)
     f43:	00 00                	add    %al,(%eax)
     f45:	00 00                	add    %al,(%eax)
     f47:	00 e1                	add    %ah,%cl
     f49:	00 00                	add    %al,(%eax)
     f4b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     f51:	00 00                	add    %al,(%eax)
     f53:	00 0c 01             	add    %cl,(%ecx,%eax,1)
     f56:	00 00                	add    %al,(%eax)
     f58:	80 00 00             	addb   $0x0,(%eax)
     f5b:	00 00                	add    %al,(%eax)
     f5d:	00 00                	add    %al,(%eax)
     f5f:	00 37                	add    %dh,(%edi)
     f61:	01 00                	add    %eax,(%eax)
     f63:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     f69:	00 00                	add    %al,(%eax)
     f6b:	00 5d 01             	add    %bl,0x1(%ebp)
     f6e:	00 00                	add    %al,(%eax)
     f70:	80 00 00             	addb   $0x0,(%eax)
     f73:	00 00                	add    %al,(%eax)
     f75:	00 00                	add    %al,(%eax)
     f77:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
     f7d:	00 00                	add    %al,(%eax)
     f7f:	00 00                	add    %al,(%eax)
     f81:	00 00                	add    %al,(%eax)
     f83:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
     f89:	00 00                	add    %al,(%eax)
     f8b:	00 00                	add    %al,(%eax)
     f8d:	00 00                	add    %al,(%eax)
     f8f:	00 d2                	add    %dl,%dl
     f91:	01 00                	add    %eax,(%eax)
     f93:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     f99:	00 00                	add    %al,(%eax)
     f9b:	00 ec                	add    %ch,%ah
     f9d:	01 00                	add    %eax,(%eax)
     f9f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     fa5:	00 00                	add    %al,(%eax)
     fa7:	00 07                	add    %al,(%edi)
     fa9:	02 00                	add    (%eax),%al
     fab:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     fb1:	00 00                	add    %al,(%eax)
     fb3:	00 28                	add    %ch,(%eax)
     fb5:	02 00                	add    (%eax),%al
     fb7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
     fbd:	00 00                	add    %al,(%eax)
     fbf:	00 47 02             	add    %al,0x2(%edi)
     fc2:	00 00                	add    %al,(%eax)
     fc4:	80 00 00             	addb   $0x0,(%eax)
     fc7:	00 00                	add    %al,(%eax)
     fc9:	00 00                	add    %al,(%eax)
     fcb:	00 66 02             	add    %ah,0x2(%esi)
     fce:	00 00                	add    %al,(%eax)
     fd0:	80 00 00             	addb   $0x0,(%eax)
     fd3:	00 00                	add    %al,(%eax)
     fd5:	00 00                	add    %al,(%eax)
     fd7:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
     fdd:	00 00                	add    %al,(%eax)
     fdf:	00 00                	add    %al,(%eax)
     fe1:	00 00                	add    %al,(%eax)
     fe3:	00 9b 02 00 00 c2    	add    %bl,-0x3dfffffe(%ebx)
     fe9:	00 00                	add    %al,(%eax)
     feb:	00 f2                	add    %dh,%dl
     fed:	aa                   	stos   %al,%es:(%edi)
     fee:	00 00                	add    %al,(%eax)
     ff0:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
     ff1:	02 00                	add    (%eax),%al
     ff3:	00 c2                	add    %al,%dl
     ff5:	00 00                	add    %al,(%eax)
     ff7:	00 00                	add    %al,(%eax)
     ff9:	00 00                	add    %al,(%eax)
     ffb:	00 ae 02 00 00 c2    	add    %ch,-0x3dfffffe(%esi)
    1001:	00 00                	add    %al,(%eax)
    1003:	00 37                	add    %dh,(%edi)
    1005:	53                   	push   %ebx
    1006:	00 00                	add    %al,(%eax)
    1008:	35 0a 00 00 24       	xor    $0x2400000a,%eax
    100d:	00 00                	add    %al,(%eax)
    100f:	00 b4 05 28 00 42 0a 	add    %dh,0xa420028(%ebp,%eax,1)
    1016:	00 00                	add    %al,(%eax)
    1018:	a0 00 00 00 08       	mov    0x8000000,%al
    101d:	00 00                	add    %al,(%eax)
    101f:	00 ce                	add    %cl,%dh
    1021:	09 00                	or     %eax,(%eax)
    1023:	00 a0 00 00 00 0c    	add    %ah,0xc000000(%eax)
    1029:	00 00                	add    %al,(%eax)
    102b:	00 00                	add    %al,(%eax)
    102d:	00 00                	add    %al,(%eax)
    102f:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
	...
    103b:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    103f:	00 01                	add    %al,(%ecx)
    1041:	00 00                	add    %al,(%eax)
    1043:	00 00                	add    %al,(%eax)
    1045:	00 00                	add    %al,(%eax)
    1047:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
    104b:	00 03                	add    %al,(%ebx)
    104d:	00 00                	add    %al,(%eax)
    104f:	00 00                	add    %al,(%eax)
    1051:	00 00                	add    %al,(%eax)
    1053:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    1057:	00 05 00 00 00 00    	add    %al,0x0
    105d:	00 00                	add    %al,(%eax)
    105f:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
    1063:	00 0a                	add    %cl,(%edx)
    1065:	00 00                	add    %al,(%eax)
    1067:	00 00                	add    %al,(%eax)
    1069:	00 00                	add    %al,(%eax)
    106b:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
    106f:	00 10                	add    %dl,(%eax)
    1071:	00 00                	add    %al,(%eax)
    1073:	00 00                	add    %al,(%eax)
    1075:	00 00                	add    %al,(%eax)
    1077:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    107b:	00 13                	add    %dl,(%ebx)
    107d:	00 00                	add    %al,(%eax)
    107f:	00 00                	add    %al,(%eax)
    1081:	00 00                	add    %al,(%eax)
    1083:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
    1087:	00 16                	add    %dl,(%esi)
    1089:	00 00                	add    %al,(%eax)
    108b:	00 00                	add    %al,(%eax)
    108d:	00 00                	add    %al,(%eax)
    108f:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    1093:	00 19                	add    %bl,(%ecx)
    1095:	00 00                	add    %al,(%eax)
    1097:	00 00                	add    %al,(%eax)
    1099:	00 00                	add    %al,(%eax)
    109b:	00 44 00 0f          	add    %al,0xf(%eax,%eax,1)
    109f:	00 1e                	add    %bl,(%esi)
    10a1:	00 00                	add    %al,(%eax)
    10a3:	00 00                	add    %al,(%eax)
    10a5:	00 00                	add    %al,(%eax)
    10a7:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
    10ab:	00 22                	add    %ah,(%edx)
    10ad:	00 00                	add    %al,(%eax)
    10af:	00 00                	add    %al,(%eax)
    10b1:	00 00                	add    %al,(%eax)
    10b3:	00 44 00 12          	add    %al,0x12(%eax,%eax,1)
    10b7:	00 25 00 00 00 00    	add    %ah,0x0
    10bd:	00 00                	add    %al,(%eax)
    10bf:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
    10c3:	00 27                	add    %ah,(%edi)
    10c5:	00 00                	add    %al,(%eax)
    10c7:	00 00                	add    %al,(%eax)
    10c9:	00 00                	add    %al,(%eax)
    10cb:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
    10cf:	00 28                	add    %ch,(%eax)
    10d1:	00 00                	add    %al,(%eax)
    10d3:	00 00                	add    %al,(%eax)
    10d5:	00 00                	add    %al,(%eax)
    10d7:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    10db:	00 2a                	add    %ch,(%edx)
    10dd:	00 00                	add    %al,(%eax)
    10df:	00 00                	add    %al,(%eax)
    10e1:	00 00                	add    %al,(%eax)
    10e3:	00 44 00 1b          	add    %al,0x1b(%eax,%eax,1)
    10e7:	00 38                	add    %bh,(%eax)
    10e9:	00 00                	add    %al,(%eax)
    10eb:	00 00                	add    %al,(%eax)
    10ed:	00 00                	add    %al,(%eax)
    10ef:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    10f3:	00 3a                	add    %bh,(%edx)
    10f5:	00 00                	add    %al,(%eax)
    10f7:	00 00                	add    %al,(%eax)
    10f9:	00 00                	add    %al,(%eax)
    10fb:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
    10ff:	00 3d 00 00 00 00    	add    %bh,0x0
    1105:	00 00                	add    %al,(%eax)
    1107:	00 44 00 1b          	add    %al,0x1b(%eax,%eax,1)
    110b:	00 3f                	add    %bh,(%edi)
    110d:	00 00                	add    %al,(%eax)
    110f:	00 00                	add    %al,(%eax)
    1111:	00 00                	add    %al,(%eax)
    1113:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    1117:	00 41 00             	add    %al,0x0(%ecx)
    111a:	00 00                	add    %al,(%eax)
    111c:	00 00                	add    %al,(%eax)
    111e:	00 00                	add    %al,(%eax)
    1120:	44                   	inc    %esp
    1121:	00 1e                	add    %bl,(%esi)
    1123:	00 45 00             	add    %al,0x0(%ebp)
    1126:	00 00                	add    %al,(%eax)
    1128:	00 00                	add    %al,(%eax)
    112a:	00 00                	add    %al,(%eax)
    112c:	44                   	inc    %esp
    112d:	00 20                	add    %ah,(%eax)
    112f:	00 49 00             	add    %cl,0x0(%ecx)
    1132:	00 00                	add    %al,(%eax)
    1134:	00 00                	add    %al,(%eax)
    1136:	00 00                	add    %al,(%eax)
    1138:	44                   	inc    %esp
    1139:	00 21                	add    %ah,(%ecx)
    113b:	00 4a 00             	add    %cl,0x0(%edx)
    113e:	00 00                	add    %al,(%eax)
    1140:	00 00                	add    %al,(%eax)
    1142:	00 00                	add    %al,(%eax)
    1144:	44                   	inc    %esp
    1145:	00 24 00             	add    %ah,(%eax,%eax,1)
    1148:	56                   	push   %esi
    1149:	00 00                	add    %al,(%eax)
    114b:	00 00                	add    %al,(%eax)
    114d:	00 00                	add    %al,(%eax)
    114f:	00 44 00 27          	add    %al,0x27(%eax,%eax,1)
    1153:	00 5a 00             	add    %bl,0x0(%edx)
    1156:	00 00                	add    %al,(%eax)
    1158:	4f                   	dec    %edi
    1159:	0a 00                	or     (%eax),%al
    115b:	00 80 00 00 00 f6    	add    %al,-0xa000000(%eax)
    1161:	ff                   	(bad)  
    1162:	ff                   	(bad)  
    1163:	ff 70 0a             	pushl  0xa(%eax)
    1166:	00 00                	add    %al,(%eax)
    1168:	40                   	inc    %eax
    1169:	00 00                	add    %al,(%eax)
    116b:	00 02                	add    %al,(%edx)
    116d:	00 00                	add    %al,(%eax)
    116f:	00 7d 0a             	add    %bh,0xa(%ebp)
    1172:	00 00                	add    %al,(%eax)
    1174:	40                   	inc    %eax
    1175:	00 00                	add    %al,(%eax)
    1177:	00 03                	add    %al,(%ebx)
    1179:	00 00                	add    %al,(%eax)
    117b:	00 00                	add    %al,(%eax)
    117d:	00 00                	add    %al,(%eax)
    117f:	00 c0                	add    %al,%al
	...
    1189:	00 00                	add    %al,(%eax)
    118b:	00 e0                	add    %ah,%al
    118d:	00 00                	add    %al,(%eax)
    118f:	00 62 00             	add    %ah,0x0(%edx)
    1192:	00 00                	add    %al,(%eax)
    1194:	88 0a                	mov    %cl,(%edx)
    1196:	00 00                	add    %al,(%eax)
    1198:	24 00                	and    $0x0,%al
    119a:	00 00                	add    %al,(%eax)
    119c:	16                   	push   %ss
    119d:	06                   	push   %es
    119e:	28 00                	sub    %al,(%eax)
    11a0:	95                   	xchg   %eax,%ebp
    11a1:	0a 00                	or     (%eax),%al
    11a3:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    11a9:	00 00                	add    %al,(%eax)
    11ab:	00 ce                	add    %cl,%dh
    11ad:	09 00                	or     %eax,(%eax)
    11af:	00 a0 00 00 00 0c    	add    %ah,0xc000000(%eax)
    11b5:	00 00                	add    %al,(%eax)
    11b7:	00 00                	add    %al,(%eax)
    11b9:	00 00                	add    %al,(%eax)
    11bb:	00 44 00 30          	add    %al,0x30(%eax,%eax,1)
	...
    11c7:	00 44 00 31          	add    %al,0x31(%eax,%eax,1)
    11cb:	00 01                	add    %al,(%ecx)
    11cd:	00 00                	add    %al,(%eax)
    11cf:	00 00                	add    %al,(%eax)
    11d1:	00 00                	add    %al,(%eax)
    11d3:	00 44 00 30          	add    %al,0x30(%eax,%eax,1)
    11d7:	00 03                	add    %al,(%ebx)
    11d9:	00 00                	add    %al,(%eax)
    11db:	00 00                	add    %al,(%eax)
    11dd:	00 00                	add    %al,(%eax)
    11df:	00 44 00 31          	add    %al,0x31(%eax,%eax,1)
    11e3:	00 05 00 00 00 00    	add    %al,0x0
    11e9:	00 00                	add    %al,(%eax)
    11eb:	00 44 00 30          	add    %al,0x30(%eax,%eax,1)
    11ef:	00 0a                	add    %cl,(%edx)
    11f1:	00 00                	add    %al,(%eax)
    11f3:	00 00                	add    %al,(%eax)
    11f5:	00 00                	add    %al,(%eax)
    11f7:	00 44 00 30          	add    %al,0x30(%eax,%eax,1)
    11fb:	00 10                	add    %dl,(%eax)
    11fd:	00 00                	add    %al,(%eax)
    11ff:	00 00                	add    %al,(%eax)
    1201:	00 00                	add    %al,(%eax)
    1203:	00 44 00 31          	add    %al,0x31(%eax,%eax,1)
    1207:	00 13                	add    %dl,(%ebx)
    1209:	00 00                	add    %al,(%eax)
    120b:	00 00                	add    %al,(%eax)
    120d:	00 00                	add    %al,(%eax)
    120f:	00 44 00 32          	add    %al,0x32(%eax,%eax,1)
    1213:	00 18                	add    %bl,(%eax)
    1215:	00 00                	add    %al,(%eax)
    1217:	00 00                	add    %al,(%eax)
    1219:	00 00                	add    %al,(%eax)
    121b:	00 44 00 34          	add    %al,0x34(%eax,%eax,1)
    121f:	00 1b                	add    %bl,(%ebx)
    1221:	00 00                	add    %al,(%eax)
    1223:	00 00                	add    %al,(%eax)
    1225:	00 00                	add    %al,(%eax)
    1227:	00 44 00 35          	add    %al,0x35(%eax,%eax,1)
    122b:	00 1e                	add    %bl,(%esi)
    122d:	00 00                	add    %al,(%eax)
    122f:	00 00                	add    %al,(%eax)
    1231:	00 00                	add    %al,(%eax)
    1233:	00 44 00 3a          	add    %al,0x3a(%eax,%eax,1)
    1237:	00 25 00 00 00 00    	add    %ah,0x0
    123d:	00 00                	add    %al,(%eax)
    123f:	00 44 00 2a          	add    %al,0x2a(%eax,%eax,1)
    1243:	00 2c 00             	add    %ch,(%eax,%eax,1)
    1246:	00 00                	add    %al,(%eax)
    1248:	00 00                	add    %al,(%eax)
    124a:	00 00                	add    %al,(%eax)
    124c:	44                   	inc    %esp
    124d:	00 3e                	add    %bh,(%esi)
    124f:	00 38                	add    %bh,(%eax)
    1251:	00 00                	add    %al,(%eax)
    1253:	00 00                	add    %al,(%eax)
    1255:	00 00                	add    %al,(%eax)
    1257:	00 44 00 2d          	add    %al,0x2d(%eax,%eax,1)
    125b:	00 3c 00             	add    %bh,(%eax,%eax,1)
    125e:	00 00                	add    %al,(%eax)
    1260:	00 00                	add    %al,(%eax)
    1262:	00 00                	add    %al,(%eax)
    1264:	44                   	inc    %esp
    1265:	00 3e                	add    %bh,(%esi)
    1267:	00 3f                	add    %bh,(%edi)
    1269:	00 00                	add    %al,(%eax)
    126b:	00 00                	add    %al,(%eax)
    126d:	00 00                	add    %al,(%eax)
    126f:	00 44 00 3a          	add    %al,0x3a(%eax,%eax,1)
    1273:	00 41 00             	add    %al,0x0(%ecx)
    1276:	00 00                	add    %al,(%eax)
    1278:	00 00                	add    %al,(%eax)
    127a:	00 00                	add    %al,(%eax)
    127c:	44                   	inc    %esp
    127d:	00 41 00             	add    %al,0x0(%ecx)
    1280:	43                   	inc    %ebx
    1281:	00 00                	add    %al,(%eax)
    1283:	00 00                	add    %al,(%eax)
    1285:	00 00                	add    %al,(%eax)
    1287:	00 44 00 43          	add    %al,0x43(%eax,%eax,1)
    128b:	00 4a 00             	add    %cl,0x0(%edx)
    128e:	00 00                	add    %al,(%eax)
    1290:	00 00                	add    %al,(%eax)
    1292:	00 00                	add    %al,(%eax)
    1294:	44                   	inc    %esp
    1295:	00 44 00 4b          	add    %al,0x4b(%eax,%eax,1)
    1299:	00 00                	add    %al,(%eax)
    129b:	00 00                	add    %al,(%eax)
    129d:	00 00                	add    %al,(%eax)
    129f:	00 44 00 47          	add    %al,0x47(%eax,%eax,1)
    12a3:	00 55 00             	add    %dl,0x0(%ebp)
    12a6:	00 00                	add    %al,(%eax)
    12a8:	00 00                	add    %al,(%eax)
    12aa:	00 00                	add    %al,(%eax)
    12ac:	44                   	inc    %esp
    12ad:	00 4a 00             	add    %cl,0x0(%edx)
    12b0:	5a                   	pop    %edx
    12b1:	00 00                	add    %al,(%eax)
    12b3:	00 a2 0a 00 00 80    	add    %ah,-0x7ffffff6(%edx)
    12b9:	00 00                	add    %al,(%eax)
    12bb:	00 e2                	add    %ah,%dl
    12bd:	ff                   	(bad)  
    12be:	ff                   	(bad)  
    12bf:	ff                   	(bad)  
    12c0:	7d 0a                	jge    12cc <bootmain-0x27ed34>
    12c2:	00 00                	add    %al,(%eax)
    12c4:	40                   	inc    %eax
    12c5:	00 00                	add    %al,(%eax)
    12c7:	00 02                	add    %al,(%edx)
    12c9:	00 00                	add    %al,(%eax)
    12cb:	00 00                	add    %al,(%eax)
    12cd:	00 00                	add    %al,(%eax)
    12cf:	00 c0                	add    %al,%al
    12d1:	00 00                	add    %al,(%eax)
    12d3:	00 00                	add    %al,(%eax)
    12d5:	00 00                	add    %al,(%eax)
    12d7:	00 70 0a             	add    %dh,0xa(%eax)
    12da:	00 00                	add    %al,(%eax)
    12dc:	40                   	inc    %eax
    12dd:	00 00                	add    %al,(%eax)
    12df:	00 01                	add    %al,(%ecx)
    12e1:	00 00                	add    %al,(%eax)
    12e3:	00 00                	add    %al,(%eax)
    12e5:	00 00                	add    %al,(%eax)
    12e7:	00 c0                	add    %al,%al
    12e9:	00 00                	add    %al,(%eax)
    12eb:	00 2c 00             	add    %ch,(%eax,%eax,1)
    12ee:	00 00                	add    %al,(%eax)
    12f0:	00 00                	add    %al,(%eax)
    12f2:	00 00                	add    %al,(%eax)
    12f4:	e0 00                	loopne 12f6 <bootmain-0x27ed0a>
    12f6:	00 00                	add    %al,(%eax)
    12f8:	38 00                	cmp    %al,(%eax)
    12fa:	00 00                	add    %al,(%eax)
    12fc:	70 0a                	jo     1308 <bootmain-0x27ecf8>
    12fe:	00 00                	add    %al,(%eax)
    1300:	40                   	inc    %eax
    1301:	00 00                	add    %al,(%eax)
    1303:	00 01                	add    %al,(%ecx)
    1305:	00 00                	add    %al,(%eax)
    1307:	00 00                	add    %al,(%eax)
    1309:	00 00                	add    %al,(%eax)
    130b:	00 c0                	add    %al,%al
    130d:	00 00                	add    %al,(%eax)
    130f:	00 3c 00             	add    %bh,(%eax,%eax,1)
    1312:	00 00                	add    %al,(%eax)
    1314:	00 00                	add    %al,(%eax)
    1316:	00 00                	add    %al,(%eax)
    1318:	e0 00                	loopne 131a <bootmain-0x27ece6>
    131a:	00 00                	add    %al,(%eax)
    131c:	3f                   	aas    
    131d:	00 00                	add    %al,(%eax)
    131f:	00 00                	add    %al,(%eax)
    1321:	00 00                	add    %al,(%eax)
    1323:	00 e0                	add    %ah,%al
    1325:	00 00                	add    %al,(%eax)
    1327:	00 62 00             	add    %ah,0x0(%edx)
    132a:	00 00                	add    %al,(%eax)
    132c:	c4 0a                	les    (%edx),%ecx
    132e:	00 00                	add    %al,(%eax)
    1330:	24 00                	and    $0x0,%al
    1332:	00 00                	add    %al,(%eax)
    1334:	78 06                	js     133c <bootmain-0x27ecc4>
    1336:	28 00                	sub    %al,(%eax)
    1338:	d4 0a                	aam    $0xa
    133a:	00 00                	add    %al,(%eax)
    133c:	a0 00 00 00 08       	mov    0x8000000,%al
    1341:	00 00                	add    %al,(%eax)
    1343:	00 df                	add    %bl,%bh
    1345:	0a 00                	or     (%eax),%al
    1347:	00 a0 00 00 00 0c    	add    %ah,0xc000000(%eax)
    134d:	00 00                	add    %al,(%eax)
    134f:	00 00                	add    %al,(%eax)
    1351:	00 00                	add    %al,(%eax)
    1353:	00 44 00 51          	add    %al,0x51(%eax,%eax,1)
	...
    135f:	00 44 00 51          	add    %al,0x51(%eax,%eax,1)
    1363:	00 09                	add    %cl,(%ecx)
    1365:	00 00                	add    %al,(%eax)
    1367:	00 00                	add    %al,(%eax)
    1369:	00 00                	add    %al,(%eax)
    136b:	00 44 00 53          	add    %al,0x53(%eax,%eax,1)
    136f:	00 0c 00             	add    %cl,(%eax,%eax,1)
    1372:	00 00                	add    %al,(%eax)
    1374:	00 00                	add    %al,(%eax)
    1376:	00 00                	add    %al,(%eax)
    1378:	44                   	inc    %esp
    1379:	00 56 00             	add    %dl,0x0(%esi)
    137c:	0f 00 00             	sldt   (%eax)
    137f:	00 00                	add    %al,(%eax)
    1381:	00 00                	add    %al,(%eax)
    1383:	00 44 00 58          	add    %al,0x58(%eax,%eax,1)
    1387:	00 1f                	add    %bl,(%edi)
    1389:	00 00                	add    %al,(%eax)
    138b:	00 00                	add    %al,(%eax)
    138d:	00 00                	add    %al,(%eax)
    138f:	00 44 00 5a          	add    %al,0x5a(%eax,%eax,1)
    1393:	00 21                	add    %ah,(%ecx)
    1395:	00 00                	add    %al,(%eax)
    1397:	00 00                	add    %al,(%eax)
    1399:	00 00                	add    %al,(%eax)
    139b:	00 44 00 58          	add    %al,0x58(%eax,%eax,1)
    139f:	00 24 00             	add    %ah,(%eax,%eax,1)
    13a2:	00 00                	add    %al,(%eax)
    13a4:	00 00                	add    %al,(%eax)
    13a6:	00 00                	add    %al,(%eax)
    13a8:	44                   	inc    %esp
    13a9:	00 5a 00             	add    %bl,0x0(%edx)
    13ac:	26 00 00             	add    %al,%es:(%eax)
    13af:	00 00                	add    %al,(%eax)
    13b1:	00 00                	add    %al,(%eax)
    13b3:	00 44 00 5b          	add    %al,0x5b(%eax,%eax,1)
    13b7:	00 29                	add    %ch,(%ecx)
    13b9:	00 00                	add    %al,(%eax)
    13bb:	00 00                	add    %al,(%eax)
    13bd:	00 00                	add    %al,(%eax)
    13bf:	00 44 00 60          	add    %al,0x60(%eax,%eax,1)
    13c3:	00 2b                	add    %ch,(%ebx)
    13c5:	00 00                	add    %al,(%eax)
    13c7:	00 00                	add    %al,(%eax)
    13c9:	00 00                	add    %al,(%eax)
    13cb:	00 44 00 62          	add    %al,0x62(%eax,%eax,1)
    13cf:	00 3a                	add    %bh,(%edx)
    13d1:	00 00                	add    %al,(%eax)
    13d3:	00 00                	add    %al,(%eax)
    13d5:	00 00                	add    %al,(%eax)
    13d7:	00 44 00 62          	add    %al,0x62(%eax,%eax,1)
    13db:	00 4c 00 00          	add    %cl,0x0(%eax,%eax,1)
    13df:	00 00                	add    %al,(%eax)
    13e1:	00 00                	add    %al,(%eax)
    13e3:	00 44 00 62          	add    %al,0x62(%eax,%eax,1)
    13e7:	00 52 00             	add    %dl,0x0(%edx)
    13ea:	00 00                	add    %al,(%eax)
    13ec:	00 00                	add    %al,(%eax)
    13ee:	00 00                	add    %al,(%eax)
    13f0:	44                   	inc    %esp
    13f1:	00 63 00             	add    %ah,0x0(%ebx)
    13f4:	59                   	pop    %ecx
    13f5:	00 00                	add    %al,(%eax)
    13f7:	00 00                	add    %al,(%eax)
    13f9:	00 00                	add    %al,(%eax)
    13fb:	00 44 00 63          	add    %al,0x63(%eax,%eax,1)
    13ff:	00 6b 00             	add    %ch,0x0(%ebx)
    1402:	00 00                	add    %al,(%eax)
    1404:	00 00                	add    %al,(%eax)
    1406:	00 00                	add    %al,(%eax)
    1408:	44                   	inc    %esp
    1409:	00 63 00             	add    %ah,0x0(%ebx)
    140c:	71 00                	jno    140e <bootmain-0x27ebf2>
    140e:	00 00                	add    %al,(%eax)
    1410:	00 00                	add    %al,(%eax)
    1412:	00 00                	add    %al,(%eax)
    1414:	44                   	inc    %esp
    1415:	00 64 00 78          	add    %ah,0x78(%eax,%eax,1)
    1419:	00 00                	add    %al,(%eax)
    141b:	00 00                	add    %al,(%eax)
    141d:	00 00                	add    %al,(%eax)
    141f:	00 44 00 64          	add    %al,0x64(%eax,%eax,1)
    1423:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1429:	00 00                	add    %al,(%eax)
    142b:	00 44 00 64          	add    %al,0x64(%eax,%eax,1)
    142f:	00 87 00 00 00 00    	add    %al,0x0(%edi)
    1435:	00 00                	add    %al,(%eax)
    1437:	00 44 00 60          	add    %al,0x60(%eax,%eax,1)
    143b:	00 8d 00 00 00 00    	add    %cl,0x0(%ebp)
    1441:	00 00                	add    %al,(%eax)
    1443:	00 44 00 69          	add    %al,0x69(%eax,%eax,1)
    1447:	00 8f 00 00 00 00    	add    %cl,0x0(%edi)
    144d:	00 00                	add    %al,(%eax)
    144f:	00 44 00 68          	add    %al,0x68(%eax,%eax,1)
    1453:	00 92 00 00 00 00    	add    %dl,0x0(%edx)
    1459:	00 00                	add    %al,(%eax)
    145b:	00 44 00 69          	add    %al,0x69(%eax,%eax,1)
    145f:	00 95 00 00 00 00    	add    %dl,0x0(%ebp)
    1465:	00 00                	add    %al,(%eax)
    1467:	00 44 00 6e          	add    %al,0x6e(%eax,%eax,1)
    146b:	00 9f 00 00 00 00    	add    %bl,0x0(%edi)
    1471:	00 00                	add    %al,(%eax)
    1473:	00 44 00 70          	add    %al,0x70(%eax,%eax,1)
    1477:	00 a2 00 00 00 ed    	add    %ah,-0x13000000(%edx)
    147d:	0a 00                	or     (%eax),%al
    147f:	00 40 00             	add    %al,0x0(%eax)
    1482:	00 00                	add    %al,(%eax)
    1484:	06                   	push   %es
    1485:	00 00                	add    %al,(%eax)
    1487:	00 00                	add    %al,(%eax)
    1489:	0b 00                	or     (%eax),%eax
    148b:	00 80 00 00 00 f6    	add    %al,-0xa000000(%eax)
    1491:	ff                   	(bad)  
    1492:	ff                   	(bad)  
    1493:	ff 0e                	decl   (%esi)
    1495:	0b 00                	or     (%eax),%eax
    1497:	00 40 00             	add    %al,0x0(%eax)
    149a:	00 00                	add    %al,(%eax)
    149c:	03 00                	add    (%eax),%eax
    149e:	00 00                	add    %al,(%eax)
    14a0:	00 00                	add    %al,(%eax)
    14a2:	00 00                	add    %al,(%eax)
    14a4:	c0 00 00             	rolb   $0x0,(%eax)
	...
    14af:	00 e0                	add    %ah,%al
    14b1:	00 00                	add    %al,(%eax)
    14b3:	00 aa 00 00 00 19    	add    %ch,0x19000000(%edx)
    14b9:	0b 00                	or     (%eax),%eax
    14bb:	00 24 00             	add    %ah,(%eax,%eax,1)
    14be:	00 00                	add    %al,(%eax)
    14c0:	22 07                	and    (%edi),%al
    14c2:	28 00                	sub    %al,(%eax)
    14c4:	90                   	nop
    14c5:	09 00                	or     %eax,(%eax)
    14c7:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    14cd:	00 00                	add    %al,(%eax)
    14cf:	00 95 08 00 00 a0    	add    %dl,-0x5ffffff8(%ebp)
    14d5:	00 00                	add    %al,(%eax)
    14d7:	00 0c 00             	add    %cl,(%eax,%eax,1)
    14da:	00 00                	add    %al,(%eax)
    14dc:	2a 0b                	sub    (%ebx),%cl
    14de:	00 00                	add    %al,(%eax)
    14e0:	a0 00 00 00 10       	mov    0x10000000,%al
    14e5:	00 00                	add    %al,(%eax)
    14e7:	00 33                	add    %dh,(%ebx)
    14e9:	0b 00                	or     (%eax),%eax
    14eb:	00 a0 00 00 00 14    	add    %ah,0x14000000(%eax)
    14f1:	00 00                	add    %al,(%eax)
    14f3:	00 b7 07 00 00 a0    	add    %dh,-0x5ffffff9(%edi)
    14f9:	00 00                	add    %al,(%eax)
    14fb:	00 18                	add    %bl,(%eax)
    14fd:	00 00                	add    %al,(%eax)
    14ff:	00 3c 0b             	add    %bh,(%ebx,%ecx,1)
    1502:	00 00                	add    %al,(%eax)
    1504:	a0 00 00 00 1c       	mov    0x1c000000,%al
    1509:	00 00                	add    %al,(%eax)
    150b:	00 00                	add    %al,(%eax)
    150d:	00 00                	add    %al,(%eax)
    150f:	00 44 00 94          	add    %al,-0x6c(%eax,%eax,1)
	...
    151b:	00 44 00 94          	add    %al,-0x6c(%eax,%eax,1)
    151f:	00 0c 00             	add    %cl,(%eax,%eax,1)
    1522:	00 00                	add    %al,(%eax)
    1524:	00 00                	add    %al,(%eax)
    1526:	00 00                	add    %al,(%eax)
    1528:	44                   	inc    %esp
    1529:	00 97 00 26 00 00    	add    %dl,0x2600(%edi)
    152f:	00 00                	add    %al,(%eax)
    1531:	00 00                	add    %al,(%eax)
    1533:	00 44 00 9a          	add    %al,-0x66(%eax,%eax,1)
    1537:	00 2b                	add    %ch,(%ebx)
    1539:	00 00                	add    %al,(%eax)
    153b:	00 00                	add    %al,(%eax)
    153d:	00 00                	add    %al,(%eax)
    153f:	00 44 00 9c          	add    %al,-0x64(%eax,%eax,1)
    1543:	00 30                	add    %dh,(%eax)
    1545:	00 00                	add    %al,(%eax)
    1547:	00 00                	add    %al,(%eax)
    1549:	00 00                	add    %al,(%eax)
    154b:	00 44 00 9e          	add    %al,-0x62(%eax,%eax,1)
    154f:	00 42 00             	add    %al,0x0(%edx)
    1552:	00 00                	add    %al,(%eax)
    1554:	00 00                	add    %al,(%eax)
    1556:	00 00                	add    %al,(%eax)
    1558:	44                   	inc    %esp
    1559:	00 9a 00 48 00 00    	add    %bl,0x4800(%edx)
    155f:	00 00                	add    %al,(%eax)
    1561:	00 00                	add    %al,(%eax)
    1563:	00 44 00 97          	add    %al,-0x69(%eax,%eax,1)
    1567:	00 4e 00             	add    %cl,0x0(%esi)
    156a:	00 00                	add    %al,(%eax)
    156c:	00 00                	add    %al,(%eax)
    156e:	00 00                	add    %al,(%eax)
    1570:	44                   	inc    %esp
    1571:	00 aa 00 5a 00 00    	add    %ch,0x5a00(%edx)
    1577:	00 48 0b             	add    %cl,0xb(%eax)
    157a:	00 00                	add    %al,(%eax)
    157c:	40                   	inc    %eax
    157d:	00 00                	add    %al,(%eax)
    157f:	00 00                	add    %al,(%eax)
    1581:	00 00                	add    %al,(%eax)
    1583:	00 53 0b             	add    %dl,0xb(%ebx)
    1586:	00 00                	add    %al,(%eax)
    1588:	40                   	inc    %eax
    1589:	00 00                	add    %al,(%eax)
    158b:	00 01                	add    %al,(%ecx)
    158d:	00 00                	add    %al,(%eax)
    158f:	00 00                	add    %al,(%eax)
    1591:	00 00                	add    %al,(%eax)
    1593:	00 c0                	add    %al,%al
	...
    159d:	00 00                	add    %al,(%eax)
    159f:	00 e0                	add    %ah,%al
    15a1:	00 00                	add    %al,(%eax)
    15a3:	00 62 00             	add    %ah,0x0(%edx)
    15a6:	00 00                	add    %al,(%eax)
    15a8:	5e                   	pop    %esi
    15a9:	0b 00                	or     (%eax),%eax
    15ab:	00 24 00             	add    %ah,(%eax,%eax,1)
    15ae:	00 00                	add    %al,(%eax)
    15b0:	84 07                	test   %al,(%edi)
    15b2:	28 00                	sub    %al,(%eax)
    15b4:	90                   	nop
    15b5:	09 00                	or     %eax,(%eax)
    15b7:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    15bd:	00 00                	add    %al,(%eax)
    15bf:	00 95 08 00 00 a0    	add    %dl,-0x5ffffff8(%ebp)
    15c5:	00 00                	add    %al,(%eax)
    15c7:	00 0c 00             	add    %cl,(%eax,%eax,1)
    15ca:	00 00                	add    %al,(%eax)
    15cc:	2a 0b                	sub    (%ebx),%cl
    15ce:	00 00                	add    %al,(%eax)
    15d0:	a0 00 00 00 10       	mov    0x10000000,%al
    15d5:	00 00                	add    %al,(%eax)
    15d7:	00 33                	add    %dh,(%ebx)
    15d9:	0b 00                	or     (%eax),%eax
    15db:	00 a0 00 00 00 14    	add    %ah,0x14000000(%eax)
    15e1:	00 00                	add    %al,(%eax)
    15e3:	00 b7 07 00 00 a0    	add    %dh,-0x5ffffff9(%edi)
    15e9:	00 00                	add    %al,(%eax)
    15eb:	00 18                	add    %bl,(%eax)
    15ed:	00 00                	add    %al,(%eax)
    15ef:	00 3c 0b             	add    %bh,(%ebx,%ecx,1)
    15f2:	00 00                	add    %al,(%eax)
    15f4:	a0 00 00 00 1c       	mov    0x1c000000,%al
    15f9:	00 00                	add    %al,(%eax)
    15fb:	00 00                	add    %al,(%eax)
    15fd:	00 00                	add    %al,(%eax)
    15ff:	00 44 00 73          	add    %al,0x73(%eax,%eax,1)
	...
    160b:	00 44 00 7f          	add    %al,0x7f(%eax,%eax,1)
    160f:	00 08                	add    %cl,(%eax)
    1611:	00 00                	add    %al,(%eax)
    1613:	00 00                	add    %al,(%eax)
    1615:	00 00                	add    %al,(%eax)
    1617:	00 44 00 73          	add    %al,0x73(%eax,%eax,1)
    161b:	00 0c 00             	add    %cl,(%eax,%eax,1)
    161e:	00 00                	add    %al,(%eax)
    1620:	00 00                	add    %al,(%eax)
    1622:	00 00                	add    %al,(%eax)
    1624:	44                   	inc    %esp
    1625:	00 73 00             	add    %dh,0x0(%ebx)
    1628:	0d 00 00 00 00       	or     $0x0,%eax
    162d:	00 00                	add    %al,(%eax)
    162f:	00 44 00 75          	add    %al,0x75(%eax,%eax,1)
    1633:	00 10                	add    %dl,(%eax)
    1635:	00 00                	add    %al,(%eax)
    1637:	00 00                	add    %al,(%eax)
    1639:	00 00                	add    %al,(%eax)
    163b:	00 44 00 77          	add    %al,0x77(%eax,%eax,1)
    163f:	00 1a                	add    %bl,(%edx)
    1641:	00 00                	add    %al,(%eax)
    1643:	00 00                	add    %al,(%eax)
    1645:	00 00                	add    %al,(%eax)
    1647:	00 44 00 7a          	add    %al,0x7a(%eax,%eax,1)
    164b:	00 1e                	add    %bl,(%esi)
    164d:	00 00                	add    %al,(%eax)
    164f:	00 00                	add    %al,(%eax)
    1651:	00 00                	add    %al,(%eax)
    1653:	00 44 00 7f          	add    %al,0x7f(%eax,%eax,1)
    1657:	00 23                	add    %ah,(%ebx)
    1659:	00 00                	add    %al,(%eax)
    165b:	00 00                	add    %al,(%eax)
    165d:	00 00                	add    %al,(%eax)
    165f:	00 44 00 80          	add    %al,-0x80(%eax,%eax,1)
    1663:	00 2f                	add    %ch,(%edi)
    1665:	00 00                	add    %al,(%eax)
    1667:	00 00                	add    %al,(%eax)
    1669:	00 00                	add    %al,(%eax)
    166b:	00 44 00 7f          	add    %al,0x7f(%eax,%eax,1)
    166f:	00 32                	add    %dh,(%edx)
    1671:	00 00                	add    %al,(%eax)
    1673:	00 00                	add    %al,(%eax)
    1675:	00 00                	add    %al,(%eax)
    1677:	00 44 00 81          	add    %al,-0x7f(%eax,%eax,1)
    167b:	00 3d 00 00 00 00    	add    %bh,0x0
    1681:	00 00                	add    %al,(%eax)
    1683:	00 44 00 84          	add    %al,-0x7c(%eax,%eax,1)
    1687:	00 48 00             	add    %cl,0x0(%eax)
    168a:	00 00                	add    %al,(%eax)
    168c:	00 00                	add    %al,(%eax)
    168e:	00 00                	add    %al,(%eax)
    1690:	44                   	inc    %esp
    1691:	00 85 00 4b 00 00    	add    %al,0x4b00(%ebp)
    1697:	00 00                	add    %al,(%eax)
    1699:	00 00                	add    %al,(%eax)
    169b:	00 44 00 88          	add    %al,-0x78(%eax,%eax,1)
    169f:	00 53 00             	add    %dl,0x0(%ebx)
    16a2:	00 00                	add    %al,(%eax)
    16a4:	00 00                	add    %al,(%eax)
    16a6:	00 00                	add    %al,(%eax)
    16a8:	44                   	inc    %esp
    16a9:	00 87 00 55 00 00    	add    %al,0x5500(%edi)
    16af:	00 00                	add    %al,(%eax)
    16b1:	00 00                	add    %al,(%eax)
    16b3:	00 44 00 8e          	add    %al,-0x72(%eax,%eax,1)
    16b7:	00 57 00             	add    %dl,0x0(%edi)
    16ba:	00 00                	add    %al,(%eax)
    16bc:	00 00                	add    %al,(%eax)
    16be:	00 00                	add    %al,(%eax)
    16c0:	44                   	inc    %esp
    16c1:	00 91 00 5c 00 00    	add    %dl,0x5c00(%ecx)
    16c7:	00 67 09             	add    %ah,0x9(%edi)
    16ca:	00 00                	add    %al,(%eax)
    16cc:	40                   	inc    %eax
    16cd:	00 00                	add    %al,(%eax)
    16cf:	00 03                	add    %al,(%ebx)
    16d1:	00 00                	add    %al,(%eax)
    16d3:	00 e7                	add    %ah,%bh
    16d5:	09 00                	or     %eax,(%eax)
    16d7:	00 40 00             	add    %al,0x0(%eax)
    16da:	00 00                	add    %al,(%eax)
    16dc:	07                   	pop    %es
    16dd:	00 00                	add    %al,(%eax)
    16df:	00 6c 0b 00          	add    %ch,0x0(%ebx,%ecx,1)
    16e3:	00 24 00             	add    %ah,(%eax,%eax,1)
    16e6:	00 00                	add    %al,(%eax)
    16e8:	e8 07 28 00 7f       	call   7f003ef4 <hehe+0x7ed80e88>
    16ed:	0b 00                	or     (%eax),%eax
    16ef:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    16f5:	00 00                	add    %al,(%eax)
    16f7:	00 2a                	add    %ch,(%edx)
    16f9:	0b 00                	or     (%eax),%eax
    16fb:	00 a0 00 00 00 0c    	add    %ah,0xc000000(%eax)
    1701:	00 00                	add    %al,(%eax)
    1703:	00 00                	add    %al,(%eax)
    1705:	00 00                	add    %al,(%eax)
    1707:	00 44 00 05          	add    %al,0x5(%eax,%eax,1)
	...
    1713:	00 44 00 07          	add    %al,0x7(%eax,%eax,1)
    1717:	00 07                	add    %al,(%edi)
    1719:	00 00                	add    %al,(%eax)
    171b:	00 00                	add    %al,(%eax)
    171d:	00 00                	add    %al,(%eax)
    171f:	00 44 00 08          	add    %al,0x8(%eax,%eax,1)
    1723:	00 18                	add    %bl,(%eax)
    1725:	00 00                	add    %al,(%eax)
    1727:	00 00                	add    %al,(%eax)
    1729:	00 00                	add    %al,(%eax)
    172b:	00 44 00 0a          	add    %al,0xa(%eax,%eax,1)
    172f:	00 35 00 00 00 88    	add    %dh,0x88000000
    1735:	0b 00                	or     (%eax),%eax
    1737:	00 80 00 00 00 e2    	add    %al,-0x1e000000(%eax)
    173d:	ff                   	(bad)  
    173e:	ff                   	(bad)  
    173f:	ff 00                	incl   (%eax)
    1741:	00 00                	add    %al,(%eax)
    1743:	00 c0                	add    %al,%al
	...
    174d:	00 00                	add    %al,(%eax)
    174f:	00 e0                	add    %ah,%al
    1751:	00 00                	add    %al,(%eax)
    1753:	00 3a                	add    %bh,(%edx)
    1755:	00 00                	add    %al,(%eax)
    1757:	00 94 0b 00 00 24 00 	add    %dl,0x240000(%ebx,%ecx,1)
    175e:	00 00                	add    %al,(%eax)
    1760:	22 08                	and    (%eax),%cl
    1762:	28 00                	sub    %al,(%eax)
    1764:	90                   	nop
    1765:	09 00                	or     %eax,(%eax)
    1767:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    176d:	00 00                	add    %al,(%eax)
    176f:	00 95 08 00 00 a0    	add    %dl,-0x5ffffff8(%ebp)
    1775:	00 00                	add    %al,(%eax)
    1777:	00 0c 00             	add    %cl,(%eax,%eax,1)
    177a:	00 00                	add    %al,(%eax)
    177c:	2a 0b                	sub    (%ebx),%cl
    177e:	00 00                	add    %al,(%eax)
    1780:	a0 00 00 00 10       	mov    0x10000000,%al
    1785:	00 00                	add    %al,(%eax)
    1787:	00 33                	add    %dh,(%ebx)
    1789:	0b 00                	or     (%eax),%eax
    178b:	00 a0 00 00 00 14    	add    %ah,0x14000000(%eax)
    1791:	00 00                	add    %al,(%eax)
    1793:	00 b7 07 00 00 a0    	add    %dh,-0x5ffffff9(%edi)
    1799:	00 00                	add    %al,(%eax)
    179b:	00 18                	add    %bl,(%eax)
    179d:	00 00                	add    %al,(%eax)
    179f:	00 a6 0b 00 00 a0    	add    %ah,-0x5ffffff5(%esi)
    17a5:	00 00                	add    %al,(%eax)
    17a7:	00 1c 00             	add    %bl,(%eax,%eax,1)
    17aa:	00 00                	add    %al,(%eax)
    17ac:	00 00                	add    %al,(%eax)
    17ae:	00 00                	add    %al,(%eax)
    17b0:	44                   	inc    %esp
    17b1:	00 c6                	add    %al,%dh
	...
    17bb:	00 44 00 ca          	add    %al,-0x36(%eax,%eax,1)
    17bf:	00 01                	add    %al,(%ecx)
    17c1:	00 00                	add    %al,(%eax)
    17c3:	00 00                	add    %al,(%eax)
    17c5:	00 00                	add    %al,(%eax)
    17c7:	00 44 00 c6          	add    %al,-0x3a(%eax,%eax,1)
    17cb:	00 03                	add    %al,(%ebx)
    17cd:	00 00                	add    %al,(%eax)
    17cf:	00 00                	add    %al,(%eax)
    17d1:	00 00                	add    %al,(%eax)
    17d3:	00 44 00 c6          	add    %al,-0x3a(%eax,%eax,1)
    17d7:	00 0a                	add    %cl,(%edx)
    17d9:	00 00                	add    %al,(%eax)
    17db:	00 00                	add    %al,(%eax)
    17dd:	00 00                	add    %al,(%eax)
    17df:	00 44 00 cf          	add    %al,-0x31(%eax,%eax,1)
    17e3:	00 17                	add    %dl,(%edi)
    17e5:	00 00                	add    %al,(%eax)
    17e7:	00 00                	add    %al,(%eax)
    17e9:	00 00                	add    %al,(%eax)
    17eb:	00 44 00 cd          	add    %al,-0x33(%eax,%eax,1)
    17ef:	00 1a                	add    %bl,(%edx)
    17f1:	00 00                	add    %al,(%eax)
    17f3:	00 00                	add    %al,(%eax)
    17f5:	00 00                	add    %al,(%eax)
    17f7:	00 44 00 cf          	add    %al,-0x31(%eax,%eax,1)
    17fb:	00 1c 00             	add    %bl,(%eax,%eax,1)
    17fe:	00 00                	add    %al,(%eax)
    1800:	00 00                	add    %al,(%eax)
    1802:	00 00                	add    %al,(%eax)
    1804:	44                   	inc    %esp
    1805:	00 d2                	add    %dl,%dl
    1807:	00 29                	add    %ch,(%ecx)
    1809:	00 00                	add    %al,(%eax)
    180b:	00 00                	add    %al,(%eax)
    180d:	00 00                	add    %al,(%eax)
    180f:	00 44 00 cd          	add    %al,-0x33(%eax,%eax,1)
    1813:	00 2c 00             	add    %ch,(%eax,%eax,1)
    1816:	00 00                	add    %al,(%eax)
    1818:	00 00                	add    %al,(%eax)
    181a:	00 00                	add    %al,(%eax)
    181c:	44                   	inc    %esp
    181d:	00 ca                	add    %cl,%dl
    181f:	00 32                	add    %dh,(%edx)
    1821:	00 00                	add    %al,(%eax)
    1823:	00 00                	add    %al,(%eax)
    1825:	00 00                	add    %al,(%eax)
    1827:	00 44 00 de          	add    %al,-0x22(%eax,%eax,1)
    182b:	00 3b                	add    %bh,(%ebx)
    182d:	00 00                	add    %al,(%eax)
    182f:	00 48 0b             	add    %cl,0xb(%eax)
    1832:	00 00                	add    %al,(%eax)
    1834:	40                   	inc    %eax
    1835:	00 00                	add    %al,(%eax)
    1837:	00 01                	add    %al,(%ecx)
    1839:	00 00                	add    %al,(%eax)
    183b:	00 53 0b             	add    %dl,0xb(%ebx)
    183e:	00 00                	add    %al,(%eax)
    1840:	40                   	inc    %eax
    1841:	00 00                	add    %al,(%eax)
    1843:	00 02                	add    %al,(%edx)
    1845:	00 00                	add    %al,(%eax)
    1847:	00 cd                	add    %cl,%ch
    1849:	07                   	pop    %es
    184a:	00 00                	add    %al,(%eax)
    184c:	40                   	inc    %eax
    184d:	00 00                	add    %al,(%eax)
    184f:	00 03                	add    %al,(%ebx)
    1851:	00 00                	add    %al,(%eax)
    1853:	00 00                	add    %al,(%eax)
    1855:	00 00                	add    %al,(%eax)
    1857:	00 c0                	add    %al,%al
	...
    1861:	00 00                	add    %al,(%eax)
    1863:	00 e0                	add    %ah,%al
    1865:	00 00                	add    %al,(%eax)
    1867:	00 3f                	add    %bh,(%edi)
    1869:	00 00                	add    %al,(%eax)
    186b:	00 ba 0b 00 00 24    	add    %bh,0x2400000b(%edx)
    1871:	00 00                	add    %al,(%eax)
    1873:	00 61 08             	add    %ah,0x8(%ecx)
    1876:	28 00                	sub    %al,(%eax)
    1878:	90                   	nop
    1879:	09 00                	or     %eax,(%eax)
    187b:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    1881:	00 00                	add    %al,(%eax)
    1883:	00 95 08 00 00 a0    	add    %dl,-0x5ffffff8(%ebp)
    1889:	00 00                	add    %al,(%eax)
    188b:	00 0c 00             	add    %cl,(%eax,%eax,1)
    188e:	00 00                	add    %al,(%eax)
    1890:	2a 0b                	sub    (%ebx),%cl
    1892:	00 00                	add    %al,(%eax)
    1894:	a0 00 00 00 10       	mov    0x10000000,%al
    1899:	00 00                	add    %al,(%eax)
    189b:	00 33                	add    %dh,(%ebx)
    189d:	0b 00                	or     (%eax),%eax
    189f:	00 a0 00 00 00 14    	add    %ah,0x14000000(%eax)
    18a5:	00 00                	add    %al,(%eax)
    18a7:	00 b7 07 00 00 a0    	add    %dh,-0x5ffffff9(%edi)
    18ad:	00 00                	add    %al,(%eax)
    18af:	00 18                	add    %bl,(%eax)
    18b1:	00 00                	add    %al,(%eax)
    18b3:	00 3c 0b             	add    %bh,(%ebx,%ecx,1)
    18b6:	00 00                	add    %al,(%eax)
    18b8:	a0 00 00 00 1c       	mov    0x1c000000,%al
    18bd:	00 00                	add    %al,(%eax)
    18bf:	00 00                	add    %al,(%eax)
    18c1:	00 00                	add    %al,(%eax)
    18c3:	00 44 00 ad          	add    %al,-0x53(%eax,%eax,1)
	...
    18cf:	00 44 00 ba          	add    %al,-0x46(%eax,%eax,1)
    18d3:	00 0c 00             	add    %cl,(%eax,%eax,1)
    18d6:	00 00                	add    %al,(%eax)
    18d8:	00 00                	add    %al,(%eax)
    18da:	00 00                	add    %al,(%eax)
    18dc:	44                   	inc    %esp
    18dd:	00 af 00 10 00 00    	add    %ch,0x1000(%edi)
    18e3:	00 00                	add    %al,(%eax)
    18e5:	00 00                	add    %al,(%eax)
    18e7:	00 44 00 b1          	add    %al,-0x4f(%eax,%eax,1)
    18eb:	00 1a                	add    %bl,(%edx)
    18ed:	00 00                	add    %al,(%eax)
    18ef:	00 00                	add    %al,(%eax)
    18f1:	00 00                	add    %al,(%eax)
    18f3:	00 44 00 b4          	add    %al,-0x4c(%eax,%eax,1)
    18f7:	00 1e                	add    %bl,(%esi)
    18f9:	00 00                	add    %al,(%eax)
    18fb:	00 00                	add    %al,(%eax)
    18fd:	00 00                	add    %al,(%eax)
    18ff:	00 44 00 b3          	add    %al,-0x4d(%eax,%eax,1)
    1903:	00 21                	add    %ah,(%ecx)
    1905:	00 00                	add    %al,(%eax)
    1907:	00 00                	add    %al,(%eax)
    1909:	00 00                	add    %al,(%eax)
    190b:	00 44 00 b9          	add    %al,-0x47(%eax,%eax,1)
    190f:	00 25 00 00 00 00    	add    %ah,0x0
    1915:	00 00                	add    %al,(%eax)
    1917:	00 44 00 ba          	add    %al,-0x46(%eax,%eax,1)
    191b:	00 2d 00 00 00 00    	add    %ch,0x0
    1921:	00 00                	add    %al,(%eax)
    1923:	00 44 00 bb          	add    %al,-0x45(%eax,%eax,1)
    1927:	00 31                	add    %dh,(%ecx)
    1929:	00 00                	add    %al,(%eax)
    192b:	00 00                	add    %al,(%eax)
    192d:	00 00                	add    %al,(%eax)
    192f:	00 44 00 ba          	add    %al,-0x46(%eax,%eax,1)
    1933:	00 34 00             	add    %dh,(%eax,%eax,1)
    1936:	00 00                	add    %al,(%eax)
    1938:	00 00                	add    %al,(%eax)
    193a:	00 00                	add    %al,(%eax)
    193c:	44                   	inc    %esp
    193d:	00 bb 00 3f 00 00    	add    %bh,0x3f00(%ebx)
    1943:	00 00                	add    %al,(%eax)
    1945:	00 00                	add    %al,(%eax)
    1947:	00 44 00 c0          	add    %al,-0x40(%eax,%eax,1)
    194b:	00 42 00             	add    %al,0x0(%edx)
    194e:	00 00                	add    %al,(%eax)
    1950:	00 00                	add    %al,(%eax)
    1952:	00 00                	add    %al,(%eax)
    1954:	44                   	inc    %esp
    1955:	00 c4                	add    %al,%ah
    1957:	00 47 00             	add    %al,0x0(%edi)
    195a:	00 00                	add    %al,(%eax)
    195c:	67 09 00             	or     %eax,(%bx,%si)
    195f:	00 40 00             	add    %al,0x0(%eax)
    1962:	00 00                	add    %al,(%eax)
    1964:	07                   	pop    %es
    1965:	00 00                	add    %al,(%eax)
    1967:	00 e7                	add    %ah,%bh
    1969:	09 00                	or     %eax,(%eax)
    196b:	00 40 00             	add    %al,0x0(%eax)
    196e:	00 00                	add    %al,(%eax)
    1970:	06                   	push   %es
    1971:	00 00                	add    %al,(%eax)
    1973:	00 00                	add    %al,(%eax)
    1975:	00 00                	add    %al,(%eax)
    1977:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
    197b:	00 b0 08 28 00 c9    	add    %dh,-0x36ffd7f8(%eax)
    1981:	0b 00                	or     (%eax),%eax
    1983:	00 64 00 02          	add    %ah,0x2(%eax,%eax,1)
    1987:	00 b0 08 28 00 08    	add    %dh,0x8002808(%eax)
    198d:	00 00                	add    %al,(%eax)
    198f:	00 3c 00             	add    %bh,(%eax,%eax,1)
    1992:	00 00                	add    %al,(%eax)
    1994:	00 00                	add    %al,(%eax)
    1996:	00 00                	add    %al,(%eax)
    1998:	17                   	pop    %ss
    1999:	00 00                	add    %al,(%eax)
    199b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    19a1:	00 00                	add    %al,(%eax)
    19a3:	00 41 00             	add    %al,0x0(%ecx)
    19a6:	00 00                	add    %al,(%eax)
    19a8:	80 00 00             	addb   $0x0,(%eax)
    19ab:	00 00                	add    %al,(%eax)
    19ad:	00 00                	add    %al,(%eax)
    19af:	00 5b 00             	add    %bl,0x0(%ebx)
    19b2:	00 00                	add    %al,(%eax)
    19b4:	80 00 00             	addb   $0x0,(%eax)
    19b7:	00 00                	add    %al,(%eax)
    19b9:	00 00                	add    %al,(%eax)
    19bb:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
    19c1:	00 00                	add    %al,(%eax)
    19c3:	00 00                	add    %al,(%eax)
    19c5:	00 00                	add    %al,(%eax)
    19c7:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
    19cd:	00 00                	add    %al,(%eax)
    19cf:	00 00                	add    %al,(%eax)
    19d1:	00 00                	add    %al,(%eax)
    19d3:	00 e1                	add    %ah,%cl
    19d5:	00 00                	add    %al,(%eax)
    19d7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    19dd:	00 00                	add    %al,(%eax)
    19df:	00 0c 01             	add    %cl,(%ecx,%eax,1)
    19e2:	00 00                	add    %al,(%eax)
    19e4:	80 00 00             	addb   $0x0,(%eax)
    19e7:	00 00                	add    %al,(%eax)
    19e9:	00 00                	add    %al,(%eax)
    19eb:	00 37                	add    %dh,(%edi)
    19ed:	01 00                	add    %eax,(%eax)
    19ef:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    19f5:	00 00                	add    %al,(%eax)
    19f7:	00 5d 01             	add    %bl,0x1(%ebp)
    19fa:	00 00                	add    %al,(%eax)
    19fc:	80 00 00             	addb   $0x0,(%eax)
    19ff:	00 00                	add    %al,(%eax)
    1a01:	00 00                	add    %al,(%eax)
    1a03:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
    1a09:	00 00                	add    %al,(%eax)
    1a0b:	00 00                	add    %al,(%eax)
    1a0d:	00 00                	add    %al,(%eax)
    1a0f:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
    1a15:	00 00                	add    %al,(%eax)
    1a17:	00 00                	add    %al,(%eax)
    1a19:	00 00                	add    %al,(%eax)
    1a1b:	00 d2                	add    %dl,%dl
    1a1d:	01 00                	add    %eax,(%eax)
    1a1f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1a25:	00 00                	add    %al,(%eax)
    1a27:	00 ec                	add    %ch,%ah
    1a29:	01 00                	add    %eax,(%eax)
    1a2b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1a31:	00 00                	add    %al,(%eax)
    1a33:	00 07                	add    %al,(%edi)
    1a35:	02 00                	add    (%eax),%al
    1a37:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1a3d:	00 00                	add    %al,(%eax)
    1a3f:	00 28                	add    %ch,(%eax)
    1a41:	02 00                	add    (%eax),%al
    1a43:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1a49:	00 00                	add    %al,(%eax)
    1a4b:	00 47 02             	add    %al,0x2(%edi)
    1a4e:	00 00                	add    %al,(%eax)
    1a50:	80 00 00             	addb   $0x0,(%eax)
    1a53:	00 00                	add    %al,(%eax)
    1a55:	00 00                	add    %al,(%eax)
    1a57:	00 66 02             	add    %ah,0x2(%esi)
    1a5a:	00 00                	add    %al,(%eax)
    1a5c:	80 00 00             	addb   $0x0,(%eax)
    1a5f:	00 00                	add    %al,(%eax)
    1a61:	00 00                	add    %al,(%eax)
    1a63:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
    1a69:	00 00                	add    %al,(%eax)
    1a6b:	00 00                	add    %al,(%eax)
    1a6d:	00 00                	add    %al,(%eax)
    1a6f:	00 9b 02 00 00 c2    	add    %bl,-0x3dfffffe(%ebx)
    1a75:	00 00                	add    %al,(%eax)
    1a77:	00 f2                	add    %dh,%dl
    1a79:	aa                   	stos   %al,%es:(%edi)
    1a7a:	00 00                	add    %al,(%eax)
    1a7c:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
    1a7d:	02 00                	add    (%eax),%al
    1a7f:	00 c2                	add    %al,%dl
    1a81:	00 00                	add    %al,(%eax)
    1a83:	00 00                	add    %al,(%eax)
    1a85:	00 00                	add    %al,(%eax)
    1a87:	00 ae 02 00 00 c2    	add    %ch,-0x3dfffffe(%esi)
    1a8d:	00 00                	add    %al,(%eax)
    1a8f:	00 37                	add    %dh,(%edi)
    1a91:	53                   	push   %ebx
    1a92:	00 00                	add    %al,(%eax)
    1a94:	d2 0b                	rorb   %cl,(%ebx)
    1a96:	00 00                	add    %al,(%eax)
    1a98:	24 00                	and    $0x0,%al
    1a9a:	00 00                	add    %al,(%eax)
    1a9c:	b0 08                	mov    $0x8,%al
    1a9e:	28 00                	sub    %al,(%eax)
    1aa0:	e1 0b                	loope  1aad <bootmain-0x27e553>
    1aa2:	00 00                	add    %al,(%eax)
    1aa4:	a0 00 00 00 08       	mov    0x8000000,%al
    1aa9:	00 00                	add    %al,(%eax)
    1aab:	00 f3                	add    %dh,%bl
    1aad:	0b 00                	or     (%eax),%eax
    1aaf:	00 a0 00 00 00 0c    	add    %ah,0xc000000(%eax)
    1ab5:	00 00                	add    %al,(%eax)
    1ab7:	00 00                	add    %al,(%eax)
    1ab9:	0c 00                	or     $0x0,%al
    1abb:	00 a0 00 00 00 10    	add    %ah,0x10000000(%eax)
    1ac1:	00 00                	add    %al,(%eax)
    1ac3:	00 0c 0c             	add    %cl,(%esp,%ecx,1)
    1ac6:	00 00                	add    %al,(%eax)
    1ac8:	a0 00 00 00 14       	mov    0x14000000,%al
    1acd:	00 00                	add    %al,(%eax)
    1acf:	00 00                	add    %al,(%eax)
    1ad1:	00 00                	add    %al,(%eax)
    1ad3:	00 44 00 06          	add    %al,0x6(%eax,%eax,1)
	...
    1adf:	00 44 00 06          	add    %al,0x6(%eax,%eax,1)
    1ae3:	00 0f                	add    %cl,(%edi)
    1ae5:	00 00                	add    %al,(%eax)
    1ae7:	00 00                	add    %al,(%eax)
    1ae9:	00 00                	add    %al,(%eax)
    1aeb:	00 44 00 07          	add    %al,0x7(%eax,%eax,1)
    1aef:	00 12                	add    %dl,(%edx)
    1af1:	00 00                	add    %al,(%eax)
    1af3:	00 00                	add    %al,(%eax)
    1af5:	00 00                	add    %al,(%eax)
    1af7:	00 44 00 09          	add    %al,0x9(%eax,%eax,1)
    1afb:	00 1a                	add    %bl,(%edx)
    1afd:	00 00                	add    %al,(%eax)
    1aff:	00 00                	add    %al,(%eax)
    1b01:	00 00                	add    %al,(%eax)
    1b03:	00 44 00 0a          	add    %al,0xa(%eax,%eax,1)
    1b07:	00 20                	add    %ah,(%eax)
    1b09:	00 00                	add    %al,(%eax)
    1b0b:	00 00                	add    %al,(%eax)
    1b0d:	00 00                	add    %al,(%eax)
    1b0f:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
    1b13:	00 23                	add    %ah,(%ebx)
    1b15:	00 00                	add    %al,(%eax)
    1b17:	00 00                	add    %al,(%eax)
    1b19:	00 00                	add    %al,(%eax)
    1b1b:	00 44 00 0f          	add    %al,0xf(%eax,%eax,1)
    1b1f:	00 2d 00 00 00 00    	add    %ch,0x0
    1b25:	00 00                	add    %al,(%eax)
    1b27:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
    1b2b:	00 2f                	add    %ch,(%edi)
    1b2d:	00 00                	add    %al,(%eax)
    1b2f:	00 00                	add    %al,(%eax)
    1b31:	00 00                	add    %al,(%eax)
    1b33:	00 44 00 0f          	add    %al,0xf(%eax,%eax,1)
    1b37:	00 32                	add    %dh,(%edx)
    1b39:	00 00                	add    %al,(%eax)
    1b3b:	00 00                	add    %al,(%eax)
    1b3d:	00 00                	add    %al,(%eax)
    1b3f:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
    1b43:	00 35 00 00 00 00    	add    %dh,0x0
    1b49:	00 00                	add    %al,(%eax)
    1b4b:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
    1b4f:	00 37                	add    %dh,(%edi)
    1b51:	00 00                	add    %al,(%eax)
    1b53:	00 00                	add    %al,(%eax)
    1b55:	00 00                	add    %al,(%eax)
    1b57:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
    1b5b:	00 3a                	add    %bh,(%edx)
    1b5d:	00 00                	add    %al,(%eax)
    1b5f:	00 00                	add    %al,(%eax)
    1b61:	00 00                	add    %al,(%eax)
    1b63:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    1b67:	00 40 00             	add    %al,0x0(%eax)
    1b6a:	00 00                	add    %al,(%eax)
    1b6c:	00 00                	add    %al,(%eax)
    1b6e:	00 00                	add    %al,(%eax)
    1b70:	44                   	inc    %esp
    1b71:	00 10                	add    %dl,(%eax)
    1b73:	00 44 00 00          	add    %al,0x0(%eax,%eax,1)
    1b77:	00 00                	add    %al,(%eax)
    1b79:	00 00                	add    %al,(%eax)
    1b7b:	00 44 00 11          	add    %al,0x11(%eax,%eax,1)
    1b7f:	00 46 00             	add    %al,0x0(%esi)
    1b82:	00 00                	add    %al,(%eax)
    1b84:	00 00                	add    %al,(%eax)
    1b86:	00 00                	add    %al,(%eax)
    1b88:	44                   	inc    %esp
    1b89:	00 10                	add    %dl,(%eax)
    1b8b:	00 49 00             	add    %cl,0x0(%ecx)
    1b8e:	00 00                	add    %al,(%eax)
    1b90:	00 00                	add    %al,(%eax)
    1b92:	00 00                	add    %al,(%eax)
    1b94:	44                   	inc    %esp
    1b95:	00 11                	add    %dl,(%ecx)
    1b97:	00 4c 00 00          	add    %cl,0x0(%eax,%eax,1)
    1b9b:	00 00                	add    %al,(%eax)
    1b9d:	00 00                	add    %al,(%eax)
    1b9f:	00 44 00 13          	add    %al,0x13(%eax,%eax,1)
    1ba3:	00 4f 00             	add    %cl,0x0(%edi)
    1ba6:	00 00                	add    %al,(%eax)
    1ba8:	1a 0c 00             	sbb    (%eax,%eax,1),%cl
    1bab:	00 40 00             	add    %al,0x0(%eax)
    1bae:	00 00                	add    %al,(%eax)
    1bb0:	00 00                	add    %al,(%eax)
    1bb2:	00 00                	add    %al,(%eax)
    1bb4:	25 0c 00 00 40       	and    $0x4000000c,%eax
    1bb9:	00 00                	add    %al,(%eax)
    1bbb:	00 02                	add    %al,(%edx)
    1bbd:	00 00                	add    %al,(%eax)
    1bbf:	00 32                	add    %dh,(%edx)
    1bc1:	0c 00                	or     $0x0,%al
    1bc3:	00 40 00             	add    %al,0x0(%eax)
    1bc6:	00 00                	add    %al,(%eax)
    1bc8:	03 00                	add    (%eax),%eax
    1bca:	00 00                	add    %al,(%eax)
    1bcc:	3e                   	ds
    1bcd:	0c 00                	or     $0x0,%al
    1bcf:	00 40 00             	add    %al,0x0(%eax)
    1bd2:	00 00                	add    %al,(%eax)
    1bd4:	07                   	pop    %es
    1bd5:	00 00                	add    %al,(%eax)
    1bd7:	00 4c 0c 00          	add    %cl,0x0(%esp,%ecx,1)
    1bdb:	00 24 00             	add    %ah,(%eax,%eax,1)
    1bde:	00 00                	add    %al,(%eax)
    1be0:	04 09                	add    $0x9,%al
    1be2:	28 00                	sub    %al,(%eax)
    1be4:	5b                   	pop    %ebx
    1be5:	0c 00                	or     $0x0,%al
    1be7:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    1bed:	00 00                	add    %al,(%eax)
    1bef:	00 6d 0c             	add    %ch,0xc(%ebp)
    1bf2:	00 00                	add    %al,(%eax)
    1bf4:	a0 00 00 00 0c       	mov    0xc000000,%al
    1bf9:	00 00                	add    %al,(%eax)
    1bfb:	00 7b 0c             	add    %bh,0xc(%ebx)
    1bfe:	00 00                	add    %al,(%eax)
    1c00:	a0 00 00 00 10       	mov    0x10000000,%al
    1c05:	00 00                	add    %al,(%eax)
    1c07:	00 0c 0c             	add    %cl,(%esp,%ecx,1)
    1c0a:	00 00                	add    %al,(%eax)
    1c0c:	a0 00 00 00 14       	mov    0x14000000,%al
    1c11:	00 00                	add    %al,(%eax)
    1c13:	00 00                	add    %al,(%eax)
    1c15:	00 00                	add    %al,(%eax)
    1c17:	00 44 00 16          	add    %al,0x16(%eax,%eax,1)
	...
    1c23:	00 44 00 16          	add    %al,0x16(%eax,%eax,1)
    1c27:	00 03                	add    %al,(%ebx)
    1c29:	00 00                	add    %al,(%eax)
    1c2b:	00 00                	add    %al,(%eax)
    1c2d:	00 00                	add    %al,(%eax)
    1c2f:	00 44 00 18          	add    %al,0x18(%eax,%eax,1)
    1c33:	00 0c 00             	add    %cl,(%eax,%eax,1)
    1c36:	00 00                	add    %al,(%eax)
    1c38:	00 00                	add    %al,(%eax)
    1c3a:	00 00                	add    %al,(%eax)
    1c3c:	44                   	inc    %esp
    1c3d:	00 19                	add    %bl,(%ecx)
    1c3f:	00 0f                	add    %cl,(%edi)
    1c41:	00 00                	add    %al,(%eax)
    1c43:	00 00                	add    %al,(%eax)
    1c45:	00 00                	add    %al,(%eax)
    1c47:	00 44 00 1c          	add    %al,0x1c(%eax,%eax,1)
    1c4b:	00 16                	add    %dl,(%esi)
    1c4d:	00 00                	add    %al,(%eax)
    1c4f:	00 00                	add    %al,(%eax)
    1c51:	00 00                	add    %al,(%eax)
    1c53:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
    1c57:	00 19                	add    %bl,(%ecx)
    1c59:	00 00                	add    %al,(%eax)
    1c5b:	00 00                	add    %al,(%eax)
    1c5d:	00 00                	add    %al,(%eax)
    1c5f:	00 44 00 1c          	add    %al,0x1c(%eax,%eax,1)
    1c63:	00 1c 00             	add    %bl,(%eax,%eax,1)
    1c66:	00 00                	add    %al,(%eax)
    1c68:	00 00                	add    %al,(%eax)
    1c6a:	00 00                	add    %al,(%eax)
    1c6c:	44                   	inc    %esp
    1c6d:	00 1e                	add    %bl,(%esi)
    1c6f:	00 20                	add    %ah,(%eax)
    1c71:	00 00                	add    %al,(%eax)
    1c73:	00 00                	add    %al,(%eax)
    1c75:	00 00                	add    %al,(%eax)
    1c77:	00 44 00 22          	add    %al,0x22(%eax,%eax,1)
    1c7b:	00 28                	add    %ch,(%eax)
    1c7d:	00 00                	add    %al,(%eax)
    1c7f:	00 8b 0c 00 00 40    	add    %cl,0x4000000c(%ebx)
    1c85:	00 00                	add    %al,(%eax)
    1c87:	00 00                	add    %al,(%eax)
    1c89:	00 00                	add    %al,(%eax)
    1c8b:	00 96 0c 00 00 40    	add    %dl,0x4000000c(%esi)
    1c91:	00 00                	add    %al,(%eax)
    1c93:	00 01                	add    %al,(%ecx)
    1c95:	00 00                	add    %al,(%eax)
    1c97:	00 a4 0c 00 00 40 00 	add    %ah,0x400000(%esp,%ecx,1)
    1c9e:	00 00                	add    %al,(%eax)
    1ca0:	01 00                	add    %eax,(%eax)
    1ca2:	00 00                	add    %al,(%eax)
    1ca4:	3e                   	ds
    1ca5:	0c 00                	or     $0x0,%al
    1ca7:	00 40 00             	add    %al,0x0(%eax)
    1caa:	00 00                	add    %al,(%eax)
    1cac:	02 00                	add    (%eax),%al
    1cae:	00 00                	add    %al,(%eax)
    1cb0:	b4 0c                	mov    $0xc,%ah
    1cb2:	00 00                	add    %al,(%eax)
    1cb4:	24 00                	and    $0x0,%al
    1cb6:	00 00                	add    %al,(%eax)
    1cb8:	2e 09 28             	or     %ebp,%cs:(%eax)
    1cbb:	00 00                	add    %al,(%eax)
    1cbd:	00 00                	add    %al,(%eax)
    1cbf:	00 44 00 27          	add    %al,0x27(%eax,%eax,1)
	...
    1ccb:	00 44 00 27          	add    %al,0x27(%eax,%eax,1)
    1ccf:	00 05 00 00 00 00    	add    %al,0x0
    1cd5:	00 00                	add    %al,(%eax)
    1cd7:	00 44 00 2d          	add    %al,0x2d(%eax,%eax,1)
    1cdb:	00 0a                	add    %cl,(%edx)
    1cdd:	00 00                	add    %al,(%eax)
    1cdf:	00 00                	add    %al,(%eax)
    1ce1:	00 00                	add    %al,(%eax)
    1ce3:	00 44 00 2b          	add    %al,0x2b(%eax,%eax,1)
    1ce7:	00 19                	add    %bl,(%ecx)
    1ce9:	00 00                	add    %al,(%eax)
    1ceb:	00 00                	add    %al,(%eax)
    1ced:	00 00                	add    %al,(%eax)
    1cef:	00 44 00 2f          	add    %al,0x2f(%eax,%eax,1)
    1cf3:	00 24 00             	add    %ah,(%eax,%eax,1)
    1cf6:	00 00                	add    %al,(%eax)
    1cf8:	00 00                	add    %al,(%eax)
    1cfa:	00 00                	add    %al,(%eax)
    1cfc:	44                   	inc    %esp
    1cfd:	00 30                	add    %dh,(%eax)
    1cff:	00 37                	add    %dh,(%edi)
    1d01:	00 00                	add    %al,(%eax)
    1d03:	00 00                	add    %al,(%eax)
    1d05:	00 00                	add    %al,(%eax)
    1d07:	00 44 00 31          	add    %al,0x31(%eax,%eax,1)
    1d0b:	00 4d 00             	add    %cl,0x0(%ebp)
    1d0e:	00 00                	add    %al,(%eax)
    1d10:	00 00                	add    %al,(%eax)
    1d12:	00 00                	add    %al,(%eax)
    1d14:	44                   	inc    %esp
    1d15:	00 33                	add    %dh,(%ebx)
    1d17:	00 69 00             	add    %ch,0x0(%ecx)
    1d1a:	00 00                	add    %al,(%eax)
    1d1c:	00 00                	add    %al,(%eax)
    1d1e:	00 00                	add    %al,(%eax)
    1d20:	44                   	inc    %esp
    1d21:	00 18                	add    %bl,(%eax)
    1d23:	00 7f 00             	add    %bh,0x0(%edi)
    1d26:	00 00                	add    %al,(%eax)
    1d28:	00 00                	add    %al,(%eax)
    1d2a:	00 00                	add    %al,(%eax)
    1d2c:	44                   	inc    %esp
    1d2d:	00 19                	add    %bl,(%ecx)
    1d2f:	00 8b 00 00 00 00    	add    %cl,0x0(%ebx)
    1d35:	00 00                	add    %al,(%eax)
    1d37:	00 44 00 1c          	add    %al,0x1c(%eax,%eax,1)
    1d3b:	00 94 00 00 00 00 00 	add    %dl,0x0(%eax,%eax,1)
    1d42:	00 00                	add    %al,(%eax)
    1d44:	44                   	inc    %esp
    1d45:	00 1e                	add    %bl,(%esi)
    1d47:	00 9d 00 00 00 00    	add    %bl,0x0(%ebp)
    1d4d:	00 00                	add    %al,(%eax)
    1d4f:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
    1d53:	00 a4 00 00 00 00 00 	add    %ah,0x0(%eax,%eax,1)
    1d5a:	00 00                	add    %al,(%eax)
    1d5c:	44                   	inc    %esp
    1d5d:	00 35 00 ab 00 00    	add    %dh,0xab00
    1d63:	00 00                	add    %al,(%eax)
    1d65:	00 00                	add    %al,(%eax)
    1d67:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    1d6b:	00 b2 00 00 00 00    	add    %dh,0x0(%edx)
    1d71:	00 00                	add    %al,(%eax)
    1d73:	00 44 00 18          	add    %al,0x18(%eax,%eax,1)
    1d77:	00 bd 00 00 00 00    	add    %bh,0x0(%ebp)
    1d7d:	00 00                	add    %al,(%eax)
    1d7f:	00 44 00 18          	add    %al,0x18(%eax,%eax,1)
    1d83:	00 c2                	add    %al,%dl
    1d85:	00 00                	add    %al,(%eax)
    1d87:	00 00                	add    %al,(%eax)
    1d89:	00 00                	add    %al,(%eax)
    1d8b:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    1d8f:	00 cc                	add    %cl,%ah
    1d91:	00 00                	add    %al,(%eax)
    1d93:	00 00                	add    %al,(%eax)
    1d95:	00 00                	add    %al,(%eax)
    1d97:	00 44 00 1c          	add    %al,0x1c(%eax,%eax,1)
    1d9b:	00 d3                	add    %dl,%bl
    1d9d:	00 00                	add    %al,(%eax)
    1d9f:	00 00                	add    %al,(%eax)
    1da1:	00 00                	add    %al,(%eax)
    1da3:	00 44 00 1e          	add    %al,0x1e(%eax,%eax,1)
    1da7:	00 dc                	add    %bl,%ah
    1da9:	00 00                	add    %al,(%eax)
    1dab:	00 00                	add    %al,(%eax)
    1dad:	00 00                	add    %al,(%eax)
    1daf:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
    1db3:	00 e3                	add    %ah,%bl
    1db5:	00 00                	add    %al,(%eax)
    1db7:	00 00                	add    %al,(%eax)
    1db9:	00 00                	add    %al,(%eax)
    1dbb:	00 44 00 3a          	add    %al,0x3a(%eax,%eax,1)
    1dbf:	00 ea                	add    %ch,%dl
    1dc1:	00 00                	add    %al,(%eax)
    1dc3:	00 00                	add    %al,(%eax)
    1dc5:	00 00                	add    %al,(%eax)
    1dc7:	00 44 00 3f          	add    %al,0x3f(%eax,%eax,1)
    1dcb:	00 f1                	add    %dh,%cl
    1dcd:	00 00                	add    %al,(%eax)
    1dcf:	00 00                	add    %al,(%eax)
    1dd1:	00 00                	add    %al,(%eax)
    1dd3:	00 44 00 18          	add    %al,0x18(%eax,%eax,1)
    1dd7:	00 f6                	add    %dh,%dh
    1dd9:	00 00                	add    %al,(%eax)
    1ddb:	00 00                	add    %al,(%eax)
    1ddd:	00 00                	add    %al,(%eax)
    1ddf:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    1de3:	00 fc                	add    %bh,%ah
    1de5:	00 00                	add    %al,(%eax)
    1de7:	00 00                	add    %al,(%eax)
    1de9:	00 00                	add    %al,(%eax)
    1deb:	00 44 00 40          	add    %al,0x40(%eax,%eax,1)
    1def:	00 05 01 00 00 00    	add    %al,0x1
    1df5:	00 00                	add    %al,(%eax)
    1df7:	00 44 00 18          	add    %al,0x18(%eax,%eax,1)
    1dfb:	00 0a                	add    %cl,(%edx)
    1dfd:	01 00                	add    %eax,(%eax)
    1dff:	00 00                	add    %al,(%eax)
    1e01:	00 00                	add    %al,(%eax)
    1e03:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    1e07:	00 10                	add    %dl,(%eax)
    1e09:	01 00                	add    %eax,(%eax)
    1e0b:	00 00                	add    %al,(%eax)
    1e0d:	00 00                	add    %al,(%eax)
    1e0f:	00 44 00 41          	add    %al,0x41(%eax,%eax,1)
    1e13:	00 19                	add    %bl,(%ecx)
    1e15:	01 00                	add    %eax,(%eax)
    1e17:	00 00                	add    %al,(%eax)
    1e19:	00 00                	add    %al,(%eax)
    1e1b:	00 44 00 18          	add    %al,0x18(%eax,%eax,1)
    1e1f:	00 1e                	add    %bl,(%esi)
    1e21:	01 00                	add    %eax,(%eax)
    1e23:	00 00                	add    %al,(%eax)
    1e25:	00 00                	add    %al,(%eax)
    1e27:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    1e2b:	00 24 01             	add    %ah,(%ecx,%eax,1)
    1e2e:	00 00                	add    %al,(%eax)
    1e30:	00 00                	add    %al,(%eax)
    1e32:	00 00                	add    %al,(%eax)
    1e34:	44                   	inc    %esp
    1e35:	00 1c 00             	add    %bl,(%eax,%eax,1)
    1e38:	2d 01 00 00 00       	sub    $0x1,%eax
    1e3d:	00 00                	add    %al,(%eax)
    1e3f:	00 44 00 1e          	add    %al,0x1e(%eax,%eax,1)
    1e43:	00 36                	add    %dh,(%esi)
    1e45:	01 00                	add    %eax,(%eax)
    1e47:	00 00                	add    %al,(%eax)
    1e49:	00 00                	add    %al,(%eax)
    1e4b:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
    1e4f:	00 3d 01 00 00 00    	add    %bh,0x1
    1e55:	00 00                	add    %al,(%eax)
    1e57:	00 44 00 1c          	add    %al,0x1c(%eax,%eax,1)
    1e5b:	00 44 01 00          	add    %al,0x0(%ecx,%eax,1)
    1e5f:	00 00                	add    %al,(%eax)
    1e61:	00 00                	add    %al,(%eax)
    1e63:	00 44 00 1e          	add    %al,0x1e(%eax,%eax,1)
    1e67:	00 4d 01             	add    %cl,0x1(%ebp)
    1e6a:	00 00                	add    %al,(%eax)
    1e6c:	00 00                	add    %al,(%eax)
    1e6e:	00 00                	add    %al,(%eax)
    1e70:	44                   	inc    %esp
    1e71:	00 1f                	add    %bl,(%edi)
    1e73:	00 54 01 00          	add    %dl,0x0(%ecx,%eax,1)
    1e77:	00 00                	add    %al,(%eax)
    1e79:	00 00                	add    %al,(%eax)
    1e7b:	00 44 00 1c          	add    %al,0x1c(%eax,%eax,1)
    1e7f:	00 5b 01             	add    %bl,0x1(%ebx)
    1e82:	00 00                	add    %al,(%eax)
    1e84:	00 00                	add    %al,(%eax)
    1e86:	00 00                	add    %al,(%eax)
    1e88:	44                   	inc    %esp
    1e89:	00 1e                	add    %bl,(%esi)
    1e8b:	00 64 01 00          	add    %ah,0x0(%ecx,%eax,1)
    1e8f:	00 00                	add    %al,(%eax)
    1e91:	00 00                	add    %al,(%eax)
    1e93:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
    1e97:	00 6b 01             	add    %ch,0x1(%ebx)
    1e9a:	00 00                	add    %al,(%eax)
    1e9c:	00 00                	add    %al,(%eax)
    1e9e:	00 00                	add    %al,(%eax)
    1ea0:	44                   	inc    %esp
    1ea1:	00 42 00             	add    %al,0x0(%edx)
    1ea4:	72 01                	jb     1ea7 <bootmain-0x27e159>
    1ea6:	00 00                	add    %al,(%eax)
    1ea8:	00 00                	add    %al,(%eax)
    1eaa:	00 00                	add    %al,(%eax)
    1eac:	44                   	inc    %esp
    1ead:	00 46 00             	add    %al,0x0(%esi)
    1eb0:	86 01                	xchg   %al,(%ecx)
    1eb2:	00 00                	add    %al,(%eax)
    1eb4:	00 00                	add    %al,(%eax)
    1eb6:	00 00                	add    %al,(%eax)
    1eb8:	64 00 00             	add    %al,%fs:(%eax)
    1ebb:	00 b9 0a 28 00 c8    	add    %bh,-0x37ffd7f6(%ecx)
    1ec1:	0c 00                	or     $0x0,%al
    1ec3:	00 64 00 02          	add    %ah,0x2(%eax,%eax,1)
    1ec7:	00 bc 0a 28 00 08 00 	add    %bh,0x80028(%edx,%ecx,1)
    1ece:	00 00                	add    %al,(%eax)
    1ed0:	3c 00                	cmp    $0x0,%al
    1ed2:	00 00                	add    %al,(%eax)
    1ed4:	00 00                	add    %al,(%eax)
    1ed6:	00 00                	add    %al,(%eax)
    1ed8:	17                   	pop    %ss
    1ed9:	00 00                	add    %al,(%eax)
    1edb:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1ee1:	00 00                	add    %al,(%eax)
    1ee3:	00 41 00             	add    %al,0x0(%ecx)
    1ee6:	00 00                	add    %al,(%eax)
    1ee8:	80 00 00             	addb   $0x0,(%eax)
    1eeb:	00 00                	add    %al,(%eax)
    1eed:	00 00                	add    %al,(%eax)
    1eef:	00 5b 00             	add    %bl,0x0(%ebx)
    1ef2:	00 00                	add    %al,(%eax)
    1ef4:	80 00 00             	addb   $0x0,(%eax)
    1ef7:	00 00                	add    %al,(%eax)
    1ef9:	00 00                	add    %al,(%eax)
    1efb:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
    1f01:	00 00                	add    %al,(%eax)
    1f03:	00 00                	add    %al,(%eax)
    1f05:	00 00                	add    %al,(%eax)
    1f07:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
    1f0d:	00 00                	add    %al,(%eax)
    1f0f:	00 00                	add    %al,(%eax)
    1f11:	00 00                	add    %al,(%eax)
    1f13:	00 e1                	add    %ah,%cl
    1f15:	00 00                	add    %al,(%eax)
    1f17:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1f1d:	00 00                	add    %al,(%eax)
    1f1f:	00 0c 01             	add    %cl,(%ecx,%eax,1)
    1f22:	00 00                	add    %al,(%eax)
    1f24:	80 00 00             	addb   $0x0,(%eax)
    1f27:	00 00                	add    %al,(%eax)
    1f29:	00 00                	add    %al,(%eax)
    1f2b:	00 37                	add    %dh,(%edi)
    1f2d:	01 00                	add    %eax,(%eax)
    1f2f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1f35:	00 00                	add    %al,(%eax)
    1f37:	00 5d 01             	add    %bl,0x1(%ebp)
    1f3a:	00 00                	add    %al,(%eax)
    1f3c:	80 00 00             	addb   $0x0,(%eax)
    1f3f:	00 00                	add    %al,(%eax)
    1f41:	00 00                	add    %al,(%eax)
    1f43:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
    1f49:	00 00                	add    %al,(%eax)
    1f4b:	00 00                	add    %al,(%eax)
    1f4d:	00 00                	add    %al,(%eax)
    1f4f:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
    1f55:	00 00                	add    %al,(%eax)
    1f57:	00 00                	add    %al,(%eax)
    1f59:	00 00                	add    %al,(%eax)
    1f5b:	00 d2                	add    %dl,%dl
    1f5d:	01 00                	add    %eax,(%eax)
    1f5f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1f65:	00 00                	add    %al,(%eax)
    1f67:	00 ec                	add    %ch,%ah
    1f69:	01 00                	add    %eax,(%eax)
    1f6b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1f71:	00 00                	add    %al,(%eax)
    1f73:	00 07                	add    %al,(%edi)
    1f75:	02 00                	add    (%eax),%al
    1f77:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1f7d:	00 00                	add    %al,(%eax)
    1f7f:	00 28                	add    %ch,(%eax)
    1f81:	02 00                	add    (%eax),%al
    1f83:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1f89:	00 00                	add    %al,(%eax)
    1f8b:	00 47 02             	add    %al,0x2(%edi)
    1f8e:	00 00                	add    %al,(%eax)
    1f90:	80 00 00             	addb   $0x0,(%eax)
    1f93:	00 00                	add    %al,(%eax)
    1f95:	00 00                	add    %al,(%eax)
    1f97:	00 66 02             	add    %ah,0x2(%esi)
    1f9a:	00 00                	add    %al,(%eax)
    1f9c:	80 00 00             	addb   $0x0,(%eax)
    1f9f:	00 00                	add    %al,(%eax)
    1fa1:	00 00                	add    %al,(%eax)
    1fa3:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
    1fa9:	00 00                	add    %al,(%eax)
    1fab:	00 00                	add    %al,(%eax)
    1fad:	00 00                	add    %al,(%eax)
    1faf:	00 ce                	add    %cl,%dh
    1fb1:	0c 00                	or     $0x0,%al
    1fb3:	00 82 00 00 00 f2    	add    %al,-0xe000000(%edx)
    1fb9:	aa                   	stos   %al,%es:(%edi)
    1fba:	00 00                	add    %al,(%eax)
    1fbc:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
    1fbd:	02 00                	add    (%eax),%al
    1fbf:	00 c2                	add    %al,%dl
    1fc1:	00 00                	add    %al,(%eax)
    1fc3:	00 00                	add    %al,(%eax)
    1fc5:	00 00                	add    %al,(%eax)
    1fc7:	00 ae 02 00 00 c2    	add    %ch,-0x3dfffffe(%esi)
    1fcd:	00 00                	add    %al,(%eax)
    1fcf:	00 37                	add    %dh,(%edi)
    1fd1:	53                   	push   %ebx
    1fd2:	00 00                	add    %al,(%eax)
    1fd4:	11 04 00             	adc    %eax,(%eax,%eax,1)
    1fd7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    1fdd:	00 00                	add    %al,(%eax)
    1fdf:	00 8c 04 00 00 80 00 	add    %cl,0x800000(%esp,%eax,1)
    1fe6:	00 00                	add    %al,(%eax)
    1fe8:	00 00                	add    %al,(%eax)
    1fea:	00 00                	add    %al,(%eax)
    1fec:	17                   	pop    %ss
    1fed:	05 00 00 80 00       	add    $0x800000,%eax
    1ff2:	00 00                	add    %al,(%eax)
    1ff4:	00 00                	add    %al,(%eax)
    1ff6:	00 00                	add    %al,(%eax)
    1ff8:	b4 05                	mov    $0x5,%ah
    1ffa:	00 00                	add    %al,(%eax)
    1ffc:	80 00 00             	addb   $0x0,(%eax)
    1fff:	00 00                	add    %al,(%eax)
    2001:	00 00                	add    %al,(%eax)
    2003:	00 44 06 00          	add    %al,0x0(%esi,%eax,1)
    2007:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    200d:	00 00                	add    %al,(%eax)
    200f:	00 00                	add    %al,(%eax)
    2011:	00 00                	add    %al,(%eax)
    2013:	00 a2 00 00 00 00    	add    %ah,0x0(%edx)
    2019:	00 00                	add    %al,(%eax)
    201b:	00 d7                	add    %dl,%bh
    201d:	0c 00                	or     $0x0,%al
    201f:	00 24 00             	add    %ah,(%eax,%eax,1)
    2022:	00 00                	add    %al,(%eax)
    2024:	bc 0a 28 00 00       	mov    $0x280a,%esp
    2029:	00 00                	add    %al,(%eax)
    202b:	00 44 00 05          	add    %al,0x5(%eax,%eax,1)
    202f:	00 00                	add    %al,(%eax)
    2031:	00 00                	add    %al,(%eax)
    2033:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    2039:	00 00                	add    %al,(%eax)
    203b:	00 bd 0a 28 00 00    	add    %bh,0x280a(%ebp)
    2041:	00 00                	add    %al,(%eax)
    2043:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    2047:	00 01                	add    %al,(%ecx)
    2049:	00 00                	add    %al,(%eax)
    204b:	00 c8                	add    %cl,%al
    204d:	0c 00                	or     $0x0,%al
    204f:	00 84 00 00 00 c2 0a 	add    %al,0xac20000(%eax,%eax,1)
    2056:	28 00                	sub    %al,(%eax)
    2058:	00 00                	add    %al,(%eax)
    205a:	00 00                	add    %al,(%eax)
    205c:	44                   	inc    %esp
    205d:	00 05 00 06 00 00    	add    %al,0x600
    2063:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    2069:	00 00                	add    %al,(%eax)
    206b:	00 c4                	add    %al,%ah
    206d:	0a 28                	or     (%eax),%ch
    206f:	00 00                	add    %al,(%eax)
    2071:	00 00                	add    %al,(%eax)
    2073:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    2077:	00 08                	add    %cl,(%eax)
    2079:	00 00                	add    %al,(%eax)
    207b:	00 c8                	add    %cl,%al
    207d:	0c 00                	or     $0x0,%al
    207f:	00 84 00 00 00 f4 0a 	add    %al,0xaf40000(%eax,%eax,1)
    2086:	28 00                	sub    %al,(%eax)
    2088:	00 00                	add    %al,(%eax)
    208a:	00 00                	add    %al,(%eax)
    208c:	44                   	inc    %esp
    208d:	00 4a 00             	add    %cl,0x0(%edx)
    2090:	38 00                	cmp    %al,(%eax)
    2092:	00 00                	add    %al,(%eax)
    2094:	e8 0c 00 00 24       	call   240020a5 <hehe+0x23d7f039>
    2099:	00 00                	add    %al,(%eax)
    209b:	00 f6                	add    %dh,%dh
    209d:	0a 28                	or     (%eax),%ch
    209f:	00 fd                	add    %bh,%ch
    20a1:	0c 00                	or     $0x0,%al
    20a3:	00 a0 00 00 00 08    	add    %ah,0x8000000(%eax)
    20a9:	00 00                	add    %al,(%eax)
    20ab:	00 00                	add    %al,(%eax)
    20ad:	00 00                	add    %al,(%eax)
    20af:	00 44 00 51          	add    %al,0x51(%eax,%eax,1)
    20b3:	00 00                	add    %al,(%eax)
    20b5:	00 00                	add    %al,(%eax)
    20b7:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    20bd:	00 00                	add    %al,(%eax)
    20bf:	00 f7                	add    %dh,%bh
    20c1:	0a 28                	or     (%eax),%ch
    20c3:	00 00                	add    %al,(%eax)
    20c5:	00 00                	add    %al,(%eax)
    20c7:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    20cb:	00 01                	add    %al,(%ecx)
    20cd:	00 00                	add    %al,(%eax)
    20cf:	00 c8                	add    %cl,%al
    20d1:	0c 00                	or     $0x0,%al
    20d3:	00 84 00 00 00 fc 0a 	add    %al,0xafc0000(%eax,%eax,1)
    20da:	28 00                	sub    %al,(%eax)
    20dc:	00 00                	add    %al,(%eax)
    20de:	00 00                	add    %al,(%eax)
    20e0:	44                   	inc    %esp
    20e1:	00 51 00             	add    %dl,0x0(%ecx)
    20e4:	06                   	push   %es
    20e5:	00 00                	add    %al,(%eax)
    20e7:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    20ed:	00 00                	add    %al,(%eax)
    20ef:	00 fe                	add    %bh,%dh
    20f1:	0a 28                	or     (%eax),%ch
    20f3:	00 00                	add    %al,(%eax)
    20f5:	00 00                	add    %al,(%eax)
    20f7:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    20fb:	00 08                	add    %cl,(%eax)
    20fd:	00 00                	add    %al,(%eax)
    20ff:	00 c8                	add    %cl,%al
    2101:	0c 00                	or     $0x0,%al
    2103:	00 84 00 00 00 00 0b 	add    %al,0xb000000(%eax,%eax,1)
    210a:	28 00                	sub    %al,(%eax)
    210c:	00 00                	add    %al,(%eax)
    210e:	00 00                	add    %al,(%eax)
    2110:	44                   	inc    %esp
    2111:	00 51 00             	add    %dl,0x0(%ecx)
    2114:	0a 00                	or     (%eax),%al
    2116:	00 00                	add    %al,(%eax)
    2118:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
    2119:	02 00                	add    (%eax),%al
    211b:	00 84 00 00 00 03 0b 	add    %al,0xb030000(%eax,%eax,1)
    2122:	28 00                	sub    %al,(%eax)
    2124:	00 00                	add    %al,(%eax)
    2126:	00 00                	add    %al,(%eax)
    2128:	44                   	inc    %esp
    2129:	00 5c 00 0d          	add    %bl,0xd(%eax,%eax,1)
    212d:	00 00                	add    %al,(%eax)
    212f:	00 00                	add    %al,(%eax)
    2131:	00 00                	add    %al,(%eax)
    2133:	00 44 00 42          	add    %al,0x42(%eax,%eax,1)
    2137:	00 0e                	add    %cl,(%esi)
    2139:	00 00                	add    %al,(%eax)
    213b:	00 c8                	add    %cl,%al
    213d:	0c 00                	or     $0x0,%al
    213f:	00 84 00 00 00 07 0b 	add    %al,0xb070000(%eax,%eax,1)
    2146:	28 00                	sub    %al,(%eax)
    2148:	00 00                	add    %al,(%eax)
    214a:	00 00                	add    %al,(%eax)
    214c:	44                   	inc    %esp
    214d:	00 55 00             	add    %dl,0x0(%ebp)
    2150:	11 00                	adc    %eax,(%eax)
    2152:	00 00                	add    %al,(%eax)
    2154:	00 00                	add    %al,(%eax)
    2156:	00 00                	add    %al,(%eax)
    2158:	44                   	inc    %esp
    2159:	00 57 00             	add    %dl,0x0(%edi)
    215c:	22 00                	and    (%eax),%al
    215e:	00 00                	add    %al,(%eax)
    2160:	10 0d 00 00 24 00    	adc    %cl,0x240000
    2166:	00 00                	add    %al,(%eax)
    2168:	1a 0b                	sbb    (%ebx),%cl
    216a:	28 00                	sub    %al,(%eax)
    216c:	25 0d 00 00 a0       	and    $0xa000000d,%eax
    2171:	00 00                	add    %al,(%eax)
    2173:	00 08                	add    %cl,(%eax)
    2175:	00 00                	add    %al,(%eax)
    2177:	00 00                	add    %al,(%eax)
    2179:	00 00                	add    %al,(%eax)
    217b:	00 44 00 5b          	add    %al,0x5b(%eax,%eax,1)
    217f:	00 00                	add    %al,(%eax)
    2181:	00 00                	add    %al,(%eax)
    2183:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    2189:	00 00                	add    %al,(%eax)
    218b:	00 1b                	add    %bl,(%ebx)
    218d:	0b 28                	or     (%eax),%ebp
    218f:	00 00                	add    %al,(%eax)
    2191:	00 00                	add    %al,(%eax)
    2193:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    2197:	00 01                	add    %al,(%ecx)
    2199:	00 00                	add    %al,(%eax)
    219b:	00 c8                	add    %cl,%al
    219d:	0c 00                	or     $0x0,%al
    219f:	00 84 00 00 00 20 0b 	add    %al,0xb200000(%eax,%eax,1)
    21a6:	28 00                	sub    %al,(%eax)
    21a8:	00 00                	add    %al,(%eax)
    21aa:	00 00                	add    %al,(%eax)
    21ac:	44                   	inc    %esp
    21ad:	00 5b 00             	add    %bl,0x0(%ebx)
    21b0:	06                   	push   %es
    21b1:	00 00                	add    %al,(%eax)
    21b3:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    21b9:	00 00                	add    %al,(%eax)
    21bb:	00 22                	add    %ah,(%edx)
    21bd:	0b 28                	or     (%eax),%ebp
    21bf:	00 00                	add    %al,(%eax)
    21c1:	00 00                	add    %al,(%eax)
    21c3:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    21c7:	00 08                	add    %cl,(%eax)
    21c9:	00 00                	add    %al,(%eax)
    21cb:	00 c8                	add    %cl,%al
    21cd:	0c 00                	or     $0x0,%al
    21cf:	00 84 00 00 00 24 0b 	add    %al,0xb240000(%eax,%eax,1)
    21d6:	28 00                	sub    %al,(%eax)
    21d8:	00 00                	add    %al,(%eax)
    21da:	00 00                	add    %al,(%eax)
    21dc:	44                   	inc    %esp
    21dd:	00 5b 00             	add    %bl,0x0(%ebx)
    21e0:	0a 00                	or     (%eax),%al
    21e2:	00 00                	add    %al,(%eax)
    21e4:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
    21e5:	02 00                	add    (%eax),%al
    21e7:	00 84 00 00 00 27 0b 	add    %al,0xb270000(%eax,%eax,1)
    21ee:	28 00                	sub    %al,(%eax)
    21f0:	00 00                	add    %al,(%eax)
    21f2:	00 00                	add    %al,(%eax)
    21f4:	44                   	inc    %esp
    21f5:	00 5c 00 0d          	add    %bl,0xd(%eax,%eax,1)
    21f9:	00 00                	add    %al,(%eax)
    21fb:	00 00                	add    %al,(%eax)
    21fd:	00 00                	add    %al,(%eax)
    21ff:	00 44 00 42          	add    %al,0x42(%eax,%eax,1)
    2203:	00 13                	add    %dl,(%ebx)
    2205:	00 00                	add    %al,(%eax)
    2207:	00 c8                	add    %cl,%al
    2209:	0c 00                	or     $0x0,%al
    220b:	00 84 00 00 00 30 0b 	add    %al,0xb300000(%eax,%eax,1)
    2212:	28 00                	sub    %al,(%eax)
    2214:	00 00                	add    %al,(%eax)
    2216:	00 00                	add    %al,(%eax)
    2218:	44                   	inc    %esp
    2219:	00 60 00             	add    %ah,0x0(%eax)
    221c:	16                   	push   %ss
    221d:	00 00                	add    %al,(%eax)
    221f:	00 00                	add    %al,(%eax)
    2221:	00 00                	add    %al,(%eax)
    2223:	00 44 00 62          	add    %al,0x62(%eax,%eax,1)
    2227:	00 27                	add    %ah,(%edi)
    2229:	00 00                	add    %al,(%eax)
    222b:	00 31                	add    %dh,(%ecx)
    222d:	0d 00 00 24 00       	or     $0x240000,%eax
    2232:	00 00                	add    %al,(%eax)
    2234:	43                   	inc    %ebx
    2235:	0b 28                	or     (%eax),%ebp
    2237:	00 25 0d 00 00 a0    	add    %ah,0xa000000d
    223d:	00 00                	add    %al,(%eax)
    223f:	00 08                	add    %cl,(%eax)
    2241:	00 00                	add    %al,(%eax)
    2243:	00 00                	add    %al,(%eax)
    2245:	00 00                	add    %al,(%eax)
    2247:	00 44 00 65          	add    %al,0x65(%eax,%eax,1)
    224b:	00 00                	add    %al,(%eax)
    224d:	00 00                	add    %al,(%eax)
    224f:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    2255:	00 00                	add    %al,(%eax)
    2257:	00 44 0b 28          	add    %al,0x28(%ebx,%ecx,1)
    225b:	00 00                	add    %al,(%eax)
    225d:	00 00                	add    %al,(%eax)
    225f:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    2263:	00 01                	add    %al,(%ecx)
    2265:	00 00                	add    %al,(%eax)
    2267:	00 c8                	add    %cl,%al
    2269:	0c 00                	or     $0x0,%al
    226b:	00 84 00 00 00 49 0b 	add    %al,0xb490000(%eax,%eax,1)
    2272:	28 00                	sub    %al,(%eax)
    2274:	00 00                	add    %al,(%eax)
    2276:	00 00                	add    %al,(%eax)
    2278:	44                   	inc    %esp
    2279:	00 65 00             	add    %ah,0x0(%ebp)
    227c:	06                   	push   %es
    227d:	00 00                	add    %al,(%eax)
    227f:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    2285:	00 00                	add    %al,(%eax)
    2287:	00 4b 0b             	add    %cl,0xb(%ebx)
    228a:	28 00                	sub    %al,(%eax)
    228c:	00 00                	add    %al,(%eax)
    228e:	00 00                	add    %al,(%eax)
    2290:	44                   	inc    %esp
    2291:	00 5c 00 08          	add    %bl,0x8(%eax,%eax,1)
    2295:	00 00                	add    %al,(%eax)
    2297:	00 c8                	add    %cl,%al
    2299:	0c 00                	or     $0x0,%al
    229b:	00 84 00 00 00 4e 0b 	add    %al,0xb4e0000(%eax,%eax,1)
    22a2:	28 00                	sub    %al,(%eax)
    22a4:	00 00                	add    %al,(%eax)
    22a6:	00 00                	add    %al,(%eax)
    22a8:	44                   	inc    %esp
    22a9:	00 68 00             	add    %ch,0x0(%eax)
    22ac:	0b 00                	or     (%eax),%eax
    22ae:	00 00                	add    %al,(%eax)
    22b0:	46                   	inc    %esi
    22b1:	0d 00 00 20 00       	or     $0x200000,%eax
    22b6:	00 00                	add    %al,(%eax)
    22b8:	00 00                	add    %al,(%eax)
    22ba:	00 00                	add    %al,(%eax)
    22bc:	55                   	push   %ebp
    22bd:	0d 00 00 20 00       	or     $0x200000,%eax
	...
    22ca:	00 00                	add    %al,(%eax)
    22cc:	64 00 00             	add    %al,%fs:(%eax)
    22cf:	00 50 0b             	add    %dl,0xb(%eax)
    22d2:	28 00                	sub    %al,(%eax)
    22d4:	66 0d 00 00          	or     $0x0,%ax
    22d8:	64 00 00             	add    %al,%fs:(%eax)
    22db:	00 50 0b             	add    %dl,0xb(%eax)
    22de:	28 00                	sub    %al,(%eax)
    22e0:	76 0d                	jbe    22ef <bootmain-0x27dd11>
    22e2:	00 00                	add    %al,(%eax)
    22e4:	84 00                	test   %al,(%eax)
    22e6:	00 00                	add    %al,(%eax)
    22e8:	50                   	push   %eax
    22e9:	0b 28                	or     (%eax),%ebp
    22eb:	00 00                	add    %al,(%eax)
    22ed:	00 00                	add    %al,(%eax)
    22ef:	00 44 00 09          	add    %al,0x9(%eax,%eax,1)
    22f3:	00 50 0b             	add    %dl,0xb(%eax)
    22f6:	28 00                	sub    %al,(%eax)
    22f8:	00 00                	add    %al,(%eax)
    22fa:	00 00                	add    %al,(%eax)
    22fc:	44                   	inc    %esp
    22fd:	00 0a                	add    %cl,(%edx)
    22ff:	00 52 0b             	add    %dl,0xb(%edx)
    2302:	28 00                	sub    %al,(%eax)
    2304:	00 00                	add    %al,(%eax)
    2306:	00 00                	add    %al,(%eax)
    2308:	44                   	inc    %esp
    2309:	00 0b                	add    %cl,(%ebx)
    230b:	00 54 0b 28          	add    %dl,0x28(%ebx,%ecx,1)
    230f:	00 00                	add    %al,(%eax)
    2311:	00 00                	add    %al,(%eax)
    2313:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
    2317:	00 55 0b             	add    %dl,0xb(%ebp)
    231a:	28 00                	sub    %al,(%eax)
    231c:	00 00                	add    %al,(%eax)
    231e:	00 00                	add    %al,(%eax)
    2320:	44                   	inc    %esp
    2321:	00 0d 00 57 0b 28    	add    %cl,0x280b5700
    2327:	00 00                	add    %al,(%eax)
    2329:	00 00                	add    %al,(%eax)
    232b:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
    232f:	00 58 0b             	add    %bl,0xb(%eax)
    2332:	28 00                	sub    %al,(%eax)
    2334:	00 00                	add    %al,(%eax)
    2336:	00 00                	add    %al,(%eax)
    2338:	44                   	inc    %esp
    2339:	00 0f                	add    %cl,(%edi)
    233b:	00 5b 0b             	add    %bl,0xb(%ebx)
    233e:	28 00                	sub    %al,(%eax)
    2340:	00 00                	add    %al,(%eax)
    2342:	00 00                	add    %al,(%eax)
    2344:	44                   	inc    %esp
    2345:	00 10                	add    %dl,(%eax)
    2347:	00 5d 0b             	add    %bl,0xb(%ebp)
    234a:	28 00                	sub    %al,(%eax)
    234c:	00 00                	add    %al,(%eax)
    234e:	00 00                	add    %al,(%eax)
    2350:	44                   	inc    %esp
    2351:	00 11                	add    %dl,(%ecx)
    2353:	00 5f 0b             	add    %bl,0xb(%edi)
    2356:	28 00                	sub    %al,(%eax)
    2358:	00 00                	add    %al,(%eax)
    235a:	00 00                	add    %al,(%eax)
    235c:	44                   	inc    %esp
    235d:	00 12                	add    %dl,(%edx)
    235f:	00 64 0b 28          	add    %ah,0x28(%ebx,%ecx,1)
    2363:	00 00                	add    %al,(%eax)
    2365:	00 00                	add    %al,(%eax)
    2367:	00 44 00 13          	add    %al,0x13(%eax,%eax,1)
    236b:	00 65 0b             	add    %ah,0xb(%ebp)
    236e:	28 00                	sub    %al,(%eax)
    2370:	00 00                	add    %al,(%eax)
    2372:	00 00                	add    %al,(%eax)
    2374:	44                   	inc    %esp
    2375:	00 14 00             	add    %dl,(%eax,%eax,1)
    2378:	66 0b 28             	or     (%eax),%bp
    237b:	00 00                	add    %al,(%eax)
    237d:	00 00                	add    %al,(%eax)
    237f:	00 44 00 15          	add    %al,0x15(%eax,%eax,1)
    2383:	00 68 0b             	add    %ch,0xb(%eax)
    2386:	28 00                	sub    %al,(%eax)
    2388:	00 00                	add    %al,(%eax)
    238a:	00 00                	add    %al,(%eax)
    238c:	44                   	inc    %esp
    238d:	00 16                	add    %dl,(%esi)
    238f:	00 6a 0b             	add    %ch,0xb(%edx)
    2392:	28 00                	sub    %al,(%eax)
    2394:	00 00                	add    %al,(%eax)
    2396:	00 00                	add    %al,(%eax)
    2398:	44                   	inc    %esp
    2399:	00 19                	add    %bl,(%ecx)
    239b:	00 6b 0b             	add    %ch,0xb(%ebx)
    239e:	28 00                	sub    %al,(%eax)
    23a0:	00 00                	add    %al,(%eax)
    23a2:	00 00                	add    %al,(%eax)
    23a4:	44                   	inc    %esp
    23a5:	00 1a                	add    %bl,(%edx)
    23a7:	00 6d 0b             	add    %ch,0xb(%ebp)
    23aa:	28 00                	sub    %al,(%eax)
    23ac:	00 00                	add    %al,(%eax)
    23ae:	00 00                	add    %al,(%eax)
    23b0:	44                   	inc    %esp
    23b1:	00 1b                	add    %bl,(%ebx)
    23b3:	00 6f 0b             	add    %ch,0xb(%edi)
    23b6:	28 00                	sub    %al,(%eax)
    23b8:	00 00                	add    %al,(%eax)
    23ba:	00 00                	add    %al,(%eax)
    23bc:	44                   	inc    %esp
    23bd:	00 1c 00             	add    %bl,(%eax,%eax,1)
    23c0:	70 0b                	jo     23cd <bootmain-0x27dc33>
    23c2:	28 00                	sub    %al,(%eax)
    23c4:	00 00                	add    %al,(%eax)
    23c6:	00 00                	add    %al,(%eax)
    23c8:	44                   	inc    %esp
    23c9:	00 1d 00 72 0b 28    	add    %bl,0x280b7200
    23cf:	00 00                	add    %al,(%eax)
    23d1:	00 00                	add    %al,(%eax)
    23d3:	00 44 00 1e          	add    %al,0x1e(%eax,%eax,1)
    23d7:	00 73 0b             	add    %dh,0xb(%ebx)
    23da:	28 00                	sub    %al,(%eax)
    23dc:	00 00                	add    %al,(%eax)
    23de:	00 00                	add    %al,(%eax)
    23e0:	44                   	inc    %esp
    23e1:	00 1f                	add    %bl,(%edi)
    23e3:	00 76 0b             	add    %dh,0xb(%esi)
    23e6:	28 00                	sub    %al,(%eax)
    23e8:	00 00                	add    %al,(%eax)
    23ea:	00 00                	add    %al,(%eax)
    23ec:	44                   	inc    %esp
    23ed:	00 20                	add    %ah,(%eax)
    23ef:	00 78 0b             	add    %bh,0xb(%eax)
    23f2:	28 00                	sub    %al,(%eax)
    23f4:	00 00                	add    %al,(%eax)
    23f6:	00 00                	add    %al,(%eax)
    23f8:	44                   	inc    %esp
    23f9:	00 21                	add    %ah,(%ecx)
    23fb:	00 7a 0b             	add    %bh,0xb(%edx)
    23fe:	28 00                	sub    %al,(%eax)
    2400:	00 00                	add    %al,(%eax)
    2402:	00 00                	add    %al,(%eax)
    2404:	44                   	inc    %esp
    2405:	00 22                	add    %ah,(%edx)
    2407:	00 7f 0b             	add    %bh,0xb(%edi)
    240a:	28 00                	sub    %al,(%eax)
    240c:	00 00                	add    %al,(%eax)
    240e:	00 00                	add    %al,(%eax)
    2410:	44                   	inc    %esp
    2411:	00 23                	add    %ah,(%ebx)
    2413:	00 80 0b 28 00 00    	add    %al,0x280b(%eax)
    2419:	00 00                	add    %al,(%eax)
    241b:	00 44 00 24          	add    %al,0x24(%eax,%eax,1)
    241f:	00 81 0b 28 00 00    	add    %al,0x280b(%ecx)
    2425:	00 00                	add    %al,(%eax)
    2427:	00 44 00 25          	add    %al,0x25(%eax,%eax,1)
    242b:	00 83 0b 28 00 00    	add    %al,0x280b(%ebx)
    2431:	00 00                	add    %al,(%eax)
    2433:	00 44 00 26          	add    %al,0x26(%eax,%eax,1)
    2437:	00 85 0b 28 00 00    	add    %al,0x280b(%ebp)
    243d:	00 00                	add    %al,(%eax)
    243f:	00 44 00 29          	add    %al,0x29(%eax,%eax,1)
    2443:	00 86 0b 28 00 00    	add    %al,0x280b(%esi)
    2449:	00 00                	add    %al,(%eax)
    244b:	00 44 00 2a          	add    %al,0x2a(%eax,%eax,1)
    244f:	00 88 0b 28 00 00    	add    %cl,0x280b(%eax)
    2455:	00 00                	add    %al,(%eax)
    2457:	00 44 00 2b          	add    %al,0x2b(%eax,%eax,1)
    245b:	00 8a 0b 28 00 00    	add    %cl,0x280b(%edx)
    2461:	00 00                	add    %al,(%eax)
    2463:	00 44 00 2c          	add    %al,0x2c(%eax,%eax,1)
    2467:	00 8b 0b 28 00 00    	add    %cl,0x280b(%ebx)
    246d:	00 00                	add    %al,(%eax)
    246f:	00 44 00 2d          	add    %al,0x2d(%eax,%eax,1)
    2473:	00 8d 0b 28 00 00    	add    %cl,0x280b(%ebp)
    2479:	00 00                	add    %al,(%eax)
    247b:	00 44 00 2e          	add    %al,0x2e(%eax,%eax,1)
    247f:	00 8e 0b 28 00 00    	add    %cl,0x280b(%esi)
    2485:	00 00                	add    %al,(%eax)
    2487:	00 44 00 2f          	add    %al,0x2f(%eax,%eax,1)
    248b:	00 91 0b 28 00 00    	add    %dl,0x280b(%ecx)
    2491:	00 00                	add    %al,(%eax)
    2493:	00 44 00 30          	add    %al,0x30(%eax,%eax,1)
    2497:	00 93 0b 28 00 00    	add    %dl,0x280b(%ebx)
    249d:	00 00                	add    %al,(%eax)
    249f:	00 44 00 31          	add    %al,0x31(%eax,%eax,1)
    24a3:	00 95 0b 28 00 00    	add    %dl,0x280b(%ebp)
    24a9:	00 00                	add    %al,(%eax)
    24ab:	00 44 00 32          	add    %al,0x32(%eax,%eax,1)
    24af:	00 9a 0b 28 00 00    	add    %bl,0x280b(%edx)
    24b5:	00 00                	add    %al,(%eax)
    24b7:	00 44 00 33          	add    %al,0x33(%eax,%eax,1)
    24bb:	00 9b 0b 28 00 00    	add    %bl,0x280b(%ebx)
    24c1:	00 00                	add    %al,(%eax)
    24c3:	00 44 00 34          	add    %al,0x34(%eax,%eax,1)
    24c7:	00 9c 0b 28 00 00 00 	add    %bl,0x28(%ebx,%ecx,1)
    24ce:	00 00                	add    %al,(%eax)
    24d0:	44                   	inc    %esp
    24d1:	00 35 00 9e 0b 28    	add    %dh,0x280b9e00
    24d7:	00 00                	add    %al,(%eax)
    24d9:	00 00                	add    %al,(%eax)
    24db:	00 44 00 36          	add    %al,0x36(%eax,%eax,1)
    24df:	00 a0 0b 28 00 00    	add    %ah,0x280b(%eax)
    24e5:	00 00                	add    %al,(%eax)
    24e7:	00 44 00 39          	add    %al,0x39(%eax,%eax,1)
    24eb:	00 a1 0b 28 00 00    	add    %ah,0x280b(%ecx)
    24f1:	00 00                	add    %al,(%eax)
    24f3:	00 44 00 3a          	add    %al,0x3a(%eax,%eax,1)
    24f7:	00 a6 0b 28 00 00    	add    %ah,0x280b(%esi)
    24fd:	00 00                	add    %al,(%eax)
    24ff:	00 44 00 3b          	add    %al,0x3b(%eax,%eax,1)
    2503:	00 ab 0b 28 00 00    	add    %ch,0x280b(%ebx)
    2509:	00 00                	add    %al,(%eax)
    250b:	00 44 00 3c          	add    %al,0x3c(%eax,%eax,1)
    250f:	00 b0 0b 28 00 00    	add    %dh,0x280b(%eax)
    2515:	00 00                	add    %al,(%eax)
    2517:	00 44 00 3f          	add    %al,0x3f(%eax,%eax,1)
    251b:	00 b1 0b 28 00 00    	add    %dh,0x280b(%ecx)
    2521:	00 00                	add    %al,(%eax)
    2523:	00 44 00 40          	add    %al,0x40(%eax,%eax,1)
    2527:	00 b6 0b 28 00 00    	add    %dh,0x280b(%esi)
    252d:	00 00                	add    %al,(%eax)
    252f:	00 44 00 41          	add    %al,0x41(%eax,%eax,1)
    2533:	00 bb 0b 28 00 00    	add    %bh,0x280b(%ebx)
    2539:	00 00                	add    %al,(%eax)
    253b:	00 44 00 42          	add    %al,0x42(%eax,%eax,1)
    253f:	00 c0                	add    %al,%al
    2541:	0b 28                	or     (%eax),%ebp
    2543:	00 00                	add    %al,(%eax)
    2545:	00 00                	add    %al,(%eax)
    2547:	00 44 00 45          	add    %al,0x45(%eax,%eax,1)
    254b:	00 c1                	add    %al,%cl
    254d:	0b 28                	or     (%eax),%ebp
    254f:	00 00                	add    %al,(%eax)
    2551:	00 00                	add    %al,(%eax)
    2553:	00 44 00 46          	add    %al,0x46(%eax,%eax,1)
    2557:	00 c2                	add    %al,%dl
    2559:	0b 28                	or     (%eax),%ebp
    255b:	00 00                	add    %al,(%eax)
    255d:	00 00                	add    %al,(%eax)
    255f:	00 44 00 47          	add    %al,0x47(%eax,%eax,1)
    2563:	00 c3                	add    %al,%bl
    2565:	0b 28                	or     (%eax),%ebp
    2567:	00 81 0d 00 00 64    	add    %al,0x6400000d(%ecx)
    256d:	00 02                	add    %al,(%edx)
    256f:	00 c4                	add    %al,%ah
    2571:	0b 28                	or     (%eax),%ebp
    2573:	00 08                	add    %cl,(%eax)
    2575:	00 00                	add    %al,(%eax)
    2577:	00 3c 00             	add    %bh,(%eax,%eax,1)
    257a:	00 00                	add    %al,(%eax)
    257c:	00 00                	add    %al,(%eax)
    257e:	00 00                	add    %al,(%eax)
    2580:	17                   	pop    %ss
    2581:	00 00                	add    %al,(%eax)
    2583:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2589:	00 00                	add    %al,(%eax)
    258b:	00 41 00             	add    %al,0x0(%ecx)
    258e:	00 00                	add    %al,(%eax)
    2590:	80 00 00             	addb   $0x0,(%eax)
    2593:	00 00                	add    %al,(%eax)
    2595:	00 00                	add    %al,(%eax)
    2597:	00 5b 00             	add    %bl,0x0(%ebx)
    259a:	00 00                	add    %al,(%eax)
    259c:	80 00 00             	addb   $0x0,(%eax)
    259f:	00 00                	add    %al,(%eax)
    25a1:	00 00                	add    %al,(%eax)
    25a3:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
    25a9:	00 00                	add    %al,(%eax)
    25ab:	00 00                	add    %al,(%eax)
    25ad:	00 00                	add    %al,(%eax)
    25af:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
    25b5:	00 00                	add    %al,(%eax)
    25b7:	00 00                	add    %al,(%eax)
    25b9:	00 00                	add    %al,(%eax)
    25bb:	00 e1                	add    %ah,%cl
    25bd:	00 00                	add    %al,(%eax)
    25bf:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    25c5:	00 00                	add    %al,(%eax)
    25c7:	00 0c 01             	add    %cl,(%ecx,%eax,1)
    25ca:	00 00                	add    %al,(%eax)
    25cc:	80 00 00             	addb   $0x0,(%eax)
    25cf:	00 00                	add    %al,(%eax)
    25d1:	00 00                	add    %al,(%eax)
    25d3:	00 37                	add    %dh,(%edi)
    25d5:	01 00                	add    %eax,(%eax)
    25d7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    25dd:	00 00                	add    %al,(%eax)
    25df:	00 5d 01             	add    %bl,0x1(%ebp)
    25e2:	00 00                	add    %al,(%eax)
    25e4:	80 00 00             	addb   $0x0,(%eax)
    25e7:	00 00                	add    %al,(%eax)
    25e9:	00 00                	add    %al,(%eax)
    25eb:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
    25f1:	00 00                	add    %al,(%eax)
    25f3:	00 00                	add    %al,(%eax)
    25f5:	00 00                	add    %al,(%eax)
    25f7:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
    25fd:	00 00                	add    %al,(%eax)
    25ff:	00 00                	add    %al,(%eax)
    2601:	00 00                	add    %al,(%eax)
    2603:	00 d2                	add    %dl,%dl
    2605:	01 00                	add    %eax,(%eax)
    2607:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    260d:	00 00                	add    %al,(%eax)
    260f:	00 ec                	add    %ch,%ah
    2611:	01 00                	add    %eax,(%eax)
    2613:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2619:	00 00                	add    %al,(%eax)
    261b:	00 07                	add    %al,(%edi)
    261d:	02 00                	add    (%eax),%al
    261f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2625:	00 00                	add    %al,(%eax)
    2627:	00 28                	add    %ch,(%eax)
    2629:	02 00                	add    (%eax),%al
    262b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2631:	00 00                	add    %al,(%eax)
    2633:	00 47 02             	add    %al,0x2(%edi)
    2636:	00 00                	add    %al,(%eax)
    2638:	80 00 00             	addb   $0x0,(%eax)
    263b:	00 00                	add    %al,(%eax)
    263d:	00 00                	add    %al,(%eax)
    263f:	00 66 02             	add    %ah,0x2(%esi)
    2642:	00 00                	add    %al,(%eax)
    2644:	80 00 00             	addb   $0x0,(%eax)
    2647:	00 00                	add    %al,(%eax)
    2649:	00 00                	add    %al,(%eax)
    264b:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
    2651:	00 00                	add    %al,(%eax)
    2653:	00 00                	add    %al,(%eax)
    2655:	00 00                	add    %al,(%eax)
    2657:	00 ce                	add    %cl,%dh
    2659:	0c 00                	or     $0x0,%al
    265b:	00 c2                	add    %al,%dl
    265d:	00 00                	add    %al,(%eax)
    265f:	00 f2                	add    %dh,%dl
    2661:	aa                   	stos   %al,%es:(%edi)
    2662:	00 00                	add    %al,(%eax)
    2664:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
    2665:	02 00                	add    (%eax),%al
    2667:	00 c2                	add    %al,%dl
    2669:	00 00                	add    %al,(%eax)
    266b:	00 00                	add    %al,(%eax)
    266d:	00 00                	add    %al,(%eax)
    266f:	00 ae 02 00 00 c2    	add    %ch,-0x3dfffffe(%esi)
    2675:	00 00                	add    %al,(%eax)
    2677:	00 37                	add    %dh,(%edi)
    2679:	53                   	push   %ebx
    267a:	00 00                	add    %al,(%eax)
    267c:	88 0d 00 00 24 00    	mov    %cl,0x240000
    2682:	00 00                	add    %al,(%eax)
    2684:	c4 0b                	les    (%ebx),%ecx
    2686:	28 00                	sub    %al,(%eax)
    2688:	9b                   	fwait
    2689:	0d 00 00 a0 00       	or     $0xa00000,%eax
    268e:	00 00                	add    %al,(%eax)
    2690:	08 00                	or     %al,(%eax)
    2692:	00 00                	add    %al,(%eax)
    2694:	af                   	scas   %es:(%edi),%eax
    2695:	0d 00 00 a0 00       	or     $0xa00000,%eax
    269a:	00 00                	add    %al,(%eax)
    269c:	0c 00                	or     $0x0,%al
    269e:	00 00                	add    %al,(%eax)
    26a0:	bb 0d 00 00 a0       	mov    $0xa000000d,%ebx
    26a5:	00 00                	add    %al,(%eax)
    26a7:	00 10                	add    %dl,(%eax)
    26a9:	00 00                	add    %al,(%eax)
    26ab:	00 00                	add    %al,(%eax)
    26ad:	00 00                	add    %al,(%eax)
    26af:	00 44 00 08          	add    %al,0x8(%eax,%eax,1)
	...
    26bb:	00 44 00 08          	add    %al,0x8(%eax,%eax,1)
    26bf:	00 03                	add    %al,(%ebx)
    26c1:	00 00                	add    %al,(%eax)
    26c3:	00 00                	add    %al,(%eax)
    26c5:	00 00                	add    %al,(%eax)
    26c7:	00 44 00 0a          	add    %al,0xa(%eax,%eax,1)
    26cb:	00 09                	add    %cl,(%ecx)
    26cd:	00 00                	add    %al,(%eax)
    26cf:	00 00                	add    %al,(%eax)
    26d1:	00 00                	add    %al,(%eax)
    26d3:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
    26d7:	00 0c 00             	add    %cl,(%eax,%eax,1)
    26da:	00 00                	add    %al,(%eax)
    26dc:	00 00                	add    %al,(%eax)
    26de:	00 00                	add    %al,(%eax)
    26e0:	44                   	inc    %esp
    26e1:	00 09                	add    %cl,(%ecx)
    26e3:	00 13                	add    %dl,(%ebx)
    26e5:	00 00                	add    %al,(%eax)
    26e7:	00 00                	add    %al,(%eax)
    26e9:	00 00                	add    %al,(%eax)
    26eb:	00 44 00 0a          	add    %al,0xa(%eax,%eax,1)
    26ef:	00 16                	add    %dl,(%esi)
    26f1:	00 00                	add    %al,(%eax)
    26f3:	00 00                	add    %al,(%eax)
    26f5:	00 00                	add    %al,(%eax)
    26f7:	00 44 00 0b          	add    %al,0xb(%eax,%eax,1)
    26fb:	00 18                	add    %bl,(%eax)
    26fd:	00 00                	add    %al,(%eax)
    26ff:	00 00                	add    %al,(%eax)
    2701:	00 00                	add    %al,(%eax)
    2703:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    2707:	00 1b                	add    %bl,(%ebx)
    2709:	00 00                	add    %al,(%eax)
    270b:	00 00                	add    %al,(%eax)
    270d:	00 00                	add    %al,(%eax)
    270f:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
    2713:	00 22                	add    %ah,(%edx)
    2715:	00 00                	add    %al,(%eax)
    2717:	00 00                	add    %al,(%eax)
    2719:	00 00                	add    %al,(%eax)
    271b:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
    271f:	00 29                	add    %ch,(%ecx)
    2721:	00 00                	add    %al,(%eax)
    2723:	00 c6                	add    %al,%dh
    2725:	0d 00 00 40 00       	or     $0x400000,%eax
    272a:	00 00                	add    %al,(%eax)
    272c:	00 00                	add    %al,(%eax)
    272e:	00 00                	add    %al,(%eax)
    2730:	d3 0d 00 00 40 00    	rorl   %cl,0x400000
    2736:	00 00                	add    %al,(%eax)
    2738:	02 00                	add    (%eax),%al
    273a:	00 00                	add    %al,(%eax)
    273c:	df 0d 00 00 40 00    	fisttp 0x400000
    2742:	00 00                	add    %al,(%eax)
    2744:	01 00                	add    %eax,(%eax)
    2746:	00 00                	add    %al,(%eax)
    2748:	ea 0d 00 00 24 00 00 	ljmp   $0x0,$0x2400000d
    274f:	00 ef                	add    %ch,%bh
    2751:	0b 28                	or     (%eax),%ebp
    2753:	00 fb                	add    %bh,%bl
    2755:	0d 00 00 a0 00       	or     $0xa00000,%eax
    275a:	00 00                	add    %al,(%eax)
    275c:	08 00                	or     %al,(%eax)
    275e:	00 00                	add    %al,(%eax)
    2760:	08 0e                	or     %cl,(%esi)
    2762:	00 00                	add    %al,(%eax)
    2764:	a0 00 00 00 0c       	mov    0xc000000,%al
    2769:	00 00                	add    %al,(%eax)
    276b:	00 00                	add    %al,(%eax)
    276d:	00 00                	add    %al,(%eax)
    276f:	00 44 00 13          	add    %al,0x13(%eax,%eax,1)
	...
    277b:	00 44 00 13          	add    %al,0x13(%eax,%eax,1)
    277f:	00 07                	add    %al,(%edi)
    2781:	00 00                	add    %al,(%eax)
    2783:	00 00                	add    %al,(%eax)
    2785:	00 00                	add    %al,(%eax)
    2787:	00 44 00 14          	add    %al,0x14(%eax,%eax,1)
    278b:	00 0a                	add    %cl,(%edx)
    278d:	00 00                	add    %al,(%eax)
    278f:	00 00                	add    %al,(%eax)
    2791:	00 00                	add    %al,(%eax)
    2793:	00 44 00 16          	add    %al,0x16(%eax,%eax,1)
    2797:	00 10                	add    %dl,(%eax)
    2799:	00 00                	add    %al,(%eax)
    279b:	00 00                	add    %al,(%eax)
    279d:	00 00                	add    %al,(%eax)
    279f:	00 44 00 17          	add    %al,0x17(%eax,%eax,1)
    27a3:	00 14 00             	add    %dl,(%eax,%eax,1)
    27a6:	00 00                	add    %al,(%eax)
    27a8:	00 00                	add    %al,(%eax)
    27aa:	00 00                	add    %al,(%eax)
    27ac:	44                   	inc    %esp
    27ad:	00 19                	add    %bl,(%ecx)
    27af:	00 19                	add    %bl,(%ecx)
    27b1:	00 00                	add    %al,(%eax)
    27b3:	00 00                	add    %al,(%eax)
    27b5:	00 00                	add    %al,(%eax)
    27b7:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
    27bb:	00 21                	add    %ah,(%ecx)
    27bd:	00 00                	add    %al,(%eax)
    27bf:	00 00                	add    %al,(%eax)
    27c1:	00 00                	add    %al,(%eax)
    27c3:	00 44 00 1b          	add    %al,0x1b(%eax,%eax,1)
    27c7:	00 27                	add    %ah,(%edi)
    27c9:	00 00                	add    %al,(%eax)
    27cb:	00 00                	add    %al,(%eax)
    27cd:	00 00                	add    %al,(%eax)
    27cf:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
    27d3:	00 2a                	add    %ch,(%edx)
    27d5:	00 00                	add    %al,(%eax)
    27d7:	00 00                	add    %al,(%eax)
    27d9:	00 00                	add    %al,(%eax)
    27db:	00 44 00 1b          	add    %al,0x1b(%eax,%eax,1)
    27df:	00 2d 00 00 00 00    	add    %ch,0x0
    27e5:	00 00                	add    %al,(%eax)
    27e7:	00 44 00 1c          	add    %al,0x1c(%eax,%eax,1)
    27eb:	00 2f                	add    %ch,(%edi)
    27ed:	00 00                	add    %al,(%eax)
    27ef:	00 00                	add    %al,(%eax)
    27f1:	00 00                	add    %al,(%eax)
    27f3:	00 44 00 1e          	add    %al,0x1e(%eax,%eax,1)
    27f7:	00 36                	add    %dh,(%esi)
    27f9:	00 00                	add    %al,(%eax)
    27fb:	00 00                	add    %al,(%eax)
    27fd:	00 00                	add    %al,(%eax)
    27ff:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
    2803:	00 39                	add    %bh,(%ecx)
    2805:	00 00                	add    %al,(%eax)
    2807:	00 00                	add    %al,(%eax)
    2809:	00 00                	add    %al,(%eax)
    280b:	00 44 00 20          	add    %al,0x20(%eax,%eax,1)
    280f:	00 3b                	add    %bh,(%ebx)
    2811:	00 00                	add    %al,(%eax)
    2813:	00 c6                	add    %al,%dh
    2815:	0d 00 00 40 00       	or     $0x400000,%eax
    281a:	00 00                	add    %al,(%eax)
    281c:	00 00                	add    %al,(%eax)
    281e:	00 00                	add    %al,(%eax)
    2820:	14 0e                	adc    $0xe,%al
    2822:	00 00                	add    %al,(%eax)
    2824:	24 00                	and    $0x0,%al
    2826:	00 00                	add    %al,(%eax)
    2828:	2d 0c 28 00 fb       	sub    $0xfb00280c,%eax
    282d:	0d 00 00 a0 00       	or     $0xa00000,%eax
    2832:	00 00                	add    %al,(%eax)
    2834:	08 00                	or     %al,(%eax)
    2836:	00 00                	add    %al,(%eax)
    2838:	00 00                	add    %al,(%eax)
    283a:	00 00                	add    %al,(%eax)
    283c:	44                   	inc    %esp
    283d:	00 23                	add    %ah,(%ebx)
	...
    2847:	00 44 00 25          	add    %al,0x25(%eax,%eax,1)
    284b:	00 09                	add    %cl,(%ecx)
    284d:	00 00                	add    %al,(%eax)
    284f:	00 00                	add    %al,(%eax)
    2851:	00 00                	add    %al,(%eax)
    2853:	00 44 00 29          	add    %al,0x29(%eax,%eax,1)
    2857:	00 13                	add    %dl,(%ebx)
    2859:	00 00                	add    %al,(%eax)
    285b:	00 00                	add    %al,(%eax)
    285d:	00 00                	add    %al,(%eax)
    285f:	00 44 00 2a          	add    %al,0x2a(%eax,%eax,1)
    2863:	00 16                	add    %dl,(%esi)
    2865:	00 00                	add    %al,(%eax)
    2867:	00 00                	add    %al,(%eax)
    2869:	00 00                	add    %al,(%eax)
    286b:	00 44 00 29          	add    %al,0x29(%eax,%eax,1)
    286f:	00 18                	add    %bl,(%eax)
    2871:	00 00                	add    %al,(%eax)
    2873:	00 00                	add    %al,(%eax)
    2875:	00 00                	add    %al,(%eax)
    2877:	00 44 00 2a          	add    %al,0x2a(%eax,%eax,1)
    287b:	00 1e                	add    %bl,(%esi)
    287d:	00 00                	add    %al,(%eax)
    287f:	00 00                	add    %al,(%eax)
    2881:	00 00                	add    %al,(%eax)
    2883:	00 44 00 2e          	add    %al,0x2e(%eax,%eax,1)
    2887:	00 24 00             	add    %ah,(%eax,%eax,1)
    288a:	00 00                	add    %al,(%eax)
    288c:	00 00                	add    %al,(%eax)
    288e:	00 00                	add    %al,(%eax)
    2890:	44                   	inc    %esp
    2891:	00 2a                	add    %ch,(%edx)
    2893:	00 25 00 00 00 00    	add    %ah,0x0
    2899:	00 00                	add    %al,(%eax)
    289b:	00 44 00 2e          	add    %al,0x2e(%eax,%eax,1)
    289f:	00 28                	add    %ch,(%eax)
    28a1:	00 00                	add    %al,(%eax)
    28a3:	00 00                	add    %al,(%eax)
    28a5:	00 00                	add    %al,(%eax)
    28a7:	00 44 00 2f          	add    %al,0x2f(%eax,%eax,1)
    28ab:	00 2b                	add    %ch,(%ebx)
    28ad:	00 00                	add    %al,(%eax)
    28af:	00 00                	add    %al,(%eax)
    28b1:	00 00                	add    %al,(%eax)
    28b3:	00 44 00 27          	add    %al,0x27(%eax,%eax,1)
    28b7:	00 2d 00 00 00 00    	add    %ch,0x0
    28bd:	00 00                	add    %al,(%eax)
    28bf:	00 44 00 30          	add    %al,0x30(%eax,%eax,1)
    28c3:	00 30                	add    %dh,(%eax)
    28c5:	00 00                	add    %al,(%eax)
    28c7:	00 25 0e 00 00 40    	add    %ah,0x4000000e
    28cd:	00 00                	add    %al,(%eax)
    28cf:	00 00                	add    %al,(%eax)
    28d1:	00 00                	add    %al,(%eax)
    28d3:	00 c6                	add    %al,%dh
    28d5:	0d 00 00 40 00       	or     $0x400000,%eax
    28da:	00 00                	add    %al,(%eax)
    28dc:	02 00                	add    (%eax),%al
    28de:	00 00                	add    %al,(%eax)
    28e0:	00 00                	add    %al,(%eax)
    28e2:	00 00                	add    %al,(%eax)
    28e4:	c0 00 00             	rolb   $0x0,(%eax)
	...
    28ef:	00 e0                	add    %ah,%al
    28f1:	00 00                	add    %al,(%eax)
    28f3:	00 35 00 00 00 31    	add    %dh,0x31000000
    28f9:	0e                   	push   %cs
    28fa:	00 00                	add    %al,(%eax)
    28fc:	24 00                	and    $0x0,%al
    28fe:	00 00                	add    %al,(%eax)
    2900:	62 0c 28             	bound  %ecx,(%eax,%ebp,1)
    2903:	00 fb                	add    %bh,%bl
    2905:	0d 00 00 a0 00       	or     $0xa00000,%eax
    290a:	00 00                	add    %al,(%eax)
    290c:	08 00                	or     %al,(%eax)
    290e:	00 00                	add    %al,(%eax)
    2910:	00 00                	add    %al,(%eax)
    2912:	00 00                	add    %al,(%eax)
    2914:	44                   	inc    %esp
    2915:	00 34 00             	add    %dh,(%eax,%eax,1)
	...
    2920:	44                   	inc    %esp
    2921:	00 34 00             	add    %dh,(%eax,%eax,1)
    2924:	03 00                	add    (%eax),%eax
    2926:	00 00                	add    %al,(%eax)
    2928:	00 00                	add    %al,(%eax)
    292a:	00 00                	add    %al,(%eax)
    292c:	44                   	inc    %esp
    292d:	00 36                	add    %dh,(%esi)
    292f:	00 06                	add    %al,(%esi)
    2931:	00 00                	add    %al,(%eax)
    2933:	00 00                	add    %al,(%eax)
    2935:	00 00                	add    %al,(%eax)
    2937:	00 44 00 35          	add    %al,0x35(%eax,%eax,1)
    293b:	00 07                	add    %al,(%edi)
    293d:	00 00                	add    %al,(%eax)
    293f:	00 00                	add    %al,(%eax)
    2941:	00 00                	add    %al,(%eax)
    2943:	00 44 00 36          	add    %al,0x36(%eax,%eax,1)
    2947:	00 0d 00 00 00 c6    	add    %cl,0xc6000000
    294d:	0d 00 00 40 00       	or     $0x400000,%eax
    2952:	00 00                	add    %al,(%eax)
    2954:	02 00                	add    (%eax),%al
    2956:	00 00                	add    %al,(%eax)
    2958:	00 00                	add    %al,(%eax)
    295a:	00 00                	add    %al,(%eax)
    295c:	64 00 00             	add    %al,%fs:(%eax)
    295f:	00 70 0c             	add    %dh,0xc(%eax)
    2962:	28 00                	sub    %al,(%eax)
    2964:	45                   	inc    %ebp
    2965:	0e                   	push   %cs
    2966:	00 00                	add    %al,(%eax)
    2968:	64 00 02             	add    %al,%fs:(%edx)
    296b:	00 70 0c             	add    %dh,0xc(%eax)
    296e:	28 00                	sub    %al,(%eax)
    2970:	08 00                	or     %al,(%eax)
    2972:	00 00                	add    %al,(%eax)
    2974:	3c 00                	cmp    $0x0,%al
    2976:	00 00                	add    %al,(%eax)
    2978:	00 00                	add    %al,(%eax)
    297a:	00 00                	add    %al,(%eax)
    297c:	17                   	pop    %ss
    297d:	00 00                	add    %al,(%eax)
    297f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2985:	00 00                	add    %al,(%eax)
    2987:	00 41 00             	add    %al,0x0(%ecx)
    298a:	00 00                	add    %al,(%eax)
    298c:	80 00 00             	addb   $0x0,(%eax)
    298f:	00 00                	add    %al,(%eax)
    2991:	00 00                	add    %al,(%eax)
    2993:	00 5b 00             	add    %bl,0x0(%ebx)
    2996:	00 00                	add    %al,(%eax)
    2998:	80 00 00             	addb   $0x0,(%eax)
    299b:	00 00                	add    %al,(%eax)
    299d:	00 00                	add    %al,(%eax)
    299f:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
    29a5:	00 00                	add    %al,(%eax)
    29a7:	00 00                	add    %al,(%eax)
    29a9:	00 00                	add    %al,(%eax)
    29ab:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
    29b1:	00 00                	add    %al,(%eax)
    29b3:	00 00                	add    %al,(%eax)
    29b5:	00 00                	add    %al,(%eax)
    29b7:	00 e1                	add    %ah,%cl
    29b9:	00 00                	add    %al,(%eax)
    29bb:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    29c1:	00 00                	add    %al,(%eax)
    29c3:	00 0c 01             	add    %cl,(%ecx,%eax,1)
    29c6:	00 00                	add    %al,(%eax)
    29c8:	80 00 00             	addb   $0x0,(%eax)
    29cb:	00 00                	add    %al,(%eax)
    29cd:	00 00                	add    %al,(%eax)
    29cf:	00 37                	add    %dh,(%edi)
    29d1:	01 00                	add    %eax,(%eax)
    29d3:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    29d9:	00 00                	add    %al,(%eax)
    29db:	00 5d 01             	add    %bl,0x1(%ebp)
    29de:	00 00                	add    %al,(%eax)
    29e0:	80 00 00             	addb   $0x0,(%eax)
    29e3:	00 00                	add    %al,(%eax)
    29e5:	00 00                	add    %al,(%eax)
    29e7:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
    29ed:	00 00                	add    %al,(%eax)
    29ef:	00 00                	add    %al,(%eax)
    29f1:	00 00                	add    %al,(%eax)
    29f3:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
    29f9:	00 00                	add    %al,(%eax)
    29fb:	00 00                	add    %al,(%eax)
    29fd:	00 00                	add    %al,(%eax)
    29ff:	00 d2                	add    %dl,%dl
    2a01:	01 00                	add    %eax,(%eax)
    2a03:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2a09:	00 00                	add    %al,(%eax)
    2a0b:	00 ec                	add    %ch,%ah
    2a0d:	01 00                	add    %eax,(%eax)
    2a0f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2a15:	00 00                	add    %al,(%eax)
    2a17:	00 07                	add    %al,(%edi)
    2a19:	02 00                	add    (%eax),%al
    2a1b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2a21:	00 00                	add    %al,(%eax)
    2a23:	00 28                	add    %ch,(%eax)
    2a25:	02 00                	add    (%eax),%al
    2a27:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2a2d:	00 00                	add    %al,(%eax)
    2a2f:	00 47 02             	add    %al,0x2(%edi)
    2a32:	00 00                	add    %al,(%eax)
    2a34:	80 00 00             	addb   $0x0,(%eax)
    2a37:	00 00                	add    %al,(%eax)
    2a39:	00 00                	add    %al,(%eax)
    2a3b:	00 66 02             	add    %ah,0x2(%esi)
    2a3e:	00 00                	add    %al,(%eax)
    2a40:	80 00 00             	addb   $0x0,(%eax)
    2a43:	00 00                	add    %al,(%eax)
    2a45:	00 00                	add    %al,(%eax)
    2a47:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
    2a4d:	00 00                	add    %al,(%eax)
    2a4f:	00 00                	add    %al,(%eax)
    2a51:	00 00                	add    %al,(%eax)
    2a53:	00 9b 02 00 00 c2    	add    %bl,-0x3dfffffe(%ebx)
    2a59:	00 00                	add    %al,(%eax)
    2a5b:	00 f2                	add    %dh,%dl
    2a5d:	aa                   	stos   %al,%es:(%edi)
    2a5e:	00 00                	add    %al,(%eax)
    2a60:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
    2a61:	02 00                	add    (%eax),%al
    2a63:	00 c2                	add    %al,%dl
    2a65:	00 00                	add    %al,(%eax)
    2a67:	00 00                	add    %al,(%eax)
    2a69:	00 00                	add    %al,(%eax)
    2a6b:	00 ae 02 00 00 c2    	add    %ch,-0x3dfffffe(%esi)
    2a71:	00 00                	add    %al,(%eax)
    2a73:	00 37                	add    %dh,(%edi)
    2a75:	53                   	push   %ebx
    2a76:	00 00                	add    %al,(%eax)
    2a78:	4d                   	dec    %ebp
    2a79:	0e                   	push   %cs
    2a7a:	00 00                	add    %al,(%eax)
    2a7c:	24 00                	and    $0x0,%al
    2a7e:	00 00                	add    %al,(%eax)
    2a80:	70 0c                	jo     2a8e <bootmain-0x27d572>
    2a82:	28 00                	sub    %al,(%eax)
    2a84:	62 0e                	bound  %ecx,(%esi)
    2a86:	00 00                	add    %al,(%eax)
    2a88:	a0 00 00 00 08       	mov    0x8000000,%al
    2a8d:	00 00                	add    %al,(%eax)
    2a8f:	00 00                	add    %al,(%eax)
    2a91:	00 00                	add    %al,(%eax)
    2a93:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
	...
    2a9f:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
    2aa3:	00 07                	add    %al,(%edi)
    2aa5:	00 00                	add    %al,(%eax)
    2aa7:	00 00                	add    %al,(%eax)
    2aa9:	00 00                	add    %al,(%eax)
    2aab:	00 44 00 12          	add    %al,0x12(%eax,%eax,1)
    2aaf:	00 0a                	add    %cl,(%edx)
    2ab1:	00 00                	add    %al,(%eax)
    2ab3:	00 00                	add    %al,(%eax)
    2ab5:	00 00                	add    %al,(%eax)
    2ab7:	00 44 00 13          	add    %al,0x13(%eax,%eax,1)
    2abb:	00 16                	add    %dl,(%esi)
    2abd:	00 00                	add    %al,(%eax)
    2abf:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    2ac5:	00 00                	add    %al,(%eax)
    2ac7:	00 8b 0c 28 00 00    	add    %cl,0x280c(%ebx)
    2acd:	00 00                	add    %al,(%eax)
    2acf:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    2ad3:	00 1b                	add    %bl,(%ebx)
    2ad5:	00 00                	add    %al,(%eax)
    2ad7:	00 45 0e             	add    %al,0xe(%ebp)
    2ada:	00 00                	add    %al,(%eax)
    2adc:	84 00                	test   %al,(%eax)
    2ade:	00 00                	add    %al,(%eax)
    2ae0:	93                   	xchg   %eax,%ebx
    2ae1:	0c 28                	or     $0x28,%al
    2ae3:	00 00                	add    %al,(%eax)
    2ae5:	00 00                	add    %al,(%eax)
    2ae7:	00 44 00 15          	add    %al,0x15(%eax,%eax,1)
    2aeb:	00 23                	add    %ah,(%ebx)
    2aed:	00 00                	add    %al,(%eax)
    2aef:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    2af5:	00 00                	add    %al,(%eax)
    2af7:	00 98 0c 28 00 00    	add    %bl,0x280c(%eax)
    2afd:	00 00                	add    %al,(%eax)
    2aff:	00 44 00 5c          	add    %al,0x5c(%eax,%eax,1)
    2b03:	00 28                	add    %ch,(%eax)
    2b05:	00 00                	add    %al,(%eax)
    2b07:	00 45 0e             	add    %al,0xe(%ebp)
    2b0a:	00 00                	add    %al,(%eax)
    2b0c:	84 00                	test   %al,(%eax)
    2b0e:	00 00                	add    %al,(%eax)
    2b10:	a0 0c 28 00 00       	mov    0x280c,%al
    2b15:	00 00                	add    %al,(%eax)
    2b17:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
    2b1b:	00 30                	add    %dh,(%eax)
    2b1d:	00 00                	add    %al,(%eax)
    2b1f:	00 00                	add    %al,(%eax)
    2b21:	00 00                	add    %al,(%eax)
    2b23:	00 44 00 17          	add    %al,0x17(%eax,%eax,1)
    2b27:	00 43 00             	add    %al,0x0(%ebx)
    2b2a:	00 00                	add    %al,(%eax)
    2b2c:	00 00                	add    %al,(%eax)
    2b2e:	00 00                	add    %al,(%eax)
    2b30:	44                   	inc    %esp
    2b31:	00 18                	add    %bl,(%eax)
    2b33:	00 4a 00             	add    %cl,0x0(%edx)
    2b36:	00 00                	add    %al,(%eax)
    2b38:	00 00                	add    %al,(%eax)
    2b3a:	00 00                	add    %al,(%eax)
    2b3c:	44                   	inc    %esp
    2b3d:	00 1a                	add    %bl,(%edx)
    2b3f:	00 54 00 00          	add    %dl,0x0(%eax,%eax,1)
    2b43:	00 00                	add    %al,(%eax)
    2b45:	00 00                	add    %al,(%eax)
    2b47:	00 44 00 19          	add    %al,0x19(%eax,%eax,1)
    2b4b:	00 58 00             	add    %bl,0x0(%eax)
    2b4e:	00 00                	add    %al,(%eax)
    2b50:	00 00                	add    %al,(%eax)
    2b52:	00 00                	add    %al,(%eax)
    2b54:	44                   	inc    %esp
    2b55:	00 1a                	add    %bl,(%edx)
    2b57:	00 62 00             	add    %ah,0x0(%edx)
    2b5a:	00 00                	add    %al,(%eax)
    2b5c:	00 00                	add    %al,(%eax)
    2b5e:	00 00                	add    %al,(%eax)
    2b60:	44                   	inc    %esp
    2b61:	00 1c 00             	add    %bl,(%eax,%eax,1)
    2b64:	6a 00                	push   $0x0
    2b66:	00 00                	add    %al,(%eax)
    2b68:	77 0e                	ja     2b78 <bootmain-0x27d488>
    2b6a:	00 00                	add    %al,(%eax)
    2b6c:	40                   	inc    %eax
    2b6d:	00 00                	add    %al,(%eax)
    2b6f:	00 03                	add    %al,(%ebx)
    2b71:	00 00                	add    %al,(%eax)
    2b73:	00 85 0e 00 00 24    	add    %al,0x2400000e(%ebp)
    2b79:	00 00                	add    %al,(%eax)
    2b7b:	00 df                	add    %bl,%bh
    2b7d:	0c 28                	or     $0x28,%al
    2b7f:	00 98 0e 00 00 a0    	add    %bl,-0x5ffffff2(%eax)
    2b85:	00 00                	add    %al,(%eax)
    2b87:	00 08                	add    %cl,(%eax)
    2b89:	00 00                	add    %al,(%eax)
    2b8b:	00 00                	add    %al,(%eax)
    2b8d:	00 00                	add    %al,(%eax)
    2b8f:	00 44 00 1e          	add    %al,0x1e(%eax,%eax,1)
	...
    2b9b:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
	...
    2ba7:	00 44 00 1e          	add    %al,0x1e(%eax,%eax,1)
    2bab:	00 06                	add    %al,(%esi)
    2bad:	00 00                	add    %al,(%eax)
    2baf:	00 00                	add    %al,(%eax)
    2bb1:	00 00                	add    %al,(%eax)
    2bb3:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
    2bb7:	00 07                	add    %al,(%edi)
    2bb9:	00 00                	add    %al,(%eax)
    2bbb:	00 00                	add    %al,(%eax)
    2bbd:	00 00                	add    %al,(%eax)
    2bbf:	00 44 00 1e          	add    %al,0x1e(%eax,%eax,1)
    2bc3:	00 0c 00             	add    %cl,(%eax,%eax,1)
    2bc6:	00 00                	add    %al,(%eax)
    2bc8:	00 00                	add    %al,(%eax)
    2bca:	00 00                	add    %al,(%eax)
    2bcc:	44                   	inc    %esp
    2bcd:	00 1e                	add    %bl,(%esi)
    2bcf:	00 10                	add    %dl,(%eax)
    2bd1:	00 00                	add    %al,(%eax)
    2bd3:	00 00                	add    %al,(%eax)
    2bd5:	00 00                	add    %al,(%eax)
    2bd7:	00 44 00 1f          	add    %al,0x1f(%eax,%eax,1)
    2bdb:	00 13                	add    %dl,(%ebx)
    2bdd:	00 00                	add    %al,(%eax)
    2bdf:	00 00                	add    %al,(%eax)
    2be1:	00 00                	add    %al,(%eax)
    2be3:	00 44 00 21          	add    %al,0x21(%eax,%eax,1)
    2be7:	00 34 00             	add    %dh,(%eax,%eax,1)
    2bea:	00 00                	add    %al,(%eax)
    2bec:	00 00                	add    %al,(%eax)
    2bee:	00 00                	add    %al,(%eax)
    2bf0:	44                   	inc    %esp
    2bf1:	00 20                	add    %ah,(%eax)
    2bf3:	00 3c 00             	add    %bh,(%eax,%eax,1)
    2bf6:	00 00                	add    %al,(%eax)
    2bf8:	00 00                	add    %al,(%eax)
    2bfa:	00 00                	add    %al,(%eax)
    2bfc:	44                   	inc    %esp
    2bfd:	00 22                	add    %ah,(%edx)
    2bff:	00 50 00             	add    %dl,0x0(%eax)
    2c02:	00 00                	add    %al,(%eax)
    2c04:	00 00                	add    %al,(%eax)
    2c06:	00 00                	add    %al,(%eax)
    2c08:	44                   	inc    %esp
    2c09:	00 23                	add    %ah,(%ebx)
    2c0b:	00 56 00             	add    %dl,0x0(%esi)
    2c0e:	00 00                	add    %al,(%eax)
    2c10:	00 00                	add    %al,(%eax)
    2c12:	00 00                	add    %al,(%eax)
    2c14:	44                   	inc    %esp
    2c15:	00 25 00 60 00 00    	add    %ah,0x6000
    2c1b:	00 00                	add    %al,(%eax)
    2c1d:	00 00                	add    %al,(%eax)
    2c1f:	00 44 00 23          	add    %al,0x23(%eax,%eax,1)
    2c23:	00 65 00             	add    %ah,0x0(%ebp)
    2c26:	00 00                	add    %al,(%eax)
    2c28:	00 00                	add    %al,(%eax)
    2c2a:	00 00                	add    %al,(%eax)
    2c2c:	44                   	inc    %esp
    2c2d:	00 22                	add    %ah,(%edx)
    2c2f:	00 68 00             	add    %ch,0x0(%eax)
    2c32:	00 00                	add    %al,(%eax)
    2c34:	00 00                	add    %al,(%eax)
    2c36:	00 00                	add    %al,(%eax)
    2c38:	44                   	inc    %esp
    2c39:	00 25 00 6e 00 00    	add    %ah,0x6e00
    2c3f:	00 00                	add    %al,(%eax)
    2c41:	00 00                	add    %al,(%eax)
    2c43:	00 44 00 26          	add    %al,0x26(%eax,%eax,1)
    2c47:	00 70 00             	add    %dh,0x0(%eax)
    2c4a:	00 00                	add    %al,(%eax)
    2c4c:	00 00                	add    %al,(%eax)
    2c4e:	00 00                	add    %al,(%eax)
    2c50:	44                   	inc    %esp
    2c51:	00 25 00 72 00 00    	add    %ah,0x7200
    2c57:	00 00                	add    %al,(%eax)
    2c59:	00 00                	add    %al,(%eax)
    2c5b:	00 44 00 26          	add    %al,0x26(%eax,%eax,1)
    2c5f:	00 77 00             	add    %dh,0x0(%edi)
    2c62:	00 00                	add    %al,(%eax)
    2c64:	00 00                	add    %al,(%eax)
    2c66:	00 00                	add    %al,(%eax)
    2c68:	44                   	inc    %esp
    2c69:	00 26                	add    %ah,(%esi)
    2c6b:	00 79 00             	add    %bh,0x0(%ecx)
    2c6e:	00 00                	add    %al,(%eax)
    2c70:	00 00                	add    %al,(%eax)
    2c72:	00 00                	add    %al,(%eax)
    2c74:	44                   	inc    %esp
    2c75:	00 27                	add    %ah,(%edi)
    2c77:	00 83 00 00 00 00    	add    %al,0x0(%ebx)
    2c7d:	00 00                	add    %al,(%eax)
    2c7f:	00 44 00 27          	add    %al,0x27(%eax,%eax,1)
    2c83:	00 87 00 00 00 00    	add    %al,0x0(%edi)
    2c89:	00 00                	add    %al,(%eax)
    2c8b:	00 44 00 28          	add    %al,0x28(%eax,%eax,1)
    2c8f:	00 91 00 00 00 00    	add    %dl,0x0(%ecx)
    2c95:	00 00                	add    %al,(%eax)
    2c97:	00 44 00 28          	add    %al,0x28(%eax,%eax,1)
    2c9b:	00 a0 00 00 00 00    	add    %ah,0x0(%eax)
    2ca1:	00 00                	add    %al,(%eax)
    2ca3:	00 44 00 29          	add    %al,0x29(%eax,%eax,1)
    2ca7:	00 a9 00 00 00 00    	add    %ch,0x0(%ecx)
    2cad:	00 00                	add    %al,(%eax)
    2caf:	00 44 00 29          	add    %al,0x29(%eax,%eax,1)
    2cb3:	00 b8 00 00 00 00    	add    %bh,0x0(%eax)
    2cb9:	00 00                	add    %al,(%eax)
    2cbb:	00 44 00 2a          	add    %al,0x2a(%eax,%eax,1)
    2cbf:	00 c1                	add    %al,%cl
    2cc1:	00 00                	add    %al,(%eax)
    2cc3:	00 00                	add    %al,(%eax)
    2cc5:	00 00                	add    %al,(%eax)
    2cc7:	00 44 00 2b          	add    %al,0x2b(%eax,%eax,1)
    2ccb:	00 e1                	add    %ah,%cl
    2ccd:	00 00                	add    %al,(%eax)
    2ccf:	00 00                	add    %al,(%eax)
    2cd1:	00 00                	add    %al,(%eax)
    2cd3:	00 44 00 2c          	add    %al,0x2c(%eax,%eax,1)
    2cd7:	00 f9                	add    %bh,%cl
    2cd9:	00 00                	add    %al,(%eax)
    2cdb:	00 77 0e             	add    %dh,0xe(%edi)
    2cde:	00 00                	add    %al,(%eax)
    2ce0:	40                   	inc    %eax
    2ce1:	00 00                	add    %al,(%eax)
    2ce3:	00 03                	add    %al,(%ebx)
    2ce5:	00 00                	add    %al,(%eax)
    2ce7:	00 a6 0e 00 00 20    	add    %ah,0x2000000e(%esi)
    2ced:	00 00                	add    %al,(%eax)
    2cef:	00 00                	add    %al,(%eax)
    2cf1:	00 00                	add    %al,(%eax)
    2cf3:	00 b2 0e 00 00 20    	add    %dh,0x2000000e(%edx)
	...
    2d01:	00 00                	add    %al,(%eax)
    2d03:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
    2d07:	00 df                	add    %bl,%bh
    2d09:	0d 28 00 d8 0e       	or     $0xed80028,%eax
    2d0e:	00 00                	add    %al,(%eax)
    2d10:	64 00 02             	add    %al,%fs:(%edx)
    2d13:	00 e0                	add    %ah,%al
    2d15:	0d 28 00 08 00       	or     $0x80028,%eax
    2d1a:	00 00                	add    %al,(%eax)
    2d1c:	3c 00                	cmp    $0x0,%al
    2d1e:	00 00                	add    %al,(%eax)
    2d20:	00 00                	add    %al,(%eax)
    2d22:	00 00                	add    %al,(%eax)
    2d24:	17                   	pop    %ss
    2d25:	00 00                	add    %al,(%eax)
    2d27:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2d2d:	00 00                	add    %al,(%eax)
    2d2f:	00 41 00             	add    %al,0x0(%ecx)
    2d32:	00 00                	add    %al,(%eax)
    2d34:	80 00 00             	addb   $0x0,(%eax)
    2d37:	00 00                	add    %al,(%eax)
    2d39:	00 00                	add    %al,(%eax)
    2d3b:	00 5b 00             	add    %bl,0x0(%ebx)
    2d3e:	00 00                	add    %al,(%eax)
    2d40:	80 00 00             	addb   $0x0,(%eax)
    2d43:	00 00                	add    %al,(%eax)
    2d45:	00 00                	add    %al,(%eax)
    2d47:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
    2d4d:	00 00                	add    %al,(%eax)
    2d4f:	00 00                	add    %al,(%eax)
    2d51:	00 00                	add    %al,(%eax)
    2d53:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
    2d59:	00 00                	add    %al,(%eax)
    2d5b:	00 00                	add    %al,(%eax)
    2d5d:	00 00                	add    %al,(%eax)
    2d5f:	00 e1                	add    %ah,%cl
    2d61:	00 00                	add    %al,(%eax)
    2d63:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2d69:	00 00                	add    %al,(%eax)
    2d6b:	00 0c 01             	add    %cl,(%ecx,%eax,1)
    2d6e:	00 00                	add    %al,(%eax)
    2d70:	80 00 00             	addb   $0x0,(%eax)
    2d73:	00 00                	add    %al,(%eax)
    2d75:	00 00                	add    %al,(%eax)
    2d77:	00 37                	add    %dh,(%edi)
    2d79:	01 00                	add    %eax,(%eax)
    2d7b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2d81:	00 00                	add    %al,(%eax)
    2d83:	00 5d 01             	add    %bl,0x1(%ebp)
    2d86:	00 00                	add    %al,(%eax)
    2d88:	80 00 00             	addb   $0x0,(%eax)
    2d8b:	00 00                	add    %al,(%eax)
    2d8d:	00 00                	add    %al,(%eax)
    2d8f:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
    2d95:	00 00                	add    %al,(%eax)
    2d97:	00 00                	add    %al,(%eax)
    2d99:	00 00                	add    %al,(%eax)
    2d9b:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
    2da1:	00 00                	add    %al,(%eax)
    2da3:	00 00                	add    %al,(%eax)
    2da5:	00 00                	add    %al,(%eax)
    2da7:	00 d2                	add    %dl,%dl
    2da9:	01 00                	add    %eax,(%eax)
    2dab:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2db1:	00 00                	add    %al,(%eax)
    2db3:	00 ec                	add    %ch,%ah
    2db5:	01 00                	add    %eax,(%eax)
    2db7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2dbd:	00 00                	add    %al,(%eax)
    2dbf:	00 07                	add    %al,(%edi)
    2dc1:	02 00                	add    (%eax),%al
    2dc3:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2dc9:	00 00                	add    %al,(%eax)
    2dcb:	00 28                	add    %ch,(%eax)
    2dcd:	02 00                	add    (%eax),%al
    2dcf:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2dd5:	00 00                	add    %al,(%eax)
    2dd7:	00 47 02             	add    %al,0x2(%edi)
    2dda:	00 00                	add    %al,(%eax)
    2ddc:	80 00 00             	addb   $0x0,(%eax)
    2ddf:	00 00                	add    %al,(%eax)
    2de1:	00 00                	add    %al,(%eax)
    2de3:	00 66 02             	add    %ah,0x2(%esi)
    2de6:	00 00                	add    %al,(%eax)
    2de8:	80 00 00             	addb   $0x0,(%eax)
    2deb:	00 00                	add    %al,(%eax)
    2ded:	00 00                	add    %al,(%eax)
    2def:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
    2df5:	00 00                	add    %al,(%eax)
    2df7:	00 00                	add    %al,(%eax)
    2df9:	00 00                	add    %al,(%eax)
    2dfb:	00 9b 02 00 00 c2    	add    %bl,-0x3dfffffe(%ebx)
    2e01:	00 00                	add    %al,(%eax)
    2e03:	00 f2                	add    %dh,%dl
    2e05:	aa                   	stos   %al,%es:(%edi)
    2e06:	00 00                	add    %al,(%eax)
    2e08:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
    2e09:	02 00                	add    (%eax),%al
    2e0b:	00 c2                	add    %al,%dl
    2e0d:	00 00                	add    %al,(%eax)
    2e0f:	00 00                	add    %al,(%eax)
    2e11:	00 00                	add    %al,(%eax)
    2e13:	00 ae 02 00 00 c2    	add    %ch,-0x3dfffffe(%esi)
    2e19:	00 00                	add    %al,(%eax)
    2e1b:	00 37                	add    %dh,(%edi)
    2e1d:	53                   	push   %ebx
    2e1e:	00 00                	add    %al,(%eax)
    2e20:	e3 0e                	jecxz  2e30 <bootmain-0x27d1d0>
    2e22:	00 00                	add    %al,(%eax)
    2e24:	24 00                	and    $0x0,%al
    2e26:	00 00                	add    %al,(%eax)
    2e28:	e0 0d                	loopne 2e37 <bootmain-0x27d1c9>
    2e2a:	28 00                	sub    %al,(%eax)
    2e2c:	00 00                	add    %al,(%eax)
    2e2e:	00 00                	add    %al,(%eax)
    2e30:	44                   	inc    %esp
    2e31:	00 0b                	add    %cl,(%ebx)
    2e33:	00 00                	add    %al,(%eax)
    2e35:	00 00                	add    %al,(%eax)
    2e37:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    2e3d:	00 00                	add    %al,(%eax)
    2e3f:	00 e1                	add    %ah,%cl
    2e41:	0d 28 00 00 00       	or     $0x28,%eax
    2e46:	00 00                	add    %al,(%eax)
    2e48:	44                   	inc    %esp
    2e49:	00 42 00             	add    %al,0x0(%edx)
    2e4c:	01 00                	add    %eax,(%eax)
    2e4e:	00 00                	add    %al,(%eax)
    2e50:	d8 0e                	fmuls  (%esi)
    2e52:	00 00                	add    %al,(%eax)
    2e54:	84 00                	test   %al,(%eax)
    2e56:	00 00                	add    %al,(%eax)
    2e58:	e6 0d                	out    %al,$0xd
    2e5a:	28 00                	sub    %al,(%eax)
    2e5c:	00 00                	add    %al,(%eax)
    2e5e:	00 00                	add    %al,(%eax)
    2e60:	44                   	inc    %esp
    2e61:	00 0b                	add    %cl,(%ebx)
    2e63:	00 06                	add    %al,(%esi)
    2e65:	00 00                	add    %al,(%eax)
    2e67:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    2e6d:	00 00                	add    %al,(%eax)
    2e6f:	00 e8                	add    %ch,%al
    2e71:	0d 28 00 00 00       	or     $0x28,%eax
    2e76:	00 00                	add    %al,(%eax)
    2e78:	44                   	inc    %esp
    2e79:	00 42 00             	add    %al,0x0(%edx)
    2e7c:	08 00                	or     %al,(%eax)
    2e7e:	00 00                	add    %al,(%eax)
    2e80:	d8 0e                	fmuls  (%esi)
    2e82:	00 00                	add    %al,(%eax)
    2e84:	84 00                	test   %al,(%eax)
    2e86:	00 00                	add    %al,(%eax)
    2e88:	e9 0d 28 00 00       	jmp    569a <bootmain-0x27a966>
    2e8d:	00 00                	add    %al,(%eax)
    2e8f:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
    2e93:	00 09                	add    %cl,(%ecx)
    2e95:	00 00                	add    %al,(%eax)
    2e97:	00 00                	add    %al,(%eax)
    2e99:	00 00                	add    %al,(%eax)
    2e9b:	00 44 00 13          	add    %al,0x13(%eax,%eax,1)
    2e9f:	00 0d 00 00 00 fe    	add    %cl,0xfe000000
    2ea5:	0e                   	push   %cs
    2ea6:	00 00                	add    %al,(%eax)
    2ea8:	24 00                	and    $0x0,%al
    2eaa:	00 00                	add    %al,(%eax)
    2eac:	ef                   	out    %eax,(%dx)
    2ead:	0d 28 00 00 00       	or     $0x28,%eax
    2eb2:	00 00                	add    %al,(%eax)
    2eb4:	44                   	inc    %esp
    2eb5:	00 16                	add    %dl,(%esi)
	...
    2ebf:	00 44 00 18          	add    %al,0x18(%eax,%eax,1)
    2ec3:	00 03                	add    %al,(%ebx)
    2ec5:	00 00                	add    %al,(%eax)
    2ec7:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    2ecd:	00 00                	add    %al,(%eax)
    2ecf:	00 f7                	add    %dh,%bh
    2ed1:	0d 28 00 00 00       	or     $0x28,%eax
    2ed6:	00 00                	add    %al,(%eax)
    2ed8:	44                   	inc    %esp
    2ed9:	00 5c 00 08          	add    %bl,0x8(%eax,%eax,1)
    2edd:	00 00                	add    %al,(%eax)
    2edf:	00 d8                	add    %bl,%al
    2ee1:	0e                   	push   %cs
    2ee2:	00 00                	add    %al,(%eax)
    2ee4:	84 00                	test   %al,(%eax)
    2ee6:	00 00                	add    %al,(%eax)
    2ee8:	ff 0d 28 00 00 00    	decl   0x28
    2eee:	00 00                	add    %al,(%eax)
    2ef0:	44                   	inc    %esp
    2ef1:	00 1a                	add    %bl,(%edx)
    2ef3:	00 10                	add    %dl,(%eax)
    2ef5:	00 00                	add    %al,(%eax)
    2ef7:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    2efd:	00 00                	add    %al,(%eax)
    2eff:	00 04 0e             	add    %al,(%esi,%ecx,1)
    2f02:	28 00                	sub    %al,(%eax)
    2f04:	00 00                	add    %al,(%eax)
    2f06:	00 00                	add    %al,(%eax)
    2f08:	44                   	inc    %esp
    2f09:	00 5c 00 15          	add    %bl,0x15(%eax,%eax,1)
    2f0d:	00 00                	add    %al,(%eax)
    2f0f:	00 d8                	add    %bl,%al
    2f11:	0e                   	push   %cs
    2f12:	00 00                	add    %al,(%eax)
    2f14:	84 00                	test   %al,(%eax)
    2f16:	00 00                	add    %al,(%eax)
    2f18:	0c 0e                	or     $0xe,%al
    2f1a:	28 00                	sub    %al,(%eax)
    2f1c:	00 00                	add    %al,(%eax)
    2f1e:	00 00                	add    %al,(%eax)
    2f20:	44                   	inc    %esp
    2f21:	00 1d 00 1d 00 00    	add    %bl,0x1d00
    2f27:	00 00                	add    %al,(%eax)
    2f29:	00 00                	add    %al,(%eax)
    2f2b:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
    2f2f:	00 0e                	add    %cl,(%esi)
    2f31:	0e                   	push   %cs
    2f32:	28 00                	sub    %al,(%eax)
    2f34:	14 0f                	adc    $0xf,%al
    2f36:	00 00                	add    %al,(%eax)
    2f38:	64 00 02             	add    %al,%fs:(%edx)
    2f3b:	00 10                	add    %dl,(%eax)
    2f3d:	0e                   	push   %cs
    2f3e:	28 00                	sub    %al,(%eax)
    2f40:	08 00                	or     %al,(%eax)
    2f42:	00 00                	add    %al,(%eax)
    2f44:	3c 00                	cmp    $0x0,%al
    2f46:	00 00                	add    %al,(%eax)
    2f48:	00 00                	add    %al,(%eax)
    2f4a:	00 00                	add    %al,(%eax)
    2f4c:	17                   	pop    %ss
    2f4d:	00 00                	add    %al,(%eax)
    2f4f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2f55:	00 00                	add    %al,(%eax)
    2f57:	00 41 00             	add    %al,0x0(%ecx)
    2f5a:	00 00                	add    %al,(%eax)
    2f5c:	80 00 00             	addb   $0x0,(%eax)
    2f5f:	00 00                	add    %al,(%eax)
    2f61:	00 00                	add    %al,(%eax)
    2f63:	00 5b 00             	add    %bl,0x0(%ebx)
    2f66:	00 00                	add    %al,(%eax)
    2f68:	80 00 00             	addb   $0x0,(%eax)
    2f6b:	00 00                	add    %al,(%eax)
    2f6d:	00 00                	add    %al,(%eax)
    2f6f:	00 8a 00 00 00 80    	add    %cl,-0x80000000(%edx)
    2f75:	00 00                	add    %al,(%eax)
    2f77:	00 00                	add    %al,(%eax)
    2f79:	00 00                	add    %al,(%eax)
    2f7b:	00 b3 00 00 00 80    	add    %dh,-0x80000000(%ebx)
    2f81:	00 00                	add    %al,(%eax)
    2f83:	00 00                	add    %al,(%eax)
    2f85:	00 00                	add    %al,(%eax)
    2f87:	00 e1                	add    %ah,%cl
    2f89:	00 00                	add    %al,(%eax)
    2f8b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2f91:	00 00                	add    %al,(%eax)
    2f93:	00 0c 01             	add    %cl,(%ecx,%eax,1)
    2f96:	00 00                	add    %al,(%eax)
    2f98:	80 00 00             	addb   $0x0,(%eax)
    2f9b:	00 00                	add    %al,(%eax)
    2f9d:	00 00                	add    %al,(%eax)
    2f9f:	00 37                	add    %dh,(%edi)
    2fa1:	01 00                	add    %eax,(%eax)
    2fa3:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2fa9:	00 00                	add    %al,(%eax)
    2fab:	00 5d 01             	add    %bl,0x1(%ebp)
    2fae:	00 00                	add    %al,(%eax)
    2fb0:	80 00 00             	addb   $0x0,(%eax)
    2fb3:	00 00                	add    %al,(%eax)
    2fb5:	00 00                	add    %al,(%eax)
    2fb7:	00 87 01 00 00 80    	add    %al,-0x7fffffff(%edi)
    2fbd:	00 00                	add    %al,(%eax)
    2fbf:	00 00                	add    %al,(%eax)
    2fc1:	00 00                	add    %al,(%eax)
    2fc3:	00 ad 01 00 00 80    	add    %ch,-0x7fffffff(%ebp)
    2fc9:	00 00                	add    %al,(%eax)
    2fcb:	00 00                	add    %al,(%eax)
    2fcd:	00 00                	add    %al,(%eax)
    2fcf:	00 d2                	add    %dl,%dl
    2fd1:	01 00                	add    %eax,(%eax)
    2fd3:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2fd9:	00 00                	add    %al,(%eax)
    2fdb:	00 ec                	add    %ch,%ah
    2fdd:	01 00                	add    %eax,(%eax)
    2fdf:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2fe5:	00 00                	add    %al,(%eax)
    2fe7:	00 07                	add    %al,(%edi)
    2fe9:	02 00                	add    (%eax),%al
    2feb:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2ff1:	00 00                	add    %al,(%eax)
    2ff3:	00 28                	add    %ch,(%eax)
    2ff5:	02 00                	add    (%eax),%al
    2ff7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
    2ffd:	00 00                	add    %al,(%eax)
    2fff:	00 47 02             	add    %al,0x2(%edi)
    3002:	00 00                	add    %al,(%eax)
    3004:	80 00 00             	addb   $0x0,(%eax)
    3007:	00 00                	add    %al,(%eax)
    3009:	00 00                	add    %al,(%eax)
    300b:	00 66 02             	add    %ah,0x2(%esi)
    300e:	00 00                	add    %al,(%eax)
    3010:	80 00 00             	addb   $0x0,(%eax)
    3013:	00 00                	add    %al,(%eax)
    3015:	00 00                	add    %al,(%eax)
    3017:	00 87 02 00 00 80    	add    %al,-0x7ffffffe(%edi)
    301d:	00 00                	add    %al,(%eax)
    301f:	00 00                	add    %al,(%eax)
    3021:	00 00                	add    %al,(%eax)
    3023:	00 9b 02 00 00 c2    	add    %bl,-0x3dfffffe(%ebx)
    3029:	00 00                	add    %al,(%eax)
    302b:	00 f2                	add    %dh,%dl
    302d:	aa                   	stos   %al,%es:(%edi)
    302e:	00 00                	add    %al,(%eax)
    3030:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
    3031:	02 00                	add    (%eax),%al
    3033:	00 c2                	add    %al,%dl
    3035:	00 00                	add    %al,(%eax)
    3037:	00 00                	add    %al,(%eax)
    3039:	00 00                	add    %al,(%eax)
    303b:	00 ae 02 00 00 c2    	add    %ch,-0x3dfffffe(%esi)
    3041:	00 00                	add    %al,(%eax)
    3043:	00 37                	add    %dh,(%edi)
    3045:	53                   	push   %ebx
    3046:	00 00                	add    %al,(%eax)
    3048:	1a 0f                	sbb    (%edi),%cl
    304a:	00 00                	add    %al,(%eax)
    304c:	24 00                	and    $0x0,%al
    304e:	00 00                	add    %al,(%eax)
    3050:	10 0e                	adc    %cl,(%esi)
    3052:	28 00                	sub    %al,(%eax)
    3054:	2d 0f 00 00 a0       	sub    $0xa000000f,%eax
    3059:	00 00                	add    %al,(%eax)
    305b:	00 08                	add    %cl,(%eax)
    305d:	00 00                	add    %al,(%eax)
    305f:	00 3a                	add    %bh,(%edx)
    3061:	0f 00 00             	sldt   (%eax)
    3064:	a0 00 00 00 0c       	mov    0xc000000,%al
    3069:	00 00                	add    %al,(%eax)
    306b:	00 00                	add    %al,(%eax)
    306d:	00 00                	add    %al,(%eax)
    306f:	00 44 00 06          	add    %al,0x6(%eax,%eax,1)
	...
    307b:	00 44 00 08          	add    %al,0x8(%eax,%eax,1)
    307f:	00 06                	add    %al,(%esi)
    3081:	00 00                	add    %al,(%eax)
    3083:	00 00                	add    %al,(%eax)
    3085:	00 00                	add    %al,(%eax)
    3087:	00 44 00 0a          	add    %al,0xa(%eax,%eax,1)
    308b:	00 0b                	add    %cl,(%ebx)
    308d:	00 00                	add    %al,(%eax)
    308f:	00 00                	add    %al,(%eax)
    3091:	00 00                	add    %al,(%eax)
    3093:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
    3097:	00 0d 00 00 00 00    	add    %cl,0x0
    309d:	00 00                	add    %al,(%eax)
    309f:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
    30a3:	00 13                	add    %dl,(%ebx)
    30a5:	00 00                	add    %al,(%eax)
    30a7:	00 00                	add    %al,(%eax)
    30a9:	00 00                	add    %al,(%eax)
    30ab:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
    30af:	00 1d 00 00 00 00    	add    %bl,0x0
    30b5:	00 00                	add    %al,(%eax)
    30b7:	00 44 00 0f          	add    %al,0xf(%eax,%eax,1)
    30bb:	00 23                	add    %ah,(%ebx)
    30bd:	00 00                	add    %al,(%eax)
    30bf:	00 00                	add    %al,(%eax)
    30c1:	00 00                	add    %al,(%eax)
    30c3:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
    30c7:	00 25 00 00 00 00    	add    %ah,0x0
    30cd:	00 00                	add    %al,(%eax)
    30cf:	00 44 00 08          	add    %al,0x8(%eax,%eax,1)
    30d3:	00 27                	add    %ah,(%edi)
    30d5:	00 00                	add    %al,(%eax)
    30d7:	00 00                	add    %al,(%eax)
    30d9:	00 00                	add    %al,(%eax)
    30db:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
    30df:	00 2c 00             	add    %ch,(%eax,%eax,1)
    30e2:	00 00                	add    %al,(%eax)
    30e4:	00 00                	add    %al,(%eax)
    30e6:	00 00                	add    %al,(%eax)
    30e8:	44                   	inc    %esp
    30e9:	00 1b                	add    %bl,(%ebx)
    30eb:	00 2e                	add    %ch,(%esi)
    30ed:	00 00                	add    %al,(%eax)
    30ef:	00 45 0f             	add    %al,0xf(%ebp)
    30f2:	00 00                	add    %al,(%eax)
    30f4:	40                   	inc    %eax
    30f5:	00 00                	add    %al,(%eax)
    30f7:	00 02                	add    %al,(%edx)
    30f9:	00 00                	add    %al,(%eax)
    30fb:	00 50 0f             	add    %dl,0xf(%eax)
    30fe:	00 00                	add    %al,(%eax)
    3100:	40                   	inc    %eax
	...
    3109:	00 00                	add    %al,(%eax)
    310b:	00 c0                	add    %al,%al
	...
    3115:	00 00                	add    %al,(%eax)
    3117:	00 e0                	add    %ah,%al
    3119:	00 00                	add    %al,(%eax)
    311b:	00 30                	add    %dh,(%eax)
    311d:	00 00                	add    %al,(%eax)
    311f:	00 5d 0f             	add    %bl,0xf(%ebp)
    3122:	00 00                	add    %al,(%eax)
    3124:	24 00                	and    $0x0,%al
    3126:	00 00                	add    %al,(%eax)
    3128:	40                   	inc    %eax
    3129:	0e                   	push   %cs
    312a:	28 00                	sub    %al,(%eax)
    312c:	2d 0f 00 00 a0       	sub    $0xa000000f,%eax
    3131:	00 00                	add    %al,(%eax)
    3133:	00 08                	add    %cl,(%eax)
    3135:	00 00                	add    %al,(%eax)
    3137:	00 3a                	add    %bh,(%edx)
    3139:	0f 00 00             	sldt   (%eax)
    313c:	a0 00 00 00 0c       	mov    0xc000000,%al
    3141:	00 00                	add    %al,(%eax)
    3143:	00 00                	add    %al,(%eax)
    3145:	00 00                	add    %al,(%eax)
    3147:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
    314b:	00 00                	add    %al,(%eax)
    314d:	00 00                	add    %al,(%eax)
    314f:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    3155:	00 00                	add    %al,(%eax)
    3157:	00 48 0e             	add    %cl,0xe(%eax)
    315a:	28 00                	sub    %al,(%eax)
    315c:	00 00                	add    %al,(%eax)
    315e:	00 00                	add    %al,(%eax)
    3160:	44                   	inc    %esp
    3161:	00 2c 01             	add    %ch,(%ecx,%eax,1)
    3164:	08 00                	or     %al,(%eax)
    3166:	00 00                	add    %al,(%eax)
    3168:	14 0f                	adc    $0xf,%al
    316a:	00 00                	add    %al,(%eax)
    316c:	84 00                	test   %al,(%eax)
    316e:	00 00                	add    %al,(%eax)
    3170:	4a                   	dec    %edx
    3171:	0e                   	push   %cs
    3172:	28 00                	sub    %al,(%eax)
    3174:	00 00                	add    %al,(%eax)
    3176:	00 00                	add    %al,(%eax)
    3178:	44                   	inc    %esp
    3179:	00 21                	add    %ah,(%ecx)
    317b:	00 0a                	add    %cl,(%edx)
    317d:	00 00                	add    %al,(%eax)
    317f:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    3185:	00 00                	add    %al,(%eax)
    3187:	00 4f 0e             	add    %cl,0xe(%edi)
    318a:	28 00                	sub    %al,(%eax)
    318c:	00 00                	add    %al,(%eax)
    318e:	00 00                	add    %al,(%eax)
    3190:	44                   	inc    %esp
    3191:	00 33                	add    %dh,(%ebx)
    3193:	01 0f                	add    %ecx,(%edi)
    3195:	00 00                	add    %al,(%eax)
    3197:	00 00                	add    %al,(%eax)
    3199:	00 00                	add    %al,(%eax)
    319b:	00 44 00 2c          	add    %al,0x2c(%eax,%eax,1)
    319f:	01 11                	add    %edx,(%ecx)
    31a1:	00 00                	add    %al,(%eax)
    31a3:	00 14 0f             	add    %dl,(%edi,%ecx,1)
    31a6:	00 00                	add    %al,(%eax)
    31a8:	84 00                	test   %al,(%eax)
    31aa:	00 00                	add    %al,(%eax)
    31ac:	53                   	push   %ebx
    31ad:	0e                   	push   %cs
    31ae:	28 00                	sub    %al,(%eax)
    31b0:	00 00                	add    %al,(%eax)
    31b2:	00 00                	add    %al,(%eax)
    31b4:	44                   	inc    %esp
    31b5:	00 24 00             	add    %ah,(%eax,%eax,1)
    31b8:	13 00                	adc    (%eax),%eax
    31ba:	00 00                	add    %al,(%eax)
    31bc:	00 00                	add    %al,(%eax)
    31be:	00 00                	add    %al,(%eax)
    31c0:	44                   	inc    %esp
    31c1:	00 27                	add    %ah,(%edi)
    31c3:	00 15 00 00 00 00    	add    %dl,0x0
    31c9:	00 00                	add    %al,(%eax)
    31cb:	00 44 00 24          	add    %al,0x24(%eax,%eax,1)
    31cf:	00 1a                	add    %bl,(%edx)
    31d1:	00 00                	add    %al,(%eax)
    31d3:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    31d9:	00 00                	add    %al,(%eax)
    31db:	00 62 0e             	add    %ah,0xe(%edx)
    31de:	28 00                	sub    %al,(%eax)
    31e0:	00 00                	add    %al,(%eax)
    31e2:	00 00                	add    %al,(%eax)
    31e4:	44                   	inc    %esp
    31e5:	00 33                	add    %dh,(%ebx)
    31e7:	01 22                	add    %esp,(%edx)
    31e9:	00 00                	add    %al,(%eax)
    31eb:	00 14 0f             	add    %dl,(%edi,%ecx,1)
    31ee:	00 00                	add    %al,(%eax)
    31f0:	84 00                	test   %al,(%eax)
    31f2:	00 00                	add    %al,(%eax)
    31f4:	64                   	fs
    31f5:	0e                   	push   %cs
    31f6:	28 00                	sub    %al,(%eax)
    31f8:	00 00                	add    %al,(%eax)
    31fa:	00 00                	add    %al,(%eax)
    31fc:	44                   	inc    %esp
    31fd:	00 29                	add    %ch,(%ecx)
    31ff:	00 24 00             	add    %ah,(%eax,%eax,1)
    3202:	00 00                	add    %al,(%eax)
    3204:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
    3205:	02 00                	add    (%eax),%al
    3207:	00 84 00 00 00 68 0e 	add    %al,0xe680000(%eax,%eax,1)
    320e:	28 00                	sub    %al,(%eax)
    3210:	00 00                	add    %al,(%eax)
    3212:	00 00                	add    %al,(%eax)
    3214:	44                   	inc    %esp
    3215:	00 cc                	add    %cl,%ah
    3217:	00 28                	add    %ch,(%eax)
    3219:	00 00                	add    %al,(%eax)
    321b:	00 14 0f             	add    %dl,(%edi,%ecx,1)
    321e:	00 00                	add    %al,(%eax)
    3220:	84 00                	test   %al,(%eax)
    3222:	00 00                	add    %al,(%eax)
    3224:	6b 0e 28             	imul   $0x28,(%esi),%ecx
    3227:	00 00                	add    %al,(%eax)
    3229:	00 00                	add    %al,(%eax)
    322b:	00 44 00 2b          	add    %al,0x2b(%eax,%eax,1)
    322f:	00 2b                	add    %ch,(%ebx)
    3231:	00 00                	add    %al,(%eax)
    3233:	00 a6 02 00 00 84    	add    %ah,-0x7bfffffe(%esi)
    3239:	00 00                	add    %al,(%eax)
    323b:	00 71 0e             	add    %dh,0xe(%ecx)
    323e:	28 00                	sub    %al,(%eax)
    3240:	00 00                	add    %al,(%eax)
    3242:	00 00                	add    %al,(%eax)
    3244:	44                   	inc    %esp
    3245:	00 c5                	add    %al,%ch
    3247:	00 31                	add    %dh,(%ecx)
    3249:	00 00                	add    %al,(%eax)
    324b:	00 14 0f             	add    %dl,(%edi,%ecx,1)
    324e:	00 00                	add    %al,(%eax)
    3250:	84 00                	test   %al,(%eax)
    3252:	00 00                	add    %al,(%eax)
    3254:	74 0e                	je     3264 <bootmain-0x27cd9c>
    3256:	28 00                	sub    %al,(%eax)
    3258:	00 00                	add    %al,(%eax)
    325a:	00 00                	add    %al,(%eax)
    325c:	44                   	inc    %esp
    325d:	00 2f                	add    %ch,(%edi)
    325f:	00 34 00             	add    %dh,(%eax,%eax,1)
    3262:	00 00                	add    %al,(%eax)
    3264:	00 00                	add    %al,(%eax)
    3266:	00 00                	add    %al,(%eax)
    3268:	44                   	inc    %esp
    3269:	00 31                	add    %dh,(%ecx)
    326b:	00 3d 00 00 00 a6    	add    %bh,0xa6000000
    3271:	02 00                	add    (%eax),%al
    3273:	00 84 00 00 00 83 0e 	add    %al,0xe830000(%eax,%eax,1)
    327a:	28 00                	sub    %al,(%eax)
    327c:	00 00                	add    %al,(%eax)
    327e:	00 00                	add    %al,(%eax)
    3280:	44                   	inc    %esp
    3281:	00 cc                	add    %cl,%ah
    3283:	00 43 00             	add    %al,0x0(%ebx)
    3286:	00 00                	add    %al,(%eax)
    3288:	14 0f                	adc    $0xf,%al
    328a:	00 00                	add    %al,(%eax)
    328c:	84 00                	test   %al,(%eax)
    328e:	00 00                	add    %al,(%eax)
    3290:	86 0e                	xchg   %cl,(%esi)
    3292:	28 00                	sub    %al,(%eax)
    3294:	00 00                	add    %al,(%eax)
    3296:	00 00                	add    %al,(%eax)
    3298:	44                   	inc    %esp
    3299:	00 33                	add    %dh,(%ebx)
    329b:	00 46 00             	add    %al,0x0(%esi)
    329e:	00 00                	add    %al,(%eax)
    32a0:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
    32a1:	02 00                	add    (%eax),%al
    32a3:	00 84 00 00 00 8c 0e 	add    %al,0xe8c0000(%eax,%eax,1)
    32aa:	28 00                	sub    %al,(%eax)
    32ac:	00 00                	add    %al,(%eax)
    32ae:	00 00                	add    %al,(%eax)
    32b0:	44                   	inc    %esp
    32b1:	00 c5                	add    %al,%ch
    32b3:	00 4c 00 00          	add    %cl,0x0(%eax,%eax,1)
    32b7:	00 14 0f             	add    %dl,(%edi,%ecx,1)
    32ba:	00 00                	add    %al,(%eax)
    32bc:	84 00                	test   %al,(%eax)
    32be:	00 00                	add    %al,(%eax)
    32c0:	8f                   	(bad)  
    32c1:	0e                   	push   %cs
    32c2:	28 00                	sub    %al,(%eax)
    32c4:	00 00                	add    %al,(%eax)
    32c6:	00 00                	add    %al,(%eax)
    32c8:	44                   	inc    %esp
    32c9:	00 37                	add    %dh,(%edi)
    32cb:	00 4f 00             	add    %cl,0x0(%edi)
    32ce:	00 00                	add    %al,(%eax)
    32d0:	00 00                	add    %al,(%eax)
    32d2:	00 00                	add    %al,(%eax)
    32d4:	44                   	inc    %esp
    32d5:	00 38                	add    %bh,(%eax)
    32d7:	00 59 00             	add    %bl,0x0(%ecx)
    32da:	00 00                	add    %al,(%eax)
    32dc:	6c                   	insb   (%dx),%es:(%edi)
    32dd:	0f 00 00             	sldt   (%eax)
    32e0:	40                   	inc    %eax
    32e1:	00 00                	add    %al,(%eax)
    32e3:	00 00                	add    %al,(%eax)
    32e5:	00 00                	add    %al,(%eax)
    32e7:	00 77 0f             	add    %dh,0xf(%edi)
    32ea:	00 00                	add    %al,(%eax)
    32ec:	40                   	inc    %eax
    32ed:	00 00                	add    %al,(%eax)
    32ef:	00 06                	add    %al,(%esi)
    32f1:	00 00                	add    %al,(%eax)
    32f3:	00 00                	add    %al,(%eax)
    32f5:	00 00                	add    %al,(%eax)
    32f7:	00 c0                	add    %al,%al
	...
    3301:	00 00                	add    %al,(%eax)
    3303:	00 e0                	add    %ah,%al
    3305:	00 00                	add    %al,(%eax)
    3307:	00 60 00             	add    %ah,0x0(%eax)
    330a:	00 00                	add    %al,(%eax)
    330c:	82                   	(bad)  
    330d:	0f 00 00             	sldt   (%eax)
    3310:	20 00                	and    %al,(%eax)
    3312:	00 00                	add    %al,(%eax)
    3314:	00 00                	add    %al,(%eax)
    3316:	00 00                	add    %al,(%eax)
    3318:	8e 0f                	mov    (%edi),%cs
    331a:	00 00                	add    %al,(%eax)
    331c:	20 00                	and    %al,(%eax)
	...
    3326:	00 00                	add    %al,(%eax)
    3328:	64 00 00             	add    %al,%fs:(%eax)
    332b:	00                   	.byte 0x0
    332c:	a0                   	.byte 0xa0
    332d:	0e                   	push   %cs
    332e:	28 00                	sub    %al,(%eax)

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
  21:	74 20                	je     43 <bootmain-0x27ffbd>
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
  10:	70 69                	jo     7b <bootmain-0x27ff85>
  12:	6c                   	insb   (%dx),%es:(%edi)
  13:	65 64 2e 00 69 6e    	gs fs add %ch,%cs:%fs:%gs:0x6e(%ecx)
  19:	74 3a                	je     55 <bootmain-0x27ffab>
  1b:	74 28                	je     45 <bootmain-0x27ffbb>
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
  44:	72 3a                	jb     80 <bootmain-0x27ff80>
  46:	74 28                	je     70 <bootmain-0x27ff90>
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
  62:	74 3a                	je     9e <bootmain-0x27ff62>
  64:	74 28                	je     8e <bootmain-0x27ff72>
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
  8a:	75 6e                	jne    fa <bootmain-0x27ff06>
  8c:	73 69                	jae    f7 <bootmain-0x27ff09>
  8e:	67 6e                	outsb  %ds:(%si),(%dx)
  90:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
  95:	74 3a                	je     d1 <bootmain-0x27ff2f>
  97:	74 28                	je     c1 <bootmain-0x27ff3f>
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
  ba:	73 69                	jae    125 <bootmain-0x27fedb>
  bc:	67 6e                	outsb  %ds:(%si),(%dx)
  be:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
  c3:	74 3a                	je     ff <bootmain-0x27ff01>
  c5:	74 28                	je     ef <bootmain-0x27ff11>
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
  ed:	74 3a                	je     129 <bootmain-0x27fed7>
  ef:	74 28                	je     119 <bootmain-0x27fee7>
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
 118:	73 69                	jae    183 <bootmain-0x27fe7d>
 11a:	67 6e                	outsb  %ds:(%si),(%dx)
 11c:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
 121:	74 3a                	je     15d <bootmain-0x27fea3>
 123:	74 28                	je     14d <bootmain-0x27feb3>
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
 15d:	73 68                	jae    1c7 <bootmain-0x27fe39>
 15f:	6f                   	outsl  %ds:(%esi),(%dx)
 160:	72 74                	jb     1d6 <bootmain-0x27fe2a>
 162:	20 75 6e             	and    %dh,0x6e(%ebp)
 165:	73 69                	jae    1d0 <bootmain-0x27fe30>
 167:	67 6e                	outsb  %ds:(%si),(%dx)
 169:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
 16e:	74 3a                	je     1aa <bootmain-0x27fe56>
 170:	74 28                	je     19a <bootmain-0x27fe66>
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
 191:	72 3a                	jb     1cd <bootmain-0x27fe33>
 193:	74 28                	je     1bd <bootmain-0x27fe43>
 195:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 198:	30 29                	xor    %ch,(%ecx)
 19a:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 19f:	31 30                	xor    %esi,(%eax)
 1a1:	29 3b                	sub    %edi,(%ebx)
 1a3:	2d 31 32 38 3b       	sub    $0x3b383231,%eax
 1a8:	31 32                	xor    %esi,(%edx)
 1aa:	37                   	aaa    
 1ab:	3b 00                	cmp    (%eax),%eax
 1ad:	75 6e                	jne    21d <bootmain-0x27fde3>
 1af:	73 69                	jae    21a <bootmain-0x27fde6>
 1b1:	67 6e                	outsb  %ds:(%si),(%dx)
 1b3:	65 64 20 63 68       	gs and %ah,%fs:%gs:0x68(%ebx)
 1b8:	61                   	popa   
 1b9:	72 3a                	jb     1f5 <bootmain-0x27fe0b>
 1bb:	74 28                	je     1e5 <bootmain-0x27fe1b>
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
 1d6:	74 3a                	je     212 <bootmain-0x27fdee>
 1d8:	74 28                	je     202 <bootmain-0x27fdfe>
 1da:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 1dd:	32 29                	xor    (%ecx),%ch
 1df:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 1e4:	31 29                	xor    %ebp,(%ecx)
 1e6:	3b 34 3b             	cmp    (%ebx,%edi,1),%esi
 1e9:	30 3b                	xor    %bh,(%ebx)
 1eb:	00 64 6f 75          	add    %ah,0x75(%edi,%ebp,2)
 1ef:	62 6c 65 3a          	bound  %ebp,0x3a(%ebp,%eiz,2)
 1f3:	74 28                	je     21d <bootmain-0x27fde3>
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
 20e:	75 62                	jne    272 <bootmain-0x27fd8e>
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
 252:	74 28                	je     27c <bootmain-0x27fd84>
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
 272:	74 28                	je     29c <bootmain-0x27fd64>
 274:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 277:	37                   	aaa    
 278:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
 27e:	31 29                	xor    %ebp,(%ecx)
 280:	3b 31                	cmp    (%ecx),%esi
 282:	36 3b 30             	cmp    %ss:(%eax),%esi
 285:	3b 00                	cmp    (%eax),%eax
 287:	76 6f                	jbe    2f8 <bootmain-0x27fd08>
 289:	69 64 3a 74 28 30 2c 	imul   $0x312c3028,0x74(%edx,%edi,1),%esp
 290:	31 
 291:	38 29                	cmp    %ch,(%ecx)
 293:	3d 28 30 2c 31       	cmp    $0x312c3028,%eax
 298:	38 29                	cmp    %ch,(%ecx)
 29a:	00 2e                	add    %ch,(%esi)
 29c:	2f                   	das    
 29d:	68 65 61 64 65       	push   $0x65646165
 2a2:	72 2e                	jb     2d2 <bootmain-0x27fd2e>
 2a4:	68 00 2e 2f 78       	push   $0x782f2e00
 2a9:	38 36                	cmp    %dh,(%esi)
 2ab:	2e                   	cs
 2ac:	68 00 2e 2f 74       	push   $0x742f2e00
 2b1:	79 70                	jns    323 <bootmain-0x27fcdd>
 2b3:	65                   	gs
 2b4:	73 2e                	jae    2e4 <bootmain-0x27fd1c>
 2b6:	68 00 62 6f 6f       	push   $0x6f6f6200
 2bb:	6c                   	insb   (%dx),%es:(%edi)
 2bc:	3a 74 28 33          	cmp    0x33(%eax,%ebp,1),%dh
 2c0:	2c 31                	sub    $0x31,%al
 2c2:	29 3d 28 30 2c 31    	sub    %edi,0x312c3028
 2c8:	29 00                	sub    %eax,(%eax)
 2ca:	69 6e 74 38 5f 74 3a 	imul   $0x3a745f38,0x74(%esi),%ebp
 2d1:	74 28                	je     2fb <bootmain-0x27fd05>
 2d3:	33 2c 32             	xor    (%edx,%esi,1),%ebp
 2d6:	29 3d 28 30 2c 31    	sub    %edi,0x312c3028
 2dc:	30 29                	xor    %ch,(%ecx)
 2de:	00 75 69             	add    %dh,0x69(%ebp)
 2e1:	6e                   	outsb  %ds:(%esi),(%dx)
 2e2:	74 38                	je     31c <bootmain-0x27fce4>
 2e4:	5f                   	pop    %edi
 2e5:	74 3a                	je     321 <bootmain-0x27fcdf>
 2e7:	74 28                	je     311 <bootmain-0x27fcef>
 2e9:	33 2c 33             	xor    (%ebx,%esi,1),%ebp
 2ec:	29 3d 28 30 2c 31    	sub    %edi,0x312c3028
 2f2:	31 29                	xor    %ebp,(%ecx)
 2f4:	00 69 6e             	add    %ch,0x6e(%ecx)
 2f7:	74 31                	je     32a <bootmain-0x27fcd6>
 2f9:	36                   	ss
 2fa:	5f                   	pop    %edi
 2fb:	74 3a                	je     337 <bootmain-0x27fcc9>
 2fd:	74 28                	je     327 <bootmain-0x27fcd9>
 2ff:	33 2c 34             	xor    (%esp,%esi,1),%ebp
 302:	29 3d 28 30 2c 38    	sub    %edi,0x382c3028
 308:	29 00                	sub    %eax,(%eax)
 30a:	75 69                	jne    375 <bootmain-0x27fc8b>
 30c:	6e                   	outsb  %ds:(%esi),(%dx)
 30d:	74 31                	je     340 <bootmain-0x27fcc0>
 30f:	36                   	ss
 310:	5f                   	pop    %edi
 311:	74 3a                	je     34d <bootmain-0x27fcb3>
 313:	74 28                	je     33d <bootmain-0x27fcc3>
 315:	33 2c 35 29 3d 28 30 	xor    0x30283d29(,%esi,1),%ebp
 31c:	2c 39                	sub    $0x39,%al
 31e:	29 00                	sub    %eax,(%eax)
 320:	69 6e 74 33 32 5f 74 	imul   $0x745f3233,0x74(%esi),%ebp
 327:	3a 74 28 33          	cmp    0x33(%eax,%ebp,1),%dh
 32b:	2c 36                	sub    $0x36,%al
 32d:	29 3d 28 30 2c 31    	sub    %edi,0x312c3028
 333:	29 00                	sub    %eax,(%eax)
 335:	75 69                	jne    3a0 <bootmain-0x27fc60>
 337:	6e                   	outsb  %ds:(%esi),(%dx)
 338:	74 33                	je     36d <bootmain-0x27fc93>
 33a:	32 5f 74             	xor    0x74(%edi),%bl
 33d:	3a 74 28 33          	cmp    0x33(%eax,%ebp,1),%dh
 341:	2c 37                	sub    $0x37,%al
 343:	29 3d 28 30 2c 34    	sub    %edi,0x342c3028
 349:	29 00                	sub    %eax,(%eax)
 34b:	69 6e 74 36 34 5f 74 	imul   $0x745f3436,0x74(%esi),%ebp
 352:	3a 74 28 33          	cmp    0x33(%eax,%ebp,1),%dh
 356:	2c 38                	sub    $0x38,%al
 358:	29 3d 28 30 2c 36    	sub    %edi,0x362c3028
 35e:	29 00                	sub    %eax,(%eax)
 360:	75 69                	jne    3cb <bootmain-0x27fc35>
 362:	6e                   	outsb  %ds:(%esi),(%dx)
 363:	74 36                	je     39b <bootmain-0x27fc65>
 365:	34 5f                	xor    $0x5f,%al
 367:	74 3a                	je     3a3 <bootmain-0x27fc5d>
 369:	74 28                	je     393 <bootmain-0x27fc6d>
 36b:	33 2c 39             	xor    (%ecx,%edi,1),%ebp
 36e:	29 3d 28 30 2c 37    	sub    %edi,0x372c3028
 374:	29 00                	sub    %eax,(%eax)
 376:	69 6e 74 70 74 72 5f 	imul   $0x5f727470,0x74(%esi),%ebp
 37d:	74 3a                	je     3b9 <bootmain-0x27fc47>
 37f:	74 28                	je     3a9 <bootmain-0x27fc57>
 381:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 384:	30 29                	xor    %ch,(%ecx)
 386:	3d 28 33 2c 36       	cmp    $0x362c3328,%eax
 38b:	29 00                	sub    %eax,(%eax)
 38d:	75 69                	jne    3f8 <bootmain-0x27fc08>
 38f:	6e                   	outsb  %ds:(%esi),(%dx)
 390:	74 70                	je     402 <bootmain-0x27fbfe>
 392:	74 72                	je     406 <bootmain-0x27fbfa>
 394:	5f                   	pop    %edi
 395:	74 3a                	je     3d1 <bootmain-0x27fc2f>
 397:	74 28                	je     3c1 <bootmain-0x27fc3f>
 399:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 39c:	31 29                	xor    %ebp,(%ecx)
 39e:	3d 28 33 2c 37       	cmp    $0x372c3328,%eax
 3a3:	29 00                	sub    %eax,(%eax)
 3a5:	70 68                	jo     40f <bootmain-0x27fbf1>
 3a7:	79 73                	jns    41c <bootmain-0x27fbe4>
 3a9:	61                   	popa   
 3aa:	64                   	fs
 3ab:	64                   	fs
 3ac:	72 5f                	jb     40d <bootmain-0x27fbf3>
 3ae:	74 3a                	je     3ea <bootmain-0x27fc16>
 3b0:	74 28                	je     3da <bootmain-0x27fc26>
 3b2:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 3b5:	32 29                	xor    (%ecx),%ch
 3b7:	3d 28 33 2c 37       	cmp    $0x372c3328,%eax
 3bc:	29 00                	sub    %eax,(%eax)
 3be:	70 70                	jo     430 <bootmain-0x27fbd0>
 3c0:	6e                   	outsb  %ds:(%esi),(%dx)
 3c1:	5f                   	pop    %edi
 3c2:	74 3a                	je     3fe <bootmain-0x27fc02>
 3c4:	74 28                	je     3ee <bootmain-0x27fc12>
 3c6:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 3c9:	33 29                	xor    (%ecx),%ebp
 3cb:	3d 28 33 2c 37       	cmp    $0x372c3328,%eax
 3d0:	29 00                	sub    %eax,(%eax)
 3d2:	73 69                	jae    43d <bootmain-0x27fbc3>
 3d4:	7a 65                	jp     43b <bootmain-0x27fbc5>
 3d6:	5f                   	pop    %edi
 3d7:	74 3a                	je     413 <bootmain-0x27fbed>
 3d9:	74 28                	je     403 <bootmain-0x27fbfd>
 3db:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 3de:	34 29                	xor    $0x29,%al
 3e0:	3d 28 33 2c 37       	cmp    $0x372c3328,%eax
 3e5:	29 00                	sub    %eax,(%eax)
 3e7:	73 73                	jae    45c <bootmain-0x27fba4>
 3e9:	69 7a 65 5f 74 3a 74 	imul   $0x743a745f,0x65(%edx),%edi
 3f0:	28 33                	sub    %dh,(%ebx)
 3f2:	2c 31                	sub    $0x31,%al
 3f4:	35 29 3d 28 33       	xor    $0x33283d29,%eax
 3f9:	2c 36                	sub    $0x36,%al
 3fb:	29 00                	sub    %eax,(%eax)
 3fd:	6f                   	outsl  %ds:(%esi),(%dx)
 3fe:	66 66 5f             	data32 pop %di
 401:	74 3a                	je     43d <bootmain-0x27fbc3>
 403:	74 28                	je     42d <bootmain-0x27fbd3>
 405:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 408:	36 29 3d 28 33 2c 36 	sub    %edi,%ss:0x362c3328
 40f:	29 00                	sub    %eax,(%eax)
 411:	46                   	inc    %esi
 412:	49                   	dec    %ecx
 413:	46                   	inc    %esi
 414:	4f                   	dec    %edi
 415:	38 3a                	cmp    %bh,(%edx)
 417:	54                   	push   %esp
 418:	28 31                	sub    %dh,(%ecx)
 41a:	2c 31                	sub    $0x31,%al
 41c:	29 3d 73 32 34 62    	sub    %edi,0x62343273
 422:	75 66                	jne    48a <bootmain-0x27fb76>
 424:	3a 28                	cmp    (%eax),%ch
 426:	31 2c 32             	xor    %ebp,(%edx,%esi,1)
 429:	29 3d 2a 28 30 2c    	sub    %edi,0x2c30282a
 42f:	31 31                	xor    %esi,(%ecx)
 431:	29 2c 30             	sub    %ebp,(%eax,%esi,1)
 434:	2c 33                	sub    $0x33,%al
 436:	32 3b                	xor    (%ebx),%bh
 438:	70 3a                	jo     474 <bootmain-0x27fb8c>
 43a:	28 30                	sub    %dh,(%eax)
 43c:	2c 31                	sub    $0x31,%al
 43e:	29 2c 33             	sub    %ebp,(%ebx,%esi,1)
 441:	32 2c 33             	xor    (%ebx,%esi,1),%ch
 444:	32 3b                	xor    (%ebx),%bh
 446:	71 3a                	jno    482 <bootmain-0x27fb7e>
 448:	28 30                	sub    %dh,(%eax)
 44a:	2c 31                	sub    $0x31,%al
 44c:	29 2c 36             	sub    %ebp,(%esi,%esi,1)
 44f:	34 2c                	xor    $0x2c,%al
 451:	33 32                	xor    (%edx),%esi
 453:	3b 73 69             	cmp    0x69(%ebx),%esi
 456:	7a 65                	jp     4bd <bootmain-0x27fb43>
 458:	3a 28                	cmp    (%eax),%ch
 45a:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 45d:	29 2c 39             	sub    %ebp,(%ecx,%edi,1)
 460:	36                   	ss
 461:	2c 33                	sub    $0x33,%al
 463:	32 3b                	xor    (%ebx),%bh
 465:	66                   	data16
 466:	72 65                	jb     4cd <bootmain-0x27fb33>
 468:	65 3a 28             	cmp    %gs:(%eax),%ch
 46b:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 46e:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 471:	32 38                	xor    (%eax),%bh
 473:	2c 33                	sub    $0x33,%al
 475:	32 3b                	xor    (%ebx),%bh
 477:	66                   	data16
 478:	6c                   	insb   (%dx),%es:(%edi)
 479:	61                   	popa   
 47a:	67 73 3a             	addr16 jae 4b7 <bootmain-0x27fb49>
 47d:	28 30                	sub    %dh,(%eax)
 47f:	2c 31                	sub    $0x31,%al
 481:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 484:	36 30 2c 33          	xor    %ch,%ss:(%ebx,%esi,1)
 488:	32 3b                	xor    (%ebx),%bh
 48a:	3b 00                	cmp    (%eax),%eax
 48c:	4d                   	dec    %ebp
 48d:	4f                   	dec    %edi
 48e:	55                   	push   %ebp
 48f:	53                   	push   %ebx
 490:	45                   	inc    %ebp
 491:	5f                   	pop    %edi
 492:	44                   	inc    %esp
 493:	45                   	inc    %ebp
 494:	43                   	inc    %ebx
 495:	3a 54 28 31          	cmp    0x31(%eax,%ebp,1),%dl
 499:	2c 33                	sub    $0x33,%al
 49b:	29 3d 73 31 36 62    	sub    %edi,0x62363173
 4a1:	75 66                	jne    509 <bootmain-0x27faf7>
 4a3:	3a 28                	cmp    (%eax),%ch
 4a5:	31 2c 34             	xor    %ebp,(%esp,%esi,1)
 4a8:	29 3d 61 72 28 31    	sub    %edi,0x31287261
 4ae:	2c 35                	sub    $0x35,%al
 4b0:	29 3d 72 28 31 2c    	sub    %edi,0x2c312872
 4b6:	35 29 3b 30 3b       	xor    $0x3b303b29,%eax
 4bb:	34 32                	xor    $0x32,%al
 4bd:	39 34 39             	cmp    %esi,(%ecx,%edi,1)
 4c0:	36                   	ss
 4c1:	37                   	aaa    
 4c2:	32 39                	xor    (%ecx),%bh
 4c4:	35 3b 3b 30 3b       	xor    $0x3b303b3b,%eax
 4c9:	32 3b                	xor    (%ebx),%bh
 4cb:	28 30                	sub    %dh,(%eax)
 4cd:	2c 31                	sub    $0x31,%al
 4cf:	31 29                	xor    %ebp,(%ecx)
 4d1:	2c 30                	sub    $0x30,%al
 4d3:	2c 32                	sub    $0x32,%al
 4d5:	34 3b                	xor    $0x3b,%al
 4d7:	70 68                	jo     541 <bootmain-0x27fabf>
 4d9:	61                   	popa   
 4da:	73 65                	jae    541 <bootmain-0x27fabf>
 4dc:	3a 28                	cmp    (%eax),%ch
 4de:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 4e1:	31 29                	xor    %ebp,(%ecx)
 4e3:	2c 32                	sub    $0x32,%al
 4e5:	34 2c                	xor    $0x2c,%al
 4e7:	38 3b                	cmp    %bh,(%ebx)
 4e9:	78 3a                	js     525 <bootmain-0x27fadb>
 4eb:	28 30                	sub    %dh,(%eax)
 4ed:	2c 31                	sub    $0x31,%al
 4ef:	29 2c 33             	sub    %ebp,(%ebx,%esi,1)
 4f2:	32 2c 33             	xor    (%ebx,%esi,1),%ch
 4f5:	32 3b                	xor    (%ebx),%bh
 4f7:	79 3a                	jns    533 <bootmain-0x27facd>
 4f9:	28 30                	sub    %dh,(%eax)
 4fb:	2c 31                	sub    $0x31,%al
 4fd:	29 2c 36             	sub    %ebp,(%esi,%esi,1)
 500:	34 2c                	xor    $0x2c,%al
 502:	33 32                	xor    (%edx),%esi
 504:	3b 62 74             	cmp    0x74(%edx),%esp
 507:	6e                   	outsb  %ds:(%esi),(%dx)
 508:	3a 28                	cmp    (%eax),%ch
 50a:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 50d:	29 2c 39             	sub    %ebp,(%ecx,%edi,1)
 510:	36                   	ss
 511:	2c 33                	sub    $0x33,%al
 513:	32 3b                	xor    (%ebx),%bh
 515:	3b 00                	cmp    (%eax),%eax
 517:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 51a:	74 5f                	je     57b <bootmain-0x27fa85>
 51c:	69 6e 66 6f 3a 54 28 	imul   $0x28543a6f,0x66(%esi),%ebp
 523:	31 2c 36             	xor    %ebp,(%esi,%esi,1)
 526:	29 3d 73 31 32 63    	sub    %edi,0x63323173
 52c:	79 6c                	jns    59a <bootmain-0x27fa66>
 52e:	69 6e 64 65 72 3a 28 	imul   $0x283a7265,0x64(%esi),%ebp
 535:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 538:	29 2c 30             	sub    %ebp,(%eax,%esi,1)
 53b:	2c 38                	sub    $0x38,%al
 53d:	3b 6c 65 64          	cmp    0x64(%ebp,%eiz,2),%ebp
 541:	3a 28                	cmp    (%eax),%ch
 543:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 546:	29 2c 38             	sub    %ebp,(%eax,%edi,1)
 549:	2c 38                	sub    $0x38,%al
 54b:	3b 63 6f             	cmp    0x6f(%ebx),%esp
 54e:	6c                   	insb   (%dx),%es:(%edi)
 54f:	6f                   	outsl  %ds:(%esi),(%dx)
 550:	72 5f                	jb     5b1 <bootmain-0x27fa4f>
 552:	6d                   	insl   (%dx),%es:(%edi)
 553:	6f                   	outsl  %ds:(%esi),(%dx)
 554:	64 65 3a 28          	fs cmp %fs:%gs:(%eax),%ch
 558:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 55b:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 55e:	36                   	ss
 55f:	2c 38                	sub    $0x38,%al
 561:	3b 72 65             	cmp    0x65(%edx),%esi
 564:	73 65                	jae    5cb <bootmain-0x27fa35>
 566:	72 76                	jb     5de <bootmain-0x27fa22>
 568:	65 64 3a 28          	gs cmp %fs:%gs:(%eax),%ch
 56c:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 56f:	29 2c 32             	sub    %ebp,(%edx,%esi,1)
 572:	34 2c                	xor    $0x2c,%al
 574:	38 3b                	cmp    %bh,(%ebx)
 576:	78 73                	js     5eb <bootmain-0x27fa15>
 578:	69 7a 65 3a 28 30 2c 	imul   $0x2c30283a,0x65(%edx),%edi
 57f:	38 29                	cmp    %ch,(%ecx)
 581:	2c 33                	sub    $0x33,%al
 583:	32 2c 31             	xor    (%ecx,%esi,1),%ch
 586:	36 3b 79 73          	cmp    %ss:0x73(%ecx),%edi
 58a:	69 7a 65 3a 28 30 2c 	imul   $0x2c30283a,0x65(%edx),%edi
 591:	38 29                	cmp    %ch,(%ecx)
 593:	2c 34                	sub    $0x34,%al
 595:	38 2c 31             	cmp    %ch,(%ecx,%esi,1)
 598:	36 3b 76 72          	cmp    %ss:0x72(%esi),%esi
 59c:	61                   	popa   
 59d:	6d                   	insl   (%dx),%es:(%edi)
 59e:	3a 28                	cmp    (%eax),%ch
 5a0:	31 2c 37             	xor    %ebp,(%edi,%esi,1)
 5a3:	29 3d 2a 28 30 2c    	sub    %edi,0x2c30282a
 5a9:	32 29                	xor    (%ecx),%ch
 5ab:	2c 36                	sub    $0x36,%al
 5ad:	34 2c                	xor    $0x2c,%al
 5af:	33 32                	xor    (%edx),%esi
 5b1:	3b 3b                	cmp    (%ebx),%edi
 5b3:	00 47 44             	add    %al,0x44(%edi)
 5b6:	54                   	push   %esp
 5b7:	3a 54 28 31          	cmp    0x31(%eax,%ebp,1),%dl
 5bb:	2c 38                	sub    $0x38,%al
 5bd:	29 3d 73 38 6c 69    	sub    %edi,0x696c3873
 5c3:	6d                   	insl   (%dx),%es:(%edi)
 5c4:	69 74 5f 6c 6f 77 3a 	imul   $0x283a776f,0x6c(%edi,%ebx,2),%esi
 5cb:	28 
 5cc:	30 2c 38             	xor    %ch,(%eax,%edi,1)
 5cf:	29 2c 30             	sub    %ebp,(%eax,%esi,1)
 5d2:	2c 31                	sub    $0x31,%al
 5d4:	36 3b 62 61          	cmp    %ss:0x61(%edx),%esp
 5d8:	73 65                	jae    63f <bootmain-0x27f9c1>
 5da:	5f                   	pop    %edi
 5db:	6c                   	insb   (%dx),%es:(%edi)
 5dc:	6f                   	outsl  %ds:(%esi),(%dx)
 5dd:	77 3a                	ja     619 <bootmain-0x27f9e7>
 5df:	28 30                	sub    %dh,(%eax)
 5e1:	2c 38                	sub    $0x38,%al
 5e3:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 5e6:	36                   	ss
 5e7:	2c 31                	sub    $0x31,%al
 5e9:	36 3b 62 61          	cmp    %ss:0x61(%edx),%esp
 5ed:	73 65                	jae    654 <bootmain-0x27f9ac>
 5ef:	5f                   	pop    %edi
 5f0:	6d                   	insl   (%dx),%es:(%edi)
 5f1:	69 64 3a 28 30 2c 32 	imul   $0x29322c30,0x28(%edx,%edi,1),%esp
 5f8:	29 
 5f9:	2c 33                	sub    $0x33,%al
 5fb:	32 2c 38             	xor    (%eax,%edi,1),%ch
 5fe:	3b 61 63             	cmp    0x63(%ecx),%esp
 601:	63 65 73             	arpl   %sp,0x73(%ebp)
 604:	73 5f                	jae    665 <bootmain-0x27f99b>
 606:	72 69                	jb     671 <bootmain-0x27f98f>
 608:	67 68 74 3a 28 30    	addr16 push $0x30283a74
 60e:	2c 32                	sub    $0x32,%al
 610:	29 2c 34             	sub    %ebp,(%esp,%esi,1)
 613:	30 2c 38             	xor    %ch,(%eax,%edi,1)
 616:	3b 6c 69 6d          	cmp    0x6d(%ecx,%ebp,2),%ebp
 61a:	69 74 5f 68 69 67 68 	imul   $0x3a686769,0x68(%edi,%ebx,2),%esi
 621:	3a 
 622:	28 30                	sub    %dh,(%eax)
 624:	2c 32                	sub    $0x32,%al
 626:	29 2c 34             	sub    %ebp,(%esp,%esi,1)
 629:	38 2c 38             	cmp    %ch,(%eax,%edi,1)
 62c:	3b 62 61             	cmp    0x61(%edx),%esp
 62f:	73 65                	jae    696 <bootmain-0x27f96a>
 631:	5f                   	pop    %edi
 632:	68 69 67 68 3a       	push   $0x3a686769
 637:	28 30                	sub    %dh,(%eax)
 639:	2c 32                	sub    $0x32,%al
 63b:	29 2c 35 36 2c 38 3b 	sub    %ebp,0x3b382c36(,%esi,1)
 642:	3b 00                	cmp    (%eax),%eax
 644:	49                   	dec    %ecx
 645:	44                   	inc    %esp
 646:	54                   	push   %esp
 647:	3a 54 28 31          	cmp    0x31(%eax,%ebp,1),%dl
 64b:	2c 39                	sub    $0x39,%al
 64d:	29 3d 73 38 6f 66    	sub    %edi,0x666f3873
 653:	66                   	data16
 654:	73 65                	jae    6bb <bootmain-0x27f945>
 656:	74 5f                	je     6b7 <bootmain-0x27f949>
 658:	6c                   	insb   (%dx),%es:(%edi)
 659:	6f                   	outsl  %ds:(%esi),(%dx)
 65a:	77 3a                	ja     696 <bootmain-0x27f96a>
 65c:	28 30                	sub    %dh,(%eax)
 65e:	2c 38                	sub    $0x38,%al
 660:	29 2c 30             	sub    %ebp,(%eax,%esi,1)
 663:	2c 31                	sub    $0x31,%al
 665:	36 3b 73 65          	cmp    %ss:0x65(%ebx),%esi
 669:	6c                   	insb   (%dx),%es:(%edi)
 66a:	65 63 74 6f 72       	arpl   %si,%gs:0x72(%edi,%ebp,2)
 66f:	3a 28                	cmp    (%eax),%ch
 671:	30 2c 38             	xor    %ch,(%eax,%edi,1)
 674:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 677:	36                   	ss
 678:	2c 31                	sub    $0x31,%al
 67a:	36 3b 64 77 5f       	cmp    %ss:0x5f(%edi,%esi,2),%esp
 67f:	63 6f 75             	arpl   %bp,0x75(%edi)
 682:	6e                   	outsb  %ds:(%esi),(%dx)
 683:	74 3a                	je     6bf <bootmain-0x27f941>
 685:	28 30                	sub    %dh,(%eax)
 687:	2c 32                	sub    $0x32,%al
 689:	29 2c 33             	sub    %ebp,(%ebx,%esi,1)
 68c:	32 2c 38             	xor    (%eax,%edi,1),%ch
 68f:	3b 61 63             	cmp    0x63(%ecx),%esp
 692:	63 65 73             	arpl   %sp,0x73(%ebp)
 695:	73 5f                	jae    6f6 <bootmain-0x27f90a>
 697:	72 69                	jb     702 <bootmain-0x27f8fe>
 699:	67 68 74 3a 28 30    	addr16 push $0x30283a74
 69f:	2c 32                	sub    $0x32,%al
 6a1:	29 2c 34             	sub    %ebp,(%esp,%esi,1)
 6a4:	30 2c 38             	xor    %ch,(%eax,%edi,1)
 6a7:	3b 6f 66             	cmp    0x66(%edi),%ebp
 6aa:	66                   	data16
 6ab:	73 65                	jae    712 <bootmain-0x27f8ee>
 6ad:	74 5f                	je     70e <bootmain-0x27f8f2>
 6af:	68 69 67 68 3a       	push   $0x3a686769
 6b4:	28 30                	sub    %dh,(%eax)
 6b6:	2c 38                	sub    $0x38,%al
 6b8:	29 2c 34             	sub    %ebp,(%esp,%esi,1)
 6bb:	38 2c 31             	cmp    %ch,(%ecx,%esi,1)
 6be:	36 3b 3b             	cmp    %ss:(%ebx),%edi
 6c1:	00 62 6f             	add    %ah,0x6f(%edx)
 6c4:	6f                   	outsl  %ds:(%esi),(%dx)
 6c5:	74 6d                	je     734 <bootmain-0x27f8cc>
 6c7:	61                   	popa   
 6c8:	69 6e 3a 46 28 30 2c 	imul   $0x2c302846,0x3a(%esi),%ebp
 6cf:	31 38                	xor    %edi,(%eax)
 6d1:	29 00                	sub    %eax,(%eax)
 6d3:	73 3a                	jae    70f <bootmain-0x27f8f1>
 6d5:	28 30                	sub    %dh,(%eax)
 6d7:	2c 31                	sub    $0x31,%al
 6d9:	39 29                	cmp    %ebp,(%ecx)
 6db:	3d 61 72 28 31       	cmp    $0x31287261,%eax
 6e0:	2c 35                	sub    $0x35,%al
 6e2:	29 3b                	sub    %edi,(%ebx)
 6e4:	30 3b                	xor    %bh,(%ebx)
 6e6:	33 39                	xor    (%ecx),%edi
 6e8:	3b 28                	cmp    (%eax),%ebp
 6ea:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 6ed:	29 00                	sub    %eax,(%eax)
 6ef:	6b 65 79 62          	imul   $0x62,0x79(%ebp),%esp
 6f3:	75 66                	jne    75b <bootmain-0x27f8a5>
 6f5:	3a 28                	cmp    (%eax),%ch
 6f7:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 6fa:	30 29                	xor    %ch,(%ecx)
 6fc:	3d 61 72 28 31       	cmp    $0x31287261,%eax
 701:	2c 35                	sub    $0x35,%al
 703:	29 3b                	sub    %edi,(%ebx)
 705:	30 3b                	xor    %bh,(%ebx)
 707:	33 31                	xor    (%ecx),%esi
 709:	3b 28                	cmp    (%eax),%ebp
 70b:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 70e:	29 00                	sub    %eax,(%eax)
 710:	6d                   	insl   (%dx),%es:(%edi)
 711:	6f                   	outsl  %ds:(%esi),(%dx)
 712:	75 73                	jne    787 <bootmain-0x27f879>
 714:	65 62 75 66          	bound  %esi,%gs:0x66(%ebp)
 718:	3a 28                	cmp    (%eax),%ch
 71a:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 71d:	31 29                	xor    %ebp,(%ecx)
 71f:	3d 61 72 28 31       	cmp    $0x31287261,%eax
 724:	2c 35                	sub    $0x35,%al
 726:	29 3b                	sub    %edi,(%ebx)
 728:	30 3b                	xor    %bh,(%ebx)
 72a:	31 32                	xor    %esi,(%edx)
 72c:	37                   	aaa    
 72d:	3b 28                	cmp    (%eax),%ebp
 72f:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 732:	29 00                	sub    %eax,(%eax)
 734:	41                   	inc    %ecx
 735:	53                   	push   %ebx
 736:	43                   	inc    %ebx
 737:	49                   	dec    %ecx
 738:	49                   	dec    %ecx
 739:	5f                   	pop    %edi
 73a:	54                   	push   %esp
 73b:	61                   	popa   
 73c:	62 6c 65 3a          	bound  %ebp,0x3a(%ebp,%eiz,2)
 740:	47                   	inc    %edi
 741:	28 30                	sub    %dh,(%eax)
 743:	2c 32                	sub    $0x32,%al
 745:	32 29                	xor    (%ecx),%ch
 747:	3d 61 72 28 31       	cmp    $0x31287261,%eax
 74c:	2c 35                	sub    $0x35,%al
 74e:	29 3b                	sub    %edi,(%ebx)
 750:	30 3b                	xor    %bh,(%ebx)
 752:	32 32                	xor    (%edx),%dh
 754:	37                   	aaa    
 755:	39 3b                	cmp    %edi,(%ebx)
 757:	28 30                	sub    %dh,(%eax)
 759:	2c 39                	sub    $0x39,%al
 75b:	29 00                	sub    %eax,(%eax)
 75d:	46                   	inc    %esi
 75e:	6f                   	outsl  %ds:(%esi),(%dx)
 75f:	6e                   	outsb  %ds:(%esi),(%dx)
 760:	74 38                	je     79a <bootmain-0x27f866>
 762:	78 31                	js     795 <bootmain-0x27f86b>
 764:	36 3a 47 28          	cmp    %ss:0x28(%edi),%al
 768:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 76b:	33 29                	xor    (%ecx),%ebp
 76d:	3d 61 72 28 31       	cmp    $0x31287261,%eax
 772:	2c 35                	sub    $0x35,%al
 774:	29 3b                	sub    %edi,(%ebx)
 776:	30 3b                	xor    %bh,(%ebx)
 778:	32 30                	xor    (%eax),%dh
 77a:	34 37                	xor    $0x37,%al
 77c:	3b 28                	cmp    (%eax),%ebp
 77e:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 781:	31 29                	xor    %ebp,(%ecx)
 783:	00 62 6f             	add    %ah,0x6f(%edx)
 786:	6f                   	outsl  %ds:(%esi),(%dx)
 787:	74 70                	je     7f9 <bootmain-0x27f807>
 789:	3a 47 28             	cmp    0x28(%edi),%al
 78c:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 78f:	34 29                	xor    $0x29,%al
 791:	3d 2a 28 31 2c       	cmp    $0x2c31282a,%eax
 796:	36 29 00             	sub    %eax,%ss:(%eax)
 799:	73 63                	jae    7fe <bootmain-0x27f802>
 79b:	72 65                	jb     802 <bootmain-0x27f7fe>
 79d:	65 6e                	outsb  %gs:(%esi),(%dx)
 79f:	2e 63 00             	arpl   %ax,%cs:(%eax)
 7a2:	63 6c 65 61          	arpl   %bp,0x61(%ebp,%eiz,2)
 7a6:	72 5f                	jb     807 <bootmain-0x27f7f9>
 7a8:	73 63                	jae    80d <bootmain-0x27f7f3>
 7aa:	72 65                	jb     811 <bootmain-0x27f7ef>
 7ac:	65 6e                	outsb  %gs:(%esi),(%dx)
 7ae:	3a 46 28             	cmp    0x28(%esi),%al
 7b1:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 7b4:	38 29                	cmp    %ch,(%ecx)
 7b6:	00 63 6f             	add    %ah,0x6f(%ebx)
 7b9:	6c                   	insb   (%dx),%es:(%edi)
 7ba:	6f                   	outsl  %ds:(%esi),(%dx)
 7bb:	72 3a                	jb     7f7 <bootmain-0x27f809>
 7bd:	70 28                	jo     7e7 <bootmain-0x27f819>
 7bf:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 7c2:	29 00                	sub    %eax,(%eax)
 7c4:	69 3a 72 28 30 2c    	imul   $0x2c302872,(%edx),%edi
 7ca:	31 29                	xor    %ebp,(%ecx)
 7cc:	00 63 6f             	add    %ah,0x6f(%ebx)
 7cf:	6c                   	insb   (%dx),%es:(%edi)
 7d0:	6f                   	outsl  %ds:(%esi),(%dx)
 7d1:	72 3a                	jb     80d <bootmain-0x27f7f3>
 7d3:	72 28                	jb     7fd <bootmain-0x27f803>
 7d5:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 7d8:	29 00                	sub    %eax,(%eax)
 7da:	63 6f 6c             	arpl   %bp,0x6c(%edi)
 7dd:	6f                   	outsl  %ds:(%esi),(%dx)
 7de:	72 5f                	jb     83f <bootmain-0x27f7c1>
 7e0:	73 63                	jae    845 <bootmain-0x27f7bb>
 7e2:	72 65                	jb     849 <bootmain-0x27f7b7>
 7e4:	65 6e                	outsb  %gs:(%esi),(%dx)
 7e6:	3a 46 28             	cmp    0x28(%esi),%al
 7e9:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 7ec:	38 29                	cmp    %ch,(%ecx)
 7ee:	00 73 65             	add    %dh,0x65(%ebx)
 7f1:	74 5f                	je     852 <bootmain-0x27f7ae>
 7f3:	70 61                	jo     856 <bootmain-0x27f7aa>
 7f5:	6c                   	insb   (%dx),%es:(%edi)
 7f6:	65                   	gs
 7f7:	74 74                	je     86d <bootmain-0x27f793>
 7f9:	65 3a 46 28          	cmp    %gs:0x28(%esi),%al
 7fd:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 800:	38 29                	cmp    %ch,(%ecx)
 802:	00 73 74             	add    %dh,0x74(%ebx)
 805:	61                   	popa   
 806:	72 74                	jb     87c <bootmain-0x27f784>
 808:	3a 70 28             	cmp    0x28(%eax),%dh
 80b:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 80e:	29 00                	sub    %eax,(%eax)
 810:	65 6e                	outsb  %gs:(%esi),(%dx)
 812:	64 3a 70 28          	cmp    %fs:0x28(%eax),%dh
 816:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 819:	29 00                	sub    %eax,(%eax)
 81b:	72 67                	jb     884 <bootmain-0x27f77c>
 81d:	62 3a                	bound  %edi,(%edx)
 81f:	70 28                	jo     849 <bootmain-0x27f7b7>
 821:	31 2c 32             	xor    %ebp,(%edx,%esi,1)
 824:	29 00                	sub    %eax,(%eax)
 826:	73 74                	jae    89c <bootmain-0x27f764>
 828:	61                   	popa   
 829:	72 74                	jb     89f <bootmain-0x27f761>
 82b:	3a 72 28             	cmp    0x28(%edx),%dh
 82e:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 831:	29 00                	sub    %eax,(%eax)
 833:	72 67                	jb     89c <bootmain-0x27f764>
 835:	62 3a                	bound  %edi,(%edx)
 837:	72 28                	jb     861 <bootmain-0x27f79f>
 839:	31 2c 32             	xor    %ebp,(%edx,%esi,1)
 83c:	29 00                	sub    %eax,(%eax)
 83e:	69 6e 69 74 5f 70 61 	imul   $0x61705f74,0x69(%esi),%ebp
 845:	6c                   	insb   (%dx),%es:(%edi)
 846:	65                   	gs
 847:	74 74                	je     8bd <bootmain-0x27f743>
 849:	65 3a 46 28          	cmp    %gs:0x28(%esi),%al
 84d:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 850:	38 29                	cmp    %ch,(%ecx)
 852:	00 74 61 62          	add    %dh,0x62(%ecx,%eiz,2)
 856:	6c                   	insb   (%dx),%es:(%edi)
 857:	65                   	gs
 858:	5f                   	pop    %edi
 859:	72 67                	jb     8c2 <bootmain-0x27f73e>
 85b:	62 3a                	bound  %edi,(%edx)
 85d:	28 30                	sub    %dh,(%eax)
 85f:	2c 31                	sub    $0x31,%al
 861:	39 29                	cmp    %ebp,(%ecx)
 863:	3d 61 72 28 31       	cmp    $0x31287261,%eax
 868:	2c 35                	sub    $0x35,%al
 86a:	29 3b                	sub    %edi,(%ebx)
 86c:	30 3b                	xor    %bh,(%ebx)
 86e:	34 37                	xor    $0x37,%al
 870:	3b 28                	cmp    (%eax),%ebp
 872:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 875:	31 29                	xor    %ebp,(%ecx)
 877:	00 62 6f             	add    %ah,0x6f(%edx)
 87a:	78 66                	js     8e2 <bootmain-0x27f71e>
 87c:	69 6c 6c 38 3a 46 28 	imul   $0x3028463a,0x38(%esp,%ebp,2),%ebp
 883:	30 
 884:	2c 31                	sub    $0x31,%al
 886:	38 29                	cmp    %ch,(%ecx)
 888:	00 76 72             	add    %dh,0x72(%esi)
 88b:	61                   	popa   
 88c:	6d                   	insl   (%dx),%es:(%edi)
 88d:	3a 70 28             	cmp    0x28(%eax),%dh
 890:	31 2c 32             	xor    %ebp,(%edx,%esi,1)
 893:	29 00                	sub    %eax,(%eax)
 895:	78 73                	js     90a <bootmain-0x27f6f6>
 897:	69 7a 65 3a 70 28 30 	imul   $0x3028703a,0x65(%edx),%edi
 89e:	2c 31                	sub    $0x31,%al
 8a0:	29 00                	sub    %eax,(%eax)
 8a2:	78 30                	js     8d4 <bootmain-0x27f72c>
 8a4:	3a 70 28             	cmp    0x28(%eax),%dh
 8a7:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 8aa:	29 00                	sub    %eax,(%eax)
 8ac:	79 30                	jns    8de <bootmain-0x27f722>
 8ae:	3a 70 28             	cmp    0x28(%eax),%dh
 8b1:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 8b4:	29 00                	sub    %eax,(%eax)
 8b6:	78 31                	js     8e9 <bootmain-0x27f717>
 8b8:	3a 70 28             	cmp    0x28(%eax),%dh
 8bb:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 8be:	29 00                	sub    %eax,(%eax)
 8c0:	79 31                	jns    8f3 <bootmain-0x27f70d>
 8c2:	3a 70 28             	cmp    0x28(%eax),%dh
 8c5:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 8c8:	29 00                	sub    %eax,(%eax)
 8ca:	63 6f 6c             	arpl   %bp,0x6c(%edi)
 8cd:	6f                   	outsl  %ds:(%esi),(%dx)
 8ce:	72 3a                	jb     90a <bootmain-0x27f6f6>
 8d0:	72 28                	jb     8fa <bootmain-0x27f706>
 8d2:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 8d5:	31 29                	xor    %ebp,(%ecx)
 8d7:	00 79 30             	add    %bh,0x30(%ecx)
 8da:	3a 72 28             	cmp    0x28(%edx),%dh
 8dd:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 8e0:	29 00                	sub    %eax,(%eax)
 8e2:	62 6f 78             	bound  %ebp,0x78(%edi)
 8e5:	66 69 6c 6c 3a 46 28 	imul   $0x2846,0x3a(%esp,%ebp,2),%bp
 8ec:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 8ef:	38 29                	cmp    %ch,(%ecx)
 8f1:	00 64 72 61          	add    %ah,0x61(%edx,%esi,2)
 8f5:	77 5f                	ja     956 <bootmain-0x27f6aa>
 8f7:	77 69                	ja     962 <bootmain-0x27f69e>
 8f9:	6e                   	outsb  %ds:(%esi),(%dx)
 8fa:	64 6f                	outsl  %fs:(%esi),(%dx)
 8fc:	77 3a                	ja     938 <bootmain-0x27f6c8>
 8fe:	46                   	inc    %esi
 8ff:	28 30                	sub    %dh,(%eax)
 901:	2c 31                	sub    $0x31,%al
 903:	38 29                	cmp    %ch,(%ecx)
 905:	00 69 6e             	add    %ch,0x6e(%ecx)
 908:	69 74 5f 73 63 72 65 	imul   $0x65657263,0x73(%edi,%ebx,2),%esi
 90f:	65 
 910:	6e                   	outsb  %ds:(%esi),(%dx)
 911:	3a 46 28             	cmp    0x28(%esi),%al
 914:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 917:	38 29                	cmp    %ch,(%ecx)
 919:	00 62 6f             	add    %ah,0x6f(%edx)
 91c:	6f                   	outsl  %ds:(%esi),(%dx)
 91d:	74 70                	je     98f <bootmain-0x27f671>
 91f:	3a 70 28             	cmp    0x28(%eax),%dh
 922:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 925:	30 29                	xor    %ch,(%ecx)
 927:	3d 2a 28 31 2c       	cmp    $0x2c31282a,%eax
 92c:	36 29 00             	sub    %eax,%ss:(%eax)
 92f:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 932:	74 70                	je     9a4 <bootmain-0x27f65c>
 934:	3a 72 28             	cmp    0x28(%edx),%dh
 937:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 93a:	30 29                	xor    %ch,(%ecx)
 93c:	00 69 6e             	add    %ch,0x6e(%ecx)
 93f:	69 74 5f 6d 6f 75 73 	imul   $0x6573756f,0x6d(%edi,%ebx,2),%esi
 946:	65 
 947:	3a 46 28             	cmp    0x28(%esi),%al
 94a:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 94d:	38 29                	cmp    %ch,(%ecx)
 94f:	00 6d 6f             	add    %ch,0x6f(%ebp)
 952:	75 73                	jne    9c7 <bootmain-0x27f639>
 954:	65 3a 70 28          	cmp    %gs:0x28(%eax),%dh
 958:	31 2c 37             	xor    %ebp,(%edi,%esi,1)
 95b:	29 00                	sub    %eax,(%eax)
 95d:	62 67 3a             	bound  %esp,0x3a(%edi)
 960:	70 28                	jo     98a <bootmain-0x27f676>
 962:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 965:	29 00                	sub    %eax,(%eax)
 967:	78 3a                	js     9a3 <bootmain-0x27f65d>
 969:	72 28                	jb     993 <bootmain-0x27f66d>
 96b:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 96e:	29 00                	sub    %eax,(%eax)
 970:	62 67 3a             	bound  %esp,0x3a(%edi)
 973:	72 28                	jb     99d <bootmain-0x27f663>
 975:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 978:	29 00                	sub    %eax,(%eax)
 97a:	64 69 73 70 6c 61 79 	imul   $0x5f79616c,%fs:0x70(%ebx),%esi
 981:	5f 
 982:	6d                   	insl   (%dx),%es:(%edi)
 983:	6f                   	outsl  %ds:(%esi),(%dx)
 984:	75 73                	jne    9f9 <bootmain-0x27f607>
 986:	65 3a 46 28          	cmp    %gs:0x28(%esi),%al
 98a:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 98d:	38 29                	cmp    %ch,(%ecx)
 98f:	00 76 72             	add    %dh,0x72(%esi)
 992:	61                   	popa   
 993:	6d                   	insl   (%dx),%es:(%edi)
 994:	3a 70 28             	cmp    0x28(%eax),%dh
 997:	31 2c 37             	xor    %ebp,(%edi,%esi,1)
 99a:	29 00                	sub    %eax,(%eax)
 99c:	70 78                	jo     a16 <bootmain-0x27f5ea>
 99e:	73 69                	jae    a09 <bootmain-0x27f5f7>
 9a0:	7a 65                	jp     a07 <bootmain-0x27f5f9>
 9a2:	3a 70 28             	cmp    0x28(%eax),%dh
 9a5:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 9a8:	29 00                	sub    %eax,(%eax)
 9aa:	70 79                	jo     a25 <bootmain-0x27f5db>
 9ac:	73 69                	jae    a17 <bootmain-0x27f5e9>
 9ae:	7a 65                	jp     a15 <bootmain-0x27f5eb>
 9b0:	3a 70 28             	cmp    0x28(%eax),%dh
 9b3:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 9b6:	29 00                	sub    %eax,(%eax)
 9b8:	70 78                	jo     a32 <bootmain-0x27f5ce>
 9ba:	30 3a                	xor    %bh,(%edx)
 9bc:	70 28                	jo     9e6 <bootmain-0x27f61a>
 9be:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 9c1:	29 00                	sub    %eax,(%eax)
 9c3:	70 79                	jo     a3e <bootmain-0x27f5c2>
 9c5:	30 3a                	xor    %bh,(%edx)
 9c7:	70 28                	jo     9f1 <bootmain-0x27f60f>
 9c9:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 9cc:	29 00                	sub    %eax,(%eax)
 9ce:	62 75 66             	bound  %esi,0x66(%ebp)
 9d1:	3a 70 28             	cmp    0x28(%eax),%dh
 9d4:	31 2c 37             	xor    %ebp,(%edi,%esi,1)
 9d7:	29 00                	sub    %eax,(%eax)
 9d9:	62 78 73             	bound  %edi,0x73(%eax)
 9dc:	69 7a 65 3a 70 28 30 	imul   $0x3028703a,0x65(%edx),%edi
 9e3:	2c 31                	sub    $0x31,%al
 9e5:	29 00                	sub    %eax,(%eax)
 9e7:	79 3a                	jns    a23 <bootmain-0x27f5dd>
 9e9:	72 28                	jb     a13 <bootmain-0x27f5ed>
 9eb:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 9ee:	29 00                	sub    %eax,(%eax)
 9f0:	63 75 72             	arpl   %si,0x72(%ebp)
 9f3:	73 6f                	jae    a64 <bootmain-0x27f59c>
 9f5:	72 3a                	jb     a31 <bootmain-0x27f5cf>
 9f7:	53                   	push   %ebx
 9f8:	28 30                	sub    %dh,(%eax)
 9fa:	2c 32                	sub    $0x32,%al
 9fc:	31 29                	xor    %ebp,(%ecx)
 9fe:	3d 61 72 28 31       	cmp    $0x31287261,%eax
 a03:	2c 35                	sub    $0x35,%al
 a05:	29 3b                	sub    %edi,(%ebx)
 a07:	30 3b                	xor    %bh,(%ebx)
 a09:	31 35 3b 28 30 2c    	xor    %esi,0x2c30283b
 a0f:	32 32                	xor    (%edx),%dh
 a11:	29 3d 61 72 28 31    	sub    %edi,0x31287261
 a17:	2c 35                	sub    $0x35,%al
 a19:	29 3b                	sub    %edi,(%ebx)
 a1b:	30 3b                	xor    %bh,(%ebx)
 a1d:	31 35 3b 28 30 2c    	xor    %esi,0x2c30283b
 a23:	32 29                	xor    (%ecx),%ch
 a25:	00 66 6f             	add    %ah,0x6f(%esi)
 a28:	6e                   	outsb  %ds:(%esi),(%dx)
 a29:	74 2e                	je     a59 <bootmain-0x27f5a7>
 a2b:	63 00                	arpl   %ax,(%eax)
 a2d:	70 72                	jo     aa1 <bootmain-0x27f55f>
 a2f:	69 6e 74 2e 63 00 69 	imul   $0x6900632e,0x74(%esi),%ebp
 a36:	74 6f                	je     aa7 <bootmain-0x27f559>
 a38:	61                   	popa   
 a39:	3a 46 28             	cmp    0x28(%esi),%al
 a3c:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 a3f:	38 29                	cmp    %ch,(%ecx)
 a41:	00 76 61             	add    %dh,0x61(%esi)
 a44:	6c                   	insb   (%dx),%es:(%edi)
 a45:	75 65                	jne    aac <bootmain-0x27f554>
 a47:	3a 70 28             	cmp    0x28(%eax),%dh
 a4a:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 a4d:	29 00                	sub    %eax,(%eax)
 a4f:	74 6d                	je     abe <bootmain-0x27f542>
 a51:	70 5f                	jo     ab2 <bootmain-0x27f54e>
 a53:	62 75 66             	bound  %esi,0x66(%ebp)
 a56:	3a 28                	cmp    (%eax),%ch
 a58:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 a5b:	39 29                	cmp    %ebp,(%ecx)
 a5d:	3d 61 72 28 31       	cmp    $0x31287261,%eax
 a62:	2c 35                	sub    $0x35,%al
 a64:	29 3b                	sub    %edi,(%ebx)
 a66:	30 3b                	xor    %bh,(%ebx)
 a68:	39 3b                	cmp    %edi,(%ebx)
 a6a:	28 30                	sub    %dh,(%eax)
 a6c:	2c 32                	sub    $0x32,%al
 a6e:	29 00                	sub    %eax,(%eax)
 a70:	76 61                	jbe    ad3 <bootmain-0x27f52d>
 a72:	6c                   	insb   (%dx),%es:(%edi)
 a73:	75 65                	jne    ada <bootmain-0x27f526>
 a75:	3a 72 28             	cmp    0x28(%edx),%dh
 a78:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 a7b:	29 00                	sub    %eax,(%eax)
 a7d:	62 75 66             	bound  %esi,0x66(%ebp)
 a80:	3a 72 28             	cmp    0x28(%edx),%dh
 a83:	31 2c 37             	xor    %ebp,(%edi,%esi,1)
 a86:	29 00                	sub    %eax,(%eax)
 a88:	78 74                	js     afe <bootmain-0x27f502>
 a8a:	6f                   	outsl  %ds:(%esi),(%dx)
 a8b:	61                   	popa   
 a8c:	3a 46 28             	cmp    0x28(%esi),%al
 a8f:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 a92:	38 29                	cmp    %ch,(%ecx)
 a94:	00 76 61             	add    %dh,0x61(%esi)
 a97:	6c                   	insb   (%dx),%es:(%edi)
 a98:	75 65                	jne    aff <bootmain-0x27f501>
 a9a:	3a 70 28             	cmp    0x28(%eax),%dh
 a9d:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 aa0:	29 00                	sub    %eax,(%eax)
 aa2:	74 6d                	je     b11 <bootmain-0x27f4ef>
 aa4:	70 5f                	jo     b05 <bootmain-0x27f4fb>
 aa6:	62 75 66             	bound  %esi,0x66(%ebp)
 aa9:	3a 28                	cmp    (%eax),%ch
 aab:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 aae:	30 29                	xor    %ch,(%ecx)
 ab0:	3d 61 72 28 31       	cmp    $0x31287261,%eax
 ab5:	2c 35                	sub    $0x35,%al
 ab7:	29 3b                	sub    %edi,(%ebx)
 ab9:	30 3b                	xor    %bh,(%ebx)
 abb:	32 39                	xor    (%ecx),%bh
 abd:	3b 28                	cmp    (%eax),%ebp
 abf:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 ac2:	29 00                	sub    %eax,(%eax)
 ac4:	73 70                	jae    b36 <bootmain-0x27f4ca>
 ac6:	72 69                	jb     b31 <bootmain-0x27f4cf>
 ac8:	6e                   	outsb  %ds:(%esi),(%dx)
 ac9:	74 66                	je     b31 <bootmain-0x27f4cf>
 acb:	3a 46 28             	cmp    0x28(%esi),%al
 ace:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 ad1:	38 29                	cmp    %ch,(%ecx)
 ad3:	00 73 74             	add    %dh,0x74(%ebx)
 ad6:	72 3a                	jb     b12 <bootmain-0x27f4ee>
 ad8:	70 28                	jo     b02 <bootmain-0x27f4fe>
 ada:	31 2c 37             	xor    %ebp,(%edi,%esi,1)
 add:	29 00                	sub    %eax,(%eax)
 adf:	66 6f                	outsw  %ds:(%esi),(%dx)
 ae1:	72 6d                	jb     b50 <bootmain-0x27f4b0>
 ae3:	61                   	popa   
 ae4:	74 3a                	je     b20 <bootmain-0x27f4e0>
 ae6:	70 28                	jo     b10 <bootmain-0x27f4f0>
 ae8:	31 2c 37             	xor    %ebp,(%edi,%esi,1)
 aeb:	29 00                	sub    %eax,(%eax)
 aed:	76 61                	jbe    b50 <bootmain-0x27f4b0>
 aef:	72 3a                	jb     b2b <bootmain-0x27f4d5>
 af1:	72 28                	jb     b1b <bootmain-0x27f4e5>
 af3:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 af6:	31 29                	xor    %ebp,(%ecx)
 af8:	3d 2a 28 30 2c       	cmp    $0x2c30282a,%eax
 afd:	31 29                	xor    %ebp,(%ecx)
 aff:	00 62 75             	add    %ah,0x75(%edx)
 b02:	66                   	data16
 b03:	66                   	data16
 b04:	65                   	gs
 b05:	72 3a                	jb     b41 <bootmain-0x27f4bf>
 b07:	28 30                	sub    %dh,(%eax)
 b09:	2c 31                	sub    $0x31,%al
 b0b:	39 29                	cmp    %ebp,(%ecx)
 b0d:	00 73 74             	add    %dh,0x74(%ebx)
 b10:	72 3a                	jb     b4c <bootmain-0x27f4b4>
 b12:	72 28                	jb     b3c <bootmain-0x27f4c4>
 b14:	31 2c 37             	xor    %ebp,(%edi,%esi,1)
 b17:	29 00                	sub    %eax,(%eax)
 b19:	70 75                	jo     b90 <bootmain-0x27f470>
 b1b:	74 66                	je     b83 <bootmain-0x27f47d>
 b1d:	6f                   	outsl  %ds:(%esi),(%dx)
 b1e:	6e                   	outsb  %ds:(%esi),(%dx)
 b1f:	74 38                	je     b59 <bootmain-0x27f4a7>
 b21:	3a 46 28             	cmp    0x28(%esi),%al
 b24:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 b27:	38 29                	cmp    %ch,(%ecx)
 b29:	00 78 3a             	add    %bh,0x3a(%eax)
 b2c:	70 28                	jo     b56 <bootmain-0x27f4aa>
 b2e:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 b31:	29 00                	sub    %eax,(%eax)
 b33:	79 3a                	jns    b6f <bootmain-0x27f491>
 b35:	70 28                	jo     b5f <bootmain-0x27f4a1>
 b37:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 b3a:	29 00                	sub    %eax,(%eax)
 b3c:	66 6f                	outsw  %ds:(%esi),(%dx)
 b3e:	6e                   	outsb  %ds:(%esi),(%dx)
 b3f:	74 3a                	je     b7b <bootmain-0x27f485>
 b41:	70 28                	jo     b6b <bootmain-0x27f495>
 b43:	31 2c 37             	xor    %ebp,(%edi,%esi,1)
 b46:	29 00                	sub    %eax,(%eax)
 b48:	72 6f                	jb     bb9 <bootmain-0x27f447>
 b4a:	77 3a                	ja     b86 <bootmain-0x27f47a>
 b4c:	72 28                	jb     b76 <bootmain-0x27f48a>
 b4e:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 b51:	29 00                	sub    %eax,(%eax)
 b53:	63 6f 6c             	arpl   %bp,0x6c(%edi)
 b56:	3a 72 28             	cmp    0x28(%edx),%dh
 b59:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 b5c:	29 00                	sub    %eax,(%eax)
 b5e:	70 75                	jo     bd5 <bootmain-0x27f42b>
 b60:	74 73                	je     bd5 <bootmain-0x27f42b>
 b62:	38 3a                	cmp    %bh,(%edx)
 b64:	46                   	inc    %esi
 b65:	28 30                	sub    %dh,(%eax)
 b67:	2c 31                	sub    $0x31,%al
 b69:	38 29                	cmp    %ch,(%ecx)
 b6b:	00 70 72             	add    %dh,0x72(%eax)
 b6e:	69 6e 74 64 65 62 75 	imul   $0x75626564,0x74(%esi),%ebp
 b75:	67 3a 46 28          	cmp    0x28(%bp),%al
 b79:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 b7c:	38 29                	cmp    %ch,(%ecx)
 b7e:	00 69 3a             	add    %ch,0x3a(%ecx)
 b81:	70 28                	jo     bab <bootmain-0x27f455>
 b83:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 b86:	29 00                	sub    %eax,(%eax)
 b88:	66 6f                	outsw  %ds:(%esi),(%dx)
 b8a:	6e                   	outsb  %ds:(%esi),(%dx)
 b8b:	74 3a                	je     bc7 <bootmain-0x27f439>
 b8d:	28 30                	sub    %dh,(%eax)
 b8f:	2c 32                	sub    $0x32,%al
 b91:	30 29                	xor    %ch,(%ecx)
 b93:	00 70 75             	add    %dh,0x75(%eax)
 b96:	74 66                	je     bfe <bootmain-0x27f402>
 b98:	6f                   	outsl  %ds:(%esi),(%dx)
 b99:	6e                   	outsb  %ds:(%esi),(%dx)
 b9a:	74 31                	je     bcd <bootmain-0x27f433>
 b9c:	36 3a 46 28          	cmp    %ss:0x28(%esi),%al
 ba0:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 ba3:	38 29                	cmp    %ch,(%ecx)
 ba5:	00 66 6f             	add    %ah,0x6f(%esi)
 ba8:	6e                   	outsb  %ds:(%esi),(%dx)
 ba9:	74 3a                	je     be5 <bootmain-0x27f41b>
 bab:	70 28                	jo     bd5 <bootmain-0x27f42b>
 bad:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 bb0:	32 29                	xor    (%ecx),%ch
 bb2:	3d 2a 28 30 2c       	cmp    $0x2c30282a,%eax
 bb7:	39 29                	cmp    %ebp,(%ecx)
 bb9:	00 70 75             	add    %dh,0x75(%eax)
 bbc:	74 73                	je     c31 <bootmain-0x27f3cf>
 bbe:	31 36                	xor    %esi,(%esi)
 bc0:	3a 46 28             	cmp    0x28(%esi),%al
 bc3:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 bc6:	38 29                	cmp    %ch,(%ecx)
 bc8:	00 69 64             	add    %ch,0x64(%ecx)
 bcb:	74 67                	je     c34 <bootmain-0x27f3cc>
 bcd:	64                   	fs
 bce:	74 2e                	je     bfe <bootmain-0x27f402>
 bd0:	63 00                	arpl   %ax,(%eax)
 bd2:	73 65                	jae    c39 <bootmain-0x27f3c7>
 bd4:	74 67                	je     c3d <bootmain-0x27f3c3>
 bd6:	64                   	fs
 bd7:	74 3a                	je     c13 <bootmain-0x27f3ed>
 bd9:	46                   	inc    %esi
 bda:	28 30                	sub    %dh,(%eax)
 bdc:	2c 31                	sub    $0x31,%al
 bde:	38 29                	cmp    %ch,(%ecx)
 be0:	00 73 64             	add    %dh,0x64(%ebx)
 be3:	3a 70 28             	cmp    0x28(%eax),%dh
 be6:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 be9:	39 29                	cmp    %ebp,(%ecx)
 beb:	3d 2a 28 31 2c       	cmp    $0x2c31282a,%eax
 bf0:	38 29                	cmp    %ch,(%ecx)
 bf2:	00 6c 69 6d          	add    %ch,0x6d(%ecx,%ebp,2)
 bf6:	69 74 3a 70 28 30 2c 	imul   $0x342c3028,0x70(%edx,%edi,1),%esi
 bfd:	34 
 bfe:	29 00                	sub    %eax,(%eax)
 c00:	62 61 73             	bound  %esp,0x73(%ecx)
 c03:	65 3a 70 28          	cmp    %gs:0x28(%eax),%dh
 c07:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c0a:	29 00                	sub    %eax,(%eax)
 c0c:	61                   	popa   
 c0d:	63 63 65             	arpl   %sp,0x65(%ebx)
 c10:	73 73                	jae    c85 <bootmain-0x27f37b>
 c12:	3a 70 28             	cmp    0x28(%eax),%dh
 c15:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c18:	29 00                	sub    %eax,(%eax)
 c1a:	73 64                	jae    c80 <bootmain-0x27f380>
 c1c:	3a 72 28             	cmp    0x28(%edx),%dh
 c1f:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c22:	39 29                	cmp    %ebp,(%ecx)
 c24:	00 6c 69 6d          	add    %ch,0x6d(%ecx,%ebp,2)
 c28:	69 74 3a 72 28 30 2c 	imul   $0x342c3028,0x72(%edx,%edi,1),%esi
 c2f:	34 
 c30:	29 00                	sub    %eax,(%eax)
 c32:	62 61 73             	bound  %esp,0x73(%ecx)
 c35:	65 3a 72 28          	cmp    %gs:0x28(%edx),%dh
 c39:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c3c:	29 00                	sub    %eax,(%eax)
 c3e:	61                   	popa   
 c3f:	63 63 65             	arpl   %sp,0x65(%ebx)
 c42:	73 73                	jae    cb7 <bootmain-0x27f349>
 c44:	3a 72 28             	cmp    0x28(%edx),%dh
 c47:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c4a:	29 00                	sub    %eax,(%eax)
 c4c:	73 65                	jae    cb3 <bootmain-0x27f34d>
 c4e:	74 69                	je     cb9 <bootmain-0x27f347>
 c50:	64                   	fs
 c51:	74 3a                	je     c8d <bootmain-0x27f373>
 c53:	46                   	inc    %esi
 c54:	28 30                	sub    %dh,(%eax)
 c56:	2c 31                	sub    $0x31,%al
 c58:	38 29                	cmp    %ch,(%ecx)
 c5a:	00 67 64             	add    %ah,0x64(%edi)
 c5d:	3a 70 28             	cmp    0x28(%eax),%dh
 c60:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 c63:	30 29                	xor    %ch,(%ecx)
 c65:	3d 2a 28 31 2c       	cmp    $0x2c31282a,%eax
 c6a:	39 29                	cmp    %ebp,(%ecx)
 c6c:	00 6f 66             	add    %ch,0x66(%edi)
 c6f:	66                   	data16
 c70:	73 65                	jae    cd7 <bootmain-0x27f329>
 c72:	74 3a                	je     cae <bootmain-0x27f352>
 c74:	70 28                	jo     c9e <bootmain-0x27f362>
 c76:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c79:	29 00                	sub    %eax,(%eax)
 c7b:	73 65                	jae    ce2 <bootmain-0x27f31e>
 c7d:	6c                   	insb   (%dx),%es:(%edi)
 c7e:	65 63 74 6f 72       	arpl   %si,%gs:0x72(%edi,%ebp,2)
 c83:	3a 70 28             	cmp    0x28(%eax),%dh
 c86:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 c89:	29 00                	sub    %eax,(%eax)
 c8b:	67 64 3a 72 28       	cmp    %fs:0x28(%bp,%si),%dh
 c90:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 c93:	30 29                	xor    %ch,(%ecx)
 c95:	00 6f 66             	add    %ch,0x66(%edi)
 c98:	66                   	data16
 c99:	73 65                	jae    d00 <bootmain-0x27f300>
 c9b:	74 3a                	je     cd7 <bootmain-0x27f329>
 c9d:	72 28                	jb     cc7 <bootmain-0x27f339>
 c9f:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 ca2:	29 00                	sub    %eax,(%eax)
 ca4:	73 65                	jae    d0b <bootmain-0x27f2f5>
 ca6:	6c                   	insb   (%dx),%es:(%edi)
 ca7:	65 63 74 6f 72       	arpl   %si,%gs:0x72(%edi,%ebp,2)
 cac:	3a 72 28             	cmp    0x28(%edx),%dh
 caf:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 cb2:	29 00                	sub    %eax,(%eax)
 cb4:	69 6e 69 74 5f 67 64 	imul   $0x64675f74,0x69(%esi),%ebp
 cbb:	74 69                	je     d26 <bootmain-0x27f2da>
 cbd:	64                   	fs
 cbe:	74 3a                	je     cfa <bootmain-0x27f306>
 cc0:	46                   	inc    %esi
 cc1:	28 30                	sub    %dh,(%eax)
 cc3:	2c 31                	sub    $0x31,%al
 cc5:	38 29                	cmp    %ch,(%ecx)
 cc7:	00 69 6e             	add    %ch,0x6e(%ecx)
 cca:	74 2e                	je     cfa <bootmain-0x27f306>
 ccc:	63 00                	arpl   %ax,(%eax)
 cce:	68 65 61 64 65       	push   $0x65646165
 cd3:	72 2e                	jb     d03 <bootmain-0x27f2fd>
 cd5:	68 00 69 6e 69       	push   $0x696e6900
 cda:	74 5f                	je     d3b <bootmain-0x27f2c5>
 cdc:	70 69                	jo     d47 <bootmain-0x27f2b9>
 cde:	63 3a                	arpl   %di,(%edx)
 ce0:	46                   	inc    %esi
 ce1:	28 30                	sub    %dh,(%eax)
 ce3:	2c 31                	sub    $0x31,%al
 ce5:	38 29                	cmp    %ch,(%ecx)
 ce7:	00 69 6e             	add    %ch,0x6e(%ecx)
 cea:	74 68                	je     d54 <bootmain-0x27f2ac>
 cec:	61                   	popa   
 ced:	6e                   	outsb  %ds:(%esi),(%dx)
 cee:	64                   	fs
 cef:	6c                   	insb   (%dx),%es:(%edi)
 cf0:	65                   	gs
 cf1:	72 32                	jb     d25 <bootmain-0x27f2db>
 cf3:	31 3a                	xor    %edi,(%edx)
 cf5:	46                   	inc    %esi
 cf6:	28 30                	sub    %dh,(%eax)
 cf8:	2c 31                	sub    $0x31,%al
 cfa:	38 29                	cmp    %ch,(%ecx)
 cfc:	00 65 73             	add    %ah,0x73(%ebp)
 cff:	70 3a                	jo     d3b <bootmain-0x27f2c5>
 d01:	70 28                	jo     d2b <bootmain-0x27f2d5>
 d03:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 d06:	39 29                	cmp    %ebp,(%ecx)
 d08:	3d 2a 28 30 2c       	cmp    $0x2c30282a,%eax
 d0d:	31 29                	xor    %ebp,(%ecx)
 d0f:	00 69 6e             	add    %ch,0x6e(%ecx)
 d12:	74 68                	je     d7c <bootmain-0x27f284>
 d14:	61                   	popa   
 d15:	6e                   	outsb  %ds:(%esi),(%dx)
 d16:	64                   	fs
 d17:	6c                   	insb   (%dx),%es:(%edi)
 d18:	65                   	gs
 d19:	72 32                	jb     d4d <bootmain-0x27f2b3>
 d1b:	63 3a                	arpl   %di,(%edx)
 d1d:	46                   	inc    %esi
 d1e:	28 30                	sub    %dh,(%eax)
 d20:	2c 31                	sub    $0x31,%al
 d22:	38 29                	cmp    %ch,(%ecx)
 d24:	00 65 73             	add    %ah,0x73(%ebp)
 d27:	70 3a                	jo     d63 <bootmain-0x27f29d>
 d29:	70 28                	jo     d53 <bootmain-0x27f2ad>
 d2b:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 d2e:	39 29                	cmp    %ebp,(%ecx)
 d30:	00 69 6e             	add    %ch,0x6e(%ecx)
 d33:	74 68                	je     d9d <bootmain-0x27f263>
 d35:	61                   	popa   
 d36:	6e                   	outsb  %ds:(%esi),(%dx)
 d37:	64                   	fs
 d38:	6c                   	insb   (%dx),%es:(%edi)
 d39:	65                   	gs
 d3a:	72 32                	jb     d6e <bootmain-0x27f292>
 d3c:	37                   	aaa    
 d3d:	3a 46 28             	cmp    0x28(%esi),%al
 d40:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 d43:	38 29                	cmp    %ch,(%ecx)
 d45:	00 6b 65             	add    %ch,0x65(%ebx)
 d48:	79 66                	jns    db0 <bootmain-0x27f250>
 d4a:	69 66 6f 3a 47 28 31 	imul   $0x3128473a,0x6f(%esi),%esp
 d51:	2c 31                	sub    $0x31,%al
 d53:	29 00                	sub    %eax,(%eax)
 d55:	6d                   	insl   (%dx),%es:(%edi)
 d56:	6f                   	outsl  %ds:(%esi),(%dx)
 d57:	75 73                	jne    dcc <bootmain-0x27f234>
 d59:	65 66 69 66 6f 3a 47 	imul   $0x473a,%gs:0x6f(%esi),%sp
 d60:	28 31                	sub    %dh,(%ecx)
 d62:	2c 31                	sub    $0x31,%al
 d64:	29 00                	sub    %eax,(%eax)
 d66:	2f                   	das    
 d67:	74 6d                	je     dd6 <bootmain-0x27f22a>
 d69:	70 2f                	jo     d9a <bootmain-0x27f266>
 d6b:	63 63 68             	arpl   %sp,0x68(%ebx)
 d6e:	58                   	pop    %eax
 d6f:	71 34                	jno    da5 <bootmain-0x27f25b>
 d71:	57                   	push   %edi
 d72:	66                   	data16
 d73:	2e 73 00             	jae,pn d76 <bootmain-0x27f28a>
 d76:	61                   	popa   
 d77:	73 6d                	jae    de6 <bootmain-0x27f21a>
 d79:	69 6e 74 33 32 2e 53 	imul   $0x532e3233,0x74(%esi),%ebp
 d80:	00 66 69             	add    %ah,0x69(%esi)
 d83:	66 6f                	outsw  %ds:(%esi),(%dx)
 d85:	2e 63 00             	arpl   %ax,%cs:(%eax)
 d88:	66 69 66 6f 38 5f    	imul   $0x5f38,0x6f(%esi),%sp
 d8e:	69 6e 69 74 3a 46 28 	imul   $0x28463a74,0x69(%esi),%ebp
 d95:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 d98:	38 29                	cmp    %ch,(%ecx)
 d9a:	00 66 69             	add    %ah,0x69(%esi)
 d9d:	66 6f                	outsw  %ds:(%esi),(%dx)
 d9f:	3a 70 28             	cmp    0x28(%eax),%dh
 da2:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 da5:	39 29                	cmp    %ebp,(%ecx)
 da7:	3d 2a 28 31 2c       	cmp    $0x2c31282a,%eax
 dac:	31 29                	xor    %ebp,(%ecx)
 dae:	00 73 69             	add    %dh,0x69(%ebx)
 db1:	7a 65                	jp     e18 <bootmain-0x27f1e8>
 db3:	3a 70 28             	cmp    0x28(%eax),%dh
 db6:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 db9:	29 00                	sub    %eax,(%eax)
 dbb:	62 75 66             	bound  %esi,0x66(%ebp)
 dbe:	3a 70 28             	cmp    0x28(%eax),%dh
 dc1:	31 2c 32             	xor    %ebp,(%edx,%esi,1)
 dc4:	29 00                	sub    %eax,(%eax)
 dc6:	66 69 66 6f 3a 72    	imul   $0x723a,0x6f(%esi),%sp
 dcc:	28 30                	sub    %dh,(%eax)
 dce:	2c 31                	sub    $0x31,%al
 dd0:	39 29                	cmp    %ebp,(%ecx)
 dd2:	00 73 69             	add    %dh,0x69(%ebx)
 dd5:	7a 65                	jp     e3c <bootmain-0x27f1c4>
 dd7:	3a 72 28             	cmp    0x28(%edx),%dh
 dda:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 ddd:	29 00                	sub    %eax,(%eax)
 ddf:	62 75 66             	bound  %esi,0x66(%ebp)
 de2:	3a 72 28             	cmp    0x28(%edx),%dh
 de5:	31 2c 32             	xor    %ebp,(%edx,%esi,1)
 de8:	29 00                	sub    %eax,(%eax)
 dea:	66 69 66 6f 38 5f    	imul   $0x5f38,0x6f(%esi),%sp
 df0:	70 75                	jo     e67 <bootmain-0x27f199>
 df2:	74 3a                	je     e2e <bootmain-0x27f1d2>
 df4:	46                   	inc    %esi
 df5:	28 30                	sub    %dh,(%eax)
 df7:	2c 31                	sub    $0x31,%al
 df9:	29 00                	sub    %eax,(%eax)
 dfb:	66 69 66 6f 3a 70    	imul   $0x703a,0x6f(%esi),%sp
 e01:	28 30                	sub    %dh,(%eax)
 e03:	2c 31                	sub    $0x31,%al
 e05:	39 29                	cmp    %ebp,(%ecx)
 e07:	00 64 61 74          	add    %ah,0x74(%ecx,%eiz,2)
 e0b:	61                   	popa   
 e0c:	3a 70 28             	cmp    0x28(%eax),%dh
 e0f:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 e12:	29 00                	sub    %eax,(%eax)
 e14:	66 69 66 6f 38 5f    	imul   $0x5f38,0x6f(%esi),%sp
 e1a:	67                   	addr16
 e1b:	65                   	gs
 e1c:	74 3a                	je     e58 <bootmain-0x27f1a8>
 e1e:	46                   	inc    %esi
 e1f:	28 30                	sub    %dh,(%eax)
 e21:	2c 31                	sub    $0x31,%al
 e23:	29 00                	sub    %eax,(%eax)
 e25:	64                   	fs
 e26:	61                   	popa   
 e27:	74 61                	je     e8a <bootmain-0x27f176>
 e29:	3a 72 28             	cmp    0x28(%edx),%dh
 e2c:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 e2f:	29 00                	sub    %eax,(%eax)
 e31:	66 69 66 6f 38 5f    	imul   $0x5f38,0x6f(%esi),%sp
 e37:	73 74                	jae    ead <bootmain-0x27f153>
 e39:	61                   	popa   
 e3a:	74 75                	je     eb1 <bootmain-0x27f14f>
 e3c:	73 3a                	jae    e78 <bootmain-0x27f188>
 e3e:	46                   	inc    %esi
 e3f:	28 30                	sub    %dh,(%eax)
 e41:	2c 31                	sub    $0x31,%al
 e43:	29 00                	sub    %eax,(%eax)
 e45:	6d                   	insl   (%dx),%es:(%edi)
 e46:	6f                   	outsl  %ds:(%esi),(%dx)
 e47:	75 73                	jne    ebc <bootmain-0x27f144>
 e49:	65 2e 63 00          	gs arpl %ax,%cs:%gs:(%eax)
 e4d:	65 6e                	outsb  %gs:(%esi),(%dx)
 e4f:	61                   	popa   
 e50:	62 6c 65 5f          	bound  %ebp,0x5f(%ebp,%eiz,2)
 e54:	6d                   	insl   (%dx),%es:(%edi)
 e55:	6f                   	outsl  %ds:(%esi),(%dx)
 e56:	75 73                	jne    ecb <bootmain-0x27f135>
 e58:	65 3a 46 28          	cmp    %gs:0x28(%esi),%al
 e5c:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 e5f:	38 29                	cmp    %ch,(%ecx)
 e61:	00 62 6f             	add    %ah,0x6f(%edx)
 e64:	6f                   	outsl  %ds:(%esi),(%dx)
 e65:	74 70                	je     ed7 <bootmain-0x27f129>
 e67:	3a 70 28             	cmp    0x28(%eax),%dh
 e6a:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 e6d:	39 29                	cmp    %ebp,(%ecx)
 e6f:	3d 2a 28 31 2c       	cmp    $0x2c31282a,%eax
 e74:	36 29 00             	sub    %eax,%ss:(%eax)
 e77:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 e7a:	74 70                	je     eec <bootmain-0x27f114>
 e7c:	3a 72 28             	cmp    0x28(%edx),%dh
 e7f:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 e82:	39 29                	cmp    %ebp,(%ecx)
 e84:	00 6d 6f             	add    %ch,0x6f(%ebp)
 e87:	75 73                	jne    efc <bootmain-0x27f104>
 e89:	65                   	gs
 e8a:	5f                   	pop    %edi
 e8b:	6d                   	insl   (%dx),%es:(%edi)
 e8c:	6f                   	outsl  %ds:(%esi),(%dx)
 e8d:	76 65                	jbe    ef4 <bootmain-0x27f10c>
 e8f:	3a 46 28             	cmp    0x28(%esi),%al
 e92:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 e95:	38 29                	cmp    %ch,(%ecx)
 e97:	00 62 6f             	add    %ah,0x6f(%edx)
 e9a:	6f                   	outsl  %ds:(%esi),(%dx)
 e9b:	74 70                	je     f0d <bootmain-0x27f0f3>
 e9d:	3a 70 28             	cmp    0x28(%eax),%dh
 ea0:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 ea3:	39 29                	cmp    %ebp,(%ecx)
 ea5:	00 67 6c             	add    %ah,0x6c(%edi)
 ea8:	6f                   	outsl  %ds:(%esi),(%dx)
 ea9:	62 3a                	bound  %edi,(%edx)
 eab:	47                   	inc    %edi
 eac:	28 31                	sub    %dh,(%ecx)
 eae:	2c 33                	sub    $0x33,%al
 eb0:	29 00                	sub    %eax,(%eax)
 eb2:	6d                   	insl   (%dx),%es:(%edi)
 eb3:	6f                   	outsl  %ds:(%esi),(%dx)
 eb4:	75 73                	jne    f29 <bootmain-0x27f0d7>
 eb6:	65                   	gs
 eb7:	70 69                	jo     f22 <bootmain-0x27f0de>
 eb9:	63 3a                	arpl   %di,(%edx)
 ebb:	47                   	inc    %edi
 ebc:	28 30                	sub    %dh,(%eax)
 ebe:	2c 32                	sub    $0x32,%al
 ec0:	30 29                	xor    %ch,(%ecx)
 ec2:	3d 61 72 28 31       	cmp    $0x31287261,%eax
 ec7:	2c 35                	sub    $0x35,%al
 ec9:	29 3b                	sub    %edi,(%ebx)
 ecb:	30 3b                	xor    %bh,(%ebx)
 ecd:	32 35 35 3b 28 30    	xor    0x30283b35,%dh
 ed3:	2c 31                	sub    $0x31,%al
 ed5:	31 29                	xor    %ebp,(%ecx)
 ed7:	00 6b 65             	add    %ch,0x65(%ebx)
 eda:	79 62                	jns    f3e <bootmain-0x27f0c2>
 edc:	6f                   	outsl  %ds:(%esi),(%dx)
 edd:	61                   	popa   
 ede:	72 64                	jb     f44 <bootmain-0x27f0bc>
 ee0:	2e 63 00             	arpl   %ax,%cs:(%eax)
 ee3:	77 61                	ja     f46 <bootmain-0x27f0ba>
 ee5:	69 74 5f 4b 42 43 5f 	imul   $0x735f4342,0x4b(%edi,%ebx,2),%esi
 eec:	73 
 eed:	65 6e                	outsb  %gs:(%esi),(%dx)
 eef:	64                   	fs
 ef0:	72 65                	jb     f57 <bootmain-0x27f0a9>
 ef2:	61                   	popa   
 ef3:	64                   	fs
 ef4:	79 3a                	jns    f30 <bootmain-0x27f0d0>
 ef6:	46                   	inc    %esi
 ef7:	28 30                	sub    %dh,(%eax)
 ef9:	2c 31                	sub    $0x31,%al
 efb:	38 29                	cmp    %ch,(%ecx)
 efd:	00 69 6e             	add    %ch,0x6e(%ecx)
 f00:	69 74 5f 6b 65 79 62 	imul   $0x6f627965,0x6b(%edi,%ebx,2),%esi
 f07:	6f 
 f08:	61                   	popa   
 f09:	72 64                	jb     f6f <bootmain-0x27f091>
 f0b:	3a 46 28             	cmp    0x28(%esi),%al
 f0e:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 f11:	38 29                	cmp    %ch,(%ecx)
 f13:	00 6d 65             	add    %ch,0x65(%ebp)
 f16:	6d                   	insl   (%dx),%es:(%edi)
 f17:	2e 63 00             	arpl   %ax,%cs:(%eax)
 f1a:	6d                   	insl   (%dx),%es:(%edi)
 f1b:	65                   	gs
 f1c:	6d                   	insl   (%dx),%es:(%edi)
 f1d:	74 65                	je     f84 <bootmain-0x27f07c>
 f1f:	73 74                	jae    f95 <bootmain-0x27f06b>
 f21:	5f                   	pop    %edi
 f22:	73 75                	jae    f99 <bootmain-0x27f067>
 f24:	62 3a                	bound  %edi,(%edx)
 f26:	46                   	inc    %esi
 f27:	28 30                	sub    %dh,(%eax)
 f29:	2c 34                	sub    $0x34,%al
 f2b:	29 00                	sub    %eax,(%eax)
 f2d:	73 74                	jae    fa3 <bootmain-0x27f05d>
 f2f:	61                   	popa   
 f30:	72 74                	jb     fa6 <bootmain-0x27f05a>
 f32:	3a 70 28             	cmp    0x28(%eax),%dh
 f35:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 f38:	29 00                	sub    %eax,(%eax)
 f3a:	65 6e                	outsb  %gs:(%esi),(%dx)
 f3c:	64 3a 70 28          	cmp    %fs:0x28(%eax),%dh
 f40:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 f43:	29 00                	sub    %eax,(%eax)
 f45:	6f                   	outsl  %ds:(%esi),(%dx)
 f46:	6c                   	insb   (%dx),%es:(%edi)
 f47:	64 3a 72 28          	cmp    %fs:0x28(%edx),%dh
 f4b:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 f4e:	29 00                	sub    %eax,(%eax)
 f50:	73 74                	jae    fc6 <bootmain-0x27f03a>
 f52:	61                   	popa   
 f53:	72 74                	jb     fc9 <bootmain-0x27f037>
 f55:	3a 72 28             	cmp    0x28(%edx),%dh
 f58:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 f5b:	29 00                	sub    %eax,(%eax)
 f5d:	6d                   	insl   (%dx),%es:(%edi)
 f5e:	65                   	gs
 f5f:	6d                   	insl   (%dx),%es:(%edi)
 f60:	74 65                	je     fc7 <bootmain-0x27f039>
 f62:	73 74                	jae    fd8 <bootmain-0x27f028>
 f64:	3a 46 28             	cmp    0x28(%esi),%al
 f67:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 f6a:	29 00                	sub    %eax,(%eax)
 f6c:	72 65                	jb     fd3 <bootmain-0x27f02d>
 f6e:	74 3a                	je     faa <bootmain-0x27f056>
 f70:	72 28                	jb     f9a <bootmain-0x27f066>
 f72:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 f75:	29 00                	sub    %eax,(%eax)
 f77:	65 6e                	outsb  %gs:(%esi),(%dx)
 f79:	64 3a 72 28          	cmp    %fs:0x28(%edx),%dh
 f7d:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 f80:	29 00                	sub    %eax,(%eax)
 f82:	68 65 68 65 3a       	push   $0x3a656865
 f87:	47                   	inc    %edi
 f88:	28 30                	sub    %dh,(%eax)
 f8a:	2c 34                	sub    $0x34,%al
 f8c:	29 00                	sub    %eax,(%eax)
 f8e:	68 65 69 68 65       	push   $0x65686965
 f93:	69 3a 47 28 30 2c    	imul   $0x2c302847,(%edx),%edi
 f99:	34 29                	xor    $0x29,%al
	...
