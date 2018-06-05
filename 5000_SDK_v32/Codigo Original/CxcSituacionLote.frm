[Forma]
Clave=CxcSituacionLote
Nombre=Modificar Situación en Lote
Icono=0
Modulos=CXC
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=491
PosicionInicialArriba=317
PosicionInicialAlturaCliente=355
PosicionInicialAncho=298
MovModulo=CXC
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Mov
ExpresionesAlMostrar=Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Estatus, Nulo)<BR>Asigna(Info.Situacion, Nulo)<BR>EjecutarSQL(<T>spMovLoteEliminar :nEstacion<T>, EstacionTrabajo) <BR>Si(no Forma(<T>EspecificarMovCxc<T>), AbortarOperacion)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxcMovLote
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
ListaEnCaptura=MovLote.MovID
CarpetaVisible=S

[Lista.MovLote.MovID]
Carpeta=Lista
Clave=MovLote.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mov=131
MovID=116

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Modificar Situación
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Expresion<BR>Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.Mov, Info.Mov)<BR>Asigna(Info.Estatus, Info.Estatus)<BR>Forma(<T>MovSituacionLote<T>)

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spMovSituacionLote :nEstacion, :tEmpresa, :tModulo, :tMov, :tEstatus, :tSituacion<T>, EstacionTrabajo, Empresa, <T>CXC<T>, Info.Mov, Info.Estatus, Info.Situacion)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
