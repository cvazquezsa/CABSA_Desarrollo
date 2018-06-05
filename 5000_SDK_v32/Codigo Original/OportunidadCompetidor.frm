
[Forma]
Clave=OportunidadCompetidor
Icono=4
Modulos=(Todos)
Nombre=Competidores
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Competidor
CarpetaPrincipal=Competidor
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=468
PosicionInicialArriba=201
PosicionInicialAlturaCliente=287
PosicionInicialAncho=343
ListaAcciones=(Lista)






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
PermiteEditar=S
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










[Acciones.Excel]
Nombre=Excel
Boton=67
NombreEnBoton=S
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S



























































































































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)
