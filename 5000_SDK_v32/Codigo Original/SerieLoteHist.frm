[Forma]
Clave=SerieLoteHist
Icono=0
Modulos=INV
Nombre=<T>Historial de Serie/Lote<T>
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialAltura=300
PosicionInicialAncho=758
PosicionInicialIzquierda=133
PosicionInicialArriba=171
Comentarios=SerieLoteHist:SerieLoteD.SerieLote
PosicionInicialAlturaCliente=391

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

[SerieLoteHist.Columnas]
0=101
1=100
Articulo_1=109
Descripcion1=174
Mov=98
MovID=68
FechaEmision=173
Tipo=57

[Acciones.Movimiento]
Nombre=Movimiento
Boton=35
NombreEnBoton=S
NombreDesplegar=&Movimiento
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(SerieLoteHist:SerieLoteD.ID)
AntesExpresiones=Asigna(Info.Modulo, SerieLoteHist:SerieLoteD.Modulo)<BR>Asigna(Info.ID, SerieLoteHist:SerieLoteD.ID)

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Presentacion preliminar]
Nombre=Presentacion preliminar
Boton=6
NombreDesplegar=Presentacion preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Enviar a Excel]
Nombre=Enviar a Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Movimientos
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SerieLoteHist
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosNombre=SerieLoteHist:SerieLoteD.Articulo
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=Art.Articulo<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroGeneral=SerieLoteD.Empresa = <T>{Empresa}<T><BR>AND SerieLoteD.SerieLote = <T>{Info.Serielote}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.Art.Articulo]
Carpeta=Lista
Clave=Art.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Tipo]
Carpeta=Lista
Clave=Art.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Mov.Mov]
Carpeta=Lista
Clave=Mov.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Mov.MovID]
Carpeta=Lista
Clave=Mov.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Mov.FechaEmision]
Carpeta=Lista
Clave=Mov.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=98
1=88

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Enviar a Excel
Enviar a Excel=Movimiento
Movimiento=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Art.Articulo
Art.Articulo=Art.Descripcion1
Art.Descripcion1=Art.Tipo
Art.Tipo=Mov.Mov
Mov.Mov=Mov.MovID
Mov.MovID=Mov.FechaEmision
Mov.FechaEmision=(Fin)
