; PROGRAM: CONVERT UPPERCASE STRING TO LOWERCASE (using XLAT)
CR      EQU 0DH
LF      EQU 0AH

STACK   SEGMENT
        DW 100 DUP(?)
STACK   ENDS

DATA    SEGMENT
STRING   DB 'INDIA', CR, LF, '$'      ; input must be UPPERCASE
STRLEN   EQU 5                        ; length of 'INDIA'
MESSAGE1 DB 'THE ORIGINAL STRING: ', '$'
MESSAGE2 DB 'THE TRANSLATED STRING: ', '$'

; 256-byte table: offset 65 ('A') .. 90 ('Z') holds 'a'..'z'
TABLE   DB 48 DUP(' '), '0123456789', 7 DUP(' ')    ; 48+10+7 = 65
        DB 'abcdefghijklmnopqrstuvwxyz', 165 DUP(' ') ; 65+26+165 = 256
DATA    ENDS

CODE    SEGMENT
        ASSUME CS:CODE, DS:DATA, ES:DATA, SS:STACK
START:
        MOV AX, DATA
        MOV DS, AX
        MOV ES, AX

        LEA SI, STRING
        LEA DI, STRING
        LEA BX, TABLE
        MOV CX, STRLEN

        MOV AH, 09H
        LEA DX, MESSAGE1
        INT 21H

        MOV AH, 09H
        LEA DX, STRING
        INT 21H

        CLD
TOP:
        LODSB
        XLAT
        STOSB
        LOOP TOP

        MOV AH, 09H
        LEA DX, MESSAGE2
        INT 21H

        MOV AH, 09H
        LEA DX, STRING
        INT 21H

QUIT:
        MOV AL, 0
        MOV AH, 4CH
        INT 21H
CODE    ENDS
        END START