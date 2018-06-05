[Forma]
Clave=EmpresaCFD
Nombre=Configuración - CFD
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=234
PosicionInicialArriba=138
PosicionInicialAlturaCliente=413
PosicionInicialAncho=811
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Empresa

[Ficha]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFD
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=EmpresaCFD.Empresa=<T>{Info.Empresa}<T>
[Ficha.EmpresaCFD.EAN13]
Carpeta=Ficha
Clave=EmpresaCFD.EAN13
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[Ficha.EmpresaCFD.DUN14]
Carpeta=Ficha
Clave=EmpresaCFD.DUN14
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.EmpresaCFD.SKU]
Carpeta=Ficha
Clave=EmpresaCFD.SKU
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.EmpresaCFD.Almacenar]
Carpeta=Ficha
Clave=EmpresaCFD.Almacenar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.EmpresaCFD.Enviar]
Carpeta=Ficha
Clave=EmpresaCFD.Enviar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Validar.EmpresaCFD.ValidarSchema]
Carpeta=Validar
Clave=EmpresaCFD.ValidarSchema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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
Vista=EmpresaCFD
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CondicionVisible=EmpresaCFD:EmpresaCFD.Almacenar

[Almacenar.EmpresaCFD.AlmacenarXML]
Carpeta=Almacenar
Clave=EmpresaCFD.AlmacenarXML
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Almacenar.EmpresaCFD.AlmacenarPDF]
Carpeta=Almacenar
Clave=EmpresaCFD.AlmacenarPDF
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Almacenar.EmpresaCFD.AlmacenarRuta]
Carpeta=Almacenar
Clave=EmpresaCFD.AlmacenarRuta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Enviar]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Enviar
Clave=Enviar
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFD
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CondicionVisible=EmpresaCFD:EmpresaCFD.Enviar

[Enviar.EmpresaCFD.EnviarXML]
Carpeta=Enviar
Clave=EmpresaCFD.EnviarXML
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Enviar.EmpresaCFD.EnviarPDF]
Carpeta=Enviar
Clave=EmpresaCFD.EnviarPDF
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Enviar.EmpresaCFD.EnviarMedio]
Carpeta=Enviar
Clave=EmpresaCFD.EnviarMedio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Almacenar.EmpresaCFD.Nombre]
Carpeta=Almacenar
Clave=EmpresaCFD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[FTP]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=FTP
Clave=FTP
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFD
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CondicionVisible=EmpresaCFD:EmpresaCFD.Enviar y (EmpresaCFD:EmpresaCFD.EnviarMedio=<T>FTP<T>)

[FTP.EmpresaCFD.EnviarDireccion]
Carpeta=FTP
Clave=EmpresaCFD.EnviarDireccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro

[FTP.EmpresaCFD.EnviarRuta]
Carpeta=FTP
Clave=EmpresaCFD.EnviarRuta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro

[FTP.EmpresaCFD.EnviarUsuario]
Carpeta=FTP
Clave=EmpresaCFD.EnviarUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[FTP.EmpresaCFD.EnviarContrasena]
Carpeta=FTP
Clave=EmpresaCFD.EnviarContrasena
Editar=S
ValidaNombre=S
3D=S
Tamano=39
ColorFondo=Blanco
ColorFuente=Negro

[SMTP]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=SMTP
Clave=SMTP
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFD
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CondicionVisible=EmpresaCFD:EmpresaCFD.Enviar y (EmpresaCFD:EmpresaCFD.EnviarMedio=<T>SMTP<T>)

[SMTP.EmpresaCFD.EnviarDireccion]
Carpeta=SMTP
Clave=EmpresaCFD.EnviarDireccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro

[SMTP.EmpresaCFD.EnviarDe]
Carpeta=SMTP
Clave=EmpresaCFD.EnviarDe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro

[SMTP.EmpresaCFD.EnviarAsunto]
Carpeta=SMTP
Clave=EmpresaCFD.EnviarAsunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro

[SMTP.EmpresaCFD.EnviarMensaje]
Carpeta=SMTP
Clave=EmpresaCFD.EnviarMensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80x3
ColorFondo=Blanco
ColorFuente=Negro

