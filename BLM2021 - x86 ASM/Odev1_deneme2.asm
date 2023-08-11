STEK SEGMENT PARA STACK 'STK'
DW 100 DUP(?)
STEK ENDS


DSG  SEGMENT PARA 'DTS'
    CR	EQU 13
    LF	EQU 10
    HATA	DB CR, LF, 'Dikkat !!! Sayi vermediniz yeniden giris yapiniz.!!!', 0        
    mesaj db CR, LF, "Hangi islemi yapmak istersiniz            M.Ali Bugday 19011076",0
    mesaj1 db CR, LF,"1)Dizi gir",0
    mesaj2 db CR, LF,"2)Linked goruntule",0
    mesaj3 db CR, LF,"3)Eleman ekle:",0
    mesaj4 db CR, LF,"4)cikis",0 
    mesaj5 db CR, LF,"dizinin uzunlugu:",0
    mesaj6 db CR, LF,"dizi degeri giriniz:",0
    mesaj7 db "-",0
    mesaj8 db ">",0
    mesaj9 db CR, LF,"Eklenecek dergeri giriniz:",0
    mesaj10 db CR, LF,"                                           M.Ali Bugday 19011076",0
    altsatir db CR, LF,"",0
    virgul db ", ",0
 
    dizi dw 0,15 dup(-100)
    dizi2 dw 0,15 dup(-100)
    max_si dw -1
    max_dizi dw -1000
    dizi_uzunluk dw 0 
    
DSG ENDS

CSG  SEGMENT PARA 'CODE'
ASSUME CS:CSG, DS:DSG, SS:STEK

BASLA   PROC FAR

PUSH DS
XOR AX,AX
PUSH AX

MOV AX, DSG
MOV DS, AX
 

 
;kod araligi basliyor
    MOV AX, OFFSET mesaj
    CALL PUT_STR
    
while:
    MOV AX, OFFSET mesaj1
    CALL PUT_STR
    MOV AX, OFFSET mesaj2
    CALL PUT_STR
    MOV AX, OFFSET mesaj3
    CALL PUT_STR   
    MOV AX, OFFSET mesaj4
    CALL PUT_STR
    CALL GETN
         
    cmp ax,1
    je bir
    
    cmp ax,2
    je iki
    
    cmp ax,3
    je uc
    
    cmp ax,4
    je son     
    
bir:
    
    MOV AX, OFFSET mesaj5
    CALL PUT_STR
    CALL GETN
    mov cx,ax
    mov dizi_uzunluk,cx
    
    call alt1      
    
    jmp secimsonu
      
iki:
    mov cx,dizi_uzunluk
    xor si,si
    
    MOV AX, OFFSET altsatir
    CALL PUT_STR
    
    call dizi2_yedekle
    mov max_dizi,-1000
    mov max_si,-1
    
    xor si,si
  l2:
    mov ax, dizi[si]
    call putn
    add si,2
    MOV AX, OFFSET virgul
    CALL PUT_STR
    loop l2
    
    MOV AX, OFFSET altsatir
    CALL PUT_STR
    
    mov cx,dizi_uzunluk
    l4:
        push cx
        mov cx,dizi_uzunluk
        xor si,si
        xor bx,bx             
                     
        mov ax,dizi[si]
        
        mov max_dizi,ax
         
      l5:
        add si,2
        mov ax,dizi[si]
        
        
        ;isaretli dallanma
        cmp dizi[si],-1
        jle isaretli
       
        cmp max_dizi,ax
        jg devam
       
        mov ax,dizi[si]
         
        mov max_dizi,ax
        mov bx,si
        jmp devam
        
 isaretli:
        cmp max_dizi,ax
        jg devam
        mov ax,dizi[si]
         
        mov max_dizi,ax
        mov bx,si      
        
    
    devam:
       
        loop l5
        
        xchg max_si,bx  
          
        mov ax,max_dizi
        call putn
        
        MOV AX, OFFSET mesaj7
        CALL PUT_STR
        MOV AX, OFFSET mesaj8
        CALL PUT_STR
        
        
        cmp bx,-1
        je ilk
        shr bx,1
        
        
     ilk:
        mov ax,bx
        call putn
        
        cmp bx,-1
        je ilk2
        shl bx,1
    ilk2:
        
        MOV AX, OFFSET virgul
        CALL PUT_STR
        
        xchg max_si,bx 
    
        mov dizi[bx],-100
        
        xchg max_si,bx
        
        pop cx
        sub cx,1
        jcxz devam2
        jmp l4
   devam2:     
    call dizi_yedekle
    jmp secimsonu
   


