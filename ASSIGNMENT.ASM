.MODEL SMALL
.STACK 64
.DATA
LOGINMSG	DB 13,10,"===================================================="
       		DB 13,10,"||            Welcome to The Best Laundry          ||"
       		DB 13,10,"||               Service In Town!                  ||"
       		DB 13,10,"===================================================="
       		DB 13,10,"||                                                 ||"
       		DB 13,10,"||               New User? Register Now!           ||"
       		DB 13,10,"||                                                 ||"
       		DB 13,10,"||                 Select an Option:               ||"
       		DB 13,10,"||                                                 ||"
       		DB 13,10,"||                  [1] Login                      ||"
       		DB 13,10,"||                  [2] Register                   ||"
       		DB 13,10,"||                  [3] Exit Program               ||"
       		DB 13,10,"||                                                 ||"
       		DB 13,10,"===================================================="
       		DB 13,10,"$"

USER		DB 13,10,"Username(max:-10 Characters): $"
PROUSER		DB 13,10,"Welcome, Your Username is $"

PROPASS		DB 13,10,"Your Password(Encrypted): $"

PASS		DB 13,10,"Password(max:-10 Characters): $"

HEADER1		DB 13,10,"=================================================="
       		DB 13,10,"||         Thank You For Trusting Our           ||"
       		DB 13,10,"||          Exclusive Laundry Service!          ||"
      		DB 13,10,"=================================================="
       		DB 13,10,"||                                              ||"
       		DB 13,10,"||               Select an Option:              ||"
       		DB 13,10,"||                                              ||"
       		DB 13,10,"||              [1] Order Entry                 ||"
       		DB 13,10,"||              [2] Service Price               ||"
       		DB 13,10,"||              [3] Profile                     ||"
       		DB 13,10,"||                                              ||"
       		DB 13,10,"=================================================="
       		DB 13,10,"$"


NOTICE		DB 13,10,"Please note: Prices may vary due to taxes and our system does not charge cents."
		DB 13,10,"Currently, we offer a 20% discount for the whole month!$"

PROMPT		DB 13,10,"Press Any Input to Return$"

INPUT		DB 13,10,"Enter Input: $"

INPUT1		DB 13,10,"Enter Input (1 - 3): $"

MSG1        	DB 13,10,"Quantity of Clothing (1-9) : $"
	   
HEADER2		DB 13,10,"========================================================="
       		DB 13,10,"||     Price Listing For Our Exclusive Services        ||"
       		DB 13,10,"========================================================="
       		DB 13,10,"||                                                     ||"
       		DB 13,10,"||  [1] Dry Clean              - RM10                  ||"
       		DB 13,10,"||  [2] Stain Removal          - RM19                  ||"
       		DB 13,10,"||  [3] Wet Wash               - RM11                  ||"
       		DB 13,10,"||  [4] Premium Service        - RM150                 ||"
       		DB 13,10,"||                                                     ||"
       		DB 13,10,"========================================================="
       		DB 13,10,"$"


MSG3	     	DB 13,10,"Select Your Choice (1 - 4) : $"

MSG4         	DB 13,10,"Total Cost : RM$"

MSG5         	DB 13,10,"Amount of Transaction You Have Made Recently: $"

MSG6		DB 13,10,"Do You Wish to Return to Main Menu or Exit?"
		DB 13,10,"(Press 1 to Return to Main Menu or 2 to Exit)$"

INVMSG 		DB 13,10, "Invalid Username or Password.Please Try Again!$"


;-Variables for Username and Password
INAME 		DB 10 DUP ('?')
IPSW 		DB 10 DUP ('?')
UNAME 		DB 10 DUP ('?')
UPSW 		DB 10 DUP ('?')

DISPLAY_NAME 	DB 11 DUP ('?'), '$'
DISPLAY_PASS 	DB 11 DUP ('?'), '$'


;-Variables for the price of services
COUNT		DB 30H
QTY 		DB 0
DC  		DB 10
SR		DB 19
WW		DB 11
PS		DB 150


