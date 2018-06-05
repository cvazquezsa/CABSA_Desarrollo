[Forma]
Clave=ExplorarCFD
Nombre=Explorar - CFD<T>s
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=122
PosicionInicialArriba=101
PosicionInicialAlturaCliente=532
PosicionInicialAncho=903
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ExpresionesAlMostrar=Asigna(Info.Ejercicio,  Año(Hoy))<BR>Asigna(Info.Periodo, Mes(Hoy))

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFD
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=10
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroEditarFueraPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
ListaEnCaptura=(Lista)
FiltroAplicaEn=CFD.Serie
FiltroAutoCampo=CFD.Serie
FiltroAutoValidar=CFD.Serie
FiltroAutoOrden=CFD.Serie
FiltroGrupo1=CFD.Serie
FiltroValida1=CFD.Serie
FiltroTodo=S
FiltroTodoFinal=S
IconosSubTitulo=<T>RFC<T>
FiltroFechasCampo=CFD.Fecha
FiltroFechasDefault=Hoy
FiltroPeriodos=S
FiltroEjercicios=S
MenuLocal=S
ListaAcciones=XML

IconosNombre=CFD:CFD.RFC
FiltroGeneral=CFD.Empresa=<T>{Empresa}<T>
[Lista.CFD.Fecha]
Carpeta=Lista
Clave=CFD.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFD.Serie]
Carpeta=Lista
Clave=CFD.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CFD.Folio]
Carpeta=Lista
Clave=CFD.Folio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Lista.Columnas]
0=115
1=130

2=-2
3=-2
4=105
5=76
6=107
7=66
8=-2
9=-2
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
NombreDesplegar=Preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
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

[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.ReporteMensual]
Nombre=ReporteMensual
Boton=38
NombreEnBoton=S
NombreDesplegar=Generar &Reporte Mensual
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Info.Periodo, PeriodoTrabajo)<BR>Si<BR>  Forma(<T>EspecificarEjercicioPeriodo<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spCFDReporteMensual :tEmp, :nEjercicio, :nPeriodo<T>, Empresa, Info.Ejercicio, Info.Periodo)<BR>  GuardarLista(SQLEnLista(<T>SELECT Dato FROM CFDReporteMensual<T>), <T><T>, <T>1<T>+Empresa.RFC+LlenaDeCeros(Info.Periodo,2)+Info.Ejercicio+<T>.txt<T>, <T>TXT<T>, <T>Datos<T>, <T>Datos<T>)<BR>Fin
[Acciones.XML]
Nombre=XML
Boton=0
NombreDesplegar=Ver &XML
EnMenu=S
TipoAccion=Expresion
Expresion=VerComentario( <T>XML<T>,  SQL(<T>SELECT Documento FROM CFD WHERE Modulo=:tModulo AND ModuloID=:nID<T>, CFD:CFD.Modulo, CFD:CFD.ModuloID) )
Activo=S
Visible=S





[Lista.ImportePesos]
Carpeta=Lista
Clave=ImportePesos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Impuesto1Pesos]
Carpeta=Lista
Clave=Impuesto1Pesos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Lista.CFD.Importe]
Carpeta=Lista
Clave=CFD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFD.Impuesto1]
Carpeta=Lista
Clave=CFD.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFD.Impuesto2]
Carpeta=Lista
Clave=CFD.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=CFD.Fecha
CFD.Fecha=CFD.Serie
CFD.Serie=CFD.Folio
CFD.Folio=ImportePesos
ImportePesos=Impuesto1Pesos
Impuesto1Pesos=ImporteTotal
ImporteTotal=CFD.Importe
CFD.Importe=CFD.Impuesto1
CFD.Impuesto1=CFD.Impuesto2
CFD.Impuesto2=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=ReporteMensual
ReporteMensual=(Fin)
