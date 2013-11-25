
mem.o：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <memtest_sub>:
#include <header.h>
#define EFLAGS_AC_BIT		0x00040000
#define CR0_CACHE_DISABLE	0x60000000

unsigned int hehe,heihei;
unsigned int memtest_sub(unsigned int start, unsigned int end){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	8b 45 08             	mov    0x8(%ebp),%eax
	unsigned int i,*p,old,pat0 = 0xaa55aa55,pat1 = 0x55aa55aa;
	for (i = start;i<=end; i+=4){
   6:	3b 45 0c             	cmp    0xc(%ebp),%eax
   9:	77 21                	ja     2c <memtest_sub+0x2c>
		p = (unsigned int *) i;
		old = *p;
   b:	8b 10                	mov    (%eax),%edx
		*p = pat0;
		*p ^= 0xffffffff;
   d:	c7 00 aa 55 aa 55    	movl   $0x55aa55aa,(%eax)
		hehe = *p;
  13:	c7 05 00 00 00 00 aa 	movl   $0x55aa55aa,0x0
  1a:	55 aa 55 
		if (*p != pat1){
  1d:	81 38 aa 55 aa 55    	cmpl   $0x55aa55aa,(%eax)
			*p = old;
  23:	89 10                	mov    %edx,(%eax)
		p = (unsigned int *) i;
		old = *p;
		*p = pat0;
		*p ^= 0xffffffff;
		hehe = *p;
		if (*p != pat1){
  25:	75 07                	jne    2e <memtest_sub+0x2e>
#define CR0_CACHE_DISABLE	0x60000000

unsigned int hehe,heihei;
unsigned int memtest_sub(unsigned int start, unsigned int end){
	unsigned int i,*p,old,pat0 = 0xaa55aa55,pat1 = 0x55aa55aa;
	for (i = start;i<=end; i+=4){
  27:	83 c0 04             	add    $0x4,%eax
  2a:	eb da                	jmp    6 <memtest_sub+0x6>
			*p = old;
			return i;
		}
		*p = old;
	}
	return 0;
  2c:	31 c0                	xor    %eax,%eax
}
  2e:	5d                   	pop    %ebp
  2f:	c3                   	ret    

00000030 <memtest>:

unsigned int memtest(unsigned int start,unsigned int end){
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	56                   	push   %esi
  34:	8b 75 0c             	mov    0xc(%ebp),%esi
  37:	53                   	push   %ebx
//read eflags and write_eflags
static __inline uint32_t
read_eflags(void)
{
        uint32_t eflags;
        __asm __volatile("pushfl; popl %0" : "=r" (eflags));
  38:	9c                   	pushf  
  39:	58                   	pop    %eax
	char flg486 = 0;
	unsigned int eflg,cr0,i;
	eflg = read_eflags();
	eflg |= EFLAGS_AC_BIT;
  3a:	0d 00 00 04 00       	or     $0x40000,%eax
}

static __inline void
write_eflags(uint32_t eflags)
{
        __asm __volatile("pushl %0; popfl" : : "r" (eflags));
  3f:	50                   	push   %eax
  40:	9d                   	popf   
//read eflags and write_eflags
static __inline uint32_t
read_eflags(void)
{
        uint32_t eflags;
        __asm __volatile("pushfl; popl %0" : "=r" (eflags));
  41:	9c                   	pushf  
  42:	58                   	pop    %eax
	write_eflags(eflg);
	eflg = read_eflags();
	if ((eflg & EFLAGS_AC_BIT) != 0){
  43:	89 c1                	mov    %eax,%ecx
		flg486 = 1;
	}
	eflg &= ~EFLAGS_AC_BIT;
  45:	25 ff ff fb ff       	and    $0xfffbffff,%eax
	unsigned int eflg,cr0,i;
	eflg = read_eflags();
	eflg |= EFLAGS_AC_BIT;
	write_eflags(eflg);
	eflg = read_eflags();
	if ((eflg & EFLAGS_AC_BIT) != 0){
  4a:	c1 e9 12             	shr    $0x12,%ecx
  4d:	88 cb                	mov    %cl,%bl
  4f:	83 e3 01             	and    $0x1,%ebx
}

static __inline void
write_eflags(uint32_t eflags)
{
        __asm __volatile("pushl %0; popfl" : : "r" (eflags));
  52:	50                   	push   %eax
  53:	9d                   	popf   
		flg486 = 1;
	}
	eflg &= ~EFLAGS_AC_BIT;
	write_eflags(eflg);
	if (flg486 != 0){
  54:	84 db                	test   %bl,%bl
  56:	74 0c                	je     64 <memtest+0x34>

static __inline uint32_t
rcr0(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr0,%0" : "=r" (val));
  58:	0f 20 c2             	mov    %cr0,%edx
		cr0 = rcr0();
		cr0 |= CR0_CACHE_DISABLE;
  5b:	81 ca 00 00 00 60    	or     $0x60000000,%edx
}

static __inline void
lcr0(uint32_t val)
{
	__asm __volatile("movl %0,%%cr0" : : "r" (val));
  61:	0f 22 c2             	mov    %edx,%cr0
		lcr0(cr0);
	}

	unsigned int ret = memtest_sub(start,end);
  64:	56                   	push   %esi
  65:	ff 75 08             	pushl  0x8(%ebp)
  68:	e8 fc ff ff ff       	call   69 <memtest+0x39>
	
	if (flg486 != 0){
  6d:	84 db                	test   %bl,%bl
  6f:	5a                   	pop    %edx
  70:	59                   	pop    %ecx
  71:	74 0c                	je     7f <memtest+0x4f>

static __inline uint32_t
rcr0(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr0,%0" : "=r" (val));
  73:	0f 20 c2             	mov    %cr0,%edx
		cr0 = rcr0();
		cr0 &= CR0_CACHE_DISABLE;
  76:	81 e2 00 00 00 60    	and    $0x60000000,%edx
}

static __inline void
lcr0(uint32_t val)
{
	__asm __volatile("movl %0,%%cr0" : : "r" (val));
  7c:	0f 22 c2             	mov    %edx,%cr0
		lcr0(cr0);
	}
	if (ret==0) return end;
	else return ret -4;
  7f:	85 c0                	test   %eax,%eax
  81:	8d 50 fc             	lea    -0x4(%eax),%edx
  84:	89 f0                	mov    %esi,%eax
  86:	0f 45 c2             	cmovne %edx,%eax
}
  89:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8c:	5b                   	pop    %ebx
  8d:	5e                   	pop    %esi
  8e:	5d                   	pop    %ebp
  8f:	c3                   	ret    

Disassembly of section .stab:

00000000 <.stab>:
#include <header.h>
#define EFLAGS_AC_BIT		0x00040000
#define CR0_CACHE_DISABLE	0x60000000

unsigned int hehe,heihei;
unsigned int memtest_sub(unsigned int start, unsigned int end){
   0:	01 00                	add    %eax,(%eax)
   2:	00 00                	add    %al,(%eax)
   4:	00 00                	add    %al,(%eax)
	unsigned int i,*p,old,pat0 = 0xaa55aa55,pat1 = 0x55aa55aa;
	for (i = start;i<=end; i+=4){
   6:	6c                   	insb   (%dx),%es:(%edi)
   7:	00 b5 07 00 00 07    	add    %dh,0x7000007(%ebp)
		p = (unsigned int *) i;
		old = *p;
		*p = pat0;
		*p ^= 0xffffffff;
   d:	00 00                	add    %al,(%eax)
   f:	00 64 00 02          	add    %ah,0x2(%eax,%eax,1)
		hehe = *p;
  13:	00 00                	add    %al,(%eax)
  15:	00 00                	add    %al,(%eax)
  17:	00 0d 00 00 00 3c    	add    %cl,0x3c000000
		if (*p != pat1){
  1d:	00 00                	add    %al,(%eax)
  1f:	00 00                	add    %al,(%eax)
  21:	00 00                	add    %al,(%eax)
			*p = old;
  23:	00 1c 00             	add    %bl,(%eax,%eax,1)
		p = (unsigned int *) i;
		old = *p;
		*p = pat0;
		*p ^= 0xffffffff;
		hehe = *p;
		if (*p != pat1){
  26:	00 00                	add    %al,(%eax)
#define CR0_CACHE_DISABLE	0x60000000

unsigned int hehe,heihei;
unsigned int memtest_sub(unsigned int start, unsigned int end){
	unsigned int i,*p,old,pat0 = 0xaa55aa55,pat1 = 0x55aa55aa;
	for (i = start;i<=end; i+=4){
  28:	80 00 00             	addb   $0x0,(%eax)
  2b:	00 00                	add    %al,(%eax)
			*p = old;
			return i;
		}
		*p = old;
	}
	return 0;
  2d:	00 00                	add    %al,(%eax)
}
  2f:	00 46 00             	add    %al,0x0(%esi)

unsigned int memtest(unsigned int start,unsigned int end){
  32:	00 00                	add    %al,(%eax)
  34:	80 00 00             	addb   $0x0,(%eax)
  37:	00 00                	add    %al,(%eax)
//read eflags and write_eflags
static __inline uint32_t
read_eflags(void)
{
        uint32_t eflags;
        __asm __volatile("pushfl; popl %0" : "=r" (eflags));
  39:	00 00                	add    %al,(%eax)
	char flg486 = 0;
	unsigned int eflg,cr0,i;
	eflg = read_eflags();
	eflg |= EFLAGS_AC_BIT;
  3b:	00 60 00             	add    %ah,0x0(%eax)
  3e:	00 00                	add    %al,(%eax)
}

static __inline void
write_eflags(uint32_t eflags)
{
        __asm __volatile("pushl %0; popfl" : : "r" (eflags));
  40:	80 00 00             	addb   $0x0,(%eax)
	write_eflags(eflg);
	eflg = read_eflags();
	if ((eflg & EFLAGS_AC_BIT) != 0){
  43:	00 00                	add    %al,(%eax)
		flg486 = 1;
	}
	eflg &= ~EFLAGS_AC_BIT;
  45:	00 00                	add    %al,(%eax)
  47:	00 8f 00 00 00 80    	add    %cl,-0x80000000(%edi)
	unsigned int eflg,cr0,i;
	eflg = read_eflags();
	eflg |= EFLAGS_AC_BIT;
	write_eflags(eflg);
	eflg = read_eflags();
	if ((eflg & EFLAGS_AC_BIT) != 0){
  4d:	00 00                	add    %al,(%eax)
  4f:	00 00                	add    %al,(%eax)
  51:	00 00                	add    %al,(%eax)
  53:	00 b8 00 00 00 80    	add    %bh,-0x80000000(%eax)

static __inline uint32_t
rcr0(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr0,%0" : "=r" (val));
  59:	00 00                	add    %al,(%eax)
	}
	eflg &= ~EFLAGS_AC_BIT;
	write_eflags(eflg);
	if (flg486 != 0){
		cr0 = rcr0();
		cr0 |= CR0_CACHE_DISABLE;
  5b:	00 00                	add    %al,(%eax)
  5d:	00 00                	add    %al,(%eax)
  5f:	00 e6                	add    %ah,%dh
}

static __inline void
lcr0(uint32_t val)
{
	__asm __volatile("movl %0,%%cr0" : : "r" (val));
  61:	00 00                	add    %al,(%eax)
  63:	00 80 00 00 00 00    	add    %al,0x0(%eax)
		lcr0(cr0);
	}

	unsigned int ret = memtest_sub(start,end);
  69:	00 00                	add    %al,(%eax)
  6b:	00 11                	add    %dl,(%ecx)
	
	if (flg486 != 0){
  6d:	01 00                	add    %eax,(%eax)
  6f:	00 80 00 00 00 00    	add    %al,0x0(%eax)

static __inline uint32_t
rcr0(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr0,%0" : "=r" (val));
  75:	00 00                	add    %al,(%eax)
		cr0 = rcr0();
		cr0 &= CR0_CACHE_DISABLE;
  77:	00 3c 01             	add    %bh,(%ecx,%eax,1)
  7a:	00 00                	add    %al,(%eax)
}

static __inline void
lcr0(uint32_t val)
{
	__asm __volatile("movl %0,%%cr0" : : "r" (val));
  7c:	80 00 00             	addb   $0x0,(%eax)
		lcr0(cr0);
	}
	if (ret==0) return end;
	else return ret -4;
  7f:	00 00                	add    %al,(%eax)
  81:	00 00                	add    %al,(%eax)
  83:	00 62 01             	add    %ah,0x1(%edx)
  86:	00 00                	add    %al,(%eax)
  88:	80 00 00             	addb   $0x0,(%eax)
}
  8b:	00 00                	add    %al,(%eax)
  8d:	00 00                	add    %al,(%eax)
  8f:	00 8c 01 00 00 80 00 	add    %cl,0x800000(%ecx,%eax,1)
  96:	00 00                	add    %al,(%eax)
  98:	00 00                	add    %al,(%eax)
  9a:	00 00                	add    %al,(%eax)
  9c:	b2 01                	mov    $0x1,%dl
  9e:	00 00                	add    %al,(%eax)
  a0:	80 00 00             	addb   $0x0,(%eax)
  a3:	00 00                	add    %al,(%eax)
  a5:	00 00                	add    %al,(%eax)
  a7:	00 d7                	add    %dl,%bh
  a9:	01 00                	add    %eax,(%eax)
  ab:	00 80 00 00 00 00    	add    %al,0x0(%eax)
  b1:	00 00                	add    %al,(%eax)
  b3:	00 f1                	add    %dh,%cl
  b5:	01 00                	add    %eax,(%eax)
  b7:	00 80 00 00 00 00    	add    %al,0x0(%eax)
  bd:	00 00                	add    %al,(%eax)
  bf:	00 0c 02             	add    %cl,(%edx,%eax,1)
  c2:	00 00                	add    %al,(%eax)
  c4:	80 00 00             	addb   $0x0,(%eax)
  c7:	00 00                	add    %al,(%eax)
  c9:	00 00                	add    %al,(%eax)
  cb:	00 2d 02 00 00 80    	add    %ch,0x80000002
  d1:	00 00                	add    %al,(%eax)
  d3:	00 00                	add    %al,(%eax)
  d5:	00 00                	add    %al,(%eax)
  d7:	00 4c 02 00          	add    %cl,0x0(%edx,%eax,1)
  db:	00 80 00 00 00 00    	add    %al,0x0(%eax)
  e1:	00 00                	add    %al,(%eax)
  e3:	00 6b 02             	add    %ch,0x2(%ebx)
  e6:	00 00                	add    %al,(%eax)
  e8:	80 00 00             	addb   $0x0,(%eax)
  eb:	00 00                	add    %al,(%eax)
  ed:	00 00                	add    %al,(%eax)
  ef:	00 8c 02 00 00 80 00 	add    %cl,0x800000(%edx,%eax,1)
  f6:	00 00                	add    %al,(%eax)
  f8:	00 00                	add    %al,(%eax)
  fa:	00 00                	add    %al,(%eax)
  fc:	a0 02 00 00 82       	mov    0x82000002,%al
 101:	00 00                	add    %al,(%eax)
 103:	00 00                	add    %al,(%eax)
 105:	00 00                	add    %al,(%eax)
 107:	00 ab 02 00 00 82    	add    %ch,-0x7dfffffe(%ebx)
 10d:	00 00                	add    %al,(%eax)
 10f:	00 00                	add    %al,(%eax)
 111:	00 00                	add    %al,(%eax)
 113:	00 b3 02 00 00 82    	add    %dh,-0x7dfffffe(%ebx)
 119:	00 00                	add    %al,(%eax)
 11b:	00 00                	add    %al,(%eax)
 11d:	00 00                	add    %al,(%eax)
 11f:	00 bd 02 00 00 80    	add    %bh,-0x7ffffffe(%ebp)
 125:	00 00                	add    %al,(%eax)
 127:	00 00                	add    %al,(%eax)
 129:	00 00                	add    %al,(%eax)
 12b:	00 cf                	add    %cl,%bh
 12d:	02 00                	add    (%eax),%al
 12f:	00 80 00 00 00 00    	add    %al,0x0(%eax)
 135:	00 00                	add    %al,(%eax)
 137:	00 e4                	add    %ah,%ah
 139:	02 00                	add    (%eax),%al
 13b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
 141:	00 00                	add    %al,(%eax)
 143:	00 fa                	add    %bh,%dl
 145:	02 00                	add    (%eax),%al
 147:	00 80 00 00 00 00    	add    %al,0x0(%eax)
 14d:	00 00                	add    %al,(%eax)
 14f:	00 0f                	add    %cl,(%edi)
 151:	03 00                	add    (%eax),%eax
 153:	00 80 00 00 00 00    	add    %al,0x0(%eax)
 159:	00 00                	add    %al,(%eax)
 15b:	00 25 03 00 00 80    	add    %ah,0x80000003
 161:	00 00                	add    %al,(%eax)
 163:	00 00                	add    %al,(%eax)
 165:	00 00                	add    %al,(%eax)
 167:	00 3a                	add    %bh,(%edx)
 169:	03 00                	add    (%eax),%eax
 16b:	00 80 00 00 00 00    	add    %al,0x0(%eax)
 171:	00 00                	add    %al,(%eax)
 173:	00 50 03             	add    %dl,0x3(%eax)
 176:	00 00                	add    %al,(%eax)
 178:	80 00 00             	addb   $0x0,(%eax)
 17b:	00 00                	add    %al,(%eax)
 17d:	00 00                	add    %al,(%eax)
 17f:	00 65 03             	add    %ah,0x3(%ebp)
 182:	00 00                	add    %al,(%eax)
 184:	80 00 00             	addb   $0x0,(%eax)
 187:	00 00                	add    %al,(%eax)
 189:	00 00                	add    %al,(%eax)
 18b:	00 7b 03             	add    %bh,0x3(%ebx)
 18e:	00 00                	add    %al,(%eax)
 190:	80 00 00             	addb   $0x0,(%eax)
 193:	00 00                	add    %al,(%eax)
 195:	00 00                	add    %al,(%eax)
 197:	00 92 03 00 00 80    	add    %dl,-0x7ffffffd(%edx)
 19d:	00 00                	add    %al,(%eax)
 19f:	00 00                	add    %al,(%eax)
 1a1:	00 00                	add    %al,(%eax)
 1a3:	00 aa 03 00 00 80    	add    %ch,-0x7ffffffd(%edx)
 1a9:	00 00                	add    %al,(%eax)
 1ab:	00 00                	add    %al,(%eax)
 1ad:	00 00                	add    %al,(%eax)
 1af:	00 c3                	add    %al,%bl
 1b1:	03 00                	add    (%eax),%eax
 1b3:	00 80 00 00 00 00    	add    %al,0x0(%eax)
 1b9:	00 00                	add    %al,(%eax)
 1bb:	00 d7                	add    %dl,%bh
 1bd:	03 00                	add    (%eax),%eax
 1bf:	00 80 00 00 00 00    	add    %al,0x0(%eax)
 1c5:	00 00                	add    %al,(%eax)
 1c7:	00 ec                	add    %ch,%ah
 1c9:	03 00                	add    (%eax),%eax
 1cb:	00 80 00 00 00 00    	add    %al,0x0(%eax)
 1d1:	00 00                	add    %al,(%eax)
 1d3:	00 02                	add    %al,(%edx)
 1d5:	04 00                	add    $0x0,%al
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
 1f7:	00 16                	add    %dl,(%esi)
 1f9:	04 00                	add    $0x0,%al
 1fb:	00 80 00 00 00 00    	add    %al,0x0(%eax)
 201:	00 00                	add    %al,(%eax)
 203:	00 91 04 00 00 80    	add    %dl,-0x7ffffffc(%ecx)
 209:	00 00                	add    %al,(%eax)
 20b:	00 00                	add    %al,(%eax)
 20d:	00 00                	add    %al,(%eax)
 20f:	00 1c 05 00 00 80 00 	add    %bl,0x800000(,%eax,1)
 216:	00 00                	add    %al,(%eax)
 218:	00 00                	add    %al,(%eax)
 21a:	00 00                	add    %al,(%eax)
 21c:	b9 05 00 00 80       	mov    $0x80000005,%ecx
 221:	00 00                	add    %al,(%eax)
 223:	00 00                	add    %al,(%eax)
 225:	00 00                	add    %al,(%eax)
 227:	00 49 06             	add    %cl,0x6(%ecx)
 22a:	00 00                	add    %al,(%eax)
 22c:	80 00 00             	addb   $0x0,(%eax)
	...
 237:	00 a2 00 00 00 00    	add    %ah,0x0(%edx)
 23d:	00 00                	add    %al,(%eax)
 23f:	00 c7                	add    %al,%bh
 241:	06                   	push   %es
 242:	00 00                	add    %al,(%eax)
 244:	24 00                	and    $0x0,%al
 246:	00 00                	add    %al,(%eax)
 248:	00 00                	add    %al,(%eax)
 24a:	00 00                	add    %al,(%eax)
 24c:	da 06                	fiaddl (%esi)
 24e:	00 00                	add    %al,(%eax)
 250:	a0 00 00 00 08       	mov    0x8000000,%al
 255:	00 00                	add    %al,(%eax)
 257:	00 e7                	add    %ah,%bh
 259:	06                   	push   %es
 25a:	00 00                	add    %al,(%eax)
 25c:	a0 00 00 00 0c       	mov    0xc000000,%al
 261:	00 00                	add    %al,(%eax)
 263:	00 00                	add    %al,(%eax)
 265:	00 00                	add    %al,(%eax)
 267:	00 44 00 06          	add    %al,0x6(%eax,%eax,1)
	...
 273:	00 44 00 08          	add    %al,0x8(%eax,%eax,1)
 277:	00 06                	add    %al,(%esi)
 279:	00 00                	add    %al,(%eax)
 27b:	00 00                	add    %al,(%eax)
 27d:	00 00                	add    %al,(%eax)
 27f:	00 44 00 0a          	add    %al,0xa(%eax,%eax,1)
 283:	00 0b                	add    %cl,(%ebx)
 285:	00 00                	add    %al,(%eax)
 287:	00 00                	add    %al,(%eax)
 289:	00 00                	add    %al,(%eax)
 28b:	00 44 00 0c          	add    %al,0xc(%eax,%eax,1)
 28f:	00 0d 00 00 00 00    	add    %cl,0x0
 295:	00 00                	add    %al,(%eax)
 297:	00 44 00 0d          	add    %al,0xd(%eax,%eax,1)
 29b:	00 13                	add    %dl,(%ebx)
 29d:	00 00                	add    %al,(%eax)
 29f:	00 00                	add    %al,(%eax)
 2a1:	00 00                	add    %al,(%eax)
 2a3:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
 2a7:	00 1d 00 00 00 00    	add    %bl,0x0
 2ad:	00 00                	add    %al,(%eax)
 2af:	00 44 00 0f          	add    %al,0xf(%eax,%eax,1)
 2b3:	00 23                	add    %ah,(%ebx)
 2b5:	00 00                	add    %al,(%eax)
 2b7:	00 00                	add    %al,(%eax)
 2b9:	00 00                	add    %al,(%eax)
 2bb:	00 44 00 0e          	add    %al,0xe(%eax,%eax,1)
 2bf:	00 25 00 00 00 00    	add    %ah,0x0
 2c5:	00 00                	add    %al,(%eax)
 2c7:	00 44 00 08          	add    %al,0x8(%eax,%eax,1)
 2cb:	00 27                	add    %ah,(%edi)
 2cd:	00 00                	add    %al,(%eax)
 2cf:	00 00                	add    %al,(%eax)
 2d1:	00 00                	add    %al,(%eax)
 2d3:	00 44 00 1a          	add    %al,0x1a(%eax,%eax,1)
 2d7:	00 2c 00             	add    %ch,(%eax,%eax,1)
 2da:	00 00                	add    %al,(%eax)
 2dc:	00 00                	add    %al,(%eax)
 2de:	00 00                	add    %al,(%eax)
 2e0:	44                   	inc    %esp
 2e1:	00 1b                	add    %bl,(%ebx)
 2e3:	00 2e                	add    %ch,(%esi)
 2e5:	00 00                	add    %al,(%eax)
 2e7:	00 f2                	add    %dh,%dl
 2e9:	06                   	push   %es
 2ea:	00 00                	add    %al,(%eax)
 2ec:	40                   	inc    %eax
 2ed:	00 00                	add    %al,(%eax)
 2ef:	00 02                	add    %al,(%edx)
 2f1:	00 00                	add    %al,(%eax)
 2f3:	00 fd                	add    %bh,%ch
 2f5:	06                   	push   %es
 2f6:	00 00                	add    %al,(%eax)
 2f8:	40                   	inc    %eax
	...
 301:	00 00                	add    %al,(%eax)
 303:	00 c0                	add    %al,%al
	...
 30d:	00 00                	add    %al,(%eax)
 30f:	00 e0                	add    %ah,%al
 311:	00 00                	add    %al,(%eax)
 313:	00 30                	add    %dh,(%eax)
 315:	00 00                	add    %al,(%eax)
 317:	00 0a                	add    %cl,(%edx)
 319:	07                   	pop    %es
 31a:	00 00                	add    %al,(%eax)
 31c:	24 00                	and    $0x0,%al
 31e:	00 00                	add    %al,(%eax)
 320:	00 00                	add    %al,(%eax)
 322:	00 00                	add    %al,(%eax)
 324:	19 07                	sbb    %eax,(%edi)
 326:	00 00                	add    %al,(%eax)
 328:	a0 00 00 00 08       	mov    0x8000000,%al
 32d:	00 00                	add    %al,(%eax)
 32f:	00 26                	add    %ah,(%esi)
 331:	07                   	pop    %es
 332:	00 00                	add    %al,(%eax)
 334:	a0 00 00 00 0c       	mov    0xc000000,%al
 339:	00 00                	add    %al,(%eax)
 33b:	00 00                	add    %al,(%eax)
 33d:	00 00                	add    %al,(%eax)
 33f:	00 44 00 1d          	add    %al,0x1d(%eax,%eax,1)
 343:	00 00                	add    %al,(%eax)
 345:	00 00                	add    %al,(%eax)
 347:	00 31                	add    %dh,(%ecx)
 349:	07                   	pop    %es
 34a:	00 00                	add    %al,(%eax)
 34c:	84 00                	test   %al,(%eax)
 34e:	00 00                	add    %al,(%eax)
 350:	38 00                	cmp    %al,(%eax)
 352:	00 00                	add    %al,(%eax)
 354:	00 00                	add    %al,(%eax)
 356:	00 00                	add    %al,(%eax)
 358:	44                   	inc    %esp
 359:	00 2c 01             	add    %ch,(%ecx,%eax,1)
 35c:	08 00                	or     %al,(%eax)
 35e:	00 00                	add    %al,(%eax)
 360:	39 07                	cmp    %eax,(%edi)
 362:	00 00                	add    %al,(%eax)
 364:	84 00                	test   %al,(%eax)
 366:	00 00                	add    %al,(%eax)
 368:	3a 00                	cmp    (%eax),%al
 36a:	00 00                	add    %al,(%eax)
 36c:	00 00                	add    %al,(%eax)
 36e:	00 00                	add    %al,(%eax)
 370:	44                   	inc    %esp
 371:	00 21                	add    %ah,(%ecx)
 373:	00 0a                	add    %cl,(%edx)
 375:	00 00                	add    %al,(%eax)
 377:	00 3f                	add    %bh,(%edi)
 379:	07                   	pop    %es
 37a:	00 00                	add    %al,(%eax)
 37c:	84 00                	test   %al,(%eax)
 37e:	00 00                	add    %al,(%eax)
 380:	3f                   	aas    
 381:	00 00                	add    %al,(%eax)
 383:	00 00                	add    %al,(%eax)
 385:	00 00                	add    %al,(%eax)
 387:	00 44 00 33          	add    %al,0x33(%eax,%eax,1)
 38b:	01 0f                	add    %ecx,(%edi)
 38d:	00 00                	add    %al,(%eax)
 38f:	00 00                	add    %al,(%eax)
 391:	00 00                	add    %al,(%eax)
 393:	00 44 00 2c          	add    %al,0x2c(%eax,%eax,1)
 397:	01 11                	add    %edx,(%ecx)
 399:	00 00                	add    %al,(%eax)
 39b:	00 47 07             	add    %al,0x7(%edi)
 39e:	00 00                	add    %al,(%eax)
 3a0:	84 00                	test   %al,(%eax)
 3a2:	00 00                	add    %al,(%eax)
 3a4:	43                   	inc    %ebx
 3a5:	00 00                	add    %al,(%eax)
 3a7:	00 00                	add    %al,(%eax)
 3a9:	00 00                	add    %al,(%eax)
 3ab:	00 44 00 24          	add    %al,0x24(%eax,%eax,1)
 3af:	00 13                	add    %dl,(%ebx)
 3b1:	00 00                	add    %al,(%eax)
 3b3:	00 00                	add    %al,(%eax)
 3b5:	00 00                	add    %al,(%eax)
 3b7:	00 44 00 27          	add    %al,0x27(%eax,%eax,1)
 3bb:	00 15 00 00 00 00    	add    %dl,0x0
 3c1:	00 00                	add    %al,(%eax)
 3c3:	00 44 00 24          	add    %al,0x24(%eax,%eax,1)
 3c7:	00 1a                	add    %bl,(%edx)
 3c9:	00 00                	add    %al,(%eax)
 3cb:	00 4d 07             	add    %cl,0x7(%ebp)
 3ce:	00 00                	add    %al,(%eax)
 3d0:	84 00                	test   %al,(%eax)
 3d2:	00 00                	add    %al,(%eax)
 3d4:	52                   	push   %edx
 3d5:	00 00                	add    %al,(%eax)
 3d7:	00 00                	add    %al,(%eax)
 3d9:	00 00                	add    %al,(%eax)
 3db:	00 44 00 33          	add    %al,0x33(%eax,%eax,1)
 3df:	01 22                	add    %esp,(%edx)
 3e1:	00 00                	add    %al,(%eax)
 3e3:	00 55 07             	add    %dl,0x7(%ebp)
 3e6:	00 00                	add    %al,(%eax)
 3e8:	84 00                	test   %al,(%eax)
 3ea:	00 00                	add    %al,(%eax)
 3ec:	54                   	push   %esp
 3ed:	00 00                	add    %al,(%eax)
 3ef:	00 00                	add    %al,(%eax)
 3f1:	00 00                	add    %al,(%eax)
 3f3:	00 44 00 29          	add    %al,0x29(%eax,%eax,1)
 3f7:	00 24 00             	add    %ah,(%eax,%eax,1)
 3fa:	00 00                	add    %al,(%eax)
 3fc:	5b                   	pop    %ebx
 3fd:	07                   	pop    %es
 3fe:	00 00                	add    %al,(%eax)
 400:	84 00                	test   %al,(%eax)
 402:	00 00                	add    %al,(%eax)
 404:	58                   	pop    %eax
 405:	00 00                	add    %al,(%eax)
 407:	00 00                	add    %al,(%eax)
 409:	00 00                	add    %al,(%eax)
 40b:	00 44 00 cc          	add    %al,-0x34(%eax,%eax,1)
 40f:	00 28                	add    %ch,(%eax)
 411:	00 00                	add    %al,(%eax)
 413:	00 63 07             	add    %ah,0x7(%ebx)
 416:	00 00                	add    %al,(%eax)
 418:	84 00                	test   %al,(%eax)
 41a:	00 00                	add    %al,(%eax)
 41c:	5b                   	pop    %ebx
 41d:	00 00                	add    %al,(%eax)
 41f:	00 00                	add    %al,(%eax)
 421:	00 00                	add    %al,(%eax)
 423:	00 44 00 2b          	add    %al,0x2b(%eax,%eax,1)
 427:	00 2b                	add    %ch,(%ebx)
 429:	00 00                	add    %al,(%eax)
 42b:	00 69 07             	add    %ch,0x7(%ecx)
 42e:	00 00                	add    %al,(%eax)
 430:	84 00                	test   %al,(%eax)
 432:	00 00                	add    %al,(%eax)
 434:	61                   	popa   
 435:	00 00                	add    %al,(%eax)
 437:	00 00                	add    %al,(%eax)
 439:	00 00                	add    %al,(%eax)
 43b:	00 44 00 c5          	add    %al,-0x3b(%eax,%eax,1)
 43f:	00 31                	add    %dh,(%ecx)
 441:	00 00                	add    %al,(%eax)
 443:	00 71 07             	add    %dh,0x7(%ecx)
 446:	00 00                	add    %al,(%eax)
 448:	84 00                	test   %al,(%eax)
 44a:	00 00                	add    %al,(%eax)
 44c:	64 00 00             	add    %al,%fs:(%eax)
 44f:	00 00                	add    %al,(%eax)
 451:	00 00                	add    %al,(%eax)
 453:	00 44 00 2f          	add    %al,0x2f(%eax,%eax,1)
 457:	00 34 00             	add    %dh,(%eax,%eax,1)
 45a:	00 00                	add    %al,(%eax)
 45c:	00 00                	add    %al,(%eax)
 45e:	00 00                	add    %al,(%eax)
 460:	44                   	inc    %esp
 461:	00 31                	add    %dh,(%ecx)
 463:	00 3d 00 00 00 77    	add    %bh,0x77000000
 469:	07                   	pop    %es
 46a:	00 00                	add    %al,(%eax)
 46c:	84 00                	test   %al,(%eax)
 46e:	00 00                	add    %al,(%eax)
 470:	73 00                	jae    472 <.stab+0x472>
 472:	00 00                	add    %al,(%eax)
 474:	00 00                	add    %al,(%eax)
 476:	00 00                	add    %al,(%eax)
 478:	44                   	inc    %esp
 479:	00 cc                	add    %cl,%ah
 47b:	00 43 00             	add    %al,0x0(%ebx)
 47e:	00 00                	add    %al,(%eax)
 480:	7f 07                	jg     489 <.stab+0x489>
 482:	00 00                	add    %al,(%eax)
 484:	84 00                	test   %al,(%eax)
 486:	00 00                	add    %al,(%eax)
 488:	76 00                	jbe    48a <.stab+0x48a>
 48a:	00 00                	add    %al,(%eax)
 48c:	00 00                	add    %al,(%eax)
 48e:	00 00                	add    %al,(%eax)
 490:	44                   	inc    %esp
 491:	00 33                	add    %dh,(%ebx)
 493:	00 46 00             	add    %al,0x0(%esi)
 496:	00 00                	add    %al,(%eax)
 498:	85 07                	test   %eax,(%edi)
 49a:	00 00                	add    %al,(%eax)
 49c:	84 00                	test   %al,(%eax)
 49e:	00 00                	add    %al,(%eax)
 4a0:	7c 00                	jl     4a2 <.stab+0x4a2>
 4a2:	00 00                	add    %al,(%eax)
 4a4:	00 00                	add    %al,(%eax)
 4a6:	00 00                	add    %al,(%eax)
 4a8:	44                   	inc    %esp
 4a9:	00 c5                	add    %al,%ch
 4ab:	00 4c 00 00          	add    %cl,0x0(%eax,%eax,1)
 4af:	00 8d 07 00 00 84    	add    %cl,-0x7bfffff9(%ebp)
 4b5:	00 00                	add    %al,(%eax)
 4b7:	00 7f 00             	add    %bh,0x0(%edi)
 4ba:	00 00                	add    %al,(%eax)
 4bc:	00 00                	add    %al,(%eax)
 4be:	00 00                	add    %al,(%eax)
 4c0:	44                   	inc    %esp
 4c1:	00 37                	add    %dh,(%edi)
 4c3:	00 4f 00             	add    %cl,0x0(%edi)
 4c6:	00 00                	add    %al,(%eax)
 4c8:	00 00                	add    %al,(%eax)
 4ca:	00 00                	add    %al,(%eax)
 4cc:	44                   	inc    %esp
 4cd:	00 38                	add    %bh,(%eax)
 4cf:	00 59 00             	add    %bl,0x0(%ecx)
 4d2:	00 00                	add    %al,(%eax)
 4d4:	93                   	xchg   %eax,%ebx
 4d5:	07                   	pop    %es
 4d6:	00 00                	add    %al,(%eax)
 4d8:	40                   	inc    %eax
 4d9:	00 00                	add    %al,(%eax)
 4db:	00 00                	add    %al,(%eax)
 4dd:	00 00                	add    %al,(%eax)
 4df:	00 9e 07 00 00 40    	add    %bl,0x40000007(%esi)
 4e5:	00 00                	add    %al,(%eax)
 4e7:	00 06                	add    %al,(%esi)
 4e9:	00 00                	add    %al,(%eax)
 4eb:	00 00                	add    %al,(%eax)
 4ed:	00 00                	add    %al,(%eax)
 4ef:	00 c0                	add    %al,%al
	...
 4f9:	00 00                	add    %al,(%eax)
 4fb:	00 e0                	add    %ah,%al
 4fd:	00 00                	add    %al,(%eax)
 4ff:	00 60 00             	add    %ah,0x0(%eax)
 502:	00 00                	add    %al,(%eax)
 504:	a9 07 00 00 20       	test   $0x20000007,%eax
	...
 511:	00 00                	add    %al,(%eax)
 513:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
 517:	00                   	.byte 0x0
 518:	90                   	nop
 519:	00 00                	add    %al,(%eax)
	...

Disassembly of section .stabstr:

00000000 <.stabstr>:
#include <header.h>
#define EFLAGS_AC_BIT		0x00040000
#define CR0_CACHE_DISABLE	0x60000000

unsigned int hehe,heihei;
unsigned int memtest_sub(unsigned int start, unsigned int end){
   0:	00 6d 65             	add    %ch,0x65(%ebp)
   3:	6d                   	insl   (%dx),%es:(%edi)
   4:	2e 63 00             	arpl   %ax,%cs:(%eax)
	unsigned int i,*p,old,pat0 = 0xaa55aa55,pat1 = 0x55aa55aa;
	for (i = start;i<=end; i+=4){
   7:	6d                   	insl   (%dx),%es:(%edi)
   8:	65                   	gs
   9:	6d                   	insl   (%dx),%es:(%edi)
   a:	2e 63 00             	arpl   %ax,%cs:(%eax)
		p = (unsigned int *) i;
		old = *p;
		*p = pat0;
		*p ^= 0xffffffff;
   d:	67 63 63 32          	arpl   %sp,0x32(%bp,%di)
  11:	5f                   	pop    %edi
  12:	63 6f 6d             	arpl   %bp,0x6d(%edi)
		hehe = *p;
  15:	70 69                	jo     80 <.stabstr+0x80>
  17:	6c                   	insb   (%dx),%es:(%edi)
  18:	65 64 2e 00 69 6e    	gs fs add %ch,%cs:%fs:%gs:0x6e(%ecx)
		if (*p != pat1){
  1e:	74 3a                	je     5a <.stabstr+0x5a>
  20:	74 28                	je     4a <.stabstr+0x4a>
  22:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
  25:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
#define CR0_CACHE_DISABLE	0x60000000

unsigned int hehe,heihei;
unsigned int memtest_sub(unsigned int start, unsigned int end){
	unsigned int i,*p,old,pat0 = 0xaa55aa55,pat1 = 0x55aa55aa;
	for (i = start;i<=end; i+=4){
  2b:	31 29                	xor    %ebp,(%ecx)
			*p = old;
			return i;
		}
		*p = old;
	}
	return 0;
  2d:	3b 2d 32 31 34 37    	cmp    0x37343132,%ebp
}

unsigned int memtest(unsigned int start,unsigned int end){
  33:	34 38                	xor    $0x38,%al
  35:	33 36                	xor    (%esi),%esi
  37:	34 38                	xor    $0x38,%al
//read eflags and write_eflags
static __inline uint32_t
read_eflags(void)
{
        uint32_t eflags;
        __asm __volatile("pushfl; popl %0" : "=r" (eflags));
  39:	3b 32                	cmp    (%edx),%esi
	char flg486 = 0;
	unsigned int eflg,cr0,i;
	eflg = read_eflags();
	eflg |= EFLAGS_AC_BIT;
  3b:	31 34 37             	xor    %esi,(%edi,%esi,1)
  3e:	34 38                	xor    $0x38,%al
}

static __inline void
write_eflags(uint32_t eflags)
{
        __asm __volatile("pushl %0; popfl" : : "r" (eflags));
  40:	33 36                	xor    (%esi),%esi
//read eflags and write_eflags
static __inline uint32_t
read_eflags(void)
{
        uint32_t eflags;
        __asm __volatile("pushfl; popl %0" : "=r" (eflags));
  42:	34 37                	xor    $0x37,%al
	write_eflags(eflg);
	eflg = read_eflags();
	if ((eflg & EFLAGS_AC_BIT) != 0){
  44:	3b 00                	cmp    (%eax),%eax
		flg486 = 1;
	}
	eflg &= ~EFLAGS_AC_BIT;
  46:	63 68 61             	arpl   %bp,0x61(%eax)
  49:	72 3a                	jb     85 <.stabstr+0x85>
	unsigned int eflg,cr0,i;
	eflg = read_eflags();
	eflg |= EFLAGS_AC_BIT;
	write_eflags(eflg);
	eflg = read_eflags();
	if ((eflg & EFLAGS_AC_BIT) != 0){
  4b:	74 28                	je     75 <.stabstr+0x75>
  4d:	30 2c 32             	xor    %ch,(%edx,%esi,1)
  50:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
		flg486 = 1;
	}
	eflg &= ~EFLAGS_AC_BIT;
	write_eflags(eflg);
	if (flg486 != 0){
  56:	32 29                	xor    (%ecx),%ch

static __inline uint32_t
rcr0(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr0,%0" : "=r" (val));
  58:	3b 30                	cmp    (%eax),%esi
  5a:	3b 31                	cmp    (%ecx),%esi
		cr0 = rcr0();
		cr0 |= CR0_CACHE_DISABLE;
  5c:	32 37                	xor    (%edi),%dh
  5e:	3b 00                	cmp    (%eax),%eax
  60:	6c                   	insb   (%dx),%es:(%edi)
}

static __inline void
lcr0(uint32_t val)
{
	__asm __volatile("movl %0,%%cr0" : : "r" (val));
  61:	6f                   	outsl  %ds:(%esi),(%dx)
  62:	6e                   	outsb  %ds:(%esi),(%dx)
  63:	67 20 69 6e          	and    %ch,0x6e(%bx,%di)
		lcr0(cr0);
	}

	unsigned int ret = memtest_sub(start,end);
  67:	74 3a                	je     a3 <.stabstr+0xa3>
  69:	74 28                	je     93 <.stabstr+0x93>
  6b:	30 2c 33             	xor    %ch,(%ebx,%esi,1)
	
	if (flg486 != 0){
  6e:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872

static __inline uint32_t
rcr0(void)
{
	uint32_t val;
	__asm __volatile("movl %%cr0,%0" : "=r" (val));
  74:	33 29                	xor    (%ecx),%ebp
		cr0 = rcr0();
		cr0 &= CR0_CACHE_DISABLE;
  76:	3b 2d 32 31 34 37    	cmp    0x37343132,%ebp
}

static __inline void
lcr0(uint32_t val)
{
	__asm __volatile("movl %0,%%cr0" : : "r" (val));
  7c:	34 38                	xor    $0x38,%al
  7e:	33 36                	xor    (%esi),%esi
		lcr0(cr0);
	}
	if (ret==0) return end;
	else return ret -4;
  80:	34 38                	xor    $0x38,%al
  82:	3b 32                	cmp    (%edx),%esi
  84:	31 34 37             	xor    %esi,(%edi,%esi,1)
  87:	34 38                	xor    $0x38,%al
}
  89:	33 36                	xor    (%esi),%esi
  8b:	34 37                	xor    $0x37,%al
  8d:	3b 00                	cmp    (%eax),%eax
  8f:	75 6e                	jne    ff <.stabstr+0xff>
  91:	73 69                	jae    fc <.stabstr+0xfc>
  93:	67 6e                	outsb  %ds:(%si),(%dx)
  95:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
  9a:	74 3a                	je     d6 <.stabstr+0xd6>
  9c:	74 28                	je     c6 <.stabstr+0xc6>
  9e:	30 2c 34             	xor    %ch,(%esp,%esi,1)
  a1:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
  a7:	34 29                	xor    $0x29,%al
  a9:	3b 30                	cmp    (%eax),%esi
  ab:	3b 34 32             	cmp    (%edx,%esi,1),%esi
  ae:	39 34 39             	cmp    %esi,(%ecx,%edi,1)
  b1:	36                   	ss
  b2:	37                   	aaa    
  b3:	32 39                	xor    (%ecx),%bh
  b5:	35 3b 00 6c 6f       	xor    $0x6f6c003b,%eax
  ba:	6e                   	outsb  %ds:(%esi),(%dx)
  bb:	67 20 75 6e          	and    %dh,0x6e(%di)
  bf:	73 69                	jae    12a <.stabstr+0x12a>
  c1:	67 6e                	outsb  %ds:(%si),(%dx)
  c3:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
  c8:	74 3a                	je     104 <.stabstr+0x104>
  ca:	74 28                	je     f4 <.stabstr+0xf4>
  cc:	30 2c 35 29 3d 72 28 	xor    %ch,0x28723d29(,%esi,1)
  d3:	30 2c 35 29 3b 30 3b 	xor    %ch,0x3b303b29(,%esi,1)
  da:	34 32                	xor    $0x32,%al
  dc:	39 34 39             	cmp    %esi,(%ecx,%edi,1)
  df:	36                   	ss
  e0:	37                   	aaa    
  e1:	32 39                	xor    (%ecx),%bh
  e3:	35 3b 00 6c 6f       	xor    $0x6f6c003b,%eax
  e8:	6e                   	outsb  %ds:(%esi),(%dx)
  e9:	67 20 6c 6f          	and    %ch,0x6f(%si)
  ed:	6e                   	outsb  %ds:(%esi),(%dx)
  ee:	67 20 69 6e          	and    %ch,0x6e(%bx,%di)
  f2:	74 3a                	je     12e <.stabstr+0x12e>
  f4:	74 28                	je     11e <.stabstr+0x11e>
  f6:	30 2c 36             	xor    %ch,(%esi,%esi,1)
  f9:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
  ff:	36 29 3b             	sub    %edi,%ss:(%ebx)
 102:	2d 30 3b 34 32       	sub    $0x32343b30,%eax
 107:	39 34 39             	cmp    %esi,(%ecx,%edi,1)
 10a:	36                   	ss
 10b:	37                   	aaa    
 10c:	32 39                	xor    (%ecx),%bh
 10e:	35 3b 00 6c 6f       	xor    $0x6f6c003b,%eax
 113:	6e                   	outsb  %ds:(%esi),(%dx)
 114:	67 20 6c 6f          	and    %ch,0x6f(%si)
 118:	6e                   	outsb  %ds:(%esi),(%dx)
 119:	67 20 75 6e          	and    %dh,0x6e(%di)
 11d:	73 69                	jae    188 <.stabstr+0x188>
 11f:	67 6e                	outsb  %ds:(%si),(%dx)
 121:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
 126:	74 3a                	je     162 <.stabstr+0x162>
 128:	74 28                	je     152 <.stabstr+0x152>
 12a:	30 2c 37             	xor    %ch,(%edi,%esi,1)
 12d:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
 133:	37                   	aaa    
 134:	29 3b                	sub    %edi,(%ebx)
 136:	30 3b                	xor    %bh,(%ebx)
 138:	2d 31 3b 00 73       	sub    $0x73003b31,%eax
 13d:	68 6f 72 74 20       	push   $0x2074726f
 142:	69 6e 74 3a 74 28 30 	imul   $0x3028743a,0x74(%esi),%ebp
 149:	2c 38                	sub    $0x38,%al
 14b:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
 151:	38 29                	cmp    %ch,(%ecx)
 153:	3b 2d 33 32 37 36    	cmp    0x36373233,%ebp
 159:	38 3b                	cmp    %bh,(%ebx)
 15b:	33 32                	xor    (%edx),%esi
 15d:	37                   	aaa    
 15e:	36                   	ss
 15f:	37                   	aaa    
 160:	3b 00                	cmp    (%eax),%eax
 162:	73 68                	jae    1cc <.stabstr+0x1cc>
 164:	6f                   	outsl  %ds:(%esi),(%dx)
 165:	72 74                	jb     1db <.stabstr+0x1db>
 167:	20 75 6e             	and    %dh,0x6e(%ebp)
 16a:	73 69                	jae    1d5 <.stabstr+0x1d5>
 16c:	67 6e                	outsb  %ds:(%si),(%dx)
 16e:	65 64 20 69 6e       	gs and %ch,%fs:%gs:0x6e(%ecx)
 173:	74 3a                	je     1af <.stabstr+0x1af>
 175:	74 28                	je     19f <.stabstr+0x19f>
 177:	30 2c 39             	xor    %ch,(%ecx,%edi,1)
 17a:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
 180:	39 29                	cmp    %ebp,(%ecx)
 182:	3b 30                	cmp    (%eax),%esi
 184:	3b 36                	cmp    (%esi),%esi
 186:	35 35 33 35 3b       	xor    $0x3b353335,%eax
 18b:	00 73 69             	add    %dh,0x69(%ebx)
 18e:	67 6e                	outsb  %ds:(%si),(%dx)
 190:	65 64 20 63 68       	gs and %ah,%fs:%gs:0x68(%ebx)
 195:	61                   	popa   
 196:	72 3a                	jb     1d2 <.stabstr+0x1d2>
 198:	74 28                	je     1c2 <.stabstr+0x1c2>
 19a:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 19d:	30 29                	xor    %ch,(%ecx)
 19f:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 1a4:	31 30                	xor    %esi,(%eax)
 1a6:	29 3b                	sub    %edi,(%ebx)
 1a8:	2d 31 32 38 3b       	sub    $0x3b383231,%eax
 1ad:	31 32                	xor    %esi,(%edx)
 1af:	37                   	aaa    
 1b0:	3b 00                	cmp    (%eax),%eax
 1b2:	75 6e                	jne    222 <.stabstr+0x222>
 1b4:	73 69                	jae    21f <.stabstr+0x21f>
 1b6:	67 6e                	outsb  %ds:(%si),(%dx)
 1b8:	65 64 20 63 68       	gs and %ah,%fs:%gs:0x68(%ebx)
 1bd:	61                   	popa   
 1be:	72 3a                	jb     1fa <.stabstr+0x1fa>
 1c0:	74 28                	je     1ea <.stabstr+0x1ea>
 1c2:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 1c5:	31 29                	xor    %ebp,(%ecx)
 1c7:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 1cc:	31 31                	xor    %esi,(%ecx)
 1ce:	29 3b                	sub    %edi,(%ebx)
 1d0:	30 3b                	xor    %bh,(%ebx)
 1d2:	32 35 35 3b 00 66    	xor    0x66003b35,%dh
 1d8:	6c                   	insb   (%dx),%es:(%edi)
 1d9:	6f                   	outsl  %ds:(%esi),(%dx)
 1da:	61                   	popa   
 1db:	74 3a                	je     217 <.stabstr+0x217>
 1dd:	74 28                	je     207 <.stabstr+0x207>
 1df:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 1e2:	32 29                	xor    (%ecx),%ch
 1e4:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 1e9:	31 29                	xor    %ebp,(%ecx)
 1eb:	3b 34 3b             	cmp    (%ebx,%edi,1),%esi
 1ee:	30 3b                	xor    %bh,(%ebx)
 1f0:	00 64 6f 75          	add    %ah,0x75(%edi,%ebp,2)
 1f4:	62 6c 65 3a          	bound  %ebp,0x3a(%ebp,%eiz,2)
 1f8:	74 28                	je     222 <.stabstr+0x222>
 1fa:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 1fd:	33 29                	xor    (%ecx),%ebp
 1ff:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 204:	31 29                	xor    %ebp,(%ecx)
 206:	3b 38                	cmp    (%eax),%edi
 208:	3b 30                	cmp    (%eax),%esi
 20a:	3b 00                	cmp    (%eax),%eax
 20c:	6c                   	insb   (%dx),%es:(%edi)
 20d:	6f                   	outsl  %ds:(%esi),(%dx)
 20e:	6e                   	outsb  %ds:(%esi),(%dx)
 20f:	67 20 64 6f          	and    %ah,0x6f(%si)
 213:	75 62                	jne    277 <.stabstr+0x277>
 215:	6c                   	insb   (%dx),%es:(%edi)
 216:	65 3a 74 28 30       	cmp    %gs:0x30(%eax,%ebp,1),%dh
 21b:	2c 31                	sub    $0x31,%al
 21d:	34 29                	xor    $0x29,%al
 21f:	3d 72 28 30 2c       	cmp    $0x2c302872,%eax
 224:	31 29                	xor    %ebp,(%ecx)
 226:	3b 31                	cmp    (%ecx),%esi
 228:	32 3b                	xor    (%ebx),%bh
 22a:	30 3b                	xor    %bh,(%ebx)
 22c:	00 5f 44             	add    %bl,0x44(%edi)
 22f:	65 63 69 6d          	arpl   %bp,%gs:0x6d(%ecx)
 233:	61                   	popa   
 234:	6c                   	insb   (%dx),%es:(%edi)
 235:	33 32                	xor    (%edx),%esi
 237:	3a 74 28 30          	cmp    0x30(%eax,%ebp,1),%dh
 23b:	2c 31                	sub    $0x31,%al
 23d:	35 29 3d 72 28       	xor    $0x28723d29,%eax
 242:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 245:	29 3b                	sub    %edi,(%ebx)
 247:	34 3b                	xor    $0x3b,%al
 249:	30 3b                	xor    %bh,(%ebx)
 24b:	00 5f 44             	add    %bl,0x44(%edi)
 24e:	65 63 69 6d          	arpl   %bp,%gs:0x6d(%ecx)
 252:	61                   	popa   
 253:	6c                   	insb   (%dx),%es:(%edi)
 254:	36                   	ss
 255:	34 3a                	xor    $0x3a,%al
 257:	74 28                	je     281 <.stabstr+0x281>
 259:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 25c:	36 29 3d 72 28 30 2c 	sub    %edi,%ss:0x2c302872
 263:	31 29                	xor    %ebp,(%ecx)
 265:	3b 38                	cmp    (%eax),%edi
 267:	3b 30                	cmp    (%eax),%esi
 269:	3b 00                	cmp    (%eax),%eax
 26b:	5f                   	pop    %edi
 26c:	44                   	inc    %esp
 26d:	65 63 69 6d          	arpl   %bp,%gs:0x6d(%ecx)
 271:	61                   	popa   
 272:	6c                   	insb   (%dx),%es:(%edi)
 273:	31 32                	xor    %esi,(%edx)
 275:	38 3a                	cmp    %bh,(%edx)
 277:	74 28                	je     2a1 <.stabstr+0x2a1>
 279:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 27c:	37                   	aaa    
 27d:	29 3d 72 28 30 2c    	sub    %edi,0x2c302872
 283:	31 29                	xor    %ebp,(%ecx)
 285:	3b 31                	cmp    (%ecx),%esi
 287:	36 3b 30             	cmp    %ss:(%eax),%esi
 28a:	3b 00                	cmp    (%eax),%eax
 28c:	76 6f                	jbe    2fd <.stabstr+0x2fd>
 28e:	69 64 3a 74 28 30 2c 	imul   $0x312c3028,0x74(%edx,%edi,1),%esp
 295:	31 
 296:	38 29                	cmp    %ch,(%ecx)
 298:	3d 28 30 2c 31       	cmp    $0x312c3028,%eax
 29d:	38 29                	cmp    %ch,(%ecx)
 29f:	00 2e                	add    %ch,(%esi)
 2a1:	2f                   	das    
 2a2:	68 65 61 64 65       	push   $0x65646165
 2a7:	72 2e                	jb     2d7 <.stabstr+0x2d7>
 2a9:	68 00 2e 2f 78       	push   $0x782f2e00
 2ae:	38 36                	cmp    %dh,(%esi)
 2b0:	2e                   	cs
 2b1:	68 00 2e 2f 74       	push   $0x742f2e00
 2b6:	79 70                	jns    328 <.stabstr+0x328>
 2b8:	65                   	gs
 2b9:	73 2e                	jae    2e9 <.stabstr+0x2e9>
 2bb:	68 00 62 6f 6f       	push   $0x6f6f6200
 2c0:	6c                   	insb   (%dx),%es:(%edi)
 2c1:	3a 74 28 33          	cmp    0x33(%eax,%ebp,1),%dh
 2c5:	2c 31                	sub    $0x31,%al
 2c7:	29 3d 28 30 2c 31    	sub    %edi,0x312c3028
 2cd:	29 00                	sub    %eax,(%eax)
 2cf:	69 6e 74 38 5f 74 3a 	imul   $0x3a745f38,0x74(%esi),%ebp
 2d6:	74 28                	je     300 <.stabstr+0x300>
 2d8:	33 2c 32             	xor    (%edx,%esi,1),%ebp
 2db:	29 3d 28 30 2c 31    	sub    %edi,0x312c3028
 2e1:	30 29                	xor    %ch,(%ecx)
 2e3:	00 75 69             	add    %dh,0x69(%ebp)
 2e6:	6e                   	outsb  %ds:(%esi),(%dx)
 2e7:	74 38                	je     321 <.stabstr+0x321>
 2e9:	5f                   	pop    %edi
 2ea:	74 3a                	je     326 <.stabstr+0x326>
 2ec:	74 28                	je     316 <.stabstr+0x316>
 2ee:	33 2c 33             	xor    (%ebx,%esi,1),%ebp
 2f1:	29 3d 28 30 2c 31    	sub    %edi,0x312c3028
 2f7:	31 29                	xor    %ebp,(%ecx)
 2f9:	00 69 6e             	add    %ch,0x6e(%ecx)
 2fc:	74 31                	je     32f <.stabstr+0x32f>
 2fe:	36                   	ss
 2ff:	5f                   	pop    %edi
 300:	74 3a                	je     33c <.stabstr+0x33c>
 302:	74 28                	je     32c <.stabstr+0x32c>
 304:	33 2c 34             	xor    (%esp,%esi,1),%ebp
 307:	29 3d 28 30 2c 38    	sub    %edi,0x382c3028
 30d:	29 00                	sub    %eax,(%eax)
 30f:	75 69                	jne    37a <.stabstr+0x37a>
 311:	6e                   	outsb  %ds:(%esi),(%dx)
 312:	74 31                	je     345 <.stabstr+0x345>
 314:	36                   	ss
 315:	5f                   	pop    %edi
 316:	74 3a                	je     352 <.stabstr+0x352>
 318:	74 28                	je     342 <.stabstr+0x342>
 31a:	33 2c 35 29 3d 28 30 	xor    0x30283d29(,%esi,1),%ebp
 321:	2c 39                	sub    $0x39,%al
 323:	29 00                	sub    %eax,(%eax)
 325:	69 6e 74 33 32 5f 74 	imul   $0x745f3233,0x74(%esi),%ebp
 32c:	3a 74 28 33          	cmp    0x33(%eax,%ebp,1),%dh
 330:	2c 36                	sub    $0x36,%al
 332:	29 3d 28 30 2c 31    	sub    %edi,0x312c3028
 338:	29 00                	sub    %eax,(%eax)
 33a:	75 69                	jne    3a5 <.stabstr+0x3a5>
 33c:	6e                   	outsb  %ds:(%esi),(%dx)
 33d:	74 33                	je     372 <.stabstr+0x372>
 33f:	32 5f 74             	xor    0x74(%edi),%bl
 342:	3a 74 28 33          	cmp    0x33(%eax,%ebp,1),%dh
 346:	2c 37                	sub    $0x37,%al
 348:	29 3d 28 30 2c 34    	sub    %edi,0x342c3028
 34e:	29 00                	sub    %eax,(%eax)
 350:	69 6e 74 36 34 5f 74 	imul   $0x745f3436,0x74(%esi),%ebp
 357:	3a 74 28 33          	cmp    0x33(%eax,%ebp,1),%dh
 35b:	2c 38                	sub    $0x38,%al
 35d:	29 3d 28 30 2c 36    	sub    %edi,0x362c3028
 363:	29 00                	sub    %eax,(%eax)
 365:	75 69                	jne    3d0 <.stabstr+0x3d0>
 367:	6e                   	outsb  %ds:(%esi),(%dx)
 368:	74 36                	je     3a0 <.stabstr+0x3a0>
 36a:	34 5f                	xor    $0x5f,%al
 36c:	74 3a                	je     3a8 <.stabstr+0x3a8>
 36e:	74 28                	je     398 <.stabstr+0x398>
 370:	33 2c 39             	xor    (%ecx,%edi,1),%ebp
 373:	29 3d 28 30 2c 37    	sub    %edi,0x372c3028
 379:	29 00                	sub    %eax,(%eax)
 37b:	69 6e 74 70 74 72 5f 	imul   $0x5f727470,0x74(%esi),%ebp
 382:	74 3a                	je     3be <.stabstr+0x3be>
 384:	74 28                	je     3ae <.stabstr+0x3ae>
 386:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 389:	30 29                	xor    %ch,(%ecx)
 38b:	3d 28 33 2c 36       	cmp    $0x362c3328,%eax
 390:	29 00                	sub    %eax,(%eax)
 392:	75 69                	jne    3fd <.stabstr+0x3fd>
 394:	6e                   	outsb  %ds:(%esi),(%dx)
 395:	74 70                	je     407 <.stabstr+0x407>
 397:	74 72                	je     40b <.stabstr+0x40b>
 399:	5f                   	pop    %edi
 39a:	74 3a                	je     3d6 <.stabstr+0x3d6>
 39c:	74 28                	je     3c6 <.stabstr+0x3c6>
 39e:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 3a1:	31 29                	xor    %ebp,(%ecx)
 3a3:	3d 28 33 2c 37       	cmp    $0x372c3328,%eax
 3a8:	29 00                	sub    %eax,(%eax)
 3aa:	70 68                	jo     414 <.stabstr+0x414>
 3ac:	79 73                	jns    421 <.stabstr+0x421>
 3ae:	61                   	popa   
 3af:	64                   	fs
 3b0:	64                   	fs
 3b1:	72 5f                	jb     412 <.stabstr+0x412>
 3b3:	74 3a                	je     3ef <.stabstr+0x3ef>
 3b5:	74 28                	je     3df <.stabstr+0x3df>
 3b7:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 3ba:	32 29                	xor    (%ecx),%ch
 3bc:	3d 28 33 2c 37       	cmp    $0x372c3328,%eax
 3c1:	29 00                	sub    %eax,(%eax)
 3c3:	70 70                	jo     435 <.stabstr+0x435>
 3c5:	6e                   	outsb  %ds:(%esi),(%dx)
 3c6:	5f                   	pop    %edi
 3c7:	74 3a                	je     403 <.stabstr+0x403>
 3c9:	74 28                	je     3f3 <.stabstr+0x3f3>
 3cb:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 3ce:	33 29                	xor    (%ecx),%ebp
 3d0:	3d 28 33 2c 37       	cmp    $0x372c3328,%eax
 3d5:	29 00                	sub    %eax,(%eax)
 3d7:	73 69                	jae    442 <.stabstr+0x442>
 3d9:	7a 65                	jp     440 <.stabstr+0x440>
 3db:	5f                   	pop    %edi
 3dc:	74 3a                	je     418 <.stabstr+0x418>
 3de:	74 28                	je     408 <.stabstr+0x408>
 3e0:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 3e3:	34 29                	xor    $0x29,%al
 3e5:	3d 28 33 2c 37       	cmp    $0x372c3328,%eax
 3ea:	29 00                	sub    %eax,(%eax)
 3ec:	73 73                	jae    461 <.stabstr+0x461>
 3ee:	69 7a 65 5f 74 3a 74 	imul   $0x743a745f,0x65(%edx),%edi
 3f5:	28 33                	sub    %dh,(%ebx)
 3f7:	2c 31                	sub    $0x31,%al
 3f9:	35 29 3d 28 33       	xor    $0x33283d29,%eax
 3fe:	2c 36                	sub    $0x36,%al
 400:	29 00                	sub    %eax,(%eax)
 402:	6f                   	outsl  %ds:(%esi),(%dx)
 403:	66 66 5f             	data32 pop %di
 406:	74 3a                	je     442 <.stabstr+0x442>
 408:	74 28                	je     432 <.stabstr+0x432>
 40a:	33 2c 31             	xor    (%ecx,%esi,1),%ebp
 40d:	36 29 3d 28 33 2c 36 	sub    %edi,%ss:0x362c3328
 414:	29 00                	sub    %eax,(%eax)
 416:	46                   	inc    %esi
 417:	49                   	dec    %ecx
 418:	46                   	inc    %esi
 419:	4f                   	dec    %edi
 41a:	38 3a                	cmp    %bh,(%edx)
 41c:	54                   	push   %esp
 41d:	28 31                	sub    %dh,(%ecx)
 41f:	2c 31                	sub    $0x31,%al
 421:	29 3d 73 32 34 62    	sub    %edi,0x62343273
 427:	75 66                	jne    48f <.stabstr+0x48f>
 429:	3a 28                	cmp    (%eax),%ch
 42b:	31 2c 32             	xor    %ebp,(%edx,%esi,1)
 42e:	29 3d 2a 28 30 2c    	sub    %edi,0x2c30282a
 434:	31 31                	xor    %esi,(%ecx)
 436:	29 2c 30             	sub    %ebp,(%eax,%esi,1)
 439:	2c 33                	sub    $0x33,%al
 43b:	32 3b                	xor    (%ebx),%bh
 43d:	70 3a                	jo     479 <.stabstr+0x479>
 43f:	28 30                	sub    %dh,(%eax)
 441:	2c 31                	sub    $0x31,%al
 443:	29 2c 33             	sub    %ebp,(%ebx,%esi,1)
 446:	32 2c 33             	xor    (%ebx,%esi,1),%ch
 449:	32 3b                	xor    (%ebx),%bh
 44b:	71 3a                	jno    487 <.stabstr+0x487>
 44d:	28 30                	sub    %dh,(%eax)
 44f:	2c 31                	sub    $0x31,%al
 451:	29 2c 36             	sub    %ebp,(%esi,%esi,1)
 454:	34 2c                	xor    $0x2c,%al
 456:	33 32                	xor    (%edx),%esi
 458:	3b 73 69             	cmp    0x69(%ebx),%esi
 45b:	7a 65                	jp     4c2 <.stabstr+0x4c2>
 45d:	3a 28                	cmp    (%eax),%ch
 45f:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 462:	29 2c 39             	sub    %ebp,(%ecx,%edi,1)
 465:	36                   	ss
 466:	2c 33                	sub    $0x33,%al
 468:	32 3b                	xor    (%ebx),%bh
 46a:	66                   	data16
 46b:	72 65                	jb     4d2 <.stabstr+0x4d2>
 46d:	65 3a 28             	cmp    %gs:(%eax),%ch
 470:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 473:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 476:	32 38                	xor    (%eax),%bh
 478:	2c 33                	sub    $0x33,%al
 47a:	32 3b                	xor    (%ebx),%bh
 47c:	66                   	data16
 47d:	6c                   	insb   (%dx),%es:(%edi)
 47e:	61                   	popa   
 47f:	67 73 3a             	addr16 jae 4bc <.stabstr+0x4bc>
 482:	28 30                	sub    %dh,(%eax)
 484:	2c 31                	sub    $0x31,%al
 486:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 489:	36 30 2c 33          	xor    %ch,%ss:(%ebx,%esi,1)
 48d:	32 3b                	xor    (%ebx),%bh
 48f:	3b 00                	cmp    (%eax),%eax
 491:	4d                   	dec    %ebp
 492:	4f                   	dec    %edi
 493:	55                   	push   %ebp
 494:	53                   	push   %ebx
 495:	45                   	inc    %ebp
 496:	5f                   	pop    %edi
 497:	44                   	inc    %esp
 498:	45                   	inc    %ebp
 499:	43                   	inc    %ebx
 49a:	3a 54 28 31          	cmp    0x31(%eax,%ebp,1),%dl
 49e:	2c 33                	sub    $0x33,%al
 4a0:	29 3d 73 31 36 62    	sub    %edi,0x62363173
 4a6:	75 66                	jne    50e <.stabstr+0x50e>
 4a8:	3a 28                	cmp    (%eax),%ch
 4aa:	31 2c 34             	xor    %ebp,(%esp,%esi,1)
 4ad:	29 3d 61 72 28 31    	sub    %edi,0x31287261
 4b3:	2c 35                	sub    $0x35,%al
 4b5:	29 3d 72 28 31 2c    	sub    %edi,0x2c312872
 4bb:	35 29 3b 30 3b       	xor    $0x3b303b29,%eax
 4c0:	34 32                	xor    $0x32,%al
 4c2:	39 34 39             	cmp    %esi,(%ecx,%edi,1)
 4c5:	36                   	ss
 4c6:	37                   	aaa    
 4c7:	32 39                	xor    (%ecx),%bh
 4c9:	35 3b 3b 30 3b       	xor    $0x3b303b3b,%eax
 4ce:	32 3b                	xor    (%ebx),%bh
 4d0:	28 30                	sub    %dh,(%eax)
 4d2:	2c 31                	sub    $0x31,%al
 4d4:	31 29                	xor    %ebp,(%ecx)
 4d6:	2c 30                	sub    $0x30,%al
 4d8:	2c 32                	sub    $0x32,%al
 4da:	34 3b                	xor    $0x3b,%al
 4dc:	70 68                	jo     546 <.stabstr+0x546>
 4de:	61                   	popa   
 4df:	73 65                	jae    546 <.stabstr+0x546>
 4e1:	3a 28                	cmp    (%eax),%ch
 4e3:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 4e6:	31 29                	xor    %ebp,(%ecx)
 4e8:	2c 32                	sub    $0x32,%al
 4ea:	34 2c                	xor    $0x2c,%al
 4ec:	38 3b                	cmp    %bh,(%ebx)
 4ee:	78 3a                	js     52a <.stabstr+0x52a>
 4f0:	28 30                	sub    %dh,(%eax)
 4f2:	2c 31                	sub    $0x31,%al
 4f4:	29 2c 33             	sub    %ebp,(%ebx,%esi,1)
 4f7:	32 2c 33             	xor    (%ebx,%esi,1),%ch
 4fa:	32 3b                	xor    (%ebx),%bh
 4fc:	79 3a                	jns    538 <.stabstr+0x538>
 4fe:	28 30                	sub    %dh,(%eax)
 500:	2c 31                	sub    $0x31,%al
 502:	29 2c 36             	sub    %ebp,(%esi,%esi,1)
 505:	34 2c                	xor    $0x2c,%al
 507:	33 32                	xor    (%edx),%esi
 509:	3b 62 74             	cmp    0x74(%edx),%esp
 50c:	6e                   	outsb  %ds:(%esi),(%dx)
 50d:	3a 28                	cmp    (%eax),%ch
 50f:	30 2c 31             	xor    %ch,(%ecx,%esi,1)
 512:	29 2c 39             	sub    %ebp,(%ecx,%edi,1)
 515:	36                   	ss
 516:	2c 33                	sub    $0x33,%al
 518:	32 3b                	xor    (%ebx),%bh
 51a:	3b 00                	cmp    (%eax),%eax
 51c:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 51f:	74 5f                	je     580 <.stabstr+0x580>
 521:	69 6e 66 6f 3a 54 28 	imul   $0x28543a6f,0x66(%esi),%ebp
 528:	31 2c 36             	xor    %ebp,(%esi,%esi,1)
 52b:	29 3d 73 31 32 63    	sub    %edi,0x63323173
 531:	79 6c                	jns    59f <.stabstr+0x59f>
 533:	69 6e 64 65 72 3a 28 	imul   $0x283a7265,0x64(%esi),%ebp
 53a:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 53d:	29 2c 30             	sub    %ebp,(%eax,%esi,1)
 540:	2c 38                	sub    $0x38,%al
 542:	3b 6c 65 64          	cmp    0x64(%ebp,%eiz,2),%ebp
 546:	3a 28                	cmp    (%eax),%ch
 548:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 54b:	29 2c 38             	sub    %ebp,(%eax,%edi,1)
 54e:	2c 38                	sub    $0x38,%al
 550:	3b 63 6f             	cmp    0x6f(%ebx),%esp
 553:	6c                   	insb   (%dx),%es:(%edi)
 554:	6f                   	outsl  %ds:(%esi),(%dx)
 555:	72 5f                	jb     5b6 <.stabstr+0x5b6>
 557:	6d                   	insl   (%dx),%es:(%edi)
 558:	6f                   	outsl  %ds:(%esi),(%dx)
 559:	64 65 3a 28          	fs cmp %fs:%gs:(%eax),%ch
 55d:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 560:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 563:	36                   	ss
 564:	2c 38                	sub    $0x38,%al
 566:	3b 72 65             	cmp    0x65(%edx),%esi
 569:	73 65                	jae    5d0 <.stabstr+0x5d0>
 56b:	72 76                	jb     5e3 <.stabstr+0x5e3>
 56d:	65 64 3a 28          	gs cmp %fs:%gs:(%eax),%ch
 571:	30 2c 32             	xor    %ch,(%edx,%esi,1)
 574:	29 2c 32             	sub    %ebp,(%edx,%esi,1)
 577:	34 2c                	xor    $0x2c,%al
 579:	38 3b                	cmp    %bh,(%ebx)
 57b:	78 73                	js     5f0 <.stabstr+0x5f0>
 57d:	69 7a 65 3a 28 30 2c 	imul   $0x2c30283a,0x65(%edx),%edi
 584:	38 29                	cmp    %ch,(%ecx)
 586:	2c 33                	sub    $0x33,%al
 588:	32 2c 31             	xor    (%ecx,%esi,1),%ch
 58b:	36 3b 79 73          	cmp    %ss:0x73(%ecx),%edi
 58f:	69 7a 65 3a 28 30 2c 	imul   $0x2c30283a,0x65(%edx),%edi
 596:	38 29                	cmp    %ch,(%ecx)
 598:	2c 34                	sub    $0x34,%al
 59a:	38 2c 31             	cmp    %ch,(%ecx,%esi,1)
 59d:	36 3b 76 72          	cmp    %ss:0x72(%esi),%esi
 5a1:	61                   	popa   
 5a2:	6d                   	insl   (%dx),%es:(%edi)
 5a3:	3a 28                	cmp    (%eax),%ch
 5a5:	31 2c 37             	xor    %ebp,(%edi,%esi,1)
 5a8:	29 3d 2a 28 30 2c    	sub    %edi,0x2c30282a
 5ae:	32 29                	xor    (%ecx),%ch
 5b0:	2c 36                	sub    $0x36,%al
 5b2:	34 2c                	xor    $0x2c,%al
 5b4:	33 32                	xor    (%edx),%esi
 5b6:	3b 3b                	cmp    (%ebx),%edi
 5b8:	00 47 44             	add    %al,0x44(%edi)
 5bb:	54                   	push   %esp
 5bc:	3a 54 28 31          	cmp    0x31(%eax,%ebp,1),%dl
 5c0:	2c 38                	sub    $0x38,%al
 5c2:	29 3d 73 38 6c 69    	sub    %edi,0x696c3873
 5c8:	6d                   	insl   (%dx),%es:(%edi)
 5c9:	69 74 5f 6c 6f 77 3a 	imul   $0x283a776f,0x6c(%edi,%ebx,2),%esi
 5d0:	28 
 5d1:	30 2c 38             	xor    %ch,(%eax,%edi,1)
 5d4:	29 2c 30             	sub    %ebp,(%eax,%esi,1)
 5d7:	2c 31                	sub    $0x31,%al
 5d9:	36 3b 62 61          	cmp    %ss:0x61(%edx),%esp
 5dd:	73 65                	jae    644 <.stabstr+0x644>
 5df:	5f                   	pop    %edi
 5e0:	6c                   	insb   (%dx),%es:(%edi)
 5e1:	6f                   	outsl  %ds:(%esi),(%dx)
 5e2:	77 3a                	ja     61e <.stabstr+0x61e>
 5e4:	28 30                	sub    %dh,(%eax)
 5e6:	2c 38                	sub    $0x38,%al
 5e8:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 5eb:	36                   	ss
 5ec:	2c 31                	sub    $0x31,%al
 5ee:	36 3b 62 61          	cmp    %ss:0x61(%edx),%esp
 5f2:	73 65                	jae    659 <.stabstr+0x659>
 5f4:	5f                   	pop    %edi
 5f5:	6d                   	insl   (%dx),%es:(%edi)
 5f6:	69 64 3a 28 30 2c 32 	imul   $0x29322c30,0x28(%edx,%edi,1),%esp
 5fd:	29 
 5fe:	2c 33                	sub    $0x33,%al
 600:	32 2c 38             	xor    (%eax,%edi,1),%ch
 603:	3b 61 63             	cmp    0x63(%ecx),%esp
 606:	63 65 73             	arpl   %sp,0x73(%ebp)
 609:	73 5f                	jae    66a <.stabstr+0x66a>
 60b:	72 69                	jb     676 <.stabstr+0x676>
 60d:	67 68 74 3a 28 30    	addr16 push $0x30283a74
 613:	2c 32                	sub    $0x32,%al
 615:	29 2c 34             	sub    %ebp,(%esp,%esi,1)
 618:	30 2c 38             	xor    %ch,(%eax,%edi,1)
 61b:	3b 6c 69 6d          	cmp    0x6d(%ecx,%ebp,2),%ebp
 61f:	69 74 5f 68 69 67 68 	imul   $0x3a686769,0x68(%edi,%ebx,2),%esi
 626:	3a 
 627:	28 30                	sub    %dh,(%eax)
 629:	2c 32                	sub    $0x32,%al
 62b:	29 2c 34             	sub    %ebp,(%esp,%esi,1)
 62e:	38 2c 38             	cmp    %ch,(%eax,%edi,1)
 631:	3b 62 61             	cmp    0x61(%edx),%esp
 634:	73 65                	jae    69b <.stabstr+0x69b>
 636:	5f                   	pop    %edi
 637:	68 69 67 68 3a       	push   $0x3a686769
 63c:	28 30                	sub    %dh,(%eax)
 63e:	2c 32                	sub    $0x32,%al
 640:	29 2c 35 36 2c 38 3b 	sub    %ebp,0x3b382c36(,%esi,1)
 647:	3b 00                	cmp    (%eax),%eax
 649:	49                   	dec    %ecx
 64a:	44                   	inc    %esp
 64b:	54                   	push   %esp
 64c:	3a 54 28 31          	cmp    0x31(%eax,%ebp,1),%dl
 650:	2c 39                	sub    $0x39,%al
 652:	29 3d 73 38 6f 66    	sub    %edi,0x666f3873
 658:	66                   	data16
 659:	73 65                	jae    6c0 <.stabstr+0x6c0>
 65b:	74 5f                	je     6bc <.stabstr+0x6bc>
 65d:	6c                   	insb   (%dx),%es:(%edi)
 65e:	6f                   	outsl  %ds:(%esi),(%dx)
 65f:	77 3a                	ja     69b <.stabstr+0x69b>
 661:	28 30                	sub    %dh,(%eax)
 663:	2c 38                	sub    $0x38,%al
 665:	29 2c 30             	sub    %ebp,(%eax,%esi,1)
 668:	2c 31                	sub    $0x31,%al
 66a:	36 3b 73 65          	cmp    %ss:0x65(%ebx),%esi
 66e:	6c                   	insb   (%dx),%es:(%edi)
 66f:	65 63 74 6f 72       	arpl   %si,%gs:0x72(%edi,%ebp,2)
 674:	3a 28                	cmp    (%eax),%ch
 676:	30 2c 38             	xor    %ch,(%eax,%edi,1)
 679:	29 2c 31             	sub    %ebp,(%ecx,%esi,1)
 67c:	36                   	ss
 67d:	2c 31                	sub    $0x31,%al
 67f:	36 3b 64 77 5f       	cmp    %ss:0x5f(%edi,%esi,2),%esp
 684:	63 6f 75             	arpl   %bp,0x75(%edi)
 687:	6e                   	outsb  %ds:(%esi),(%dx)
 688:	74 3a                	je     6c4 <.stabstr+0x6c4>
 68a:	28 30                	sub    %dh,(%eax)
 68c:	2c 32                	sub    $0x32,%al
 68e:	29 2c 33             	sub    %ebp,(%ebx,%esi,1)
 691:	32 2c 38             	xor    (%eax,%edi,1),%ch
 694:	3b 61 63             	cmp    0x63(%ecx),%esp
 697:	63 65 73             	arpl   %sp,0x73(%ebp)
 69a:	73 5f                	jae    6fb <.stabstr+0x6fb>
 69c:	72 69                	jb     707 <.stabstr+0x707>
 69e:	67 68 74 3a 28 30    	addr16 push $0x30283a74
 6a4:	2c 32                	sub    $0x32,%al
 6a6:	29 2c 34             	sub    %ebp,(%esp,%esi,1)
 6a9:	30 2c 38             	xor    %ch,(%eax,%edi,1)
 6ac:	3b 6f 66             	cmp    0x66(%edi),%ebp
 6af:	66                   	data16
 6b0:	73 65                	jae    717 <.stabstr+0x717>
 6b2:	74 5f                	je     713 <.stabstr+0x713>
 6b4:	68 69 67 68 3a       	push   $0x3a686769
 6b9:	28 30                	sub    %dh,(%eax)
 6bb:	2c 38                	sub    $0x38,%al
 6bd:	29 2c 34             	sub    %ebp,(%esp,%esi,1)
 6c0:	38 2c 31             	cmp    %ch,(%ecx,%esi,1)
 6c3:	36 3b 3b             	cmp    %ss:(%ebx),%edi
 6c6:	00 6d 65             	add    %ch,0x65(%ebp)
 6c9:	6d                   	insl   (%dx),%es:(%edi)
 6ca:	74 65                	je     731 <.stabstr+0x731>
 6cc:	73 74                	jae    742 <.stabstr+0x742>
 6ce:	5f                   	pop    %edi
 6cf:	73 75                	jae    746 <.stabstr+0x746>
 6d1:	62 3a                	bound  %edi,(%edx)
 6d3:	46                   	inc    %esi
 6d4:	28 30                	sub    %dh,(%eax)
 6d6:	2c 34                	sub    $0x34,%al
 6d8:	29 00                	sub    %eax,(%eax)
 6da:	73 74                	jae    750 <.stabstr+0x750>
 6dc:	61                   	popa   
 6dd:	72 74                	jb     753 <.stabstr+0x753>
 6df:	3a 70 28             	cmp    0x28(%eax),%dh
 6e2:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 6e5:	29 00                	sub    %eax,(%eax)
 6e7:	65 6e                	outsb  %gs:(%esi),(%dx)
 6e9:	64 3a 70 28          	cmp    %fs:0x28(%eax),%dh
 6ed:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 6f0:	29 00                	sub    %eax,(%eax)
 6f2:	6f                   	outsl  %ds:(%esi),(%dx)
 6f3:	6c                   	insb   (%dx),%es:(%edi)
 6f4:	64 3a 72 28          	cmp    %fs:0x28(%edx),%dh
 6f8:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 6fb:	29 00                	sub    %eax,(%eax)
 6fd:	73 74                	jae    773 <.stabstr+0x773>
 6ff:	61                   	popa   
 700:	72 74                	jb     776 <.stabstr+0x776>
 702:	3a 72 28             	cmp    0x28(%edx),%dh
 705:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 708:	29 00                	sub    %eax,(%eax)
 70a:	6d                   	insl   (%dx),%es:(%edi)
 70b:	65                   	gs
 70c:	6d                   	insl   (%dx),%es:(%edi)
 70d:	74 65                	je     774 <.stabstr+0x774>
 70f:	73 74                	jae    785 <.stabstr+0x785>
 711:	3a 46 28             	cmp    0x28(%esi),%al
 714:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 717:	29 00                	sub    %eax,(%eax)
 719:	73 74                	jae    78f <.stabstr+0x78f>
 71b:	61                   	popa   
 71c:	72 74                	jb     792 <.stabstr+0x792>
 71e:	3a 70 28             	cmp    0x28(%eax),%dh
 721:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 724:	29 00                	sub    %eax,(%eax)
 726:	65 6e                	outsb  %gs:(%esi),(%dx)
 728:	64 3a 70 28          	cmp    %fs:0x28(%eax),%dh
 72c:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 72f:	29 00                	sub    %eax,(%eax)
 731:	2e                   	cs
 732:	2f                   	das    
 733:	78 38                	js     76d <.stabstr+0x76d>
 735:	36                   	ss
 736:	2e                   	cs
 737:	68 00 6d 65 6d       	push   $0x6d656d00
 73c:	2e 63 00             	arpl   %ax,%cs:(%eax)
 73f:	2e                   	cs
 740:	2f                   	das    
 741:	78 38                	js     77b <.stabstr+0x77b>
 743:	36                   	ss
 744:	2e                   	cs
 745:	68 00 6d 65 6d       	push   $0x6d656d00
 74a:	2e 63 00             	arpl   %ax,%cs:(%eax)
 74d:	2e                   	cs
 74e:	2f                   	das    
 74f:	78 38                	js     789 <.stabstr+0x789>
 751:	36                   	ss
 752:	2e                   	cs
 753:	68 00 6d 65 6d       	push   $0x6d656d00
 758:	2e 63 00             	arpl   %ax,%cs:(%eax)
 75b:	2e                   	cs
 75c:	2f                   	das    
 75d:	78 38                	js     797 <.stabstr+0x797>
 75f:	36                   	ss
 760:	2e                   	cs
 761:	68 00 6d 65 6d       	push   $0x6d656d00
 766:	2e 63 00             	arpl   %ax,%cs:(%eax)
 769:	2e                   	cs
 76a:	2f                   	das    
 76b:	78 38                	js     7a5 <.stabstr+0x7a5>
 76d:	36                   	ss
 76e:	2e                   	cs
 76f:	68 00 6d 65 6d       	push   $0x6d656d00
 774:	2e 63 00             	arpl   %ax,%cs:(%eax)
 777:	2e                   	cs
 778:	2f                   	das    
 779:	78 38                	js     7b3 <.stabstr+0x7b3>
 77b:	36                   	ss
 77c:	2e                   	cs
 77d:	68 00 6d 65 6d       	push   $0x6d656d00
 782:	2e 63 00             	arpl   %ax,%cs:(%eax)
 785:	2e                   	cs
 786:	2f                   	das    
 787:	78 38                	js     7c1 <memtest+0x791>
 789:	36                   	ss
 78a:	2e                   	cs
 78b:	68 00 6d 65 6d       	push   $0x6d656d00
 790:	2e 63 00             	arpl   %ax,%cs:(%eax)
 793:	72 65                	jb     7fa <memtest+0x7ca>
 795:	74 3a                	je     7d1 <memtest+0x7a1>
 797:	72 28                	jb     7c1 <memtest+0x791>
 799:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 79c:	29 00                	sub    %eax,(%eax)
 79e:	65 6e                	outsb  %gs:(%esi),(%dx)
 7a0:	64 3a 72 28          	cmp    %fs:0x28(%edx),%dh
 7a4:	30 2c 34             	xor    %ch,(%esp,%esi,1)
 7a7:	29 00                	sub    %eax,(%eax)
 7a9:	68 65 68 65 3a       	push   $0x3a656865
 7ae:	47                   	inc    %edi
 7af:	28 30                	sub    %dh,(%eax)
 7b1:	2c 34                	sub    $0x34,%al
 7b3:	29 00                	sub    %eax,(%eax)

Disassembly of section .comment:

00000000 <.comment>:
#include <header.h>
#define EFLAGS_AC_BIT		0x00040000
#define CR0_CACHE_DISABLE	0x60000000

unsigned int hehe,heihei;
unsigned int memtest_sub(unsigned int start, unsigned int end){
   0:	00 47 43             	add    %al,0x43(%edi)
   3:	43                   	inc    %ebx
   4:	3a 20                	cmp    (%eax),%ah
	unsigned int i,*p,old,pat0 = 0xaa55aa55,pat1 = 0x55aa55aa;
	for (i = start;i<=end; i+=4){
   6:	28 47 4e             	sub    %al,0x4e(%edi)
   9:	55                   	push   %ebp
   a:	29 20                	sub    %esp,(%eax)
		p = (unsigned int *) i;
		old = *p;
   c:	34 2e                	xor    $0x2e,%al
		*p = pat0;
		*p ^= 0xffffffff;
   e:	38 2e                	cmp    %ch,(%esi)
  10:	32 20                	xor    (%eax),%ah
  12:	32 30                	xor    (%eax),%dh
		hehe = *p;
  14:	31 33                	xor    %esi,(%ebx)
  16:	31 30                	xor    %esi,(%eax)
  18:	31 37                	xor    %esi,(%edi)
  1a:	20 28                	and    %ch,(%eax)
  1c:	52                   	push   %edx
		if (*p != pat1){
  1d:	65 64 20 48 61       	gs and %cl,%fs:%gs:0x61(%eax)
  22:	74 20                	je     44 <memtest+0x14>
			*p = old;
  24:	34 2e                	xor    $0x2e,%al
		p = (unsigned int *) i;
		old = *p;
		*p = pat0;
		*p ^= 0xffffffff;
		hehe = *p;
		if (*p != pat1){
  26:	38 2e                	cmp    %ch,(%esi)
#define CR0_CACHE_DISABLE	0x60000000

unsigned int hehe,heihei;
unsigned int memtest_sub(unsigned int start, unsigned int end){
	unsigned int i,*p,old,pat0 = 0xaa55aa55,pat1 = 0x55aa55aa;
	for (i = start;i<=end; i+=4){
  28:	32                   	.byte 0x32
  29:	2d                   	.byte 0x2d
  2a:	31 29                	xor    %ebp,(%ecx)
	...

Disassembly of section .eh_frame:

00000090 <.eh_frame>:
		cr0 &= CR0_CACHE_DISABLE;
		lcr0(cr0);
	}
	if (ret==0) return end;
	else return ret -4;
}
  90:	14 00                	adc    $0x0,%al
  92:	00 00                	add    %al,(%eax)
  94:	00 00                	add    %al,(%eax)
  96:	00 00                	add    %al,(%eax)
  98:	01 7a 52             	add    %edi,0x52(%edx)
  9b:	00 01                	add    %al,(%ecx)
  9d:	7c 08                	jl     a7 <.eh_frame+0x17>
  9f:	01 1b                	add    %ebx,(%ebx)
  a1:	0c 04                	or     $0x4,%al
  a3:	04 88                	add    $0x88,%al
  a5:	01 00                	add    %eax,(%eax)
  a7:	00 1c 00             	add    %bl,(%eax,%eax,1)
  aa:	00 00                	add    %al,(%eax)
  ac:	1c 00                	sbb    $0x0,%al
  ae:	00 00                	add    %al,(%eax)
  b0:	00 00                	add    %al,(%eax)
  b2:	00 00                	add    %al,(%eax)
  b4:	30 00                	xor    %al,(%eax)
  b6:	00 00                	add    %al,(%eax)
  b8:	00 41 0e             	add    %al,0xe(%ecx)
  bb:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  c1:	6c                   	insb   (%dx),%es:(%edi)
  c2:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
  c5:	04 00                	add    $0x0,%al
  c7:	00 28                	add    %ch,(%eax)
  c9:	00 00                	add    %al,(%eax)
  cb:	00 3c 00             	add    %bh,(%eax,%eax,1)
  ce:	00 00                	add    %al,(%eax)
  d0:	30 00                	xor    %al,(%eax)
  d2:	00 00                	add    %al,(%eax)
  d4:	60                   	pusha  
  d5:	00 00                	add    %al,(%eax)
  d7:	00 00                	add    %al,(%eax)
  d9:	41                   	inc    %ecx
  da:	0e                   	push   %cs
  db:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
  e1:	41                   	inc    %ecx
  e2:	86 03                	xchg   %al,(%ebx)
  e4:	44                   	inc    %esp
  e5:	83 04 02 55          	addl   $0x55,(%edx,%eax,1)
  e9:	c3                   	ret    
  ea:	41                   	inc    %ecx
  eb:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
  ef:	04 04                	add    $0x4,%al
  f1:	00 00                	add    %al,(%eax)
	...
