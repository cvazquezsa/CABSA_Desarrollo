[Forma]
Clave=ProvAutoCargos
Nombre=Bonificación Autómatica Multiple
Icono=0
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
Comentarios=Info.Proveedor
PosicionInicialIzquierda=253
PosicionInicialArriba=230
PosicionInicialAlturaProveedor=265
PosicionInicialAncho=589
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=273

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
Vista=ProvAutoCargos
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
FiltroGeneral=ProvAutoCargos.Proveedor=<T>{Info.Proveedor}<T>

[Lista.ProvAutoCargos.Concepto]
Carpeta=Lista
Clave=ProvAutoCargos.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProvAutoCargos.Porcentaje]
Carpeta=Lista
Clave=ProvAutoCargos.Porcentaje
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

[Lista.ProvAutoCargos.FechaD]
Carpeta=Lista
Clave=ProvAutoCargos.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProvAutoCargos.FechaA]
Carpeta=Lista
Clave=ProvAutoCargos.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=ProvAutoCargos.Concepto
ProvAutoCargos.Concepto=ProvAutoCargos.Porcentaje
ProvAutoCargos.Porcentaje=ProvAutoCargos.FechaD
ProvAutoCargos.FechaD=ProvAutoCargos.FechaA
ProvAutoCargos.FechaA=(Fin)
