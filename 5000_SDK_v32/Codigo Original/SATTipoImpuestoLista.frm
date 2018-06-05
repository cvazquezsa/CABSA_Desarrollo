[Forma]
Clave=SATTipoImpuestoLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Tipo de Impuesto
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=506
PosicionInicialArriba=124
PosicionInicialAlturaCliente=281
PosicionInicialAncho=425
ListaAcciones=Seleccionar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATTipoImpuesto
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

[Lista.SATTipoImpuesto.Clave]
Carpeta=Lista
Clave=SATTipoImpuesto.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SATTipoImpuesto.Descripcion]
Carpeta=Lista
Clave=SATTipoImpuesto.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
Clave=80
Descripcion=305






[Lista.ListaEnCaptura]
(Inicio)=SATTipoImpuesto.Clave
SATTipoImpuesto.Clave=SATTipoImpuesto.Descripcion
SATTipoImpuesto.Descripcion=(Fin)



[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)

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
