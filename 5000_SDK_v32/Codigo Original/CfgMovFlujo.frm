[Forma]
Clave=CfgMovFlujo
Nombre=Flujo del Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=654
PosicionInicialArriba=389
PosicionInicialAltura=300
PosicionInicialAncho=553
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Mov
PosicionInicialAlturaCliente=386

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgMovFlujo
Fuente={Tahoma, 8, Negro, []}
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
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S
ListaOrden=CfgMovFlujo.Orden<TAB>(Acendente)
HojaTitulos=S
HojaMostrarColumnas=S
FiltroGeneral=Modulo=<T>{Info.Modulo}<T> AND OMov=<T>{Info.Mov}<T>

[Lista.CfgMovFlujo.DMov]
Carpeta=Lista
Clave=CfgMovFlujo.DMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
GuardarAntes=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(CfgMovFlujo:CfgMovFlujo.DMov)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Lista.Columnas]
DMov=240
Orden=47
Nombre=274
Nivel=58

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Forma(<T>CfgMovFlujoOrdenar<T>)

[Lista.CfgMovFlujo.Nombre]
Carpeta=Lista
Clave=CfgMovFlujo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ordenar
Ordenar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CfgMovFlujo.DMov
CfgMovFlujo.DMov=CfgMovFlujo.Nombre
CfgMovFlujo.Nombre=(Fin)
