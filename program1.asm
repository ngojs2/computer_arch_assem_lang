TITLE Program 1     (program1.asm)

; Author: Jeffrey Ngo
; Last Modified: 4/13/2020
; OSU email address: ngojef@oregonstate.edu
; Course number/section: CS271/400
; Project Number: 1                Due Date: 4/12/2020
; Description: Display Name and program title
; Display instructions, User Enters 3 Numbers,
; Calculate and display the sum and differences
; Display terminating message

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

; (insert variable definitions here)

progTitle		BYTE	"Elementary Arithmetic",0
nameDisplay		BYTE	"by Jeffrey Ngo",0
instruction1	BYTE	"Enter 3 numbers in descending order (largest to smallest)",0
instruction2	BYTE	"and I'll calculate the sum and differences",0
prompt1			BYTE	"Enter first number: ",0
prompt2			BYTE	"Enter second number: ",0
prompt3			BYTE	"Enter third number: ",0
number1			DWORD	? ;integer entered by user
number2			DWORD	? ;integer entered by user
number3			DWORD	? ;integer entered by user
sum				DWORD	? ;sum of the selected numbers
difference		DWORD	? ;difference of the selected numbers
replay			DWORD	? ;replay choice (1 for yes or 2 for no) 
plusSymbol		BYTE	" + ",0
minusSymbol		BYTE	" - ",0
equalSymbol		BYTE	" = ",0
goodbyeMessage	BYTE	"Goodbye!",0
replayMessage	BYTE	"** EC ** Press 1 to play again or press 2 to exit: ",0
errorMessage1	BYTE	"** EC Error: First number must be larger than the second **",0
errorMessage2	BYTE	"** EC Error: Second number must be larger than the third **",0
ecMsg1			BYTE	"** EC ** Program loops until user exits",0
ecMsg2			BYTE	"** EC ** Program handles negative results with extra calculations",0
ecMsg3			BYTE	"** EC ** Program checks if the input numbers are in descending order",0


.code
main PROC

; (insert executable instructions here)

; Diplay the program title
	mov		edx, OFFSET progTitle
	call	WriteString
	call	Crlf

; Display name
	mov		edx, OFFSET nameDisplay
	call	WriteString
	call	Crlf

; Display extra credit notes
	call	Crlf
	mov		edx, OFFSET ecMsg1
	call	WriteString
	call	Crlf
	mov		edx, OFFSET ecMsg2
	call	WriteString
	call	Crlf
	mov		edx, OFFSET ecMsg3
	call	WriteString
	call	Crlf

