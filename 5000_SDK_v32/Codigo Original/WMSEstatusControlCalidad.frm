
[Forma]
Clave=WMSEstatusControlCalidad
Icono=67
Modulos=(Todos)
Nombre=Control de Calidad Estatus

ListaCarpetas=WMSEstatusControlCalidad
CarpetaPrincipal=WMSEstatusControlCalidad
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=513
PosicionInicialArriba=120
PosicionInicialAlturaCliente=449
PosicionInicialAncho=339
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaBloquearAjuste=S
VentanaEstadoInicial=Normal
ListaAcciones=Guardar
Comentarios=Empresa.Nombre
[WMSEstatusControlCalidad]
Estilo=Hoja
Clave=WMSEstatusControlCalidad
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSEstatusControlCalidad
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
[WMSEstatusControlCalidad.ListaEnCaptura]
(Inicio)=WMSEstatusControlCalidad.EstatusControlCalidad
WMSEstatusControlCalidad.EstatusControlCalidad=WMSEstatusControlCalidad.Estatus
WMSEstatusControlCalidad.Estatus=(Fin)

[WMSEstatusControlCalidad.WMSEstatusControlCalidad.EstatusControlCalidad]
Carpeta=WMSEstatusControlCalidad
Clave=WMSEstatusControlCalidad.EstatusControlCalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[WMSEstatusControlCalidad.WMSEstatusControlCalidad.Estatus]
Carpeta=WMSEstatusControlCalidad
Clave=WMSEstatusControlCalidad.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[WMSEstatusControlCalidad.Columnas]
EstatusControlCalidad=139
Estatus=130

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
