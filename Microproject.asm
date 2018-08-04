; Run thermometer.exe && Traffic_Lights.exe from c:\emu8086\devices
; Also accessible from the "virtual devices" menu of the emulator

#start=thermometer.exe#
#start=Traffic_Lights.exe#

#make_bin#

name "thermo_led"

all_red          equ      0010_0100_1001b       ;0249h
all_yellow       equ      0100_1001_0010b       ;0492h
all_green        equ      1001_0010_0100b       ;0924h

; set data segment to code segment:
mov ax, cs
mov ds, ax


start:
IN  AX, 125
CMP AX, 60             ; Instead of 200 so it's not always green
JBE green
CMP AX, 80             ; Instead of 500
JB  yellow
;JAE red         	   ; Not really needed.

;Light up red LED
MOV AX, 0249h
OUT 4, AX              ; or all_red
JMP delay

;Light up yellow LED
yellow:
MOV AX, 0492h          ; or all_yellow
OUT 4, AX
JMP delay

;Light up green LED
green:
MOV AX, 0924h          ; or all_green
OUT 4, AX

;Wait 3 minutes <180 million millseconds> <0ABA9500 HEX>
delay:
MOV CX, 4Ch           ; 5 second intervals just for now
MOV DX, 4B40h         ; 5 second intervals just for now
MOV AH, 86h
int 15h

JMP start