/*
-- C++ File
-- Author:	Sebastian Romero 
-- 			Bahadir Ülkü
-- Last edited: 19.01.2021
*/

#include <iostream>
#include <ctime>
#include <windows.h>

int main()
{
    // Open serial port
    HANDLE serialHandle;

    serialHandle = CreateFileA("\\\\.\\COM5", GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL);

    if (serialHandle == INVALID_HANDLE_VALUE)   //Check Connection
        std::cout << "Error in opening serial port\n";
    else{
        std::cout << "Opening serial port successful\n";
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
        std::cout << "HELLO WORLD!" << "\nThis program is meant to run with an FPGA, verify that\n";
        std::cout << "\nTime : " << tm_local->tm_hour << ":" << tm_local->tm_min << ":" << tm_local->tm_sec << "\n";

        // Receiving Data
        char nowByte = 0; //Temporary byte used for reading
        DWORD NoBytesRead;
        char oldByte = nowByte; // Previous byte
        char event = 0;
        char headcount = 0;

        while (true) {
            ReadFile(serialHandle, &nowByte, sizeof(nowByte), &NoBytesRead, NULL);

            if (nowByte != oldByte) {  //Compare Current Value with oldByte one
                event = nowByte & 3;
                event = (int)event;
                headcount = nowByte >> 2;
                std::cout << "\nNumber of people: " << (int)headcount << "\t";
                switch(event){
                    case 0:
                        // idle
                    break;
                    case 1:
                        std::cout << "Person ENTERED\n";
                    break;
                    case 2:
                        std::cout << "Person LEFT\n";
                    break;
                    case 3:
                        std::cout << "Max. number of People is reached\n";
                    break;
                    default:
                        std::cout << "Error: Please contact IT\n";
                    break;
                }
                curr_time = time(NULL);
                tm_local = localtime(&curr_time);
                std::cout << "Time : " << tm_local->tm_hour << ":" << tm_local->tm_min << ":" << tm_local->tm_sec << "\n";        
            }
            oldByte = nowByte;     //Save current byte
        }

        CloseHandle(serialHandle);//Closing the Serial Port
    }
        

    

    return EXIT_SUCCESS;
}

//step 1: open port (filestream)
//step 2: set options (baud, no. of bits, stop bit, parity)
//step 4: check what event byte
//step 5: read time, print message
//step 6: close stream