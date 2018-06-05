[Forma]
Clave=Acceso
Nombre=Access Intelisis
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=368
PosicionInicialArriba=305
PosicionInicialAltura=195
PosicionInicialAncho=533
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraAcciones=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
AccionesDivision=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaSinIconosMarco=S
PosicionInicialAlturaCliente=168
IniciarAgregando=S
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Temp.Num, 1)<BR>Si(SQL(<T>SELECT EncriptarContrasenas FROM Version<T>), EncriptarContraseñas EjecutarSQL(<T>spEncriptarContrasenas 0<T> ) )
ExpresionesAlActivar=Si<BR>  SesionParametro(<T>Password<T>)<><T><T><BR>Entonces<BR>  Forma.Accion(<T>Aceptar<T>) <BR>Fin

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=&Ok
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Multiple=S
ConCondicion=S
ListaAccionesMultiples=(Lista)
GuardarAntes=S
Antes=S

EjecucionCondicion=ConDatos(Acceso:Acceso.Empresa) y ConDatos(Acceso:Acceso.Usuario) y ConDatos(Acceso:Acceso.Sucursal)
AntesExpresiones=Asigna(Info.Contrasena, Acceso:Acceso.Contrasena)<BR>Asigna(Acceso:Acceso.Contrasena, MD5(Acceso:Acceso.Contrasena, <T>p<T>))
[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=<T>&Cancel<T>
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar

[Ficha.Empresa.Clave]
Carpeta=Ficha
Clave=Empresa.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Acceso
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=130
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
FichaEspacioNombresAuto=S
FiltroGeneral=1=0

[Ficha.Acceso.Empresa]
Carpeta=Ficha
Clave=Acceso.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S
IgnoraFlujo=S

[Ficha.Acceso.Usuario]
Carpeta=Ficha
Clave=Acceso.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Acceso.Contrasena]
Carpeta=Ficha
Clave=Acceso.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Empresa.Nombre]
Carpeta=Ficha
Clave=Empresa.Nombre
Editar=S
3D=S
Tamano=48
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Usuario.Nombre]
Carpeta=Ficha
Clave=Usuario.Nombre
Editar=S
3D=S
Tamano=24
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Usuario.GrupoTrabajo]
Carpeta=Ficha
Clave=Usuario.GrupoTrabajo
Editar=S
3D=S
Tamano=24
ColorFondo=Plata
Pegado=S
ColorFuente=Negro

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S

EjecucionCondicion=Si<BR>  AsignarAcceso(Acceso:Acceso.Empresa, Acceso:Acceso.Usuario, Acceso:Acceso.Sucursal, Acceso:Usuario.GrupoTrabajo, Acceso:Acceso.FechaTrabajo, Acceso:Acceso.ID)<BR>Entonces<BR>   GuardarCambios<BR>   Asigna(Info.ContMoneda, SQL(<T>SELECT ContMoneda FROM EmpresaCfg WHERE Empresa=:tEmpresa<T>, Acceso:Acceso.Empresa))<BR>   Asigna(Info.Moneda, Info.ContMoneda)<BR>   Asigna(Info.MonedaBase, Info.ContMoneda)<BR>   EjecutarSQL(<T>spAccesoOk :tEmpresa, :nSucursal, :tUsuario, :fFecha, :nID<T>, Acceso:Acceso.Empresa, Acceso:Acceso.Sucursal, Acceso:Acceso.Usuario, Acceso:Acceso.FechaTrabajo, Acceso:Acceso.ID)<BR>   Verdadero<BR>Sino                                   <BR>  Falso<BR>Fin
[Acciones.Aceptar.ChecarPassword]
Nombre=ChecarPassword
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S

EjecucionCondicion=Si<BR>  No(EsAutoPass = verdadero)<BR>Entonces<BR>  Igual(Acceso:Acceso.Contrasena, Acceso:Usuario.Contrasena)<BR>Fin
EjecucionMensaje=Inc(Temp.Num)<BR>Asigna(Acceso:Acceso.Contrasena,Info.Contrasena)<BR>Si(Temp.Num>5, EjecutarSQL(<T>spBloquearUsuario :tUsuario<T>, Acceso:Acceso.Usuario) <T>Invalid Password, User Blocked<T>, <T>Invalid Password<T>)
[Acciones.Aceptar.ChecarEmpresa]
Nombre=ChecarEmpresa
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
EjecucionCondicion=SQL(<T>SELECT Empresa FROM UsuarioD WHERE Usuario = :tUsuario AND Empresa = :tEmpresa<T>,Acceso:Acceso.Usuario, Acceso:Acceso.Empresa)=Acceso:Acceso.Empresa
EjecucionMensaje=<T>You dont have access to this company<T>

