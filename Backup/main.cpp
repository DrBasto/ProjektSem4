#include <iostream>
#include <windows.h>
#include <ctime>
#include <tchar.h>

int main() {
// Open serial port
    HANDLE serialHandle;
    OVERLAPPED o;
    DWORD dwBytesTransferred;
    DWORD dwCommModemStatus;
    DWORD dwEvtMask;

    serialHandle = CreateFileA("\\\\.\\COM5",
                              GENERIC_READ | GENERIC_WRITE, //allow read/write
                              0,
                              NULL,
                              OPEN_EXISTING, //Open rather than create
                              FILE_ATTRIBUTE_NORMAL, //not overlapped
                              NULL);

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

    // Create an event object for use by WaitCommEvent.

    o.hEvent = CreateEvent(
            NULL,   // default security attributes
            TRUE,   // manual-reset event
            FALSE,  // not signaled
            NULL    // no name
    );


    // Initialize the rest of the OVERLAPPED structure to zero.
    o.Internal = 0;
    o.InternalHigh = 0;
    o.Offset = 0;
    o.OffsetHigh = 0;

//Time
    time_t curr_time;
    curr_time = time(NULL);

    tm *tm_local = localtime(&curr_time);
    std::cout << "Current local time : " << tm_local->tm_hour << ":" << tm_local->tm_min << ":" << tm_local->tm_sec;

    //lööp
    while(true){
        unsigned char Buffer[2];

        SetCommMask(serialHandle, EV_RXCHAR | EV_ERR);    //receive character event
        if (WaitCommEvent(serialHandle, &dwEvtMask, &o)){

            if (dwCommModemStatus & EV_RXCHAR) {
                ReadFile(serialHandle, &Buffer, 2, &dwBytesTransferred, 0); //read 2
            }else if (dwCommModemStatus & EV_ERR) {
                //error message
            }
            if (Buffer[1]== '+'){
                std::cout<< "person entered";
                std::cout << "Current local time : " << tm_local->tm_hour << ":" << tm_local->tm_min << ":" << tm_local->tm_sec;
            } else if(Buffer[1] == '-'){
                std::cout << "person left";
                std::cout << "Current local time : " << tm_local->tm_hour << ":" << tm_local->tm_min << ":" << tm_local->tm_sec;
            }else if (Buffer[1] == '!'){
                std::cout << "max. headcount reached";
                std::cout << "Current local time : " << tm_local->tm_hour << ":" << tm_local->tm_min << ":" << tm_local->tm_sec;
            }
            std::cout<< "Current Headcount: " << Buffer[0];
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

