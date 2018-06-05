[Forma]
Clave=EmpresaCfgMovAlmacenDef
Nombre=Almacenes por Omisión
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=266
PosicionInicialArriba=216
PosicionInicialAlturaCliente=301
PosicionInicialAncho=492
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Empresa

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovAlmacenDef
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.EmpresaCfgMovAlmacenDef.Modulo]
Carpeta=Lista
Clave=EmpresaCfgMovAlmacenDef.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovAlmacenDef.Mov]
Carpeta=Lista
Clave=EmpresaCfgMovAlmacenDef.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovAlmacenDef.Almacen]
Carpeta=Lista
Clave=EmpresaCfgMovAlmacenDef.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Modulo=54
Mov=141
Almacen=88
Nombre=177

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

[Lista.Alm.Nombre]
Carpeta=Lista
Clave=Alm.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ListaEnCaptura]
(Inicio)=EmpresaCfgMovAlmacenDef.Modulo
EmpresaCfgMovAlmacenDef.Modulo=EmpresaCfgMovAlmacenDef.Mov
EmpresaCfgMovAlmacenDef.Mov=EmpresaCfgMovAlmacenDef.Almacen
EmpresaCfgMovAlmacenDef.Almacen=Alm.Nombre
Alm.Nombre=(Fin)
