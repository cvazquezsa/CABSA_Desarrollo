
[Forma]
Clave=ConceptoFEFondosLista
Icono=0
Modulos=(Todos)
Nombre=Concepto Flujo Efectivo Fondos

ListaCarpetas=lista
CarpetaPrincipal=lista
PosicionInicialAlturaCliente=273
PosicionInicialAncho=342
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaColor=Plata
PosicionInicialIzquierda=511
PosicionInicialArriba=211
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[lista]
Estilo=Hoja
Clave=lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ConceptoFEFondos
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=ConceptoFEFondos.ConceptoFEFondos

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
BusquedaAncho=20
BusquedaEnLinea=S
FuenteBusqueda={MS Sans Serif, 8, Negro, []}
[lista.ConceptoFEFondos.ConceptoFEFondos]
Carpeta=lista
Clave=ConceptoFEFondos.ConceptoFEFondos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[lista.Columnas]
ConceptoFEFondos=304

Clasificacion=304
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Seleccionar.Seleccionar]
Nombre=Seleccionar
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Acciones.Cerrar]
Nombre=Cerrar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S












[lista.ListaEnCaptura]
(Inicio)=ConceptoFEFondos.Clasificacion
ConceptoFEFondos.Clasificacion=ConceptoFEFondos.ConceptoFEFondos
ConceptoFEFondos.ConceptoFEFondos=(Fin)








[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Seleccionar
Seleccionar=Aceptar
Aceptar=(Fin)









[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cerrar
Cerrar=(Fin)
