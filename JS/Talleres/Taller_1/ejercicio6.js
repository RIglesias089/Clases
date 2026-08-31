//              =====EJERCICIO 6=====
class Producto {
    constructor(nombre, precio, stock) {
        this.nombre = nombre;
        this.precio = precio;
        this.stock = stock;
    }

    mostrarDetalles() {
        console.log('Producto: ' + this.nombre);
        console.log('Precio: $' + this.precio);
        console.log('Stock: ' + this.stock + 'unidades');
        console.log("-------------------");
    }
}

// Creacion de objetos
const producto1 = new Producto("Audifonos", 25, 10);
const producto2 = new Producto("Cuaderno", 45, 15);
const producto3 = new Producto("Mouse", 25, 10);

producto1.mostrarDetalles();
producto2.mostrarDetalles();
producto3.mostrarDetalles();