;-Variables for calculations part
TTL 		DB 0
TEN 		DB 10
TWENTY		DB 20
FIVE		DB 5
SIX		DB 6
HUND		DB 100
DISCOUNT	DB 0
SALESTAX	DB 0
SST		DB 0
QUOTIENT1   	DB 0
REMAINDER1   	DB 0
QUOTIENT2	DB 0
REMAINDER2	DB 0
QUOTIENT3	DB 0
REMAINDER3	DB 0


;-Variables to store the user's choice
CHOICE		DB 0
CHOICE2		DB 0
SELECTION	DB 0
PROGRAM		DB 0


;-Variables that involved in 4 digit calculations
TTL1		DW 0
TEN1		DW 10
TWENTY1		DW 20
SIX1		DW 6
HUND1		DW 100
DISCOUNT1	DW 0
SALESTAX1	DW 0
SST1		DW 0


.CODE
MAIN PROC
MOV AX,@DATA
MOV DS,AX

;--------------------------------------------------------------------------

HOME:
;-OUTPUT STRING:09H(LOGINMSG)
 MOV AH,09H
 LEA DX,LOGINMSG
 INT 21H
 CALL NEWLINE
;-OUTPUT STRING:09H(INPUT)
 MOV AH,09H
 LEA DX,INPUT1
 INT 21H
;-INPUT BYTE:01H
 MOV AH,01H
 INT 21H
 MOV CHOICE2,AL

;-------------------------------------

 CMP CHOICE2, '1'
 JE LOGIN
 CMP CHOICE2, '2'
 JE REGISTER
 CMP CHOICE2, '3'
 JMP EXIT

;-------------------------------------

REGISTER:
;-Display "Username: "
 MOV AH, 09H
 LEA DX, USER
 INT 21H

;-Input username into INAME, stop on Enter
 MOV SI, 0               ; Initialize index
GETNAME:
 MOV AH, 01H             ; BIOS function to read a character
 INT 21H
 CMP AL, 0DH             ; Check if the input is Enter (0DH)
 JE END_GETNAME          ; Jump to end if Enter is pressed
 MOV INAME[SI], AL       ; Store the character in INAME
 INC SI                  ; Increment index
 CMP SI, 10              ; Check if index reached the max length
 JE END_GETNAME          ; Stop if max length is reached
 JMP GETNAME             ; Repeat until Enter is pressed
END_GETNAME:
 MOV INAME[SI], '$'      ; End string with '$' if Enter is pressed

;-Display "Password: "
 MOV AH, 09H
 LEA DX, PASS
 INT 21H

;-Input password into IPSW, stop on Enter
 MOV SI, 0               ; Initialize index
GETPSW:
 MOV AH, 01H             ; BIOS function to read a character
 INT 21H
 CMP AL, 0DH             ; Check if the input is Enter (0DH)
 JE END_GETPSW           ; Jump to end if Enter is pressed
 MOV IPSW[SI], AL        ; Store the character in IPSW
 INC SI                  ; Increment index
 CMP SI, 10              ; Check if index reached the max length
 JE END_GETPSW           ; Stop if max length is reached
 JMP GETPSW              ; Repeat until Enter is pressed
END_GETPSW:
 MOV IPSW[SI], '$'       ; End string with '$' if Enter is pressed
 JMP HOME                ; Return to the main menu

;-------------------------------------

LOGIN:
;-Display "Username: "
 MOV AH, 09H
 LEA DX, USER
 INT 21H

;-Input username into UNAME, stop on Enter
 MOV SI, 0               ; Initialize index
GETNAME1:
 MOV AH, 01H             ; BIOS function to read a character
 INT 21H
 CMP AL, 0DH             ; Check if the input is Enter (0DH)
 JE END_GETNAME1         ; Jump to end if Enter is pressed
 MOV UNAME[SI], AL       ; Store the character in UNAME
 INC SI                  ; Increment index
 CMP SI, 10              ; Check if index reached the max length
 JE END_GETNAME1         ; Stop if max length is reached
 JMP GETNAME1            ; Repeat until Enter is pressed
