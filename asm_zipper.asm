;===============================================================================
; Funcion extra para escribir en pantalla un salto de linea
;-------------------------------------------------------------------------------

	extern	putchar	
_nlinea:
	pushf
	push		dword 10		; 10 == ASCII code for \n
	call		putchar
	pop			ecx
	popf
	ret

;===============================================================================
;============ LISTO! ===========================================================
;
; void Zipper::change(Arbol *a){
;	loc->setActual(a);
; }
; ------------------------------------------------------------------------------

segment .text
	global	_asm_change

_asm_change:
	enter	0,0
	pusha
	mov			eax,[ebp+8]		; eax = Zipper *this
	mov			edx,[ebp+12]	; edx = Arbol *actual
	mov			ecx,[eax]		; ecx = Location *loc
	mov			[ecx],edx		; actual = a
	popa
	leave
	ret



segment .data
	msg1	db	"Error: goLeft de Top",0
	msg2	db	"Error: menores es []",0
	
segment .text
	global	_asm_goLeft
			extern printf	
			extern PopFront
			extern PushFront
			extern Front
_asm_goLeft:
	enter		0,0
	pusha
	mov			eax,[ebp+8]		; eax = puntero this
	mov			ebx,[eax]		; ebx = puntero a location, offset 0
	mov			ecx,[ebx+4]		; ecx = puntero a path, offset +4
	mov			edx,[ecx+4]		; edx = valor top
	
	cmp			edx,1			; if(loc->getPath()->esTop()) then...
	je			_error1			; "Error: goLeft de Top"
									
	mov			ebx,[ecx+12]	; ebx = menores <- list<Arbol *>
	mov			edx,[ebx]		; edx = primer elemento
	cmp			edx,ebx			; if(loc->getPath->getMenores().empty()) then...
	je			_error2			; "Error: menores es []"

	mov			eax,[ebp+8]		; eax = puntero this
	mov			ebx,[eax]		; ebx = puntero a location
	mov			ecx,[ebx]		; ecx = puntero a arbol
	push		dword ecx		; guardo ecx en la pila
	mov			ecx,[ebx+4]		; ecx = puntero a path
	mov			edx,[ecx+20]	; edx = puntero a mayores
	mov			ebx,[edx]		; ebx = mayores
	pop			dword ecx		; ecx = puntero a arbol
	
	;-------------------------------------------------
	; Llamada a PushFront
	
	pushf
	push		dword ecx		; argumento Arbol *
	push		dword ebx		; argumento list<Arbol *>
	call		PushFront	
	pop			ecx
	pop			ecx
	popf

	mov			eax,[ebp+8]		; eax = puntero this
	mov			ebx,[eax]		; ebx = puntero a location
	mov			ecx,[ebx+4]		; ecx = puntero a path
	mov			edx,[ecx+12]	; edx = puntero a menores
	mov			ecx,[edx]		; ecx = menores

	;-------------------------------------------------
	; Llamada a Front para obtener un Arbol *

	pushf
	push		ecx
	call		Front			; retorna en eax ¿?
	pop			ecx
	popf

	mov			[ebx],eax		; [ebx] = arbol actual nuevo

	mov			eax,[ebp+8]		; eax = puntero this
	mov			ebx,[eax]		; ebx = puntero a location
	mov			ecx,[ebx+4]		; ecx = puntero a path
	mov			edx,[ecx+12]	; edx = puntero a menores
	mov			ecx,[edx]		; ecx = menores

	;-------------------------------------------------
	; Llamada a PopFront para manipular list<Arbol *>

	pushf
	push		dword ecx	
	call		PopFront
	pop			ecx
	popf

	;-------------------------------------------------

	popa						
	leave
	ret

_error1:
	pushf
	push	eax
	push    dword msg1		; "Error: goLeft de Top"
	call	printf
	pop		ecx
	pop		ecx
	popf
	call	_nlinea			; "\n"
	popa
	leave
	ret

