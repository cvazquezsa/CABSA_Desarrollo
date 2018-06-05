

[Forma]
Clave=CFDIRetencionEmpresa
Icono=0
Modulos=(Todos)
PosicionInicialAlturaCliente=508
PosicionInicialAncho=810
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=(Lista)
CarpetaPrincipal=General
PosicionInicialIzquierda=236
PosicionInicialArriba=90
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Nombre=CFDI Retenciones - Configuración Timbrado
Comentarios=Empresa
Menus=S
MenuPrincipal=&Maestros
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



[Lista.ListaEnCaptura]
(Inicio)=CFDIRetencionEmpresa.CFDIClaveRiesgo
CFDIRetencionEmpresa.CFDIClaveRiesgo=CFDINominaRiesgoPuesto.Descripcion
CFDINominaRiesgoPuesto.Descripcion=CFDIRetencionEmpresa.RutaGenerarQRCode
CFDIRetencionEmpresa.RutaGenerarQRCode=CFDIRetencionEmpresa.RetencionAlmacenarRuta
CFDIRetencionEmpresa.RetencionAlmacenarRuta=CFDIRetencionEmpresa.RetencionNombre
CFDIRetencionEmpresa.RetencionNombre=(Fin)




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
Vista=CFDIRetencionEmpresa
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



FiltroGeneral=CFDIRetencionEmpresa.Empresa = <T>{Empresa}<T>
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
Vista=CFDIRetencionEmpresa
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

[Almacenar.CFDIRetencionEmpresa.RetencionAlmacenarRuta]
Carpeta=Almacenar
Clave=CFDIRetencionEmpresa.RetencionAlmacenarRuta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=71
ColorFondo=Blanco

[Almacenar.CFDIRetencionEmpresa.RetencionNombre]
Carpeta=Almacenar
Clave=CFDIRetencionEmpresa.RetencionNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=71
ColorFondo=Blanco



[Almacenar.Columnas]
RetencionAlmacenarRuta=604
RetencionNombre=604






[Timbrar.CFDIRetencionEmpresa.Llave]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.Llave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[Timbrar.CFDIRetencionEmpresa.RutaCertificado]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.RutaCertificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[Timbrar.CFDIRetencionEmpresa.RutaANSIToUTF]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.RutaANSIToUTF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco


[Timbrar.CFDIRetencionEmpresa.TimbrarCFDIPassword]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.TimbrarCFDIPassword
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Timbrar.CFDIRetencionEmpresa.TimbrarCFDIServidor]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.TimbrarCFDIServidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

EspacioPrevio=S
[Timbrar.CFDIRetencionEmpresa.TimbrarCFDIUsuario]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.TimbrarCFDIUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[Timbrar.CFDIRetencionEmpresa.TimeOutTimbrado]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.TimeOutTimbrado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
[Timbrar.CFDIRetencionEmpresa.ModoPruebas]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.ModoPruebas
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20
[Timbrar.CFDIRetencionEmpresa.RutaGenerarQRCode]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.RutaGenerarQRCode
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
























[Timbrar.CFDIRetencionEmpresa.noCertificado]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.noCertificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
















EspacioPrevio=S
[Timbrar.CFDIRetencionEmpresa.RutaIntelisisCFDI]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.RutaIntelisisCFDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco























[Timbrar.CFDIRetencionEmpresa.ContrasenaLlave]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.ContrasenaLlave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
































[Timbrar.CFDIRetencionEmpresa.CancelarCFDIUsuario]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.CancelarCFDIUsuario
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco




ValidaNombre=S



Pegado=N


















[Timbrar.CFDIRetencionEmpresa.CancelarCFDIPassword]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.CancelarCFDIPassword
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=30
ColorFondo=Blanco

LineaNueva=S






[Timbrar.CFDIRetencionEmpresa.CancelarCFDIToken]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.CancelarCFDIToken
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Timbrar.CFDIRetencionEmpresa.CancelarCFDICuenta]
Carpeta=Timbrar
Clave=CFDIRetencionEmpresa.CancelarCFDICuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco























[General.CFDIRetencionEmpresa.EnviarRetencion]
Carpeta=General
Clave=CFDIRetencionEmpresa.EnviarRetencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Tamano=60
[Almacenar.CFDIRetencionEmpresa.EnviarXMLRetencion]
Carpeta=Almacenar
Clave=CFDIRetencionEmpresa.EnviarXMLRetencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Almacenar.CFDIRetencionEmpresa.EnviarPDFRetencion]
Carpeta=Almacenar
Clave=CFDIRetencionEmpresa.EnviarPDFRetencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Almacenar.CFDIRetencionEmpresa.EnviarAsuntoRetencion]
Carpeta=Almacenar
Clave=CFDIRetencionEmpresa.EnviarAsuntoRetencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco

[Almacenar.CFDIRetencionEmpresa.EnviarMensajeRetencion]
Carpeta=Almacenar
Clave=CFDIRetencionEmpresa.EnviarMensajeRetencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80X15
ColorFondo=Blanco

























