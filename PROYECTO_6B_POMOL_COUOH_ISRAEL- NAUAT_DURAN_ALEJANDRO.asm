
;TECNOLOGICO NACIONAL DE MEXICO
;INSTITUTO TENCNOLOGICO SUPERIOR DE VALLADOLID

;EQUIPO: NAUAT DURAN ALEJANDRO DELA CRUZ 
;        POMOL COUOH ISRAEL

;MAESTRO: MMMD. JOSE LEONEL PECH MAY 

;ASIGNATURA: LENGUAJE Y AUTOMATAS II
;ACTIVIDAD: PROYECTO

;FECHA 01/06/2020

;PROYECTO

;PROGRAMA DEBE REALIZAR:

;-->SUMA                ;
;-->RESTA                ;NUMEROS COON DOS DIGITOS
;-->MULTIPLICACION      ;

;-->DIVISION            ; NUMEROS DE 1 DIGITO
;/////////////////////////////////////////////////////
;/////////////////////////////////////////////////////

org 100h       
OPERACION_SUMA MACRO m, n      ;MACRO DE PROCEDIMIENTO DE SUMA
    
        MOV AL,m
        ADD AL,n
        XOR AH,AH
        DIV cien
        ADD AL,30H
        MOV DL,AL
        MOV AL,AH
        AAM
        ADD AX,3030H
        MOV BX,AX
        MOV AH,2
        INT 21H
        MOV DL,BH
        INT 21H
        MOV DL,BL
        INT 21H
                                        ;FIN DE MACRO DE SUMA
    OPERACION_SUMA ENDM     
OPERACION_RESTA MACRO m, n      ;MACRO DE PROCEDIMIENTO DE RESTA
    
        MOV AL,m
        SUB AL,n
        AAM
        ADD AX,3030H
        MOV BX,AX
        MOV AH,2
        MOV DL,BH
        INT 21H
        MOV DL,BL
        INT 21H
                                        ;FIN DE MACRO DE RESTA
    OPERACION_RESTA ENDM  
OPERACION_MUL MACRO chr1, chr2, char3, chr4       ;MACRO DE PROCEDIMIENTO DE MULTIPLICACION
    
       MOV AL,chr4    ;UNIDAD DEL SEG. NUM.
       MOV BL,chr2    ;UNIDAD DEL PRI. NUM-
       MUL BL         ;MULTI
       MOV AH,0       ;LIMPIAMOS
       AAM          
       MOV ac1,AH     ;DECE. DE LA PRI. MUL.
       MOV r4,AL      ;UNI. DE LA PRI. MUL.       
       MOV AL,chr4    ;UNIDAD DEL SEG. NUM.
       MOV BL,chr1    ;DECENA DEL PRIM. NIM
       MUL BL         ;MULTI
       MOV r3,AL      ;RESULT. A R3
       MOV BL,ac1     ; ACARREO A BL
       ADD r3,BL      ;SUMA RESULT + ACARREO
       MOV AH,0       ;LIMPIAMOS
       MOV AL,r3      ;RESULT. A AL
       AAM          
       MOV r3,AL      ;UNIDAD EN R3
       MOV ac1,AH     ;DECENAS EN ACARREO
       MOV AL,chr3    ;REPETIMOS PROCESO PERO CON EL SIGUIENTE NUMERO
       MOV BL,chr2    
       MUL BL         
       MOV AH,0h      
       AAM            
       MOV ac,AH      
       MOV r2,AL      
       MOV AL,chr3    
       MOV BL,chr1    
       MUL BL         
       MOV r1,AL      
       MOV BL,ac      
       ADD r1,BL      
       MOV AH,0     
       MOV AL,r1      
       AAM            
       MOV r1,AL      
       MOV ac,AH     
;******SUMA FINAL*********
  
       MOV AX,0000h   ;LIMPIAMOS
       MOV AL,r3      ;RESULT. DE LA PRI. MUL. A AL
       MOV BL,r2      ;RESUL DE LA SEGUNDA MUL. A BL
       ADD AL,BL      ;SUMA
       MOV AH,0       ;LIMPIAMOS
       AAM            
       MOV r3,AL      ;DECE. DEL RESUL. A R3
       MOV r2,AH      ;R2 NUEVO ACARREO
       MOV AX,0000h   
       MOV AL,ac1     ;ACARREO DE LA PRIM. MUL. A AL
       MOV BL,r1      ;SEGUN. RESUL. DE LA SEGUN. MULT. A BL
       ADD AL,r2      ;SUMA DEL ACARREO A NUM. ANTERIOR
       ADD AL,BL      ;SUMA
       MOV AH,0       ;LIMPIAMOS
       AAM            
       MOV r1,AL      ;GUARDAMOS CENTENAS
       MOV r2,AH      ;GUARDAMOS ACARREO
       MOV AL,r2      ;ACARREO A AL
       MOV BL,ac      ;ACARREO A BL
       ADD AL,BL      ;SUMA
       MOV ac,AL      ;MOVEMOS ACARREO
