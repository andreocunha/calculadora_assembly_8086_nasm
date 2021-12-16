segment code
..start:
    MOV 	AX, data
    MOV 	DS, AX
    MOV 	AX, stack
    MOV 	SS,AX
    MOV 	SP,stacktop 

Main:
    call PrintNewLine
    call PrintMenu
    
    call ReadValue
    cmp dl, '1'
    je near Soma
    
    Operation2:
    cmp dl, '2'
    je near Subtracao
    
    Operation3:
    cmp dl, '3'
    je near Multi
    
    Operation4:
    cmp dl, '4'
    je near Divisao

    call Quit  


ReadNumber:
    mov ah,1h           ;read a character from console
    int 21h

    cmp al,13          ;if carriage return
    je Fim
    
    sub al,30h          ;convert number into bcd from ascii
    mov cl,al
    
    mov ax,[di]
    mov bx,10
    mul bx
    mov [di],ax

    add [di],cl
    jmp ReadNumber

    Fim:
        ret
    
Soma:
    mov dx,msg5         ;load address of msg1 into dx
    mov ah,9h           ;interrupt to display contents of dx
    int 21h
    mov di, num1
    call ReadNumber

    mov dx,msg6         ;load address of msg1 into dx
    mov ah,9h           ;interrupt to display contents of dx
    int 21h
    mov di, num2
    call ReadNumber
    
    mov ax,[num2]
    add ax,[num1]       ;add num1 to num2
    mov [result],ax        ;store sum in res

    mov dx,msg7         
    mov ah,9h
    int 21h

    mov dx,[result]
    call imprimenumero

    call PrintNewLine
    call Quit
    
Subtracao:
    mov dx,msg5         ;load address of msg1 into dx
    mov ah,9h           ;interrupt to display contents of dx
    int 21h
    mov di, num1
    call ReadNumber

    mov dx,msg6         ;load address of msg1 into dx
    mov ah,9h           ;interrupt to display contents of dx
    int 21h
    mov di, num2
    call ReadNumber
    
    mov ax,[num1]         
    sub ax,[num2]       ;sub num2 from num1
    mov [result],ax        ;store sum in res

    mov dx,msg7         
    mov ah,9h
    int 21h

    mov dx,[result]
    call imprimenumero
    call PrintNewLine
    call Quit

Multi:
    mov dx,msg5         ;load address of msg1 into dx
    mov ah,9h           ;interrupt to display contents of dx
    int 21h
    mov di, num1
    call ReadNumber

    mov dx,msg6         ;load address of msg1 into dx
    mov ah,9h           ;interrupt to display contents of dx
    int 21h
    mov di, num2
    call ReadNumber

    mov ax,[num1]
    mov bx,[num2]
    mul bx

    mov [result],ax

    mov dx,msg7
    mov ah,9h
    int 21h


    mov dx,[result]
    call imprimenumero

    call PrintNewLine


    call Quit

Divisao:
    mov dx,msg5         ;load address of msg1 into dx
    mov ah,9h           ;interrupt to display contents of dx
    int 21h
    mov di, num1
    call ReadNumber

    mov dx,msg6         ;load address of msg1 into dx
    mov ah,9h           ;interrupt to display contents of dx
    int 21h
    mov di, num2
    call ReadNumber

    mov ax,[num1]
    mov bl,[num2]
    div bl              ;div num1 to num2
    mov [result],al        ;store sum in res
    mov ch, ah
    add ch,30h          ;rest digit converted from ascii to bcd
    
    mov dx,msg7         
    mov ah,9h
    int 21h

    mov dx,[result]
    call imprimenumero
    
    mov dx,msg8         ;print ms8
    mov ah,9h
    int 21h

    mov ah,2h            ;print resto
    mov dl,ch
    int 21h


    call PrintNewLine

    call Quit

imprimenumero:
; Save the context
		PUSHF
		PUSH 	AX
		PUSH 	BX
		PUSH	CX
		PUSH 	DX
				
		MOV 	DI,saida
		CALL 	bin2ascii		

		MOV 	DX,saida
		MOV 	AH,9h
		INT 	21h         
		
