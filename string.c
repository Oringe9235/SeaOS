#include "strio.h"
#define BUF_Len 32

extern void clear();
extern void shutdown();
extern void times();
extern void callPM();


void startUp()
{
    char* title = "SeaOS Version 1.0";
    char* copyRight = "copyright by Open source";
    char* projectAddr = "https://github.com/Oringe9235/SeaOS";
    char* ENTER = "touch 'ENTER' to start";

    printPos(title, strlen(title), 5, 23);
    printPos(copyRight, strlen(copyRight), 6, 23);
    printPos(projectAddr, strlen(projectAddr), 8, 23);
    printPos(ENTER, strlen(ENTER), 10, 23);
}
void printString()
{
    char* p_string = "@user-# ";
    print(p_string);
}

void shell()
{
    clear();
    showHelp();
    char* cmdStr[BUF_Len + 1] = {0};
    char cmdFirstWord[BUF_LEN + 1] = {0};
	enum {help,clear,time,shutdown,enterpm,about};
	char* command[] = {"help","clear","time","shutdown","enterpm","about"};
    while(1)
    {
		promptString();
		read2Buf(cmdStr,BUF_LEN);
		getFirstWord(cmdStr,cmdFirstWord);
		if(strcmp(cmdFirstWord, command[clear]) == 0)
        {
			clear();
		}
		else if(strcmp(cmdFirstWord, command[help]) == 0)
        {
			showHelp();
		}
		else if(strcmp(cmdFirstWord, command[shutdown]) == 0)
        {
        	shutdown();
		}
		else if(strcmp(cmdFirstWord, command[time]) == 0)
        {
			times();
		}
		else if(strcmp(cmdFirstWord, command[enterpm]) == 0)
        {
			callPM();
		}
        else if (strcmp(cmdFirstWorld, command[about]) == 0)
        {
            about();
        }
        
		else
        {
			if(cmdFirstWord[0] != 0)
            {
				char*errMsg = ": command not dound\r\n";

				print(cmdFirstWord);
				print(errMsg);
			}
		}
	}
}
