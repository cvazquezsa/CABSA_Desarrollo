
[Forma]
Clave=EmpresaCFDFlex
Icono=0
Modulos=(Todos)
Nombre=Configuración CFD Flexible

ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=126
PosicionInicialArriba=85
PosicionInicialAlturaCliente=520
PosicionInicialAncho=1114
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Comentarios=Lista(Info.Empresa)
PosicionSec1=194
[Ficha]
Estilo=Ficha
Clave=Ficha
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFDFlex
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ListaEnCaptura=(Lista)


Pestana=S
PestanaOtroNombre=S
PestanaNombre=General
FiltroGeneral=EmpresaCFDFlex.Empresa = {Comillas(Info.Empresa)}
[Ficha.EmpresaCFDFlex.noCertificado]
Carpeta=Ficha
Clave=EmpresaCFDFlex.noCertificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.EmpresaCFDFlex.CertificadoBase64]
Carpeta=Ficha
Clave=EmpresaCFDFlex.CertificadoBase64
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=100x6
[Ficha.EmpresaCFDFlex.ContrasenaSello]
Carpeta=Ficha
Clave=EmpresaCFDFlex.ContrasenaSello
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.EmpresaCFDFlex.Llave]
Carpeta=Ficha
Clave=EmpresaCFDFlex.Llave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Ficha.EmpresaCFDFlex.RutaFirmaSAT]
Carpeta=Ficha
Clave=EmpresaCFDFlex.RutaFirmaSAT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Ficha.EmpresaCFDFlex.RutaCertificado]
Carpeta=Ficha
Clave=EmpresaCFDFlex.RutaCertificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Ficha.EmpresaCFDFlex.RutaTemporal]
Carpeta=Ficha
Clave=EmpresaCFDFlex.RutaTemporal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S




[Acciones.Registrar]
Nombre=Registrar
Boton=83
NombreEnBoton=S
NombreDesplegar=&Registrar Certificado
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S



























Expresion=ProcesarSQL(<T>EXEC spCFDFlexRegistrarCertificadoXML :nEstacion, :tEmpresa, :tSucursal, :tTipo, 0<T>,EstacionTrabajo,Info.Empresa, Sucursal, <T>Empresa<T>)<BR>ActualizarForma
[Ficha.EmpresaCFDFlex.RutaANSIToUTF]
Carpeta=Ficha
Clave=EmpresaCFDFlex.RutaANSIToUTF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco





[Ficha.EmpresaCFDFlex.EAN13]
Carpeta=Ficha
Clave=EmpresaCFDFlex.EAN13
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



















[Ficha.EmpresaCFDFlex.EnviarAlAfectar]
Carpeta=Ficha
Clave=EmpresaCFDFlex.EnviarAlAfectar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Mensaje]
Estilo=Ficha
Pestana=S
Clave=Mensaje
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFDFlex
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=122
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
PestanaNombre=Almacenar y Enviar

CarpetaVisible=S
FiltroGeneral=EmpresaCFDFlex.Empresa = {Comillas(Empresa)}
[Mensaje.EmpresaCFDFlex.EnviarAsunto]
Carpeta=Mensaje
Clave=EmpresaCFDFlex.EnviarAsunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

EspacioPrevio=N
[Mensaje.EmpresaCFDFlex.EnviarMensaje]
Carpeta=Mensaje
Clave=EmpresaCFDFlex.EnviarMensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x3
ColorFondo=Blanco







[Acciones.ReportesEspecificos]
Nombre=ReportesEspecificos
Boton=57
NombreEnBoton=S
NombreDesplegar=&Reportes Especificos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmpresaCFDReporte
Activo=S
Antes=S
Visible=S






































GuardarAntes=S
[Ficha.EmpresaCFDFlex.SAT_MN]
Carpeta=Ficha
Clave=EmpresaCFDFlex.SAT_MN
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco










[Mensaje.EmpresaCFDFlex.AlmacenarRuta]
Carpeta=Mensaje
Clave=EmpresaCFDFlex.AlmacenarRuta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco






EspacioPrevio=N
[Mensaje.EmpresaCFDFlex.AlmacenarXML]
Carpeta=Mensaje
Clave=EmpresaCFDFlex.AlmacenarXML
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=25
[Mensaje.EmpresaCFDFlex.AlmacenarPDF]
Carpeta=Mensaje
Clave=EmpresaCFDFlex.AlmacenarPDF
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco




Tamano=25
[Mensaje.EmpresaCFDFlex.Nombre]
Carpeta=Mensaje
Clave=EmpresaCFDFlex.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=100
ColorFondo=Blanco
















