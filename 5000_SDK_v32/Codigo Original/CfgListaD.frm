
[Forma]
Clave=CfgListaD
Icono=0
Modulos=(Todos)
Nombre=<T>Lista<T>

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Lista
ListaAcciones=Aceptar
PosicionInicialIzquierda=280
PosicionInicialArriba=171
PosicionInicialAlturaCliente=389
PosicionInicialAncho=806
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgListaD
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
FiltroGeneral=CfgListaD.Lista=<T>{Info.Lista}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
[Lista.ListaEnCaptura]
(Inicio)=CfgListaD.Campo
CfgListaD.Campo=CfgListaD.Valor
CfgListaD.Valor=(Fin)

[Lista.CfgListaD.Campo]
Carpeta=Lista
Clave=CfgListaD.Campo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.CfgListaD.Valor]
Carpeta=Lista
Clave=CfgListaD.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

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
Campo=277
Valor=491
