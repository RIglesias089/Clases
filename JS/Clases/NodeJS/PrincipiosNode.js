/* 
 1. REPOSITORIOS Y DESARROLLO WEB:
    - Espacio donde se almacena, organiza y versiona el código fuente de un 
      proyecto (por ejemplo, usando Git y GitHub).
    - Herramientas como Node.js permiten probar, validar y gestionar el 
      ciclo de vida de todo nuestro proyecto web.

 2. NODE.JS:
    - Entorno de ejecución para JavaScript fuera del navegador (construido sobre 
      el motor V8 de Google Chrome), ideal para desarrollar aplicaciones backend.
    - Se instala de forma local en la computadora para poder gestionarlo.

 3. NVM (Node Version Manager):
    - Herramienta que permite tener instaladas y cambiar fácilmente entre 
      múltiples versiones de Node.js en una misma máquina.
    - ¿Qué versión usar?: Depende enteramente del proyecto. Si un proyecto 
      requiere Node 18, podemos usar la 18 o superiores (siempre que sean 
      compatibles). Si usamos una versión muy moderna (ej. 18) en un proyecto 
      diseñado para una versión antigua (ej. 14), es muy probable que falle 
      por incompatibilidades.

 4. LTS (Long-Term Support):
    - Versión de Node.js con soporte a largo plazo. Es la más estable y 
      recomendada para producción, permitiendo trabajar de manera segura 
      y natural sin lidiar con configuraciones experimentales.

 5. NPM (Node Package Manager):
    - Gestor de paquetes oficial que viene incluido con Node.js.
    - *Nota importante*: Aunque su nombre se parece a NVM, hacen cosas distintas. 
      NVM gestiona *versiones de Node*, mientras que NPM gestiona *paquetes y 
      dependencias* del proyecto (como librerías y frameworks).

 6. DIRECCIÓN Y PUERTO:
    - Al inicializar y levantar un servidor local con Node, este nos asigna 
      una dirección (como `localhost`) y un puerto numérico específico 
      (ej. `3000`), el cual actúa como la puerta de enlace para que el navegador 
      pueda comunicarse con nuestra aplicación.
      */

let msj = "hola, este es un mensaje"

console.log(msj);

//si queremos recibir informacion a nivel de endpoint (el url especifico), recibiremos parametros
//Estos estan en un objeto de JS | JSON (Javascript objet notation), el contenido que hay
//dentro de un objeto es un parametro o elementos.
let params = {
  name: "jhon",
  password: "123",
  age: 12,
  isActive: false
}

//buscamos ponder una condicion con la informacion que recibimos
//si tuvieramos una base de datos, corraboramos y con eso validamos que el nombre y la contrasena
//sean correctas y existan. Eso porque tenemos esos parametros dentro de un "objeto de JS"
if(nameuser === "jhon" && password === "123" && age === 12 && params.isActive === false){
  console.log("Usuario existente");
} else {
  console.log("Usuario no existente")  
};

//un objeto puede tener cualquier tipo de cosa siempre y cuando hablemos de JS, 
//cuando hablamos de Typescripot estos  deben tener un tipo y yo debo decirle
//que tipo de conteenido va a llevar ese objeto


