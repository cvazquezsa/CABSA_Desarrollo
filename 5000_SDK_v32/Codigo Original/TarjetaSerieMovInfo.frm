[Forma]
Clave=TarjetaSerieMovInfo
Nombre=Tarjetas
Icono=0
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=412
PosicionInicialAncho=637
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=321
PosicionInicialArriba=289
Comentarios=Lista(Info.Mov, Info.MovID, Info.Moneda)
Totalizadores=S
PosicionSec1=349
ListaAcciones=Cerrar

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TarjetaSerieMov
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ListaEnCaptura=(Lista)
FiltroGeneral=TarjetaSerieMov.Empresa=<T>{Empresa}<T> AND<BR>TarjetaSerieMov.Modulo=<T>{Info.Modulo}<T> AND<BR>TarjetaSerieMov.ID={Info.ID}

[Lista.TarjetaSerieMov.Serie]
Carpeta=Lista
Clave=TarjetaSerieMov.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ValeSerie.Tipo]
Carpeta=Lista
Clave=ValeSerie.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TarjetaSerieMov.Importe]
Carpeta=Lista
Clave=TarjetaSerieMov.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ValeSerie.Moneda]
Carpeta=Lista
Clave=ValeSerie.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EstatusNombre]
Carpeta=Lista
Clave=EstatusNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Serie=189
EstatusNombre=89
Tipo=88
Importe=85
Moneda=61
Saldo=79

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Conteo<BR>Importe
Totalizadores2=Conteo(TarjetaSerieMov:TarjetaSerieMov.Serie<BR>Suma(TarjetaSerieMov:TarjetaSerieMov.Importe)
Totalizadores3=<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=5
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.Saldo]
Carpeta=Lista
Clave=Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
(Inicio)=TarjetaSerieMov.Serie
TarjetaSerieMov.Serie=TarjetaSerieMov.Importe
TarjetaSerieMov.Importe=EstatusNombre
EstatusNombre=ValeSerie.Tipo
ValeSerie.Tipo=ValeSerie.Moneda
ValeSerie.Moneda=Saldo
Saldo=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Conteo
Conteo=(Fin)
