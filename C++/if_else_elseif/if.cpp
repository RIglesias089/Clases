//incluimos las librerias
#include <iostream>
using namespace std;

//hacemos la entrada de datos
int main (){

    //planteamos las varibales a utilizar, aclarando que tipo de valor sean como, "int","bool","double","char".
    double numero;
    //mostramos el texto y pedimos el dato, para despues guardarlo en dicho prog
    cout << "Ingrese un numero: "<< endl;
    cin >> numero;
    //creamos la verificacion de ese numero con un if
    if (numero > 0)//planteamos la condicion que se debe cumplir para que suceda:
    {
        cout << "Tu numero es positivo."<< endl;
    } else{ //si no se cumple esa condicione entonces sucedera:
        cout<< "tu numero es negativo."<< endl;
    }
    
    return 0; //incluimos el fin de el programa
}