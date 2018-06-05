
[Forma]
Clave=OportunidadCompetidorLista
Icono=4
Modulos=(Todos)
Nombre=Competidor
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Competidor
CarpetaPrincipal=Competidor
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=506
PosicionInicialArriba=201
PosicionInicialAlturaCliente=287
PosicionInicialAncho=354
ListaAcciones=Seleccionar






MovModulo=OPORT
[Competidor.Columnas]
Competidor=304











[Competidores.ListaEnCaptura]
(Inicio)=OportunidadCompetidor.Competidor
OportunidadCompetidor.Competidor=OportunidadCompetidor.NivelInteres
OportunidadCompetidor.NivelInteres=OportunidadCompetidor.ValorPropuesta
OportunidadCompetidor.ValorPropuesta=OportunidadCompetidor.Moneda
OportunidadCompetidor.Moneda=OportunidadCompetidor.Comentarios
OportunidadCompetidor.Comentarios=(Fin)


[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar Cambios
Cancelar Cambios=Cancelar
Cancelar=(Fin)


































[Competidor]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Competidores
Clave=Competidor
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadCompetidor
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=OportunidadCompetidor.Competidor
CarpetaVisible=S

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
[Competidor.OportunidadCompetidor.Competidor]
Carpeta=Competidor
Clave=OportunidadCompetidor.Competidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

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
