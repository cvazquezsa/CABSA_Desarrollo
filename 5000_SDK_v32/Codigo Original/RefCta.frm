[Forma]
Clave=RefCta
Nombre=Referencias
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=220
PosicionInicialArriba=295
PosicionInicialAlturaCliente=399
PosicionInicialAncho=839
Comentarios=Lista(Info.Cuenta, Info.Nombre)

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RefCta
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
FiltroGeneral=RefCta.Rama=<T>{Info.Rama}<T> AND RefCta.Cuenta=<T>{Info.Cuenta}<T>

[Lista.RefCta.Tipo]
Carpeta=Lista
Clave=RefCta.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RefCta.Referencia]
Carpeta=Lista
Clave=RefCta.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RefCta.Fecha]
Carpeta=Lista
Clave=RefCta.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RefCta.Estado]
Carpeta=Lista
Clave=RefCta.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
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
Tipo=112
Referencia=157
Fecha=76
Almacen=99
Estado=100
Nombre=133
Telefonos=96
Observaciones=130

[Lista.RefCta.Nombre]
Carpeta=Lista
Clave=RefCta.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RefCta.Telefonos]
Carpeta=Lista
Clave=RefCta.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RefCta.Observaciones]
Carpeta=Lista
Clave=RefCta.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=RefCta.Tipo
RefCta.Tipo=RefCta.Referencia
RefCta.Referencia=RefCta.Fecha
RefCta.Fecha=RefCta.Nombre
RefCta.Nombre=RefCta.Telefonos
RefCta.Telefonos=RefCta.Observaciones
RefCta.Observaciones=RefCta.Estado
RefCta.Estado=(Fin)