_error2:
	pushf
	push	eax
	push    dword msg2		; "Error: menores es []"
	call	printf
	pop		ecx
	pop		ecx
	popf
	call	_nlinea			; "\n"
	popa
	leave
	ret


segment .data
	msg3	db	"Error: goRight de Top",0
	msg4	db	"Error: mayores es []",0
	
segment .text
	global	_asm_goRight
			extern printf	
			extern PopFront
			extern PushFront
			extern Front
			extern verArbol
_asm_goRight:
	enter		0,0
	pusha
	mov			eax,[ebp+8]		; eax = Zipper *this
	mov			ebx,[eax]		; ebx = Location *loc
	mov			ecx,[ebx+4]		; ecx = Path *path
	mov			edx,[ecx+4]		; edx = int top
	
	cmp			edx,1			; if(loc->getPath()->esTop()) then...
	je			_error3			; "Error: goRight de Top"						
			
	mov			edx,[ecx+20]	; edx = list<Arbol *> *mayores
	mov			ecx,[edx]		; ecx = mayores
	cmp			ecx,edx			; if(loc->getPath->getMayores().empty()) then...
	je			_error4			; "Error: mayores es []"


	
	mov			eax,[ebp+8]		; eax = Zipper *this	
	mov			ebx,[eax]		; ebx = Location *loc	
	mov			ecx,[ebx]		; ebx = Arbol *actual
	mov			edx,[ebx+4]		; edx = Path *path
	mov			ebx,[edx+12]	; ebx = list<Arbol *> *menores
	mov			edx,[ebx]		; edx = menores
		
	pushf
	push		dword ecx		; argumento Arbol *
	push		dword edx		; argumento list<Arbol *>
	call		PushFront	
	pop			dword edx
	pop			dword ecx
	popf

	;---------------------------------------------------------------------------
	; loc->setActual(laux.front())

	mov			eax,[ebp+8]		; eax = puntero this
	mov			ebx,[eax]		; ebx = puntero a location
	mov			ecx,[ebx+4]		; ecx = puntero a path
	mov			edx,[ecx+20]	; edx = list<Arbol *> *mayores
	mov			ecx,[edx]		; ecx = mayores

	pushf
	push		ecx
	call		Front			; eax = Arbol *
	pop			ecx
	popf
	
	;mov			[ebx],eax		; Arbol *actual = Arbol *Front(mayores)

	;---------------------------------------------------------------------------
	; Llamada a PopFront

	mov			eax,[ebp+8]		; eax = Zipper *this
	mov			ebx,[eax]		; ebx = Location *loc
	mov			ecx,[ebx+4]		; ecx = Path *path
	mov			edx,[ecx+20]	; edx = list<Arbol *> *mayores
	mov			ecx,[edx]		; ecx = mayores

	pushf
	push		ecx	
	call		PopFront
	pop			ecx
	popf

	popa						
	leave
	ret

_error3:
	pushf
	push	eax
	push    dword msg3		; "Error: goRight de Top"
	call	printf
	pop		ecx
	pop		ecx
	popf
	call	_nlinea			; "\n"
	popa
	leave
	ret

_error4:
	pushf
	push	eax
	push    dword msg4		; "Error: mayores es []"
	call	printf
	pop		ecx
	pop		ecx
	popf
	call	_nlinea			; "\n"
	popa
	leave
	ret



segment .data
	msg5		db	"Error: goUp de Top",0

segment .text
	global	_asm_goUp
			extern printf	
			extern PushFront
			extern Reverse
			extern Splice
			extern cambiarSec			
			extern verLista
			extern verPath
