[Forma]
Clave=PeriodoTipoMovEmpresa
Nombre=por Movimiento/Empresa
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=318
PosicionInicialArriba=230
PosicionInicialAlturaCliente=273
PosicionInicialAncho=388
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.PeriodoTipo

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PeriodoTipoMovEmpresa
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
FiltroGeneral=PeriodoTipoMovEmpresa.PeriodoTipo=<T>{Info.PeriodoTipo}<T>

[Lista.PeriodoTipoMovEmpresa.Mov]
Carpeta=Lista
Clave=PeriodoTipoMovEmpresa.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PeriodoTipoMovEmpresa.UltimoDiaPagado]
Carpeta=Lista
Clave=PeriodoTipoMovEmpresa.UltimoDiaPagado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mov=186
UltimoDiaPagado=104
Empresa=66

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

[Lista.PeriodoTipoMovEmpresa.Empresa]
Carpeta=Lista
Clave=PeriodoTipoMovEmpresa.Empresa
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=PeriodoTipoMovEmpresa.Mov
PeriodoTipoMovEmpresa.Mov=PeriodoTipoMovEmpresa.Empresa
PeriodoTipoMovEmpresa.Empresa=PeriodoTipoMovEmpresa.UltimoDiaPagado
PeriodoTipoMovEmpresa.UltimoDiaPagado=(Fin)
