package org.model;

/**
 * Clase hija 'Gato' que también hereda de la clase abstracta 'mascota'.
 */
public class Gato extends mascota {

    /**
     * Constructor de la clase hija 'Gato'.
     * Utiliza 'super(nombre)' para enviarle el nombre al constructor de la clase padre (mascota).
     */
    public Gato(String nombre) {
        super(nombre);
    }

    /**
     * Implementación obligatoria del método abstracto heredado de la clase 'mascota'.
     * Define el comportamiento particular del sonido de un gato.
     */
    @Override
    public void hacerSonido() {
        System.out.println("Miau!");
    }
}