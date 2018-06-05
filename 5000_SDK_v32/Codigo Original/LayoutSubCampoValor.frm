[Forma]
Clave=LayoutSubCampoValor
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
Comentarios=Lista(Info.SubCampo, Info.Nombre)
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
Vista=LayoutSubCampovalor
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
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=LayoutSubCampovalor.Layout=<T>{Info.Layout}<T> AND<BR>LayoutSubCampovalor.Lista=<T>{Info.Lista}<T> AND<BR>LayoutSubCampovalor.Campo=<T>{Info.Campo}<T> AND<BR>LayoutSubCampovalor.SubCampo=<T>{Info.SubCampo}<T>

[Lista.LayoutSubCampovalor.valor]
Carpeta=Lista
Clave=LayoutSubCampovalor.valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.LayoutSubCampovalor.Nombre]
Carpeta=Lista
Clave=LayoutSubCampovalor.Nombre
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
(Inicio)=LayoutSubCampovalor.valor
LayoutSubCampovalor.valor=LayoutSubCampovalor.Nombre
LayoutSubCampovalor.Nombre=(Fin)
