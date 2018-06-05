

[Forma]
Clave=CFDIRetencionRegenerar
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Retenciones - Generar Constancia PDF
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=269
PosicionInicialArriba=74
PosicionInicialAlturaCliente=542
PosicionInicialAncho=828
ExpresionesAlMostrar=Asigna(Info.Mov, SQL(<T>SELECT MovTimbrado FROM  CFDIRetencionCfg<T>))
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

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxpA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
ListaEnCaptura=(Lista)

FiltroUsuarios=S
FiltroFechas=S
FiltroSucursales=S
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=Cxp.FechaEmision
FiltroFechasDefault=Este Mes
BusquedaRapida=S
BusquedaEnLinea=S

IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=CxpA:Cxp.Mov+<T> <T>+CxpA:Cxp.MovID
FiltroGeneral=Cxp.Mov = <T>{Info.Mov}<T> AND Cxp.Estatus = <T>CONCLUIDO<T>
[Lista.Cxp.Proveedor]
Carpeta=Lista
Clave=Cxp.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco



[Lista.Cxp.FechaEmision]
Carpeta=Lista
Clave=Cxp.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
0=152
1=78
2=150
3=91
4=95
5=96
6=90
7=95












[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Cxp.Moneda]
Carpeta=Lista
Clave=Cxp.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
NombreDesplegar=&Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.QuitarSeleccion]
Nombre=QuitarSeleccion
Boton=0
NombreDesplegar=&Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S



[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación Preliminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S




[Acciones.XML]
Nombre=XML
Boton=124
NombreEnBoton=S
NombreDesplegar=Regenerar XML
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=RegistrarSeleccionID(<T>Lista<T>)<BR>Informacion(SQL(<T>EXEC spCFDIRetencionXMLRegenerar :nEstacion, :tEmpresa, :tUsuario<T>, EstacionTrabajo, Empresa, Usuario))<BR>ActualizarVista<BR>ActualizarForma


[Acciones.GenerarPDF]
Nombre=GenerarPDF
Boton=0
NombreDesplegar=&Generar PDF
EnLote=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S




EspacioPrevio=S





















Expresion=Asigna(Info.Reporte, SQL(<T>SELECT RepConstancia FROM CFDIRetencionCfg<T>))<BR>Asigna(Info.Anuncio, SQL(<T>SELECT ArchivoPDF FROM CFDRetencion WHERE Modulo = :tModulo AND ModuloID = :nID<T>, <T>CXP<T>, CxpA:Cxp.ID))<BR><BR>ReportePDF(Info.Reporte, <T>CXP<T>, CxpA:Cxp.ID, Info.Anuncio)<BR><BR>EjecutarSQL(<T>EXEC spCFDIRetencionAnexoPDF :tEmpresa, :tUsuario, :nID, :tArchivo, :nEstacion<T>, Empresa, Usuario, CxpA:Cxp.ID, Info.Anuncio, EstacionTrabajo)<BR><BR>Si SQL(<T>SELECT CASE WHEN COUNT(ID) <= 0 THEN 1 ELSE  0 END FROM ListaID where Estacion = :tEstacion <T>, EstacionTrabajo)<BR>Entonces<BR>  Asigna(Temp.texto,<T>Proceso Concluido<T>)<BR>  Informacion(Temp.Texto)<BR>Sino<BR>  Asigna(Temp.Texto,<T><T>)<BR>Fin
Antes=S
AntesExpresiones=RegistrarSeleccionID(<T>Lista<T>)
[Acciones.Enviar]
Nombre=Enviar
Boton=0
NombreDesplegar=&Enviar por Correo Electrónico
EnMenu=S
TipoAccion=Expresion
Activo=S

EspacioPrevio=S



Antes=S












EnLote=S









Expresion=Si SQL(<T>SELECT EnviarPDFRetencion FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>, Empresa)<BR>Entonces<BR>  Si SQL(<T>SELECT dbo.fnCFDIRetencionPDFGenerado(:nID)<T>, CxpA:Cxp.ID) = <T>Generado<T><BR>  Entonces<BR>    EjecutarSQL(<T>EXEC spCFDIRetencionEnviar :tEmpresa, :nID, :tEstacionTrabajo<T>,Empresa, CxpA:Cxp.ID, EstacionTrabajo)<BR>  Sino<BR>    Falso<BR>    Error( <T>Error al Enviar: <T>+ CxpA:Cxp.Mov+<T> <T>+CxpA:Cxp.MovID +<T>, Falta Generar la Constancia PDF<T>)<BR>  Fin<BR>Sino<BR>  EjecutarSQL(<T>EXEC spCFDIRetencionEnviar :tEmpresa, :nID, :tEstacionTrabajo<T>,Empresa, CxpA:Cxp.ID, EstacionTrabajo)<BR>Fin<BR><BR>Si SQL(<T>SELECT CASE WHEN COUNT(ID) <= 0 THEN 1 ELSE  0 END FROM ListaID where Estacion = :tEstacion <T>, EstacionTrabajo)<BR>Entonces<BR>  Asigna(Temp.texto,<T>Proceso Concluido<T>)<BR>  Informacion(Temp.Texto)<BR>Sino<BR>  Asigna(Temp.Texto,<T><T>)<BR>Fin
AntesExpresiones=RegistrarSeleccionID(<T>Lista<T>)
VisibleCondicion=SQL(<T>SELECT EnviarRetencion FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>, Empresa))



[Lista.ListaEnCaptura]
(Inicio)=Cxp.Proveedor
Cxp.Proveedor=Prov.Nombre
Prov.Nombre=Cxp.FechaEmision
Cxp.FechaEmision=ImporteTotal
ImporteTotal=Cxp.Moneda
Cxp.Moneda=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionarTodo
SeleccionarTodo=QuitarSeleccion
QuitarSeleccion=GenerarPDF
GenerarPDF=Enviar
Enviar=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=XML
XML=(Fin)
