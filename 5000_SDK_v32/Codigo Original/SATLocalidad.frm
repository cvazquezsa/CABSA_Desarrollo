[Forma]
Clave=SATLocalidad
Nombre=Catálogo de Localidades
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=432
PosicionInicialArriba=134
PosicionInicialAltura=346
PosicionInicialAncho=501
PosicionInicialAlturaCliente=421

ListaAcciones=Cerrar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATLocalidad
Fuente={MS Sans Serif, 8, Negro, []}
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
OtroOrden=S
ListaOrden=(Lista)






[Lista.Columnas]
LimiteInferior=102
LimiteSuperior=98
Cuota=87
Porcentaje=59
TablaImpuesto=96
PeriodoTipo=82
Fecha=95

ClaveLocalidad=90
ClaveEstado=89
Descripcion=220

[Lista.SATLocalidad.ClaveLocalidad]
Carpeta=Lista
Clave=SATLocalidad.ClaveLocalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.SATLocalidad.ClaveEstado]
Carpeta=Lista
Clave=SATLocalidad.ClaveEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco

[Lista.SATLocalidad.Descripcion]
Carpeta=Lista
Clave=SATLocalidad.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=SATLocalidad.ClaveLocalidad
SATLocalidad.ClaveLocalidad=SATLocalidad.ClaveEstado
SATLocalidad.ClaveEstado=SATLocalidad.Descripcion
SATLocalidad.Descripcion=(Fin)

[Lista.ListaOrden]
(Inicio)=SATLocalidad.ClaveEstado	(Acendente)
SATLocalidad.ClaveEstado	(Acendente)=SATLocalidad.ClaveLocalidad	(Acendente)
SATLocalidad.ClaveLocalidad	(Acendente)=(Fin)
