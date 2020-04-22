#ifndef ZIPPER_H_
#define ZIPPER_H_

#include "arbol.h"



class Path{ 
public:
	virtual int esTop() = 0;	
	virtual void mostrar() = 0;
	virtual Path *getPath() = 0;
	virtual void setPath(Path *p) = 0;
	virtual list<Arbol *> getMenores() = 0;
	virtual list<Arbol *> getMayores() = 0;
	virtual void setMenores(list<Arbol *>) = 0;
	virtual void setMayores(list<Arbol *>) = 0;
};

class Top : public Path{
public:
	Top(){ top = 1; }
	~Top(){}
	int esTop(){ return top; }
	void mostrar(){ cout << " Top "; }
	void agregar(Arbol *){}
	Path *getPath(){ return NULL; }
	void setPath(Path *p){}
	list<Arbol *> getMenores(){ return (list<Arbol *>)NULL; }
	list<Arbol *> getMayores(){ return (list<Arbol *>)NULL; }
	void setMenores(list<Arbol *>){}
	void setMayores(list<Arbol *>){}
protected:
	int top;	
};

class Node : public Path{
public:
	Node();
	~Node();
	int esTop(){ return top; }
	void mostrar();
	Path *getPath(){ return path; }
	void setPath(Path *p){ path = p; }
	list<Arbol *> getMenores(){ return menores; }
	list<Arbol *> getMayores(){ return mayores; }
	void setMenores(list<Arbol *> l){ menores = l; }
	void setMayores(list<Arbol *> l){ mayores = l; }
protected:
	int top;					// offset 0
	Path *path;					// offset 8
    list<Arbol *> menores;		// offset 12
    list<Arbol *> mayores;		// offset 20
};

class Location{
public:
    Location();
    ~Location();
    void mostrar();
    Arbol *getActual();
    void setActual(Arbol *);
	Path *getPath();
    void setPath(Path *);
private:
    Arbol *actual;	// offset 0
    Path *path;		// offset 4
};

class Zipper{
public:
    Zipper();
    ~Zipper();
    void mostrar();
	Location *getLocation();
	void goLeft();
	void goRight();
	void goDown();
	void goUp();
	void insertRight(Arbol *);
	void insertLeft(Arbol *);
	void insertDown(Arbol *);
	void change(Arbol *);
	void eliminar();			//delete esta reservado
private:
	Location *loc;	
};

#endif 
