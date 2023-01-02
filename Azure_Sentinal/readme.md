<h1>SIEM With Azure Sentinal</h1>


<h2>Description</h2>
This is a project done on mapping failed event login attempts(or a bruteforce attempts) on a windows machine which is open to the internet.
we either turn firewall off or put ICMP requests to allow.
After catching the logs, we run a powershell script inside the machine and by using Workspace Analytics, Log Analytics, Cloud Defender and Azure Sentinal; we pull these log out and maps it to the worldmap and see how many attempts have generated from all around the world
<br />


<h2>Languages and Utilities Used</h2>

- <b>PowerShell</b> 
- <b>Microsoft Azure</b>
- <b>Azure Sentinal, Workspace Analytics and Virtual Machine</b>

<h2>Environments Used </h2>

- <b>Windows 10</b> (21H2)
- <b>Azure</b>

<h2>Procedure:</h2>

<p align="Left">
- Creating a VM in Azure – open to attackers, (disable firewall/enable icmp to be accessed to ping req) <br/>
- Create a Log Analytics workspace and add the VM to that so that it can ingest the logs from it <br/>
- We use the IP from the failed login and programmatically (using PowerShell) maps out the country, place from IP geolocation <br/>
- Create an Azure Sentinel (SIEM) - Microsoft cloud native SIEM—and it create a map that maps all the different attacker data  <br/>
  
<h2>Process Walkthrough:</h2>

<p>
  - Created a new resource group named HoneyPots in Azure <br/>
  - Created a Workspace analytics with the same resource group <br/>
  - Go to cloud security center and turn on defender and put all events to data collection <br/>
  - Connect VM to log analytics workspace <br/>

-Setting up sentinel – *Sentinal helps to visualize the attack data*  

        Select the required log analytics workspace in sentinel
        Select the required log analytics workspace in sentinel
        Start the VM and login using SSH or RDP
        In this project we are using audit logs from windows event viewer (Go to Event Viewer> Windows Logs> Security
  
Create a custom log inside log analytics workspace to insert our custom log into log analytics and add the created log file as sample and put the file path in  the VM under collection path
<br/>
<img src="https://i.imgur.com/FKqfhxf.png" height="50%" width="50%" alt="Sample File Upload"/>
<br />
Run a Smple query of the custom log and wait for it to reflect (Might take more than 15 minutes) <br/>
<img src="https://imgur.com/CD7Lqhu.png" height="50%" width="50%" alt="Sample Query"/>
<br />
<br />
Add extra fields like Langitude, Longitude etc.. from the log by rightclicking one sample <br/>
<img src="https://imgur.com/An3U1Yv.png" height="50%" width="50%" alt="Custom log1"/>
<br />

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







Thanks to **Josh Madakor** for taking the time and effort in teaching this project. It is really fun

Please check the video from Josh --- https://www.youtube.com/watch?v=RoZeVbbZ0o0 --- and see how crazy the attack is happening within a **DAY**
