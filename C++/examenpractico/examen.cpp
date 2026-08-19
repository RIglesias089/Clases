#include <iostream> 
using namespace std;

//Función para calcular el descuento de AFP según la ganancia
double calculateAFP(double ganancia) { 
    if (ganancia <= 500){
        return ganancia * 0.05; // Si la ganancia es menor o igual a 500
    } else if (ganancia > 500 && ganancia <= 1000){
        return ganancia * 0.07; // Si la ganancia es mayor a 500 y menor o igual a 1000
    } else if (ganancia > 1000){
        return ganancia * 0.09; // Si la ganancia es mayor a 1000
    } else {
        cout << "Numero no valido, porfavor ingrese un numero mayor a 0" << endl;
        return 0;
    }
}

//Función para calcular el impuesto según la ganancia
double calculateTax(double ganancia){ 
    if (ganancia <= 500) {
        return ganancia * 0.01; // Si la ganancia es menor o igual a 500
    } else if (ganancia > 500  && ganancia <= 1000) { 
        return ganancia * 0.12; // Si la ganancia está entre 500 y 1000
    } else if (ganancia > 1000){
        return ganancia * 0.15; // Si la ganancia es mayor a 1000
    } else {
    }
}

//Función para obtener la factura de la luz
double getElectricityBill(double facturaL1){ 
    cout << "Ingrese el monto de la factura de luz: ";
    cin >> facturaL1;
    if (facturaL1 > 0)
    {
        return facturaL1;
    }else
    {
    } 
    while (facturaL1 <= 0) 
    {
        cout << "Numero no valido, porfavor ingrese un numero mayor a 0" << endl;
        cout << "Ingrese el monto de la factura de luz: ";
        cin >> facturaL1;
    }
    
}

//Función para obtener la factura de agua
double getWaterBill(double facturaA1){
    cout << "Ingrese el monto de la factura de agua: ";
    cin >> facturaA1;
    if (facturaA1 > 0)
    {
        return facturaA1;
    }else
    {
    }
    while (facturaA1 <= 0) 
    {
        cout << "Numero no valido, porfavor ingrese un numero mayor a 0" << endl;
        cout << "Ingrese el monto de la factura de agua: ";
        cin >> facturaA1;
    }  
}

//Función para obtener la factura de internet
double getInternetBill(double facturaI1){
    cout << "Ingrese el monto de la factura de internet: ";
    cin >> facturaI1;
    if (facturaI1 > 0)
    {
        return facturaI1;
    }else
    {
    }
    while (facturaI1 <= 0) 
    {
        cout << "Numero no valido, porfavor ingrese un numero mayor a 0" << endl;
        cout << "Ingrese el monto de la factura de internet: ";
        cin >> facturaI1;
    }  
}

//Función para obtener la factura de gas (nombre corregido para evitar redefinición)
double getGasBill(double facturaG1){
    cout << "Ingrese el monto de la factura de gas: ";
    cin >> facturaG1;
    if (facturaG1 > 0)
    {
        return facturaG1;
    }else
    {
    }
    while (facturaG1 <= 0) 
    {
        cout << "Numero no valido, porfavor ingrese un numero mayor a 0" << endl;
        cout << "Ingrese el monto de la factura de gas: ";
        cin >> facturaG1;
    }
}

//Funcion para verificar si los gastos son mayores, menores o iguales al ingreso de la la ganancia
bool areExpensesGreaterThanNetIncome(double totalgaanancia, double totalgastos) {
    if (totalgastos > totalgaanancia) {
        cout << "Los gastos son mayores que los ingresos." << endl;
        return true; // Los gastos son mayores que los ingresos
    } else if (totalgastos < totalgaanancia) {
        cout << "Los gastos son menores que los ingresos." << endl;
        return false; // Los gastos son menores que los ingresos
    } else {
        cout << "Los gastos son iguales a los ingresos." << endl;
        return false; // Los gastos son iguales a los ingresos
    }
}


int main (){
    // Declaramos las variables
    double ganancia, facturaL, facturaLI, facturaA, facturaAI, facturaI, facturaII, facturaG, facturaGI, descuentoAFP, descuentoRenta, gastosT;
    bool result;
    // Pedimos todos los datos necesarios al usuario para darle los cálculos ya hechos
    cout << "----Bienvenido a nuestra calculadora de AFP y sus respectivos descuentos y monto de renta----" << endl;
    cout << "porfavor ingrese su sueldo o ganancia: " << endl;
    cin >> ganancia;

    facturaLI = getElectricityBill(facturaL); // Llamamos a la función de la factura de luz y guardamos el valor en facturaLI
    facturaAI = getWaterBill(facturaA); // Llamamos a la función de la factura de agua y guardamos el valor en facturaAI
    facturaII = getInternetBill(facturaI); // Llamamos a la función de la factura de internet y guardamos el valor en facturaII
    facturaGI = getGasBill(facturaG); // Llamamos a la función de la factura de gas y guardamos el valor en facturaGI

    cout << "Muchas gracias por los datos ahora le presentamos su descuento de AFP y el monto de renta" << endl;

    // Igualamos los datos de las funciones a variables en el main para utilizarlas 
    descuentoAFP = calculateAFP(ganancia); // Llamamos a la función de calcular AFP y guardamos el valor en descuentoAFP
    descuentoRenta = calculateTax(ganancia); // Llamamos a la función y guardamos en el descuento de renta

    //vemos el total de gastos
    gastosT = facturaLI + facturaAI + facturaII + facturaGI; // Sumamos todas las facturas para obtener el total de gastos
    // Mostramos los resultados al usuario
    cout << "Su descuento de AFP es: " << descuentoAFP << endl;
    cout << "Su descuento de renta es: " << descuentoRenta << endl;
    cout << "Sus facturas son: " << endl;
    cout << "Factura de luz: " << facturaLI << endl;
    cout << "Factura de agua: " << facturaAI << endl;
    cout << "Factura de internet: " << facturaII << endl;
    cout << "Factura de gas: " << facturaGI << endl;
    cout << "----compararemos sus gastos con su ingreso----"<<endl;
    cout << "Sus gastos totales son: " << gastosT << endl;
    //mandamos a llamar la función para comparar los gastos con la ganancia
    result = areExpensesGreaterThanNetIncome(ganancia, gastosT); // Llamamos a la función para comparar gastos e ingresos
    if (result) {
        cout << "Debe reducir sus gastos." << endl;
    } else {
        cout << "Sus gastos están dentro de su presupuesto." << endl;
    }
    return 0;
}