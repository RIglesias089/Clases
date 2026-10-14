package org.model;

public class mascotas {
    //lo primero que se define en una clase son sus atributos
    String nombre;
    int edad;
    boolean comiendo;

    //Creamos el constructor para inicializar el objeto
    public mascotas(String nombre, int edad, boolean comiendo) {
        this.nombre = nombre;
        this.edad = edad;
        this.comiendo = false; //por defecto que inicie en falso
    }

    //Luego de plantear sus atributos podemos plantear metodos que son como las acciones
    //que estos pueden hacer
    public void comiendo(){
        this.comiendo = true; //Esta linea lo que hace es que tenga un valor
        System.out.println("El animal esta comiendo");
    }

    public void hacerSonido(){
        System.out.println("miau!"); //Este metodo directamente nos devolvera un print en la consola
    }

    public void mostrarInfo(){
        System.out.println("Nombre: " + this.nombre);
        System.out.println("Edad: " + this.edad);
        System.out.println("Comiendo: " + this.comiendo);
    }
}