END_GETNAME1:
 MOV UNAME[SI], '$'      ; End string with '$' if Enter is pressed

;-Display "Password: "
 MOV AH, 09H
 LEA DX, PASS
 INT 21H

;-Input password into UPSW, stop on Enter
 MOV SI, 0               ; Initialize index

GETPSW1:
 MOV AH, 01H             ; BIOS function to read a character
 INT 21H
 CMP AL, 0DH             ; Check if the input is Enter (0DH)
 JE END_GETPSW1          ; Jump to end if Enter is pressed
 MOV UPSW[SI], AL        ; Store the character in UPSW
 INC SI                  ; Increment index
 CMP SI, 10              ; Check if index reached the max length
 JE END_GETPSW1          ; Stop if max length is reached
 JMP GETPSW1             ; Repeat until Enter is pressed

END_GETPSW1:
 MOV UPSW[SI], '$'       ; End string with '$' if Enter is pressed

;--------------------------------------

;-Compare input username and password with registered ones
 MOV SI, 0
 MOV DI, 0

CHKNAME:
 CMP SI, 10
 JE CHKPSW
 MOV AL, UNAME[SI]
 CMP AL, INAME[SI]
 JE NNAME
 JNE ERROR

NNAME:
 INC SI
 JMP CHKNAME

CHKPSW:
 CMP DI, 10
 JE START
 MOV AL, UPSW[DI]
 CMP AL, IPSW[DI]
 JE NPSW
 JNE ERROR

NPSW:
 INC DI
 JMP CHKPSW

ERROR:
;-Display "INVMSG" message
 CALL NEWLINE
 MOV AH, 09H
 LEA DX, INVMSG
 INT 21H
 CALL NEWLINE
 INC COUNT
 JMP HOME

;--------------------------------------------------------------------------

START:
;-OUTPUT HEADER:09H(HEADER1)
 MOV AH,09H
 LEA DX,HEADER1
 INT 21H
 CALL NEWLINE
;-OUTPUT HEADER:09H(INPUT1)
 MOV AH,09H
 LEA DX,INPUT1
 INT 21H
;-INPUT BYTE:01H(USER CHOOSE THEIR SELECTION)
 MOV AH,01H
 INT 21H
 MOV SELECTION,AL

;-------------------------------------

 CMP SELECTION, '1'
 JE ORDERENTRY
 CMP SELECTION, '2'
 JE SERVICEPRICE
 CMP SELECTION, '3'
 JMP PROFILE

;-------------------------------------

SERVICEPRICE :
;-OUTPUT STRING:09H(HEADER2)
 MOV AH,09H
 LEA DX,HEADER2
 INT 21H
;-OUTPUT STRING:09H(NOTICE)
 MOV AH,09H
 LEA DX,NOTICE
 INT 21H
;-OUTPUT HEADER:09H(PROMPT)
 MOV AH,09H
 LEA DX,PROMPT
 INT 21H
;-OUTPUT HEADER:09H(INPUT)
 MOV AH,09H
 LEA DX,INPUT
 INT 21H
;-INPUT BYTE:01H
 MOV AH,01H
 INT 21H
 JMP START

;-------------------------------------

ORDERENTRY :
;-OUTPUT STRING:09H(MSG1)
 CALL NEWLINE
 MOV AH,09H
 LEA DX,MSG1
 INT 21H
;-INPUT BYTE:01H(USER INPUT QTY OF CLOTHING)
 MOV AH,01H
 INT 21H
;-MOVE INPUT BYTE (AL) TO QTY
 MOV QTY,AL
;-OUTPUT STRING:09H(HEADER2)
 CALL NEWLINE
 MOV AH,09H
 LEA DX,HEADER2
 INT 21H
 CALL NEWLINE
;-OUTPUT STRING:09H(MSG3)
 MOV AH,09H
 LEA DX,MSG3
 INT 21H
;--INPUT BYTE:01H (User choice of service)
 MOV AH,01H
 INT 21H 
 MOV CHOICE, AL    

