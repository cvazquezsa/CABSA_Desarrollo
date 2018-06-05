[Forma]
Clave=PlanDemandaAlm
Nombre=Demanda del Artículo / Almacén
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=187
PosicionInicialArriba=153
PosicionInicialAlturaCliente=427
PosicionInicialAncho=649
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Articulo, Info.Almacen)
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
ExpresionesAlMostrar=EjecutarSQL(<T>spPlanDemanda :nEstacion, :tEmpresa, :tArt, :tAlm<T>, EstacionTrabajo, Empresa, Info.Articulo, Info.Almacen)

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PlanDemanda
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
PestanaOtroNombre=S
FiltroAplicaEn=PlanDemanda.Periodo
FiltroAutoCampo=(Validaciones Memoria)
FiltroGrupo1=PlanDemanda.Periodo
FiltroValida1=PlanDemanda.Periodo
FiltroTodo=S
IconosNombre=PlanDemanda:PlanDemanda.Mov+<T> <T>+PlanDemanda:PlanDemanda.MovID
FiltroGrupo2=PlanDemanda.Mov
FiltroValida2=PlanDemanda.Mov
FiltroGeneral=PlanDemanda.Estacion={EstacionTrabajo} AND PlanDemanda.Empresa=<T>{Empresa}<T> AND PlanDemanda.Articulo=<T>{Info.Articulo}<T>

[Lista.PlanDemanda.Cantidad]
Carpeta=Lista
Clave=PlanDemanda.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.Columnas]
0=131
1=57

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

[Lista.PlanDemanda.Periodo]
Carpeta=Lista
Clave=PlanDemanda.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(PlanDemanda:PlanDemanda.ModuloID)
AntesExpresiones=Asigna(Info.Modulo, PlanDemanda:PlanDemanda.Modulo)<BR>Asigna(Info.ID, PlanDemanda:PlanDemanda.ModuloID)

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

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

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Examinar]
Nombre=Examinar
Boton=57
NombreEnBoton=S
NombreDesplegar=&Examinar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=ReportePantalla(PlanDemanda:PlanDemanda.Modulo, PlanDemanda:PlanDemanda.ModuloID)
EjecucionCondicion=ConDatos(PlanDemanda:PlanDemanda.ModuloID)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Propiedades
Propiedades=Examinar
Examinar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PlanDemanda.Periodo
PlanDemanda.Periodo=PlanDemanda.Cantidad
PlanDemanda.Cantidad=(Fin)