[Timbrar.ListaEnCaptura]
(Inicio)=CFDIRetencionEmpresa.Llave
CFDIRetencionEmpresa.Llave=CFDIRetencionEmpresa.RutaCertificado
CFDIRetencionEmpresa.RutaCertificado=CFDIRetencionEmpresa.RutaANSIToUTF
CFDIRetencionEmpresa.RutaANSIToUTF=CFDIRetencionEmpresa.RutaIntelisisCFDI
CFDIRetencionEmpresa.RutaIntelisisCFDI=CFDIRetencionEmpresa.RutaGenerarQRCode
CFDIRetencionEmpresa.RutaGenerarQRCode=CFDIRetencionEmpresa.TimbrarCFDIServidor
CFDIRetencionEmpresa.TimbrarCFDIServidor=CFDIRetencionEmpresa.TimbrarCFDIUsuario
CFDIRetencionEmpresa.TimbrarCFDIUsuario=CFDIRetencionEmpresa.TimbrarCFDIPassword
CFDIRetencionEmpresa.TimbrarCFDIPassword=CFDIRetencionEmpresa.CancelarCFDIUsuario
CFDIRetencionEmpresa.CancelarCFDIUsuario=CFDIRetencionEmpresa.CancelarCFDIPassword
CFDIRetencionEmpresa.CancelarCFDIPassword=CFDIRetencionEmpresa.CancelarCFDIToken
CFDIRetencionEmpresa.CancelarCFDIToken=CFDIRetencionEmpresa.CancelarCFDICuenta
CFDIRetencionEmpresa.CancelarCFDICuenta=CFDIRetencionEmpresa.noCertificado
CFDIRetencionEmpresa.noCertificado=CFDIRetencionEmpresa.ContrasenaLlave
CFDIRetencionEmpresa.ContrasenaLlave=CFDIRetencionEmpresa.TimeOutTimbrado
CFDIRetencionEmpresa.TimeOutTimbrado=CFDIRetencionEmpresa.ModoPruebas
CFDIRetencionEmpresa.ModoPruebas=(Fin)





















[General.CFDIRetencionEmpresa.UsarTimbrarRetencion]
Carpeta=General
Clave=CFDIRetencionEmpresa.UsarTimbrarRetencion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco




Tamano=40


[TimbrarNomina.ListaEnCaptura]
(Inicio)=EmpresaCFDRetencion.Llave
EmpresaCFDRetencion.Llave=EmpresaCFDRetencion.Certificado
EmpresaCFDRetencion.Certificado=EmpresaCFDRetencion.ContrasenaLlave
EmpresaCFDRetencion.ContrasenaLlave=EmpresaCFDRetencion.TimbrarCFDIServidor
EmpresaCFDRetencion.TimbrarCFDIServidor=EmpresaCFDRetencion.TimbrarCFDIUsuario
EmpresaCFDRetencion.TimbrarCFDIUsuario=EmpresaCFDRetencion.TimbrarCFDIPassword
EmpresaCFDRetencion.TimbrarCFDIPassword=EmpresaCFDRetencion.CancelarCFDIUsuario
EmpresaCFDRetencion.CancelarCFDIUsuario=EmpresaCFDRetencion.CancelarCFDIPassword
EmpresaCFDRetencion.CancelarCFDIPassword=EmpresaCFDRetencion.CancelarCFDIToken
EmpresaCFDRetencion.CancelarCFDIToken=EmpresaCFDRetencion.CancelarCFDICuenta
EmpresaCFDRetencion.CancelarCFDICuenta=EmpresaCFDRetencion.ModoPruebas
EmpresaCFDRetencion.ModoPruebas=(Fin)














