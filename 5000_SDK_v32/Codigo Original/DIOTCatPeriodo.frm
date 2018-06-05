
[Forma]
Clave=DIOTCatPeriodo
Icono=0
Modulos=(Todos)
MovModulo=DIOTCatPeriodo
Nombre=Periodos

ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=Lista
ListaAcciones=Aceptar
PosicionInicialIzquierda=364
PosicionInicialArriba=180
PosicionInicialAlturaCliente=328
PosicionInicialAncho=637
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DIOTCatPeriodo
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

CarpetaVisible=S

ListaEnCaptura=(Lista)


PermiteEditar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral={Si<BR>  Info.Clave <> Nulo<BR>Entonces<BR>  Si<BR>     Info.Clave <> <T><T><BR>  Entonces<BR>     <T>DIOTCatPeriodo.ClavePeriodicidad = <T> & Info.Clave<BR>  Sino<BR>     <T>1=1<T><BR>  Fin<BR>Sino<BR>  <T>1=1<T><BR>Fin }
[Lista.DIOTCatPeriodo.ClavePeriodicidad]
Carpeta=Lista
Clave=DIOTCatPeriodo.ClavePeriodicidad
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

[Lista.DIOTCatPeriodo.ClavePeriodo]
Carpeta=Lista
Clave=DIOTCatPeriodo.ClavePeriodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Lista.DIOTCatPeriodo.Descripcion]
Carpeta=Lista
Clave=DIOTCatPeriodo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.Columnas]
ClavePeriodicidad=108
Descripcion_1=177
ClavePeriodo=101
Descripcion=172



Clave=94

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

[Acciones.Aceptar.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Seleccionar
Seleccionar=Aceptar
Aceptar=(Fin)





[Lista.ListaEnCaptura]
(Inicio)=DIOTCatPeriodo.ClavePeriodicidad
DIOTCatPeriodo.ClavePeriodicidad=DIOTCatPeriodicidad.Descripcion
DIOTCatPeriodicidad.Descripcion=DIOTCatPeriodo.ClavePeriodo
DIOTCatPeriodo.ClavePeriodo=DIOTCatPeriodo.Descripcion
DIOTCatPeriodo.Descripcion=(Fin)
