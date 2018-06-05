
[Forma]
Clave=CFDFlexPerfilDBMail
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Perfil DBMail
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=467
PosicionInicialAncho=737
PosicionCol1=248
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=271
PosicionInicialArriba=92
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDFlexPerfilDBMail
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

IconosCampo=Estatus
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200

IconosSubTitulo=<T>Perfil<T>
IconosNombre=CFDFlexPerfilDBMail:CFDFlexPerfilDBMail.NombrePerfil
[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CFDFlexPerfilDBMail
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

[Detalle.CFDFlexPerfilDBMail.NombrePerfil]
Carpeta=Detalle
Clave=CFDFlexPerfilDBMail.NombrePerfil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.CFDFlexPerfilDBMail.NombreCuenta]
Carpeta=Detalle
Clave=CFDFlexPerfilDBMail.NombreCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

EspacioPrevio=S
[Detalle.CFDFlexPerfilDBMail.Descripcion]
Carpeta=Detalle
Clave=CFDFlexPerfilDBMail.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.CFDFlexPerfilDBMail.CorreoElectronico]
Carpeta=Detalle
Clave=CFDFlexPerfilDBMail.CorreoElectronico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.CFDFlexPerfilDBMail.Usuario]
Carpeta=Detalle
Clave=CFDFlexPerfilDBMail.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.CFDFlexPerfilDBMail.Contrasena]
Carpeta=Detalle
Clave=CFDFlexPerfilDBMail.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S



[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S





Antes=S
AntesExpresiones=EJECUTARSQL(<T>EXECUTE spCFDFlexEliminarCorreoElectronico :tNombrePerfil, :tNombreCuenta<T>,<BR>CFDFlexPerfilDBMail:CFDFlexPerfilDBMail.NombrePerfil,<BR>CFDFlexPerfilDBMail:CFDFlexPerfilDBMail.NombreCuenta)
[Lista.Columnas]
0=227





[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

EspacioPrevio=S







Expresion=GuardarCambios<BR>ActualizarForma
[Detalle.CFDFlexPerfilDBMail.Servidor]
Carpeta=Detalle
Clave=CFDFlexPerfilDBMail.Servidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




[Acciones.Registrar]
Nombre=Registrar
Boton=83
NombreDesplegar=&Registrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S





EspacioPrevio=S



















Expresion=EJECUTARSQL(<T>EXECUTE spCFDFlexRegistrarCorreoElectronico :tNombrePerfil, :tNombreCuenta, :tDescripcion, :tCorreoElectronico, :tUsuario, :tContrasena, :tServidor, :nPuerto, :lSSL<T>,<BR>CFDFlexPerfilDBMail:CFDFlexPerfilDBMail.NombrePerfil,<BR>CFDFlexPerfilDBMail:CFDFlexPerfilDBMail.NombreCuenta,<BR>CFDFlexPerfilDBMail:CFDFlexPerfilDBMail.Descripcion,<BR>CFDFlexPerfilDBMail:CFDFlexPerfilDBMail.CorreoElectronico,<BR>CFDFlexPerfilDBMail:CFDFlexPerfilDBMail.Usuario,<BR>CFDFlexPerfilDBMail:CFDFlexPerfilDBMail.Contrasena,<BR>CFDFlexPerfilDBMail:CFDFlexPerfilDBMail.Servidor,<BR>CFDFlexPerfilDBMail:CFDFlexPerfilDBMail.Puerto,<BR>CFDFlexPerfilDBMail:CFDFlexPerfilDBMail.ActivarSSL)<BR>ActualizarForma
[Detalle.ListaEnCaptura]
(Inicio)=CFDFlexPerfilDBMail.NombrePerfil
CFDFlexPerfilDBMail.NombrePerfil=CFDFlexPerfilDBMail.NombreCuenta
CFDFlexPerfilDBMail.NombreCuenta=CFDFlexPerfilDBMail.Descripcion
CFDFlexPerfilDBMail.Descripcion=CFDFlexPerfilDBMail.CorreoElectronico
CFDFlexPerfilDBMail.CorreoElectronico=CFDFlexPerfilDBMail.Usuario
CFDFlexPerfilDBMail.Usuario=CFDFlexPerfilDBMail.Contrasena
CFDFlexPerfilDBMail.Contrasena=CFDFlexPerfilDBMail.Servidor
CFDFlexPerfilDBMail.Servidor=CFDFlexPerfilDBMail.Puerto
CFDFlexPerfilDBMail.Puerto=CFDFlexPerfilDBMail.ActivarSSL
CFDFlexPerfilDBMail.ActivarSSL=(Fin)

[Detalle.CFDFlexPerfilDBMail.Puerto]
Carpeta=Detalle
Clave=CFDFlexPerfilDBMail.Puerto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.CFDFlexPerfilDBMail.ActivarSSL]
Carpeta=Detalle
Clave=CFDFlexPerfilDBMail.ActivarSSL
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco





















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Nuevo
Nuevo=Eliminar
Eliminar=Registrar
Registrar=(Fin)
