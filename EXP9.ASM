DATA SEGMENT
Q DB 7H
M DB 3H
RESULT DW ?
DB 100 DUP(00H)
DATA ENDS
CODE SEGMENT
ASSUME CS: CODE, DS: DATA
START:MOV AX, DATA
MOV DS, AX
MOV BX, 0000H
MOV AX, 0000H
MOV CX, 0008H ; Number of Bits
MOV AL, Q ; Load Dividend in AL
BACK: SHL AX, 1 ; Shift A-Q towards left
SUB AH, M
MOV BH, AH ; Make copy of A in BH
SHL BH, 1 ; Move MSB of A in carry bit
JC NEXT ; Jump if A is less than 0
OR AL, 01H ; Make Q0 bit 1
JMP COUNT ; Jump for Count = Count - 1
NEXT: AND AL, 0FEH ; Make Q0 bit 0
ADD AH, M ; Restore A (A = A + M)
COUNT: LOOP BACK ; Decrement counter
MOV RESULT, AX ; Store result into memory
INT 3h
CODE ENDS

END START