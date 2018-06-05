[Forma]
Clave=SerieLoteAutorizar
Nombre=<T>Autorizar: <T> + Info.SerieLote
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=390
PosicionInicialArriba=320
PosicionInicialAlturaCliente=93
PosicionInicialAncho=243
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
VentanaEscCerrar=S
VentanaExclusiva=S
AccionesDivision=S
AccionesCentro=S
BarraHerramientas=S
ExpresionesAlMostrar=Si <BR>  Usuario.Autorizar<BR>Entonces<BR>  Asigna(Info.Usuario, Usuario)<BR>  Asigna(Info.Contrasena, Usuario.Contrasena)<BR>Sino<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>Fin

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
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

[(Variables).Info.Usuario]
Carpeta=(Variables)
Clave=Info.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Contrasena]
Carpeta=(Variables)
Clave=Info.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

Expresion=Asigna(Temp.Reg, SQL(<T>SELECT u.Usuario, u.Contrasena, u.Autorizar, u.AutorizarSeriesLotes FROM Usuario u, UsuarioD d WHERE u.Usuario=:tUsuario AND u.Usuario=d.Usuario AND d.Empresa=:tEmp<T>, Info.Usuario, Empresa))<BR>Si <BR>  Temp.Reg[1]=Info.Usuario<BR>Entonces<BR>  Si <BR>    Igual(Temp.Reg[2], Info.Contrasena) o Igual(Temp.Reg[2], MD5(Info.Contrasena, <T>p<T>))<BR>  Entonces<BR>    Si<BR>      Temp.Reg[3] y Temp.Reg[4]<BR>    Entonces<BR>      EjecutarSQL(<T>spSerieLoteAutorizar :tEmpresa, :tSerieLote, :tUsuario<T>, Empresa, Info.SerieLote, Info.Usuario)<BR>    Sino<BR>      Error(<T>El Usuario Indicado No Puede Autorizar<T>)<BR>    Fin<BR>  Sino<BR>    Error(<T>Contraseña Incorrecta<T>)<BR>  Fin<BR>Sino<BR>  Error(<T>Usuario Incorrecto<T>)<BR>Fin
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Autorizar
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreDesplegar=<T>&Cancelar<T>
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[(Variables).ListaEnCaptura]
(Inicio)=Info.Usuario
Info.Usuario=Info.Contrasena
Info.Contrasena=(Fin)








[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Aceptar
Aceptar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
