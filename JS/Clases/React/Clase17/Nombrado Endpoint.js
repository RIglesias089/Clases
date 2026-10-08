//usamos el api rest para desarrollar una salida de informacion, su priorizacion y demas
//una solucion seria (de solo 1 endpoint) el graphql que no tiene nada que ver con GrapUS, solo un camino de netrada y salida me lleva a la solucion
//Concurrencia era tener dos procesos atendidos por un solo nucleo, osea que recibe y responde al mismo tiempo
//JrPc este lo hace en nodo o cola, tiene la capacidad para un escalamiento vertical
//En rest si queremos listar usamos get, si queremos crear un recursos tenemos post,
//si queremos borrar usamos delet, si queremos actualizar usamos put, si queremos actualizar un solo campo usamos un patch

//si teenmos un parametro user/parametro, cuano el parametro se ingrese al backend lo que ambiara sera el metodo con el que lo 
//buscara o desarrollara, con este metodo accedemos y dentro de le rest le conocemos commo verbo, el qeu queremos hacer.

//Cuando creamos las indicaciones tenemos que plantear bien las reglas porque de los ocntrario este puede causar errores
//asi com problemas, hayq ue definirlo al momento de ejecutar la accion.

//Generamos un endpoint para listar una casa el post para crear la casa con HTTP,
//luego de eso le solicitamos el body este nos deve devoleren su respuesta , esto es erroneo 
//en su arquitectura debemos hacer con u metodo de get, pero este no recibe u body, para evitar y solucionarlo, 
//Agregamos un parametro a el url, para que el get sepa donde buscar y directaente llamarlo y darnos una respuesta por HTTP

//Si tenemos otro caso con su url con casas/obtener, esto es malo porque agregamos el metodo cosa que no debe ir dentro de ella,
//si geneeramos un parametro de la forma /casas?="Value", query, inyecta diferentes valores que es usado pero en una base de datos
//la estructura debe ser distinta porque si no puede causar problemas.

//Postman o thunderclient al igual de insomnia, pokeAPI nos ayuda siendo un cliente, el cual nos peude ayudar con la informacion que solicitamos
 