[Forma]
Clave=TipoCreditoLista
Nombre=Tipos Crédito
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=363
PosicionInicialArriba=293
PosicionInicialAlturaCliente=410
PosicionInicialAncho=553
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoCredito
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.TipoCredito.TipoCredito]
Carpeta=Lista
Clave=TipoCredito.TipoCredito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
TipoCredito=204
Descripcion=238
TipoTasa=104
TipoTasaBonificacion=110
Reciprocidad=81

[Lista.TipoCredito.Descripcion]
Carpeta=Lista
Clave=TipoCredito.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TipoCredito.Reciprocidad]
Carpeta=Lista
Clave=TipoCredito.Reciprocidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TipoCredito.TipoCredito
TipoCredito.TipoCredito=TipoCredito.Descripcion
TipoCredito.Descripcion=TipoCredito.Reciprocidad
TipoCredito.Reciprocidad=(Fin)
