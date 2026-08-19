#include <iostream>
using namespace std;

//planteamos las funciones encima de el int main, por cuestiones de orden dependiendo la situacion

float suma(float uno, float dos){
        float resultado = 0;
        resultado = uno + dos;

        return resultado;    
    }

float resta(float uno, float dos){
        float resultado = 0;
        resultado = uno - dos;

        return resultado;
}

float multiplicacion(float uno, float dos){
        float resultado = 0;
        resultado = uno * dos;

        return resultado;
}

float division (float uno, float dos){
        float resultado = 0;

        if(uno<dos || uno==0 || dos==0){
            resultado=1000;
        }else{
            resultado = uno / dos;
        }

        return resultado;
}

int main(){ //declaramos el cuerpo, las variabnles y desarrrollamios en el main
    float numero1, numero2, numero3=7, numero4=56, sumatoria=0, sumatoria2=0, resultadoResta=0, resultadoMultiplicacion=0, resultadoDivision=0;
    int opcion;
    cout<<"Operaciones"<<endl;
    cout<<"Ingrese el primer numero"<<endl;
    cin>>numero1;

    cout<<"Ingrese el segundo numero"<<endl;
    cin>>numero2;
    
    //despues de pedir los numeros, planteamos las operaciones llamando las funciones y poniendo los parametros

    sumatoria = suma(numero1,numero2);
    sumatoria2 = suma(numero3, numero4);
    resultadoResta = resta(numero1, numero2);
    resultadoMultiplicacion = multiplicacion(numero1,numero2);
    resultadoDivision = division(numero1,numero2);

    //planteamos un menu y un swich para el usuario pueda elegir la operacion que desea realizar
    cout<< "Que operacion desea realizar?"<<endl;
    cout<<"1. Suma"<<endl;
    cout<<"2. Resta"<<endl;
    cout<<"3. Multiplicacion"<<endl;
    cout<<"4. Division"<<endl;
    cout << "Digite la opcion: "<<endl;
    cin >>opcion;

    switch(opcion){
        case 1:
            cout<<"La suma es: "<<sumatoria<<endl;
            break;
        case 2:
            cout<<"La resta es: "<<resultadoResta<<endl;
            break;
        case 3:
            cout<<"La multiplicacion es: "<<resultadoMultiplicacion<<endl;
            break;
        case 4:
        //planteamos una condicion en el caso que el usuario plantee una division que no se pueda realizar.
        if(resultadoDivision=5000){
        cout<<"La division no se puede"<<endl;
        }else{
        cout<<"Resultado de la division: "<<resultadoDivision<<endl;
        }
            break;
        default:
            cout<<"Opcion no valida"<<endl;
    }
    //planteamos una condicion en el caso que el usuario plantee una division que no se pueda realizar.
    

    return 0;
}