TITLE Program 5     (program5.asm)

; Author: Jeffrey Ngo
; Last Modified: 5/26/2020
; OSU email address: ngojef@oregonstate.edu
; Course number/section: 271/400
; Project Number: 5               Due Date: 5/24/2020
; Description: Generate an array with random integers between 10-29
; Display the unsorted array and sorted array
; Calculate and display the median of the array
; Count and display the number of each integer's appearance

INCLUDE Irvine32.inc

; (insert constant definitions here)

	LO = 10
	HI = 29
	ARRAYSIZE = 200

.data

; (insert variable definitions here)

progTitle		BYTE	"Random Number Sort",0
nameDisplay		BYTE	"by Jeffrey Ngo",0
instruction1	BYTE	"This program generates random integers in the range of [10 - 29]",0
instruction2	BYTE	"It diplays the list of integers before sorting, after sorting in ascending order",0
instruction3	BYTE	"Calculates the median value of the array, and counts each number's frequency ",0
sortedTitle		BYTE	"Unsorted List: ",0
unsortedTitle	BYTE	"Sorted List: ",0
medianTitle		BYTE	"Median: ",0
countTitle		BYTE	"List of Array counts (starting with number 10): ",0
spacing			BYTE	"  ",0
list			DWORD	ARRAYSIZE DUP(?)

.code

;-----------------------------------------
; calls other procedures
; pass by reference for each procedure
;-----------------------------------------
main PROC
; (insert executable instructions here)

	; randomize the numbers
	call	Randomize

	; pass by reference for the introduction
	push	OFFSET progTitle
	push	OFFSET nameDisplay
	push	OFFSET instruction1
	push	OFFSET instruction2
	push	OFFSET instruction3
	call	introduction

	; pass by reference to fill array
	push	OFFSET list
	push	ARRAYSIZE
	call	fillArray

	; pass by reference to display the list
	push	OFFSET sortedTitle
	push	OFFSET list
	push	ARRAYSIZE
	push	OFFSET spacing
	call	displayList

	; pass by reference to sort the array
	push	OFFSET list
	push	ARRAYSIZE
	call	sortList

	; pass by reference to display sorted array
	push	OFFSET unsortedTitle
	push	OFFSET list
	push	ARRAYSIZE
	push	OFFSET spacing
	call	displayList

	; pass by reference to display the median
	push	OFFSET medianTitle
	push	OFFSET list
	push	ARRAYSIZE
	call	displayMedian

	; pass by reference to count the and display number of count
	push	OFFSET countTitle
	push	OFFSET spacing
	push	OFFSET list
	push	ARRAYSIZE
	call	countList

	exit	; exit to operating system
main ENDP

;-----------------------------------------
; Displays program title, my name,
; and instructions for the user
; receives: ebp+24, ebp+20, ebp+16, ebp+12
; ebp+8 
; returns: title, name, instruction strings
;-----------------------------------------
introduction PROC
	; stack frame
	push	ebp
	mov		ebp,esp

	; display title
	mov		edx, [ebp+24]
	call	WriteString
	call	Crlf

	; display name
	mov		edx, [ebp+20]
	call	WriteString
	call	Crlf
	call	Crlf
	
	; display instruction1
	mov		edx, [ebp+16]
	call	WriteString
	call	Crlf

	; display instruction2
	mov		edx, [ebp+12]
	call	WriteString
	call	Crlf

	; display instruction3
	mov		edx, [ebp+8]
	call	WriteString
	call	Crlf
	call	Crlf

	pop		ebp
	ret		20

introduction ENDP

;-----------------------------------------
; preconditions: Empty array
; postconditions: fills array with random numbers between 10-29
; receives: ebp+12 and ebp+8, array address and size
; Hi and LO global constants
; returns: filled array
;-----------------------------------------
fillArray PROC
	;stack frame
	push	ebp
	mov		ebp,esp

	; address of list array
	mov		edi, [ebp+12]	

	; list size counter
	mov		ecx, [ebp+8]
		
; Followed the randomRange procedure from Lecture 20
listLoop:
	; range = hi - lo + 1
	mov		eax, HI
	sub		eax, LO
	add		eax, 1

	; call RandomRange
	; add lo to eax
	call	RandomRange
	add		eax, LO

	; move number in to the array
	mov		[edi], eax
	
	; move to the next element
	add		edi, 4

	loop	listLoop

	pop ebp
	ret 8
fillArray ENDP

;-----------------------------------------
; preconditions: Empty array
; postconditions: Displays the unsorted and sorted array
; receives: ebp+16, ebp+12, ebp+20, ebp+8 
; returns: Displays the array
;-----------------------------------------
displayList PROC
	; stack frame
	push	ebp
	mov		ebp, esp

	; address of list array
	mov		edi, [ebp+16]

	; Display list title
	mov		edx, [ebp+20]
	call	WriteString
	call	Crlf

	
	; list size counter
	mov		ecx, [ebp+12]
	; line counter
	mov		ebx, 0

