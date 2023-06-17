<h1>Splunk Enterprise with remote Hosts</h1>

<h2>Description</h2>
This is a sample project to setup a Splunk SIEM lab and forward alerts and events from remote hosts to the splunk server for monitoring and analysing 
<br />


<h2>Prerequisites</h2>

- <b>Virtual box</b> 
- <b>Ubuntu server iso for hosting our Splunk server</b>
- <b>Windows machine (here using windows 7)</b>
- <b>Splunk Enterprise Edition and Splunk forwarder (we can get a 14 day trial version from Splunk to use the enterprise edition)</b>

<h2>Setup</h2>

- <b>Create 2 VM in Virtual box with Bridged network adapter and enabling Promiscuous mode</b> 
- <b>1 VM with Ubuntu server and other with Windows 7</b>
 
<h2>1. Setting Up Splunk Server</h2>
<p align="Left">
Splunk is a SIEM used to analyze data and logs produced by systems. For using splunk, we need to import the logs and data to Splunk for analysis. 
Splunk has an Universal Forwarder which allows the remote hosts to forward data to the splunk server for monitoring.
Splunk also provides with robust visualization and reporting tools to identify data that interests and provides results and visualize answers in the form of report, chart, graph  etc …
This is used by security team to identify and respond to internal and external attacks
</br>
<p>
->Regiter in Splunk with an account and download the <a href = "https://www.splunk.com/en_us/download/splunk-enterprise.html">Splunk Enterprise(Free Trial)</a><br/>
->Download the Splunk enterprise to the Ubuntu-Server VM and install<br/>
  <img src="https://imgur.com/PUJCFDJ.png" height="50%" width="50%"><br/>
->The Splunk Enterprise would be installed in the /opt directory<br/>
->cd to /opt/splunk/bin and enable boot-start with the command<br/>
        
        Sudo /opt/splunk/bin/splunk enable boot-start
->Accept the license and provide an username and password for the administrator account<br/>
  <img src= "https://imgur.com/LI9E9so.png" height="50%" width="50%"> 
  <br/>
  <img src = "https://imgur.com/fiZnu64.png" height="50%" width="50%"><br/>
->Splunk web console is using port 8000, so we need to allow port 8000 on firewall <br/>


        Checking the status of ufw - "sudo ufw status"
        Enabling ufw - "sudo ufw enable"
        Adding firewall rule - "sudo ufw allow 8000"
  <img src="https://imgur.com/seWGAFJ.png" height="50%" width="50%"><br/>
->Starting splunk 
        
        sudo /opt/splunk/bin/splunk start
  <img src = "https://imgur.com/kd1ghbf.png" height="50%" width="50%">
  <br/>
  <img src = "https://imgur.com/YRlfQti.png" height="50%" width="70%">
->Browse to the "serverip:8000" to access the splunk server<br/>
  <img src = "https://imgur.com/W0tZhh5.png" height="50%" width="50%">
->Login using the created credentials and we would be able to see the Splunk Enterprise <br/>
  <img src = "https://imgur.com/RUjDlHh.png" height="50%" width="50%">

<h2>2. Configuring Splunk server to receive logs</h2>
<p align="Left">
->Click on the settings > Forwarding and Receiving<br/>
   <img src = "https://imgur.com/qVb8KPC.png" height="50%" width="50%"></br>
->Click on Configure Receiving<br/>
   <img src = "https://imgur.com/AY2Gpek.png" height="50%" width="50%"></br>
->Click new receiving port and add the port (9997) from which the data is being forwarded from <br/>
   <img src = "https://imgur.com/yzYT3jw.png" height="50%" width="50%"></br>
->Go back to home and now seleect Indexes on settings<br/>
   <img src = "https://imgur.com/x54Q5ap.png" height="50%" width="50%"></br>
->Create a new index, name it and save, Here the name is "windows" <br/>
  <img src = "https://imgur.com/ETVEaAX.png" height="50%" width="50%"></br>

<h2>3. Installing Splunk Forwarder on Windows(host) machine</h2>
<p align="Left">
->Logon to the windows host machine and download <a href="https://www.splunk.com/en_us/download/universal-forwarder.html?utm_campaign=google_emea_tier2_en_search_brand&utm_source=google&utm_medium=cpc&utm_content=Uni_Forwarder_Demo&utm_term=splunk%20universal%20forwarder&_bk=splunk%20universal%20forwarder&_bt=471686934609&_bm=p&_bn=g&_bg=114606398847&device=c&gclid=EAIaIQobChMIy4uU4-rK_wIVr4VoCR3pbQJxEAAYASAAEgIWovD_BwE">Splunk Forwarder</a><br/>
->Install Splunk Forwarder on the Machine<br/>
->Agree license and select "On-Premise Splunk option"<br/>
   <img src = "https://imgur.com/HqRRrmm.png" height="50%" width="50%"></br>
->Create an username and password > next <br/>
->Click next as we would setup the receiving indexer<br/>
->Enter the IP address of the splunk server and the port (9997) we enabled on splunk to listen<br/>
   <img src = "https://imgur.com/1NnA3en.png" height="50%" width="50%"></br>
->Click next and install<br/>

<h2>3. Finalizing the host setup</h2>
<p align="Left">
->After the installation is done, we need to add the index name to the windows machine<br/>
->Go to the installed path of the splunk forwarder
      
  
        Go to c:\program files\SplunkUniversalForwarder\etc\apps\SplunkUniversalForwarder\local<br/>
->We would be able to find the inputs.conf file<br/>
->open it in notepad and add the index name that we created in splunk at the end of all event  (Here it is index= windows)<br/>
   <img src = "https://imgur.com/i8ratQd.png" height="50%" width="50%"></br>
->Check whether the Splunk server is configured correctly in the host<br/>
->Go to c:\program files\SplunkUniversalForwarder\etc\system\local<br/>
->Open and check the outputs.conf file<br/>
   <img src = "https://imgur.com/CKHIweS.png" height="50%" width="50%"></br>
->Now we need to open the port 9997 on the firewall to finalize the connection<br/>
->Go to "windows defender firewall with advanced security" <br/>
   <img src = "https://imgur.com/6mF0HLu.png" height="50%" width="50%"></br>
->Select inbound rule on the left and create a new rule " <br/>
   <img src = "https://imgur.com/sEYMhlN.png" height="50%" width="50%"></br>
->Set Rule Type as Port<br/>
   <img src = "https://imgur.com/XESJuIM.png" height="50%" width="50%"></br>
->Select protocol as UDP and specify the port (9997)<br/>
   <img src = "https://imgur.com/zvPQtx9.png" height="50%" width="50%"></br>
->Use the default on Action (Allow the connection) and profile (Check all three on profile) <br/>
->Add a name and description, click finish<br/>
   <img src = "https://imgur.com/fyoHwAD.png" height="50%" width="50%"></br>
->Finally restart the splunk forwarder service in the services.msc<br/>
   <img src = "https://imgur.com/afNHVi6.png" height="50%" width="50%"></br>
->After the service got resatrted go to the Search and Reporting option in Splunk Server<br/>
   <img src = "https://imgur.com/gmKpYQj.png" height="50%" width="50%"></br>
->Click on Data Summary and we would be able to see the hosts and Sources got populated from windows machine<br/>
   <img src = "https://imgur.com/uMyuGSz.png" height="50%" width="50%"></br>
   <img src = "https://imgur.com/ABxBv9h.png" height="50%" width="50%"></br>

Now the logs from Windows machine would get imported into our Splunk server and Splunk would be able to provide analysis of it<br/> 
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
