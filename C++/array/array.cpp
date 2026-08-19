#include <iostream>
using namespace std;

//El dia de hoy conoceremos como usar los array en c++, los array o arreglos nos ayudan a almacenar datos en posiciones
//gracias a esto podemos acceder a ellos de manera rapida, la manera de llamar el array es
//tipo de nombre [tamaño del array]

int main (){

    //veamos un ejemplo, primero decalramos un array de enteros
    int numeros [5]; //esto es "int" el tipo de dato, "numeros" el nombre y "[5]" el tamaño del array
    //ahora podemos asignar el valor a cada posicion del array
    numeros[0] = 1; //ponemos el nombre de el array, en corchetes la posicion y luego el valor que le asignamos
    numeros[1] = 2;
    numeros[2] = 3;
    numeros[3] = 4;
    numeros[4] = 5;
    
    //luego de haber planteado los datos de el array, podemos acceder a ellos de la proxima manera:
    /*cout << "El primer numero es :"<< numeros[0]<<endl; 
    cout << "El segundo numero es: "<< numeros[1]<<endl;
    cout << "El tercer numero es :"<< numeros[2]<<endl;
    cout << "El cuarto numero es :"<< numeros[3]<<endl;
    cout << "El quinto numero es :"<< numeros[4]<<endl;*/
    //mandamos a imprimir poniendo el nombre de el array y su posicion.
    // pero que sucede si quieremos pedir los numeros al usuario?
    cout << "porfavor ingrese 5 numeros: "<<endl;
    //planteamos el pedir los numeros en un bucle de for
    for (int i = 0; i < 5; i++)
    {
        cout << "Ingrese el numero: "<< i+1<<endl;
        cin >> numeros[i];
    }
    //pedimos el numero y lo guardamos en el array, pero porque usamios "i" en vez de un numero?
    //porque "i" se recorrera de 0 a 4, y cada vez que se repite el bucle "i" aumenta en 1, por lo tanto guardaremos cada nuemro en ese orden
    //ahora, como lo imprimimos?
    cout << "Los numeros que ingresaste son: "<<endl;
    for (int i = 1; i < 5; i++)
    {
        cout << "El numero en la posicion " << i << " es: " << numeros[i] << endl;
    }
    //usamos otro bucle for para poder mostrar el numero, usando el array siempre en la posicion "i", porque se recorre de 0 a 4

    //tambien podemos hacerlo de manera manual, pero mas largo pidiendo dato por dato y guardando posicion por posicion
    // asi: cout << "Ingrese el primer numero: "<<endl;
    //cin >> numeros[0];
    //asi susesivamente.

    return 0;
}