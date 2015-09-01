; Projeto de controle de servomotor
; Programador: Francisco Edno

;******************************************************************************
; Equates and definitions
;******************************************************************************
SERVO   equ   p2.0

;******************************************************************************
; Interrupt vectors entry point
;******************************************************************************
            org     0000h   ;Reset ENTRY POINT
            ljmp    _main

            org     0003h   ;External 0 ENTRY POINT
            ljmp    _ext0

            org     000Bh   ;Timer 0 ENTRY POINT
            ljmp    _tmr0

            org     0013h   ;External 1 ENTRY POINT
            ljmp    _ext1

            org     001Bh   ;Timer 1 ENTRY POINT
            ljmp    _tmr1

            org     0023h   ;Serial Port ENTRY POINT
            ljmp    _serial

            org     002Bh   ;Timer 2 ENTRY POINT
            ljmp    _tmr2

;******************************************************************************
; Main
;******************************************************************************
            org     0030h       ; reset entry point
_main:      mov     ie, #82h    ; habilita a interrupcao do timer 0
            mov     tmod, #01h  ; timer 0 no modo 1

            mov     r7, #07

            setb    f0
            acall   ReloadHT    ; recarrega o timer com tempo alto
            setb    tr0         ; liga o timer 0

            ajmp    $           ; espera as interrupcoes

;******************************************************************************
; ISR - Interrupt Service Routines
;******************************************************************************

;------------------------------------------------------------------------------
; Externa 0
;------------------------------------------------------------------------------
_ext0:      reti

;------------------------------------------------------------------------------
; Timer 0
;------------------------------------------------------------------------------
_tmr0:      jb      f0, high_done

low_done:   setb    f0
            setb    SERVO
            acall   ReloadHT
            ;mov     th0, #high -1502
            ;mov     tl0, #low -1502
            ajmp    _exit

high_done:  clr     f0
            clr     SERVO
            acall   ReloadLT
            ;mov     th0, #high -18498
            ;mov     tl0, #low -18498

_exit:      clr     tf0
            reti

;------------------------------------------------------------------------------
; Externa 1
;------------------------------------------------------------------------------
_ext1:      reti

;------------------------------------------------------------------------------
; Timer 1
;------------------------------------------------------------------------------
_tmr1:      reti

;------------------------------------------------------------------------------
; Serial Port
;------------------------------------------------------------------------------
_serial:    reti

;------------------------------------------------------------------------------
; Timer 2
;------------------------------------------------------------------------------
_tmr2:      reti

;******************************************************************************
; SUB-ROTINAS
;******************************************************************************

;------------------------------------------------------------------------------
; ReloadHT
;------------------------------------------------------------------------------
ReloadHT:   mov     a, r7   ; carrega o valor do acumulador com o pwm desejado
            acall   LKHTHB 
            mov     th0, a

            mov     a, r7
            acall   LKHTLB
            mov     tl0, a

            ret

;------------------------------------------------------------------------------
; ReloadLT
;------------------------------------------------------------------------------
ReloadLT:   mov     a, r7
            acall   LKLTHB
            mov     th0, a

            mov     a, r7
            acall   LKLTLB
            mov     tl0, a

            ret

;------------------------------------------------------------------------------
; LKHTHB
;------------------------------------------------------------------------------
LKHTHB:     mov     dptr, #TH_HIGH 
            movc    a, @a+dptr

            ret

TH_HIGH:    db  0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh
            db  0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh
            db  0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh
            db  0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh
            db  0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh
            db  0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh
            db  0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh
            db  0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh
            db  0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh
            db  0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh
            db  0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0FAh,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h
            db  0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h
            db  0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h
            db  0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h
            db  0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h
            db  0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F9h,0F8h,0F8h,0F8h,0F8h,0F8h
            db  0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h
            db  0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h
            db  0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h
            db  0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h,0F8h

;------------------------------------------------------------------------------
; LKHTLB
;------------------------------------------------------------------------------
LKHTLB:     mov     dptr, #TH_LOW
            movc    a, @a+dptr

            ret

