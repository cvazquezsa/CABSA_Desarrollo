[Forma]
Clave=mcModuloMov
Nombre=Movimientos del Módulo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=819
PosicionInicialArriba=341
PosicionInicialAlturaCliente=481
PosicionInicialAncho=282
Comentarios=Info.Modulo
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=mcModuloMov
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=mcModuloMov.Mov
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaMantenerSeleccion=S
FiltroGeneral=mcModuloMov.Modulo=<T>{Info.Modulo}<T>

[Lista.mcModuloMov.Mov]
Carpeta=Lista
Clave=mcModuloMov.Mov
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
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S

[Lista.Columnas]
Mov=245

[Acciones.Poliza]
Nombre=Poliza
Boton=47
NombreEnBoton=S
NombreDesplegar=&Póliza
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=mcModuloMovPoliza
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(mcModuloMov:mcModuloMov.Mov)
AntesExpresiones=Asigna(Info.Mov, mcModuloMov:mcModuloMov.Mov)<BR>MC.TablaPost(<T>mcModuloMov<T>, <T>mcModuloMov.Modulo=<T>+Comillas(Info.Modulo))

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Poliza
Poliza=(Fin)
