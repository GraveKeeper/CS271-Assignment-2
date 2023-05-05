; Assignment 2     (Assignment2.asm)

; Author(s): Sean Harrington
; CS_271 / Project ID                 Date: 1/28/2023

; Description: 
; Write and test a MASM program that performs the following tasks: 
; Display the program title and programmer’s name. Then get the user’s name and greet the user.
; Prompt the user to enter the number of Fibonacci terms to be displayed. Advise the user to enter
; an integer in the range [1 .. 46].
; Get and validate the user input (n).
; Calculate and display all of the Fibonacci numbers up to and including the n th term. The results
; should be displayed 5 terms per line with at least 5 spaces between terms.
; Display a parting message that includes the user’s name and terminate the program.


INCLUDE Irvine32.inc

; (insert constant definitions here)
.386
.stack 4096			;SS register
ExitProcess proto,dwExitCode:dword

.data
	intro1					BYTE				"Assignment 2: Fibonacci Numbers ",0		;Display Assignment name
	intro2					BYTE				"by: Sean Harrington ",0					;Display creators name
	promptN					BYTE				"What is your name: ",0						;Prompt for users input
	uName					BYTE				79 DUP(?)
	max = 80				
	promptA2				BYTE				"Hello There, ",0							;Cont.
	promptFib				BYTE				"Enter the number of Fibonacci ",0			;Cont.
	promptFib2				BYTE				"to be displayed Give the number ",0		;Cont.
	promptFib3				BYTE				"as an integer in the range [1 .. 46].",0	;Cont.
	promptUser				BYTE				"How many Fibonacci terms do you want: ",0
	fibIn					DWORD				?											;Take in Users input for first Num
	fibError				BYTE				"Out of range. Enter a number in [1 .. 46]",0		
	bye1					BYTE				"GoodBye, ",0								;Exit message and users name 
	userIn					DWORD				?											;Take in Fib number n
	vCheck					DWORD				?
	lProg					DWORD				?
	fibOne					DWORD				?
	fibTwo					DWORD				?
	counter_1				DWORD				?
	pUse					BYTE				"How"


; (insert variable definitions here)

.code
main PROC

; Introduction give assignment and name 
	Introduction:
		mov EDX, OFFSET intro1																;Move copy of into1 to a known address
		call WriteString																	;call write command
		call Crlf																			;End of line sequence

		mov EDX, OFFSET intro2																;Move copy of into1 to a known address
		call WriteString																	;call write command
		call Crlf																			;End of line sequence

; Outputs prompt for User to begin program 
	UserInstructions:
		mov EDX, OFFSET promptN																;Output Name Instructions
		call WriteString

		mov EDX, OFFSET uName
		mov ECX, MAX
		call ReadString																		;Take in Users name and save to uName
		call Crlf

		mov EDX, OFFSET promptA2															;Output Name and message
		call WriteString

		mov EDX, OFFSET uName
		call WriteString
		call Crlf
		
		mov EDX, OFFSET promptFib															;Output Program instructions
		call WriteString
		mov EDX, OFFSET promptFib2
		call WriteString
		call Crlf
		mov EDX, OFFSET promptFib3
		call WriteString
		call Crlf

; data validation for users input.
; Check for valid input being between 1 and 46
; Condition: vCheck < 47. vCheck > 0, vCheck = 0 give quit option
; Take in Users Number and save it to uIn

	GetUserData:																					
		mov vCheck, 46																		;Initialize highest end point
		mov lProg, 0																		;Initialize lowest breakout point
																							;Label for the beginning of the loop
																							;check input repeat if input not valid, continue if input is valid
			mov	EDX, OFFSET promptUser														;give prompt line and take in input		
			call WriteString																;ask for a number	
			call ReadInt																	;Puts input in EAX
			call Crlf
			mov userIn, EAX
		

		InvalidNum:
			mov	EDX, OFFSET fibError
			call WriteString
			cmp EAX, vCheck																		;Check if value entered is less then 47
			
																			; Label for the ending of the loop


;Display Fibonacci Numbers to screen as generated from user input
	DisplayFibs:
		mov ECX, userIn
		mov counter_1, ECX
		mov EAX, fibOne
		mov EBX, fibTwo

		mov EDX, OFFSET pUse
		call WriteString

	Fib_Loop_S:
		
		mov EAX, fibOne
		mov EBX, fibTwo
		add EAX, EBX
		call WriteDec
		call Crlf

		
		mov EBX, fibOne
		mov fibTwo, EAX
		
		sub counter_1, 1
		cmp	counter_1, eax
		je Fib_Loop_S


	Fib_Loop_E:

; Display exit message to screen
	Farewell:
		mov	EDX, OFFSET bye1				
		call WriteString
		mov	EDX, OFFSET uName
		call WriteString
		call Crlf


; (insert executable instructions here)

	
	invoke ExitProcess,0
	exit	; exit to operating system
main ENDP


; (insert additional procedures here)

END main