;-------------------------------------

 CMP CHOICE, '1'
 JE DRYCLEAN
 CMP CHOICE, '2'
 JE STAINREMOVAL
 CMP CHOICE, '3'
 JE WETWASH
 CMP CHOICE, '4'
 JE PREMIUMSERVICE
 
;-------------------------------------

STAINREMOVAL:
;-CLEAR AX
MOV AX,0
;-CONVERT HEX TO DEC (QTY)
 SUB QTY,30H
;-MOVE MULTIPLICAND (QTY) TO AL
 MOV AL,QTY
;-MULTIPLIED WITH MULTIPLIER (SR)
 MUL SR
;-MOVE RESULT FROM AL TO TTL
 MOV TTL,AL
;-JUMP TO PERCENTAGE
 JMP PERCENTAGE

;-------------------------------------

DRYCLEAN:   
;-CLEAR AX
 MOV AX,0
;-CONVERT HEX TO DEC (QTY)
 SUB QTY,30H
;-MOVE MULTIPLICAND (QTY) TO AL
 MOV AL,QTY
;-MULTIPLIED WITH MULTIPLIER (DC)
 MUL DC
;-MOVE RESULT FROM AL TO TTL
 MOV TTL,AL
;-JUMP TO PERCENTAGE
 JMP PERCENTAGE

;-------------------------------------

WETWASH:
;-CLEAR AX
 MOV AX,0
;-CONVERT HEX TO DEC (QTY)
 SUB QTY,30H
;-MOVE MULTIPLICAND (QTY) TO AL
 MOV AL,QTY
;-MULTIPLIED WITH MULTIPLIER (WW)
 MUL WW
;-MOVE RESULT FROM AL TO TTL
 MOV TTL,AL
;-JUMP TO PERCENTAGE
 JMP PERCENTAGE

;-------------------------------------

PREMIUMSERVICE:
;-CLEAR AX
MOV AX,0
;-CONVERT HEX TO DEC (QTY)
 SUB QTY,30H
;-MOVE MULTIPLICAND (QTY) TO AL
 MOV AL,QTY
;-MULTIPLIED WITH MULTIPLIER (PS)
 MUL PS
;-MOVE RESULT FROM AL TO TTL
 MOV TTL1,AX
;-JUMP TO PERCENTAGE
 JMP PERCENTAGE1

;-------------------------------------

PERCENTAGE1 :
;-CLEAR AX
 MOV AX,0
 MOV DX,0
;-SALES TAX 6%
 MOV AX,TTL1
 MUL SIX1
 DIV HUND1
 MOV SALESTAX1,AX
;-CLEAR AX,0
 MOV AX,0
 MOV DX,0
;-SST 10%
 MOV AX,TTL1
 MUL TEN1
 DIV HUND1
 MOV SST1,AX
;-CLEAR AX,0
 MOV AX,0
 MOV DX,0
;-ADD SALESTAX & SST
 MOV AX,TTL1
 ADD AX,SALESTAX1
 ADD AX,SST1
 MOV TTL1,AX
;-CLEAR AX
 MOV AX,0
 MOV DX,0
;-APPLY 20% DISCOUNT
 MOV AX,TTL1
 MUL TWENTY1
 DIV HUND1
 MOV DISCOUNT1,AX
 MOV AX,0
 MOV DX,0
 MOV AX,TTL1
 SUB AX,DISCOUNT1
 MOV TTL1,AX
 JMP CHOICES

;-------------------------------------

PERCENTAGE :
;-CLEAR AX
 MOV AX,0
;-SALES TAX 6%
 MOV AL,TTL
 MUL SIX
 DIV HUND
 MOV SALESTAX,AL
;-CLEAR AX,0
 MOV AX,0
;-SST 10%
 MOV AL,TTL
 MUL TEN
 DIV HUND
 MOV SST,AL
;-ADD SALESTAX & SST
 MOV AL,TTL
 ADD AL,SALESTAX
 ADD AL,SST
 MOV TTL,AL
;-CLEAR AX
 MOV AX,0
