[Forma]
Clave=aroProcedimientoLista
Nombre=Procedimientos
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=643
PosicionInicialArriba=333
PosicionInicialAlturaCliente=499
PosicionInicialAncho=633
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSec1=330

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroProcedimiento
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=aroProcedimiento.Nombre
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Procedimiento<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Procedimientos
IconosNombre=aroProcedimiento:aroProcedimiento.Procedimiento

[Lista.aroProcedimiento.Nombre]
Carpeta=Lista
Clave=aroProcedimiento.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Procedimiento=145
Nombre=358
Proceso=124
CentroCostos=124
UnidadOrganizacional=118
0=114
1=399

[Ficha.aroProcedimiento.Proceso]
Carpeta=Ficha
Clave=aroProcedimiento.Proceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.aroProceso.Nombre]
Carpeta=Ficha
Clave=aroProceso.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Ficha.aroProcedimiento.CentroCostos]
Carpeta=Ficha
Clave=aroProcedimiento.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CentroCostos.Descripcion]
Carpeta=Ficha
Clave=CentroCostos.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Ficha.aroProcedimiento.UnidadOrganizacional]
Carpeta=Ficha
Clave=aroProcedimiento.UnidadOrganizacional
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.aroUnidad.Nombre]
Carpeta=Ficha
Clave=aroUnidad.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
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
