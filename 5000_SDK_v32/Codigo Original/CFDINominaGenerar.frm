
[Forma]
Clave=CFDINominaGenerar
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Nómina - Generar CFDI
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=62
PosicionInicialArriba=47
PosicionInicialAlturaCliente=529
PosicionInicialAncho=899
ListaAcciones=(Lista)
Menus=S
Comentarios=Empresa
MenuPrincipal=&Configurar
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Movimientos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroProyectos=S
FiltroSucursales=S
FiltroListaEstatus=(Lista)

FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
IconosSubTitulo=<T>Movimiento<T>




FiltroEstatusDefault=CONCLUIDO
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=Nomina.FechaEmision
FiltroFechasDefault=Hoy
FiltroMonedasCampo=Nomina.Moneda
FiltroFechasCancelacion=Nomina.FechaCancelacion
ListaEnCaptura=(Lista)

FiltroGrupo1=Nomina.Ejercicio
FiltroValida1=Nomina.Ejercicio
FiltroGrupo2=Nomina.Periodo
FiltroValida2=Nomina.Periodo
FiltroTodo=S
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=CFDINominaA:Nomina.Mov+<T> <T>+CFDINominaA:Nomina.MovID
FiltroGeneral=Nomina.Empresa=<T>{Empresa}<T> AND<BR>Nomina.Estatus IN (<T>PENDIENTE<T>, <T>CONCLUIDO<T>) AND<BR>/*Nomina.Ejercicio >= 2014 AND*/<BR>Nomina.CFDTimbrado = 0
[Lista.Columnas]
0=89

1=98
2=120
3=133
4=249
5=102
6=106
7=102
8=97
9=97
10=105
Mov=155
MovID=98
FechaPago=151
11=-2
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
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S


NombreDesplegar=Imprimir
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Imprimir
[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
EnBarraHerramientas=S
Activo=S
Visible=S


NombreDesplegar=Presentación Preliminar
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
[Acciones.Excel]
Nombre=Excel
Boton=67
EnBarraHerramientas=S
Activo=S
Visible=S


NombreDesplegar=Enviar a Excel
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
[Acciones.Movimiento]
Nombre=Movimiento
Boton=35
EnBarraHerramientas=S
Activo=S
Visible=S

EspacioPrevio=S



NombreEnBoton=S
NombreDesplegar=&Movimiento
TipoAccion=Formas
ClaveAccion=MovPropiedades
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(CFDINominaA:Nomina.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.ID, CFDINominaA:Nomina.ID)
[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
EnBarraHerramientas=S
Activo=S
Visible=S



















NombreDesplegar=Personalizar Vista
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos




[Lista.Nomina.FechaEmision]
Carpeta=Lista
Clave=Nomina.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Lista.Nomina.Concepto]
Carpeta=Lista
Clave=Nomina.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Nomina.Condicion]
Carpeta=Lista
Clave=Nomina.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Nomina.Observaciones]
Carpeta=Lista
Clave=Nomina.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


























[Acciones.Todo]
Nombre=Todo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Nada]
Nombre=Nada
Boton=0
NombreDesplegar=Eliminar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S








[Acciones.Concepto]
Nombre=Concepto
Boton=0
Menu=&Configurar
NombreDesplegar=&Conceptos
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDINominaConcepto
Activo=S
Visible=S














EspacioPrevio=S

[Acciones.Empresa]
Nombre=Empresa
Boton=0
Menu=&Configurar
NombreDesplegar=&Empresas
TipoAccion=Formas
ClaveAccion=CFDINominaEmpresa
Activo=S
Visible=S




























EnMenu=S
[Acciones.ConceptosDiasPagados]
Nombre=ConceptosDiasPagados
Boton=0
NombreDesplegar=C&onceptos Días Pagados
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDINominaConceptoDiasPaga

Menu=&Configurar
















































[Acciones.Movimientos]
Nombre=Movimientos
Boton=0
Menu=&Configurar
NombreDesplegar=&Movimientos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDINominaMov
Activo=S
Visible=S










[Acciones.Instituciones]
Nombre=Instituciones
Boton=0
NombreDesplegar=&Instituciones Financieras
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDINominaInstitucionFin
Activo=S
Visible=S



Menu=&Configurar





















[Acciones.Plantilla]
Nombre=Plantilla
Boton=0
Menu=&Configurar
NombreDesplegar=&Plantilla XML
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDINominaXMLPlantilla
Activo=S
Visible=S

























[Acciones.ProcesarInfo]
Nombre=ProcesarInfo
Boton=20
NombreDesplegar=Sugerir Recibo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S









EspacioPrevio=S



































Expresion=RegistrarSeleccionModuloID(<T>Lista<T>, <T>Nomina.Empresa<T>, <T>Nomina.ID<T>)<BR><BR>ProcesarSQL(<T>EXEC spCFDINominaGenerar :nEstacionTrabajo, 0, :tUsuario<T>, EstacionTrabajo, Usuario)
[Acciones.Generar CFDI]
Nombre=Generar CFDI
Boton=127
NombreDesplegar=&Generar CFDI
EnBarraHerramientas=S
EspacioPrevio=S
ConfirmarAntes=S
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=RegistrarSeleccionModuloID(<T>Lista<T>, <T>Nomina.Empresa<T>, <T>Nomina.ID<T>)<BR>Asigna(Temp.logico,SQL(<T>SELECT NominaEditarFechaPago FROM EmpresaCFD WHERE Empresa =:tEmpresa<T>,Empresa))<BR>SI Temp.Logico<BR>Entonces<BR>EjecutarSQL(<T>EXEC spCFDINominaEditarMov :nEstacionTrabajo, :tEmpresa, :tUsuario<T>, EstacionTrabajo, Empresa, Usuario)<BR>Forma(<T>CFDINominaDatosMov<T>)<BR>Sino<BR>ProcesarSQL(<T>EXEC spCFDINominaGenerar :nEstacionTrabajo, 1, :tUsuario<T>, EstacionTrabajo, Usuario)<BR>Fin<BR>ActualizarVista<BR>ActualizarForma
[Acciones.Recibo]
Nombre=Recibo
Boton=61
NombreEnBoton=S
NombreDesplegar=&Recibo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

ConCondicion=S
Antes=S





















































































































Expresion=Forma(<T>CFDINominaRecibo<T>)<BR>ActualizarVista<BR>ActualizarForma
EjecucionCondicion=ConDatos(CFDINominaA:Nomina.ID)
AntesExpresiones=Asigna(Info.Mov, CFDINominaA:Nomina.Mov)<BR>Asigna(Info.MovID, CFDINominaA:Nomina.MovID)<BR>Asigna(Info.ID, CFDINominaA:Nomina.ID)




[Lista.ListaEnCaptura]
(Inicio)=Nomina.FechaEmision
Nomina.FechaEmision=Nomina.Concepto
Nomina.Concepto=Nomina.Condicion
Nomina.Condicion=Nomina.Observaciones
Nomina.Observaciones=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)

[Lista.ListaAcciones]
(Inicio)=Todo
Todo=Nada
Nada=(Fin)

































































































































































































































































































































































































































































































































































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Movimiento
Movimiento=ProcesarInfo
ProcesarInfo=Recibo
Recibo=Generar CFDI
Generar CFDI=Personalizar
Personalizar=Empresa
Empresa=Concepto
Concepto=ConceptosDiasPagados
ConceptosDiasPagados=Movimientos
Movimientos=Instituciones
Instituciones=Plantilla
Plantilla=(Fin)
