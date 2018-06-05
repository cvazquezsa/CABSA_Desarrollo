
[Forma]
Clave=UsuarioPerfilFormaD
Icono=0
Modulos=(Todos)
Nombre=Detalle del Perfil

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Perfil
PosicionInicialIzquierda=319
PosicionInicialArriba=116
PosicionInicialAlturaCliente=486
PosicionInicialAncho=728
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioPerfilFormaD
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
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=UsuarioPerfilFormaD.Perfil=<T>{Info.Perfil}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
[Lista.ListaEnCaptura]
(Inicio)=UsuarioPerfilFormaD.Forma
UsuarioPerfilFormaD.Forma=UsuarioPerfilFormaD.Estatus
UsuarioPerfilFormaD.Estatus=UsuarioPerfilFormaD.FormaVirtual
UsuarioPerfilFormaD.FormaVirtual=(Fin)

[Lista.UsuarioPerfilFormaD.Forma]
Carpeta=Lista
Clave=UsuarioPerfilFormaD.Forma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.UsuarioPerfilFormaD.Estatus]
Carpeta=Lista
Clave=UsuarioPerfilFormaD.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.UsuarioPerfilFormaD.FormaVirtual]
Carpeta=Lista
Clave=UsuarioPerfilFormaD.FormaVirtual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar Cambios
Cancelar Cambios=Cancelar
Cancelar=(Fin)


[Lista.Columnas]
Forma=265
Estatus=94
FormaVirtual=330









[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
