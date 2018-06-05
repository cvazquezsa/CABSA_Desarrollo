
[Forma]
Clave=SAUXArtServicioLista
Icono=0
Nombre=Servicios
MovModulo=SAUX

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=273
PosicionInicialAncho=503
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=548
PosicionInicialArriba=294
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
Comentarios=Lista(Info.Articulo, Info.Descripcion)
[Ficha]
Estilo=Hoja
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SAUXArtServicioLista
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ListaEnCaptura=(Lista)


[Ficha.Clave]
Carpeta=Ficha
Clave=Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Descripcion]
Carpeta=Ficha
Clave=Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Ficha.Columnas]
Clave=124
Descripcion=331

[Ficha.ListaEnCaptura]
(Inicio)=Clave
Clave=Descripcion
Descripcion=(Fin)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
