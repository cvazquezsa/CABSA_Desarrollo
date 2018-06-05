[Forma]
Clave=vic_Plano2
Nombre=Planogramas
Icono=47
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=519
PosicionInicialArriba=264
PosicionInicialAltura=504
PosicionInicialAncho=881
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=453

MovModulo=(Todos)
Menus=S
PosicionSec1=347
VentanaEstadoInicial=Normal
MenuPrincipal=&Maestros
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Planograma
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=vic_Plano
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=vic_PlanoCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=vic_PlanoFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=vic_PlanoGrp
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=25
FiltroListasRama=CXC
FiltroRespetar=S
FiltroTipo=Múltiple (por grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=25
BusquedaEnLinea=S
CarpetaVisible=S
FiltroTodo=S
FiltroTodoFinal=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
OtroOrden=S
ListaOrden=(Lista)
MenuLocal=S
PermiteLocalizar=S



ListaAcciones=(Lista)
FiltroListasAplicaEn=vic_Plano.Plano
FiltroAplicaEn1=vic_PlanoCat.Categoria
FiltroAplicaEn2=vic_PlanoFam.Familia
FiltroAplicaEn3=vic_PlanoGrp.Grupo
IconosConPaginas=S
ElementosPorPaginaEsp=200
FuenteBusqueda={MS Sans Serif, 8, Negro, []}
IconosNombre=vic_Plano:vic_Plano.Plano
[Lista.Columnas]
0=99
1=121
2=180

3=153
4=-2
TipoPlano=304
5=-2
6=-2
Familia=233
Categoria=304
Grupo=304
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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S


[Acciones.LocalCteInfo]
Nombre=LocalCteInfo
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Información
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Cte:Cte.Cliente)
AntesExpresiones=Asigna(Info.Cliente, Cte:Cte.Cliente)

[Acciones.LocalImprimir]
Nombre=LocalImprimir
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.LocalPreliminar]
Nombre=LocalPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F11

[Acciones.LocalExcel]
Nombre=LocalExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.LocalCampos]
Nombre=LocalCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S


[Acciones.LocalMovCte]
Nombre=LocalMovCte
Boton=0
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=Generar Movimientos...
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovCte
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=Usuario.CteMov
EjecucionCondicion=ConDatos(Cte:Cte.Cliente)
AntesExpresiones=Asigna(Info.Cliente, Cte:Cte.Cliente)<BR>Asigna(Info.Nombre, Cte:Cte.Nombre)


[Acciones.LocalEditarCliente]
Nombre=LocalEditarCliente
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=&Editar Datos Cliente
EnMenu=S
TipoAccion=Formas
ClaveAccion=VentaCte
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
ActivoCondicion=Usuario.ModificarDatosCliente
EjecucionCondicion=ConDatos(Cte:Cte.Cliente)
AntesExpresiones=Asigna(Info.Cliente, Cte:Cte.Cliente)


[Acciones.LocalMapaTodo]
Nombre=LocalMapaTodo
Boton=0
NombreDesplegar=Ver Mapa (&Todos)
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Mapa.Borrar<BR>RegistrarListaSt(<T>Lista<T>, <T>Cte.Cliente<T>)<BR>Mapa.AgregarListaSt(<T>Cliente<T>)<BR>PlugIn(<T>Mapa<T>, <T>Cliente<T>, <T>Pintar<T>)

[Acciones.LocalMapaSeleccion]
Nombre=LocalMapaSeleccion
Boton=0
NombreDesplegar=Ver Mapa (&Selección)
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Mapa.Borrar<BR>RegistrarListaSt(<T>Lista<T>, <T>Cte.Cliente<T>, Verdadero)<BR>Mapa.AgregarListaSt(<T>Cliente<T>)<BR>PlugIn(<T>Mapa<T>, <T>Cliente<T>, <T>Pintar<T>)










[Acciones.NvoPlanograma]
Nombre=NvoPlanograma
Boton=87
NombreDesplegar=&Nuevo Planograma
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S








Multiple=S
ListaAccionesMultiples=(Lista)
[Lista.vic_Plano.Nombre]
Carpeta=Lista
Clave=vic_Plano.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.vic_Plano.NombreCorto]
Carpeta=Lista
Clave=vic_Plano.NombreCorto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



