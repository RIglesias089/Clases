#include<iostream>
using namespace std;

/*El usuario debe elegir una opción (1, 2 o 3).
Si elige 1, el programa dice "¡Hola, usuario!".
Si elige 2, el programa muestra un número favorito (por ejemplo: 42).
Si elige 3, el programa muestra "Adiós." y termina.
Si elige otra cosa, muestra "Opción inválida" y vuelve a mostrar el menú.

El do hile es muy curioso porque eecutamos un solo codigo en do y ella sola cumplira la funcion de regresarnos en el caso de que
sea un menu de opcion.
*/
int main (){
    //planteamos las variables
    int opcion;
    //Mostramos el menu y pedimos una opcion al usuario.
    do //En el do mostraremos todo el codigo que queeremos repetir hasta que el usuario elija salir.
    { 
        cout << "1.Saludar.\n";
        cout << "2.Mostrar un numero favorito.\n";
        cout << "3.Salir.\n";
        cout << "Elige una opcion: \n";
        cin>> opcion;

        switch (opcion)
        {
        case 1:
            cout << "¡Hola, usuario!" << endl;
            break;
        case 2:
            cout << "Mi numero favorito es: 42" << endl;
            break;
        case 3:
            cout << "Adiós." << endl;
            break;
        default:
            cout << "Opción inválida. Por favor, elige una opción válida." << endl;
            break;
        }
        
    } while (opcion != 3); //En el while plantearemos que se repetira hasta que el usuario elija la opcion 3.
    return 0;
}