
[Forma]
Clave=CFDINominaEmpresa
Icono=0
Modulos=(Todos)
PosicionInicialAlturaCliente=561
PosicionInicialAncho=1022
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=(Lista)
CarpetaPrincipal=General
PosicionInicialIzquierda=153
PosicionInicialArriba=64
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Nombre=CFDI Nómina - Configuración Empresa
Comentarios=Empresa
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



[Lista.Columnas]
CFDIClaveRiesgo=66

Clave=64
Descripcion=391


[Acciones.CFDINominaRiesgoPuesto]
Nombre=CFDINominaRiesgoPuesto
Boton=0
Menu=&Maestros
NombreDesplegar=&Riesgos
EnMenu=S
TipoAccion=Formas
ClaveAccion=CFDINominaRiesgoPuesto
Activo=S
Visible=S
















[Lista.ListaEnCaptura]
(Inicio)=CFDINominaEmpresa.CFDIClaveRiesgo
CFDINominaEmpresa.CFDIClaveRiesgo=CFDINominaRiesgoPuesto.Descripcion
CFDINominaRiesgoPuesto.Descripcion=CFDINominaEmpresa.RutaGenerarQRCode
CFDINominaEmpresa.RutaGenerarQRCode=CFDINominaEmpresa.NominaAlmacenarRuta
CFDINominaEmpresa.NominaAlmacenarRuta=CFDINominaEmpresa.NominaNombre
CFDINominaEmpresa.NominaNombre=(Fin)




[General]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=General
Clave=General
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaEmpresa
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=218
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=CFDINominaEmpresa.Empresa = <T>{Empresa}<T>
[General.CFDINominaEmpresa.CFDIClaveRiesgo]
Carpeta=General
Clave=CFDINominaEmpresa.CFDIClaveRiesgo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[General.CFDINominaRiesgoPuesto.Descripcion]
Carpeta=General
Clave=CFDINominaRiesgoPuesto.Descripcion
3D=S
Tamano=60
ColorFondo=Blanco



[Almacenar]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Almacenar
Clave=Almacenar
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaEmpresa
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

ListaEnCaptura=(Lista)
FichaEspacioEntreLineas=6
FichaEspacioNombres=67
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

[Almacenar.CFDINominaEmpresa.NominaAlmacenarRuta]
Carpeta=Almacenar
Clave=CFDINominaEmpresa.NominaAlmacenarRuta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=71
ColorFondo=Blanco

[Almacenar.CFDINominaEmpresa.NominaNombre]
Carpeta=Almacenar
Clave=CFDINominaEmpresa.NominaNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=71
ColorFondo=Blanco



[Almacenar.Columnas]
NominaAlmacenarRuta=604
NominaNombre=604






[Timbrar.CFDINominaEmpresa.Llave]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.Llave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[Timbrar.CFDINominaEmpresa.RutaCertificado]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.RutaCertificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[Timbrar.CFDINominaEmpresa.RutaANSIToUTF]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.RutaANSIToUTF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco


[Timbrar.CFDINominaEmpresa.TimbrarCFDIPassword]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.TimbrarCFDIPassword
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Timbrar.CFDINominaEmpresa.TimbrarCFDIServidor]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.TimbrarCFDIServidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

EspacioPrevio=S
[Timbrar.CFDINominaEmpresa.TimbrarCFDIUsuario]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.TimbrarCFDIUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[Timbrar.CFDINominaEmpresa.TimeOutTimbrado]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.TimeOutTimbrado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
[Timbrar.CFDINominaEmpresa.ModoPruebas]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.ModoPruebas
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20
[Timbrar.CFDINominaEmpresa.RutaGenerarQRCode]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.RutaGenerarQRCode
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco



[Timbrar.Columnas]
Llave=604
RutaCertificado=604
RutaANSIToUTF=604
RutaTimbrarCFDI=604
TimbrarCFDIPassword=604
TimbrarCFDIServidor=604
TimbrarCFDIUsuario=604
ContrasenakeyCSD=604
TimeOutTimbrado=94
ModoPruebas=72
RutaGenerarQRCode=604
























[Timbrar.CFDINominaEmpresa.noCertificado]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.noCertificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
















EspacioPrevio=S
[Timbrar.CFDINominaEmpresa.RutaIntelisisCFDI]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.RutaIntelisisCFDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco























[Timbrar.CFDINominaEmpresa.ContrasenaLlave]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.ContrasenaLlave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
































[Timbrar.CFDINominaEmpresa.CancelarCFDIUsuario]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.CancelarCFDIUsuario
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco




ValidaNombre=S



Pegado=N


















[Timbrar.CFDINominaEmpresa.CancelarCFDIPassword]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.CancelarCFDIPassword
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=30
ColorFondo=Blanco

