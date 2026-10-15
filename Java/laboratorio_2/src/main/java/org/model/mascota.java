package org.model;

//La clase abstracta es como una plantilla, para representar cualquier tipo de objeto, basados en
//este contexto, para cualquier tipo de mascotas.
// 1. No se puede instanciar directamente (está prohibido hacer "new mascota(...)").
// 2. Funciona como una base genérica para compartir atributos y métodos comunes mediante la herencia.
abstract class mascota {
    //El uso de protected permite hacer que el atributo sea accesible, en su clase o en su paquete, tambien por
    //sus clases hijas
    protected String nombre;
    //El consturctor de una clase abstracta, obliga a que cualquier mascota nazca bajo esta polantilla proveiendo un
    //nombre obligatoriamente. Se usa el "this.name" para desambiguar y guardar el valor recibido en la clase.

    mascota(String nombre) {
        this.nombre = nombre;
    }

    //A la hora de heredar una funcionalidad que se obtiene es que pueden imprimir un nombre en la consola
    //sin necesidad de rescribir el codigo entero

    public void mostrarNombre() {
        System.out.println(nombre);
    }

    // Metodo abstracto obligatorio: las clases hijas deberán implementar su propia versión de cómo hacen sonido
    public abstract void hacerSonido();
}

/**
 * Clase hija 'Perro' que hereda de la clase abstracta 'mascota' usando la palabra clave 'extends'.
 * Adquiere todas las características y comportamientos del padre.
 */


