;
; Plotting in tilemap mode
;


IF FORzxn
	SECTION	code_graphics
	PUBLIC	plot_MODE64


plot_MODE64:
	defc    NEEDplot = 1
	INCLUDE	"target/zxn/graphics/pixel_MODE64.inc"
ENDIF