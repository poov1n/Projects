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
 
<h2>The Memory Anatomy</h2>
<p align="Left">
<img src = "https://www.coengoedegebure.com/content/images/2018/04/ram-1.png" height="20%" width="20%"></br>
-> Kernel - Contains the command-line parameters that are passed to the programme or variables</br>
-> Stack - Big area of memory where large objects like File, Images are stored</br>
-> Heap - Holds the local variables for each of the functions</br>
-> Data - Uninitialized and initialized variables are stored here</br> 
-> Text - Contains the actual code, it is a read-only area</br>

<h3>The STACK</h3>
<img src = "https://imgur.com/A84R4lE.png" height="40%" width="40%"</br>
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



  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  


<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
