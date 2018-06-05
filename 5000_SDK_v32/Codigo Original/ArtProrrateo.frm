
[Forma]
Clave=ArtProrrateo
Icono=0
Modulos=(Todos)

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
Totalizadores=S
Nombre=Tabla Prorrateo
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=19
PosicionInicialArriba=141
PosicionInicialAlturaCliente=451
PosicionInicialAncho=986
ListaAcciones=Aceptar
PosicionSec1=381
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Comentarios=Lista(Info.Articulo)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtProrrateo
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

Filtros=S
ValidarCampos=S
PermiteEditar=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Predefinido
ListaEnCaptura=(Lista)
ListaCamposAValidar=(Lista)
FiltroPredefinido1=por %<BR>por Sucursal<BR>por Centro Costos<BR>por Centro Costos 2<BR>por Centro Costos 3<BR>por Proyecto<BR>por Actividad<BR>por Sucursal / Centro<BR>por UEN
FiltroPredefinido2=Art IS NOT NULL<BR>Art IS NOT NULL<BR>Art IS NOT NULL<BR>Art IS NOT NULL<BR>Art IS NOT NULL<BR>Art IS NOT NULL<BR>Art IS NOT NULL<BR>Art IS NOT NULL<BR>Art IS NOT NULL
FiltroPredefinido3=Porcentaje<BR>SucursalProrrateo, Porcentaje<BR>CCProrrateo, Porcentaje<BR>CC2Prorrateo, Porcentaje<BR>CC3Prorrateo, Porcentaje<BR>ProyectoProrrateo, Porcentaje<BR>ActividadProrrateo, Porcentaje<BR>SucursalProrrateo, CCProrrateo, CC2Prorrateo, CC3Prorrateo, Porcentaje<BR>UENProrrateo, Porcentaje
FiltroEstilo=Directorio
FiltroGeneral=ArtProrrateo.Art=<T>{Info.Articulo}<T> AND<BR>NULLIF(RTRIM(UPPER(ArtProrrateo.EmpresaProrrateo)), <T><T>) IN (NULL, <T>(TODAS)<T>, <T>{Empresa}<T>)
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S



ConCondicion=S
Activo=S
GuardarAntes=S
EjecucionConError=S
EjecucionCondicion=Si(ConDatos(ArtProrrateo:ArtProrrateo.Art), Suma(ArtProrrateo:ArtProrrateo.Porcentaje) = 100 , Verdadero)
EjecucionMensaje=El %Total debe ser 100
[Lista.ArtProrrateo.EmpresaProrrateo]
Carpeta=Lista
Clave=ArtProrrateo.EmpresaProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Lista.ArtProrrateo.SucursalProrrateo]
Carpeta=Lista
Clave=ArtProrrateo.SucursalProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtProrrateo.CCProrrateo]
Carpeta=Lista
Clave=ArtProrrateo.CCProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ArtProrrateo.CC2Prorrateo]
Carpeta=Lista
Clave=ArtProrrateo.CC2Prorrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ArtProrrateo.CC3Prorrateo]
Carpeta=Lista
Clave=ArtProrrateo.CC3Prorrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ArtProrrateo.EspacioProrrateo]
Carpeta=Lista
Clave=ArtProrrateo.EspacioProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.ArtProrrateo.VINProrrateo]
Carpeta=Lista
Clave=ArtProrrateo.VINProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ArtProrrateo.ProyectoProrrateo]
Carpeta=Lista
Clave=ArtProrrateo.ProyectoProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ArtProrrateo.UENProrrateo]
Carpeta=Lista
Clave=ArtProrrateo.UENProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtProrrateo.ActividadProrrateo]
Carpeta=Lista
Clave=ArtProrrateo.ActividadProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.ArtProrrateo.Porcentaje]
Carpeta=Lista
Clave=ArtProrrateo.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
Totalizadores1=%Total
Totalizadores2=Suma(ArtProrrateo:ArtProrrateo.Porcentaje)
TotCarpetaRenglones=Lista

Totalizadores3=0.00
ListaEnCaptura=%Total

[Lista.Columnas]
EmpresaProrrateo=91
CCProrrateo=124
CC2Prorrateo=124
CC3Prorrateo=124
VINProrrateo=124
EspacioProrrateo=86
SucursalProrrateo=90
ProyectoProrrateo=243
ActividadProrrateo=233
UENProrrateo=70
Porcentaje=64

CentroCostos=127
Descripcion=235
0=91
1=267
UEN=44
Nombre=269
[(Carpeta Totalizadores).%Total]
Carpeta=(Carpeta Totalizadores)
Clave=%Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata





























[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S









[Lista.ListaEnCaptura]
(Inicio)=ArtProrrateo.EmpresaProrrateo
ArtProrrateo.EmpresaProrrateo=ArtProrrateo.CCProrrateo
ArtProrrateo.CCProrrateo=ArtProrrateo.CC2Prorrateo
ArtProrrateo.CC2Prorrateo=ArtProrrateo.CC3Prorrateo
ArtProrrateo.CC3Prorrateo=ArtProrrateo.VINProrrateo
ArtProrrateo.VINProrrateo=ArtProrrateo.EspacioProrrateo
ArtProrrateo.EspacioProrrateo=ArtProrrateo.SucursalProrrateo
ArtProrrateo.SucursalProrrateo=ArtProrrateo.ProyectoProrrateo
ArtProrrateo.ProyectoProrrateo=ArtProrrateo.ActividadProrrateo
ArtProrrateo.ActividadProrrateo=ArtProrrateo.UENProrrateo
ArtProrrateo.UENProrrateo=ArtProrrateo.Porcentaje
ArtProrrateo.Porcentaje=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Sucursal.Nombre
Sucursal.Nombre=Espacio.Nombre
Espacio.Nombre=ArtProrrateo.Art
ArtProrrateo.Art=UEN.Nombre
UEN.Nombre=(Fin)
