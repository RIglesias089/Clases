package org.model;

import org.interfaces.Mostrable;

class Perro extends mascota implements Mostrable {

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
     * Implementación obligatoria del método abstracto heredado de la clase 'mascota'.
     * Define el comportamiento particular del sonido de un perro.
     */
    @Override
    public void hacerSonido() {
        System.out.println("Guau!");
    }

    //implementamos el metodo que si o si debe estar por el interface
    @Override
    public void mostrarInfo(){
        System.out.println("Soy un perro llamado " + nombre);
    }
    
}

