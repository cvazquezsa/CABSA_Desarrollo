
[Forma]
Clave=MovTipoeDoc
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=MovTipo - Documento Electrónico
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Aceptar
Comentarios=Lista(Info.Modulo,Info.Mov)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=390
PosicionInicialArriba=212
PosicionInicialAlturaCliente=411
PosicionInicialAncho=495
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoeDoc
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

FiltroGeneral=MovTipoeDoc.Modulo = {Comillas(Info.Modulo)} AND MovTipoeDoc.Mov = {Comillas(Info.Mov)}
[Lista.MovTipoeDoc.Contacto]
Carpeta=Lista
Clave=MovTipoeDoc.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.MovTipoeDoc.eDoc]
Carpeta=Lista
Clave=MovTipoeDoc.eDoc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MovTipoeDoc.Estatus]
Carpeta=Lista
Clave=MovTipoeDoc.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=MovTipoeDoc.Contacto
MovTipoeDoc.Contacto=MovTipoeDoc.eDoc
MovTipoeDoc.eDoc=MovTipoeDoc.Estatus
MovTipoeDoc.Estatus=(Fin)

[Lista.Columnas]
Contacto=105
eDoc=173
Estatus=185
