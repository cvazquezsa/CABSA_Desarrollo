[Forma]
Clave=POSMovAutorizar
Nombre=<T>Autorizar: <T> & Afectar.Mov & <T> <T> & Afectar.MovID
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=598
PosicionInicialArriba=314
PosicionInicialAlturaCliente=156
PosicionInicialAncho=340
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaExclusiva=S

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
VentanaColor=$00804000
VentanaSinIconosMarco=S
ExpresionesAlMostrar=Si<BR>  Usuario.Autorizar<BR>Entonces<BR>  Asigna(Info.Usuario, Usuario)<BR>  Asigna(Info.Contrasena, Nulo)<BR>Sino<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>Fin
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Segoe UI, 12, Blanco, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=$00804000
FichaAlineacionDerecha=S
CampoColorLetras=Rojo obscuro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

ConFuenteEspecial=S
BarraBotones=S
BarraBtnFuente={Segoe UI, 12, Blanco, []}
BarraBtnFondo=$00804000
BarraBtnPosicion=Abajo
BarraBtnSize=80
BarraBtnSeparacion=2
BarraBtnSinBisel=S
BarraBtnBisel=0
BarraBtnPaginas=1
ListaAccionesBB=(Lista)
[(Variables).Info.Usuario]
Carpeta=(Variables)
Clave=Info.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

ColorFuente=Rojo obscuro
ColorFondo=Blanco
[(Variables).Info.Contrasena]
Carpeta=(Variables)
Clave=Info.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

ColorFuente=Rojo obscuro
ColorFondo=Blanco
[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si ((ConDatos(Info.Usuario)) y (ConDatos(Info.Contrasena)))<BR>Entonces<BR>Asigna(Temp.Reg5, SQL(<T>SELECT u.Usuario, u.Contrasena FROM Usuario u, UsuarioD d WHERE u.Usuario=:tUsuario AND u.Usuario=d.Usuario AND d.Empresa=:tEmp<T>, Info.Usuario, Empresa))<BR>  Si<BR>    Temp.Reg5[1]=Info.Usuario<BR>  Entonces<BR>    Si<BR>      Igual(Temp.Reg5[2], Info.Contrasena) o Igual(Temp.Reg5[2], MD5(Info.Contrasena, <T>p<T>))<BR>    Entonces<BR>      Si SQL(<T>EXEC spPOSUsuarioAutorizaValidaSuc :tUsu, :nSuc<T>, Info.Usuario, Sucursal) = 1 <BR>      Entonces<BR>        EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.Usuario)<BR>      Sino<BR>       Error(<T>El usuario no tiene acceso a esta sucursal<T>)<BR>       Asigna(Info.Codigo,Nulo)<BR>      Fin<BR>    Sino<BR>      Error(<T>Contraseña Incorrecta<T>)<BR>      Asigna(Info.Codigo,Nulo)<BR>    Fin<BR>  Sino<BR>    Error(<T>Usuario Incorrecto<T>)<BR>    Asigna(Info.Codigo,Nulo)<BR>  Fin<BR> Sino<BR>  Error(<T>Falta indicar el usuario y/o Contraseña<T>)<BR>   Asigna(Info.Codigo,Nulo)<BR>Fin


[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Aceptar
Aceptar=(Fin)






















[Acciones.Espacio]
Nombre=Espacio
Boton=0
NombreDesplegar=<T>Espacio<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=115
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1

[Acciones.Autoriza]
Nombre=Autoriza
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Autorizar<T>
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=72
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F1.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F1
ListaAccionesMultiples=(Lista)
[Acciones.Separador]
Nombre=Separador
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=10
BarraBtnAlto=75
BarraBtnFondo=Negro
BarraBtnPagina=1

[Acciones.Cancela]
Nombre=Cancela
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
BarraBtnAncho=72
BarraBtnMargen=2
BarraBtnAlto=75
BarraBtnFondo=$00C08000
BarraBtnImgAncho=40
BarraBtnImgAlto=40
NombreEnBotonX=S
edBotonSrc=F2.png
BarraBtnPagina=1
BarraBtnImgAlign=Centrado
BarraBtnImgPos=Arriba
BarraBtnTxtPos=Abajo
BarraBtnTxtAlign=Centrado

TeclaFuncion=F2



[Acciones.Autoriza.Variables]
Nombre=Variables
Boton=0
NombreDesplegar=Variables
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Autoriza.Autoriza]
Nombre=Autoriza
Boton=0
NombreDesplegar=Autoriza
TipoAccion=Expresion
Expresion=Si ((ConDatos(Info.Usuario)) y (ConDatos(Info.Contrasena)))<BR>Entonces<BR>Asigna(Temp.Reg5, SQL(<T>SELECT u.Usuario, u.Contrasena FROM Usuario u, UsuarioD d WHERE u.Usuario=:tUsuario AND u.Usuario=d.Usuario AND d.Empresa=:tEmp<T>, Info.Usuario, Empresa))<BR>  Si<BR>    Temp.Reg5[1]=Info.Usuario<BR>  Entonces<BR>    Si<BR>      Igual(Temp.Reg5[2], Info.Contrasena) o Igual(Temp.Reg5[2], MD5(Info.Contrasena, <T>p<T>))<BR>    Entonces<BR>      Si SQL(<T>EXEC spPOSUsuarioAutorizaValidaSuc :tUsu, :nSuc<T>, Info.Usuario, Sucursal) = 1 <BR>      Entonces<BR>        EjecutarSQL(<T>EXEC spPOSUsuarioAutoriza :tID, :tUsu<T>, Info.IDTexto, Info.Usuario)<BR>      Sino<BR>       Error(<T>El usuario no tiene acceso a esta sucursal<T>)<BR>       Asigna(Info.Codigo,Nulo)<BR>      Fin<BR>    Sino<BR>      Error(<T>Contraseña Incorrecta<T>)<BR>      Asigna(Info.Codigo,Nulo)<BR>    Fin<BR>  Sino<BR>    Error(<T>Usuario Incorrecto<T>)<BR>    Asigna(Info.Codigo,Nulo)<BR>  Fin<BR> Sino<BR>  Error(<T>Falta indicar el usuario y/o Contraseña<T>)<BR>   Asigna(Info.Codigo,Nulo)<BR>Fin
Activo=S
Visible=S

[Acciones.Autoriza.Acepta]
Nombre=Acepta
Boton=0
NombreDesplegar=Acepta
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S




[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Acciones.Autoriza.ListaAccionesMultiples]
(Inicio)=Variables
Variables=Autoriza
Autoriza=Acepta
Acepta=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.Usuario
Info.Usuario=Info.Contrasena
Info.Contrasena=(Fin)

[(Variables).ListaAccionesBB]
(Inicio)=Espacio
Espacio=Autoriza
Autoriza=Separador
Separador=Cancela
Cancela=(Fin)
