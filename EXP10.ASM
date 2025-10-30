.model small
.stack 100h
.data
.code
start:
mov ax, @data
mov ds, ax

; Generate a beep sound at ~1kHz frequency for 500ms
call beep_1000hz_500ms

; Wait for a key press before exit
mov ah, 00h
int 16h

; Exit program
mov ah, 4Ch
int 21h

; ----------------------------------------
; beep_1000hz_500ms: Beep at ~1kHz for 500ms
; ----------------------------------------
beep_1000hz_500ms proc
; Calculate divisor for 1kHz
; Divisor = 1193180 / frequency
; 1193180 / 1000 = 1193 approx

mov bx, 1193 ; Divisor for 1kHz

; Program PIT Channel 2:
mov al, 0B6h ; Command byte: channel 2, lobyte/hibyte, mode 3 (square wave)
out 43h, al

; Send low byte of divisor
mov al, bl
out 42h, al

; Send high byte of divisor
mov al, bh
out 42h, al

; Enable speaker by setting bits 0 and 1 of port 61h
in al, 61h
or al, 03h ; Set bits 0 and 1
out 61h, al

; Delay ~500ms (simple loop)
mov cx, 5000
delay_loop:
push cx
mov cx, 65535
inner_delay:
loop inner_delay
pop cx
loop delay_loop

; Disable speaker (clear bits 0 and 1)
in al, 61h
and al, 0FCh
out 61h, al

ret
beep_1000hz_500ms endp

end start