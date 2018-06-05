[Forma]
Clave=AccesoExpirado
Nombre=Su Contraseña Expiró, Favor de Cambiarla
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=710
PosicionInicialArriba=515
PosicionInicialAltura=159
PosicionInicialAncho=500
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
BarraAcciones=S
AccionesDivision=S
VentanaSinIconosMarco=S
PosicionInicialAlturaCliente=133

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Usuario.Usuario=<T>{Usuario}<T>

[Ficha.Usuario.Usuario]
Carpeta=Ficha
Clave=Usuario.Usuario
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Usuario.Nombre]
Carpeta=Ficha
Clave=Usuario.Nombre
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Usuario.Contrasena]
Carpeta=Ficha
Clave=Usuario.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Usuario.ContrasenaConfirmacion]
Carpeta=Ficha
Clave=Usuario.ContrasenaConfirmacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
EnBarraAcciones=S
ConCondicion=S
EjecucionConError=S
Antes=S

EjecucionCondicion=(MD5(Usuario:Usuario.Contrasena, <T>p<T>)<>Usuario.Contrasena) y (Usuario:Usuario.Contrasena<>Usuario.Contrasena)
EjecucionMensaje=<T>Es Necesario que Cambie su Contraseña<T>
AntesExpresiones=Si<BR>  ContrasenaCorrecta(Usuario:Usuario.Contrasena, Usuario:Usuario.ContrasenaConfirmacion)<BR>Entonces<BR>  Asigna(Usuario:Usuario.Contrasena, MD5(Usuario:Usuario.Contrasena, <T>p<T>))<BR>  Asigna(Usuario:Usuario.ContrasenaConfirmacion, MD5(Usuario:Usuario.ContrasenaConfirmacion, <T>p<T>))<BR>  Asigna(Usuario:Usuario.ContrasenaModificar, Falso)<BR>Sino<BR>  ContrasenaValidaError<BR>  AbortarOperacion<BR>Fin
[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar.Cambios]
Nombre=Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Ficha.ListaEnCaptura]
(Inicio)=Usuario.Usuario
Usuario.Usuario=Usuario.Nombre
Usuario.Nombre=Usuario.Contrasena
Usuario.Contrasena=Usuario.ContrasenaConfirmacion
Usuario.ContrasenaConfirmacion=(Fin)
