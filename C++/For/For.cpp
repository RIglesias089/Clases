#include <iostream>
using namespace std;

//Ahora trabaaremos con lago muy usado para hacer bucles, los for.
int main (){
    //planteamos las variables
    int numero;
    //Pedimos el numero al usuario.
    cout<< "ingrese un numero: "<< endl;
    cin>> numero;

    //veamos como es la estructura de el for.
    for (int i = 0; i <= 10 ; i++) //la estruvura es: el tipo de dato y su inicio sea de 0 o 1; la condicion; el aumento o resta que tendra.
    {
    cout<< numero << "x"<< i<<"="<< numero * i<< endl; //mostramos o hacemos lo que realizara el buqle y llamamos sa variable que determinamos en el for
    }
    /*En este caso hicimos algo diferente, usamos una variable para poder guardar el numero que nos dio el usuario, determinamos
    naciendo desde el numero 0 hasta el 10 al ser lo que queremos realizar, planteamos el numero como entero y le decimos que cuando
    "i"m sea menor o igual a 10 veces entonces parara, y aumentara de 1 en 1 "i++", luego solo imprimimos y realizamos el orden en 
    el que realizara el proceso.*/

    return 0;
}