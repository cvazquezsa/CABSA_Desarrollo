[Forma]
Clave=MovTipoListaT
Nombre=Lista de Claves de Afectación
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=433
PosicionInicialAncho=513
CarpetasMultilinea=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Modulo
PosicionInicialIzquierda=178
PosicionInicialArriba=102

[MovTipoListaT.Columnas]
0=46
1=64

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
Activo=S
Visible=S
NombreEnBoton=S
TipoAccion=Ventana
ClaveAccion=Seleccionar

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Claves
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
OtroOrden=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaOrden=MovTipo.Orden<TAB>(Acendente)
IconosSubTitulo=<T>Orden<T>
IconosNombreNumerico=S
IconosNombre=MovTipo:MovTipo.Orden
FiltroGeneral=MovTipo.Modulo=<T>{Info.Modulo}<T>

[Lista.MovTipo.Mov]
Carpeta=Lista
Clave=MovTipo.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=91
1=86

[Lista.MovClave.Clave]
Carpeta=Lista
Clave=MovClave.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovClave.Descripcion]
Carpeta=Lista
Clave=MovClave.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=S
Visible=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
ClaveAccion=Imprimir

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación Preliminar
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

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Mostrar Campos
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MovClave.Clave
MovClave.Clave=MovTipo.Mov
MovTipo.Mov=MovClave.Descripcion
MovClave.Descripcion=(Fin)
