[Forma]
Clave=CteBonificacion
Nombre=Bonificación Autómatica Multiple
Icono=0
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
Comentarios=Info.Cliente
PosicionInicialIzquierda=313
PosicionInicialArriba=234
PosicionInicialAlturaCliente=265
PosicionInicialAncho=588
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

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

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteBonificacion
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
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=CteBonificacion.Cliente=<T>{Info.Cliente}<T>

[Lista.CteBonificacion.Concepto]
Carpeta=Lista
Clave=CteBonificacion.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteBonificacion.Porcentaje]
Carpeta=Lista
Clave=CteBonificacion.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Concepto=304
Porcentaje=64
FechaD=94
FechaA=94

[Lista.CteBonificacion.FechaD]
Carpeta=Lista
Clave=CteBonificacion.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteBonificacion.FechaA]
Carpeta=Lista
Clave=CteBonificacion.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CteBonificacion.Concepto
CteBonificacion.Concepto=CteBonificacion.Porcentaje
CteBonificacion.Porcentaje=CteBonificacion.FechaD
CteBonificacion.FechaD=CteBonificacion.FechaA
CteBonificacion.FechaA=(Fin)