[Ficha.Acceso.FechaTrabajo]
Carpeta=Ficha
Clave=Acceso.FechaTrabajo
Editar=S
ValidaNombre=S
3D=S
Tamano=38
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
IgnoraFlujo=S

[Ficha.Sucursal.Nombre]
Carpeta=Ficha
Clave=Sucursal.Nombre
Editar=S
3D=S
Tamano=48
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Acceso.Sucursal]
Carpeta=Ficha
Clave=Acceso.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N
IgnoraFlujo=S

[Acciones.Aceptar.Expiracion]
Nombre=Expiracion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  Acceso:Usuario.ContrasenaModificar<BR>Entonces<BR>  Forma(<T>AccesoExpirado<T>)  <BR>Sino<BR>  Si<BR>    General.ExpirarContrasenas y (SQL(<T>SELECT ISNULL(ContrasenaNuncaExpira, 0) FROM Usuario WHERE Usuario=:tUsuario<T>, Acceso:Acceso.Usuario)=0)<BR>  Entonces<BR>    Si((Ahora-Acceso:Usuario.ContrasenaFecha) > General.ExpirarDias, Forma(<T>AccesoExpirado<T>))<BR>  Fin<BR>Fin
[Acciones.Aceptar.ChecarSucursal]
Nombre=ChecarSucursal
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Si<BR> Acceso:Usuario.AccesarOtrasSucursalesEnLinea o (Acceso:Acceso.Sucursal=Acceso:Usuario.Sucursal)<BR>Entonces<BR>  Verdadero<BR>Sino<BR>  SQL(<T>SELECT COUNT(*) FROM UsuarioSucursalAcceso WHERE Usuario=:tUsr AND Sucursal=:nSuc<T>, Acceso:Acceso.Usuario, Acceso:Acceso.Sucursal)>0<BR>Fin
EjecucionMensaje=<T>You dont have access to this branch<T>

[Acciones.Aceptar.ChecarMovMover]
Nombre=ChecarMovMover
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=SQL(<T>SELECT COUNT(*) FROM Version WHERE MovMover=1<T>)=0
EjecucionMensaje=<T>In this moment you cant use Intelisis<T>+NuevaLinea+NuevaLinea+<T>Moving records from operation to historic<T>

[Acciones.Aceptar.ChecarXP]
Nombre=ChecarXP
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, SQL(<T>EXEC xpAccesoVerificar :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :fFechaTrabajo<T>, Acceso:Acceso.Empresa, Acceso:Acceso.Sucursal, Acceso:Acceso.Usuario, Acceso:Acceso.EstacionTrabajo, Acceso:Acceso.FechaTrabajo))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Temp.Texto

[Acciones.Aceptar.ChecarUsuario]
Nombre=ChecarUsuario
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
EjecucionCondicion=EjecutarSQL(<T>spAccesoUsuarioOk :tUsuario<T>, Acceso:Acceso.Usuario)       <BR>SQL(<T>SELECT Estatus FROM Usuario WHERE Usuario=:tUsuario<T>, Acceso:Acceso.Usuario)=EstatusAlta
EjecucionMensaje=<T>Inactive User<T>


[Ficha.ListaEnCaptura]
(Inicio)=Acceso.Usuario
Acceso.Usuario=Usuario.Nombre
Usuario.Nombre=Usuario.GrupoTrabajo
Usuario.GrupoTrabajo=Acceso.Contrasena
Acceso.Contrasena=Acceso.FechaTrabajo
Acceso.FechaTrabajo=Acceso.Empresa
Acceso.Empresa=Empresa.Nombre
Empresa.Nombre=Acceso.Sucursal
Acceso.Sucursal=Sucursal.Nombre
Sucursal.Nombre=(Fin)














[Acciones.Aceptar.Notificacion]
Nombre=Notificacion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si (General.Notificacion) Y (SQL(<T>IF EXISTS(SELECT * FROM UsuarioCfg2 WHERE Usuario = :tUsuario AND NotificacionAlAcceso = 1) SELECT 1 ELSE SELECT 0<T>,Acceso:Acceso.Usuario) = 1) Entonces<BR>  Si SQL(<T>IF EXISTS(SELECT TOP 1 * FROM UsuarioNotificacion WHERE Usuario = :tUsuario AND Estatus = :tEstatus) SELECT 1 ELSE SELECT 0<T>,Acceso:Acceso.Usuario,<T>PENDIENTE<T>) = 1 Entonces<BR>    Forma(<T>UsuarioNotificacion<T>)<BR>  Fin<BR>Fin


























[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=ChecarUsuario
ChecarUsuario=ChecarPassword
ChecarPassword=ChecarEmpresa
ChecarEmpresa=ChecarSucursal
ChecarSucursal=ChecarMovMover
ChecarMovMover=ChecarXP
ChecarXP=Aceptar
Aceptar=Expiracion
Expiracion=Notificacion
Notificacion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
