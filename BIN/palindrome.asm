; PROGRAM: CHECK WHETHER A STRING IS A PALINDROME
CR      EQU 0DH
LF      EQU 0AH

STACK   SEGMENT
        DW 100 DUP(?)
STACK   ENDS

DATA    SEGMENT
STRING1   DB 'LIRIL'                   ; word to test (change to try others)
STRLENGTH EQU $-STRING1                ; length = 5 (calculated by assembler)
MESSAGE1  DB 'THE GIVEN WORD IS PALINDROME', CR, LF, '$'
MESSAGE2  DB 'THE GIVEN WORD IS NOT PALINDROME', CR, LF, '$'
STRING2   DB STRLENGTH DUP(' ')        ; buffer for the reversed copy
DATA    ENDS

CODE    SEGMENT
        ASSUME CS:CODE, DS:DATA, ES:DATA, SS:STACK
START:
        MOV AX, DATA
        MOV DS, AX
        MOV ES, AX

        ; ---- Step 1: copy STRING1 into STRING2 in reverse ----
        LEA SI, STRING1                 ; SI -> first char of STRING1
        LEA DI, STRING2+STRLENGTH-1     ; DI -> LAST byte of STRING2
        MOV CX, STRLENGTH
TOP:
        CLD                             ; read forward
        LODSB                           ; AL = [SI], SI = SI + 1
        STD                             ; write backward
        STOSB                           ; [DI] = AL, DI = DI - 1
        LOOP TOP

        ; ---- Step 2: compare STRING1 with STRING2 ----
        LEA SI, STRING1
        LEA DI, STRING2
        CLD                             ; compare forward
        MOV CX, STRLENGTH
        REPE CMPSB                      ; repeat while bytes are equal
        JNZ NOTPALINDROME               ; ZF=0 -> a mismatch was found

        MOV AH, 09H                     ; all equal -> palindrome
        LEA DX, MESSAGE1
        INT 21H
        JMP QUIT

NOTPALINDROME:
        MOV AH, 09H
        LEA DX, MESSAGE2
        INT 21H

QUIT:
        MOV AL, 0
        MOV AH, 4CH
        INT 21H
CODE    ENDS
        END START