#include "stringio.h"

void about()
{
    char* logo = 
                    " ____                     _____   ____        \r\n"
                    "/\  _`\                  /\  __`\/\  _`\      \r\n"
                    "\ \,\L\_\     __     __  \ \ \/\ \ \,\L\_\    \r\n"
                    " \/_\__ \   /'__`\ /'__`\ \ \ \ \ \/_\__ \    \r\n"
                    "   /\ \L\ \/\  __//\ \L\.\_\ \ \_\ \/\ \L\ \  \r\n"
                    "   \ `\____\ \____\ \__/.\_\\ \_____\ `\____\ \r\n"
                    "    \/_____/\/____/\/__/\/_/ \/_____/\/_____/ \r\n";
    char* title =  "--SeaOS Version 1.0";
    char* copyRight = "--copyright by GUN-GPLv2";
    char* projectAddr = "https://github.com/Oringe9235/SeaOS";
    
    print(logo);
    print(title);
    print(copyRight);
    print(projectAddr);
}
