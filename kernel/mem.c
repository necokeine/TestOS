#include <header.h>
#define EFLAGS_AC_BIT		0x00040000
#define CR0_CACHE_DISABLE	0x60000000

unsigned int hehe,heihei;
unsigned int memtest_sub(unsigned int start, unsigned int end){
	unsigned int i,*p,old,pat0 = 0xaa55aa55,pat1 = 0x55aa55aa;
	for (i = start;i<=end; i+=4){
		p = (unsigned int *) i;
		old = *p;
		*p = pat0;
		*p ^= 0xffffffff;
		hehe = *p;
		if (*p != pat1){
			*p = old;
			return i;
		}
		hehe = *p;
		*p ^= 0xffffffff;
		if (*p != pat0){
			*p = old;
			return i;
		}
		*p = old;
	}
	return 0;
}

unsigned int memtest(unsigned int start,unsigned int end){
	char flg486 = 0;
	unsigned int eflg,cr0,i;
	eflg = read_eflags();
	eflg |= EFLAGS_AC_BIT;
	write_eflags(eflg);
	eflg = read_eflags();
	if ((eflg & EFLAGS_AC_BIT) != 0){
		flg486 = 1;
	}
	eflg &= ~EFLAGS_AC_BIT;
	write_eflags(eflg);
	if (flg486 != 0){
		cr0 = rcr0();
		cr0 |= CR0_CACHE_DISABLE;
		lcr0(cr0);
	}

	unsigned int ret = memtest_sub(start,end);
	
	if (flg486 != 0){
		cr0 = rcr0();
		cr0 &= ~CR0_CACHE_DISABLE;
		lcr0(cr0);
	}
	if (ret==0) return end;
	else return ret -4;
}