[Opciones]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Opciones Generales
Clave=Opciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFD
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Opciones.EmpresaCFD.EnviarAlAfectar]
Carpeta=Opciones
Clave=EmpresaCFD.EnviarAlAfectar
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Opciones.EmpresaCFD.ModoPruebas]
Carpeta=Opciones
Clave=EmpresaCFD.ModoPruebas
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[SQLMail]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=SQL Mail
Clave=SQLMail
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFD
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CondicionVisible=EmpresaCFD:EmpresaCFD.Enviar y (EmpresaCFD:EmpresaCFD.EnviarMedio=<T>SQL Mail<T>)

[SQLMail.EmpresaCFD.EnviarAsunto]
Carpeta=SQLMail
Clave=EmpresaCFD.EnviarAsunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro

[SQLMail.EmpresaCFD.EnviarMensaje]
Carpeta=SQLMail
Clave=EmpresaCFD.EnviarMensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EmpresaCFD.SKUEmpresa]
Carpeta=Ficha
Clave=EmpresaCFD.SKUEmpresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Opciones.EmpresaCFD.SKUCodigoInterno]
Carpeta=Opciones
Clave=EmpresaCFD.SKUCodigoInterno
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Certificado]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=SAT - Certificado (Sello Digital)
Clave=Certificado
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFD
Fuente={Fixedsys, 9, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Certificado.EmpresaCFD.CertificadoBase64]
Carpeta=Certificado
Clave=EmpresaCFD.CertificadoBase64
Editar=S
3D=S
Tamano=100x16
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
ValidaNombre=S

[Certificado.EmpresaCFD.noCertificado]
Carpeta=Certificado
Clave=EmpresaCFD.noCertificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Certificado.EmpresaCFD.Certificado]
Carpeta=Certificado
Clave=EmpresaCFD.Certificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[SMTP.EmpresaCFD.EnviarUsuario]
Carpeta=SMTP
Clave=EmpresaCFD.EnviarUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[SMTP.EmpresaCFD.EnviarContrasena]
Carpeta=SMTP
Clave=EmpresaCFD.EnviarContrasena
Editar=S
ValidaNombre=S
3D=S
Tamano=39
ColorFondo=Blanco
ColorFuente=Negro

[SAT]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=SAT - Datos Generales
Clave=SAT
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFD
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[SAT.EmpresaCFD.version]
Carpeta=SAT
Clave=EmpresaCFD.version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SAT.EmpresaCFD.versionFecha]
Carpeta=SAT
Clave=EmpresaCFD.versionFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[SAT.EmpresaCFD.versionAnterior]
Carpeta=SAT
Clave=EmpresaCFD.versionAnterior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SAT.EmpresaCFD.XSL]
Carpeta=SAT
Clave=EmpresaCFD.XSL
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[SAT.EmpresaCFD.XSLAnterior]
Carpeta=SAT
Clave=EmpresaCFD.XSLAnterior
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[SAT.EmpresaCFD.ValidarSchema]
Carpeta=SAT
Clave=EmpresaCFD.ValidarSchema
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[SAT.EmpresaCFD.ValidarSchemaAnterior]
Carpeta=SAT
Clave=EmpresaCFD.ValidarSchemaAnterior
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[SAT.EmpresaCFD.Llave]
Carpeta=SAT
Clave=EmpresaCFD.Llave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=102
ColorFondo=Blanco
EspacioPrevio=S

[SAT.EmpresaCFD.ContrasenaSello]
Carpeta=SAT
Clave=EmpresaCFD.ContrasenaSello
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=102
ColorFondo=Blanco

[SAT.EmpresaCFD.SAT_MN]
Carpeta=SAT
Clave=EmpresaCFD.SAT_MN
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=40
ColorFondo=Blanco

[SAT.EmpresaCFD.Validar]
Carpeta=SAT
Clave=EmpresaCFD.Validar
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco



[Almacenar.ListaEnCaptura]
(Inicio)=EmpresaCFD.AlmacenarXML
EmpresaCFD.AlmacenarXML=EmpresaCFD.AlmacenarPDF
EmpresaCFD.AlmacenarPDF=EmpresaCFD.Nombre
EmpresaCFD.Nombre=EmpresaCFD.AlmacenarRuta
EmpresaCFD.AlmacenarRuta=(Fin)

