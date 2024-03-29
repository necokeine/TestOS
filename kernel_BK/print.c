#include "header.h"


void printdebug(int i,int x)
{
char font[30];
sprintf(font,"Debug:var=%x" ,i);
puts8((char *)VRAM ,320,x,150,1,font);

}

void itoa(int value,char *buf){
    char tmp_buf[10] = {0};
    char *tbp = tmp_buf;
    if((value >> 31) & 0x1)
    { /* neg num */
        *buf++ = '-';//得到负号
        value = ~value + 1; //将负数变为正数
    }
    
    do
    {
        *tbp++ = ('0' + (char)(value % 10));//得到低位数字
        value /= 10;
    }while(value);
    
    
    while(tmp_buf != tbp)
    {
      tbp--;
      *buf++ = *tbp;

    }
    *buf='\0';
    
    
}
static  inline char fourbtoc(int value){
    if(value >= 10)
        value = value - 10 + 65;
    else
        value = value + 48;
    return value;
}

void xtoa(unsigned int value,char *buf){
    char tmp_buf[30] = {0};
    char *tbp = tmp_buf;

    *buf++='0';
    *buf++='x';
  
    do
    {
        // *tbp++ = ('0' + (char)(value % 16));//得到低位数字
	*tbp++=fourbtoc(value&0x0000000f);
        
        //*tbp++ = ((value % 16)>9)?('A' + (char)(value % 16-10)):('0' + (char)(value % 16));//得到低位数字
        value >>= 4;
    }while(value);
    
    
    while(tmp_buf != tbp)
    {
      tbp--;
      *buf++ = *tbp;

    }
    *buf='\0';
    
    
}




//实现可变参数的打印，主要是为了观察打印的变量。
void sprintf(char *str,char *format ,...)
{
  
   int *var=(int *)(&format)+1; //得到第一个可变参数的地址
   char buffer[10];
   char *buf=buffer;
  while(*format)
  {
      if(*format!='%')
      {
	*str++=*format++;
	continue;
      }
      else
      {
	format++;
	switch (*format)
	{
	  case 'd':itoa(*var,buf);while(*buf){*str++=*buf++;};break;
	  case 'x':xtoa(*var,buf);while(*buf){*str++=*buf++;};break;
	  case 's':buf=(char*)(*var);while(*buf){*str++=*buf++;};break;
	  
	}
	buf=buffer;
	var++;
	format++;
	
      }
    
  }
  *str='\0';
  
}

void puts8(char *vram ,int xsize,int x,int y,char color,char *font)//x=0 311 y=0 183
{
  
 while(*font)
 {
    if(*font=='\n')
    {
      x=0;
      y=y+16;
      
    }
    else
    {  
    putfont8((char *)vram ,xsize,x,y,color,(char *)(Font8x16+(*font)*16));
    x+=8;
    if(x>312)
       {
	  x=0;
	  y+=16;
	  if(y>183)
	  {
	    x=0;
	    y=0;
	    
	  }
        }    
    }
    
    font++;
}
  
}

void putfont8(char *vram ,int xsize,int x,int y,char color,char *font)//x=0 311 y=0 183
{
  int row,col;
  char d;
  for(row=0;row<16;row++)
  {
    d=font[row];
    for(col=0;col<8;col++)
    {
      if(d&(0x80>>col))
      {
	vram[(y+row)*xsize+x+col]=color;
	
      }
      else
	;
	//vram[(y+row)*xsize+x+col]=15;//for debug
      
    }
    
  }
  return;
  
}
//print string: big string
void puts16(char *vram ,int xsize,int x,int y,char color,char *font)
{
  unsigned short  *pt;
  while(*font)
  {
    if(*font=='\n')
    {
      x=0;
      y=y+24;
      
    }
    else
    {
	pt=(unsigned short *)((*font)*24+ASCII_Table);
	putfont16(vram ,xsize,x,y,color,pt);
	x=x+16;
	   
	   
    }
    
     font++;
      
  }
  
}
void putfont16(char *vram ,int xsize,int x,int y,char color,unsigned short *font)//x=0 311 y=0 183
{
  int row,col;
  unsigned short  d;
  unsigned short *pt=(unsigned short *)(font-32*24);
  for(row=0;row<24;row++)
  {
    d=pt[row];
    for(col=0;col<16;col++)
    {
       if( (d&(1 << col) ))
     // if((d<<col)&0x0001)
      {
	vram[(y+row)*xsize+x+col]=color;
	
      } 
      else
	;
	//vram[(y+row)*xsize+x+col]=15;//for debug
      
    }
    
  }
  return;
  
}

