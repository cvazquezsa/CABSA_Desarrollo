[Forma]
Clave=ConceptoProrrateo
Nombre=Tabla Prorrateo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=516
PosicionInicialArriba=338
PosicionInicialAltura=393
PosicionInicialAncho=888
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Concepto
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
Vista=ConceptoProrrateo
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

FiltroGeneral=ConceptoProrrateo.Modulo=<T>{Info.Modulo}<T> AND ConceptoProrrateo.Concepto=<T>{Info.Concepto}<T> AND NULLIF(RTRIM(UPPER(ConceptoProrrateo.EmpresaProrrateo)), <T><T>) IN (NULL, <T>(TODAS)<T>, <T>{Empresa}<T>)
[Lista.ConceptoProrrateo.Porcentaje]
Carpeta=Lista
Clave=ConceptoProrrateo.Porcentaje
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

CC2Prorrateo=87
CC3Prorrateo=89
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
Totalizadores2=Suma(ConceptoProrrateo:ConceptoProrrateo.Porcentaje)
Totalizadores3=0.00
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=% Total
CarpetaVisible=S

[Lista.ConceptoProrrateo.SucursalProrrateo]
Carpeta=Lista
Clave=ConceptoProrrateo.SucursalProrrateo
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

[Lista.ConceptoProrrateo.CCProrrateo]
Carpeta=Lista
Clave=ConceptoProrrateo.CCProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConceptoProrrateo.ProyectoProrrateo]
Carpeta=Lista
Clave=ConceptoProrrateo.ProyectoProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConceptoProrrateo.ActividadProrrateo]
Carpeta=Lista
Clave=ConceptoProrrateo.ActividadProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConceptoProrrateo.EmpresaProrrateo]
Carpeta=Lista
Clave=ConceptoProrrateo.EmpresaProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConceptoProrrateo.EspacioProrrateo]
Carpeta=Lista
Clave=ConceptoProrrateo.EspacioProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConceptoProrrateo.UENProrrateo]
Carpeta=Lista
Clave=ConceptoProrrateo.UENProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConceptoProrrateo.AFArticuloProrrateo]
Carpeta=Lista
Clave=ConceptoProrrateo.AFArticuloProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConceptoProrrateo.AFSerieProrrateo]
Carpeta=Lista
Clave=ConceptoProrrateo.AFSerieProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConceptoProrrateo.VINProrrateo]
Carpeta=Lista
Clave=ConceptoProrrateo.VINProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro





[Lista.ConceptoProrrateo.CC2Prorrateo]
Carpeta=Lista
Clave=ConceptoProrrateo.CC2Prorrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ConceptoProrrateo.CC3Prorrateo]
Carpeta=Lista
Clave=ConceptoProrrateo.CC3Prorrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro









[Lista.ListaEnCaptura]
(Inicio)=ConceptoProrrateo.EmpresaProrrateo
ConceptoProrrateo.EmpresaProrrateo=ConceptoProrrateo.CCProrrateo
ConceptoProrrateo.CCProrrateo=ConceptoProrrateo.CC2Prorrateo
ConceptoProrrateo.CC2Prorrateo=ConceptoProrrateo.CC3Prorrateo
ConceptoProrrateo.CC3Prorrateo=ConceptoProrrateo.VINProrrateo
ConceptoProrrateo.VINProrrateo=ConceptoProrrateo.EspacioProrrateo
ConceptoProrrateo.EspacioProrrateo=ConceptoProrrateo.SucursalProrrateo
ConceptoProrrateo.SucursalProrrateo=ConceptoProrrateo.ProyectoProrrateo
ConceptoProrrateo.ProyectoProrrateo=ConceptoProrrateo.ActividadProrrateo
ConceptoProrrateo.ActividadProrrateo=ConceptoProrrateo.UENProrrateo
ConceptoProrrateo.UENProrrateo=ConceptoProrrateo.AFArticuloProrrateo
ConceptoProrrateo.AFArticuloProrrateo=ConceptoProrrateo.AFSerieProrrateo
ConceptoProrrateo.AFSerieProrrateo=ConceptoProrrateo.Porcentaje
ConceptoProrrateo.Porcentaje=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Sucursal.Nombre
Sucursal.Nombre=Espacio.Nombre
Espacio.Nombre=Art.Descripcion1
Art.Descripcion1=UEN.Nombre
UEN.Nombre=(Fin)
