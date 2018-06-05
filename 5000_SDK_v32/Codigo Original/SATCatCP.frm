[Forma]
Clave=SATCatCP
Nombre=Catálogo de Códigos Postales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=252
PosicionInicialArriba=134
PosicionInicialAltura=346
PosicionInicialAncho=862
PosicionInicialAlturaCliente=421

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATCatCP
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
ListaOrden=SATCatCP.ClaveCP<TAB>(Acendente)






[Lista.Columnas]
LimiteInferior=102
LimiteSuperior=98
Cuota=87
Porcentaje=59
TablaImpuesto=96
PeriodoTipo=82
Fecha=122

ClaveCP=85
ClaveEstado=91
ClaveMunicipio=92
ClaveLocalidad=90
HusoHorario=83
Descripcion=95
VeranoMesInicio=88
VeranoDiaInicio=98
VeranoHoraInicio=92
VeranoDiferenciaHoraria=127
InviernoMesInicio=102
InviernoDiaInicio=105
InviernoHoraInicio=98
InviernoDiferenciaHoraria=133
ClavePais=143

[Lista.SATCatCP.ClaveCP]
Carpeta=Lista
Clave=SATCatCP.ClaveCP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.SATCatCP.ClaveEstado]
Carpeta=Lista
Clave=SATCatCP.ClaveEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco

[Lista.SATCatCP.ClaveMunicipio]
Carpeta=Lista
Clave=SATCatCP.ClaveMunicipio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco

[Lista.SATCatCP.ClaveLocalidad]
Carpeta=Lista
Clave=SATCatCP.ClaveLocalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Lista.SATCatCP.HusoHorario]
Carpeta=Lista
Clave=SATCatCP.HusoHorario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Lista.SATCatCP.Descripcion]
Carpeta=Lista
Clave=SATCatCP.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.SATCatCP.VeranoMesInicio]
Carpeta=Lista
Clave=SATCatCP.VeranoMesInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.SATCatCP.VeranoDiaInicio]
Carpeta=Lista
Clave=SATCatCP.VeranoDiaInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SATCatCP.VeranoHoraInicio]
Carpeta=Lista
Clave=SATCatCP.VeranoHoraInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.SATCatCP.VeranoDiferenciaHoraria]
Carpeta=Lista
Clave=SATCatCP.VeranoDiferenciaHoraria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Lista.SATCatCP.InviernoMesInicio]
Carpeta=Lista
Clave=SATCatCP.InviernoMesInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.SATCatCP.InviernoDiaInicio]
Carpeta=Lista
Clave=SATCatCP.InviernoDiaInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SATCatCP.InviernoHoraInicio]
Carpeta=Lista
Clave=SATCatCP.InviernoHoraInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.SATCatCP.InviernoDiferenciaHoraria]
Carpeta=Lista
Clave=SATCatCP.InviernoDiferenciaHoraria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco













[Lista.ListaOrden]
(Inicio)=SATCatCP.ClaveEstado	(Acendente)
SATCatCP.ClaveEstado	(Acendente)=SATCatCP.ClaveMunicipio	(Acendente)
SATCatCP.ClaveMunicipio	(Acendente)=SATCatCP.ClaveCP	(Acendente)
SATCatCP.ClaveCP	(Acendente)=(Fin)




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
(Inicio)=SATCatCP.ClaveCP
SATCatCP.ClaveCP=SATCatCP.ClaveEstado
SATCatCP.ClaveEstado=SATCatCP.ClaveMunicipio
SATCatCP.ClaveMunicipio=SATCatCP.ClaveLocalidad
SATCatCP.ClaveLocalidad=SATCatCP.HusoHorario
SATCatCP.HusoHorario=SATCatCP.Descripcion
SATCatCP.Descripcion=SATCatCP.VeranoMesInicio
SATCatCP.VeranoMesInicio=SATCatCP.VeranoDiaInicio
SATCatCP.VeranoDiaInicio=SATCatCP.VeranoHoraInicio
SATCatCP.VeranoHoraInicio=SATCatCP.VeranoDiferenciaHoraria
SATCatCP.VeranoDiferenciaHoraria=SATCatCP.InviernoMesInicio
SATCatCP.InviernoMesInicio=SATCatCP.InviernoDiaInicio
SATCatCP.InviernoDiaInicio=SATCatCP.InviernoHoraInicio
SATCatCP.InviernoHoraInicio=SATCatCP.InviernoDiferenciaHoraria
SATCatCP.InviernoDiferenciaHoraria=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Historico
Historico=(Fin)
