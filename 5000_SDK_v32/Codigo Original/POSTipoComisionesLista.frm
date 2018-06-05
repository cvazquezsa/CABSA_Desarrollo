
[Forma]
Clave=POSTipoComisionesLista
Icono=0
Modulos=(Todos)
Nombre=Lista tipos de comisiones

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialIzquierda=542
PosicionInicialArriba=272
PosicionInicialAlturaCliente=146
PosicionInicialAncho=281
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaColor=Negro
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSTipoComisiones
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

CarpetaVisible=S

ListaEnCaptura=(Lista)
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.Columnas]
IdTipoCobroComision=105
TipoCobroComision=169

IdTipoComision=76
TipoComision=110
[Lista.ListaEnCaptura]
(Inicio)=POSTipoComisiones.IdTipoComision
POSTipoComisiones.IdTipoComision=POSTipoComisiones.TipoComision
POSTipoComisiones.TipoComision=(Fin)

[Lista.POSTipoComisiones.IdTipoComision]
Carpeta=Lista
Clave=POSTipoComisiones.IdTipoComision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.POSTipoComisiones.TipoComision]
Carpeta=Lista
Clave=POSTipoComisiones.TipoComision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
