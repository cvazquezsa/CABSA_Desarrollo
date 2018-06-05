[Forma]
Clave=TipoCredito
Nombre=Tipos Crédito
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=255
PosicionInicialArriba=293
PosicionInicialAlturaCliente=410
PosicionInicialAncho=769
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
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

[Lista.TipoCredito.TipoTasa]
Carpeta=Lista
Clave=TipoCredito.TipoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TipoCredito.TipoTasaBonificacion]
Carpeta=Lista
Clave=TipoCredito.TipoTasaBonificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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

[Lista.ListaEnCaptura]
(Inicio)=TipoCredito.TipoCredito
TipoCredito.TipoCredito=TipoCredito.Descripcion
TipoCredito.Descripcion=TipoCredito.TipoTasa
TipoCredito.TipoTasa=TipoCredito.TipoTasaBonificacion
TipoCredito.TipoTasaBonificacion=TipoCredito.Reciprocidad
TipoCredito.Reciprocidad=(Fin)
