
[Forma]
Clave=eDocInHerrTablaST
Icono=0
CarpetaPrincipal=eDocInHerrTablaST
Modulos=(Todos)
Nombre=Generar Tabla Conversión
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
ListaAcciones=(Lista)
PosicionInicialIzquierda=502
PosicionInicialArriba=151
PosicionInicialAlturaCliente=519
PosicionInicialAncho=595
PosicionSec1=124
ExpresionesAlMostrar=EjecutarSQL(<T>speDocInBorrarHerrTablaSt :nEstacion<T>,EstacionTrabajo)
[eDocInHerrTablaST]
Estilo=Ficha
Clave=eDocInHerrTablaST
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocInHerrTablaST
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
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=eDocInHerrTablaST.Estacion = {EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
[eDocInHerrTablaST.ListaEnCaptura]
(Inicio)=eDocInHerrTablaST.TablaSt
eDocInHerrTablaST.TablaSt=eDocInHerrTablaST.Tablas
eDocInHerrTablaST.Tablas=eDocInHerrTablaST.CampoNombre
eDocInHerrTablaST.CampoNombre=eDocInHerrTablaST.CampoValor
eDocInHerrTablaST.CampoValor=(Fin)

[eDocInHerrTablaST.eDocInHerrTablaST.TablaSt]
Carpeta=eDocInHerrTablaST
Clave=eDocInHerrTablaST.TablaSt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[eDocInHerrTablaST.eDocInHerrTablaST.Tablas]
Carpeta=eDocInHerrTablaST
Clave=eDocInHerrTablaST.Tablas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[eDocInHerrTablaST.eDocInHerrTablaST.CampoNombre]
Carpeta=eDocInHerrTablaST
Clave=eDocInHerrTablaST.CampoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[eDocInHerrTablaST.eDocInHerrTablaST.CampoValor]
Carpeta=eDocInHerrTablaST
Clave=eDocInHerrTablaST.CampoValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[eDocInHerrTablaSTD]
Estilo=Hoja
Clave=eDocInHerrTablaSTD
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=eDocInHerrTablaSTD
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
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=eDocInHerrTablaSTD.Estacion = {EstacionTrabajo}
[eDocInHerrTablaSTD.eDocInHerrTablaSTD.Operando1]
Carpeta=eDocInHerrTablaSTD
Clave=eDocInHerrTablaSTD.Operando1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[eDocInHerrTablaSTD.eDocInHerrTablaSTD.Operador]
Carpeta=eDocInHerrTablaSTD
Clave=eDocInHerrTablaSTD.Operador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[eDocInHerrTablaSTD.eDocInHerrTablaSTD.Operando2]
Carpeta=eDocInHerrTablaSTD
Clave=eDocInHerrTablaSTD.Operando2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


NombreEnBoton=S
[Acciones.Expresion]
Nombre=Expresion
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=ProcesarSQL(<T>speDocInGenerarInsertTablaSt :nEstacion<T>,EstacionTrabajo)
[eDocInHerrTablaSTD.Columnas]
Operando1=201
Operador=129
Operando2=201

[eDocInHerrTablaSTD.ListaEnCaptura]
(Inicio)=eDocInHerrTablaSTD.Operando1
eDocInHerrTablaSTD.Operando1=eDocInHerrTablaSTD.Operador
eDocInHerrTablaSTD.Operador=eDocInHerrTablaSTD.Operando2
eDocInHerrTablaSTD.Operando2=(Fin)





































[Forma.ListaCarpetas]
(Inicio)=eDocInHerrTablaST
eDocInHerrTablaST=eDocInHerrTablaSTD
eDocInHerrTablaSTD=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Expresion
Expresion=(Fin)
