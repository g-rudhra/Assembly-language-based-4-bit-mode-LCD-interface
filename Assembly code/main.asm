
.include "m328pdef.inc"

.cseg
.ORG 0x00
RJMP displayDistance

; Main function for display
; will show the value in r27 temporarily - need to set the value for distance to that
displaySetup:
    sbi DDRB, 0          ; Set bit 0 of DDRB (set as output)
    sbi DDRB, 1          ; Set bit 1 of DDRB (set as output)

    sbi DDRD, 4          ; Set bit 4 of DDRD (set as output)
    sbi DDRD, 5          ; Set bit 5 of DDRD (set as output)
    sbi DDRD, 6          ; Set bit 6 of DDRD (set as output)
    sbi DDRD, 7          ; Set bit 7 of DDRD (set as output)

    cbi PORTB, 0         ; Clear bit 0 of PORTB (reset control signal)
    cbi PORTB, 1         ; Clear bit 1 of PORTB (reset control signal)

    ldi R16, 0x02        ; Load immediate value 0x02 into R16 (set function mode)
    rcall sendCmd        ; Send command to display

	ldi R16, 0x33        ; Load immediate value 0x28 into R16 (5*7  mode)
    rcall sendCmd        ; Send command to display

	ldi R16, 0x32        ; Load immediate value 0x28 into R16 (4 bit  mode)
    rcall sendCmd        ; Send command to display

    ldi R16, 0x28        ; Load immediate value 0x28 into R16 (set entry mode)
    rcall sendCmd        ; Send command to display

    ldi R16, 0x0C        ; Load immediate value 0x0C into R16 (display on)
    rcall sendCmd        ; Send command to display

	ldi R16, 0x01        ; Load immediate value 0x28 into R16 (clear mode)
    rcall sendCmd        ; Send command to display

    ldi R16, 0x06        ; Load immediate value 0x06 into R16 (set cursor move)
    rcall sendCmd        ; Send command to display
    ret                  ; Return from subroutine
displayDistance:
	ldi R28,0x32
    rcall displaySetup			; Call displaySetup subroutine to setup and send commands

    ldi ZH, HIGH(distanceString<<1)
    ldi ZL, LOW(distanceString<<1)

    ldi R24, 0
    ldi R17, 17

;data:
 ;   inc R24					
 ;   cpse R24, R17				;check the line is filled
 ;   brne loadLine1				;load until 16 characters
  ;  rcall moveLine2				;if fully filled branch

loadLine1:
    lpm R16, Z
    cpi R16, 0x00
    breq distanceOut
    rcall sendData
    inc ZL
   ; rcall delay
    rjmp loadLine1

distanceOut:
    rcall asciiConversionOfDistance	;covert to ascii
    mov R21, R16
    mov R16, R18
    rcall sendData
    mov R16, R17
    rcall sendData
    mov R16, R21
    rcall sendData
    ldi R16, 'm'					;upto 100m
    rcall sendData

moveLine2:							;second line
    ldi R16, 0xC0
    rcall sendCmd

angleStringRoutine:
	ldi ZH, HIGH(angleString<<1)
    ldi ZL, LOW(angleString<<1)
displayAngle:
    lpm R16, Z
    cpi R16, 0x00
    breq angleOut
    rcall sendData
    inc ZL
    ;rcall delay
    rjmp displayAngle				;loop until string print
    ret

angleOut:
	rcall asciiConversionOfAngle
    rcall sendData
	ldi R16,'''
    rcall sendData
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	   	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	   rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	   	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay		 rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	   	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	   	
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
		rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	   	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay	rcall delay
	rcall delay
	rcall delay
	rcall delay
	rcall delay
    rjmp displayDistance		   ;print the whole thing again


delay:
    ldi R20, 10
h3:
    ldi R18, 30
h2:
    ldi R19, 50

h1:
    dec R19
    brne h1

    dec R18
    brne h2

    dec R20
    brne h3
    ret

distanceString:
    .db "Distance = ",0x00

angleString:
	.db "Angle = ",0x00


asciiConversionOfDistance:
    mov R16, R18    ; final distance to show in display
    ldi R18, 0      ; R18 will store hundreds
    ldi R17, 0      ; R17 will store tens

hundredsLoop:
    cpi R16, 100
    brlo doneHundreds
    subi R16, 100
    inc R18
    rjmp hundredsLoop

doneHundreds:
tensLoop:
    cpi R16, 10
    brlo doneTens
    subi R16, 10
    inc R17
    rjmp tensLoop

doneTens:
    ori R18, 0x30   ; Convert hundreds to ASCII
    ori R17, 0x30   ; Convert tens to ASCII
    ori R16, 0x30   ; Convert units to ASCII
    ret

asciiConversionOfAngle:
	mov R16,R28
	ori R16, 0x30   ; Convert Angle to ASCII
	ret
	
;---------------------------------------------------------------
bit4Cmd:
    sbrs R16, 0
    rjmp else
    sbi PORTD, 4
    rjmp if1

else:
    cbi PORTD, 4

if1:
    sbrs R16, 1
    rjmp else1
    sbi PORTD, 5
    rjmp if2

else1:
    cbi PORTD, 5

if2:
    sbrs R16, 2
    rjmp else2
    sbi PORTD, 6
    rjmp if3

else2:
    cbi PORTD, 6

if3:
    sbrs R16, 3
    rjmp else3
    sbi PORTD, 7
    rjmp ena

else3:
    cbi PORTD, 7

ena:
    sbi PORTB, 1
    cbi PORTB, 1

    rcall delay
    ret

sendCmd:
    mov R22, R16
    cbi PORTB, 0
    swap R16
    andi R16, 0x0F
    rcall bit4Cmd

    mov R16, R22
    rcall bit4Cmd
    ret

sendData:
    mov R22, R16
    sbi PORTB, 0
    swap R16
    andi R16, 0x0F
    rcall bit4Cmd
    mov R16, R22
    rcall bit4Cmd
    ret
;---------------------------------------------------------------


;#########################################################################
