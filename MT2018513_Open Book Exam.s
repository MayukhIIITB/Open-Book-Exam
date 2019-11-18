;Circle Question
;By Mayukh Ghosh MT2018513
;sinx value stored in S12
;cosx value stored in S11
;x coordinate in S17
;y coordinate in S18
;New X cordinate stored in S19
;New Y coordinate stored in S20

	 AREA     CIRCLE, CODE, READONLY
     EXPORT __main
	 IMPORT printMsg
	 ;IMPORT printMsg4p
     ENTRY 
__main  FUNCTION	

		VLDR.F32 S31,=1;
		VLDR.F32 S14,=1;Holding 'x' value(in degrees)
		MOV R8, #0;
	 	VLDR.F32 S15,=0.0174533; changing degress into radians 
ANGLE	BL CONV
		VMUL.F32 S0,S14,S15 ; changing degress into radians 
		VADD.F32 S14,S14,S31;
		ADD R8, R8, #1;
		
		
		VCVT.S32.F32 S19,S19
		
		VMOV.F32 R0,S19;
		
		VCVT.S32.F32 S20,S20
		
		VMOV.F32 R1,S20;

		
		MOV R2, #50;
		BL printMsg4p
		CMP R8,#360;
		BNE ANGLE
		
		

		
		;VLDR.F S14,=120;x in degree
		;VLDR.F S0,= 2 ; value of x
		
CONV	VMOV.F S4,S0  ; value of x
		
		VLDR.F S5,= 1
		
		LDR R6,= 0x00000000 ;
		
		
		VLDR.F S6,= 1
		
		VLDR.F S7,= 1
		
		VLDR.F S10,= 1 ; 
		
		LDR R3,= 0x00000008 ; iteration
		
		VMOV.F S3,R3 ; 
		
		VCVT.F32.U32 S3,S3
		
		ADD R2,R3,R3 ; 
		
		VMOV.F S2,R2 ; 
		
		VCVT.F32.U32 S2,S2
		
		
		LDR R4,= 0x00000000 ; 
		
		
		LDR R10,= 0x00000000 ; 
		
		
		LDR R5,= 0x00000000 ; 
		
		
		LDR R0,= 0x00000001 ;
		
		
		VLDR.F S9,= 0 ; final value 
		
nxt
		LDR R12,= 0x00000000 ; 
		
		CMP R10,R3
		
		BNE cosf
		
		VMOV.F S11,S9 ; final cos result in S11
		
		LDR R12,= 0x00000001 ; R12 = 1 for sin
		
		
		LDR R4,= 0x00000000 ;
		
		LDR R10,= 0x00000000 ; 
		
		
		BEQ sinf
		
		
nxtSINE
		
		CMP R10,R3 ;
		
		BNE sinf
		
		VMOV.F S12,S9 ; final  value of sin
		
		
		
		B points
		
cosf
		B oddeven
sinf

		AND R7,R4,#0x00000001
		
		ADD R4,R4,R4 
		
		ADD R4,#0x00000001
		
		CMP R4,#0x00000001
		
		LDR R5,= 0x00000000 ; 
		
		LDR R6,= 0x00000000 ;
		
		VLDR.F S5,= 1
		
		BEQ fitrsin
		
		BNE raise1
		
L 
		VDIV.F S8,S0,S5
		
		CMP R7,R0
		
		ITE LT
		
		VADDLT.F S9,S9,S8
		
		VSUBGE.F S9,S9,S8 ; 
		
		ADD R10,#0x00000001
		
		MOV R4,R10
		
		VLDR.F S5,= 1
		
		VMOV.F S0,S4
		
		LDR R6,= 0x00000000 ;
		
		VLDR.F S6,= 1
		
		LDR R5,= 0x00000000 ; 
		
		CMP R12,#0x00000001
		
		BEQ nxtSINE
		
		BNE nxt 
		
		

cos 
		ADD R4,R4,R4
		
		CMP R4,#0x00000000
		
		BEQ fitr
		
		BNE raise1
raise1		

		SUB R11,R4,#0x00000001
		
		VMUL.F S0,S0,S4 ; 
		
		ADD R5,#0x00000001
		
		CMP R5,R11
		
		BNE raise1
		
		BEQ factorial
		
		
fitr
		VMOV.F S0,S10
		
		VMOV.F S5,S10
		
		B L
		
fitrsin

		VMOV.F S0,S4
		
		VMOV.F S5,S4
		
		VMOV.F S9,S4
		
		ADD R10,#0x00000001
		
		mov r4,r10
		
		B nxtSINE
		
factorial 
		CMP R4,#0x00000000
		
		BEQ fitr
		
		VMUL.F S5,S5,S6 ; factorial value
		
		
		ADD R6,#0x00000001
		
		VMOV.F S6,R6
		
		VCVT.F32.U32 S6,S6
		
		VADD.F S6,S6,S10
		
		CMP R6,R4
		
		BNE factorial
		
		BEQ L
		
oddeven
		AND R7,R4,#0x00000001
		
		B cos
		
		
points	
		
		VLDR.F32 S16,=50;Holding radius 'r' value
		
		;// Calculation Of X and Y coordinates with zero as centre
		
		VMUL.F32 S17,S16,S11 ;X coordinate // x=r*cos(theta) x is stored in S17
		
		VMUL.F32 S18,S16,S12 ;Y coordinate // y=r*sin(theta) y is stored in S18
		
		MOV R0,#320 ;
		VMOV.F S21,R0; 
	    VCVT.F32.U32 S21,S21;
	   
	    MOV R1,#240 ;
		VMOV.F S22,R1 ; 
	    VCVT.F32.U32 S22,S22;
	   
		VADD.F32 S19,S17,S21 ; New X coordinate X=320+x
		
		
		VADD.F32 S20,S18,S22  ;New Y coordinate Y=240+y
		
		BX LR
		;B printMsg	 ; Refer to ARM Procedure calling standards.
stop    B stop ; stop program
        ENDFUNC
        END