[Forma]
Clave=ClaseProrrateo
Nombre=Tabla Prorrateo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=504
PosicionInicialArriba=338
PosicionInicialAltura=393
PosicionInicialAncho=912
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Clase, Info.SubClase)
Totalizadores=S
PosicionSeccion1=90
PosicionInicialAlturaCliente=489
PosicionSec1=427

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ClaseProrrateo
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Predefinido
CarpetaVisible=S
FiltroPredefinido1=por %<BR>por Sucursal<BR>por Centro Costos<BR>por Centro Costos 2<BR>por Centro Costos 3<BR>por Proyecto<BR>por Actividad<BR>por Sucursal / Centro Costos<BR>por UEN<BR>por Activo Fijo
FiltroPredefinido2=Modulo IS NOT NULL<BR>Modulo IS NOT NULL<BR>Modulo IS NOT NULL<BR>Modulo IS NOT NULL<BR>Modulo IS NOT NULL<BR>Modulo IS NOT NULL<BR>Modulo IS NOT NULL<BR>Modulo IS NOT NULL<BR>Modulo IS NOT NULL<BR>Modulo IS NOT NULL
FiltroPredefinido3=Porcentaje<BR>SucursalProrrateo, Porcentaje<BR>CCProrrateo, Porcentaje<BR>CC2Prorrateo, Porcentaje<BR>CC3Prorrateo, Porcentaje<BR>ProyectoProrrateo, Porcentaje<BR>ActividadProrrateo, Porcentaje<BR>SucursalProrrateo, CCProrrateo, CC2Prorrateo, CC3Prorrateo, Porcentaje<BR>UENProrrateo, Porcentaje<BR>AFArticuloProrrateo, AFSerieProrrateo, Porcentaje
FiltroEstilo=Directorio
ValidarCampos=S
ListaCamposAValidar=(Lista)

FiltroGeneral=ClaseProrrateo.Modulo=<T>{Info.Modulo}<T> AND ClaseProrrateo.Clase=<T>{Info.Clase}<T> AND ClaseProrrateo.SubClase<BR>{Si(ConDatos(Info.SubClase), <T>=<T>+Comillas(Info.SubClase), <T> IS NOT NULL<T>)}<BR>AND NULLIF(RTRIM(UPPER(ClaseProrrateo.EmpresaProrrateo)), <T><T>) IN (NULL, <T>(TODAS)<T>, <T>{Empresa}<T>)
[Lista.ClaseProrrateo.Porcentaje]
Carpeta=Lista
Clave=ClaseProrrateo.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Sucursal=47
Nombre=120
Porcentaje=40
SucursalProrrateo=46
CCProrrateo=105
ProyectoProrrateo=120
ActividadProrrateo=82
Empresa=54
EmpresaProrrateo=57
EspacioProrrateo=90
UENProrrateo=26
AFArticuloProrrateo=90
AFSerieProrrateo=78
VINProrrateo=124

CC2Prorrateo=100
CC3Prorrateo=99
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
Totalizadores1=% Total
Totalizadores2=Suma(ClaseProrrateo:ClaseProrrateo.Porcentaje)
Totalizadores3=0.00
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=% Total
CarpetaVisible=S

[Lista.ClaseProrrateo.SucursalProrrateo]
Carpeta=Lista
Clave=ClaseProrrateo.SucursalProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).% Total]
Carpeta=(Carpeta Totalizadores)
Clave=% Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata
ColorFuente=Negro

[Lista.ClaseProrrateo.CCProrrateo]
Carpeta=Lista
Clave=ClaseProrrateo.CCProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClaseProrrateo.ProyectoProrrateo]
Carpeta=Lista
Clave=ClaseProrrateo.ProyectoProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClaseProrrateo.ActividadProrrateo]
Carpeta=Lista
Clave=ClaseProrrateo.ActividadProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClaseProrrateo.EmpresaProrrateo]
Carpeta=Lista
Clave=ClaseProrrateo.EmpresaProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClaseProrrateo.EspacioProrrateo]
Carpeta=Lista
Clave=ClaseProrrateo.EspacioProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClaseProrrateo.UENProrrateo]
Carpeta=Lista
Clave=ClaseProrrateo.UENProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClaseProrrateo.AFArticuloProrrateo]
Carpeta=Lista
Clave=ClaseProrrateo.AFArticuloProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClaseProrrateo.AFSerieProrrateo]
Carpeta=Lista
Clave=ClaseProrrateo.AFSerieProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClaseProrrateo.VINProrrateo]
Carpeta=Lista
Clave=ClaseProrrateo.VINProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro





[Lista.ClaseProrrateo.CC2Prorrateo]
Carpeta=Lista
Clave=ClaseProrrateo.CC2Prorrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ClaseProrrateo.CC3Prorrateo]
Carpeta=Lista
Clave=ClaseProrrateo.CC3Prorrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro







[Lista.ListaEnCaptura]
(Inicio)=ClaseProrrateo.EmpresaProrrateo
ClaseProrrateo.EmpresaProrrateo=ClaseProrrateo.CCProrrateo
ClaseProrrateo.CCProrrateo=ClaseProrrateo.CC2Prorrateo
ClaseProrrateo.CC2Prorrateo=ClaseProrrateo.CC3Prorrateo
ClaseProrrateo.CC3Prorrateo=ClaseProrrateo.VINProrrateo
ClaseProrrateo.VINProrrateo=ClaseProrrateo.EspacioProrrateo
ClaseProrrateo.EspacioProrrateo=ClaseProrrateo.SucursalProrrateo
ClaseProrrateo.SucursalProrrateo=ClaseProrrateo.ProyectoProrrateo
ClaseProrrateo.ProyectoProrrateo=ClaseProrrateo.ActividadProrrateo
ClaseProrrateo.ActividadProrrateo=ClaseProrrateo.UENProrrateo
ClaseProrrateo.UENProrrateo=ClaseProrrateo.AFArticuloProrrateo
ClaseProrrateo.AFArticuloProrrateo=ClaseProrrateo.AFSerieProrrateo
ClaseProrrateo.AFSerieProrrateo=ClaseProrrateo.Porcentaje
ClaseProrrateo.Porcentaje=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Sucursal.Nombre
Sucursal.Nombre=Espacio.Nombre
Espacio.Nombre=Art.Descripcion1
Art.Descripcion1=UEN.Nombre
UEN.Nombre=(Fin)
