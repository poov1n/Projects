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
- Add the powershell script to the VM and run in powershell ise
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
<img src="https://i.imgur.com/FKqfhxf.png" height="30%" width="30%" alt="Sample File Upload"/>
<br />
Run a Smple query of the custom log and wait for it to reflect (Might take more than 15 minutes) <br/>
<img src="https://imgur.com/CD7Lqhu.png" height="30%" width="30%" alt="Sample Query"/>
<br />
Add extra fields like Langitude, Longitude etc.. from the log by rightclicking one sample <br/>
<img src="https://imgur.com/An3U1Yv.png" height="30%" width="30%" alt="Custom log1"/>
<br />
Right click on field value of the log and add field titles 
<br/> <img src="https://imgur.com/MqDxelt.png" height="30%" width="30%" alt="field title"/>
<br />
Check all the fields and save extraction (This is the use of sample log)
<br/> <img src="https://imgur.com/MqDxelt.png" height="30%" width="30%" alt="Extraction"/>
<br />
If highlighted incorrectly, modify each target and extraxt value
<br/> <img src="https://imgur.com/mliLel8.png" height="30%" width="30%" alt="Error checking"/>
<br />
Custom Field Values
<br/> <img src="https://imgur.com/qTkxl8B.png" height="30%" width="30%" alt="Custom Fields"/>
<br />

After setting up do a failed login and test whether the log is coming in and sorting itself out 
</p> 
   <br/>
  
<h2>Setting Up Sentinel for Geo mapping:</h2>

<p align="Left">
Go to workbooks inside Microsoft Sentinal <br/>
   <img src="https://imgur.com/q1hPdME.png" height=30% width =30% alt= "sentinal"/>
  <br />
Edit and remove the existing template and click add on the new workbook  <br/>
  <img src="https://imgur.com/zGu1kL6.png" height=30% width =30% alt= "New Workbook"/>
  <br />
Click on add query and run it <br/> 
  <img src="https://imgur.com/V9gDATs.png" height=30% width =30% alt= "Add query"/>
  <br />
We would be able to see the logs coming in <br/> 
  <img src="https://imgur.com/7t5wqr2.png" height=30% width =30% alt= "Logs"/>
  <br />
Click visualization and select Map <br/> 
  <img src="https://imgur.com/DYUXEUT.png" height=30% width =30% alt= "Maps"/>
  <br />
On Map settings select the appropriate custom field values in Lattitude, Longitude, Country and so on <br/> 
  <img src="https://imgur.com/OXaJzie.png" height=30% width =30% alt= "Maps values"/>
  <br />
Click appy and wait for some hours, we would be able to see the Brute force Attacks being mapped in the World Map<br/> 
  <img src="https://imgur.com/XWCxSNU.png" height=30% width =30% alt= "Attacks"/>
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