LineaNueva=S






[Timbrar.CFDINominaEmpresa.CancelarCFDIToken]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.CancelarCFDIToken
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Timbrar.CFDINominaEmpresa.CancelarCFDICuenta]
Carpeta=Timbrar
Clave=CFDINominaEmpresa.CancelarCFDICuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco























[General.CFDINominaEmpresa.EnviarNomina]
Carpeta=General
Clave=CFDINominaEmpresa.EnviarNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Tamano=60
[Almacenar.CFDINominaEmpresa.EnviarXMLNomina]
Carpeta=Almacenar
Clave=CFDINominaEmpresa.EnviarXMLNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Almacenar.CFDINominaEmpresa.EnviarPDFNomina]
Carpeta=Almacenar
Clave=CFDINominaEmpresa.EnviarPDFNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Almacenar.CFDINominaEmpresa.EnviarAsuntoNomina]
Carpeta=Almacenar
Clave=CFDINominaEmpresa.EnviarAsuntoNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco

[Almacenar.CFDINominaEmpresa.EnviarMensajeNomina]
Carpeta=Almacenar
Clave=CFDINominaEmpresa.EnviarMensajeNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80X15
ColorFondo=Blanco















[Almacenar.ListaEnCaptura]
(Inicio)=CFDINominaEmpresa.NominaAlmacenarRuta
CFDINominaEmpresa.NominaAlmacenarRuta=CFDINominaEmpresa.NominaNombre
CFDINominaEmpresa.NominaNombre=CFDINominaEmpresa.EnviarXMLNomina
CFDINominaEmpresa.EnviarXMLNomina=CFDINominaEmpresa.EnviarPDFNomina
CFDINominaEmpresa.EnviarPDFNomina=CFDINominaEmpresa.EnviarAsuntoNomina
CFDINominaEmpresa.EnviarAsuntoNomina=CFDINominaEmpresa.EnviarMensajeNomina
CFDINominaEmpresa.EnviarMensajeNomina=(Fin)


























[General.CFDINominaEmpresa.NominaEditarFechaPago]
Carpeta=General
Clave=CFDINominaEmpresa.NominaEditarFechaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco














[TimbrarNomina.Columnas]
Empresa=45
Llave=604
Certificado=604
ContrasenaSello=604
ModoPruebas=69
TimbrarCFDIServidor=604
TimbrarCFDIUusario=604
TimbrarCFDIPassword=604
CancelarCFDIUsuario=604
CancelarCFDIPassword=604
ContrasenakeyCSD=604
CancelarCFDIToken=604
CancelarCFDICuenta=604











[Timbrar.ListaEnCaptura]
(Inicio)=CFDINominaEmpresa.Llave
CFDINominaEmpresa.Llave=CFDINominaEmpresa.RutaCertificado
CFDINominaEmpresa.RutaCertificado=CFDINominaEmpresa.RutaANSIToUTF
CFDINominaEmpresa.RutaANSIToUTF=CFDINominaEmpresa.RutaIntelisisCFDI
CFDINominaEmpresa.RutaIntelisisCFDI=CFDINominaEmpresa.RutaGenerarQRCode
CFDINominaEmpresa.RutaGenerarQRCode=CFDINominaEmpresa.TimbrarCFDIServidor
CFDINominaEmpresa.TimbrarCFDIServidor=CFDINominaEmpresa.TimbrarCFDIUsuario
CFDINominaEmpresa.TimbrarCFDIUsuario=CFDINominaEmpresa.TimbrarCFDIPassword
CFDINominaEmpresa.TimbrarCFDIPassword=CFDINominaEmpresa.CancelarCFDIUsuario
CFDINominaEmpresa.CancelarCFDIUsuario=CFDINominaEmpresa.CancelarCFDIPassword
CFDINominaEmpresa.CancelarCFDIPassword=CFDINominaEmpresa.CancelarCFDIToken
CFDINominaEmpresa.CancelarCFDIToken=CFDINominaEmpresa.CancelarCFDICuenta
CFDINominaEmpresa.CancelarCFDICuenta=CFDINominaEmpresa.noCertificado
CFDINominaEmpresa.noCertificado=CFDINominaEmpresa.ContrasenaLlave
CFDINominaEmpresa.ContrasenaLlave=CFDINominaEmpresa.TimeOutTimbrado
CFDINominaEmpresa.TimeOutTimbrado=CFDINominaEmpresa.ModoPruebas
CFDINominaEmpresa.ModoPruebas=(Fin)















[TimbrarNomina.EmpresaCFDNomina.TimbrarCFDIServidor]
Carpeta=TimbrarNomina
Clave=EmpresaCFDNomina.TimbrarCFDIServidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco




