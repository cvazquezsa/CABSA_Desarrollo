[Forma]
Clave=CtoTipoCampoExtra
Nombre=Campos Extras del Contacto
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=323
PosicionInicialArriba=253
PosicionInicialAlturaCliente=490
PosicionInicialAncho=669
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Tipo, Info.SubTipo)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtoTipoCampoExtra
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
ListaOrden=CtoTipoCampoExtra.Orden<TAB>(Acendente)
FiltroGeneral=CtoTipoCampoExtra.Tipo=<T>{Info.Tipo}<T> AND<BR>CtoTipoCampoExtra.SubTipo=<T>{Info.SubTipo}<T>

[Lista.CtoTipoCampoExtra.CampoExtra]
Carpeta=Lista
Clave=CtoTipoCampoExtra.CampoExtra
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

[Lista.CtoTipoCampoExtra.Grupo]
Carpeta=Lista
Clave=CtoTipoCampoExtra.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtoTipoCampoExtra.Requerido]
Carpeta=Lista
Clave=CtoTipoCampoExtra.Requerido
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
AntesExpresiones=EjecutarSQL(<T>spCtoCampoExtraCrearVista :tTipo<T>, Info.Tipo)

[Lista.Columnas]
CampoExtra=172
Nombre=178
Grupo=199
Requerido=53
Orden=35

[Lista.CtoTipoCampoExtra.Orden]
Carpeta=Lista
Clave=CtoTipoCampoExtra.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CtoTipoCampoExtra.CampoExtra
CtoTipoCampoExtra.CampoExtra=CampoExtra.Nombre
CampoExtra.Nombre=CtoTipoCampoExtra.Grupo
CtoTipoCampoExtra.Grupo=CtoTipoCampoExtra.Requerido
CtoTipoCampoExtra.Requerido=CtoTipoCampoExtra.Orden
CtoTipoCampoExtra.Orden=(Fin)
