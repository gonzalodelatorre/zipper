#include "listas.h"

Arbol *Front(list<Arbol *> l){
	return l.front();
}

void PushFront(list<Arbol *> l,Arbol *a){
	l.push_front(a);
	cout << "PushFront" << endl;
	
}

void PopFront(list<Arbol *> l){
	l.pop_front();		
	cout << "PopFront" << endl;	
}

void Reverse(list<Arbol *> l){
	if(l.size()>1)
		l.reverse();
	cout << "Reverse" << endl;
}

void Splice(list<Arbol *> l,list<Arbol *> r){
	list<Arbol *>::iterator it;
	it = l.end();
	l.splice(it,r);		// merge hacia cosas raras!
}

void verLista(list<Arbol *> l){
	if(l.empty())
		cout << "La lista esta Vacia" << endl;
	else{
		list<Arbol *>::iterator it;
		for(it = l.begin();it != l.end();it++)
			(*it)->mostrar();
		cout << endl;
	}
}

void verArbol(Arbol *a){
	cout << "verArbol" << endl;	
	a->mostrar();
	cout << endl;
}

void verPath(Path *p){
	cout << "verPath = ";
	p->mostrar();
	cout << endl;
}

void cambiarSec(Section *s,list<Arbol *> l){
	s->setSection(l);
}

void cambiarMay(Path *p, list<Arbol *> l){
	cout << "cambiarMay" << endl;
	p->setMayores(l);
}
