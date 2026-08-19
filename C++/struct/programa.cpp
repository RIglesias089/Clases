#include <iostream>
using namespace std;

float Cum(float arregloNota[], float arregloUV[]) {
    float CUM = 0;
    float sumaUV = 0;
    float sumaCUM = 0;
    for (int i = 0; i < 3; i++) {
        CUM += arregloNota[i] * arregloUV[i];
        sumaUV += arregloUV[i];
        sumaCUM += CUM;
    }
    return CUM;

}

struct Persona {
    string nombre;
    int edad;
    char genero;
    string carnet;
    float cum;

};
int main(){
    Persona persona1;
    int cantidad;
    float notas[3], uv[3];
    string materias;
    cout << "Ingrese la cantidad de personas: ";
    cin >> cantidad;
    for (int i = 0; i < cantidad; i++)
    {
        cout << "Ingrese los datos de la persona" << i + 1 << endl;
        cout << "Nombre: ";
        cin >> persona1.nombre;
        cout << "Edad: ";
        cin >> persona1.edad;
        cout << "Genero (M/F): ";
        cin >> persona1.genero;
        cout << "Carnet: ";
        cin >> persona1.carnet;
        cout << "------------------------" << endl;
    }
    cout << "-------------------Datos de las personas-------------------" << endl;
    for (int i = 0; i < cantidad; i++)
    {
        cout << "Datos de la persona " << i + 1 << endl;
        cout << "Nombre: " << persona1.nombre << endl;
        cout << "Edad: " << persona1.edad << endl;
        cout << "Genero: " << persona1.genero << endl;
        cout << "Carnet: " << persona1.carnet << endl;
        cout << "------------------------" << endl;
    }
    cout << "-------------------CUM de las materias-------------------" << endl;
    for (int i = 0; i < 3; i++)
    {
        cout << "Ingrese la materia " << i + 1 << ": ";
        cin >> materias;
        cout << "Ingrese la UV " << i + 1 << ": ";
        cin >> uv[i];
        cout << "Ingrese la nota " << i + 1 << ": ";
        cin >> notas[i];
        float cum = Cum(notas, uv);
        float totalUV = 0;
        for (int j = 0; j < 3; j++) {
            totalUV += uv[j];
        }   

        cout << "El CUM de " << materias << " es: " << cum << endl;
        cout << "------------------------" << endl;
        cout << "El total de UV es: " << totalUV << endl;
        cout << "El CUM total es: " << cum / totalUV << endl;
    }


    return 0;
}