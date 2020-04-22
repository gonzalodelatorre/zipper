#include "zipper.h"

extern "C"{
	Arbol *Front(list<Arbol *>);
	void PushFront(list<Arbol *>,Arbol *);
	void PopFront(list<Arbol *>);
	void Reverse(list<Arbol *>);
    void Splice(list<Arbol *>,list<Arbol *>);
	void verLista(list<Arbol *>);
	void verArbol(Arbol *);
	void verPath(Path *);
	
	void cambiarSec(Section *,list<Arbol *>);
	void cambiarMay(Path *, list<Arbol *>);
}
