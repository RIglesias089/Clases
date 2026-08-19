#include <iostream>
using namespace std;

int main (){//escribimos la interfaz ya vista (ultima vez que recordaremos esccribirlo)
    //planteamos las variables a utilizar
    int opcion, dinero = 0,montodeposito, montoretiro = 0;

    //Enseñamos un menu a nuestro usuario 
    cout<< "Bienvenido a neustra empresa!.\n"<< endl;
    cout<< "porfavor elija una de nuestras opciones: \n"<< endl;
    cout<< "1. Insertar dinero.\n";
    cout<< "2. retirar dinero.\n";
    cout<< "3.Ver dinero en cuenta.\n";
    cout<< "4. exit.\n";
    cout<< "dijite su opcion: ";
    cin >> opcion; //Guardamos su decicion en una variable

    //Ahora llamamos esa variable, asegurarnos que sea entera pues el swich no funciona con variables que no sean enteras
    switch (opcion)
    {
    //Hacemos el caso en el que quiera ingresar dinero a la cuenta.
    case 1:
        cout<< "Porfavor dijite la cantidad a agregar: "<<endl;
        cin >> montodeposito;
        dinero += montodeposito;
        cout<< "El deposito se realizo correctamente."<<endl;
        break;
    //Planteamos que sucedera si quiere retirar dinero        
    case 2:
        cout<< "porfavor dijite la cantidad a retirar: "<< endl;
        cin>> montoretiro; 
        //Hacemos un if para que si el retiro es posible
        if (montoretiro <= dinero) { // Si el monto a retirar es menor o igual al disponible permitira el retiro, de lo contrario no
        dinero -= montoretiro;
        cout << "Retiro hecho correctamente." << endl;
        } else { //si es mayor a lo que esta en cuenta no permitira hacer el retiro de la cuenta.
        cout << "El fondo no es suficiente." << endl;
        }
        break;

    //Enseñamos al usuario su fondo
    case 3:
        cout<< "Su fondo es de : " << dinero<< endl;
        break;
    //Si quiere retirarse de el programa 
    case 4: 
        cout<< "Muchas gracias por preferirnos."<<endl;
        return 1;
        break;
    //Si digita una opcion o numero no valido.
    default:
        cout<< "Opcion no valida.";
        break;
    }
    return 0;
}