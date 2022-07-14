#include <stdint.h>
#include "about.c"
#include "help.c"

extern void printPos(char* msg, uint16_t len, uint8_t row, uint8_t col);
extern void putchar(char c);
extern char getch();
extern void about();
extern void showHelp();

uint16_t strlen(char* str)
{
    uint16_t count = 0;
    while (str[count++] != 0);
    return count - 1;
    
}
uint8_t strcmp(char* str1,char* str2){
	int i = 0;
	while(1){
		if(str1[i] == 0 || str2[i] == 0)
			break;
		if(str1[i] != str2[i])
			break;
		i++;
	}
	return (str1[i] - str2[i]);
}
// tudo
void print(char* str)
{
    uint16_t len = strlen(str);
    for (int i = 0; i < len; i++)
    {
        putchar(str[i]);
    }
}

void readBuf(char* buffer, uint16_t max_Len){
	int i = 0;
	while(1)
	{
		char temp = getch();
		if(!(temp == 0x0D || temp == '\b' || (temp >= 32 && temp <= 127)))
		{
			continue;
		}
		if(i > 0 && i < max_Len - 1)
		{
			if(temp == 0x0D)
			{
				break;	
			}
			else if(temp == '\b')
			{
				putchar('\b');
				putchar(' ');
				putchar('\b');
				i--;
			}
			else
			{
				 putchar(temp);
				 buffer[i] = temp;
				 i++;
			}
		}
		else if(i >= max_Len - 1)
		{
			if(temp == '\b')
			{
				putchar('\b');
				putchar(' ');
				putchar('\b');
				i--;
			}else if(temp == 0x0D)
			{
				break;
			}
		}
		else if(i <= 0)
		{
			if(temp == 0x0D)
			{
				break;
			}
			else if(temp != '\b')
			{
				putchar(temp);
				buffer[i] = temp;
				i++;
			}
		}
	}
	putchar('\r');
	putchar('\n');
	buffer[i] = 0;
}



