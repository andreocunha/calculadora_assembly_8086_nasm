segment code
..start:
    MOV 	AX, data
    MOV 	DS, AX
    MOV 	AX, stack
    MOV 	SS,AX
    MOV 	SP,stacktop 

Main:
    call PrintNewLine   ;chama a rotina de impressao de nova linha
    call PrintMenu      ;chama a rotina de impressao do menu
    
    call ReadOperation  ;chama a rotina de leitura da operacao
    cmp dl, '1'         ;compara se a operacao eh 1
    je near Soma        ;se for, chama a rotina de soma
    
    Operation2:         ;rotina de subtracao
    cmp dl, '2'         ;compara se a operacao eh 2
    je near Subtracao   ;se for, chama a rotina de subtracao
    
    Operation3:         ;rotina de multiplicacao
    cmp dl, '3'         ;compara se a operacao eh 3
    je near Multi       ;se for, chama a rotina de multiplicacao
    
    Operation4:         ;rotina de divisao
    cmp dl, '4'         ;compara se a operacao eh 4
    je near Divisao     ;se for, chama a rotina de divisao

    call Quit           ;chama a rotina de saida


ReadNumber:
    mov ah,1h          ;le um caractere do teclado
    int 21h            ;chama a rotina de leitura do teclado

    cmp al,13          ;retorna se detectar que o caractere eh ENTER
    je Fim             ;se for, entao sai do programa
    
    sub al,30h         ;subtrai o valor de 30 para converter de ASCII para valor decimal
    mov cl,al
    
    mov ax,[di]        ;pega o valor de di
    mov bx,10          ;multiplica o valor de 10
    mul bx              ;multiplica o valor de di por 10
    mov [di],ax     ;atualiza o valor de di

    add [di],cl      ;adiciona o valor de cl ao valor de di
    jmp ReadNumber  ;chama a rotina de leitura do teclado novamente

    Fim:
        ret
    
Soma:
    mov dx,msg5         ;pega o valor de msg5
    mov ah,9h           ;chama a rotina de impressao
    int 21h             ;chama a rotina de impressao
    mov di, num1        ;pega o valor de num1
    call ReadNumber     ;chama a rotina de leitura do teclado

    mov dx,msg6         ;pega o valor de msg6
    mov ah,9h           ;chama a rotina de impressao
    int 21h             ;chama a rotina de impressao
    mov di, num2        ;pega o valor de num2
    call ReadNumber     ;chama a rotina de leitura do teclado
    
    mov ax,[num2]       ;pega o valor de num2
    add ax,[num1]       ;soma o valor de num1 ao valor de num2
    mov [result],ax     ;atualiza o valor de result

    mov dx,msg7         ;pega o valor de msg7
    mov ah,9h           ;chama a rotina de impressao
    int 21h             ;chama a rotina de impressao

    mov dx,[result]     ;pega o valor de result
    call imprimenumero  ;chama a rotina de impressao de numero

    call PrintNewLine   ;chama a rotina de impressao de nova linha
    call Quit           ;chama a rotina de saida do programa
    
Subtracao:
    mov dx,msg5         ;pega o valor de msg5
    mov ah,9h           ;chama a rotina de impressao
    int 21h             ;chama a rotina de impressao
    mov di, num1        ;pega o valor de num1
    call ReadNumber     ;chama a rotina de leitura do teclado

    mov dx,msg6         ;pega o valor de msg6
    mov ah,9h           ;chama a rotina de impressao
    int 21h             ;chama a rotina de impressao
    mov di, num2        ;pega o valor de num2
    call ReadNumber     ;chama a rotina de leitura do teclado
    
    mov ax,[num1]       ;pega o valor de num1
    sub ax,[num2]       ;subtrai o valor de num2 do valor de num1
    mov [result],ax     ;atualiza o valor de result

    mov dx,msg7         ;pega o valor de msg7
    mov ah,9h           ;chama a rotina de impressao
    int 21h             ;chama a rotina de impressao

    mov dx,[result]     ;pega o valor de result
    call imprimenumero  ;chama a rotina de impressao de numero
    call PrintNewLine   ;chama a rotina de impressao de nova linha
    call Quit           ;chama a rotina de saida do programa

