
[Forma]
Clave=WebPaginaIndicador
Icono=0
Modulos=(Todos)
Nombre=Indicadores de Gestión

ListaCarpetas=WebPaginaIndicador
CarpetaPrincipal=WebPaginaIndicador
PosicionInicialAlturaCliente=219
PosicionInicialAncho=1133
PosicionInicialIzquierda=50
PosicionInicialArriba=181
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[WebPaginaIndicador]
Estilo=Hoja
Clave=WebPaginaIndicador
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPaginaIndicador
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
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
FiltroGeneral=WebPaginaIndicador.Pagina=<T>{Info.Pagina}<T>
[WebPaginaIndicador.WebPaginaIndicador.Titulo]
Carpeta=WebPaginaIndicador
Clave=WebPaginaIndicador.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[WebPaginaIndicador.WebPaginaIndicador.SP]
Carpeta=WebPaginaIndicador
Clave=WebPaginaIndicador.SP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[WebPaginaIndicador.WebPaginaIndicador.ValorMinimo]
Carpeta=WebPaginaIndicador
Clave=WebPaginaIndicador.ValorMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[WebPaginaIndicador.WebPaginaIndicador.ValorMedio]
Carpeta=WebPaginaIndicador
Clave=WebPaginaIndicador.ValorMedio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[WebPaginaIndicador.WebPaginaIndicador.ValorMaximo]
Carpeta=WebPaginaIndicador
Clave=WebPaginaIndicador.ValorMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[WebPaginaIndicador.Columnas]
Titulo=194
SP=207
ValorMinimo=112
ValorMedio=103
ValorMaximo=99




CampoID=119
CampoNombre=127
CampoImporte=136
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

GuardarAntes=S
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S





















[WebPaginaIndicador.WebPaginaIndicador.CampoID]
Carpeta=WebPaginaIndicador
Clave=WebPaginaIndicador.CampoID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[WebPaginaIndicador.WebPaginaIndicador.CampoNombre]
Carpeta=WebPaginaIndicador
Clave=WebPaginaIndicador.CampoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[WebPaginaIndicador.WebPaginaIndicador.CampoImporte]
Carpeta=WebPaginaIndicador
Clave=WebPaginaIndicador.CampoImporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro






[WebPaginaIndicador.ListaEnCaptura]
(Inicio)=WebPaginaIndicador.Titulo
WebPaginaIndicador.Titulo=WebPaginaIndicador.SP
WebPaginaIndicador.SP=WebPaginaIndicador.ValorMinimo
WebPaginaIndicador.ValorMinimo=WebPaginaIndicador.ValorMedio
WebPaginaIndicador.ValorMedio=WebPaginaIndicador.ValorMaximo
WebPaginaIndicador.ValorMaximo=WebPaginaIndicador.CampoID
WebPaginaIndicador.CampoID=WebPaginaIndicador.CampoNombre
WebPaginaIndicador.CampoNombre=WebPaginaIndicador.CampoImporte
WebPaginaIndicador.CampoImporte=(Fin)





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Eliminar
Eliminar=(Fin)