[Acciones.eMailAutoCampo]
Nombre=eMailAutoCampo
Boton=101
NombreEnBoton=S
NombreDesplegar=&Ayuda Campos eMail
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CFDFlexAyuda
Activo=S
Visible=S



EspacioPrevio=S









Antes=S
AntesExpresiones=Asigna(Info.Tipo,<T>Correo<T>)
[Mensaje.EmpresaCFDFlex.EnviarXML]
Carpeta=Mensaje
Clave=EmpresaCFDFlex.EnviarXML
Editar=S
ValidaNombre=N
3D=S
Tamano=25
ColorFondo=Blanco

[Mensaje.EmpresaCFDFlex.EnviarPDF]
Carpeta=Mensaje
Clave=EmpresaCFDFlex.EnviarPDF
Editar=S
ValidaNombre=N
3D=S
Tamano=25
ColorFondo=Blanco











[Ficha.EmpresaCFDFlex.RutaTimbrarCFDI]
Carpeta=Ficha
Clave=EmpresaCFDFlex.RutaTimbrarCFDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco







[CFDI]
Estilo=Ficha
Pestana=S
Clave=CFDI
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFDFlex
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


PestanaOtroNombre=S
PestanaNombre=CFDI
CondicionVisible=SQL(<T>SELECT ISNULL(CFDI, 0) FROM EmpresaGral WHERE Empresa = :tEmpresa<T>, EmpresaCFDFlex:EmpresaCFDFlex.Empresa)
[CFDI.EmpresaCFDFlex.TimbrarCFDIServidor]
Carpeta=CFDI
Clave=EmpresaCFDFlex.TimbrarCFDIServidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CFDI.EmpresaCFDFlex.TimbrarCFDIUsuario]
Carpeta=CFDI
Clave=EmpresaCFDFlex.TimbrarCFDIUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CFDI.EmpresaCFDFlex.TimbrarCFDIPassword]
Carpeta=CFDI
Clave=EmpresaCFDFlex.TimbrarCFDIPassword
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco










[Jasper]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Jasper Reports
Clave=Jasper
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFDFlex
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


CondicionVisible=(EmpresaCFDFlex:EmpresaCFDFlex.Reporteador=<T>Jasper Reports<T>)
[Jasper.EmpresaCFDFlex.RutaGenerarQRCode]
Carpeta=Jasper
Clave=EmpresaCFDFlex.RutaGenerarQRCode
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




[Acciones.Jasper]
Nombre=Jasper
Boton=51
NombreEnBoton=S
NombreDesplegar=Reportes Jasper
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmpresaCFDJasperReports









GuardarAntes=S





































Visible=S
ActivoCondicion=(EmpresaCFDFlex:EmpresaCFDFlex.Reporteador = <T>Jasper Reports<T> Y EmpresaCFDFlex:EmpresaCFDFlex.EnviarAlAfectar)
[Jasper.EmpresaCFDFlex.RutaJasper]
Carpeta=Jasper
Clave=EmpresaCFDFlex.RutaJasper
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Jasper.EmpresaCFDFlex.JasperFueraLinea]
Carpeta=Jasper
Clave=EmpresaCFDFlex.JasperFueraLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Jasper.EmpresaCFDFlex.Nailgun]
Carpeta=Jasper
Clave=EmpresaCFDFlex.Nailgun
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



















[Acciones.Trabajo]
Nombre=Trabajo
Boton=102
NombreEnBoton=S
NombreDesplegar=Trabajo Jasper
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=JasperTrabajo
Activo=S













GuardarAntes=S
EspacioPrevio=S
VisibleCondicion=(EmpresaCFDFlex:EmpresaCFDFlex.Reporteador = <T>Jasper Reports<T>  y EmpresaCFDFlex:EmpresaCFDFlex.JasperFueraLinea)





[Ficha.EmpresaCFDFlex.MostrarAnexoPDF]
Carpeta=Ficha
Clave=EmpresaCFDFlex.MostrarAnexoPDF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.EmpresaCFDFlex.NoValidarOrigenDocumento]
Carpeta=Ficha
Clave=EmpresaCFDFlex.NoValidarOrigenDocumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Ficha.EmpresaCFDFlex.ToleranciaCalculo]
Carpeta=Ficha
Clave=EmpresaCFDFlex.ToleranciaCalculo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Acciones.ContratoTimbradoAspel]
Nombre=ContratoTimbradoAspel
Boton=56
NombreEnBoton=S
NombreDesplegar=Contrato Timbrado Aspel
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CFDFLexContratoCFDISinFirma
Activo=S





