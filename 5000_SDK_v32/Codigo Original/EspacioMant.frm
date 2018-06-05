[Forma]
Clave=EspacioMant
Nombre=Mantenimientos Preventivos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=213
PosicionInicialArriba=191
PosicionInicialAlturaCliente=351
PosicionInicialAncho=597
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Espacio

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EspacioMant
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
FiltroGrupo1=EspacioMant.Mantenimiento
FiltroGrupo2=EspacioMant.Tipo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=EspacioMant.Espacio=<T>{Info.Espacio}<T>

[Lista.EspacioMant.Mantenimiento]
Carpeta=Lista
Clave=EspacioMant.Mantenimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mantenimiento=154
Tipo=96
Kms=97
MantenimientoKms=159
MantenimientoFecha=139
Servicio=203
Fecha=111

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
GuardarAntes=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Lista.EspacioMant.Servicio]
Carpeta=Lista
Clave=EspacioMant.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioMant.Kms]
Carpeta=Lista
Clave=EspacioMant.Kms
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioMant.Fecha]
Carpeta=Lista
Clave=EspacioMant.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=EspacioMant.Mantenimiento
EspacioMant.Mantenimiento=EspacioMant.Servicio
EspacioMant.Servicio=EspacioMant.Fecha
EspacioMant.Fecha=EspacioMant.Kms
EspacioMant.Kms=(Fin)

[Lista.ListaOrden]
(Inicio)=EspacioMant.Fecha<TAB>(Acendente)
EspacioMant.Fecha<TAB>(Acendente)=EspacioMant.Kms<TAB>(Acendente)
EspacioMant.Kms<TAB>(Acendente)=(Fin)