;*******RESUL*****                

       MOV AH,02h 
       MOV DL,ac
       ADD DL,30h
       INT 21h        ;IMPRESION DE MILLAR
       MOV AH,02H
       MOV DL,r1
       ADD DL,30h
       INT 21h        ;IMPRESION CENTE.
       MOV AH,02H
       MOV DL,r3
       ADD DL,30h
       INT 21h        ;IMPRESION DECE.
       MOV AH,02H
       MOV DL,r4
       ADD DL,30h
       INT 21h        ;IMPRESION UNIDAD
                                        ;FIN DE MACRO DE MULTIPLICACION
    OPERACION_MUL ENDM        
OPERACION_DIV MACRO var1, var2        ;MACRO DE PROCEDIMIENTO DE DIVISION
    
        MOV AL,var2
        MOV BL,AL
        MOV AL,var1
        DIV BL              ;DIVISION
        MOV BL,AL
        
        MOV DL,BL
        ADD DL,30h
        MOV AH,02h
        INT 21h  
        
    OPERACION_DIV ENDM         ;FIN DE MACRO DE DIVISION

.STACK 
.DATA  ;SEGMENTO DE DATOS DEL PROGRAMA
    menu DB 10,13, '---- MENU ----', 10, 13, 'PRESIONE 1.- OPERACIONES SUMAS' , 10, 13, 'PRESIONE 2.- OPERACIONES RESTAS', 10, 13, 'PRESIONE 3.- OPERACIONES MULTIPLICACION',, 10, 13, 'PRESIONE 4.- OPERACIONES DIVISION' , 10, 13, 'PRESOINE X.- PARA SALIR', 10,13, '$'   
    ms1 DB 10,13,'INGRESE NUMERO: $'
    ms2 DB 10,13,'LA SUMA ES: $'
    ms3 DB 10,13,'LA RESTA ES: $'
    ms4 DB 10,13,'LA MULTIPLICACION ES: $'  
    ms5 DB 10,13,'LA DIVISION ES: $'       
    ;VARIABLES DE SUMA Y RESTA
    m DB ?
    n DB ?
    s DB ?
    d DB ?
    cien DB 100   
    ;VARABLES DE MULTIPLI
    chr1  db ? 
    chr2  db ? 
    chr3  db ? 
    chr4  db ?
    r1    db ? 
    r2    db ? 
    r3    db ?
    r4    db ?
    ac    db 0 
    ac1   db 0         
    ;VARIABLES DE DIVI
    var1 db 0
    var2 db 0
    
    LINEA DB 13, 10, '$'   
    LISTO DB 10, 13, 'ENTER$'
    ESPACIO DB ' $'
.CODE   ;SEGMENTO DEL CODIGO
.STARTUP     ;SEGMENTO DE ARRANQUE
   
   COMIENZO:                     ;ETIQUETA DE INICIO
        CALL LIMPIAR              ;LLAMAMOS PROCEDIMIENTO LIMPIAR
        MOV AX, @DATA             ;OBTENEMOS LOS DATOS
        MOV DS, AX                ;
        MOV ES, AX                ;
                                  ;FIN
        MOV AH, 9                 ;IMPRESION DE LA VARIABLE MENU
        LEA DX, menu              ;
        INT 21h                   ;FIN       
   
    LEER_OP:                      ;ETIQUETA DE SELECION DEL MENU PRINCIPAL
        MOV AH, 1                 ;LEE DATO
        INT 21h                   ;FIN
        
        CMP AL, 49                ;INICION DE SECUANCIA DE COMPARADORES
        JE SUMAR                  ;49-->1    SUMAR
                                  ;
        CMP AL, 50                ;50-->2
        JE RESTA                  ;SALTAMOS A RESTAS
                                  ;      
        CMP AL, 51                ;50-->3
        JE MULTIPLICACION         ;SALTAMOS A MULTIPLICACION
                                  ;
        CMP AL, 52                ;50-->4
        JE DIVISION               ;SALTAMOS A DIVISION
                                  ;
        CMP AL, 120               ;120-->x
        JE CERRAR                 ;SALTAMOS A ETIQUETA
                                  ;
        CMP AL, 88                ;88-->X
        JE CERRAR                 ;SALTAMOS A ETIQUETA               
    
    
