[Forma]
Clave=Organizacion
Icono=0
Modulos=(Todos)
Nombre=Organizaciones

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=487
PosicionInicialArriba=156
PosicionInicialAlturaCliente=420
PosicionInicialAncho=392
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionSec1=216
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Organizacion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Lista.Organizacion.Organizacion]
Carpeta=Lista
Clave=Organizacion.Organizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Organizacion.Nombre]
Carpeta=Lista
Clave=Organizacion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Lista.Columnas]
Organizacion=44
Nombre=300
Descripcion=400

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Descripcion]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Descripción
Clave=Descripcion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=Organizacion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Organizacion.Descripcion
CarpetaVisible=S
AlinearTodaCarpeta=S

[Descripcion.Organizacion.Descripcion]
Carpeta=Descripcion
Clave=Organizacion.Descripcion
Editar=S
3D=S
Tamano=255x3
ColorFondo=Blanco

















































































[Lista.ListaEnCaptura]
(Inicio)=Organizacion.Organizacion
Organizacion.Organizacion=Organizacion.Nombre
Organizacion.Nombre=(Fin)


[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Posiciones
Posiciones=(Fin)









[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Descripcion
Descripcion=(Fin)
