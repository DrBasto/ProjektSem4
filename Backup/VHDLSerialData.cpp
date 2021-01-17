#include <iostream>
#include <ctime>
#include <windows.h>

using namespace std;

const int maxPeople = 10;

int main()
{
    // Open serial port
    HANDLE serialHandle;

    serialHandle = CreateFileA("\\\\.\\COM5", GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL);

    if (serialHandle == INVALID_HANDLE_VALUE)   //Check Connection
        cout << "Error in opening serial port\n";
    else
        cout << "opening serial port successful\n";

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

    // Receiving Data
    byte TempChar = 0; //Temporary character used for reading
    DWORD NoBytesRead;
    byte headcountOLD = 0;
    byte event = 0;
    byte headcount = 0;
    bool runOnce= true;
    while (true) {
        ReadFile(serialHandle,           //Handle of the Serial port
            &TempChar,       //Temporary character
            sizeof(TempChar),//Size of TempChar
            &NoBytesRead,    //Number of bytes read
            NULL);
        if(runOnce){
            headcount = TempChar >> 2;
            runOnce = false;
        }
        if (headcount != headcountOLD) {  //Compare Current Value with Old one
            event = TempChar & 3;
            event = (int)event;
            headcount = TempChar >> 2;
            cout << time(0) << " " << (int)headcount << "\n";
            cout << (int)event << "\n";
            //if(headcount >= maxPeople)
              //  cout << "Max. number of People is reached\n";
            switch(event){
                case 0:
                    // idle
                break;
                case 1:
                    cout << "Someone ENTERED\n";
                break;
                case 2:
                    cout << "Someone LEFT\n";
                break;
                case 3:
                    cout << "Max. number of People is reached\n";
                break;
                default:
                    cout << "Error\n";
                break;
            }        
        }
        headcountOLD = headcount;     //Save current number
    }

    CloseHandle(serialHandle);//Closing the Serial Port

    return EXIT_SUCCESS;
}