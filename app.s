	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 32

	.equ FLOOR_WIDTH, 640
	.equ FLOOR_HEIGH, 300

	.equ GPIO_BASE,    0x3f200000
	.equ GPIO_GPFSEL0, 0x00
	.equ GPIO_GPLEV0,  0x34

	.globl main

main:
	// x0 contiene la direccion base del framebuffer
	mov x20, x0 // Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------
    //#75DCFF
	movz x10, 0x75, lsl 16
	movk x10, 0xDCFF, lsl 00

	mov x11, 640 // mov x11 nos va a permitir utilizar el registo x11 para guardar 640, constante para calcular direccion de pixel.
fondopantalla:    
	mov x3,2

loop2:
	mov x2, SCREEN_HEIGH         // Y Size
	sub x3,x3,1

loop1:
	mov x1, SCREEN_WIDTH         // X Size
loop0:
	stur w10,[x0]  // w10, agarra 32bits (32 bits de argb) de su registro de 64 bits. Stur lo carga en la direccion guardada en el registro x0
	add x0,x0,4  // add x0,4 apunta hacia 4 bytes distancia de x0 (es decir, el proximo pixel)
	sub x1,x1,1   // disminuyo x1 en 1 (x1-1) ya que representa la cantidad de pixeles por pintar a lo ancho de la pantalla.
	cbnz x1,loop0  // cnbz comprueba que x1 =/ 0 y branchea a la linea llamada loop0. si es 0 skipea a la siguiente instruccion.
	sub x2,x2,2    // disminuye x2 en 1 (x2-1) y representa las filas por pintar
	cbnz x2,loop1 // cnbz comprueba que x2 =/ 0 y branchea a la linea llamada loop1. si es 0 skipea y concluye con el loop.
	
//eb7a21
    movz x10, 0xEB, lsl 16
    movk x10, 0x7A21, lsl 00
    cbnz x3,loop2
//rectangulong
//#69B81F

cactus_drawing:

	movz x10, 0x69, lsl 16
	movk x10, 0xB81F, lsl 00

	mov x12, 190 // y 
	mov x4, 80

base_rectangular:
    mul x0,x4,x11 //Calcula la posicion de memoria del pixel
	add x0,x0, 100
	lsl x0,x0,2
	add x0,x0,x20
	mov x13,50 //Anchen
loop4: 
     stur w10,[x0]
	 add x0,x0,4
	 sub x13,x13,1
	 cbnz x13, loop4
	 sub x12,x12,1
	 add x4,x4,1
	 cbnz x12, base_rectangular

brazoizq_cactus:

    movz x10, 0x69, lsl 16
	movk x10, 0xB81F, lsl 00
    
	mov x12, 100
	mov x4, 100

basebrazoizq:

    mul x0,x4,x11 //Calcula la posicion de memoria del pixel
	add x0,x0, 100 // Distribuye en el eje x el cactus
	lsl x0,x0,2
	add x0,x0,x20
	mov x13,100 //Anchen

loopbrazo:
    stur w10,[x0]
	 add x0,x0,4
	 sub x13,x13,1
	 cbnz x13, loopbrazo
	 sub x12,x12,1
	 add x4,x4,1
	 cbnz x12, basebrazoizq



cactus_drawing2:

	movz x10, 0x69, lsl 16
	movk x10, 0xB81F, lsl 00

	mov x12, 250 // modifica el ejey del cactus (en tamaño)
	mov x4, 95 // modifica el ejey del cactus (en posicion)

base_rectangular2:
    mul x0,x4,x11 //Calcula la posicion de memoria del pixel
	add x0,x0, 550 // Distribuye en el eje x el cactus
	lsl x0,x0,2
	add x0,x0,x20
	mov x13,60 //Anchen
loop5: 
     stur w10,[x0]
	 add x0,x0,4
	 sub x13,x13,1
	 cbnz x13, loop5
	 sub x12,x12,1
	 add x4,x4,1
	 cbnz x12, base_rectangular2



    // movz x10, 0xEB, lsl 16
   // movk x10, 0xA0A0, lsl 00



	// Ejemplo de uso de gpios
	mov x9, GPIO_BASE

	// Atención: se utilizan registros w porque la documentación de broadcom
	// indica que los registros que estamos leyendo y escribiendo son de 32 bits

	// Setea gpios 0 - 9 como lectura
	str wzr, [x9, GPIO_GPFSEL0]

	// Lee el estado de los GPIO 0 - 31
	ldr w10, [x9, GPIO_GPLEV0]

	// And bit a bit mantiene el resultado del bit 2 en w10 (notar 0b... es binario)
	// al inmediato se lo refiere como "máscara" en este caso:
	// - Al hacer AND revela el estado del bit 2
	// - Al hacer OR "setea" el bit 2 en 1
	// - Al hacer AND con el complemento "limpia" el bit 2 (setea el bit 2 en 0)
	and w11, w10, 0b00000010

	// si w11 es 0 entonces el GPIO 1 estaba liberado
	// de lo contrario será distinto de 0, (en este caso particular 2)
	// significando que el GPIO 1 fue presionado

	//---------------------------------------------------------------
	// Infinite Loop

InfLoop:
	b InfLoop
