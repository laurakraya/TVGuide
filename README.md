# TVGuide

TVGuide es un ejercicio de ios que abarca:

- Manejo de dependencias con CocoaPods
- Llamada a una API REST con Alamofire
- Implementación de delegation pattern
- Aplicación de principios SOLID
- Manejo de opcionales
- Evitar la generación de ciclos de referencia fuerte en delegation o callbacks, usando: weak, unowned, etc.
- Uso simple de TableViews
- Uso simple de procesos asincrónicos y callbacks
- Migrar paso a paso desde MVC hasta VIPER, pasando por MVP
- Implementar cambios a través del uso de PR

## Bitácora

PRIMERA ETAPA: MVC

Los ViewController manejan toda la lógica y terminan siendo muy extensos. 

Una clase aparte, en este caso NetworkManager, define las llamadas a la API REST.

Se divide el modelo en dos. Primero se crea un DTO (data transfer object) utilizado para parsear la respuesta de la API y luego, éste se mappea a un modelo de negocio con el que va a operar la aplicación. 

Se realizan las siguientes correcciones en el PR:
- Borrar comentarios obsoletos
- Si el DTO tiene datos opcionales, el modelo también
- Los valores por defecto no se asignan al mappear los DTOs. El VC se encarga de manejar los opcionales (a futuro lo hará el presenter)
- La extensión de UIImageView que obtiene la imagen a partir de la url pasa también al NetworkManager.
- Se agrega una extensión para poder inicializar una View a partir del nibName


SEGUNDA ETAPA: MVP

Los ViewController pasan a formar parte de la Vista, que debe ser completamente boba. Los Presenter se ocupan de manejar las llamadas a los servicios, la lógica de navegación y la de presentación.

El modelo vuelve a desdoblarse: esta vez aparece un "modelo presentable", con todos los datos ya procesados por el Presenter, que será recibido por la vista para simplemente mostrarlo. En la Vista solamente se le asigna el contenido correspondiente a los distintos elementos visuales y se les da estilo.

Se realizan las siguientes correcciones en el PR:
- Los protocolos de delegación deben extender de class (para poder hacer uso de weak y evitar un Strong Reference Cycle) y no de UIViewController.
- No duplicar data que ya esté en el presenter en el VC. 
- La lógica de manejo de strings y dates se extrapola a alguna clase auxiliar para cumplir con el principio de single responsibility.
- Cambiar nombres poco descriptivos por otros que sí lo sean.
- Se implementa el uso de [weak self] o [unowned self] dentro de callbacks para evitar otro tipo de Strong Reference Cycle.
- Se vuelve a revisar el uso de opcionales (id opcional, url opcional)

TERCERA ETAPA: Interactor

Se agrega la capa del Interactor que pasa a encargarse de las reglas de negocio, como las llamadas a servicios.

Correccciones en el PR: 
- En el init sólo se deben incializar cosas (recordar que es el constructor), otro tipo de asignaciones, como la del delegado pasan por ej al ViewDidLoad.

CUARTA ETAPA: Router

Se agrega la capa del Router que pasa a manejar toda la lógica de navegación.

Correcciones en el PR:
- El Router sólo debería ocuparse del flujo de la navegación, no de instanciar y devolver un controller. Para ello se agrega un Builder que se encargue de instanciar view controller, presenter y router, y  también de hacer las asignaciones correspondientes para relacionar dichas capas.
- Al Router se le agrega una propiedad weak y opcional de tipo viewcontroller (que es asignada en el builder) para no tener que andar pasándola por parámetro.
- El Presenter ya contiene el array de shows, de modo que en el didSelectRowAt del view controller, sólo necesitamos pasarle el indexPath.row, no un Show.