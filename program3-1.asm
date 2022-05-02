TITLE Program 3    (program3.asm)

; Author: Jeffrey Ngo
; Last Modified: 5/5/2920
; OSU email address: ngojef@oregonstate.edu
; Course number/section: 271/400
; Project Number: 3                Due Date: 5/3/20/20
; Description: Asks user to enter a number, validate input
; Sum up the valid input, count the number of inputs, calculate average

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

; (insert variable definitions here)

progTitle		BYTE	"Integer Accumulator",0
nameDisplay		BYTE	"by Jeffrey Ngo",0
intro1			BYTE	"Welcome to Integer Accumulator",0
getName			BYTE	"What is your name? ",0
username		BYTE	25 DUP(0)
greet			BYTE	"Hello, ",0
instruction1	BYTE	"Please enter numbers between the ranges [-88, -55] or [-40, -1]",0
instruction2	BYTE	"Then enter a non-negative number when you are finished to see the sum and average those valid inputs",0
numDisplay1		BYTE	"You entered ",0 ; to display how many numbers the user entered
numDisplay2		BYTE	" valid numbers",0 ; to display how many numbers the user entered
prompt1			BYTE	"Enter a number: ",0
printSum		BYTE	"The sum of the valid numbers is: ",0
printHigh		BYTE	"The highest number closest to zero is: ",0
printLow		BYTE	"The lowest number is: ",0
printAvg		BYTE	"The rounded average is: ",0
goodbyeMessage	BYTE	"Thanks for stopping by, Goodbye ",0
minNum = -88				; minimum number for the range1
maxNum = -55				; maximum number for the range1
minNum2 = -40				; minimum number for the range2
maxNum2 = -1				; maximum number for the range2
lowNum			DWORD	? ; store lowest number
highNum			DWORD	? ; store highest number
number			DWORD	? ; number the user enters
numCounter		DWORD	? ; counter for the number of inputs
sum				DWORD	? ; sum of the inputed numbers
avg				DWORD	? ; average of inputed numbers
errorMessage	BYTE	"Error: Out of Range",0

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

; Display intro
	call Crlf
	mov		edx, OFFSET intro1
	call	WriteString
	call	Crlf

; Get the user's name
	mov		edx, OFFSET getName
	call	WriteString
	mov		edx, OFFSET username
	mov		ecx, 25
	call	ReadString

; Greet the user
	mov		edx, OFFSET greet
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString
	call	Crlf

; Display instructions
	call	Crlf
	mov		edx, OFFSET instruction1
	call	WriteString
	call	Crlf
	mov		edx, OFFSET instruction2
	call	WriteString
	call	Crlf

; Asks the user to enter a number
; Checks if the chosen number is in range
; Jumps to error if out of range
prompt:
	; Get the number
	call	Crlf
	mov		eax, numCounter
	add		eax, 1
	mov		numCounter, eax
	mov		edx, OFFSET prompt1
	call	WriteString
	call	ReadInt
	mov		number, eax

; Compare input to -1
; If greater it jumps to print the results
	mov		eax, number
	cmp		eax, maxNum2
	jg		print

; Compare input to -40;
; If less it compares to the next number -55
	mov		eax, number
	cmp		eax, minNum2
	jge		calc
	jl		check1

; Compare input to -55
; If greater, jumps to print error if in the invalid range of -54, -41
; If less, jumps to compare to -88
check1:
	cmp		eax, maxNum
	jg		error
	jl		check2

; Compare input to -88
; If less, jumps to print error message
check2:
	cmp		eax, minNum
	jl		error

; Adds the inputted numbers together
; Loops until the user decided to stop
calc:
	add		eax, sum
	mov		sum, eax
	loop	prompt

; Prints error message if the user enters an invalid number
; Subtract 1 from the counter since the number entered is invalid
; Jumps back to the prompt to ask the user to enter another input
error:
	call	Crlf
	mov		eax, numCounter
	sub		eax, 1
	mov		numCounter, eax

	mov		edx, OFFSET errorMessage
	call	WriteString
	call	Crlf
	jmp		prompt

;Prints number of inputs, highest number, lowest number, sum, average, and goodbye
print:
	; Subtract 1 from the counter for entering a number greater than or equal to 0
	call	Crlf
	mov		eax, numCounter
	sub		eax, 1
	mov		numCounter, eax

	; Print the number of of inputs
	mov		edx, OFFSET numDisplay1
	call	WriteString
	mov		eax, numCounter
	call	WriteDec
	mov		edx, OFFSET numDisplay2
	call	WriteString
	call	Crlf

	; Print the highest number entered
	mov		edx, OFFSET printHigh
	call	WriteString
	mov		eax, highNum
	call	WriteInt
	call	Crlf

	; Print the lowest number entered
	mov		edx, OFFSET printLow
	call	WriteString
	mov		eax, lowNum
	call	WriteInt
	call	Crlf

	; Print the calculated sum
	mov		edx, OFFSET printSum
	call	WriteString
	mov		eax, sum
	call	WriteInt
	call	Crlf

	; Calculate the average using the sum and number of inputs
	mov		eax, sum
	cdq
	mov		ebx, numCounter
	idiv	ebx
	mov		avg, eax

	; Print the average 
	mov		edx, OFFSET printAvg
	call	WriteString
	mov		eax, avg
	call	WriteInt
	call	Crlf

	; displays goodbye message to user
	call	Crlf
	mov		edx, OFFSET goodbyeMessage
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString
	call	Crlf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
