[Forma]
Clave=UsuarioD
Nombre=<T>Empresas con acceso - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=265
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=494
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Usuario
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioD
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroGeneral=UsuarioD.Usuario=<T>{Info.Usuario}<T>
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S

[Lista.UsuarioD.Empresa]
Carpeta=Lista
Clave=UsuarioD.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5

[Lista.Empresa.Nombre]
Carpeta=Lista
Clave=Empresa.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Gris

[Lista.Empresa.Grupo]
Carpeta=Lista
Clave=Empresa.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Gris

[Lista.Columnas]
Empresa=83
Nombre=228
Grupo=153

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

[Lista.ListaEnCaptura]
(Inicio)=UsuarioD.Empresa
UsuarioD.Empresa=Empresa.Nombre
Empresa.Nombre=Empresa.Grupo
Empresa.Grupo=(Fin)
