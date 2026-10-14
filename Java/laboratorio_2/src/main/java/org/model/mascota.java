package org.model;

/**
 * Clase abstracta que sirve como plantilla o molde base para representar a cualquier tipo de mascota.
 * Características principales de una clase abstracta:
 * 1. No se puede instanciar directamente (está prohibido hacer "new mascota(...)").
 * 2. Funciona como una base genérica para compartir atributos y métodos comunes mediante la herencia.
 */
abstract class mascota {

    // El modificador 'protected' permite que este atributo sea accesible
    // únicamente dentro de la misma clase, en clases del mismo paquete y por sus clases hijas (herencia).
    protected String nombre;

    /**
     * Constructor de la clase abstracta 'mascota'.
     * Obliga a que cualquier mascota que nazca bajo este molde deba proveer un nombre obligatoriamente.
     * Se usa 'this.nombre' para desambiguar y guardar el valor recibido en el atributo de la clase.
     */
    public mascota(String nombre) {
        this.nombre = nombre;
    }

    /**
     * Metodo compartido.
     * Todas las clases hijas heredan esta funcionalidad automáticamente
     * y podrán imprimir su nombre en la consola sin necesidad de reescribir el código.
     */
    public void mostrarNombre() {
        System.out.println(nombre);
    }
}

/**
 * Clase hija 'Perro' que hereda de la clase abstracta 'mascota' usando la palabra clave 'extends'.
 * Adquiere todas las características y comportamientos del padre.
 */
class Perro extends mascota {

    /**
     * Constructor de la clase hija 'Perro'.
     * Como la clase padre exige un constructor que recibe un parámetro, la clase hija
     * está obligada a crear su propio constructor y usar 'super(nombre)' como primera línea
     * para entregarle el nombre al padre y que este lo configure.
     */
    public Perro(String nombre) {
        super(nombre); // Envía el nombre al constructor de la clase padre (mascota)
    }

    /**
     * Metodo exclusivo de la clase 'Perro'.
     * Define un comportamiento particular que le pertenece únicamente a los perros.
     */
    public void hacersonido() {
        System.out.println("Guau!");
    }
}