#include <iostream>
using namespace std;


int main (){
    //Declaramos la variable de temperatura a evaluar
    int temperatura;
    cout << "porfavor dijite la temperatura en grados Celsius: "<<endl;
    cin >> temperatura;

    //Verificamos y mostramos un mensaje dependiendo la temperatura dada
    if (temperatura < 15)
    {
        cout << "Esta haciendo frio";
    }else if (temperatura == 15 || temperatura <=25)
    {
        cout<< "el agua esta templada o normal."<<endl;
    }else if (temperatura >25)
    {
        cout<< "El agua esta caliente";
    }else{
        cout<< "temperatura no valida."<<endl;
    }
    return 0;
}