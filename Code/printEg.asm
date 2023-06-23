;Copyright © Mark F Kozel. Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
;Link: https://comp-org-etext.netlify.app/Assembly/BasicIO/LC3IO.html

.ORIG x3000
	LD R0, A ; Load ascii value of 'A'

	; Write characher to screen
	WAIT 	LDI R1, DSR	; Check DSR for ready
				BRzp WAIT		; loop until DSR is empty/ready
	STI R0, DDR				; Update DDR to display character

	HALT  ;End of Program

;Data Declarations-------------
	A	.FILL x41			; ASCCI 'A'
	DSR	.FILL xFE04	;Display Status Register
	DDR	.FILL xFE06	;Display Data Register
.END