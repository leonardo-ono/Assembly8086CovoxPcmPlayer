; hello! in this video, let's code a very simple
; COVOX PCM audio player using Assembly 8086
; It's very similar to the "Sound Blaster Direct Mode"

	org 100h

; 2) now, let's read the next sample and send it to the LPT1 port
;    I'm gonna use the register SI as index

	mov si, 0
next_sample:
	mov dx, 378h ; LPT1 port
	mov al, [music_data + si]
	out dx, al

; 3) ok, now let's add a delay to obtain
;    the correct sample rate

	mov cx, 300 ; <-- change this value according to the speed of your computer/emulator
delay:
	nop
	loop delay

; 4) now, let's move to the next sample and send it again until we reach the end of audio data

	inc si
	cmp si, [music_length]
	jbe next_sample

; 5) return to DOS

	mov ax, 4c00h
	int 21h



; and that's it! let's see if it works...



; 1) so first, let's include the RAW PCM audio file
;    and inform the file size

;    In this example, i'm using 
;    unsigned PCM 8-bits mono 5KHz

music_length dw 62348
music_data:
	incbin "scc96inv.raw"