#include "stringio.h"
#define bufLen 32

extern void about();
extern void help();

void startUp()
{
    char* title = "SeaOS vesion Beta 1.1";
    char* copyright = "Copyright by GUN";
    char* hint = "Please ENTER to start sell";

    printInPos(title, strlen(title), 2, 20);
    printInPos(copyright, strlen(copyright), 3, 20);
    printInPos(hint, strlen(hint), 5, 20);
}
void promptstring()
{
    char* promptstring_str = "@user -#";
    print_f(promptstring_str);
}
void showHelp()
{
    char* help_str = 
    "Shell for SeaOS, Vesion Beta 1.1\r\n"
    "The shell for SeaOS, you can use 'help' to get more command\r\n\n"
    "Commands List:\r\n"
    "\rclear    -[clear the screen]\r\n"
    "\rtimes    -[get the time for now]\r\n"
    "\rshutdown -[shutdown the power]\r\n";

    print_f(help_str);
}
void shell()
{
    clear();
    showHelp();
    char cmdStr[bufLen + 1] = {0};
    char cmdFirstWord[bufLen + 1] = {0};
	enum {help,clear,time,shutdown,enterpm,about};
	char* command[] = {"help","clear","time","shutdown","enterpm","about"};
    while(1)
    {
		promptstring();
		readBuf(cmdStr,bufLen);
		getFirstWord(cmdStr,cmdFirstWord);
		if(strcmp(cmdFirstWord, command[clear]) == 0)
        {
			void clear();
		}
		else if(strcmp(cmdFirstWord, command[help]) == 0)
        {
			showHelp();
		}
		else if(strcmp(cmdFirstWord, command[shutdown]) == 0)
        {
        	void shutdown();
		}
		else if(strcmp(cmdFirstWord, command[time]) == 0)
        {
			//times();
		}
		else if(strcmp(cmdFirstWord, command[enterpm]) == 0)
        {
			//callPM();
		}
        else if (strcmp(cmdFirstWord, command[about]) == 0)
        {
            void about();
        }
        
		else
        {
			if(cmdFirstWord[0] != 0)
            {
				char*errMsg = ": command not dound\r\n";

				print_f(cmdFirstWord);
				print_f(errMsg);
			}
		}
	}
}
