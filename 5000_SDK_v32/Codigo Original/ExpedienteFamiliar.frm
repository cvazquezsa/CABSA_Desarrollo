[Forma]
Clave=ExpedienteFamiliar
Nombre=Expedientes Familiares
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=469
PosicionInicialArriba=284
PosicionInicialAlturaCliente=447
PosicionInicialAncho=676
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ExpedienteFamiliar
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)

[Lista.ExpedienteFamiliar.ExpedienteFamiliar]
Carpeta=Lista
Clave=ExpedienteFamiliar.ExpedienteFamiliar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ExpedienteFamiliar.Nombre]
Carpeta=Lista
Clave=ExpedienteFamiliar.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ExpedienteFamiliar.Estatus]
Carpeta=Lista
Clave=ExpedienteFamiliar.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S

[Lista.Columnas]
ExpedienteFamiliar=124
Nombre=435
Estatus=86

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ActivoCondicion=no ExpedienteFamiliar:ExpedienteFamiliar.TieneMovimientos

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Eliminar
Eliminar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ExpedienteFamiliar.ExpedienteFamiliar
ExpedienteFamiliar.ExpedienteFamiliar=ExpedienteFamiliar.Nombre
ExpedienteFamiliar.Nombre=ExpedienteFamiliar.Estatus
ExpedienteFamiliar.Estatus=(Fin)
