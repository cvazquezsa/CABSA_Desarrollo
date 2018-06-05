
[Forma]
Clave=VtasProrrateo
Icono=0
Modulos=(Todos)
MovModulo=VTAS
Nombre=Prorrateo Ventas

ListaCarpetas=lista
CarpetaPrincipal=lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=405
PosicionInicialAncho=1287
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaColor=Plata
PosicionInicialIzquierda=316
PosicionInicialArriba=298
Totalizadores=S
PosicionSec1=332
ListaAcciones=Aceptar
[lista]
Estilo=Hoja
Clave=lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VtasProrrateo
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S


FiltroGeneral=VtasProrrateo.ID = {Info.ID}
[lista.VtasProrrateo.EmpresaProrrateo]
Carpeta=lista
Clave=VtasProrrateo.EmpresaProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[lista.VtasProrrateo.SucursalProrrateo]
Carpeta=lista
Clave=VtasProrrateo.SucursalProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[lista.VtasProrrateo.CCProrrateo]
Carpeta=lista
Clave=VtasProrrateo.CCProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[lista.VtasProrrateo.CC2Prorrateo]
Carpeta=lista
Clave=VtasProrrateo.CC2Prorrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[lista.VtasProrrateo.CC3Prorrateo]
Carpeta=lista
Clave=VtasProrrateo.CC3Prorrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[lista.VtasProrrateo.EspacioProrrateo]
Carpeta=lista
Clave=VtasProrrateo.EspacioProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[lista.VtasProrrateo.VINProrrateo]
Carpeta=lista
Clave=VtasProrrateo.VINProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[lista.VtasProrrateo.ProyectoProrrateo]
Carpeta=lista
Clave=VtasProrrateo.ProyectoProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[lista.VtasProrrateo.UENProrrateo]
Carpeta=lista
Clave=VtasProrrateo.UENProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[lista.VtasProrrateo.ActividadProrrateo]
Carpeta=lista
Clave=VtasProrrateo.ActividadProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[lista.VtasProrrateo.Porcentaje]
Carpeta=lista
Clave=VtasProrrateo.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[lista.Columnas]
RenglonID=64
EmpresaProrrateo=91
SucursalProrrateo=90
CCProrrateo=99
CC2Prorrateo=94
CC3Prorrateo=97
EspacioProrrateo=86
VINProrrateo=124
ProyectoProrrateo=124
UENProrrateo=33
ActividadProrrateo=150
Porcentaje=65



0=91
1=267
CentroCostos=127
Descripcion=235
CentroCostos2=127
CentroCostos3=127
UEN=44
Nombre=269



Importe=117
Articulo=124
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
FichaAlineacionDerecha=S
FichaColorFondo=Plata
Totalizadores=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
Totalizadores1=%Total<BR>Total Prorrateado<BR>Total Importe
Totalizadores2=Suma(VtasProrrateo:VtasProrrateo.Porcentaje)<BR>Suma(VtasProrrateo:VtasProrrateo.Importe)<BR>Info.Importe
Totalizadores3=0.00<BR>(Monetario)<BR>(Monetario)
TotCarpetaRenglones=lista
ListaEnCaptura=(Lista)

[(Carpeta Totalizadores).%Total]
Carpeta=(Carpeta Totalizadores)
Clave=%Total
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S
ConCondicion=S






EjecucionCondicion=GuardarCambios<BR>1 = SQL(<T>SELECT Ok FROM fnValidarVtasProrrateo(:t1)<T>,Info.ID)
EjecucionMensaje=SQL(<T>SELECT OkRef FROM fnValidarVtasProrrateo(:t1)<T>,Info.ID)
EjecucionConError=S
[lista.VtasProrrateo.Importe]
Carpeta=lista
Clave=VtasProrrateo.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[lista.VtasProrrateo.Articulo]
Carpeta=lista
Clave=VtasProrrateo.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[(Carpeta Totalizadores).Total Prorrateado]
Carpeta=(Carpeta Totalizadores)
Clave=Total Prorrateado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[(Carpeta Totalizadores).Total Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Total Importe
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata



[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Total Prorrateado
Total Prorrateado=Total Importe
Total Importe=%Total
%Total=(Fin)

[lista.ListaEnCaptura]
(Inicio)=VtasProrrateo.Articulo
VtasProrrateo.Articulo=VtasProrrateo.EmpresaProrrateo
VtasProrrateo.EmpresaProrrateo=VtasProrrateo.SucursalProrrateo
VtasProrrateo.SucursalProrrateo=VtasProrrateo.CCProrrateo
VtasProrrateo.CCProrrateo=VtasProrrateo.CC2Prorrateo
VtasProrrateo.CC2Prorrateo=VtasProrrateo.CC3Prorrateo
VtasProrrateo.CC3Prorrateo=VtasProrrateo.UENProrrateo
VtasProrrateo.UENProrrateo=VtasProrrateo.EspacioProrrateo
VtasProrrateo.EspacioProrrateo=VtasProrrateo.VINProrrateo
VtasProrrateo.VINProrrateo=VtasProrrateo.ProyectoProrrateo
VtasProrrateo.ProyectoProrrateo=VtasProrrateo.ActividadProrrateo
VtasProrrateo.ActividadProrrateo=VtasProrrateo.Importe
VtasProrrateo.Importe=VtasProrrateo.Porcentaje
VtasProrrateo.Porcentaje=(Fin)