GuardarAntes=S








Multiple=S
ListaAccionesMultiples=Expresion


ConCondicion=S
EspacioPrevio=S
EjecucionCondicion=Asigna(Info.Mensaje,SQL(<T>SELECT ISNULL(ContatoFirmadoAspel, :tVacio) FROM EmpresaCFD WHERE Empresa = :tEmpresa<T>, <T><T>, Info.empresa))
VisibleCondicion=EmpresaCFDFlex.TimbrarCFDIServidor=<T>Aspel<T>
[Acciones.ContratoTimbradoAspel.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



























































































































































Expresion=Si Info.Mensaje = <T> <T><BR>Entonces<BR>  FormaModal(<T>CFDFLexContratoAspel<T>)<BR>Sino<BR>  FormaModal(<T>CFDFLexContratoFirmadoAspel<T>)<BR>Fin

















[CFDI.EmpresaCFDFlex.RutaFirmarContratoAspel]
Carpeta=CFDI
Clave=EmpresaCFDFlex.RutaFirmarContratoAspel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco














[ReportBuilder]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Report Builder
Clave=ReportBuilder
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFDFlex
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


CondicionVisible=(EmpresaCFDFlex:EmpresaCFDFlex.Reporteador=<T>Report Builder<T> )
[ReportBuilder.EmpresaCFDFlex.RutaGenerarQRCode]
Carpeta=ReportBuilder
Clave=EmpresaCFDFlex.RutaGenerarQRCode
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[ReportBuilder.EmpresaCFDFlex.RutaReportBuilder]
Carpeta=ReportBuilder
Clave=EmpresaCFDFlex.RutaReportBuilder
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco















[Acciones.ReportBuilder]
Nombre=ReportBuilder
Boton=51
NombreDesplegar=Reportes Builder
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EmpresaCFDBuilder



















NombreEnBoton=S


















EspacioPrevio=S




Visible=S
ActivoCondicion=(EmpresaCFDFlex:EmpresaCFDFlex.Reporteador = <T>Report Builder<T> Y EmpresaCFDFlex:EmpresaCFDFlex.EnviarAlAfectar)
[Ficha.EmpresaCFDFlex.Reporteador]
Carpeta=Ficha
Clave=EmpresaCFDFlex.Reporteador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco











[ReporteadorIntelisis]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Reporteador Intelisis
Clave=ReporteadorIntelisis
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFDFlex
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=EmpresaCFDFlex.RutaGenerarQRCode

CondicionVisible=(EmpresaCFDFlex:EmpresaCFDFlex.Reporteador=<T>Reporteador Intelisis<T> )
[ReporteadorIntelisis.EmpresaCFDFlex.RutaGenerarQRCode]
Carpeta=ReporteadorIntelisis
Clave=EmpresaCFDFlex.RutaGenerarQRCode
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco















[Ficha.EmpresaCFDFlex.SKU]
Carpeta=Ficha
Clave=EmpresaCFDFlex.SKU
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.EmpresaCFDFlex.SKUEmpresa]
Carpeta=Ficha
Clave=EmpresaCFDFlex.SKUEmpresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco












[Jasper.ListaEnCaptura]
(Inicio)=EmpresaCFDFlex.RutaGenerarQRCode
EmpresaCFDFlex.RutaGenerarQRCode=EmpresaCFDFlex.RutaJasper
EmpresaCFDFlex.RutaJasper=EmpresaCFDFlex.JasperFueraLinea
EmpresaCFDFlex.JasperFueraLinea=EmpresaCFDFlex.Nailgun
EmpresaCFDFlex.Nailgun=(Fin)

[ReportBuilder.ListaEnCaptura]
(Inicio)=EmpresaCFDFlex.RutaGenerarQRCode
EmpresaCFDFlex.RutaGenerarQRCode=EmpresaCFDFlex.RutaReportBuilder
EmpresaCFDFlex.RutaReportBuilder=(Fin)


[CFDI.EmpresaCFDFlex.CancelarCFDIUsuario]
Carpeta=CFDI
Clave=EmpresaCFDFlex.CancelarCFDIUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[CFDI.EmpresaCFDFlex.CancelarCFDIPassword]
Carpeta=CFDI
Clave=EmpresaCFDFlex.CancelarCFDIPassword
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco






