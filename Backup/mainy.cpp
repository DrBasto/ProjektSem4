#include <iostream>
#include <windows.h>
#include <ctime>
#include <tchar.h>

int main() {
// Open serial port
    HANDLE serialHandle;
    OVERLAPPED o;
    DWORD NoBytesRead;

    serialHandle = CreateFileA("\\\\.\\COM5", GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);

// Do some basic settings
    DCB serialParams = { 0 };
    serialParams.DCBlength = sizeof(serialParams);

    GetCommState(serialHandle, &serialParams);
    serialParams.BaudRate = 9600;
    serialParams.ByteSize = 8;
    serialParams.StopBits = ONESTOPBIT;
    serialParams.Parity = NOPARITY;
    SetCommState(serialHandle, &serialParams);

// Set timeouts
    COMMTIMEOUTS timeout = { 0 };
    timeout.ReadIntervalTimeout = 50;
    timeout.ReadTotalTimeoutConstant = 50;
    timeout.ReadTotalTimeoutMultiplier = 50;
    timeout.WriteTotalTimeoutConstant = 50;
    timeout.WriteTotalTimeoutMultiplier = 10;
    SetCommTimeouts(serialHandle, &timeout);



//Time
    time_t curr_time;
    curr_time = time(NULL);

    tm *tm_local = localtime(&curr_time);
    std::cout << "Current local time : " << tm_local->tm_hour << ":" << tm_local->tm_min << ":" << tm_local->tm_sec;

    unsigned char Old;
    //lööp
    while(true){
        unsigned char read_Byte;

        ReadFile(serialHandle, &read_Byte, sizeof(read_Byte), &NoBytesRead, 0); //read 2
        if (read_Byte!=Old){
            Old = read_Byte;
            std::cout<< "\nbuffer:\t" << (int)(read_Byte & 3);
            if ((read_Byte & 3) == 1){
                std::cout<< "\tperson entered";
            } else if((read_Byte & 3) == 2){
                std::cout << "\tperson left";
                
            }else if ((read_Byte & 3) == 3){
                std::cout << "\tmax. headcount reached";
            }
            std::cout << "\nCurrent local time : " << tm_local->tm_hour << ":" << tm_local->tm_min << ":" << tm_local->tm_sec;
            std::cout<< "\nCurrent Headcount: " << (read_Byte>>2);
        }


    }





    CloseHandle(serialHandle);
    return 0;
}
//step 1: open port (filestream)
//step 2: set options (baud, no. of bits, stop bit, parity)
//step 4: check what event byte
//step 5: read time, print message
//step 6: close stream

