
[Forma]
Clave=MESMotivoRechazo
Icono=0
CarpetaPrincipal=MESMotivoRechazo
Modulos=(Todos)
Nombre=Motivo Rechazo

ListaCarpetas=MESMotivoRechazo
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=390
PosicionInicialArriba=245
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
PermiteEditar=S
ListaEnCaptura=(Lista)


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

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S


[MESMotivoRechazo.Columnas]
Motivo=88
Descripcion=289


[MESMotivoRechazo.ListaEnCaptura]
(Inicio)=MESMotivoRechazo.Motivo
MESMotivoRechazo.Motivo=MESMotivoRechazo.Descripcion
MESMotivoRechazo.Descripcion=(Fin)















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Registro Eliminar
Registro Eliminar=(Fin)
