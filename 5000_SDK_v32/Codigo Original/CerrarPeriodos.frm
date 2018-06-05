[Forma]
Clave=CerrarPeriodos
Nombre=Cerrar Periodos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=469
PosicionInicialArriba=381
PosicionInicialAltura=254
PosicionInicialAncho=342
Comentarios=Lista(Info.Empresa, Info.Modulo)
PosicionInicialAlturaCliente=227

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CerrarPeriodo
Fuente={MS Sans Serif, 8, Negro, []}
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
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=CerrarPeriodo.Empresa=<T>{Info.Empresa}<T> AND <BR>CerrarPeriodo.Rama=<T>{Info.Modulo}<T>

[Lista.CerrarPeriodo.Ejercicio]
Carpeta=Lista
Clave=CerrarPeriodo.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CerrarPeriodo.Periodo]
Carpeta=Lista
Clave=CerrarPeriodo.Periodo
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

[Lista.Columnas]
Ejercicio=84
Periodo=74

[Acciones.CancelarMov]
Nombre=CancelarMov
Boton=30
NombreEnBoton=S
NombreDesplegar=&Permitir Cancelar
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgCancelarMov
Activo=S
Visible=S
EspacioPrevio=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CancelarMov
CancelarMov=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CerrarPeriodo.Ejercicio
CerrarPeriodo.Ejercicio=CerrarPeriodo.Periodo
CerrarPeriodo.Periodo=(Fin)
