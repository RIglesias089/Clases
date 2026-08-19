#include<iostream>
#include <string>
using namespace std;
/*Crea un programa que:
1.Pida al usuario que escriba una contraseña.
2.Mientras la contraseña no sea correcta, le pida que la vuelva a escribir.
3.Cuando la escriba bien, mostrar: "¡Acceso concedido!"*/
int main (){
    //determinamos las vairables, usamos string porque es una contraseña
    string contrasena;

    cout<< "ingrese la contrasena: "<<endl;
    cin >> contrasena;

    while (contrasena != "Juanito") //planteamos que sucedera si la contraseña es incorrecta
    {
        cout<< "Contraseña incorrecte, ingresela nuevamente."<<endl; 
        cin>> contrasena; //Pedimos que ingrse nuevamente la contraseña
    }
    
    cout<< "Acceso concedido"<<endl; //mostramos el mensaje cuandon la condicion se cumpla corrrectamente

    return 0;
}