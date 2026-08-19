#include <iostream>
#include <fstream>
using namespace std;

//planteamos primero la estructura para trabajar en un CRUD
struct Alumno
{
    int Id;
    string nombre;
    int edad;
    bool promedio;
};

Alumno alumnos[10]; //planteamos la cantidad de alumnos que hay en un arreglo
int Cantidad_alumnos = 0;

void agregar(){
    cout << "Ingrese el nombre de el estudiante: "<<endl;
    cin >> alumnos[Cantidad_alumnos].nombre;
    cout << "Ingrese el id de el estudiante: "<<endl;
    cin >> alumnos[Cantidad_alumnos].Id;
    cout << "Ingrese la edad de el estudiante: "<<endl;
    cin >> alumnos[Cantidad_alumnos].edad;
    cout << "Escriba el promedio de el estudiante: "<<endl;
    cin >> alumnos[Cantidad_alumnos].promedio;
    Cantidad_alumnos++;
}
void mostrar(){
    for (int i = 0; i < Cantidad_alumnos; i++)
    {
        cout << alumnos[i].Id;
        cout << alumnos[i].nombre;
        cout << alumnos[i].edad;
        cout << alumnos[i].promedio;
    }
    
}

void buscar(){
    int buscarId;
    bool encontrado = false;
    ifstream archivo("Estudiantes.txt");
    if (archivo.is_open())
    {
        cout << "Ingrese porfavor el ID de el estudiante: "<<endl;
        cin >> buscarId;
    }
    for (int i = 0; i < Cantidad_alumnos; i++)
    {
        if (alumnos[i].Id == buscarId) //escribimos el nomobre de la structura que planteamos y comparamos con el id para ver
        {
           cout << "Estudiante encontrado: "<< alumnos[i].Id<< "-"<< alumnos[i].nombre<< "-"<< alumnos [i].edad<< "-"<< alumnos[i].promedio;
           encontrado = true;
           break; 
        }
        
    }
    if (!encontrado)
    {
        cout << "estudiante no encontrado"<<endl;
    }archivo.close();
}

void eliminar(){
    int estudiante_eliminado;
    bool eliminado = false;
    cout << "ingrese el id de el estudiante a eliminar: "<<endl;
    cin >> estudiante_eliminado;

    for (int i = 0; i < Cantidad_alumnos; i++)
    {
        if (alumnos[i].Id == estudiante_eliminado)
        {
            for (int j = i = 0; i < Cantidad_alumnos -1; j++)
            {
                alumnos[j] = alumnos [j+1];
            }
            Cantidad_alumnos --;
            cout << "alumno eliminado correctamente"<<endl;
            eliminado = true;
        }
        
    }

    if (!eliminado)
    {
        cout << "Estudiante no encontrado"<<endl;
    }
    
    
    
    

}

void cargar(){

}

int main (){
    cargar();
    int opcion;
    do
    {
    cout<< "Porfavor elija una de las siguientes opciones:"<<endl;
    cout << "1.Agregar"<<endl;
    cout << "2.Mostrar"<<endl;
    cout << "3.Buscar"<<endl;
    cout << "4.Eliminar"<<endl;
    cout << "5.Salir"<<endl;
    cout << "ingrese la opcion a elegir: "<<endl;
    cin >> opcion;

    if (opcion == 1) agregar(); 
    else if (opcion == 2) mostrar();
    else if (opcion == 3) buscar();
    else if (opcion == 4) eliminar();
    break;
    } while (true);
    return 0;
}