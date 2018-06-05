[Forma]
Clave=MovTipoCampoExtra
Nombre=Campos Extras del Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=304
PosicionInicialArriba=253
PosicionInicialAlturaCliente=490
PosicionInicialAncho=672
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Mov

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoCampoExtra
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=MovTipoCampoExtra.Orden<TAB>(Acendente)
FiltroGeneral=MovTipoCampoExtra.Modulo=<T>{Info.Modulo}<T> AND<BR>MovTipoCampoExtra.Mov=<T>{Info.Mov}<T>

[Lista.MovTipoCampoExtra.CampoExtra]
Carpeta=Lista
Clave=MovTipoCampoExtra.CampoExtra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampoExtra.Nombre]
Carpeta=Lista
Clave=CampoExtra.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.MovTipoCampoExtra.Grupo]
Carpeta=Lista
Clave=MovTipoCampoExtra.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoCampoExtra.Requerido]
Carpeta=Lista
Clave=MovTipoCampoExtra.Requerido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Antes=S
DespuesGuardar=S
AntesExpresiones=EjecutarSQL(<T>spMovCampoExtraCrearVista :tModulo<T>, Info.Modulo)

[Lista.Columnas]
CampoExtra=172
Nombre=178
Grupo=199
Requerido=53
Orden=38

[Lista.MovTipoCampoExtra.Orden]
Carpeta=Lista
Clave=MovTipoCampoExtra.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=MovTipoCampoExtra.CampoExtra
MovTipoCampoExtra.CampoExtra=CampoExtra.Nombre
CampoExtra.Nombre=MovTipoCampoExtra.Grupo
MovTipoCampoExtra.Grupo=MovTipoCampoExtra.Requerido
MovTipoCampoExtra.Requerido=MovTipoCampoExtra.Orden
MovTipoCampoExtra.Orden=(Fin)