[TimbrarRetencion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Timbrar Retención
Clave=TimbrarRetencion
PermiteEditar=S
GuardarAlSalir=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFDRetencion
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


Detalle=S
VistaMaestra=CFDIRetencionEmpresa
LlaveLocal=EmpresaCFDRetencion.Empresa
LlaveMaestra=CFDIRetencionEmpresa.Empresa
CondicionVisible=CFDIRetencionEmpresa:CFDIRetencionEmpresa.UsarTimbrarRetencion
[TimbrarRetencion.EmpresaCFDRetencion.Llave]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.Llave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70
ColorFondo=Blanco

EspacioPrevio=S
[TimbrarRetencion.EmpresaCFDRetencion.Certificado]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.Certificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70
ColorFondo=Blanco

[TimbrarRetencion.EmpresaCFDRetencion.ContrasenaLlave]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.ContrasenaLlave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[TimbrarRetencion.EmpresaCFDRetencion.TimbrarCFDIServidor]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.TimbrarCFDIServidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[TimbrarRetencion.EmpresaCFDRetencion.TimbrarCFDIUsuario]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.TimbrarCFDIUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[TimbrarRetencion.EmpresaCFDRetencion.TimbrarCFDIPassword]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.TimbrarCFDIPassword
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[TimbrarRetencion.EmpresaCFDRetencion.CancelarCFDIUsuario]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.CancelarCFDIUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[TimbrarRetencion.EmpresaCFDRetencion.CancelarCFDIPassword]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.CancelarCFDIPassword
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[TimbrarRetencion.EmpresaCFDRetencion.CancelarCFDIToken]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.CancelarCFDIToken
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[TimbrarRetencion.EmpresaCFDRetencion.CancelarCFDICuenta]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.CancelarCFDICuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[TimbrarRetencion.EmpresaCFDRetencion.ModoPruebas]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.ModoPruebas
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco




Tamano=15
[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=CFDINominaRiesgoPuesto
CFDINominaRiesgoPuesto=(Fin)














[TimbrarRetencion.EmpresaCFDRetencion.RutaIntelisisCFDI]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.RutaIntelisisCFDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70
ColorFondo=Blanco

[TimbrarRetencion.EmpresaCFDRetencion.TimeOutTimbrado]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.TimeOutTimbrado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Almacenar.ListaEnCaptura]
(Inicio)=CFDIRetencionEmpresa.RetencionAlmacenarRuta
CFDIRetencionEmpresa.RetencionAlmacenarRuta=CFDIRetencionEmpresa.RetencionNombre
CFDIRetencionEmpresa.RetencionNombre=CFDIRetencionEmpresa.EnviarXMLRetencion
CFDIRetencionEmpresa.EnviarXMLRetencion=CFDIRetencionEmpresa.EnviarPDFRetencion
CFDIRetencionEmpresa.EnviarPDFRetencion=CFDIRetencionEmpresa.EnviarAsuntoRetencion
CFDIRetencionEmpresa.EnviarAsuntoRetencion=CFDIRetencionEmpresa.EnviarMensajeRetencion
CFDIRetencionEmpresa.EnviarMensajeRetencion=(Fin)




[General.ListaEnCaptura]
(Inicio)=CFDIRetencionEmpresa.EnviarRetencion
CFDIRetencionEmpresa.EnviarRetencion=CFDIRetencionEmpresa.UsarTimbrarRetencion
CFDIRetencionEmpresa.UsarTimbrarRetencion=(Fin)





[TimbrarRetencion.EmpresaCFDRetencion.RutaANSIToUTF]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.RutaANSIToUTF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70
ColorFondo=Blanco

[TimbrarRetencion.EmpresaCFDRetencion.RutaGenerarQRCode]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.RutaGenerarQRCode
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70
ColorFondo=Blanco












[TimbrarRetencion.ListaEnCaptura]
(Inicio)=EmpresaCFDRetencion.RutaIntelisisCFDI
EmpresaCFDRetencion.RutaIntelisisCFDI=EmpresaCFDRetencion.RutaANSIToUTF
EmpresaCFDRetencion.RutaANSIToUTF=EmpresaCFDRetencion.RutaGenerarQRCode
EmpresaCFDRetencion.RutaGenerarQRCode=EmpresaCFDRetencion.TimeOutTimbrado
EmpresaCFDRetencion.TimeOutTimbrado=EmpresaCFDRetencion.Llave
EmpresaCFDRetencion.Llave=EmpresaCFDRetencion.ContrasenaLlave
EmpresaCFDRetencion.ContrasenaLlave=EmpresaCFDRetencion.Certificado
EmpresaCFDRetencion.Certificado=EmpresaCFDRetencion.noCertificado
EmpresaCFDRetencion.noCertificado=EmpresaCFDRetencion.TimbrarCFDIServidor
EmpresaCFDRetencion.TimbrarCFDIServidor=EmpresaCFDRetencion.TimbrarCFDIUsuario
EmpresaCFDRetencion.TimbrarCFDIUsuario=EmpresaCFDRetencion.TimbrarCFDIPassword
EmpresaCFDRetencion.TimbrarCFDIPassword=EmpresaCFDRetencion.CancelarCFDIUsuario
EmpresaCFDRetencion.CancelarCFDIUsuario=EmpresaCFDRetencion.CancelarCFDIPassword
EmpresaCFDRetencion.CancelarCFDIPassword=EmpresaCFDRetencion.CancelarCFDIToken
EmpresaCFDRetencion.CancelarCFDIToken=EmpresaCFDRetencion.CancelarCFDICuenta
EmpresaCFDRetencion.CancelarCFDICuenta=EmpresaCFDRetencion.ModoPruebas
EmpresaCFDRetencion.ModoPruebas=(Fin)

[TimbrarRetencion.EmpresaCFDRetencion.noCertificado]
Carpeta=TimbrarRetencion
Clave=EmpresaCFDRetencion.noCertificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco











[Forma.ListaCarpetas]
(Inicio)=General
General=Almacenar
Almacenar=TimbrarRetencion
TimbrarRetencion=(Fin)
