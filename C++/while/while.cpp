#include <iostream>
using namespace std; 

int main () {
    //determninamos las variables
    int numero =0;//igualamos a 0 para que sea su primera posicion. (0,1,2,3,...), podemos hacer lo mismo igualando a 1 

    //Pedimos al usuario un numero
    cout<< "ingrese un numero: "<<endl;
    cin>> numero;

    while (numero <= 10) //planeteamos la condicion (recordemos que este no es como un if, es un tipo de bucle)
    /*Hay que saber que el while analizara dato por dato hasta que non se cumpla, osea que con valores grandes como 100
    significa que analizara los 100 datos hasta que no se cumpla.*/
    {
        cout << "Numero invalido. Ingrese otro"<<endl;
        cin >> numero; //especificamos el valor de aumento
    }

    cout<< "numero valido. Feliz dia"<<endl;
    /*es importante poner lo que sucedera una vez no se cumpla esa condicion, asi no se hara un bucle infinito*/
    return 0;
}