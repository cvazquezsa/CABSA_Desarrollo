
[Forma]
Clave=ConceptoFEFondos
Icono=0
Modulos=(Todos)
Nombre=Concepto Flujo Efectivo Fondos

ListaCarpetas=Lista
CarpetaPrincipal=Lista
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
[Lista]
Estilo=Hoja
Clave=Lista
BusquedaRapidaControles=S
PermiteEditar=S
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
CarpetaVisible=S
ListaEnCaptura=ConceptoFEFondos.ConceptoFEFondos

[Lista.ConceptoFEFondos.ConceptoFEFondos]
Carpeta=Lista
Clave=ConceptoFEFondos.ConceptoFEFondos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
ConceptoFEFondos=304

Clasificacion=304
0=207
Cuenta=128
[Acciones.Guardar]
Nombre=Guardar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S
































[Acciones.Clasificacion]
Nombre=Clasificacion
Boton=93
NombreEnBoton=S
NombreDesplegar=Clasificación
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ClasificacionConcFEFondos
Activo=S
Visible=S
























[Lista.ListaEnCaptura]
(Inicio)=ConceptoFEFondos.Clasificacion
ConceptoFEFondos.Clasificacion=ConceptoFEFondos.ConceptoFEFondos
ConceptoFEFondos.ConceptoFEFondos=ConceptoFEFondos.Cuenta
ConceptoFEFondos.Cuenta=(Fin)









[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cancelar
Cancelar=Clasificacion
Clasificacion=(Fin)
