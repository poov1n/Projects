<h1>File Integrity Monitor</h1>


<h2>Description</h2>
Integrity in CIA Triad means the correctness in a file. If a data gets changed or edited an alert needs to be triggered so that an analyst or others can check the integrity 
This projects is to create a FIM – File integrity Monitor <a href= "https://github.com/V4g4b0nd/Projects/blob/main/FIM(File%20Integriy%20Manager)/FIMscript.ps1"> Shell Script <a/> 

FIM – is to monitor some important files and is designed to provide an alert once it gets modified
<br />

<h2>Languages and Utilities Used</h2>

- <b>PowerShell</b> 
- <b>Virtual machine in VMWARE</b>

<h2>Environments Used </h2>

- <b>Windows 10</b> (21H2)

<h2>Procedure:</h2>

<p align="Left">
- Create a Windows VM Machine in VMware or any virtualisation platform (We can also use primary     computer if running a Windos OS ) <br />
- Create or provide the path of the files that needs to be checked inside the Script <br />
- Pass the file path for saving or taking the baseline for checking <br />
  
<h2>Script Process Walkthrough:</h2>

<p>
  Start the powershell script in powershell ISE <br/>
       Ask user what they want to do <br />
       A) Collect new baseline <br />
       B) Begin monitoring files with saved baseline <br />

           A) --> Calculate Hash value from Target files (Hash is taking the digital
                    thumbprint of a text file and stores in a text file)
              --> Store the file or Hash pairs in Baseline.txt

           B) --> Load file or Hash pair from the existing Baseline.txt
              --> Loop through each target file, calculate the hash and compare the
                  file or hash to baseline.txt
              --> Notify user if a file is changed or deleted
              --> If a file's actual hash is different than what is recorded in baseline,
                    print in the screen.
              --> If a file is deleted, says Integrity Compromised !!!
              
</p>  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  


<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>