[Lista.vic_Plano.Lista]
Carpeta=Lista
Clave=vic_Plano.Lista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco





[Acciones.vic_PlanoCat]
Nombre=vic_PlanoCat
Boton=0
Menu=&Maestros
NombreDesplegar=&Categorías
EnMenu=S
TipoAccion=Formas
ClaveAccion=vic_PlanoCat
Activo=S


VisibleCondicion=1=0
[Acciones.vic_PlanoFam]
Nombre=vic_PlanoFam
Boton=0
Menu=&Maestros
NombreDesplegar=&Familia
EnMenu=S
TipoAccion=Formas
ClaveAccion=vic_PlanoFam
Activo=S


VisibleCondicion=1=0
[Acciones.vic_PlanoGrp]
Nombre=vic_PlanoGrp
Boton=0
Menu=&Maestros
NombreDesplegar=&Grupo
EnMenu=S
TipoAccion=Formas
ClaveAccion=vic_PlanoGrp
Activo=S






VisibleCondicion=1=0
[Acciones.TipoPlano]
Nombre=TipoPlano
Boton=0
Menu=&Maestros
NombreDesplegar=&Tipo de Plano
EnMenu=S
TipoAccion=Formas
ClaveAccion=vic_PlanoTipo
Activo=S
Visible=S











[Acciones]
Estilo=Hoja
Clave=Acciones
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=vic_PlanoAcciones
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=vic_plano
LlaveLocal=vic_PlanoAcciones.Plano
LlaveMaestra=vic_Plano.Plano
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
PestanaOtroNombre=S
PestanaNombre=Acciones

OtroOrden=S
MenuLocal=S
ListaOrden=vic_PlanoAcciones.Renglon<TAB>(Acendente)
ListaAcciones=(Lista)
HojaColorFondo=Plata
[Acciones.vic_PlanoAcciones.Nombre]
Carpeta=Acciones
Clave=vic_PlanoAcciones.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Acciones.vic_PlanoAcciones.Estatus]
Carpeta=Acciones
Clave=vic_PlanoAcciones.Estatus
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


[Acciones.Columnas]
Nombre=347
Query=325
LeyendaColor=124
Estatus=135






[Acciones.NvoPlanograma.vic_PlanoNuevo]
Nombre=vic_PlanoNuevo
Boton=0
TipoAccion=Formas
ClaveAccion=vic_PlanoNuevo
Activo=S
Visible=S

[Acciones.NvoPlanograma.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.NvoPlanograma.ListaAccionesMultiples]
(Inicio)=vic_PlanoNuevo
vic_PlanoNuevo=Actualizar Vista
Actualizar Vista=(Fin)








[Acciones.Actualizar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=FormaPos(<T>vic_PlanoNuevo<T>, vic_Plano:vic_Plano.Plano)
[Acciones.Actualizar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
NombreDesplegar=Actualizar Planograma
Multiple=S
EnMenu=S
ListaAccionesMultiples=(Lista)

Visible=S

EspacioPrevio=S
ActivoCondicion=(ConDatos(vic_Plano:vic_Plano.Plano) o ConDatos(Info.Tipo)) y Usuario.vic_ActualizarPlanoGrama
[Acciones.PImprimir]
Nombre=PImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.PPreliminar]
Nombre=PPreliminar
Boton=0
NombreDesplegar=Presentación Preliminar
EnMenu=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.PExcel]
Nombre=PExcel
Boton=0
NombreDesplegar=Enviar a excel
EnMenu=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.PPersonalizar]
Nombre=PPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S














