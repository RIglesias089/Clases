package org;

//Importamos las carpetas
import org.model.mascotas;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
     mascotas perro = new mascotas("Spike", 3, true);

     //En esta parte llamamos los metodos de la clase que creamos
        perro.mostrarInfo();
    }
}
