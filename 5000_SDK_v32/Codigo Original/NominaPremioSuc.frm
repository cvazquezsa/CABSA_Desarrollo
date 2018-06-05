[Forma]
Clave=NominaPremioSuc
Nombre=Sucursales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Nombre
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=384
PosicionInicialArriba=304
PosicionInicialAlturaCliente=381
PosicionInicialAncho=607

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaPremioSuc
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
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaMantenerSeleccion=S
FiltroGeneral=NominaPremioSuc.ID={Info.ID}

[Lista.NominaPremioSuc.Sucursal]
Carpeta=Lista
Clave=NominaPremioSuc.Sucursal
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
Editar=S

[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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
Sucursal=48
Nombre=304
Meta=129
Premio=129
MetaCantidad=93

[Acciones.Premios]
Nombre=Premios
Boton=47
NombreEnBoton=S
NombreDesplegar=&Premios Sucursal
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NominaPremioSucAlcance
Antes=S
DespuesGuardar=S
Activo=S
AntesExpresiones=Asigna(Info.Sucursal, NominaPremioSuc:NominaPremioSuc.Sucursal)<BR>Asigna(Info.Descripcion, NominaPremioSuc:Sucursal.Nombre)
VisibleCondicion=Info.Nivel=<T>Encargado<T>

[Lista.NominaPremioSuc.Meta]
Carpeta=Lista
Clave=NominaPremioSuc.Meta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaPremioSuc.MetaCantidad]
Carpeta=Lista
Clave=NominaPremioSuc.MetaCantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Premios
Premios=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=NominaPremioSuc.Sucursal
NominaPremioSuc.Sucursal=Sucursal.Nombre
Sucursal.Nombre=NominaPremioSuc.Meta
NominaPremioSuc.Meta=NominaPremioSuc.MetaCantidad
NominaPremioSuc.MetaCantidad=(Fin)
