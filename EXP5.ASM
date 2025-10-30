.MODEL SMALL
.STACK 100H

.DATA
prompt1       db 'Enter a string (max 20 chars): $'
prompt2       db 0Dh,0Ah,'Enter character to search: $'
foundMsg      db 0Dh,0Ah,'Character found in string.$'
notFoundMsg   db 0Dh,0Ah,'Character NOT found in string.$'

str1          db 21        ; maximum buffer size
              db 0         ; will contain number of chars entered
              db 21 dup('$') ; actual buffer storage

str2          db 21 dup(?)  ; copy destination
charToFind    db ?          ; search character

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX           ; ES must match DS for SCASB

    ; Display first prompt
    LEA DX, prompt1
    MOV AH, 09H
    INT 21H

    ; Read string (buffered input)
    LEA DX, str1
    MOV AH, 0Ah
    INT 21H

    ; Get string length → CX
    MOV CL, BYTE PTR str1+1
    XOR CH, CH
    MOV BX, CX           ; Save length for later

    ; Copy string from str1+2 → str2
    LEA SI, str1+2
    LEA DI, str2
    CLD
    REP MOVSB

    ; Prompt for character
    LEA DX, prompt2
    MOV AH, 09H
    INT 21H

    ; Read a single character
    MOV AH, 01H
    INT 21H
    MOV charToFind, AL

    ; Prepare for search using SCASB
    MOV AL, charToFind
    LEA DI, str2
    MOV CX, BX
    CLD
    REPNZ SCASB

    ; Check result
    JZ FOUND

    ; Not found message
    LEA DX, notFoundMsg
    MOV AH, 09H
    INT 21H
    JMP EXIT

FOUND:
    LEA DX, foundMsg
    MOV AH, 09H
    INT 21H

EXIT:
    MOV AH, 4Ch
    INT 21H

MAIN ENDP
END MAIN
