TITLE Elementary Arithmetic     (Elementary_Arithmetic.asm)

; Author: Carlos Lopez-Molina
; Course / Project ID : CS 271/Elementary Arithmetic       Date: 1/22/17
; Description: MASM program that can display name and program on output screen, instructions for user, prompts the user for two numbers and calculates the sum, difference, product, (int) quotient and remainder of numbers. Program can be run as many times as user desires without shutting down and will also display an error if the second number is not smaller than the first; also display a terminating message.
;**EC: (1) Program loops until user wants to stop.
;**EC: (2) Program varifies second number less than first.
;   *Instructions did not specify that we had to loop when user enters invalid numbers. As the example shows the program ending when the user inputs invalid numbers.

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

;variable definitions
intro_1		BYTE	"Elementary Arithmetic      by Carlos Lopez-Molina ", 0
prompt_1	BYTE	"Enter two numbers, and I'll show you the sum, difference, product, quotient, and remainder. ", 0
getFirstnum	BYTE	"Enter first number: ",0
getSecnum	BYTE	"Enter second number: ",0
num_1		DWORD	?
num_2		DWORD	?
addition	BYTE	" + ",0
subtract	BYTE	" - ",0
mult		BYTE	" x ",0
divide		BYTE	" / ",0
equals		BYTE	" = ",0
addresult	DWORD	?
subresult	DWORD	?
multresult	DWORD	?
divresult	DWORD	?	
rem			DWORD	?
again		DWORD	1
remainder	BYTE	" remainder ",0
goodbye		BYTE	"Thats it, goodbye!:) ", 0
invalid		BYTE	"Second number must be less than the first!",0
repeatP		BYTE	"Would you like to enter new numbers? (1-YES, 0-NO) ", 0
extra		BYTE	"**EC: Program loops until user wants to stop.", 0
extra1		BYTE	"**EC: Program varifies second number less than first.", 0
;these are valid!
;list		BYTE	10,20
;			BYTE	30,40
;str1 \
;BYTE "This string is quite long!",0

.code
main PROC

	call	ClrScr							;clears the screen

;introduction
	mov		edx, OFFSET intro_1				;main intro
	call	WriteString
	call	CrLf
	mov		edx, OFFSET extra		
	call	WriteString
	call	CrLf
	mov		edx, OFFSET extra1		
	call	WriteString
	call	CrLf
		
	call	CrLf
	mov		edx, OFFSET prompt_1		
	call	WriteString
	call	CrLf

;start of program that will be looped - main program
beginwhile:
	mov		eax, 1
	cmp		eax, again
	jne		_end

;get the data
validNum:
	mov		edx, OFFSET getFirstnum
	call	WriteString						;prompts user for data
	call	ReadInt							;gathers user data
	mov		num_1, eax						;saves users data to the variable

	mov		edx, OFFSET getSecnum			;same process, saving second part of data
	call	WriteString
	call	ReadInt
	mov		num_2, eax
	call	CrLf

	mov		eax, num_1
	mov		ebx, num_2
	cmp		eax, ebx						;compare if less than
	jL		L1
	jmp		L2

;prompt notifying user of invalid input
L1:	mov		edx, OFFSET invalid
	call	WriteString
	call	CrLf
	jmp		_end

L2:
;calculate the required values
	;addition
	mov		eax, num_1
	mov		ebx, num_2
	add		eax, ebx					;adds the two variables
	mov		addresult, eax				;result saved to new variable
	;subtraction
	mov		eax, num_1
	mov		ebx, num_2
	sub		eax, ebx					;subtracts the two variables
	mov		subresult, eax				;result saved to new variable
	;multiplication
	mov		eax, num_1
	mov		ebx, num_2
	mul		ebx							;mulitplies two variables
	mov		multresult, eax				;result saved to new variable
	;division
	mov		eax, num_1
	cdq									;"convert double word to quad word" extend/expands the sign from eax into edx - program crashes without this 
	mov		ebx, num_2
	div		ebx							;quotient in eax remainder in edx
	mov		divresult, eax
	mov		rem, edx		

;display the results
	;addition
	mov		eax, num_1					;variables moved to registers so they are able to be read and displayed:
	call	WriteDec					;Displays integer
	mov		edx, OFFSET addition		; " + " move OFFSET to edx in order to get input (the address)
	call	WriteString					;Displays string
	mov		eax, num_2
	call	WriteDec
	mov		edx, OFFSET equals			;OFFSET to 
	call	WriteString
	mov		eax, addresult
	call	WriteDec
	call	CrLf

	;subtraction
	mov		eax, num_1					;variables moved to registers so they are able to be read and displayed:
	call	WriteDec
	mov		edx, OFFSET subtract		; " - " move OFFSET to edx in order to get input (the address)
	call	WriteString
	mov		eax, num_2
	call	WriteDec
	mov		edx, OFFSET equals
	call	WriteString
	mov		eax, subresult
	call	WriteDec
	call	CrLf

	;multiplication
	mov		eax, num_1					;variables moved to registers so they are able to be read and displayed:
	call	WriteDec
	mov		edx, OFFSET mult			; " x " move OFFSET to edx in order to get input (the address)
	call	WriteString
	mov		eax, num_2
	call	WriteDec
	mov		edx, OFFSET equals
	call	WriteString
	mov		eax, multresult
	call	WriteDec
	call	CrLf

	;Division
	mov		eax, num_1					;variables moved to registers so they are able to be read and displayed:
	call	WriteDec
	mov		edx, OFFSET divide			; " / " move OFFSET to edx in order to get input (the address)
	call	WriteString
	mov		eax, num_2
	call	WriteDec
	mov		edx, OFFSET equals
	call	WriteString
	mov		eax, divresult
	call	WriteDec
	mov		edx, OFFSET remainder
	call	WriteString
	mov		eax, rem
	call	WriteDec
	call	CrLf
	call	CrLf

	;repeat program
	mov		edx, OFFSET repeatP
	call	WriteString					;prompts user for data
	call	ReadDec						;gathers user data
	mov		again, eax					;saves users data to the variable
	call	CrLf
	
	jmp		beginwhile

_end:
;say goodbye
	mov		edx, OFFSET goodbye
	call	WriteString
	call	CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
