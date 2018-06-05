[Forma]
Clave=CteEnviarACFD
Nombre=Datos CFD de la Sucursal del Cliente
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=489
PosicionInicialArriba=260
PosicionInicialAlturaCliente=310
PosicionInicialAncho=619
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.ID)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteEnviarACFD
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
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales

FiltroGeneral=CteEnviarACFD.Cliente=<T>{Info.Cliente}<T> AND<BR>CteEnviarACFD.EnviarA={Info.ID}
[Ficha.CteEnviarACFD.ReceptorID]
Carpeta=Ficha
Clave=CteEnviarACFD.ReceptorID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
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




[Validar.CteEnviarACFD.ValidarSchema]
Carpeta=Validar
Clave=CteEnviarACFD.ValidarSchema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70
ColorFondo=Blanco


[Almacenar.CteEnviarACFD.AlmacenarXML]
Carpeta=Almacenar
Clave=CteEnviarACFD.AlmacenarXML
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco

[Almacenar.CteEnviarACFD.AlmacenarPDF]
Carpeta=Almacenar
Clave=CteEnviarACFD.AlmacenarPDF
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco

[Almacenar.CteEnviarACFD.AlmacenarRuta]
Carpeta=Almacenar
Clave=CteEnviarACFD.AlmacenarRuta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
EspacioPrevio=N


[Enviar.CteEnviarACFD.EnviarXML]
Carpeta=Enviar
Clave=CteEnviarACFD.EnviarXML
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco

[Enviar.CteEnviarACFD.EnviarPDF]
Carpeta=Enviar
Clave=CteEnviarACFD.EnviarPDF
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco

[Enviar.CteEnviarACFD.EnviarMedio]
Carpeta=Enviar
Clave=CteEnviarACFD.EnviarMedio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
EspacioPrevio=S




[Almacenar.CteEnviarACFD.Nombre]
Carpeta=Almacenar
Clave=CteEnviarACFD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=50
ColorFondo=Blanco


[FTP.CteEnviarACFD.EnviarDireccion]
Carpeta=FTP
Clave=CteEnviarACFD.EnviarDireccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[FTP.CteEnviarACFD.EnviarRuta]
Carpeta=FTP
Clave=CteEnviarACFD.EnviarRuta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[FTP.CteEnviarACFD.EnviarUsuario]
Carpeta=FTP
Clave=CteEnviarACFD.EnviarUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[FTP.CteEnviarACFD.EnviarContrasena]
Carpeta=FTP
Clave=CteEnviarACFD.EnviarContrasena
Editar=S
ValidaNombre=S
3D=S
Tamano=29
ColorFondo=Blanco


[SMTP.CteEnviarACFD.EnviarDireccion]
Carpeta=SMTP
Clave=CteEnviarACFD.EnviarDireccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[SMTP.CteEnviarACFD.EnviarDe]
Carpeta=SMTP
Clave=CteEnviarACFD.EnviarDe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[SMTP.CteEnviarACFD.EnviarAsunto]
Carpeta=SMTP
Clave=CteEnviarACFD.EnviarAsunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[SMTP.CteEnviarACFD.EnviarMensaje]
Carpeta=SMTP
Clave=CteEnviarACFD.EnviarMensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco


[SQLMail.CteEnviarACFD.EnviarAsunto]
Carpeta=SQLMail
Clave=CteEnviarACFD.EnviarAsunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[SQLMail.CteEnviarACFD.EnviarMensaje]
Carpeta=SQLMail
Clave=CteEnviarACFD.EnviarMensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco


[SMTP.CteEnviarACFD.EnviarUsuario]
Carpeta=SMTP
Clave=CteEnviarACFD.EnviarUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[SMTP.CteEnviarACFD.EnviarContrasena]
Carpeta=SMTP
Clave=CteEnviarACFD.EnviarContrasena
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=29
ColorFondo=Blanco









[Almacenar.ListaEnCaptura]
(Inicio)=CteEnviarACFD.AlmacenarXML
CteEnviarACFD.AlmacenarXML=CteEnviarACFD.AlmacenarPDF
CteEnviarACFD.AlmacenarPDF=CteEnviarACFD.Nombre
CteEnviarACFD.Nombre=CteEnviarACFD.AlmacenarRuta
CteEnviarACFD.AlmacenarRuta=(Fin)




[FTP.ListaEnCaptura]
(Inicio)=CteEnviarACFD.EnviarDireccion
CteEnviarACFD.EnviarDireccion=CteEnviarACFD.EnviarRuta
CteEnviarACFD.EnviarRuta=CteEnviarACFD.EnviarUsuario
CteEnviarACFD.EnviarUsuario=CteEnviarACFD.EnviarContrasena
CteEnviarACFD.EnviarContrasena=(Fin)

[SMTP.ListaEnCaptura]
(Inicio)=CteEnviarACFD.EnviarDireccion
CteEnviarACFD.EnviarDireccion=CteEnviarACFD.EnviarDe
CteEnviarACFD.EnviarDe=CteEnviarACFD.EnviarAsunto
CteEnviarACFD.EnviarAsunto=CteEnviarACFD.EnviarMensaje
CteEnviarACFD.EnviarMensaje=CteEnviarACFD.EnviarUsuario
CteEnviarACFD.EnviarUsuario=CteEnviarACFD.EnviarContrasena
CteEnviarACFD.EnviarContrasena=(Fin)






[Enviar.ListaEnCaptura]
(Inicio)=CteEnviarACFD.EnviarXML
CteEnviarACFD.EnviarXML=CteEnviarACFD.EnviarPDF
CteEnviarACFD.EnviarPDF=CteEnviarACFD.EnviarMedio
CteEnviarACFD.EnviarMedio=(Fin)









[SQLMail.ListaEnCaptura]
(Inicio)=CteEnviarACFD.EnviarAsunto
CteEnviarACFD.EnviarAsunto=CteEnviarACFD.EnviarMensaje
CteEnviarACFD.EnviarMensaje=(Fin)










[Ficha.CteEnviarACFD.Cta]
Carpeta=Ficha
Clave=CteEnviarACFD.Cta
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco





[Ficha.CteEnviarACFD.InfoPago]
Carpeta=Ficha
Clave=CteEnviarACFD.InfoPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco

[Ficha.CteEnviarACFD.InfoFormaPago]
Carpeta=Ficha
Clave=CteEnviarACFD.InfoFormaPago
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco



























[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Validar
Validar=Almacenar
Almacenar=Enviar
Enviar=SQLMail
SQLMail=FTP
FTP=SMTP
SMTP=(Fin)



[Acciones.CteCFDInfoPago]
Nombre=CteCFDInfoPago
Boton=57
NombreEnBoton=S
NombreDesplegar=Información de Pago
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteCFDInfoPago
Activo=S
Visible=S










[Ficha.ListaEnCaptura]
(Inicio)=CteEnviarACFD.ReceptorID
CteEnviarACFD.ReceptorID=CteEnviarACFD.Cta
CteEnviarACFD.Cta=CteEnviarACFD.InfoPago
CteEnviarACFD.InfoPago=CteEnviarACFD.InfoFormaPago
CteEnviarACFD.InfoFormaPago=(Fin)













[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CteCFDInfoPago
CteCFDInfoPago=(Fin)
