[Forma]
Clave=VINDoc
Nombre=<T>VINs<T>+Si(Info.DocOk, <T> con <T>, <T> sin <T>)+Info.Doc
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=798
PosicionInicialArriba=206
PosicionInicialAltura=436
PosicionInicialAncho=796
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Info.Articulo
PosicionInicialAlturaCliente=409

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>VIN<T>
ElementosPorPagina=200
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=VINs
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
OtroOrden=S
ListaOrden=VIN.Fecha<TAB>(Decendente)

IconosNombre=VIN:VIN.VIN
FiltroGrupo1=Art.Fabricante
FiltroValida1=Art.Fabricante
FiltroGrupo2=Art.Modelo
FiltroValida2=VIN.Modelo
FiltroGrupo3=Art.Linea
FiltroValida3=Art.Linea
FiltroGrupo4=Art.Version
FiltroValida4=Art.Version
FiltroGrupo5=Art.Articulo
FiltroValida5=Art.Articulo
FiltroTodo=S
FiltroTodoFinal=S
FiltroGeneral=VIN.VIN {Si(no Info.DocOk, <T>NOT<T>,<T><T>)} IN (SELECT Cuenta FROM DocCta WHERE Rama = <T>{Info.Rama}<T> AND Documento = <T>{Info.Doc}<T>)
[Lista.VIN.Articulo]
Carpeta=Lista
Clave=VIN.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
VIN=170
Articulo=144
Descripcion1=244
0=118
1=116

2=243
3=-2
[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Activo=S
Visible=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(VIN:VIN.VIN) y ConDatos(VIN:VIN.Articulo)
AntesExpresiones=Asigna(Info.SerieLote, VIN:VIN.VIN)<BR>Asigna(Info.Articulo, VIN:VIN.Articulo)<BR>Asigna(Info.SubCuenta, <T><T>)<BR>Asigna(Info.ArtTipo, TipoVIN)

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.VIN.Fecha]
Carpeta=Lista
Clave=VIN.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentacion preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S




[Lista.ListaEnCaptura]
(Inicio)=VIN.Articulo
VIN.Articulo=Art.Descripcion1
Art.Descripcion1=VIN.Fecha
VIN.Fecha=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Informacion
Informacion=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)