_asm_goUp:
	enter		0,0
	pusha
	
	;---------------------------------------------------------------------------
	; ¿es Top?

	mov			eax,[ebp+8]		; eax = Zipper *this
	mov			ebx,[eax]		; ebx = Location *loc
	mov			ecx,[ebx+4]		; ecx = Path *path
	mov			edx,[ecx+4]		; edx = bool top
		
	cmp			edx,1			; if(loc->getPath()->esTop()) then...
	je			_error5			; "Error: goUp de Top"	

	;---------------------------------------------------------------------------
	; Llamada a Reverse

	mov			ebx,[ecx+12]	; ebx = puntero a menores
	mov			ecx,[ebx]		; ecx = menores
	
	pushf
	push		dword ecx
	call		Reverse
	pop			ecx
	popf

	;---------------------------------------------------------------------------
	; Llamada a PushFront

	mov			eax,[ebp+8]		; eax = Zipper *this	
	mov			ebx,[eax]		; ebx = Location *loc
	mov			edx,[ebx]		; edx = Arbol *actual	
	mov			ecx,[ebx+4]		; ecx = Path *p 
	mov			ebx,[ecx+20]	; edx = list<Arbol *> *mayores
	mov			ecx,[ebx]		; ecx = mayores
			
	pushf
	push		dword edx		; Arbol *actual
	push		dword ecx		; list<Arbol *> ecx
	call		PushFront	
	pop			ecx
	pop			ecx
	popf

	;---------------------------------------------------------------------------
	; Llamada a Splice
	
	mov			eax,[ebp+8]		; eax = Zipper *this
	mov			ebx,[eax]		; ebx = Location *loc
	mov			ecx,[ebx+4]		; ecx = Path *path
	mov			edx,[ecx+12]	; edx = list<Arbol *> *menores
	mov			ebx,[edx]		; ebx = menores

	push		dword ebx		; guardo menores en la pila
	mov			eax,[ebp+8]		; eax = Zipper *this
	mov			ebx,[eax]		; ebx = Location *loc
	mov			ecx,[ebx+4]		; ecx = Path *path
	mov			edx,[ecx+20]	; edx = list<Arbol *> *mayores
	mov			ebx,[edx]		; ebx = mayores
	pop			dword ecx		; ecx = menores
		
	pushf
	push		ebx				; mayores
	push		ecx				; menores
	call		Splice	
	pop			ecx
	pop			edx		
	popf

	;---------------------------------------------------------------------------
	; Uso el Section *s que pase como argumento
	
	mov			eax,[ebp+12]	; eax = Section *s

	pushf
	push		dword ecx
	push		dword eax
	call		cambiarSec	
	pop			eax
	pop			ecx
	popf

	;---------------------------------------------------------------------------
	; loc->setActual(s) - Actualizo el arbol actual
	
	mov			ebx,[ebp+8]		; eax = puntero this
	mov			ecx,[ebx]		; ebx = puntero a Location
	mov			[ecx],eax		; actual = s
	
	;---------------------------------------------------------------------------
	; loc->setPath(p) - Actualizo el path

	mov			eax,[ebp+8]		; eax = puntero this
	mov			ebx,[eax]		; ebx = puntero a location
	mov			ecx,[ebx+4]		; ecx = puntero a path
	mov			edx,[ecx+8]		; ebx = puntero a path Up
	mov			[ebx+4],edx		; loc->setPath(edx); <- abuso de notacion! =P
	
	popa
	leave
	ret 
	
_error5:
	pushf
	push	eax
	push    dword msg5		; "Error: goUp de Top"
	call	printf
	pop		ecx
	pop		ecx
	popf
	call	_nlinea			; "\n"
	popa
	leave
	ret

segment .data
	msg6	db	"Error: goDown de Item",0
	msg7 	db	"Error: goDown de Section []",0
	
segment .text
	global	_asm_goDown
			extern printf	
			extern Front
			extern PushFront
			extern cambiarMay
			extern verArbol