[CFDI.EmpresaCFDFlex.CancelarCFDIToken]
Carpeta=CFDI
Clave=EmpresaCFDFlex.CancelarCFDIToken
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[CFDI.EmpresaCFDFlex.CancelarCFDICuenta]
Carpeta=CFDI
Clave=EmpresaCFDFlex.CancelarCFDICuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[CFDI.EmpresaCFDFlex.ModoPruebas]
Carpeta=CFDI
Clave=EmpresaCFDFlex.ModoPruebas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


















[Ficha.EmpresaCFDFlex.RutaIntelisisCFDI]
Carpeta=Ficha
Clave=EmpresaCFDFlex.RutaIntelisisCFDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




[CFDI.EmpresaCFDFlex.TimeOutTimbrado]
Carpeta=CFDI
Clave=EmpresaCFDFlex.TimeOutTimbrado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[CFDI.EmpresaCFDFlex.NominaTimbrar]
Carpeta=CFDI
Clave=EmpresaCFDFlex.NominaTimbrar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[CFDI.ListaEnCaptura]
(Inicio)=EmpresaCFDFlex.TimbrarCFDIServidor
EmpresaCFDFlex.TimbrarCFDIServidor=EmpresaCFDFlex.TimbrarCFDIUsuario
EmpresaCFDFlex.TimbrarCFDIUsuario=EmpresaCFDFlex.TimbrarCFDIPassword
EmpresaCFDFlex.TimbrarCFDIPassword=EmpresaCFDFlex.RutaFirmarContratoAspel
EmpresaCFDFlex.RutaFirmarContratoAspel=EmpresaCFDFlex.CancelarCFDIUsuario
EmpresaCFDFlex.CancelarCFDIUsuario=EmpresaCFDFlex.CancelarCFDIPassword
EmpresaCFDFlex.CancelarCFDIPassword=EmpresaCFDFlex.CancelarCFDIToken
EmpresaCFDFlex.CancelarCFDIToken=EmpresaCFDFlex.CancelarCFDICuenta
EmpresaCFDFlex.CancelarCFDICuenta=EmpresaCFDFlex.TimeOutTimbrado
EmpresaCFDFlex.TimeOutTimbrado=EmpresaCFDFlex.ModoPruebas
EmpresaCFDFlex.ModoPruebas=EmpresaCFDFlex.NominaTimbrar
EmpresaCFDFlex.NominaTimbrar=(Fin)







































[Enviar.Columnas]
Llave=604
ContrasenaLlave=604
Certificado=604
noCertificado=124
TimbrarCFDIServidor=604
TimbrarCFDIUsuario=604
TimbrarCFDIPassword=604
ModoPruebas=69






MedioEnvio=154
DireccionCorreo=604
ContrasenaCorreo=604
SmtpCorreo=604
PuertoCorreo=604

[Enviar.EmpresaCFDNomina.MedioEnvio]
Carpeta=Enviar
Clave=EmpresaCFDNomina.MedioEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Enviar.EmpresaCFDNomina.DireccionCorreo]
Carpeta=Enviar
Clave=EmpresaCFDNomina.DireccionCorreo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Enviar.EmpresaCFDNomina.ContrasenaCorreo]
Carpeta=Enviar
Clave=EmpresaCFDNomina.ContrasenaCorreo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Enviar.EmpresaCFDNomina.SmtpCorreo]
Carpeta=Enviar
Clave=EmpresaCFDNomina.SmtpCorreo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Enviar.EmpresaCFDNomina.PuertoCorreo]
Carpeta=Enviar
Clave=EmpresaCFDNomina.PuertoCorreo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco























[Ficha.ListaEnCaptura]
(Inicio)=EmpresaCFDFlex.EAN13
EmpresaCFDFlex.EAN13=EmpresaCFDFlex.SKU
EmpresaCFDFlex.SKU=EmpresaCFDFlex.SKUEmpresa
EmpresaCFDFlex.SKUEmpresa=EmpresaCFDFlex.noCertificado
EmpresaCFDFlex.noCertificado=EmpresaCFDFlex.ContrasenaSello
EmpresaCFDFlex.ContrasenaSello=EmpresaCFDFlex.CertificadoBase64
EmpresaCFDFlex.CertificadoBase64=EmpresaCFDFlex.Llave
EmpresaCFDFlex.Llave=EmpresaCFDFlex.RutaFirmaSAT
EmpresaCFDFlex.RutaFirmaSAT=EmpresaCFDFlex.RutaCertificado
EmpresaCFDFlex.RutaCertificado=EmpresaCFDFlex.RutaTemporal
EmpresaCFDFlex.RutaTemporal=EmpresaCFDFlex.RutaANSIToUTF
EmpresaCFDFlex.RutaANSIToUTF=EmpresaCFDFlex.RutaTimbrarCFDI
EmpresaCFDFlex.RutaTimbrarCFDI=EmpresaCFDFlex.RutaIntelisisCFDI
EmpresaCFDFlex.RutaIntelisisCFDI=EmpresaCFDFlex.EnviarAlAfectar
EmpresaCFDFlex.EnviarAlAfectar=EmpresaCFDFlex.ToleranciaCalculo
EmpresaCFDFlex.ToleranciaCalculo=EmpresaCFDFlex.SAT_MN
EmpresaCFDFlex.SAT_MN=EmpresaCFDFlex.NoValidarOrigenDocumento
EmpresaCFDFlex.NoValidarOrigenDocumento=EmpresaCFDFlex.Reporteador
EmpresaCFDFlex.Reporteador=EmpresaCFDFlex.MostrarAnexoPDF
EmpresaCFDFlex.MostrarAnexoPDF=EmpresaCFDFlex.Enviar
EmpresaCFDFlex.Enviar=(Fin)