;-APPLY 20% DISCOUNT
 MOV AL,TTL
 MUL TWENTY
 DIV HUND
 MOV DISCOUNT,AL
 MOV AL,TTL
 SUB AL,DISCOUNT
 MOV TTL,AL
 JMP CHOICES

;-------------------------------------

CHOICES: 
 CMP CHOICE, '1'
 JE CALC1
 CMP CHOICE, '2'
 JE CALC2
 CMP CHOICE, '3'
 JE CALC1
 CMP CHOICE, '4'
 JMP CALC3

;-------------------------------------

CALC1 :
;-CLEAR AX
 MOV AX,0
;-MOVE DIVIDEND (TTL) INTO AL
 MOV AL,TTL
;-DIVIDED BY DIVISOR (TEN)
 DIV TEN
;-MOVE QUOTIENT (AL) TO Q
 MOV QUOTIENT1,AL
;-MOVE REMAINDER (AH) TO R
 MOV REMAINDER1,AH
;-CONVERT DEC TO HEX (Q1,R1)
 ADD QUOTIENT1,30H
 ADD REMAINDER1,30H
;-OUTPUT STRING:09H(MSG4)
 MOV AH,09H
 LEA DX,MSG4
 INT 21H
;-OUTPUT BYTE:02H(Q1)
 MOV AH,02H
 MOV DL,QUOTIENT1
 INT 21H
;-OUTPUT BYTE:02H(R1)
 MOV AH,02H
 MOV DL,REMAINDER1
 INT 21H
 INC COUNT
 JMP START

;-------------------------------------

CALC2:
;-CLEAR AX
 MOV AX,0
;-MOVE DIVIDEND (TTL) INTO AL
 MOV AL,TTL
;-DIVIDED BY DIVISOR (TEN)
 DIV TEN
;-MOVE QUOTIENT (AL) TO Q1
 MOV QUOTIENT1,AL
;-MOVE REMAINDER (AH) TO R1
 MOV REMAINDER1,AH
;-CLEAR AX
 MOV AX,0
;-MOVE DIVIDEND (Q1) INTO AL
 MOV AL,QUOTIENT1
;-DIVIDED BY DIVISOR (TEN)
 DIV TEN
;-MOVE QUOTIENT (AL) TO Q2
 MOV QUOTIENT2,AL
;-MOVE REMAINDER (AH) TO R2
 MOV REMAINDER2,AH
;-CONVERT DEC TO HEX (Q2,R1,R2)
 ADD QUOTIENT2,30H
 ADD REMAINDER1,30H
 ADD REMAINDER2,30H
;-OUTPUT STRING:09H(MSG4)
 MOV AH,09H
 LEA DX,MSG4
 INT 21H
;-OUTPUT BYTE:02H(Q2)
 MOV AH,02H
 MOV DL,QUOTIENT2
 INT 21H
;-OUTPUT BYTE:02H(R2)
 MOV AH,02H
 MOV DL,REMAINDER2
 INT 21H
;-OUTPUT BYTE:02H(R1)
 MOV AH,02H
 MOV DL,REMAINDER1
 INT 21H
 INC COUNT
 JMP START

;-------------------------------------

CALC3 :
;-CLEAR AX
 MOV AX,0
 MOV DX,0
;-MOVE DIVIDEND (TTL) INTO AL 
 MOV AX,TTL1
;-DIVIDED BY DIVISOR (TEN)
 DIV TEN
;-MOVE QUOTIENT (AL) TO Q1 
 MOV QUOTIENT1,AL
;-MOVE REMAINDER (AH) TO R1 
 MOV REMAINDER1,AH
;-CLEAR AX
 MOV AX,0
 MOV DX,0
;-MOVE DIVIDEND (Q1) INTO AL 
 MOV AL,QUOTIENT1
;-DIVIDED BY DIVISOR (TEN) 
 DIV TEN
;-MOVE QUOTIENT (AL) TO Q2 
 MOV QUOTIENT2,AL
;-MOVE REMAINDER (AH) TO R2 
 MOV REMAINDER2,AH
;-CLEAR AX
 MOV AX,0
 MOV AL,QUOTIENT2
 DIV TEN
 MOV QUOTIENT3,AL
 MOV REMAINDER3,AH
