
[Forma]
Clave=MESMotivoRechazoLista
Icono=0
Modulos=(Todos)
Nombre=Motivo Rechazo Lista

ListaCarpetas=MESMotivoRechazo
CarpetaPrincipal=MESMotivoRechazo
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar/Aceptar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=545
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
[MESMotivoRechazo]
Estilo=Hoja
Clave=MESMotivoRechazo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MESMotivoRechazo
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

[MESMotivoRechazo.ListaEnCaptura]
(Inicio)=MESMotivoRechazo.Motivo
MESMotivoRechazo.Motivo=MESMotivoRechazo.Descripcion
MESMotivoRechazo.Descripcion=(Fin)

[MESMotivoRechazo.MESMotivoRechazo.Motivo]
Carpeta=MESMotivoRechazo
Clave=MESMotivoRechazo.Motivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

[MESMotivoRechazo.MESMotivoRechazo.Descripcion]
Carpeta=MESMotivoRechazo
Clave=MESMotivoRechazo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

[Acciones.Seleccionar/Aceptar]
Nombre=Seleccionar/Aceptar
Boton=23
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar/Aceptar
Activo=S
Visible=S

NombreEnBoton=S
[MESMotivoRechazo.Columnas]
Motivo=52
Descripcion=258