_asm_goDown:
	enter		0,0			; Espacio para armar el Node
	pusha
	
	;---------------------------------------------------------------------------
	; ¿es Item?
	
	mov			eax,[ebp+8]		; eax = puntero this
	mov			ebx,[eax]		; ebx = puntero a location, offset 0
	mov			ecx,[ebx]		; ecx = puntero a actual, offset 0
	mov			edx,[ecx+4]		; edx = valor item
	
	cmp			edx,1			; if(loc->getActual()->esItem()) then...
	je			_error6			; "Error: goDown de Item"	

	;---------------------------------------------------------------------------
	; ¿es Section []?

	mov			eax,[ebp+8]		; eax = puntero this
	mov			ebx,[eax]		; ebx = puntero a location, offset 0
	mov			ecx,[ebx]		; ebx = puntero a actual, offset 0
	mov			edx,[ecx+8]		; edx = puntero a section, offset 0
	mov			ecx,[edx]		; ecx = section
	cmp			ecx,edx			; if(loc->getActua->getSection().empty()) then...
	je			_error7			; "Error: goDown de Section []"

	;---------------------------------------------------------------------------
	; Usando el Node 

	mov			eax,[ebp+8]				; eax = Zipper *this
	mov			ebx,[eax]				; ebx = Location *loc
	mov			ecx,[ebx+4]				; ecx = Path *path
	mov			edx,[ebp+12]			; edx = Node *n
	mov			[edx+8],ecx				; n->path = loc->path
	mov			[ebx+4],edx				; loc->path = n

	mov			edx,[ebx]				; edx = Arbol *actual
	mov			ecx,[edx+8]				; ecx = list<Arbol *> *section
	mov			edx,[ecx]	
	mov			ebx,[eax]				; ebx = Location *loc
	mov			ecx,[ebx+4]				; ecx = Path *path
	mov			ebx,[edx]				; edx = section		
	
	pushf
	push		dword ebx
	push		dword ecx
	call		cambiarMay
	pop			ecx
	pop			ebx
	popf
	
	mov			eax,[ebp+8]		; eax = puntero this
	mov			ebx,[eax]		; ebx = puntero a location
	mov			ecx,[ebx+4]		; ecx = puntero a path
	mov			edx,[ecx+20]	; edx = puntero a mayores
	mov			ecx,[edx]		; ecx = mayores

	;-------------------------------------------------
	; Llamada a Front para obtener un Arbol *

	pushf
	push		ecx
	call		Front			; retorna en eax
	pop			ecx
	popf

	pushf
	push		eax
	call		verArbol			; retorna en eax
	pop			eax
	popf

	popa
	leave
	ret
	
	mov			[ebx],eax		; [ebx] = arbol actual nuevo
			
	mov			ebx,[ebp+8]				; ebx = puntero this
	mov			edx,[ebx]				; ecx = puntero location
	mov			[edx],eax				; loc->setActual(eax)	
	
	;---------------------------------------------------------------------------
	; Llamada a PopFront

	mov			eax,[ebp+8]				; eax = Zipper *this
	mov			ebx,[eax]				; ebx = Location *loc
	mov			ecx,[ebx+4]				; ecx = Path *path
	mov			edx,[ecx+20]			; edx = list<Arbol *> mayores
	mov			ecx,[edx]
	
	pushf
	push		dword ecx
	call		PopFront
	pop			ecx
	popf

	popa
	leave
	ret

_error6:
	pushf
	push	eax
	push    dword msg6		; "Error: goDown de Item"
	call	printf
	pop		ecx
	pop		ecx
	popf
	call	_nlinea			; "\n"
	popa
	leave
	ret

_error7:
	pushf
	push	eax
	push    dword msg7		; "Error: goDown de Section []"
	call	printf
	pop		ecx
	pop		ecx
	popf
	call	_nlinea			; "\n"
	popa
	leave
	ret


segment	.data
	msg8	db	"Error: insertDown de Item",0
	fint	db	"%d",0
segment	.text
	global	_asm_insertDown
			extern printf, cambiarMay
			extern verPath, verLista
			
