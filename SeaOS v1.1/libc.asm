#include "stringio.h"
#define bufLen 32

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
    "Command List:\r\n"
    "\rclear    -[clear the screen]\r\n"
    "\rtimes    -[get the time for now]\r\n"
    "\rshutdown -[shutdown the power]\r\n";

    print_f(help_str);
}
void shell()
{

}