uc:
    call alt2
    
    ;jmp iki
    
             
secimsonu:
    MOV AX, OFFSET mesaj10
    CALL PUT_STR    
    jmp while
    
    
son:
;kod arali�i bitiyor



RETF
BASLA   ENDP 

alt1 proc 
    push cx
    push si
    push ax
    
    xor si,si
    
  l1:
    MOV AX, OFFSET mesaj6
    CALL PUT_STR
    CALL GETN
    mov dizi[si],ax
    add si,2
    loop l1      
    
    pop ax      
	pop si
	pop cx
    ret
alt1 endp

alt2 proc near
    push bx
    xor bx,bx
    
    MOV AX, OFFSET mesaj9
    CALL PUT_STR
    CALL GETN
    mov bx,dizi_uzunluk
    shl bx,1
    mov dizi[bx],ax
    add dizi_uzunluk,1
    
    
cikar:

        
    pop bx
    ret    
alt2 endp

dizi2_yedekle proc
    push cx
    push si
    
    mov cx,dizi_uzunluk
    xor si,si
    
  l6:
    mov ax,dizi[si]
    mov dizi2[si],ax
    add si,2
    loop l6  
    
    pop si
    pop cx
    ret
dizi2_yedekle endp

dizi_yedekle proc
    push cx
    push si
    
    mov cx,dizi_uzunluk
    xor si,si
    
  l7:
    mov ax,dizi2[si]
    mov dizi[si],ax
    add si,2
    loop l7  
    
    pop si
    pop cx
    ret
dizi_yedekle endp

GETC	PROC NEAR
        ;------------------------------------------------------------------------
        ; Klavyeden bas�lan karakteri AL yazmac�na al�r ve ekranda g�sterir. 
        ; i�lem sonucunda sadece AL etkilenir. 
        ;------------------------------------------------------------------------
        MOV AH, 1h
        INT 21H
        RET 
GETC	ENDP 

PUTC	PROC NEAR
        ;------------------------------------------------------------------------
        ; AL yazmac�ndaki de�eri ekranda g�sterir. DL ve AH de�i�iyor. AX ve DX 
        ; yazma�lar�n�n de�erleri korumak i�in PUSH/POP yap�l�r. 
        ;------------------------------------------------------------------------
        PUSH AX
        PUSH DX
        MOV DL, AL
        MOV AH,2
        INT 21H
        POP DX
        POP AX
        RET 
PUTC 	ENDP 

GETN 	PROC NEAR
        ;------------------------------------------------------------------------
        ; Klavyeden bas�lan sayiyi okur, sonucu AX yazmac� �zerinden dondurur. 
        ; DX: say�n�n i�aretli olup/olmad���n� belirler. 1 (+), -1 (-) demek 
        ; BL: hane bilgisini tutar 
        ; CX: okunan say�n�n islenmesi s�ras�ndaki ara de�eri tutar. 
        ; AL: klavyeden okunan karakteri tutar (ASCII)
        ; AX zaten d�n�� de�eri olarak de�i�mek durumundad�r. Ancak di�er 
        ; yazma�lar�n �nceki de�erleri korunmal�d�r. 
        ;------------------------------------------------------------------------
        PUSH BX
        PUSH CX
        PUSH DX
GETN_START:
        MOV DX, 1	                        ; say�n�n �imdilik + oldu�unu varsayal�m 
        XOR BX, BX 	                        ; okuma yapmad� Hane 0 olur. 
        XOR CX,CX	                        ; ara toplam de�eri de 0�d�r. 
NEW:
        CALL GETC	                        ; klavyeden ilk de�eri AL�ye oku. 
        CMP AL,CR 
        JE FIN_READ	                        ; Enter tu�una basilmi� ise okuma biter
        CMP  AL, '-'	                        ; AL ,'-' mi geldi ? 
        JNE  CTRL_NUM	                        ; gelen 0-9 aras�nda bir say� m�?
NEGATIVE:
        MOV DX, -1	                        ; - bas�ld� ise say� negatif, DX=-1 olur
        JMP NEW		                        ; yeni haneyi al
