;
; trafficlights.asm
;

start:
ldi R24, 0b01111000        
out ddrd, R24    

ldi R24, 0b01000000 ; Start green.
out portd, R24
 
end: ; Wait for button press
sbis pinc, 3
jmp button2 ; Button 2 is the pedestrian button.

sbis pinc, 2
jmp button1

rjmp end

button2:
ldi R24, 0b00100000 ; Change to Amber
out portd, R24
call delay ; Two delays on Amber to prepare traffic for change.
call delay

ldi R24, 0b0010000
out portd, R24 ; Change to red.

call delay 
call delay ; Long delay of 4s
call delay
call delay

ldi R24, 0b0110000 
out portd, R24
call delay ; Single delay on Amber and Red to prepare traffic for change.

ldi R24, 0b0100000 ; Revert to green.
out portd, R24

ret

button1: ; Test the lights, useful for traffic maintainence.
ldi R24, 0b01111000
out portd, R24

call delay
call delay ; Three delays, 3 seconds.
call delay

ldi R24, 0b00000000
out portd, R24

ret

delay: ; 1 second
    ldi  r18, 41
    ldi  r19, 150
    ldi  r20, 128
L1: dec  r20 ; Delay loop
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
ret
