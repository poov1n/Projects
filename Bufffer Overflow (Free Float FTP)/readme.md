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
<h3>1. Spiking and Fuzzing</h3>
Spiking is used to find a part of a programme which is vulnerable to Buffer Overflow</br>
Start the programme in Immunity and Connect to the FTP server from the Attack box using NetCat</br>

    nc 192.168.1.56 21
<img src = "https://imgur.com/ojDMkSv.png" height="40%" width="40%"></br>
Spiking can be done in two ways, we can either manually provide a set of characters to the application and make it crash or use the generic_send_tcp command to break the programme.</br>
FTP allows a command USER, PASS and so on. So let's try to add 1000 "A" characters to the USER command and see whether it crashes the programme. We can use Python to print 1000 characters and pass it to the FTP server.</br>
<img src = "https://imgur.com/Hvs1sSk.png" height="40%" width="40%"></br>
The application paused in the Immunity showing that the programme crashed. Let's see how many characters it took before crashing it. To get the accurate total value of the buffer, we could subtract the ESP and EIP</br>
<img src = "https://imgur.com/6u2eABR.png" height="40%" width="40%"></br>
In the Registers, we could see the ESP and EIP values. We can see the "A" characters that we passed to the application.In the EIP we could see it is showing as 41414141 which states that EIP holds 4 bytes of characters.(41 is the hex value of "A")
Right-click the ESP value and select Follow in Dump</br>
<img src = "https://imgur.com/9YfnZou.png" height="40%" width="40%"></br>
In the bottom left box, we can see the "A" characters, lets note down the Address from which the character started till it crashed.</br>
<img src = "https://imgur.com/lxE8ncn.png" height="40%" width="40%"></br>
<img src = "https://imgur.com/OacB96Y.png" height="40%" width="40%"></br>

We can see the characters started from 00B3FB3C and ended in 00B3FF0C </br>
Let's try to subtract the value in Python to see the total number of  characters</br>
To do that we need to add '0x' in the beginning</br>

    python3
    0x00B3FB3C - 0x00B3FF0C

<img src = "https://imgur.com/HUK7a7x.png" height="40%" width="40%"></br>
So a total lengths of **976** characters would crash the programme.</br>

<h3>2. Finding Offset</h3>
<p>
For finding the Offset we could use the pattern_create and pattern_offset tools of Metasploit</br> 
So Offset is the part where the characters would start moving into the EIP</br>
First, let's create random characters with 976 strings long using msf-pattern_create</br>

        msf-pattern_create -l 976
<img src = "https://imgur.com/CYRw10p.png" height="40%" width="40%"></br>
Pass this string onto the application and note down the EIP value</br>
**Note= After each time the programme crashes, we need to restart it inside the immunity debugger using ctrl+F2 and the programme should be in Running mode.**</br>

<img src = "https://imgur.com/8CY3x4c.png" height="40%" width="40%"></br>

The programme is crashed and the EIP value is **37684136** </br>
<img src = "https://imgur.com/fIQdoaa.png" height="40%" width="40%"></br>

Let's find the offset value using msf-pattern_offset. We need to pass the character length used along with the EIP value in query</b>

    msf-pattern_offset -l 976 -q 37684136
<img src = "https://imgur.com/Kgmuv0B.png" height="40%" width="40%"></br>

We found the offset at **230**

<h3>2. Overwriting the EIP</h3>
Let's overwrite and control the EIP.</b>
Now we know the total length is 976 and the offset is at 230. The EIP contains a total of 4 characters and it starts after the offset value.</br>
To figure out whether we can predict the EIP let's fill in the character "A" till the offset value and the next 4 characters as "B" followed by "C" till the end of our total length</b>

    Total Character length = 976
    Offset = 230 (Filled by "A")
    EIP length = 4 (Filled by "B")
    Remaining Character length = 976-230-4 = 742 (Filled by "C")
Let's pass it to the application and see whether we would get **42424242** as the EIP value (42 is the hex value of "B")</br>
<img src = "https://imgur.com/j6SFBW5.png" height="40%" width="40%"></br>    
The application crashed and we can see the EIP is overwritten by **42424242** (Character "B").</br>
<img src = "https://imgur.com/90Tu7Fk.png" height="40%" width="40%"></br>

<h3>3. Finding the Modules</h3>
<h4>3.1 Setting up Mona</h4>
For finding the right Module, we could use Mona.py script for finding the right modules and files which we could use for exploitation.</b>
For setting up Mona.py, we just need to copy the script to the below location</br>

    c:\Program Files\Immunity Inc\Immunity Debugger\PyCommands
    
<img src = "https://imgur.com/f6PPM70.png" height="40%" width="40%"></br>
To invoke Mona just type **!mona** on the bottom space and press Enter</br>
<img src = "https://imgur.com/SKiMCFK.png" height="40%" width="40%"></br>

<h4>3.2 Finding Bad characters </h4>
So before finding the module, we need to figure out which characters are good for the code and which all are bad.</br>
We can find it by running all the hex characters through the program and how it parses out. </br>
We are doing this because some characters may be used by the application for a particular function and we do not want to include it in our code, which would break it.</br>
        
    badchars = ("\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0b\x0c\x0e\x0f\x10"
	"\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
	"\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30"
	"\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40"
	"\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50"
	"\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60"
	"\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70"
	"\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80"
	"\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90"
	"\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0"
	"\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf\xb0"
	"\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0"
	"\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0"
	"\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0"
	"\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef\xf0"
	"\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff")

For this let's use a Python script, to make our life easier! </br>






  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  



<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