TH_LOW:     db  018h,014h,010h,00Ch,008h,004h,000h,0FDh,0F9h,0F5h,0F1h,0EDh,0E9h
            db  0E5h,0E1h,0DDh,0D9h,0D5h,0D1h,0CDh,0CAh,0C6h,0C2h,0BEh,0BAh,0B6h
            db  0B2h,0AEh,0AAh,0A6h,0A2h,09Eh,09Bh,097h,093h,08Fh,08Bh,087h,083h
            db  07Fh,07Bh,077h,073h,06Fh,06Bh,068h,064h,060h,05Ch,058h,054h,050h
            db  04Ch,048h,044h,040h,03Ch,038h,035h,031h,02Dh,029h,025h,021h,01Dh
            db  019h,015h,011h,00Dh,009h,005h,002h,0FEh,0FAh,0F6h,0F2h,0EEh,0EAh
            db  0E6h,0E2h,0DEh,0DAh,0D6h,0D3h,0CFh,0CBh,0C7h,0C3h,0BFh,0BBh,0B7h
            db  0B3h,0AFh,0ABh,0A7h,0A3h,0A0h,09Ch,098h,094h,090h,08Ch,088h,084h
            db  080h,07Ch,078h,074h,070h,06Dh,069h,065h,061h,05Dh,059h,055h,051h
            db  04Dh,049h,045h,041h,03Dh,03Ah,036h,032h,02Eh,02Ah,026h,022h,01Eh
            db  01Ah,016h,012h,00Eh,00Bh,007h,003h,0FFh,0FBh,0F7h,0F3h,0EFh,0EBh
            db  0E7h,0E3h,0DFh,0DBh,0D8h,0D4h,0D0h,0CCh,0C8h,0C4h,0C0h,0BCh,0B8h
            db  0B4h,0B0h,0ACh,0A8h,0A5h,0A1h,09Dh,099h,095h,091h,08Dh,089h,085h
            db  081h,07Dh,079h,075h,072h,06Eh,06Ah,066h,062h,05Eh,05Ah,056h,052h
            db  04Eh,04Ah,046h,043h,03Fh,03Bh,037h,033h,02Fh,02Bh,027h,023h,01Fh
            db  01Bh,017h,013h,010h,00Ch,008h,004h,000h,0FCh,0F8h,0F4h,0F0h,0ECh
            db  0E8h,0E4h,0E0h,0DDh,0D9h,0D5h,0D1h,0CDh,0C9h,0C5h,0C1h,0BDh,0B9h
            db  0B5h,0B1h,0ADh,0AAh,0A6h,0A2h,09Eh,09Ah,096h,092h,08Eh,08Ah,086h
            db  082h,07Eh,07Bh,077h,073h,06Fh,06Bh,067h,063h,05Fh,05Bh,057h,053h
            db  04Fh,04Bh,048h,044h,040h,03Ch,038h,034h,030h

;------------------------------------------------------------------------------
; LKLTHB
;------------------------------------------------------------------------------
LKLTHB:     mov     dptr, #TL_HIGH
            movc    a, @a+dptr

            ret

TL_HIGH:    db  0B5h,0B5h,0B5h,0B5h,0B5h,0B5h,0B5h,0B5h,0B5h,0B5h,0B5h,0B5h,0B5h
            db  0B5h,0B5h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h
            db  0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h
            db  0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h
            db  0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h
            db  0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h,0B6h
            db  0B6h,0B6h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h
            db  0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h
            db  0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h
            db  0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h
            db  0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h,0B7h
            db  0B7h,0B7h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h
            db  0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h
            db  0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h
            db  0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h
            db  0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h,0B8h
            db  0B8h,0B8h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h
            db  0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h
            db  0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h
            db  0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h,0B9h
;------------------------------------------------------------------------------
; LKLTLB
;------------------------------------------------------------------------------
LKLTLB:     mov     dptr, #TL_LOW
            movc    a, @a+dptr

            ret

TL_LOW:     db  0C8h,0CCh,0D0h,0D4h,0D8h,0DCh,0E0h,0E3h,0E7h,0EBh,0EFh,0F3h,0F7h
            db  0FBh,0FFh,003h,007h,00Bh,00Fh,013h,016h,01Ah,01Eh,022h,026h,02Ah
            db  02Eh,032h,036h,03Ah,03Eh,042h,045h,049h,04Dh,051h,055h,059h,05Dh
            db  061h,065h,069h,06Dh,071h,075h,078h,07Ch,080h,084h,088h,08Ch,090h
            db  094h,098h,09Ch,0A0h,0A4h,0A8h,0ABh,0AFh,0B3h,0B7h,0BBh,0BFh,0C3h
            db  0C7h,0CBh,0CFh,0D3h,0D7h,0DBh,0DEh,0E2h,0E6h,0EAh,0EEh,0F2h,0F6h
            db  0FAh,0FEh,002h,006h,00Ah,00Dh,011h,015h,019h,01Dh,021h,025h,029h
            db  02Dh,031h,035h,039h,03Dh,040h,044h,048h,04Ch,050h,054h,058h,05Ch
            db  060h,064h,068h,06Ch,070h,073h,077h,07Bh,07Fh,083h,087h,08Bh,08Fh
            db  093h,097h,09Bh,09Fh,0A3h,0A6h,0AAh,0AEh,0B2h,0B6h,0BAh,0BEh,0C2h
            db  0C6h,0CAh,0CEh,0D2h,0D5h,0D9h,0DDh,0E1h,0E5h,0E9h,0EDh,0F1h,0F5h
            db  0F9h,0FDh,001h,005h,008h,00Ch,010h,014h,018h,01Ch,020h,024h,028h
            db  02Ch,030h,034h,038h,03Bh,03Fh,043h,047h,04Bh,04Fh,053h,057h,05Bh
            db  05Fh,063h,067h,06Bh,06Eh,072h,076h,07Ah,07Eh,082h,086h,08Ah,08Eh
            db  092h,096h,09Ah,09Dh,0A1h,0A5h,0A9h,0ADh,0B1h,0B5h,0B9h,0BDh,0C1h
            db  0C5h,0C9h,0CDh,0D0h,0D4h,0D8h,0DCh,0E0h,0E4h,0E8h,0ECh,0F0h,0F4h
            db  0F8h,0FCh,000h,003h,007h,00Bh,00Fh,013h,017h,01Bh,01Fh,023h,027h
            db  02Bh,02Fh,033h,036h,03Ah,03Eh,042h,046h,04Ah,04Eh,052h,056h,05Ah
            db  05Eh,062h,065h,069h,06Dh,071h,075h,079h,07Dh,081h,085h,089h,08Dh
            db  091h,095h,098h,09Ch,0A0h,0A4h,0A8h,0ACh,0B0h

;******************************************************************************
            end
;******************************************************************************
