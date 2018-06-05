[Forma]
Clave=CteCtoComites
Nombre=Comités del Contacto
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Nombre
PosicionInicialIzquierda=157
PosicionInicialArriba=163
PosicionInicialAlturaCliente=408
PosicionInicialAncho=709
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteCtoComites
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
FiltroGeneral=CteCtoComites.Cliente=<T>{Info.Cliente}<T> AND CteCtoComites.ID={Info.ID}

[Lista.CteCtoComites.Comite]
Carpeta=Lista
Clave=CteCtoComites.Comite
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteCtoComites.Cargo]
Carpeta=Lista
Clave=CteCtoComites.Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
Comite=222
Cargo=248
SubComite=208

[Lista.CteCtoComites.SubComite]
Carpeta=Lista
Clave=CteCtoComites.SubComite
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CteCtoComites.Comite
CteCtoComites.Comite=CteCtoComites.SubComite
CteCtoComites.SubComite=CteCtoComites.Cargo
CteCtoComites.Cargo=(Fin)
