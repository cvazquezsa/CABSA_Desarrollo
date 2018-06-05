[Forma]
Clave=ServicioTipoOrden
Nombre=Tipos de Ordenes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=454
PosicionInicialArriba=297
PosicionInicialAlturaCliente=396
PosicionInicialAncho=372
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ServicioTipoOrden
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

[Lista.ServicioTipoOrden.TipoOrden]
Carpeta=Lista
Clave=ServicioTipoOrden.TipoOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioTipoOrden.ListaPreciosEsp]
Carpeta=Lista
Clave=ServicioTipoOrden.ListaPreciosEsp
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
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
TipoOrden=228
Clave=98
ListaPreciosEsp=114

[Lista.ListaEnCaptura]
(Inicio)=ServicioTipoOrden.TipoOrden
ServicioTipoOrden.TipoOrden=ServicioTipoOrden.ListaPreciosEsp
ServicioTipoOrden.ListaPreciosEsp=(Fin)
