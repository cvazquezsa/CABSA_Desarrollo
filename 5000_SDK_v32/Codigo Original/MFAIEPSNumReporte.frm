
[Forma]
Clave=MFAIEPSNumReporte
Icono=0
Modulos=(Todos)
Nombre=MFA - Número Reporte IEPS

ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=Lista
PosicionInicialIzquierda=258
PosicionInicialArriba=108
PosicionInicialAlturaCliente=491
PosicionInicialAncho=764
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAIEPSNumReporte
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
PestanaOtroNombre=S
PestanaNombre=Registros

[Lista.MFAIEPSNumReporte.NumReporte]
Carpeta=Lista
Clave=MFAIEPSNumReporte.NumReporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFAIEPSNumReporte.Descripcion]
Carpeta=Lista
Clave=MFAIEPSNumReporte.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

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

[Lista.ListaEnCaptura]
(Inicio)=MFAIEPSNumReporte.NumReporte
MFAIEPSNumReporte.NumReporte=MFAIEPSNumReporte.Descripcion
MFAIEPSNumReporte.Descripcion=(Fin)

[Lista.Columnas]
NumReporte=124
Descripcion=604
