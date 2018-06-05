[Forma]
Clave=ExplorarCentroCostos2CtaD
Icono=47
Modulos=(Todos)
Nombre=<T>Explorando - Centros de Costos 2 (por Cuenta)<T>
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=189
PosicionInicialArriba=195
PosicionInicialAltura=377
PosicionInicialAncho=645
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Cuenta, Info.SubCuenta, Info.Nombre, Info.Ejercicio)
VentanaEstadoInicial=Normal

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContT
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Movimientos
IconosNombre=ContT:Cont.Mov+<T> <T>+ContT:Cont.MovID
FiltroGeneral=ContD.Cuenta=<T>{Info.Cuenta}<T> AND ContD.SubCuenta=<T>{Info.SubCuenta}<T> AND <BR>Cont.Ejercicio={Info.Ejercicio} AND Cont.Periodo={Info.Periodo} AND<BR>Cont.Estatus=<T>CONCLUIDO<T>

[Lista.Columnas]
Cuenta=132
Descripcion=206
Tipo=68
PeriodoNombre=79
Cargos=123
Abonos=131
NombrePeriodo=80
0=118
1=91

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

[Lista.Cont.FechaContable]
Carpeta=Lista
Clave=Cont.FechaContable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ContD.Concepto]
Carpeta=Lista
Clave=ContD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ContD.Debe]
Carpeta=Lista
Clave=ContD.Debe
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ContD.Haber]
Carpeta=Lista
Clave=ContD.Haber
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(ContT:Cont.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>CONT<T>)<BR>Asigna(Info.ID, ContT:Cont.ID)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Propiedades
Propiedades=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cont.FechaContable
Cont.FechaContable=ContD.Concepto
ContD.Concepto=ContD.Debe
ContD.Debe=ContD.Haber
ContD.Haber=(Fin)