[Acciones.Eliminar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si Precaucion(<T>¿ Esta seguro que desea eliminar este Planograma ?<T>+ NuevaLinea + NuevaLinea + vic_Plano:vic_Plano.NombreCorto, BotonSi, BotonNo ) = BotonSi<BR>Entonces EjecutarSQL(<T>vic_spEliminaPlano :tPlano<T>, vic_Plano:vic_Plano.Plano)<BR>Sino<BR><T><T><BR>Fin
[Acciones.Eliminar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=0
NombreDesplegar=Eliminar Planograma
Multiple=S
EnMenu=S
ListaAccionesMultiples=(Lista)

Visible=S










ActivoCondicion=(ConDatos(vic_Plano:vic_Plano.Plano) o ConDatos(Info.Tipo)) y Usuario.vic_EliminarPlanoGrama
[Acciones.NuevaAccion.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.NuevaAccion]
Nombre=NuevaAccion
Boton=0
NombreDesplegar=&Acciones del Planograma
Multiple=S
EnMenu=S
ListaAccionesMultiples=(Lista)

Antes=S
Visible=S

ActivoCondicion=(ConDatos(vic_Plano:vic_Plano.Plano) o ConDatos(Info.Tipo)) y Usuario.vic_AccionesPlanoGrama
AntesExpresiones=Asigna(Info.Plano, vic_Plano:vic_Plano.Plano)
[Lista.NombreInmueble]
Carpeta=Lista
Clave=NombreInmueble
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco










[Acciones.EliminarAccion.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si Precaucion(<T>¿ Esta seguro que desea eliminar esta acción ?<T>+ NuevaLinea + NuevaLinea + <T>Acción <T> + vic_PlanoAcciones:vic_PlanoAcciones.Nombre, BotonSi, BotonNo ) = BotonSi<BR>Entonces EjecutarSQL(<T>vic_spEliminaAccionPlano :tPlano, :nRenglon<T>, vic_PlanoAcciones:vic_PlanoAcciones.Plano, vic_PlanoAcciones:vic_PlanoAcciones.Renglon)<BR>Sino<BR><T><T><BR>Fin
[Acciones.EliminarAccion.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.EliminarAccion]
Nombre=EliminarAccion
Boton=0
NombreDesplegar=&Eliminar acción del Planograma
Multiple=S
EnMenu=S
ListaAccionesMultiples=(Lista)

Visible=S

ActivoCondicion=(ConDatos(vic_PlanoAcciones:vic_PlanoAcciones.Plano)) y (ConDatos(vic_PlanoAcciones:vic_PlanoAcciones.Renglon))
[Acciones.ACImprimir]
Nombre=ACImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=Acciones
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.ACPreliminar]
Nombre=ACPreliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=Acciones
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.ACExcel]
Nombre=ACExcel
Boton=0
NombreDesplegar=Enviar a excel
EnMenu=S
Carpeta=Acciones
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.ACPersonalizar]
Nombre=ACPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S







