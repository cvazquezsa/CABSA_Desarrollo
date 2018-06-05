[Forma]
Clave=ListaNegraLista
Nombre=Lista Negra - Contactos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=275
PosicionInicialArriba=112
PosicionInicialAltura=537
PosicionInicialAncho=474
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
PosicionSeccion1=82
PosicionInicialAlturaCliente=510

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ListaNegra
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=30
BusquedaEnLinea=S
HojaMantenerSeleccion=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaAjustarColumnas=S

[Lista.ListaNegra.Nombre]
Carpeta=Lista
Clave=ListaNegra.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Nombre=292
Registro=144

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Datos]
Estilo=Ficha
Clave=Datos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ListaNegra
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ListaNegra.Datos
CarpetaVisible=S
AlinearTodaCarpeta=S

[Datos.ListaNegra.Datos]
Carpeta=Datos
Clave=ListaNegra.Datos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50x3
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaNegra.Registro]
Carpeta=Lista
Clave=ListaNegra.Registro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=ListaNegra.Nombre
ListaNegra.Nombre=ListaNegra.Registro
ListaNegra.Registro=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Datos
Datos=(Fin)
