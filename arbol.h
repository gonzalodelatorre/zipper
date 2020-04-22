#ifndef ARBOL_H_
#define ARBOL_H_

#include <iostream>
#include <list>

using namespace std;

class Arbol{
public:

	virtual void mostrar() = 0;
	virtual int esItem() = 0;
	virtual list<Arbol *> getSection() = 0;
	virtual void setSection(list<Arbol *>) = 0;
	virtual void addArbol(Arbol *) = 0;
};

class Item : public Arbol{
public:
	Item(int i){ valor = i;
				 item = 1; }			
	~Item(){}							
	void mostrar(); 					
	int esItem(){ return item; }		
	list<Arbol *> getSection(){ return (list<Arbol *>)NULL; }
	void setSection(list<Arbol *>){}
	void addArbol(Arbol *a){}

private:
	int item;
	int valor;	// offset 0
};

class Section : public Arbol{
public:
	Section(){ item = 0; }
	~Section(){}
	void mostrar();
	int esItem(){ return item; } 		
	list<Arbol *> getSection(){ return section; }
	void setSection(list<Arbol *> l){ section = l; }
	void addArbol(Arbol *a){ section.push_front(a); }
private:
	int item;
	list<Arbol *> section;	
};

#endif 