; Upgrade the context
		POP 	DX
		POP 	CX
		POP		BX
		POP 	AX
		POPF
		RET

bin2ascii:
		CMP		DX,10
		JB		Uni
		CMP		DX,100 
		JB		Des
		CMP		DX,1000
		JB		Cen
		CMP		DX,10000
		JB		Mil
		JMP		Dezmil
			
Uni:	
		ADD		DX,0x0030
		MOV 	byte [DI],DL
		RET
Des:
		MOV 	AX,DX
		MOV		BL,10
		div		BL
		ADD		AH,0x30
		ADD		AL,0x30
		MOV 	byte [DI],AL
		MOV 	byte [DI+1],AH
		RET
Cen:		
		MOV 	AX,DX
		MOV		BL,100
		DIV		BL
		ADD		AL,0x30
		MOV 	byte [DI],AL
		MOV 	AL,AH
		AND		AX,0x00FF
		MOV		BL,10
		DIV		BL
		ADD		AH,0x30
		ADD		AL,0x30
		MOV 	byte [DI+1],AL		
		MOV 	byte [DI+2],AH
		RET
Mil:		
		MOV 	AX,DX
		MOV     DX,0
		MOV		BX,1000
		DIV		BX
		ADD		AL,0x30
		MOV 	byte [DI],AL
		MOV 	AX,DX
		MOV		BL,100
		DIV		BL
		ADD		AL,0x30
		MOV 	byte [DI+1],AL		
		MOV 	AL,AH
	    AND     AX,0x00FF
		MOV		BL,10
		DIV		BL
		ADD		AH,0x30
		ADD		AL,0x30
		MOV 	byte [DI+2],AL		
		MOV 	byte [DI+3],AH
		RET
Dezmil:
		MOV 	AX,DX
		MOV     DX,0
		MOV		BX,10000
		DIV		BX
		ADD		AL,0x30
		MOV 	byte [DI],AL
		MOV		AX,DX		
		MOV     DX,0
		MOV		BX,1000
		DIV		BX
		ADD		AL,0x30
		MOV 	byte [DI+1],AL
		MOV 	AX,DX
		MOV		BL,100
		DIV		BL
		ADD		AL,0x30
		MOV 	byte [DI+2],AL		
		MOV 	AL,AH
	    AND     AX,0x00FF
		MOV		BL,10
		DIV		BL
		ADD		AH,0x30
		ADD		AL,0x30
		MOV 	byte [DI+3],AL		
		MOV 	byte [DI+4],AH
		RET    

ReadValue:
    mov ah, 1h ; keyboard input subprogram
    int 21h ; read character into al
    mov dl, al ; copy character to dl
	ret			;

Print:
    mov ah,0x9
    int 0x21
    ret             	; retorna

PrintNewLine:
	mov dx,CRLF  
    call Print
    ret            


PrintMenu:
    mov dx, msg1		; Mensagem 1
    call Print      	; Chama a funcao Print
    
    mov dx,msg2		; Mensagem 2
    call Print      	; Chama a funcao 
    
    mov dx, msg3		; Mensagem 3
    call Print      	; Chama a funcao 
    
    mov dx, msg4		; Mensagem 4
    call Print      	; Chama a funcao 
    call PrintNewLine
    ret
    
Quit:
    MOV AH,4CH ; retorna para o DOS com código 0
    INT 21h  


segment data
    CR 		EQU		13
    LF 		EQU		10
    num1 dw 0
    num2 dw 0
    result dw 0
    resto dw 0
    msg1 db 10,13, "1 - SOMA $"
	msg2 db 10,13, "2 - SUBTRACAO $"
	msg3 db 10,13, "3 - MULTIPLICACAO $"
	msg4 db 10,13, "4 - DIVISAO $"
    msg5 db 10,13, "Digite o primeiro numero: $"
    msg6 db 10,13, "Digite o segundo numero: $"
    msg7 db 10,13, "Resultado: $"
    msg8 db 10,13, "Resto: $"
    CRLF db 0DH,0AH,'$'
    saida: 		resb 5 
            db CR,LF,'$'

segment stack stack
    resb 256 ; reserva 256 bytes para formar a pilha
    stacktop:
