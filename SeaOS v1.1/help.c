#include "stringio.h"

void showHelp()
{
    clear();
    char* menuForHelp = "Command Menu:";
    char* helpList_1 = "\tclear     -[clear word on the screen]";
    char* helpList_2 = "\ttime      -[print time for now]";
    char* helpList_3 = "\tenterpm   -[enter protect mode]";
    char* helpList_4 = "\tshutdown  -[take off the power]";
    char* helpList_5 = "\thelp      -[get help for command]";
    char* helpList_6 = "\tabout     -[see the SeaOS's instructions]";

    printPos(menuForHelp, strlen(menuForHelp),2,2);
    printPos(helpList_1, strlen(helpList_1),3,2);
    printPos(helpList_2, strlen(helpList_2),4,2);
    printPos(helpList_3, strlen(helpList_3),5,2);
    printPos(helpList_4, strlen(helpList_4),6,2);
    printPos(helpList_5, strlen(helpList_5),7,2);
    printPos(helpList_6, strlen(helpList_6),8,2);
}
