#include "listas.h"

// Definiciones de las funciones implementadas en assembler

extern "C"{
	extern void _asm_goLeft(Zipper *);
	extern void _asm_goRight(Zipper *);
	extern void _asm_goUp(Zipper *,Section *);
	extern void _asm_goDown(Zipper *,Node *);
	extern void _asm_insertLeft(Zipper *,Arbol *);
	extern void _asm_insertRight(Zipper *,Arbol *);
	extern void _asm_insertDown(Zipper *,Arbol *,Path *);
	extern void _asm_change(Zipper *,Arbol *);
	extern void _asm_eliminar(Zipper *);
}

// Implementacion de primitivas en C++ por ahora.

void Zipper::goLeft(){
	cout << "goLeft()" << endl;
	_asm_goLeft(this);
}

void Zipper::goRight(){
	cout << "goRight()" << endl;
	_asm_goRight(this);
}

void Zipper::goUp(){
	cout << "goUp()" << endl;
	Section *s = new Section();
	_asm_goUp(this,s);
	/*if(loc->getPath()->esTop()){
		cout << "Error: goUp de Top" << endl;
	}
	else{
		Section *s = new Section();
		list<Arbol *> ls,rs;
		ls = loc->getPath()->getMenores();
		rs = loc->getPath()->getMayores();
		ls.reverse();
		rs.push_front(loc->getActual());
		ls.merge(rs);
		s->setSection(ls);
		loc->setActual(s);
		loc->setPath(loc->getPath()->getPath());
	}*/
}

void Zipper::goDown(){
	cout << "goDown()" << endl;
	Node *n = new Node();
	Top *t = new Top();
	n->setPath(t);
	_asm_goDown(this,n);	
	/*if(loc->getActual()->esItem()){
		cout << "Error: goDown de Item" << endl;
	}
	else{
		if(loc->getActual()->getSection().empty()){
			cout << "Error: goDown de Section vacia" << endl;
		}
		else{
			Path *p = new Node();
			p->setPath(loc->getPath());
			p->setMayores(loc->getActual()->getSection());
			loc->setActual(p->getMayores().front());
			p->getMayores().pop_front();
			loc->setPath(p);
		}
	}*/
}

void Zipper::insertLeft(Arbol *a){
	cout << "insertLeft()" << endl;
	_asm_insertLeft(this,a);
	/*if(loc->getPath()->esTop())
		cout << "Error: insertLeft de Top." << endl;
	else{
		list<Arbol *> laux = loc->getPath()->getMenores();
		laux.push_front(a);
		loc->getPath()->setMenores(laux);
	}*/
}

void Zipper::insertRight(Arbol *a){
	cout << "insertRight()" << endl;
	_asm_insertRight(this,a);
	/*if(loc->getPath()->esTop())
		cout << "Error: insertRight de Top." << endl;
	else{
		list<Arbol *> laux = loc->getPath()->getMayores();
		laux.push_front(a);
		loc->getPath()->setMayores(laux);
	}*/
}

void Zipper::insertDown(Arbol *a){ 
	cout << "insertDown()" << endl;
	Node *n = new Node();
	Top *t = new Top();
	n->setPath(t);
	_asm_insertDown(this,a,n);
	/*if(loc->getActual()->esItem())
		cout << "Error: insertDown en un item." << endl;
	else{
		Path *p = new Node();
		p->setPath(loc->getPath());
		p->setMayores(loc->getActual()->getSection());
		loc->setActual(a);
		loc->setPath(p);
	}*/
}

void Zipper::change(Arbol *a){
	cout << "change()" << endl;
	_asm_change(this,a);
}

void Zipper::eliminar(){
	cout << "eliminar()" << endl;
	if(loc->getPath()->esTop())
		cout << "Error: eliminar de Top" << endl;
	else{
		if(!loc->getPath()->getMayores().empty()){
			loc->setActual(loc->getPath()->getMayores().front());
			loc->getPath()->getMayores().pop_front();
		}
		else if(!loc->getPath()->getMenores().empty()){
			loc->setActual(loc->getPath()->getMenores().front());
			loc->getPath()->getMenores().pop_front();
		}
		else{
			Section *s = new Section();
			loc->setActual(s);
			loc->setPath(loc->getPath()->getPath());
		}
	}
}
