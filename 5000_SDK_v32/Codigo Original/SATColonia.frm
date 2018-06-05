[Forma]
Clave=SATColonia
Nombre=Catálogo de Colonias
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

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ListaAcciones=Cerrar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATColonia
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
ListaOrden=SATColonia.ClaveColonia<TAB>(Acendente)






[Lista.Columnas]
LimiteInferior=102
LimiteSuperior=98
Cuota=87
Porcentaje=59
TablaImpuesto=96
PeriodoTipo=82
Fecha=122

ClaveColonia=101
ClaveCP=126
Descripcion=229
ClaveEstado=82
ClaveMunicipio=94
ClaveLocalidad=96
HusoHorario=78
VeranoMesInicio=99
VeranoDiaInicio=116
VeranoHoraInicio=104
VeranoDiferenciaHoraria=139
InviernoMesInicio=101
InviernoDiaInicio=105
InviernoHoraInicio=108
InviernoDiferenciaHoraria=139


[Lista.SATColonia.ClaveColonia]
Carpeta=Lista
Clave=SATColonia.ClaveColonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.SATColonia.ClaveCP]
Carpeta=Lista
Clave=SATColonia.ClaveCP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.SATColonia.Descripcion]
Carpeta=Lista
Clave=SATColonia.Descripcion
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

[Lista.ListaEnCaptura]
(Inicio)=SATColonia.ClaveColonia
SATColonia.ClaveColonia=SATColonia.ClaveCP
SATColonia.ClaveCP=SATColonia.Descripcion
SATColonia.Descripcion=(Fin)

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
