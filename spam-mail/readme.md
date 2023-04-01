<h1>2FA Steal</h1>


<h2>Description</h2>
Just a simple demonstration inspired from the video of John Hammond to bypass 2FA SMS Authentication. You can watch the video <a href= "https://www.youtube.com/watch?v=FwGeBW6OurM&t=211s">Here<a><br>  
<br />

<h2>Languages and Utilities Used</h2>

- <b>Linux</b> 
- <b>Python</b>
- <b>Java</b>

<h2>Environments Used </h2>

- <b>Windows 10</b>
- <b>kali</b>

<h2>Procedure:</h2>

<p align="Left">
- Took the HTML code from the browser view page source </br>
- Added the json <a href="https://raw.githubusercontent.com/V4g4b0nd/Projects/main/spam-mail/payload.js">payload <a>inside the code</br>
- Created a simple flask python <a href="https://raw.githubusercontent.com/V4g4b0nd/Projects/main/spam-mail/spam.py"> app <a>and hosted it</br> 
- Accessed the IP outside the machine and grabbed the input on the terminal
  
<h2>Process Walkthrough:</h2>

<p>
  - Hosting the app publically <br/>
<img src="https://imgur.com/nIfYUfs.png" height="50%" width="50%" alt="Server1"/></br>
  - The webpage being accessed by the victim by clicking on a spam email or dodgy link and try logging in with the password</br>
<img src="https://imgur.com/s7NERDG.png" height="50%" width="50%" alt="victim1"/></br>
  - The attacker is prompted with the password of the account in the terminal when the victim press next</br>
 <img src = "https://imgur.com/fqrZ15h.png" height="50%" width="50%" alt="server2"/></br>
  - The victim is then prompted with the page to enter the Verification code that is being sent to the phone</br>
 <img src = "https://imgur.com/DAqm6U1.png" height="50%" width="50%" alt="victim2"/></br>
  - On clicking next, the attacker would be able to get the 2FA code and can be used to login to victim's account</br>
 <img src = "https://imgur.com/voHQSMK.png" height="50%" width="50%" alt="victim2"/></br>
</p>  
  
  
  

