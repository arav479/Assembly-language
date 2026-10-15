; PROGRAM: CONVERT LOWERCASE STRING TO UPPERCASE (using XLAT)
CR      EQU 0DH
LF      EQU 0AH

STACK   SEGMENT
        DW 100 DUP(?)
STACK   ENDS

DATA    SEGMENT
STRING   DB 'india', CR, LF, '$'      ; input must be LOWERCASE
STRLEN   EQU 5                        ; length of 'india'
MESSAGE1 DB 'THE ORIGINAL STRING: ', '$'
MESSAGE2 DB 'THE TRANSLATED STRING: ', '$'

; 256-byte table: offset 97 ('a') .. 122 ('z') holds 'A'..'Z'
TABLE   DB 48 DUP(' '), '0123456789', 39 DUP(' ')   ; 48+10+39 = 97
        DB 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 133 DUP(' ') ; 97+26+133 = 256
DATA    ENDS

CODE    SEGMENT
        ASSUME CS:CODE, DS:DATA, ES:DATA, SS:STACK
START:
        MOV AX, DATA
        MOV DS, AX
        MOV ES, AX

        LEA SI, STRING          ; source
        LEA DI, STRING          ; destination (same buffer, in place)
        LEA BX, TABLE           ; XLAT uses BX as table base
        MOV CX, STRLEN          ; loop counter = 5

        MOV AH, 09H             ; print "THE ORIGINAL STRING: "
        LEA DX, MESSAGE1
        INT 21H

        MOV AH, 09H             ; print original string
        LEA DX, STRING
        INT 21H

        CLD                     ; SI and DI increment
TOP:
        LODSB                   ; AL = [SI], SI = SI + 1
        XLAT                    ; AL = [BX + AL]
        STOSB                   ; [DI] = AL, DI = DI + 1
        LOOP TOP                ; CX = CX - 1, repeat until CX = 0

        MOV AH, 09H             ; print "THE TRANSLATED STRING: "
        LEA DX, MESSAGE2
        INT 21H

        MOV AH, 09H             ; print converted string
        LEA DX, STRING
        INT 21H

QUIT:
        MOV AL, 0
        MOV AH, 4CH             ; terminate program
        INT 21H
CODE    ENDS
        END START