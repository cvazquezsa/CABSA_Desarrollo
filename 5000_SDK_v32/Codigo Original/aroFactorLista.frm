[Forma]
Clave=aroFactorLista
Nombre=Factores Riesgo
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=600
PosicionInicialArriba=284
PosicionInicialAlturaCliente=597
PosicionInicialAncho=719
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSec1=408

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroFactor
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=aroFactor.Nombre
CarpetaVisible=S
OtroOrden=S
ListaOrden=aroFactor.Orden<TAB>(Acendente)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Factores Riesgo
IconosNombre=aroFactor:aroFactor.FactorRiesgo

[Lista.aroFactor.Nombre]
Carpeta=Lista
Clave=aroFactor.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
FactorRiesgo=132
Nombre=445
Descripcion=503
Orden=37
EsEstructura=56
0=67
1=505

[Descripcion.aroFactor.Descripcion]
Carpeta=Descripcion
Clave=aroFactor.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x10
ColorFondo=Blanco
ColorFuente=Negro

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
NombreDesplegar=Personalizar
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
