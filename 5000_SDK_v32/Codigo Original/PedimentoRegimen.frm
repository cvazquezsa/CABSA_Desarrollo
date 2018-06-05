[Forma]
Clave=PedimentoRegimen
Nombre=Regimenes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=350
PosicionInicialArriba=293
PosicionInicialAlturaCliente=411
PosicionInicialAncho=469
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PedimentoRegimen
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

[Lista.PedimentoRegimen.PedimentoRegimen]
Carpeta=Lista
Clave=PedimentoRegimen.PedimentoRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PedimentoRegimen.Descripcion]
Carpeta=Lista
Clave=PedimentoRegimen.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
PedimentoRegimen=63
Descripcion=377
Temporalidad=111

[Lista.ListaEnCaptura]
(Inicio)=PedimentoRegimen.PedimentoRegimen
PedimentoRegimen.PedimentoRegimen=PedimentoRegimen.Descripcion
PedimentoRegimen.Descripcion=(Fin)
