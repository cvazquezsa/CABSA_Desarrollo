
[Forma]
Clave=pNetUsuario
Icono=0
Modulos=(Todos)
Nombre=Usuarios
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaColor=Plata
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S


ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=393
PosicionInicialArriba=189
PosicionInicialAlturaCliente=310
PosicionInicialAncho=580
ListaAcciones=Guardar
[pNetUsuario.ListaEnCaptura]
(Inicio)=pNetUsuario.Usuario
pNetUsuario.Usuario=pNetUsuario.eMail
pNetUsuario.eMail=(Fin)



[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=pNetUsuario
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaColorFondo=Plata
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

FiltroGeneral=pNetUsuario.IDUsuarioTipo = 1 AND pNetUsuario.IDRole = 1
[Lista.pNetUsuario.Usuario]
Carpeta=Lista
Clave=pNetUsuario.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.pNetUsuario.eMail]
Carpeta=Lista
Clave=pNetUsuario.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=pNetUsuario.Usuario
pNetUsuario.Usuario=pNetUsuario.Nombre
pNetUsuario.Nombre=pNetUsuario.eMail
pNetUsuario.eMail=(Fin)

[Lista.pNetUsuario.Nombre]
Carpeta=Lista
Clave=pNetUsuario.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Usuario=98
Nombre=255
eMail=185

0=99
1=375
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
