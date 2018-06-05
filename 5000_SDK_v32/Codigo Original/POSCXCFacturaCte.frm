[Forma]
Clave=POSCXCFacturaCte
Nombre=<T>Movimientos Pendientes<T>
Icono=67
Modulos=(Todos)
CarpetaPrincipal=Hoja
PosicionInicialAlturaCliente=367
PosicionInicialAncho=550
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=342
PosicionInicialArriba=145
ListaCarpetas=Hoja
ListaAcciones=(Lista)
BarraHerramientas=S
BarraAyuda=S
BarraAyudaBold=S
VentanaEstadoInicial=Normal
Comentarios=Info.Acreditado
VentanaSinIconosMarco=S
ExpresionesAlMostrar=EjecutarSQL( <T>spOrigenVentaPMMavi :tEmp, :tCte, :nEst, :nTipoCobro<T>,  Empresa,  Info.Acreditado, EstacionTrabajo, Info.Cantidad  )
[Hoja.Columnas]
0=-2
1=94
2=71
3=293
4=-2
Empresa=45
IdCxC=64
IdOrigeN=64
IdCxCOrigen=124
IdCxCOrigenMov=124
Cliente=64
5=-2
6=-2
[Hoja]
Estilo=Iconos
Clave=Hoja
MostrarConteoRegistros=S
Zona=A1
Vista=CXCFacturaCteMavi
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=IdCxCOrigenMov<BR>IdCxCOrigen<BR>Articulo
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
ElementosPorPagina=200
IconosSubTitulo=<T>Reg<T>
IconosSeleccionPorLlave=S
IconosSeleccionMultiple=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
AlineacionAutomatica=S
AcomodarTexto=S
IconosNombre=CXCFacturaCteMavi:IdOrigeN
FiltroGeneral=CXCFacturaCteMavi.Empresa = <T>{Empresa}<T> AND<BR>{ Si(ConDatos(Info.Acreditado), <T>Cliente=<T>+Comillas(Info.Acreditado), <T>1=1<T>))}
[Hoja.IdCxCOrigenMov]
Carpeta=Hoja
Clave=IdCxCOrigenMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Aceptar
EnBarraAcciones=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
Multiple=S
ListaAccionesMultiples=(Lista)
GuardarAntes=S
[Acciones.QuitarSeleccion]
Nombre=QuitarSeleccion
Boton=75
NombreDesplegar=&Quitar Seleccion
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S
EspacioPrevio=S
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=RegistrarListaSt(<T>Hoja<T>,<T>IdOrigen<T>)<BR>Asigna(Info.Mensaje, <T>0<T>)<BR>Asigna(Info.Mensaje, SQL(<T>spValidaNumFactSelMAVI :nID, :nEst, :nTipoCobro<T>,  Info.ID, EstacionTrabajo, Info.Cantidad ))<BR>Asigna(Mavi.Folio,SQL(<T>SELECT Clave FROM ListaSt WHERE Estacion=:nEst<T>,EstacionTrabajo))<BR>Asigna(Info.Cantidad,SQL(<T>SELECT C = CASE WHEN DBO.FN_MAVIRM0906CobxPol(:tId) = <T>+Comillas(<T>SI<T>)+<T> THEN 1 ELSE 0 END<T>,Mavi.Folio))<BR>Asigna(Info.Importe,SQL(<T>EXEC SP_MAVIDM0043SugerirMonto :tIDFac, :tImp<T>,Mavi.Folio,Info.Importe))<BR>//Informacion(Info.Mensaje)<BR>Si Info.Mensaje = <T>0<T>  Entonces<BR>  Forma(<T>NegociaMoratorios<T>)<BR>Sino<BR>  Informacion(Info.Mensaje)<BR>Fin
[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
[Hoja.IdCxCOrigen]
Carpeta=Hoja
Clave=IdCxCOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Hoja.Articulo]
Carpeta=Hoja
Clave=Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro










[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Aceptar
Aceptar=Cerrar
Cerrar=(Fin)











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=QuitarSeleccion
QuitarSeleccion=(Fin)