[Enviar.ListaEnCaptura]
(Inicio)=EmpresaCFD.EnviarXML
EmpresaCFD.EnviarXML=EmpresaCFD.EnviarPDF
EmpresaCFD.EnviarPDF=EmpresaCFD.EnviarMedio
EmpresaCFD.EnviarMedio=(Fin)

[FTP.ListaEnCaptura]
(Inicio)=EmpresaCFD.EnviarDireccion
EmpresaCFD.EnviarDireccion=EmpresaCFD.EnviarRuta
EmpresaCFD.EnviarRuta=EmpresaCFD.EnviarUsuario
EmpresaCFD.EnviarUsuario=EmpresaCFD.EnviarContrasena
EmpresaCFD.EnviarContrasena=(Fin)

[SMTP.ListaEnCaptura]
(Inicio)=EmpresaCFD.EnviarDireccion
EmpresaCFD.EnviarDireccion=EmpresaCFD.EnviarDe
EmpresaCFD.EnviarDe=EmpresaCFD.EnviarAsunto
EmpresaCFD.EnviarAsunto=EmpresaCFD.EnviarMensaje
EmpresaCFD.EnviarMensaje=EmpresaCFD.EnviarUsuario
EmpresaCFD.EnviarUsuario=EmpresaCFD.EnviarContrasena
EmpresaCFD.EnviarContrasena=(Fin)


[SQLMail.ListaEnCaptura]
(Inicio)=EmpresaCFD.EnviarAsunto
EmpresaCFD.EnviarAsunto=EmpresaCFD.EnviarMensaje
EmpresaCFD.EnviarMensaje=(Fin)

[Certificado.ListaEnCaptura]
(Inicio)=EmpresaCFD.noCertificado
EmpresaCFD.noCertificado=EmpresaCFD.Certificado
EmpresaCFD.Certificado=EmpresaCFD.CertificadoBase64
EmpresaCFD.CertificadoBase64=(Fin)



[Opciones.EmpresaCFD.Decimales]
Carpeta=Opciones
Clave=EmpresaCFD.Decimales
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[SAT.EmpresaCFD.NoValidarOrigenDocumento]
Carpeta=SAT
Clave=EmpresaCFD.NoValidarOrigenDocumento
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco

Tamano=100



[SAT.ListaEnCaptura]
(Inicio)=EmpresaCFD.version
EmpresaCFD.version=EmpresaCFD.XSL
EmpresaCFD.XSL=EmpresaCFD.ValidarSchema
EmpresaCFD.ValidarSchema=EmpresaCFD.versionFecha
EmpresaCFD.versionFecha=EmpresaCFD.versionAnterior
EmpresaCFD.versionAnterior=EmpresaCFD.XSLAnterior
EmpresaCFD.XSLAnterior=EmpresaCFD.ValidarSchemaAnterior
EmpresaCFD.ValidarSchemaAnterior=EmpresaCFD.Llave
EmpresaCFD.Llave=EmpresaCFD.ContrasenaSello
EmpresaCFD.ContrasenaSello=EmpresaCFD.Validar
EmpresaCFD.Validar=EmpresaCFD.SAT_MN
EmpresaCFD.SAT_MN=EmpresaCFD.NoValidarOrigenDocumento
EmpresaCFD.NoValidarOrigenDocumento=(Fin)








[CFDI]
Estilo=Ficha
Pestana=S
Clave=CFDI
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFD
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PermiteEditar=S

PestanaOtroNombre=S
PestanaNombre=CFDI
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
[CFDI.EmpresaCFD.TimbrarCFDIServidor]
Carpeta=CFDI
Clave=EmpresaCFD.TimbrarCFDIServidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[CFDI.EmpresaCFD.TimbrarCFDIUsuario]
Carpeta=CFDI
Clave=EmpresaCFD.TimbrarCFDIUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[CFDI.EmpresaCFD.TimbrarCFDIPassword]
Carpeta=CFDI
Clave=EmpresaCFD.TimbrarCFDIPassword
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



