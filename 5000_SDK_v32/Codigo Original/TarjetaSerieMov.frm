[Forma]
Clave=TarjetaSerieMov
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
PosicionInicialArriba=292
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID, Info.Moneda)
Totalizadores=S
PosicionSec1=349

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
PermiteEditar=S

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

[Lista.ValeSerie.Tipo]
Carpeta=Lista
Clave=ValeSerie.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.TarjetaSerieMov.Importe]
Carpeta=Lista
Clave=TarjetaSerieMov.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ValeSerie.Moneda]
Carpeta=Lista
Clave=ValeSerie.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.EstatusNombre]
Carpeta=Lista
Clave=EstatusNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.Columnas]
Serie=189
EstatusNombre=89
Tipo=88
Importe=85
Moneda=61
Saldo=79

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
Antes=S
GuardarAntes=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(TarjetaSerieMov:TarjetaSerieMov.Serie)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
AntesExpresiones=EjecutarSQL(<T>spValeImporteCobrado :tEmpresa, :tModulo, :nID, :nImp, :nTarjeta<T>, Empresa, Info.Modulo, Info.ID, Def.CxImpuesto, 1)
DespuesGuardar=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

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
Totalizadores2=Conteo(TarjetaSerieMov:TarjetaSerieMov.Serie)<BR>Suma(TarjetaSerieMov:TarjetaSerieMov.Importe)
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
ColorFuente=$00408000


[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Conteo
Conteo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TarjetaSerieMov.Serie
TarjetaSerieMov.Serie=TarjetaSerieMov.Importe
TarjetaSerieMov.Importe=TarjetaSerieMov.ImporteTarjeta
TarjetaSerieMov.ImporteTarjeta=TarjetaSerieMov.TipoCambioTarjeta
TarjetaSerieMov.TipoCambioTarjeta=EstatusNombre
EstatusNombre=ValeSerie.Tipo
ValeSerie.Tipo=ValeSerie.Moneda
ValeSerie.Moneda=Saldo
Saldo=(Fin)

[Lista.TarjetaSerieMov.ImporteTarjeta]
Carpeta=Lista
Clave=TarjetaSerieMov.ImporteTarjeta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.TarjetaSerieMov.TipoCambioTarjeta]
Carpeta=Lista
Clave=TarjetaSerieMov.TipoCambioTarjeta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