Multi:
    mov dx,msg5         ;pega o valor de msg5
    mov ah,9h           ;chama a rotina de impressao
    int 21h             ;chama a rotina de impressao
    mov di, num1        ;pega o valor de num1
    call ReadNumber     ;chama a rotina de leitura do teclado

    mov dx,msg6         ;pega o valor de msg6
    mov ah,9h           ;chama a rotina de impressao
    int 21h             ;chama a rotina de impressao
    mov di, num2        ;pega o valor de num2
    call ReadNumber     ;chama a rotina de leitura do teclado

    mov ax,[num1]       ;pega o valor de num1
    mov bx,[num2]       ;pega o valor de num2
    mul bx              ;multiplica o valor de num1 com o valor de num2

    mov [result],ax     ;atualiza o valor de result

    mov dx,msg7         ;pega o valor de msg7
    mov ah,9h           ;chama a rotina de impressao
    int 21h             ;chama a rotina de impressao


    mov dx,[result]     ;pega o valor de result
    call imprimenumero  ;chama a rotina de impressao de numero

    call PrintNewLine   ;chama a rotina de impressao de nova linha


    call Quit

Divisao:
    mov dx,msg5         ;pega o valor de msg5
    mov ah,9h           ;chama a rotina de impressao
    int 21h             ;chama a rotina de impressao
    mov di, num1        ;pega o valor de num1
    call ReadNumber     ;chama a rotina de leitura do teclado

    mov dx,msg6         ;pega o valor de msg6
    mov ah,9h           ;chama a rotina de impressao
    int 21h             ;chama a rotina de impressao
    mov di, num2        ;pega o valor de num2
    call ReadNumber     ;chama a rotina de leitura do teclado

    mov ax,[num1]       ;pega o valor de num1
    mov bl,[num2]       ;pega o valor de num2
    div bl              ;divide o valor de num1 por num2
    mov [result],al     ;atualiza o valor de result
    mov ch, ah          ;pega o resto da divisao
    add ch,30h          ;adiciona 30 ao resto da divisao para converter de ASCII para valor decimal
    
    mov dx,msg7         ;pega o valor de msg7
    mov ah,9h           ;chama a rotina de impressao
    int 21h             ;chama a rotina de impressao

    mov dx,[result]     ;pega o valor de result
    call imprimenumero  ;chama a rotina de impressao de numero
    
    mov dx,msg8         ;pega o valor de msg8
    mov ah,9h           ;chama a rotina de impressao
    int 21h             ;chama a rotina de impressao

    mov ah,2h           ;chama a rotina de impressao
    mov dl,ch           ;pega o valor de ch, que contem o resto da divisao
    int 21h             ;chama a rotina de impressao 


    call PrintNewLine   ;chama a rotina de impressao de nova linha

    call Quit           ;chama a rotina de saida do programa

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

ReadOperation:
    mov ah, 1h          ;chama a rotina de leitura do teclado
    int 21h             ;chama a rotina de leitura do teclado
    mov dl, al          ;pega o valor de al, que contem o caractere digitado
	ret			        ;retorna para o programa principal

Print:
    mov ah,0x9          ;chama a rotina de impressao
    int 0x21            ;chama a rotina de impressao
    ret                 ;retorna para o programa principal

PrintNewLine:
	mov dx,CRLF         ;pega o valor de CRLF que contem o caractere de nova linha
    call Print          ;chama a rotina de impressao
    ret                 ;retorna para o programa principal


PrintMenu:
    mov dx, msg1		; Mensagem 1
    call Print      	; chama a rotina de impressao
    
    mov dx,msg2		    ; Mensagem 2
    call Print      	; chama a rotina de impressao
    
    mov dx, msg3		; Mensagem 3
    call Print      	; chama a rotina de impressao
    
    mov dx, msg4		; Mensagem 4
    call Print      	; chama a rotina de impressao
    call PrintNewLine   ; chama a rotina de impressao de nova linha
    ret                 ; retorna para o programa principal
    
Quit:
    MOV AH,4CH  ; retorna para o DOS com código 0
    INT 21h     ; chama a rotina de retorno para o DOS


segment data
    CR 		EQU		13
    LF 		EQU		10
    num1 dw 0           ;numero 1
    num2 dw 0           ;numero 2
    result dw 0         ;resultado
    resto dw 0          ;resto
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