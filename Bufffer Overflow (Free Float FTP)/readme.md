<h1>Practical Buffer Overflow with  FreeFloat FTP Server</h1>

<h2>Description</h2>
An explanation of the steps to follow while performing a buffer overflow hack and showing it off on the FreeFloat FTP Server. 
<br />

<h2>Lab Setup</h2>

- <b>Virtual box</b> 
- <b>A windows XP machine </b>
- <b>Favourite Pentest Distro</b>
- <b>Favourite Code editor</b>

<h2>Softwares and Tools</h2>

- <b>Download or Install <a href = "https://debugger.immunityinc.com/ID_register.py">Immunity Debugger</a> and the <a href = "https://www.exploit-db.com/exploits/23243">Free Float</a> FTP server onto the Windows XP</b> 
- <b>Download the <a href = "https://github.com/corelan/mona/blob/master/mona.py">mona.py</a> file to Windows XP</b>
- <b>Need Metasploit and SPIKE tools on the Pentest box (Here, I won't be using spike script but would manually exploit the application)</b>
- <b>Note: Turn off the Windows Antivirus as the FTP server would get blocked by Windows Security</b>

<h2>The Memory Anatomy</h2>
<p align="Left">
<img src = "https://www.coengoedegebure.com/content/images/2018/04/ram-1.png" height="20%" width="20%"></br>
-> Kernel - Contains the command-line parameters that are passed to the programme or variables</br>
-> Stack - Big area of memory where large objects like File, Images are stored</br>
-> Heap - Holds the local variables for each of the functions</br>
-> Data - Uninitialized and initialized variables are stored here</br> 
-> Text - Contains the actual code, it is a read-only area</br>

<h3>The STACK</h3>
<img src = "https://imgur.com/A84R4lE.png" height="40%" width="40%"></br>
->So in stack, we have ESP at the top and EBP at the bottom. In between we have the buffer space. Buffer space will fill up with characters and it would write downwards towards EBP.</br>
->So normally let's say we have a bunch of A characters (AAAAAA…), the A characters would fill up the space in the buffer and stops at EBP (as long as we are sanitizing our buffer space),
If not and we have characters that require more space than the existing buffer space, it will overwrite the EBP and gets to EIP.</br>
->EIP is called a return address, so if we could control the EIP, we could point it towards whatever code we want. So if we direct it towards some malicious code that could return us a reverse shell, we have made a successful buffer overflow attack
</br>

<h3>Buffer Process</h3>
-> Spiking - finding a part of the program that is vulnerable</br>
-> Fuzzing - Sending a bunch of characters to the program to break it</br>
-> Finding Offset - Figuring out at which part we break it</br>
-> Overwriting the EIP</br>
-> Finding the module</br>
-> Generate shellcode and get root access</br>

<h2>Attack Walkthrough</h2>
So, the Freefloat FTP Server is an application which is vulnerable to Buffer Overflow. We need to run both the Immunity Debugger and FTP server as an administrator.</br>
We can import the FTP Server to Immunity in two ways, whether we can File > Open > FTP server or File > Attach > Attach the FTP server to Immunity. 
<img src ="https://imgur.com/MKRLeRq.png"height="40%" width="40%"></br>
<img src ="https://imgur.com/jtMd1H1.png"height="40%" width="40%"></br>
We can see that the application is Paused in Immunity (In the bottom right Corner). For testing the application it should be in Running mode.
We can press the play button to run the Programme or press F9 on the keyboard.</br>
Some Immunity Shortcuts to save our time.</br>

    Press f9 or Play button to start the server!
    Ctrl + F2 to Restart the programme
<h3>1. Spiking</h3>
Spiking is used to find a part of a programme which is vulnerable to Buffer Overflow</br>
Start the programme in Immunity and Connect to the FTP server from the Attack box using NetCat</br>

    nc 192.168.1.48 21

Spiking can be done in two ways, we can either manually provide a set of characters to the application and make it crash or use the generic_send_tcp command to break the programme.</br>
FTP allows a command USER, PASS and so on. So let's try to add 1000 "A" characters to the USER command and see whether it crashes the programme.</br>

It crashed the programme. Let's see how many characters it took before crashing it. For getting the accurate total value of the buffer, we could subtract the EIP from ESP</br>
Right-click the ESP value and select Follow in Dump</br>

<img src = "https://imgur.com/vzwIRn1.png" height="40%" width="40%"></br>
In the bottom left box, we can see the "A" characters, lets note down the pointers from which the character started till it crashed.</br>
<img src = "https://imgur.com/EcszUSm.png" height="40%" width="40%"></br>

<img src = "https://imgur.com/CldzkMs.png" height="40%" width="40%"></br>

We can see it started from 0291FAE8 and ended in 0291FEC8 (The hex value of "A" is 41)</br>

Let's try to subtract the value in Python to see the total number of  characters</br>
To do that we need to add '0x' in the beginning</br>

<img src = "https://imgur.com/mZunjdu.png" height="40%" width="40%"></br>
So a total of 920 lengths of characters would crash the programme.</br>




    

    

     


  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  


<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
