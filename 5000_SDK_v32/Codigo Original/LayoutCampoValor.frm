[Forma]
Clave=LayoutCampoValor
Nombre=Valores del Campo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=590
PosicionInicialArriba=275
PosicionInicialAlturaCliente=466
PosicionInicialAncho=500
Comentarios=Lista(Info.Campo, Info.Nombre)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LayoutCampovalor
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=LayoutCampovalor.Layout=<T>{Info.Layout}<T> AND<BR>LayoutCampovalor.Lista=<T>{Info.Lista}<T> AND<BR>LayoutCampovalor.Campo=<T>{Info.Campo}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.LayoutCampovalor.valor]
Carpeta=Lista
Clave=LayoutCampovalor.valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LayoutCampovalor.Nombre]
Carpeta=Lista
Clave=LayoutCampovalor.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
valor=179
Nombre=291

[Lista.ListaEnCaptura]
(Inicio)=LayoutCampovalor.valor
LayoutCampovalor.valor=LayoutCampovalor.Nombre
LayoutCampovalor.Nombre=(Fin)
