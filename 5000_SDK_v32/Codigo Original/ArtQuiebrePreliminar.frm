[Forma]
Clave=ArtQuiebrePreliminar
Nombre=e(<T>Quiebre<T>)+<T> - <T>+Info.ArtFam
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=220
PosicionInicialArriba=253
PosicionInicialAlturaCliente=483
PosicionInicialAncho=839
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=93

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtQuiebre
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
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtFam
FiltroAplicaEn1=Art.Familia
FiltroAplicaEn=Art.Familia
FiltroAutoCampo=Art.Familia
FiltroAutoValidar=Art.Familia
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
PestanaOtroNombre=S
IconosNombre=ArtQuiebre:ArtQuiebre.Articulo
FiltroGeneral=ArtQuiebre.Familia=<T>{Info.ArtFam}<T>

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=0

[Lista.ArtQuiebre.Ventas]
Carpeta=Lista
Clave=ArtQuiebre.Ventas
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtQuiebre.Devoluciones]
Carpeta=Lista
Clave=ArtQuiebre.Devoluciones
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtQuiebre.Faltantes]
Carpeta=Lista
Clave=ArtQuiebre.Faltantes
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtQuiebre.Scanner]
Carpeta=Lista
Clave=ArtQuiebre.Scanner
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.Columnas]
Articulo=105
Descripcion1=170
Ventas=64
Devoluciones=68
Faltantes=57
DemandaAjustada=95
Scanner=55
ScannerAjustado=89
DemandaNeta=75
Estatus=94
VentaAjustada=78
0=118
1=160

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

[Lista.Art.Estatus]
Carpeta=Lista
Clave=Art.Estatus
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtQuiebre.VentaAjustada]
Carpeta=Lista
Clave=ArtQuiebre.VentaAjustada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.ArtQuiebre.DemandaNeta]
Carpeta=Lista
Clave=ArtQuiebre.DemandaNeta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.Quiebre]
Carpeta=Lista
Clave=Quiebre
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

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
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=Art.Estatus
Art.Estatus=ArtQuiebre.Ventas
ArtQuiebre.Ventas=ArtQuiebre.Devoluciones
ArtQuiebre.Devoluciones=ArtQuiebre.Faltantes
ArtQuiebre.Faltantes=ArtQuiebre.DemandaNeta
ArtQuiebre.DemandaNeta=ArtQuiebre.Scanner
ArtQuiebre.Scanner=ArtQuiebre.VentaAjustada
ArtQuiebre.VentaAjustada=Quiebre
Quiebre=(Fin)
