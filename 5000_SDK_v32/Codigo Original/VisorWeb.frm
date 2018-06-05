
[Forma]
Clave=VisorWeb
Icono=0
Modulos=(Todos)
Nombre=Visor Web

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
PosicionInicialIzquierda=432
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=576
Comentarios=Usuario
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VisorWeb
Fuente={Tahoma, 8, Negro, []}
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
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática

FiltroDistintos=S
FiltroGeneral=VisorWebConfigUsuario.Usuario=<T>(Todos)<T> or<BR>VisorWebConfigUsuario.Usuario=<T>{Usuario}<T>
[Lista.VisorWebConfigUsuario.Formato]
Carpeta=Lista
Clave=VisorWebConfigUsuario.Formato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.VisorWeb]
Nombre=VisorWeb
Boton=106
NombreEnBoton=S
NombreDesplegar=&Explorar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S




Antes=S
Expresion=fnVisorWeb(Info.Categoria)
AntesExpresiones=Asigna(Info.Categoria,VisorWeb:VisorWebConfigUsuario.Formato)
[Lista.Columnas]
Formato=173





Nombre=320

Descripcion=361
[Lista.VisorWebConfig.Descripcion]
Carpeta=Lista
Clave=VisorWebConfig.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
















































[Lista.LlaveLocal]
(Inicio)=VisorWebConfigUsuario.Formato
VisorWebConfigUsuario.Formato=VisorWebConfigUsuario.Usuario
VisorWebConfigUsuario.Usuario=(Fin)

[Lista.LlaveMaestra]
(Inicio)=VisorWebConfigUsuario.Formato
VisorWebConfigUsuario.Formato=VisorWebConfigUsuario.Usuario
VisorWebConfigUsuario.Usuario=(Fin)

[Lista.ResumenLlave]
(Inicio)=VisorWebConfigUsuario.Formato
VisorWebConfigUsuario.Formato=VisorWebConfigUsuario.Usuario
VisorWebConfigUsuario.Usuario=(Fin)

[Lista.ResumenLlaveMaestra]
(Inicio)=VisorWebConfigUsuario.Formato
VisorWebConfigUsuario.Formato=VisorWebConfigUsuario.Usuario
VisorWebConfigUsuario.Usuario=(Fin)



















[Lista.ListaEnCaptura]
(Inicio)=VisorWebConfigUsuario.Formato
VisorWebConfigUsuario.Formato=VisorWebConfig.Descripcion
VisorWebConfig.Descripcion=(Fin)











































































































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=VisorWeb
VisorWeb=(Fin)
