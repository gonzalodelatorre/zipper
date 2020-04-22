#include "listas.h"
#include <stddef.h>

using namespace std;

class Zipper;

int main(){
	cout << "Zipper..." << endl;

	Zipper *z = new Zipper();
	z->mostrar();

	Section *s = new Section();
	z->insertDown(s);	
	z->mostrar();

	Item *a = new Item(1);
	z->insertRight(a);
	z->mostrar();	

	Item *b = new Item(2);
	z->insertLeft(b);
	z->mostrar();

	z->goLeft();
	z->mostrar();
	
	z->goRight();
	z->mostrar();
	


	delete z;

	return 0;
}
