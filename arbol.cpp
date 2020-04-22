#include "arbol.h"

using namespace std;

void Item::mostrar(){
	cout << "(Item " << valor << ")";
}

void Section::mostrar(){
	cout << "(Section [";
	list<Arbol *>::iterator it;
	for(it = section.begin();it != section.end();it++)
		(*it)->mostrar();
	cout << "])";
}