_asm_insertDown:
	enter		0,0
	pusha
	
	;---------------------------------------------------------------------------
	; if(loc->getActual()->esItem()) ...
	
	mov			eax,[ebp+8]		; eax = Zipper *this
	mov			ebx,[eax]		; ebx = Location *loc
	mov			ecx,[ebx]		; ecx = Arbol *actual
	mov			edx,[ecx+4]		; edx = int item
	
	cmp			dword edx,1		; if(loc->getActual()->esItem()) ...
	je			_error8

	;---------------------------------------------------------------------------
	; n->setPath(loc->getPath());

	mov			ecx,[ebx+4]			; ecx = Path *path
	mov			edx,[ebp+16]		; edx = Node *n
	mov			[edx+8],ecx			; n->setPath(loc->getPath())
	
	;---------------------------------------------------------------------------
	; loc->setPath(n);

	mov			[ebx+4],edx			; loc->setPath(n)

	;---------------------------------------------------------------------------
	; loc->getPath()->setMayores(loc->getActual()->getSection())
	
	mov			ecx,[ebx]			; ecx = Arbol *actual
	mov			edx,[ecx+8]			; edx = list<Arbol *> *section
	mov			ecx,[edx]			; ecx = section		
	mov			edx,[ebx+4]			; ecx = Path *path
	
	pushf
	push		dword ecx
	push		dword edx
	call		cambiarMay
	pop			dword edx
	pop			dword ecx
	popf

	;---------------------------------------------------------------------------
	; loc->setActual(a);

	mov			ecx,[ebp+12]		; ecx = Arbol *a
	mov			[ebx],ecx			; loc->setActual(a)
	
	popa
	leave
	ret

_error8:
	pushf
	push	eax
	push    dword msg8		; "Error: insertDown de Item"
	call	printf
	pop		ecx
	pop		ecx
	popf
	call	_nlinea			; "\n"
	popa
	leave
	ret
	


segment	.data
	msg9	db	"Error: insertRight de Top",0

segment	.text
	global	_asm_insertRight
			extern printf			; C 
			extern PushFront 		; list
			
_asm_insertRight:
	enter		0,0
	pusha

	;---------------------------------------------------------------------------
	; if(loc->getPath()->esTop()) ...

	mov			eax,[ebp+8]			; eax = Zipper *this
	mov			ebx,[eax]			; ebx = Location *loc
	mov			ecx,[ebx+4]			; ecx = Path *path
	mov			edx,[ecx+4]			; edx = bool top
	cmp			edx,1				
	je			_error9

	;---------------------------------------------------------------------------
	; list<Arbol *> laux = loc->getPath()->getMayores();
	; laux.push_front(a);
	; loc->getPath()->setMayores(laux);
	
	mov			edx,[ecx+20]		; edx = list<Arbol *> *mayores
	mov			ecx,[edx]  			; ecx = mayores
	mov			edx,[ebp+12]		; edx = Arbol *a
	
	pushf
	push		dword edx
	push		dword ecx
	call		PushFront
	pop			dword ecx
	pop			dword edx
	popf
	
	popa
	leave
	ret

_error9:
	pushf



segment	.data
	msg10	db	"Error: insertLeft de Top",0

segment	.text
	global	_asm_insertLeft
			extern printf			; C 
			extern PushFront 		; list
			
_asm_insertLeft:
	enter		0,0
	pusha

	;---------------------------------------------------------------------------
	; if(loc->getPath()->esTop()) ...

	mov			eax,[ebp+8]			; eax = Zipper *this
	mov			ebx,[eax]			; ebx = Location *loc
	mov			ecx,[ebx+4]			; ecx = Path *path
	mov			edx,[ecx+4]			; edx = bool top
	cmp			edx,1				
	je			_error10


	
	mov			edx,[ecx+12]		; edx = list<Arbol *> *menores
	mov			ecx,[edx]  			; ecx = menores
	mov			edx,[ebp+12]		; edx = Arbol *a
	
	pushf
	push		dword edx
	push		dword ecx
	call		PushFront
	pop			dword ecx
	pop			dword edx
	popf
	
	popa
	leave
	ret

_error10:
	pushf
	push		eax
	push    	dword msg10		; "Error: insertLeft de Top"
	call		printf
	pop			ecx
	pop			ecx
	popf
	call		_nlinea			; "\n"
	popa
	leave
	ret



