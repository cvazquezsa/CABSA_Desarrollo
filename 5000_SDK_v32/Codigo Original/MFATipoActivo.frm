
[Forma]
Clave=MFATipoActivo
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=MFA - Tipos de Activo Fijo
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=MFATipoActivo
CarpetaPrincipal=MFATipoActivo
PosicionInicialIzquierda=441
PosicionInicialArriba=161
PosicionInicialAlturaCliente=367
PosicionInicialAncho=483
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[MFATipoActivo]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=MFATipoActivo
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFATipoActivo
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

ListaOrden=MFATipoActivo.Tipo<TAB>(Acendente)
CarpetaVisible=S
[MFATipoActivo.ListaEnCaptura]
(Inicio)=MFATipoActivo.Tipo
MFATipoActivo.Tipo=MFATipoActivo.Descripcion
MFATipoActivo.Descripcion=(Fin)

[MFATipoActivo.MFATipoActivo.Tipo]
Carpeta=MFATipoActivo
Clave=MFATipoActivo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MFATipoActivo.MFATipoActivo.Descripcion]
Carpeta=MFATipoActivo
Clave=MFATipoActivo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[MFATipoActivo.Columnas]
Tipo=56
Descripcion=366