[Acciones.ConsultarAccion.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=FormaPos(<T>vic_PlanoAcciones<T>, vic_PlanoAcciones:vic_PlanoAcciones.Plano, vic_PlanoAcciones:vic_PlanoAcciones.Renglon, vic_PlanoAcciones:vic_PlanoAcciones.RenglonSub)
[Acciones.ConsultarAccion.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S



[Acciones.ConsultarAccion.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Vista
Actualizar Vista=(Fin)











[Acciones.NuevaAccion.vic_PlanoAcciones2]
Nombre=vic_PlanoAcciones2
Boton=0
TipoAccion=Formas
ClaveAccion=vic_PlanoAcciones2
Activo=S
Visible=S
















[Acciones.vicintelisis_planos]
Nombre=vicintelisis_planos
Boton=0
NombreDesplegar=&Ver Planograma (Diseño)
EnMenu=S
TipoAccion=Expresion
Visible=S



































Antes=S








Expresion=PlugIn(<T>Planograma<T>,<T>#D#I#<T>+Info.Plano)
ActivoCondicion=(ConDatos(vic_Plano:vic_Plano.Plano) o ConDatos(Info.Tipo)) y Usuario.vic_VerPlanoGramaDiseno
AntesExpresiones=Asigna(Info.Plano, vic_Plano:vic_Plano.Plano)
[Acciones.vicintelisis_planos2]
Nombre=vicintelisis_planos2
Boton=0
NombreDesplegar=Ver Planograma (Producción)
EnMenu=S
TipoAccion=Expresion
Visible=S
Antes=S








































Expresion=PlugIn(<T>Planograma<T>,<T>#P#I#<T>+Info.Plano+<T>#<T>)
ActivoCondicion=(ConDatos(vic_Plano:vic_Plano.Plano) o ConDatos(Info.Tipo)) y Usuario.vic_VerPlanoGramaProduccion
AntesExpresiones=Asigna(Info.Plano, vic_Plano:vic_Plano.Plano)
[Acciones.CopiarAcciones.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

[Acciones.CopiarAcciones.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S


[Acciones.CopiarAcciones.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Vista
Actualizar Vista=(Fin)






[Acciones.PCopiarAcciones.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.PCopiarAcciones]
Nombre=PCopiarAcciones
Boton=0
NombreDesplegar=&Copiar Acciones del Planograma
GuardarAntes=S
EnMenu=S

Visible=S

Antes=S













TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
DespuesGuardar=S
ActivoCondicion=(ConDatos(vic_Plano:vic_Plano.Plano) o ConDatos(Info.Tipo)) y Usuario.vic_CopiarAccionesPlanoGrama
AntesExpresiones=Asigna(Info.Plano, vic_Plano:vic_Plano.Plano)<BR>Forma(<T>vic_PlanoLista<T>)
[Acciones.PCopiarAcciones.vic_PlanoLista]
Nombre=vic_PlanoLista
Boton=0
TipoAccion=Formas
ClaveAccion=vic_PlanoLista
Activo=S
Visible=S




[Acciones.PCopiarAcciones.ListaAccionesMultiples]
(Inicio)=vic_PlanoLista
vic_PlanoLista=Actualizar Vista
Actualizar Vista=(Fin)











[vic_Plano.Columnas]
0=-2
1=-2
2=211
3=113



[Acciones.EliminarAccion.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Vista
Actualizar Vista=(Fin)

[Acciones.ListaEnCaptura]
(Inicio)=vic_PlanoAcciones.Nombre
vic_PlanoAcciones.Nombre=vic_PlanoAcciones.Estatus
vic_PlanoAcciones.Estatus=(Fin)

[Acciones.ListaAcciones]
(Inicio)=EliminarAccion
EliminarAccion=ACImprimir
ACImprimir=ACPreliminar
ACPreliminar=ACExcel
ACExcel=ACPersonalizar
ACPersonalizar=(Fin)















































































[Acciones.llamar Plano]
Nombre=llamar Plano
Boton=0
NombreDesplegar=Llamar a Plano
EnBarraHerramientas=S
EnMenu=S
TipoAccion=expresion
Activo=S











Expresion=PlugIn(<T>Planograma<T>)
VisibleCondicion=1=0













































































































































































[Acciones.PImprimir.Imprimir]
Nombre=Imprimir
Boton=0
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.PImprimir.Asigna]
Nombre=Asigna
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.Tipo,vic_Plano:vic_Plano.Plano)
Activo=S
Visible=S

[Acciones.PImprimir.ListaAccionesMultiples]
(Inicio)=Asigna
Asigna=Imprimir
Imprimir=(Fin)

















[Acciones.Actualizar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Vista
Actualizar Vista=(Fin)

[Acciones.Eliminar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Vista
Actualizar Vista=(Fin)

[Acciones.NuevaAccion.ListaAccionesMultiples]
(Inicio)=vic_PlanoAcciones2
vic_PlanoAcciones2=Actualizar Vista
Actualizar Vista=(Fin)







[Lista.ListaEnCaptura]
(Inicio)=vic_Plano.NombreCorto
vic_Plano.NombreCorto=vic_Plano.Nombre
vic_Plano.Nombre=vic_Plano.Lista
vic_Plano.Lista=NombreInmueble
NombreInmueble=(Fin)

[Lista.ListaOrden]
(Inicio)=vic_Plano.Plano	(Acendente)
vic_Plano.Plano	(Acendente)=vic_Plano.Nombre	(Acendente)
vic_Plano.Nombre	(Acendente)=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQ_AVISO
BLOQ_AVISO=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=vicintelisis_planos2
vicintelisis_planos2=vicintelisis_planos
vicintelisis_planos=PCopiarAcciones
PCopiarAcciones=Actualizar
Actualizar=Eliminar
Eliminar=NuevaAccion
NuevaAccion=PImprimir
PImprimir=PPreliminar
PPreliminar=PExcel
PExcel=PPersonalizar
PPersonalizar=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Acciones
Acciones=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=NvoPlanograma
NvoPlanograma=Campos
Campos=vic_PlanoCat
vic_PlanoCat=vic_PlanoGrp
vic_PlanoGrp=vic_PlanoFam
vic_PlanoFam=TipoPlano
TipoPlano=llamar Plano
llamar Plano=(Fin)