[TimbrarNomina.EmpresaCFDNomina.CancelarCFDIUsuario]
Carpeta=TimbrarNomina
Clave=EmpresaCFDNomina.CancelarCFDIUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco




[TimbrarNomina.EmpresaCFDNomina.CancelarCFDIPassword]
Carpeta=TimbrarNomina
Clave=EmpresaCFDNomina.CancelarCFDIPassword
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[TimbrarNomina.EmpresaCFDNomina.CancelarCFDIToken]
Carpeta=TimbrarNomina
Clave=EmpresaCFDNomina.CancelarCFDIToken
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[TimbrarNomina.EmpresaCFDNomina.CancelarCFDICuenta]
Carpeta=TimbrarNomina
Clave=EmpresaCFDNomina.CancelarCFDICuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco




[TimbrarNomina.EmpresaCFDNomina.TimbrarCFDIUsuario]
Carpeta=TimbrarNomina
Clave=EmpresaCFDNomina.TimbrarCFDIUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[TimbrarNomina.EmpresaCFDNomina.Llave]
Carpeta=TimbrarNomina
Clave=EmpresaCFDNomina.Llave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70
ColorFondo=Blanco

[TimbrarNomina.EmpresaCFDNomina.Certificado]
Carpeta=TimbrarNomina
Clave=EmpresaCFDNomina.Certificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70
ColorFondo=Blanco




[TimbrarNomina.EmpresaCFDNomina.ContrasenaLlave]
Carpeta=TimbrarNomina
Clave=EmpresaCFDNomina.ContrasenaLlave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[TimbrarNomina.EmpresaCFDNomina.TimbrarCFDIPassword]
Carpeta=TimbrarNomina
Clave=EmpresaCFDNomina.TimbrarCFDIPassword
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[TimbrarNomina.EmpresaCFDNomina.ModoPruebas]
Carpeta=TimbrarNomina
Clave=EmpresaCFDNomina.ModoPruebas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



















[General.CFDINominaEmpresa.UsarTimbrarNomina]
Carpeta=General
Clave=CFDINominaEmpresa.UsarTimbrarNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




Tamano=30


[TimbrarNomina.ListaEnCaptura]
(Inicio)=EmpresaCFDNomina.Llave
EmpresaCFDNomina.Llave=EmpresaCFDNomina.Certificado
EmpresaCFDNomina.Certificado=EmpresaCFDNomina.ContrasenaLlave
EmpresaCFDNomina.ContrasenaLlave=EmpresaCFDNomina.TimbrarCFDIServidor
EmpresaCFDNomina.TimbrarCFDIServidor=EmpresaCFDNomina.TimbrarCFDIUsuario
EmpresaCFDNomina.TimbrarCFDIUsuario=EmpresaCFDNomina.TimbrarCFDIPassword
EmpresaCFDNomina.TimbrarCFDIPassword=EmpresaCFDNomina.CancelarCFDIUsuario
EmpresaCFDNomina.CancelarCFDIUsuario=EmpresaCFDNomina.CancelarCFDIPassword
EmpresaCFDNomina.CancelarCFDIPassword=EmpresaCFDNomina.CancelarCFDIToken
EmpresaCFDNomina.CancelarCFDIToken=EmpresaCFDNomina.CancelarCFDICuenta
EmpresaCFDNomina.CancelarCFDICuenta=EmpresaCFDNomina.ModoPruebas
EmpresaCFDNomina.ModoPruebas=(Fin)










[General.ListaEnCaptura]
(Inicio)=CFDINominaEmpresa.CFDIClaveRiesgo
CFDINominaEmpresa.CFDIClaveRiesgo=CFDINominaRiesgoPuesto.Descripcion
CFDINominaRiesgoPuesto.Descripcion=CFDINominaEmpresa.EnviarNomina
CFDINominaEmpresa.EnviarNomina=CFDINominaEmpresa.NominaEditarFechaPago
CFDINominaEmpresa.NominaEditarFechaPago=CFDINominaEmpresa.UsarTimbrarNomina
CFDINominaEmpresa.UsarTimbrarNomina=(Fin)









[Acciones.TimbrarNomina]
Nombre=TimbrarNomina
Boton=-1
NombreDesplegar=Timbrar Nómina
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
Activo=S

NombreEnBoton=S
ClaveAccion=EmpresaCFDNomina






















EspacioPrevio=S




VisibleCondicion=CFDINominaEmpresa:CFDINominaEmpresa.UsarTimbrarNomina












[Forma.ListaCarpetas]
(Inicio)=General
General=Almacenar
Almacenar=(Fin)

[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=CFDINominaRiesgoPuesto
CFDINominaRiesgoPuesto=TimbrarNomina
TimbrarNomina=(Fin)
