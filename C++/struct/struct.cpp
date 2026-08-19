#include <iostream>
using namespace std;
/*El dia de hoy analizaremos como funcionan las estructuras en c++, cuando hablamos de una estructura o como se escribe en c++
"struct", plantearemos la estructura fuera del main, asi como las funcioens, planteamos el nombe que tendra esta , declaramos variables 
en la estructura etc.*/

struct Estudiante //Segun las reglas de las funciones y estructuras, el nombre debe ir en mayusculas.
{
    int edad;
    string nombre;
    string carnet;
    char genero; //recordemos que en los cahr, los datos van en comillas simples.
    string carrera;

}; //para cerrar las estructuras hay que escribir un punto y como al final.

int main (){

    //Ahora nos vamos al main y comenzamos a trabajar, como usaremos la estructura?, pues declaramos la estructura como una variable
    /*Estudiante estudiante1 = {20, "Juan", "00000725", 'M', "Informatica"}; //declaramos la estructura como una variable normal

    cout << "Ingrese su edad: "<<estudiante1.edad << endl; 
    cin >> estudiante1.edad; //para poder ingresar los datos de la estructura, usamos el cin y el cout,
    cout << "Ingrese su nombre: " << estudiante1.nombre << endl;
    cin >> estudiante1.nombre; //con el cin y cout, podemos ingresar los datos de la estructura
    cout << "Ingrese su carnet: " << estudiante1.carnet << endl;
    cin >> estudiante1.carnet; //con el cin y cout, podemos ingresar los datos de la estructura
    cout << "Ingrese su genero: " << estudiante1.genero << endl;
    cin >> estudiante1.genero; //con el cin y cout, podemos ingresar los datos de la estructura
    cout << "Ingrese su carrera: " << estudiante1.carrera << endl;
    cin >> estudiante1.carrera; //con el cin y cout, podemos ingresar los datos de la estructura

    cout << "Sus datos son: "<<endl;

    cout << "edad: " << estudiante1.edad<< endl; //para poder decidir el dato que mostrara pondremos 
    //el nombre de la variable y el nombre del dato que queremos mostrar con un punto de por medio
    cout << "nombre: " << estudiante1.nombre << endl;
    cout << "carnet: " << estudiante1.carnet << endl;
    cout << "genero: " << estudiante1.genero << endl;
    cout << "carrera: " << estudiante1.carrera << endl;*/

    int cantidad;
    cout<< "Ingrese la cantidad de estudiantes: ";
    cin >> cantidad;
    Estudiante estudiantes[cantidad]; //declaramos un arreglo de estructuras, donde la cantidad de estudiantes sera la cantidad que ingrese el usuario

    for (int i = 0; i < cantidad; i++) //usamos un for para recorrer el arreglo de estructuras
    {
        cout << "Ingrese los datos del estudiante " << i + 1 << endl;
        cout << "Edad: ";
        cin >> estudiantes[i].edad; //ingresamos los datos de cada estudiante
        cout << "Nombre: ";
        cin >> estudiantes[i].nombre;
        cout << "Carnet: ";
        cin >> estudiantes[i].carnet;
        cout << "Genero: ";
        cin >> estudiantes[i].genero;
        cout << "Carrera: ";
        cin >> estudiantes[i].carrera;
        cout << "------------------------"<<endl;
    }for (int i = 0; i < cantidad; i++)
    {
        cout << "-------------------Estudiante" << i+i<< "-------------------"<<endl;
        cout << "Datos del estudiante " << i + 1 << endl; //mostramos los datos de cada estudiante
        cout << "Edad: " << estudiantes[i].edad << endl;
        cout << "Nombre: " << estudiantes[i].nombre << endl;
        cout << "Carnet: " << estudiantes[i].carnet << endl;
        cout << "Genero: " << estudiantes[i].genero << endl;
        cout << "Carrera: " << estudiantes[i].carrera << endl;
        cout << "------------------------"<<endl;
    }

    return 0;
}