[Ficha.EmpresaCFDFlex.Enviar]
Carpeta=Ficha
Clave=EmpresaCFDFlex.Enviar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco











































[Enviar.ListaEnCaptura]
(Inicio)=EmpresaCFDNomina.MedioEnvio
EmpresaCFDNomina.MedioEnvio=EmpresaCFDNomina.DireccionCorreo
EmpresaCFDNomina.DireccionCorreo=EmpresaCFDNomina.ContrasenaCorreo
EmpresaCFDNomina.ContrasenaCorreo=EmpresaCFDNomina.SmtpCorreo
EmpresaCFDNomina.SmtpCorreo=EmpresaCFDNomina.PuertoCorreo
EmpresaCFDNomina.PuertoCorreo=(Fin)







[Mensaje.EmpresaCFDFlex.EnviarMedio]
Carpeta=Mensaje
Clave=EmpresaCFDFlex.EnviarMedio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Mensaje.EmpresaCFDFlex.EnviarUsuario]
Carpeta=Mensaje
Clave=EmpresaCFDFlex.EnviarUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Mensaje.EmpresaCFDFlex.EnviarContrasena]
Carpeta=Mensaje
Clave=EmpresaCFDFlex.EnviarContrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Mensaje.EmpresaCFDFlex.EnviarSmtp]
Carpeta=Mensaje
Clave=EmpresaCFDFlex.EnviarSmtp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Mensaje.EmpresaCFDFlex.EnviarPuerto]
Carpeta=Mensaje
Clave=EmpresaCFDFlex.EnviarPuerto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco










[Mensaje.ListaEnCaptura]
(Inicio)=EmpresaCFDFlex.AlmacenarXML
EmpresaCFDFlex.AlmacenarXML=EmpresaCFDFlex.EnviarXML
EmpresaCFDFlex.EnviarXML=EmpresaCFDFlex.AlmacenarPDF
EmpresaCFDFlex.AlmacenarPDF=EmpresaCFDFlex.EnviarPDF
EmpresaCFDFlex.EnviarPDF=EmpresaCFDFlex.AlmacenarRuta
EmpresaCFDFlex.AlmacenarRuta=EmpresaCFDFlex.Nombre
EmpresaCFDFlex.Nombre=EmpresaCFDFlex.EnviarAsunto
EmpresaCFDFlex.EnviarAsunto=EmpresaCFDFlex.EnviarMensaje
EmpresaCFDFlex.EnviarMensaje=EmpresaCFDFlex.EnviarMedio
EmpresaCFDFlex.EnviarMedio=EmpresaCFDFlex.EnviarUsuario
EmpresaCFDFlex.EnviarUsuario=EmpresaCFDFlex.EnviarContrasena
EmpresaCFDFlex.EnviarContrasena=EmpresaCFDFlex.EnviarSmtp
EmpresaCFDFlex.EnviarSmtp=EmpresaCFDFlex.EnviarPuerto
EmpresaCFDFlex.EnviarPuerto=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Mensaje
Mensaje=CFDI
CFDI=Jasper
Jasper=ReportBuilder
ReportBuilder=ReporteadorIntelisis
ReporteadorIntelisis=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Registrar
Registrar=ReportesEspecificos
ReportesEspecificos=eMailAutoCampo
eMailAutoCampo=Jasper
Jasper=ReportBuilder
ReportBuilder=Trabajo
Trabajo=ContratoTimbradoAspel
ContratoTimbradoAspel=(Fin)
