[Forma]
Clave=ValeSerieMov
Nombre=Vales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAltura=434
PosicionInicialAncho=555
PosicionInicialIzquierda=362
PosicionInicialArriba=291
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID, Info.Moneda)
Totalizadores=S
PosicionSeccion1=91
VentanaExclusiva=S
PosicionInicialAlturaCliente=414
PosicionSec1=318

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ValeSerieMov
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
HojaAjustarColumnas=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroGeneral=ValeSerieMov.Empresa=<T>{Empresa}<T> AND<BR>ValeSerieMov.Modulo=<T>{Info.Modulo}<T> AND<BR>ValeSerieMov.ID={Info.ID}
FiltroRespetar=S
FiltroTipo=General

[Lista.ValeSerieMov.Serie]
Carpeta=Lista
Clave=ValeSerieMov.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.ValeSerie.Precio]
Carpeta=Lista
Clave=ValeSerie.Precio
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Gris
Efectos=[Negritas]
ColorFondo=Blanco

[Lista.ValeSerie.Moneda]
Carpeta=Lista
Clave=ValeSerie.Moneda
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=Gris
ColorFondo=Blanco

[Lista.Columnas]
Serie=195
Precio=90
Moneda=53
EstatusNombre=87
Tipo=87

[Lista.EstatusNombre]
Carpeta=Lista
Clave=EstatusNombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFuente=Gris
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
Visible=S
EjecucionConError=S
Antes=S
DespuesGuardar=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ValeSerieMov:ValeSerieMov.Serie)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
AntesExpresiones=EjecutarSQL(<T>spValeImporteCobrado :tEmpresa, :tModulo, :nID, :nImp, :nTarjeta<T>, Empresa, Info.Modulo, Info.ID, Def.CxImpuesto, 0)

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
Totalizadores2=Conteo(ValeSerieMov:ValeSerieMov.Serie)<BR>Suma(ValeSerieMov:ValeSerie.Precio)
Totalizadores3=<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S
ValidaNombre=S
Efectos=[Negritas]

[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
3D=S
Tamano=5
ColorFondo=Plata
ColorFuente=Negro

[Lista.ValeSerie.Tipo]
Carpeta=Lista
Clave=ValeSerie.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ValeSerieMov.Serie
ValeSerieMov.Serie=EstatusNombre
EstatusNombre=ValeSerie.Tipo
ValeSerie.Tipo=ValeSerie.Precio
ValeSerie.Precio=ValeSerie.Moneda
ValeSerie.Moneda=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Conteo
Conteo=(Fin)