[CFDI.Columnas]
TimbrarCFDIServidor=604
TimbrarCFDIUsuario=604
TimbrarCFDIPassword=604




[CFDI.EmpresaCFD.RutaTimbrarCFDI]
Carpeta=CFDI
Clave=EmpresaCFD.RutaTimbrarCFDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco

[CFDI.EmpresaCFD.ContrasenakeyCSD]
Carpeta=CFDI
Clave=EmpresaCFD.ContrasenakeyCSD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[CFDI.EmpresaCFD.CancelarCFDIUsuario]
Carpeta=CFDI
Clave=EmpresaCFD.CancelarCFDIUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[CFDI.EmpresaCFD.CancelarCFDIPassword]
Carpeta=CFDI
Clave=EmpresaCFD.CancelarCFDIPassword
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco







[CFDI.EmpresaCFD.CancelarCFDIToken]
Carpeta=CFDI
Clave=EmpresaCFD.CancelarCFDIToken
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[CFDI.EmpresaCFD.CancelarCFDICuenta]
Carpeta=CFDI
Clave=EmpresaCFD.CancelarCFDICuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco













[CFDI.EmpresaCFD.RutaIntelisisCFDI]
Carpeta=CFDI
Clave=EmpresaCFD.RutaIntelisisCFDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco




[Opciones.EmpresaCFD.TimeOutTimbrado]
Carpeta=Opciones
Clave=EmpresaCFD.TimeOutTimbrado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Ficha.ListaEnCaptura]
(Inicio)=EmpresaCFD.EAN13
EmpresaCFD.EAN13=EmpresaCFD.DUN14
EmpresaCFD.DUN14=EmpresaCFD.SKU
EmpresaCFD.SKU=EmpresaCFD.SKUEmpresa
EmpresaCFD.SKUEmpresa=EmpresaCFD.Almacenar
EmpresaCFD.Almacenar=EmpresaCFD.Enviar
EmpresaCFD.Enviar=(Fin)


[Opciones.ListaEnCaptura]
(Inicio)=EmpresaCFD.SKUCodigoInterno
EmpresaCFD.SKUCodigoInterno=EmpresaCFD.EnviarAlAfectar
EmpresaCFD.EnviarAlAfectar=EmpresaCFD.TimeOutTimbrado
EmpresaCFD.TimeOutTimbrado=EmpresaCFD.ModoPruebas
EmpresaCFD.ModoPruebas=EmpresaCFD.Decimales
EmpresaCFD.Decimales=EmpresaCFD.NominaTimbrar
EmpresaCFD.NominaTimbrar=(Fin)

[Opciones.EmpresaCFD.NominaTimbrar]
Carpeta=Opciones
Clave=EmpresaCFD.NominaTimbrar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[CFDI.ListaEnCaptura]
(Inicio)=EmpresaCFD.RutaTimbrarCFDI
EmpresaCFD.RutaTimbrarCFDI=EmpresaCFD.RutaIntelisisCFDI
EmpresaCFD.RutaIntelisisCFDI=EmpresaCFD.ContrasenakeyCSD
EmpresaCFD.ContrasenakeyCSD=EmpresaCFD.TimbrarCFDIServidor
EmpresaCFD.TimbrarCFDIServidor=EmpresaCFD.TimbrarCFDIUsuario
EmpresaCFD.TimbrarCFDIUsuario=EmpresaCFD.TimbrarCFDIPassword
EmpresaCFD.TimbrarCFDIPassword=EmpresaCFD.CancelarCFDIToken
EmpresaCFD.CancelarCFDIToken=EmpresaCFD.CancelarCFDICuenta
EmpresaCFD.CancelarCFDICuenta=EmpresaCFD.CancelarCFDIUsuario
EmpresaCFD.CancelarCFDIUsuario=EmpresaCFD.CancelarCFDIPassword
EmpresaCFD.CancelarCFDIPassword=(Fin)





[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=SAT
SAT=Certificado
Certificado=Opciones
Opciones=Almacenar
Almacenar=Enviar
Enviar=SQLMail
SQLMail=FTP
FTP=SMTP
SMTP=CFDI
CFDI=(Fin)
