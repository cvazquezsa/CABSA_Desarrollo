
[Forma]
Clave=MovTipoCFDFlex
Icono=0
Modulos=(Todos)
Nombre=CFD Flexible

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Modulo,Info.Mov)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=353
PosicionInicialArriba=226
PosicionInicialAlturaCliente=381
PosicionInicialAncho=888
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoCFDFlex
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

FiltroGeneral=MovTipoCFDFlex.Modulo = {Comillas(Info.Modulo)} AND MovTipoCFDFlex.Mov = {Comillas(Info.Mov)}
[Lista.MovTipoCFDFlex.Comprobante]
Carpeta=Lista
Clave=MovTipoCFDFlex.Comprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MovTipoCFDFlex.Adenda]
Carpeta=Lista
Clave=MovTipoCFDFlex.Adenda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MovTipoCFDFlex.XSD]
Carpeta=Lista
Clave=MovTipoCFDFlex.XSD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


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

[Lista.Columnas]
Cliente=80
Comprobante=161
Adenda=179
XSD=139




Contacto=64
Estatus=94
OrigenModulo=73
OrigenMov=124
[Lista.MovTipoCFDFlex.Contacto]
Carpeta=Lista
Clave=MovTipoCFDFlex.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco




[Lista.MovTipoCFDFlex.Estatus]
Carpeta=Lista
Clave=MovTipoCFDFlex.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=MovTipoCFDFlex.Contacto
MovTipoCFDFlex.Contacto=MovTipoCFDFlex.Comprobante
MovTipoCFDFlex.Comprobante=MovTipoCFDFlex.Adenda
MovTipoCFDFlex.Adenda=MovTipoCFDFlex.Estatus
MovTipoCFDFlex.Estatus=MovTipoCFDFlex.XSD
MovTipoCFDFlex.XSD=MovTipoCFDFlex.OrigenModulo
MovTipoCFDFlex.OrigenModulo=MovTipoCFDFlex.OrigenMov
MovTipoCFDFlex.OrigenMov=(Fin)

[Lista.MovTipoCFDFlex.OrigenModulo]
Carpeta=Lista
Clave=MovTipoCFDFlex.OrigenModulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.MovTipoCFDFlex.OrigenMov]
Carpeta=Lista
Clave=MovTipoCFDFlex.OrigenMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Estatus]
Nombre=Estatus
Boton=18
NombreEnBoton=S
NombreDesplegar=&Estatus
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovTipoCFDFlexEstatus
Activo=S
Antes=S
GuardarAntes=S
AntesExpresiones=Asigna(Info.Contacto,MovTipoCFDFlex:MovTipoCFDFlex.Contacto)
VisibleCondicion=MovTipoCFDFlex:MovTipoCFDFlex.Estatus = <T>(VARIOS)<T>

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Estatus
Estatus=(Fin)
