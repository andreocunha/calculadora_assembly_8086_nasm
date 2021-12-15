segment code
..start:
    MOV 	AX, data
    MOV 	DS, AX
    MOV 	AX, stack
    MOV 	SS,AX
    MOV 	SP,stacktop 

Main:
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

ReadNumbers:
    mov dx,msg5         ;load address of msg1 into dx
    mov ah,9h           ;interrupt to display contents of dx
    int 21h    
    
    mov ah,1h           ;read a character from console
    int 21h
    sub al,30h          ;convert number into bcd from as

    mov [num1],al       ;store number as num1
    
    mov dx,msg6         ;load address of msg2 into dx
    mov ah,9h           ;interrupt to display contents of dx
    int 21h    
    
    mov ah,1h           ;read a character from console
    int 21h
    sub al,30h          ;convert number into bcd from ascii form
    mov [num2],al       ;store number as num2
    ret
    
Soma:
    call ReadNumbers

    mov al,[num2]

    add al,[num1]       ;add num1 to num2
    mov [res],al        ;store sum in res
    mov ah,0            ;clear garabage value (ah to be used later)
    aaa                 ;converts hex to bcd and stores values in ah and al 
    add ah,30h          ;first digit converted into bcd
    add al,30h          ;second digit converted from ascii to bcd
    
    mov bx,ax           ;save value of ax into bx
    mov dx,msg7         ;print ms3
    mov ah,9h
    int 21h
    
    mov ah,2h           ;print first digit
    mov dl,bh                                
    int 21h
    
    mov ah,2            ;print second digit
    mov dl,bl
    int 21h

    call PrintNewLine

    jmp Main
    
Subtracao:
    call ReadNumbers
    
    mov al,[num1]         
    sub al,[num2]       ;sub num2 from num1
    mov [res],al        ;store sum in res
    mov ah,0            ;clear garabage value (ah to be used later)
    aaa                 ;converts hex to bcd and stores values in ah and al 
    add ah,30h          ;first digit converted into bcd
    add al,30h          ;second digit converted from ascii to bcd
    
    mov bx,ax           ;save value of ax into bx
    mov dx,msg7         ;print ms3
    mov ah,9h
    int 21h
    
    mov ah,2h           ;print first digit
    mov dl,bh                                
    int 21h
    
    mov ah,2            ;print second digit
    mov dl,bl
    int 21h

    call PrintNewLine

    jmp Main

Multi:
    call ReadNumbers

    mov al,[num1]
    mov bl,[num2]
    mul bl
    mov [res],ax

    mov ah,0            ;clear garabage value (ah to be used later)
    aaa                 ;converts hex to bcd and stores values in ah and al 
    add ah,30h          ;first digit converted into bcd
    add al,30h          ;second digit converted from ascii to bcd
    
    mov bx,ax           ;save value of ax into bx
    mov dx,msg7         ;print ms3
    mov ah,9h
    int 21h
    
    mov ah,2h           ;print first digit
    mov dl,bh                                
    int 21h
    
    mov ah,2            ;print second digit
    mov dl,bl
    int 21h

    call PrintNewLine

    jmp Main



Divisao:
    call ReadNumbers

    mov ax,[num1]
    mov bl,[num2]
    div bl              ;div num1 to num2
    mov [res],al        ;store sum in res
    mov ch, ah

    mov ah,0            ;clear garabage value (ah to be used later)
    aaa                 ;converts hex to bcd and stores values in ah and al 
    add ah,30h          ;first digit converted into bcd
    add al,30h          ;second digit converted from ascii to bcd
    add ch,30h          ;rest digit converted from ascii to bcd
    
    mov bx,ax           ;save value of ax into bx
    mov dx,msg7         ;print ms3
    mov ah,9h
    int 21h
    
    mov ah,2h           ;print first digit
    mov dl,bh                                
    int 21h
    
    mov ah,2            ;print second digit
    mov dl,bl
    int 21h

    mov dx,msg8         ;print ms8
    mov ah,9h
    int 21h

    mov ah,2            ;print resto
    mov dl,ch
    int 21h

    call PrintNewLine

    jmp Main

    

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
    num1 dw 0
    num2 dw 0
    res dw 0
    msg1 db 10,13, "1 - SOMA $"
	msg2 db 10,13, "2 - SUBTRACAO $"
	msg3 db 10,13, "3 - MULTIPLICACAO $"
	msg4 db 10,13, "4 - DIVISAO $"
    msg5 db 10,13,"Digite o primeiro numero: $"
    msg6 db 10,13,"Digite o segundo numero: $"
    msg7 db 10,13,"Resultado: $"
    msg8 db 10,13,"Resto: $"
    CRLF   DB   0DH,0AH,'$'

segment stack stack
    resb 256 ; reserva 256 bytes para formar a pilha
    stacktop: