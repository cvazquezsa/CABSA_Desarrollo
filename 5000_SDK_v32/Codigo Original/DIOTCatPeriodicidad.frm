
[Forma]
Clave=DIOTCatPeriodicidad
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Periodicidad

ListaCarpetas=Lista
PosicionInicialIzquierda=426
PosicionInicialArriba=201
PosicionInicialAlturaCliente=286
PosicionInicialAncho=514
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DIOTCatPeriodicidad
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
PermiteEditar=S

[Lista.DIOTCatPeriodicidad.Clave]
Carpeta=Lista
Clave=DIOTCatPeriodicidad.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Lista.DIOTCatPeriodicidad.Descripcion]
Carpeta=Lista
Clave=DIOTCatPeriodicidad.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
Clave=94
Descripcion=243



[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S




[Acciones.Aceptar.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.Clave,DIOTCatPeriodicidad:DIOTCatPeriodicidad.Clave)
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Seleccionar
Seleccionar=Aceptar
Aceptar=Expresion
Expresion=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=DIOTCatPeriodicidad.Clave
DIOTCatPeriodicidad.Clave=DIOTCatPeriodicidad.Descripcion
DIOTCatPeriodicidad.Descripcion=(Fin)
