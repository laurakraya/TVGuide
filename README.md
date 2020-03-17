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
- El interactor también se inicializa y asigna en el builder
- Se arregla un problema de referencias entre presenter y vista (sólo uno de ellos debe tener una referencia weak para romper el strong reference cycle)
- El presenter referencia al router y no viceversa, por lo tanto, la propiedad del presenter donde se referencia al router no necesita ser weak.


QUINTA ETAPA: Episodes-Table 

Se agrega a la vista del detalle de un show una tabla con distintas secciones por temporada y dentro de éstas, se agregan filas con los episodios correspondientes. 
Esto presenta la dificultad de tener una TableView (que en principio tiene scroll propio), dentro de una ScrollView. El problema radica principalmente, en que esta última para funcionar correctamente no puede tener ambigüedad en su altura, sino que requiere un alto definido que la tabla de por sí no le proporciona. 
Para resolverlo, después de intentar distintos enfoques, finalmente se anula el scroll de la tabla y se coloca un constraint para su altura. Una vez obtenidos los episodios y luego de hacer reloadData() de la tabla, se dispara una función que realiza lo siguiente:
- toma la constraint de la altura de la tabla y le otorga el valor de la altura de su contenido.
- se le pide a la vista que vuelva a realizar el layout de sus subviews.
- se modifica el tamaño del contenido de la ScrollView, dándole el ancho de la pantalla y la altura del contenido de la tabla sumada a la altura del StackView que contiene los datos del detalle del show.
- se le pide a la ScrollView que reacomode sus subviews de ser necesario.

Por otro lado, para obtener los episodios filtrados por temporada, se buscaba pasar de un array de episodios ordenados -pero no separados- por temporada, a un array de arrays con la siguiente estructura: [[episodios de temporada uno], [episodios de temporada dos], [episodios de temporada tres]], con tantos subarrays como temporadas tenga un show.
Para lograrlo primero se obtuvo mediante un map y un reduce, un array con las temporadas del show ordenadas. Luego se iteró sobre el mismo y en cada iteración se realizaron los siguientes pasos:
- filtrar el array de episodios obteniendo sólo aquellos que se correspondan con la temporada en cuestión
- appendear esos episodios a un array de episodios de la temporada
- appendear ese array a un array final que va a terminar conteniendo todos los arrays de episodios por temporada

SEXTA ETAPA: Searchbar

Se agrega a la pantalla de listado de shows una UISearchBar que permita buscar shows según el texto ingresado cada vez que este se modifica y muestre los resultados en la tabla de shows. En caso de cancelar la búsqueda o de que la searchbar quede en blanco, la tabla deberá volver a mostrar todos los shows que venían en el llamado original.
Para lograr esto, se asigna al ShowsViewController como delegado de la UISearchBar y éste implementa el protocolo UISearchBarDelegate y a continuación, el método opcional textDidChange que se dispara al realizar cambios en el contenido de la searchbar. Si el input está vacío o la búsqueda se cancela, se le pide al presenter, que a su vez le pide al interactor, que realice el llamado a la API que trae todos los shows. Si el input no está vacío, se le pide al presenter, que a su vez le pide al interactor, que realice otro llamado que le pega a un endpoint de búsqueda de la API pasando el contenido del input de la searchbar como parámetro de búsqueda. En cualquiera de los dos casos, finalmente le llega de vuelta a la vista el array de shows correspondiente y se actualiza la tabla.

Para poder mantener los resultados de una búsqueda después de haber pasado a la vista del detalle de uno de ellos y haber vuelto a la vista del listado de shows, la llamada a presenter?.getShows() se borra del método viewDidAppear() (que se ejecuta cada vez que volvemos a esa pantalla) y se coloca en el viewDidLoad(), que es ejecutado una sola vez al cargar la app.

También se juega un poco a cambiar el aspecto de la searchbar modificando el valor de algunas de sus propiedades y se experimenta con el UISearchController que trae resueltas ciertas cuestiones, le da a la searchbar otro comportamiento al ser seleccionada y la mantiene en la parte superior de la pantalla, pero éste último es descartado en favor de la UISearchBar.