#include "zipper.h"

using namespace std;

Zipper::Zipper(){
	//cout << "Zipper::Zipper()" << endl;
	loc = new Location();
}

Zipper::~Zipper(){
	//cout << "Zipper::~Zipper()" << endl;
	delete loc;
}

void Zipper::mostrar(){
	//cout << "Zipper::mostrar()" << endl;
	loc->mostrar();
	cout << endl;
}

Location *Zipper::getLocation(){
	//cout << "Zipper::getLocation()" << endl;
	return loc;
}

Location::Location(){
	//cout << "Location::Location()" << endl;
	actual = new Section();
	path = new Top();
}

Location::~Location(){
	//cout << "Location::~Location()" << endl;
	delete actual;
	delete path;
}

void Location::mostrar(){
	//cout << "Location::mostrar()" << endl;
    cout << "Loc ";
	actual->mostrar();
    path->mostrar();
}

Arbol *Location::getActual(){
	return actual;
}

void Location::setActual(Arbol *a){
	actual = a;
};

Path *Location::getPath(){
	//cout << "Location::getPath()" << endl;
	return path;
}

void Location::setPath(Path *p){
	//cout << "Location::setPath()" << endl;
	path = p;
}

Node::Node(){
	//cout << "Node::Node()" << endl;
	top = 0;
	path = NULL;
}

Node::~Node(){
	//cout << "Node::~Node()" << endl;
	delete path;
}

void Node::mostrar(){
	list<Arbol *>::iterator it;
	cout << "(Node ["; //Iterar sobre las listas
	for(it = menores.begin();it != menores.end();it++)
		//cout << " menor ";	
		(*it)->mostrar();
	cout << "] ";
	path->mostrar();
	cout << " [";
	for(it = mayores.begin();it != mayores.end();it++)
		(*it)->mostrar();
	cout << "])";
}
