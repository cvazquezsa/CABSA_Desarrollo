[Forma]
Clave=aroEventoLista
Nombre=Eventos Perdida
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=626
PosicionInicialArriba=294
PosicionInicialAlturaCliente=578
PosicionInicialAncho=668
PosicionSec1=398
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroEvento
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=aroEvento.Nombre
ListaOrden=aroEvento.Orden<TAB>(Acendente)
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Eventos Perdida
IconosNombre=aroEvento:aroEvento.EventoRiesgo

[Lista.aroEvento.Nombre]
Carpeta=Lista
Clave=aroEvento.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Descripcion.aroEvento.Descripcion]
Carpeta=Descripcion
Clave=aroEvento.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255x10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
EventoRiesgo=124
Nombre=434
EsEstructura=68
0=109
1=407

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)
