[Forma]
Clave=WebPaginaTipoEvento
Nombre=Tipos Eventos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=619
PosicionInicialArriba=351
PosicionInicialAlturaCliente=461
PosicionInicialAncho=681
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaTipoEvento
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
ListaOrden=WebPaginaTipoEvento.Numero<TAB>(Acendente)
CarpetaVisible=S

[Lista.WebPaginaTipoEvento.Tipo]
Carpeta=Lista
Clave=WebPaginaTipoEvento.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaTipoEvento.Numero]
Carpeta=Lista
Clave=WebPaginaTipoEvento.Numero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.WebPaginaTipoEvento.Color]
Carpeta=Lista
Clave=WebPaginaTipoEvento.Color
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
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Tipo=304
Numero=64
Color=274

[Lista.ListaEnCaptura]
(Inicio)=WebPaginaTipoEvento.Tipo
WebPaginaTipoEvento.Tipo=WebPaginaTipoEvento.Color
WebPaginaTipoEvento.Color=WebPaginaTipoEvento.Numero
WebPaginaTipoEvento.Numero=(Fin)