CTRL_NUM:
        CMP AL, '0'	                        ; say�n�n 0-9 aras�nda oldu�unu kontrol et.
        JB error 
        CMP AL, '9'
        JA error		                ; de�il ise HATA mesaj� verilecek
        SUB AL,'0'	                        ; rakam al�nd�, haneyi toplama d�hil et 
        MOV BL, AL	                        ; BL�ye okunan haneyi koy 
        MOV AX, 10 	                        ; Haneyi eklerken *10 yap�lacak 
        PUSH DX		                        ; MUL komutu DX�i bozar i�aret i�in saklanmal�
        MUL CX		                        ; DX:AX = AX * CX
        POP DX		                        ; i�areti geri al 
        MOV CX, AX	                        ; CX deki ara de�er *10 yap�ld� 
        ADD CX, BX 	                        ; okunan haneyi ara de�ere ekle 
        JMP NEW 		                ; klavyeden yeni bas�lan de�eri al 
ERROR:
        MOV AX, OFFSET HATA 
        CALL PUT_STR	                        ; HATA mesaj�n� g�ster 
        JMP GETN_START                          ; o ana kadar okunanlar� unut yeniden say� almaya ba�la 
FIN_READ:
        MOV AX, CX	                        ; sonu� AX �zerinden d�necek 
        CMP DX, 1	                        ; ��arete g�re say�y� ayarlamak laz�m 
        JE FIN_GETN
        NEG AX		                        ; AX = -AX
FIN_GETN:
        POP DX
        POP CX
        POP DX
        RET 
GETN 	ENDP 

PUTN 	PROC NEAR
        ;------------------------------------------------------------------------
        ; AX de bulunan sayiyi onluk tabanda hane hane yazd�r�r. 
        ; CX: haneleri 10�a b�lerek bulaca��z, CX=10 olacak
        ; DX: 32 b�lmede i�leme d�hil olacak. Soncu etkilemesin diye 0 olmal� 
        ;------------------------------------------------------------------------
        PUSH CX
        PUSH DX 	
        XOR DX,	DX 	                        ; DX 32 bit b�lmede soncu etkilemesin diye 0 olmal� 
        PUSH DX		                        ; haneleri ASCII karakter olarak y���nda saklayaca��z.
                                                ; Ka� haneyi alaca��m�z� bilmedi�imiz i�in y���na 0 
                                                ; de�eri koyup onu alana kadar devam edelim.
        MOV CX, 10	                        ; CX = 10
        CMP AX, 0
        JGE CALC_DIGITS	
        NEG AX 		                        ; say� negatif ise AX pozitif yap�l�r. 
        PUSH AX		                        ; AX sakla 
        MOV AL, '-'	                        ; i�areti ekrana yazd�r. 
        CALL PUTC
        POP AX		                        ; AX�i geri al 
        
CALC_DIGITS:
        DIV CX  		                ; DX:AX = AX/CX  AX = b�l�m DX = kalan 
        ADD DX, '0'	                        ; kalan de�erini ASCII olarak bul 
        PUSH DX		                        ; y���na sakla 
        XOR DX,DX	                        ; DX = 0
        CMP AX, 0	                        ; b�len 0 kald� ise say�n�n i�lenmesi bitti demek
        JNE CALC_DIGITS	                        ; i�lemi tekrarla 
        
DISP_LOOP:
                                                ; yaz�lacak t�m haneler y���nda. En anlaml� hane �stte 
                                                ; en az anlaml� hane en alta ve onu alt�nda da 
                                                ; sona vard���m�z� anlamak i�in konan 0 de�eri var. 
        POP AX		                        ; s�rayla de�erleri y���ndan alal�m
        CMP AX, 0 	                        ; AX=0 olursa sona geldik demek 
        JE END_DISP_LOOP 
        CALL PUTC 	                        ; AL deki ASCII de�eri yaz
        JMP DISP_LOOP                           ; i�leme devam
        
END_DISP_LOOP:
        POP DX 
        POP CX
        RET
PUTN 	ENDP 

PUT_STR	PROC NEAR
        ;------------------------------------------------------------------------
        ; AX de adresi verilen sonunda 0 olan dizgeyi karakter karakter yazd�r�r.
        ; BX dizgeye indis olarak kullan�l�r. �nceki de�eri saklanmal�d�r. 
        ;------------------------------------------------------------------------
	PUSH BX 
        MOV BX,	AX			        ; Adresi BX�e al 
        MOV AL, BYTE PTR [BX]	                ; AL�de ilk karakter var 
PUT_LOOP:   
        CMP AL,0		
        JE  PUT_FIN 			        ; 0 geldi ise dizge sona erdi demek
        CALL PUTC 			        ; AL�deki karakteri ekrana yazar
        INC BX 				        ; bir sonraki karaktere ge�
        MOV AL, BYTE PTR [BX]
        JMP PUT_LOOP			        ; yazd�rmaya devam 
PUT_FIN:
	POP BX
	RET 
PUT_STR	ENDP

CSG  ENDS
END BASLA