; Followed and borrowed from Lecture 20
displayLoop:
	; Check the number per line, create a new line
	cmp		ebx, 20
	je		newLine

	; print current element
	mov		eax, [edi]
	call	WriteDec

	; print spacing
	mov		edx, [ebp+8]
	call	WriteString

	; move to next element
	add		edi, 4

	; increment counter
	inc		ebx

	loop	displayLoop
	jmp		endList

	; Prints a new line
newLine:
	call	Crlf
	mov		ebx, 0
	jmp		displayLoop

endList:
	call	Crlf
	pop		ebp
	ret		16
	
displayList ENDP

;-----------------------------------------
; preconditions: Unsorted array
; postconditions: Sorts the array using Gnome sort algorithm
; receives: ebp+12 and ebp+8, array address and size
; returns: Sorted array
;-----------------------------------------
sortList PROC

	call Crlf
	
	; stack frame
	push	ebp
	mov		ebp, esp
	; array address
	mov		edi, [ebp+12]

	; list size
	mov		ecx, [ebp+8]

	; position
	mov		ebx, 0
	
sortLoop:

	; compare position to array size
	cmp		ebx, ecx
	je		endSort
	
	; if position is 0 move to the next
	cmp		ebx, 0
	je		next

	; if position > position - 1 move the next
	; already sorted
	mov		eax, [edi-4]
	mov		edx, [edi]
	cmp		edx, eax
	jge		next

	;	else swap the elements
exchangeElements:
	mov		eax, [edi]
	mov		edx, [edi-4]

	mov		[edi-4], eax
	mov		[edi], edx

	; position - 1
	sub		edi, 4
	sub		ebx, 1

	jmp		sortLoop

; position + 1
next:
	add		ebx, 1
	add		edi, 4
	jmp		sortLoop


endSort:
	pop		ebp
	ret		8

sortList ENDP

;-----------------------------------------
; preconditions: no median
; postconditions: finds the median of the array
; receives: ebp+16, ebp+12 and ebp+8
; title, array address and size
; returns: median
;-----------------------------------------
displayMedian PROC
	
	; stack frame
	push	ebp
	mov		ebp, esp
	; array address
	mov		edi, [ebp+12]

	; array size counter
	mov		ecx, [ebp+8]

	; Display median title
	call	Crlf
	mov		edx, [ebp+16]
	call	WriteString
	call	Crlf

	; find the middle of the array
	; by dividing the array in half
	mov		eax, ecx
	mov		ebx, 2
	cdq
	div		ebx

	; multiply middle number by 4 to get the address
	; address of 100th number 100*4 = 400
	; address of 101st number 400+4 = 404
	mov		ecx, 4
	mul		ecx			 
	add		edi, eax

	; Since the array is even you need the two inner most
	; number. n and n+1 (100th and 101st)
	mov		eax, [edi]	 
	mov		ebx, [edi+4] 

	; add the two numbers at the addresses
	add		eax, ebx	 
	mov		ecx, 2		 
	mov		edx, 0
	; divide by 2
	div		ecx	
	; check remainder
	cmp		edx, 1		
	je		remainder
	jmp		noRemainder

noRemainder:
	call	WriteDec
	jmp		endMedian

	; round up
remainder:
	add		eax, 1
	call	WriteDec

endMedian:
	pop ebp
	ret 12

displayMedian ENDP

;-----------------------------------------
; preconditions: uncounted number of frequency
; postconditions: counts the number of frequency 
; for each integer
; receives: ebp+20, ebp+16, ebp+12 and ebp+8
; title, array address and size, spacing
; returns: each integers number of frequency appeared
;-----------------------------------------
countList PROC

	call	 Crlf

	; stack frame
	push	ebp
	mov		ebp, esp

	; array address
	mov		edi, [ebp+12]

	; array size counter
	mov		ecx, [ebp+8]
	
	; starting number for 10-29
	mov		ebx, 10
	
	; Display median title
	call	Crlf
	mov		edx, [ebp+20]
	call	WriteString
	call	Crlf
	
	; loops for each number between 10-29
outerLoop:
	cmp		ebx, 29
	jg		endCount
	mov		edx, 0
	
	; Loops the entire array, compares numbers
	; starting with the first number in the array
	; counts the number of times it appeared
innerLoop:
	; start with the first number
	mov		eax, [edi]
	
	;compare numbers
	; jump if equal
	cmp		eax, ebx
	je		equal

	mov		eax, edx
	call	WriteDec

	mov		edx, [ebp+16]
	call	WriteString

	jmp		innerDone

; increment counter
; move to the next element
; jump to check for matches
equal:
	inc		edx
	add		edi, 4
	jmp		innerLoop

; Once it loops through the entire array
; increment ebx to check the frequency for the next number
innerDone:
	inc		ebx
	jmp		outerLoop

endCount:

	pop ebp
	ret 16

countList ENDP

; (insert additional procedures here)

END main
