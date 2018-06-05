
[Forma]
Clave=CFDINominaReciboPDF
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI - Recibo Nómina SAT
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=214
PosicionInicialArriba=79
PosicionInicialAlturaCliente=531
PosicionInicialAncho=855
Comentarios=Info.Mov + <T> <T> + Info.MovID

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaRecibo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Personal<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
Filtros=S
OtroOrden=S
ListaOrden=CFDINominaRecibo.Personal<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGrupo1=CFDINominaRecibo.PDFGenerado
FiltroValida1=CFDINominaRecibo.PDFGenerado
FiltroTodo=S
FiltroAutoCampo=CFDINominaRecibo.Timbrado
FiltroAutoValidar=CFDINominaRecibo.Timbrado
MenuLocal=S
ListaAcciones=(Lista)
IconosSeleccionMultiple=S

IconosNombre=CFDINominaRecibo:CFDINominaRecibo.Personal
FiltroGeneral=CFDINominaRecibo.ID = {Info.ID} AND<BR>CFDINominaRecibo.Timbrado = <T>Timbrado<T>
[Lista.Columnas]
0=75
1=117
2=108
3=111
4=108
5=91
6=106
7=102

8=97
9=52
10=252
11=-2
[Lista.CFDINominaRecibo.TotalPercepciones]
Carpeta=Lista
Clave=CFDINominaRecibo.TotalPercepciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.CFDINominaRecibo.PercepcionesTotalGravado]
Carpeta=Lista
Clave=CFDINominaRecibo.PercepcionesTotalGravado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=0
Tamano=255
[Lista.CFDINominaRecibo.PercepcionesTotalExcento]
Carpeta=Lista
Clave=CFDINominaRecibo.PercepcionesTotalExcento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=0
[Lista.CFDINominaRecibo.TotalDeducciones]
Carpeta=Lista
Clave=CFDINominaRecibo.TotalDeducciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.CFDINominaRecibo.DeduccionesTotalGravado]
Carpeta=Lista
Clave=CFDINominaRecibo.DeduccionesTotalGravado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=0
[Lista.CFDINominaRecibo.DeduccionesTotalExcento]
Carpeta=Lista
Clave=CFDINominaRecibo.DeduccionesTotalExcento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=0
[Lista.CFDINominaRecibo.TotalDescuento]
Carpeta=Lista
Clave=CFDINominaRecibo.TotalDescuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Totalizador=0
[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S





[Lista.NombrePersonal]
Carpeta=Lista
Clave=NombrePersonal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco














[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


EspacioPrevio=S
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

















[Acciones.GenerarRecibo]
Nombre=GenerarRecibo
Boton=0
NombreDesplegar=&Generar Recibo
EnLote=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

EspacioPrevio=S
Expresion=Asigna(Info.Reporte, SQL(<T>SELECT Reporte FROM CFDINominaMov WHERE Mov = :tMov<T>, CFDINominaRecibo:Nomina.Mov))<BR><BR>ReportePDF(Info.Reporte, CFDINominaRecibo:CFDINominaRecibo.ID, CFDINominaRecibo:CFDINominaRecibo.Personal, CFDINominaRecibo:CFDINominaRecibo.ArchivoPDF)<BR><BR>EjecutarSQL(<T>EXEC spCFDINominaGeneroPDF :nID, :tPersonal<T>, CFDINominaRecibo:CFDINominaRecibo.ID, CFDINominaRecibo:CFDINominaRecibo.Personal)
[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
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
NombreDesplegar=Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S










































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
























[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreEnBoton=S
NombreDesplegar=Actualizar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

EspacioPrevio=S































Expresion=<BR>  EjecutarSQL(<T>EXEC spActualizarCorreo<T>)<BR>Forma.ActualizarArbol(<T>Lista<T>)<BR>ActualizarVista<BR>ActualizarForma
[Acciones.RegenerarXML]
Nombre=RegenerarXML
Boton=0
NombreDesplegar=Regenerar XML
EnLote=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S










Expresion=ProcesarSQL(<T>EXEC spCFDINominaRegenerarXML :nID, :tPersonal<T>, CFDINominaRecibo:CFDINominaRecibo.ID, CFDINominaRecibo:CFDINominaRecibo.Personal)
[Acciones.Enviar]
Nombre=Enviar
Boton=0
NombreDesplegar=Enviar
EnLote=S
EnMenu=S
TipoAccion=Expresion
Visible=S














































































Antes=S
Expresion=Asigna(Temp.texto,Sql(<T>SELECT MedioEnvio FROM EMPRESACFDNOMINA WHERE Empresa=:tEmpresa<T>,EMPRESA) )<BR>Si<BR>  sql(<T>SELECT EnviarPDFNomina FROM EMPRESACFD WHERE Empresa=:tEmpresa<T>,EMPRESA)<BR>Entonces<BR>  Si<BR>    CFDINominaRecibo:CFDINominaRecibo.PDFGenerado<BR>  Entonces<BR>    Si<BR>     Temp.texto=<T>IntelisisCFDI<T><BR>    Entonces<BR>       EjecutarSQL(<T>EXEC spEnviarReciboNominaCFDI :tEmpresa,:nID,:tPersonal,:tAcceso<T>,Empresa, CFDINominaRecibo:CFDINominaRecibo.RID,CFDINominaRecibo:CFDINominaRecibo.Personal,EstacionTrabajo )<BR>    Sino<BR>       EjecutarSQL(<T>EXEC spEnviarReciboNomina :tEmpresa,:nID,:tPersonal,:tAcceso<T>,Empresa, CFDINominaRecibo:CFDINominaRecibo.RID,CFDINominaRecibo:CFDINominaRecibo.Personal,EstacionTrabajo )<BR>    Fin<BR>                                        <BR>  Sino<BR>    Falso<BR>     Error( <T>Error al enviar al Personal: <T>+ CFDINominaRecibo:CFDINominaRecibo.Personal +<T>, falta generar PDF<T> )<BR>   Fin<BR> Fin<BR><BR>Si<BR> sql(<T>SELECT    CASE    WHEN count(id) <= 0 THEN 1  else  0  END FROM ListaModuloID where Estacion = :testacion <T>, EstacionTrabajo )<BR>Entonces<BR>  Asigna(Temp.texto,<T>PROCESO CONCLUIDO<T>)<BR>informacion(temp.texto)<BR>Sino<BR>  Asigna(Temp.texto,<T><T>)                                              <BR><BR>Fin
ActivoCondicion=(CFDINominaRecibo:CFDINominaRecibo.Timbrado =<T>Timbrado<T>)y (sql(<T>SELECT EnviarNomina FROM EMPRESACFD WHERE Empresa=:tEmpresa<T>,EMPRESA))
AntesExpresiones=RegistrarSeleccionModuloID(<T>Lista<T>, <T>CFDINominaRecibo.Personal<T>, <T>CFDINominaRecibo.RID<T>)
[Lista.CFDINominaRecibo.EnviarMail]
Carpeta=Lista
Clave=CFDINominaRecibo.EnviarMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco












[Lista.CFDINominaRecibo.EnviarMailSql]
Carpeta=Lista
Clave=CFDINominaRecibo.EnviarMailSql
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco




































































































[Lista.ListaEnCaptura]
(Inicio)=NombrePersonal
NombrePersonal=CFDINominaRecibo.EnviarMail
CFDINominaRecibo.EnviarMail=CFDINominaRecibo.EnviarMailSql
CFDINominaRecibo.EnviarMailSql=CFDINominaRecibo.TotalPercepciones
CFDINominaRecibo.TotalPercepciones=CFDINominaRecibo.PercepcionesTotalGravado
CFDINominaRecibo.PercepcionesTotalGravado=CFDINominaRecibo.PercepcionesTotalExcento
CFDINominaRecibo.PercepcionesTotalExcento=CFDINominaRecibo.TotalDeducciones
CFDINominaRecibo.TotalDeducciones=CFDINominaRecibo.DeduccionesTotalGravado
CFDINominaRecibo.DeduccionesTotalGravado=CFDINominaRecibo.DeduccionesTotalExcento
CFDINominaRecibo.DeduccionesTotalExcento=CFDINominaRecibo.TotalDescuento
CFDINominaRecibo.TotalDescuento=(Fin)

[Lista.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=QuitarSeleccion
QuitarSeleccion=GenerarRecibo
GenerarRecibo=RegenerarXML
RegenerarXML=Enviar
Enviar=(Fin)















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Actualizar
Actualizar=MostrarCampos
MostrarCampos=(Fin)