;-CONVERT DEC TO HEX (R3,R2,R1,Q3)
 ADD REMAINDER3,30H
 ADD REMAINDER2,30H
 ADD REMAINDER1,30H
 ADD QUOTIENT3,30H
;-OUTPUT STRING:09H(MSG4)
 MOV AH,09H
 LEA DX,MSG4
 INT 21H
;-OUTPUT BYTE:02H(Q3)
 MOV AH,02H
 MOV DL,QUOTIENT3
 INT 21H
;-OUTPUT BYTE:02H(R3)
 MOV AH,02H
 MOV DL,REMAINDER3
 INT 21H
;-OUTPUT BYTE:02H(R2)
 MOV AH,02H
 MOV DL,REMAINDER2
 INT 21H
;-OUTPUT BYTE:02H(R1)
 MOV AH,02H
 MOV DL,REMAINDER1
 INT 21H
 INC COUNT
 JMP START

;-------------------------------------

PROFILE:
;-Copy UNAME to DISPLAY_NAME
 MOV SI, 0
 MOV DI, 0

COPY_UNAME:
 CMP SI, 10              ; Check if we reached the end of UNAME array
 JE END_UNAME_COPY       ; Jump to add '$' if end is reached
 MOV AL, UNAME[SI]       ; Load character from UNAME
 MOV DISPLAY_NAME[DI], AL  ; Copy character to DISPLAY_NAME
 INC SI
 INC DI
 JMP COPY_UNAME

END_UNAME_COPY:
 MOV DISPLAY_NAME[DI], '$' ; Add '$' to mark the end of string

;-Copy and XOR-encrypt UPSW to DISPLAY_PASS
 MOV SI, 0
 MOV DI, 0

COPY_UPSW:
 CMP SI, 10              ; Check if we reached the end of UPSW array
 JE END_UPSW_COPY        ; Jump to add '$' if end is reached
 MOV AL, UPSW[SI]        ; Load character from UPSW
 XOR AL, 0AAH            ; XOR encrypt the character with 0xAA
 MOV DISPLAY_PASS[DI], AL ; Copy encrypted character to DISPLAY_PASS
 INC SI
 INC DI
 JMP COPY_UPSW

END_UPSW_COPY:
 MOV DISPLAY_PASS[DI], '$' ; Add '$' to mark the end of string

;-Display Username
 CALL NEWLINE
 MOV AH, 09H
 LEA DX, PROUSER
 INT 21H
 MOV AH, 09H
 LEA DX, DISPLAY_NAME
 INT 21H

;-Display Encrypted Password
 CALL NEWLINE
 MOV AH, 09H
 LEA DX, PROPASS
 INT 21H
 MOV AH, 09H
 LEA DX, DISPLAY_PASS
 INT 21H

;-Display transaction history
 CALL NEWLINE
 MOV AH,09H
 LEA DX,MSG5
 INT 21H
 MOV AH,02H
 MOV DL,COUNT
 INT 21H
 CALL NEWLINE

;-MAIN MENU OR EXIT
 MOV AH,09H
 LEA DX,MSG6
 INT 21H
 CALL NEWLINE
 MOV AH,09H
 LEA DX,INPUT
 INT 21H
 MOV AH,01H
 INT 21H
 MOV PROGRAM, AL   

;-------------------------------------

 CMP PROGRAM, '2'
 JE EXIT
 CMP PROGRAM, '1'
 JMP START

;-------------------------------------
    
;-Input byte to continue
 MOV AH, 01H
 INT 21H
 JMP START

;-------------------------------------

NEWLINE PROC
;-Print Carriage Return (CR)
 MOV AH, 02H
 MOV DL, 0DH  ; ASCII code for Carriage Return
 INT 21H

;-Print Line Feed (LF)
 MOV AH, 02H
 MOV DL, 0AH  ; ASCII code for Line Feed
 INT 21H
 RET
NEWLINE ENDP

;-------------------------------------

EXIT:
MOV AH,4CH
INT 21H
MAIN ENDP
END MAIN