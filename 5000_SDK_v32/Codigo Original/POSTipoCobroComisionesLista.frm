
[Forma]
Clave=POSTipoCobroComisionesLista
Icono=0
Modulos=(Todos)
Nombre=Lista tipos de cobro de comisiones

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=153
PosicionInicialAncho=331
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaColor=Negro
PosicionInicialIzquierda=517
PosicionInicialArriba=268
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSTipoCobroComisiones
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

[Lista.POSTipoCobroComisiones.IdTipoCobroComision]
Carpeta=Lista
Clave=POSTipoCobroComisiones.IdTipoCobroComision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.POSTipoCobroComisiones.TipoCobroComision]
Carpeta=Lista
Clave=POSTipoCobroComisiones.TipoCobroComision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
IdTipoCobroComision=35
TipoCobroComision=168

[Lista.ListaEnCaptura]
(Inicio)=POSTipoCobroComisiones.IdTipoCobroComision
POSTipoCobroComisiones.IdTipoCobroComision=POSTipoCobroComisiones.TipoCobroComision
POSTipoCobroComisiones.TipoCobroComision=(Fin)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
NombreEnBoton=S
