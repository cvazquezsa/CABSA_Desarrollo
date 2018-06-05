[Forma]
Clave=FormaVirtualCampo
Nombre=Campos de la Forma Virtual
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=503
PosicionInicialArriba=311
PosicionInicialAlturaCliente=534
PosicionInicialAncho=913
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.FormaVirtual
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaVirtualCampo
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaAjustarColumnas=S
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=FormaVirtualCampo.FormaVirtual=<T>{Info.FormaVirtual}<T>

[Lista.FormaVirtualCampo.Vista]
Carpeta=Lista
Clave=FormaVirtualCampo.Vista
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.FormaVirtualCampo.Campo]
Carpeta=Lista
Clave=FormaVirtualCampo.Campo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[Lista.FormaVirtualCampo.Nombre]
Carpeta=Lista
Clave=FormaVirtualCampo.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[Lista.FormaVirtualCampo.Etiqueta]
Carpeta=Lista
Clave=FormaVirtualCampo.Etiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Vista=105
Campo=188
Nombre=199
Etiqueta=293
Invisible=44
Bloqueado=54
Visible=44
Activo=42

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

[Lista.FormaVirtualCampo.Visible]
Carpeta=Lista
Clave=FormaVirtualCampo.Visible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.FormaVirtualCampo.Activo]
Carpeta=Lista
Clave=FormaVirtualCampo.Activo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=FormaVirtualCampo.Vista
FormaVirtualCampo.Vista=FormaVirtualCampo.Campo
FormaVirtualCampo.Campo=FormaVirtualCampo.Nombre
FormaVirtualCampo.Nombre=FormaVirtualCampo.Etiqueta
FormaVirtualCampo.Etiqueta=FormaVirtualCampo.Visible
FormaVirtualCampo.Visible=FormaVirtualCampo.Activo
FormaVirtualCampo.Activo=(Fin)

[Lista.ListaOrden]
(Inicio)=FormaVirtualCampo.Vista<TAB>(Acendente)
FormaVirtualCampo.Vista<TAB>(Acendente)=FormaVirtualCampo.Campo<TAB>(Acendente)
FormaVirtualCampo.Campo<TAB>(Acendente)=(Fin)
