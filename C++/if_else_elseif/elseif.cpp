#include <iostream>
using namespace std;
//escribimos la interfaz ya vista
int main (){
    //usamos el codigo ya visto para if.
    //planteamos las varibales a utilizar, aclarando que tipo de valor sean como, "int","bool","double","char".
    double numero;
    //mostramos el texto y pedimos el dato, para despues guardarlo en dicho prog
    cout << "Ingrese un numero: "<< endl;
    cin >> numero;
    //creamos la verificacion de ese numero con un if, esta vez usando el elseif para poder dar una condicion especifica
    if (numero > 0)//planteamos la condicion que se debe cumplir para que suceda:
    {
        cout << "Tu numero es positivo."<< endl;
    }
    else if (numero < 0) //Planteamos que pasa si escribe numeros negativos con la funcion de else if
    {
        cout << "El numero es negativo."<< endl;
    }else{ //planteamos que sucedera si escribe numeros con otros simbolos o letras.
        cout<< "Numero o simbolo no valido."<< endl;
    }
    
    
    return 0; //incluimos el fin de el programa
}