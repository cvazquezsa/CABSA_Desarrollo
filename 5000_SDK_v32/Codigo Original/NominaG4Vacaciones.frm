
[Forma]
Clave=NominaG4Vacaciones
Icono=0
Modulos=(Todos)
Nombre=Vacaciones

ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=273
PosicionInicialAncho=440
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
PosicionInicialIzquierda=463
PosicionInicialArriba=208
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaG4Vacaciones
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
[Lista.ListaEnCaptura]
(Inicio)=NominaG4Vacaciones.TipoSindicato
NominaG4Vacaciones.TipoSindicato=NominaG4Vacaciones.Descripcion
NominaG4Vacaciones.Descripcion=(Fin)

[Lista.NominaG4Vacaciones.TipoSindicato]
Carpeta=Lista
Clave=NominaG4Vacaciones.TipoSindicato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.NominaG4Vacaciones.Descripcion]
Carpeta=Lista
Clave=NominaG4Vacaciones.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Lista.Columnas]
TipoSindicato=154
Descripcion=242

[Acciones.Detalle]
Nombre=Detalle
Boton=18
NombreEnBoton=S
NombreDesplegar=Detalle
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NominaG4VacacionesD
Activo=S
Antes=S
DespuesGuardar=S
Visible=S





EspacioPrevio=S
AntesExpresiones=Asigna( Info.ABC, NominaG4Vacaciones:NominaG4Vacaciones.TipoSindicato )






[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Detalle
Detalle=(Fin)
