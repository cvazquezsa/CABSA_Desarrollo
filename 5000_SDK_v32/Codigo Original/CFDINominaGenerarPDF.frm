
[Forma]
Clave=CFDINominaGenerarPDF
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Nómina - Generar Recibo PDF
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=231
PosicionInicialArriba=54
PosicionInicialAlturaCliente=581
PosicionInicialAncho=903
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
MenuLocal=S
IconosSeleccionMultiple=S
ListaAcciones=(Lista)
IconosNombre=CFDINominaA:Nomina.Mov+<T> <T>+CFDINominaA:Nomina.MovID
FiltroGeneral=Nomina.Empresa=<T>{Empresa}<T> AND<BR>Nomina.Estatus IN (<T>PENDIENTE<T>, <T>CONCLUIDO<T>) /*AND<BR>Nomina.Ejercicio >= 2014 AND*/
[Lista.Columnas]
0=141

1=84
2=122
3=133
4=238
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




























[Acciones.Recibo]
Nombre=Recibo
Boton=61
NombreEnBoton=S
NombreDesplegar=&Recibo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDINominaReciboPDF
Activo=S
Visible=S

ConCondicion=S
Antes=S

































































































































EjecucionCondicion=ConDatos(CFDINominaA:Nomina.ID)
AntesExpresiones=Asigna(Info.Mov, CFDINominaA:Nomina.Mov)<BR>Asigna(Info.MovID, CFDINominaA:Nomina.MovID)<BR>Asigna(Info.ID, CFDINominaA:Nomina.ID)




[Acciones.Todo]
Nombre=Todo
Boton=0
NombreDesplegar=&Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Nada]
Nombre=Nada
Boton=0
NombreDesplegar=&Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S









[Acciones.GenerarRecibo]
Nombre=GenerarRecibo
Boton=0
EnMenu=S
Activo=S
Visible=S

NombreDesplegar=Generar Recibo Global
EnLote=S
TipoAccion=Expresion




EspacioPrevio=S
























Expresion=Asigna(Info.Reporte, SQL(<T>SELECT ReporteMov FROM CFDINominaMov WHERE Mov = :tMov<T>, CFDINominaA:Nomina.Mov))<BR>Asigna(Info.Anuncio, SQL(<T>SELECT TOP 1 ArchivoPDF FROM CFDINominaRecibo WHERE ID = :nID AND NULLIF(ArchivoPDF, :tVacio) IS NOT NULL<T>, CFDINominaA:Nomina.ID, <T><T>))<BR>Asigna(Info.Anuncio, SQL(<T>SELECT dbo.fnCFDINominaObtenerRuta(:tArchivo)<T>, Info.Anuncio))<BR>Asigna(Info.Anuncio, Info.Anuncio+<T>\<T>+CFDINominaA:Nomina.Mov+<T> <T>+CFDINominaA:Nomina.MovID+<T>.pdf<T>)<BR>ReportePDF(Info.Reporte, CFDINominaA:Nomina.ID, Info.Anuncio)<BR>EjecutarSQL(<T>EXEC spCFDINominaMovPDF :nID, :tArchivo<T>, CFDINominaA:Nomina.ID, Info.Anuncio)




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
Nada=GenerarRecibo
GenerarRecibo=(Fin)

























[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Movimiento
Movimiento=Recibo
Recibo=Personalizar
Personalizar=(Fin)
