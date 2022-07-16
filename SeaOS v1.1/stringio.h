#include <stdint.h>

extern void printInPos(char* massage, uint16_t len, uint8_t row, uint8_t col);
extern void putchar(char c);
extern char getcommand();

uint16_t strlen(char* str)
{
    int count = 0;
    while (str[count++] != '\0');
    return count - 1;
}
uint8_t strcmp(char* str_1,char* str_2)
{
    int i = 0;
    while (1)
    {
        if (str_1[i] == '\0' || str_2[i] == '\0')
        {
            break;
        }
        else if (str_1[i] != str_2[i])
        {
            break;
        }
        ++i;
    }
    return str_1[i] - str_2[i];
}
void print_f(char* str)
{
    for (int i = 0, len = strlen(str); i < len; i++)
    {
        putchar(str[i]);
    }
}
void readBuf(char* buffer, uint16_t maxLen)
{
    int i = 0;
    while (1)
    {
        char temp = getcommand();
        if (!(temp == 0xd || temp == '\b' || temp >= 32 && temp <= 127))
        {
            continue;
        }
        else if (i > 0 && i < maxLen - 1)
        {
            if (temp == 0x0d)
            {
                break;
            }
            else if (temp == '\b')
            {
                putchar('\b');
                putchar(' ');
                putchar('\b');
                --i;
            }
            else
            {
                putchar(temp);
                buffer[i] = temp;
                i++;
            }
        }
        else if (i > maxLen - 1)
        {
            if (temp =='\b')
            {
                putchar('\b');
                putchar(' ');
                putchar('\b');
                --i;
            }
            else if (temp == 0x0d)
            {
                break;
            }
        }
        else if (i < 0)
        {
            if (temp == 0x0d)
            {
                break;
            }
            else if (temp != '\b')
            {
                putchar(temp);
                buffer[i] = temp;
                i++;
            }
        }
    }
    putchar('\r');
    putchar('\n');
    buffer[i] = '\0';
}
void getFirstWord(char* str, char* buf)
{
    int i = 0;
    while (str[i] && str[i] != '\0')
    {
        buf[i] = str[i];
        i++;
    }
    buf[i]++;
}