;top of loop
;Gets user input and calculates
top:
	; Display instructions
	call	Crlf
	mov		edx, OFFSET instruction1
	call	WriteString
	call	Crlf
	mov		edx, OFFSET instruction2
	call	WriteString
	call	Crlf

	; Get the first number
	call	Crlf
	mov		edx, OFFSET prompt1
	call	WriteString
	call	ReadInt
	mov		number1, eax

	; Get the second number
	mov		edx, OFFSET prompt2
	call	WriteString
	call	ReadInt
	mov		number2, eax

	; Get the third number
	mov		edx, OFFSET prompt3
	call	WriteString
	call	ReadInt
	mov		number3, eax
	call	Crlf

	; Checks if numbers 1 is greater than 2
	; Jumps to Error1 if 1 is less than 2
	mov		eax, number1
	cmp		eax, number2
	jl		Error1
	
	; Checks if numbers 2 is greater than 3
	; Jumps to Error2 if 2 is less than 3
	mov		eax, number2
	cmp		eax, number3
	jl		Error2

	; Sum of first and second number
	mov		eax, number1
	mov		ebx, number2
	add		eax, ebx
	mov		sum, eax	

	; Sum of first and second number results
	mov		eax, number1
	call	WriteDec
	mov		edx, OFFSET plusSymbol
	call	WriteString
	mov		eax, number2
	call	WriteDec
	mov		edx, OFFSET equalSymbol
	call	WriteString
	mov		eax, sum
	call	WriteDec
	call	Crlf

	; Subtraction of first and second number
	mov		eax, number1
	mov		ebx, number2
	sub		eax, ebx
	mov		difference, eax	

	; Subtraction of first and second number results
	mov		eax, number1
	call	WriteDec
	mov		edx, OFFSET minusSymbol
	call	WriteString
	mov		eax, number2
	call	WriteDec
	mov		edx, OFFSET equalSymbol
	call	WriteString
	mov		eax, difference
	call	WriteDec
	call	Crlf

	; Sum of first and third number
	mov		eax, number1
	mov		ebx, number3
	add		eax, ebx
	mov		sum, eax	

	; Sum of first and third number results
	mov		eax, number1
	call	WriteDec
	mov		edx, OFFSET plusSymbol
	call	WriteString
	mov		eax, number3
	call	WriteDec
	mov		edx, OFFSET equalSymbol
	call	WriteString
	mov		eax, sum
	call	WriteDec
	call	Crlf

	; Subtraction of first and third number
	mov		eax, number1
	mov		ebx, number3
	sub		eax, ebx
	mov		difference, eax	

	; Subtraction of first and third number results
	mov		eax, number1
	call	WriteDec
	mov		edx, OFFSET minusSymbol
	call	WriteString
	mov		eax, number3
	call	WriteDec
	mov		edx, OFFSET equalSymbol
	call	WriteString
	mov		eax, difference
	call	WriteDec
	call	Crlf

	; Sum of second and third number
	mov		eax, number2
	mov		ebx, number3
	add		eax, ebx
	mov		sum, eax	

	; Sum of second and third number results
	mov		eax, number2
	call	WriteDec
	mov		edx, OFFSET plusSymbol
	call	WriteString
	mov		eax, number3
	call	WriteDec
	mov		edx, OFFSET equalSymbol
	call	WriteString
	mov		eax, sum
	call	WriteDec
	call	Crlf

	; Subtraction of second and third number
	mov		eax, number2
	mov		ebx, number3
	sub		eax, ebx
	mov		difference, eax	

	; Subtraction of second and third number results
	mov		eax, number2 
	call	WriteDec
	mov		edx, OFFSET minusSymbol
	call	WriteString
	mov		eax, number3
	call	WriteDec
	mov		edx, OFFSET equalSymbol
	call	WriteString
	mov		eax, difference
	call	WriteDec
	call	Crlf

	; Sum of first, second and third number
	mov		eax, number1
	mov		ebx, number2
	mov		ecx, number3
	add		eax, ebx
	add		eax, ecx
	mov		sum, eax	

	; Sum of first, second and third number results
	mov		eax, number1
	call	WriteDec
	mov		edx, OFFSET plusSymbol
	call	WriteString
	mov		eax, number2
	call	WriteDec
	mov		edx, OFFSET plusSymbol
	call	WriteString
	mov		eax, number3
	call	WriteDec
	mov		edx, OFFSET equalSymbol
	call	WriteString
	mov		eax, sum
	call	WriteDec
	call	Crlf

	; Display extra credit negative numbers
	call	Crlf
	mov		edx, OFFSET ecMsg2
	call	WriteString
	call	Crlf

	; Subtraction of second and first number
	mov		eax, number2
	mov		ebx, number1
	sub		eax, ebx
	mov		difference, eax	

	; Subtraction of second and first number results
	mov		eax, number2
	call	WriteDec
	mov		edx, OFFSET minusSymbol
	call	WriteString
	mov		eax, number1
	call	WriteDec
	mov		edx, OFFSET equalSymbol
	call	WriteString
	mov		eax, difference
	call	WriteInt
	call	Crlf

	; Subtraction of third and first number
	mov		eax, number3
	mov		ebx, number1
	sub		eax, ebx
	mov		difference, eax	

	; Subtraction of third and first number results
	mov		eax, number3
	call	WriteDec
	mov		edx, OFFSET minusSymbol
	call	WriteString
	mov		eax, number1
	call	WriteDec
	mov		edx, OFFSET equalSymbol
	call	WriteString
	mov		eax, difference
	call	WriteInt
	call	Crlf

	; Subtraction of third and second number
	mov		eax, number3
	mov		ebx, number2
	sub		eax, ebx
	mov		difference, eax	

	; Subtraction of third and second number results
	mov		eax, number3
	call	WriteDec
	mov		edx, OFFSET minusSymbol
	call	WriteString
	mov		eax, number2
	call	WriteDec
	mov		edx, OFFSET equalSymbol
	call	WriteString
	mov		eax, difference
	call	WriteInt
	call	Crlf

	; Sum of first, second and third number
	mov		eax, number3
	mov		ebx, number2
	mov		ecx, number1
	sub		eax, ebx
	sub		eax, ecx
	mov		difference, eax	

	; Sum of first, second and third number results
	mov		eax, number3
	call	WriteDec
	mov		edx, OFFSET minusSymbol
	call	WriteString
	mov		eax, number2
	call	WriteDec
	mov		edx, OFFSET minusSymbol
	call	WriteString
	mov		eax, number1
	call	WriteDec
	mov		edx, OFFSET equalSymbol
	call	WriteString
	mov		eax, difference
	call	WriteInt
	call	Crlf


	
	; **EC Replay until user chooses to exit
	call	Crlf
	mov		edx, OFFSET replayMessage
	call	WriteString
	call	ReadInt
	mov		replay, eax;
	cmp		eax, 1
	je		top
	call Crlf

	; Display terminating message
	mov		edx, OFFSET goodbyeMessage
	call	WriteString
	call	Crlf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

; Prints error message if number 2 is larger 1
; Jumps to main
Error1:
	mov		edx, OFFSET errorMessage1
	call	WriteString
	call	Crlf
	call	Crlf
	jmp		main

; Prints error message if number 3 is larger 2
; Jumps to main
Error2:
	call	Crlf
	mov		edx, OFFSET errorMessage2
	call	WriteString
	call	Crlf
	call	Crlf
	jmp		main

END main
