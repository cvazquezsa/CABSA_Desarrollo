[Forma]
Clave=SerieLoteInfo
Nombre=<T>Información de<T>+Si(Info.ArtTipo en (TipoLote, TipoVIN), <T>l <T>, <T> la <T>)+Info.ArtTipo
Icono=6
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=323
PosicionInicialArriba=96
PosicionInicialAltura=508
PosicionInicialAncho=720
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaExclusiva=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=29
PosicionSeccion2=66
PosicionColumna1=58
EsConsultaExclusiva=S
Comentarios=Info.SerieLote
PosicionInicialAlturaCliente=497
PosicionSec1=137
PosicionCol1=358

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SerieLote
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=SerieLote.Empresa=<T>{Empresa}<T> AND<BR>SerieLote.Articulo=<T>{Info.Articulo}<T> AND<BR>SerieLote.SerieLote=<T>{Info.SerieLote}<T>

[Ficha.SerieLote.SerieLote]
Carpeta=Ficha
Clave=SerieLote.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Ficha.SerieLote.Articulo]
Carpeta=Ficha
Clave=SerieLote.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Ficha.Art.Descripcion1]
Carpeta=Ficha
Clave=Art.Descripcion1
Editar=S
3D=S
Tamano=47
ColorFondo=Plata
LineaNueva=S
ValidaNombre=S
ColorFuente=Negro
Efectos=[Negritas]

[Propiedades]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Propiedades
Clave=Propiedades
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=SerieLote
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CondicionVisible=Info.ArtTipo<>TipoVIN

[Propiedades.SerieLoteProp.Propiedades]
Carpeta=Propiedades
Clave=SerieLoteProp.Propiedades
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Propiedades.SerieLoteProp.Extra1]
Carpeta=Propiedades
Clave=SerieLoteProp.Extra1
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Propiedades.SerieLoteProp.Extra2]
Carpeta=Propiedades
Clave=SerieLoteProp.Extra2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Propiedades.SerieLoteProp.Extra3]
Carpeta=Propiedades
Clave=SerieLoteProp.Extra3
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Propiedades.SerieLoteProp.Fecha1]
Carpeta=Propiedades
Clave=SerieLoteProp.Fecha1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[Propiedades.SerieLoteProp.Fecha2]
Carpeta=Propiedades
Clave=SerieLoteProp.Fecha2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Propiedades.SerieLoteProp.Fecha3]
Carpeta=Propiedades
Clave=SerieLoteProp.Fecha3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
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

[Detalle]
Estilo=Iconos
Clave=Detalle
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=SerieLoteD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=SerieLote
LlaveLocal=(Lista)
LlaveMaestra=(Lista)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
MenuLocal=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=Mov.FechaRegistro<TAB>(Acendente)
Pestana=S

IconosNombre=SerieLoteD:Mov.Mov+<T> <T>+SerieLoteD:Mov.MovID
[Detalle.Mov.FechaEmision]
Carpeta=Detalle
Clave=Mov.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.Mov.Concepto]
Carpeta=Detalle
Clave=Mov.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.Mov.Proyecto]
Carpeta=Detalle
Clave=Mov.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.Mov.Referencia]
Carpeta=Detalle
Clave=Mov.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco

[Detalle.Mov.Observaciones]
Carpeta=Detalle
Clave=Mov.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Detalle.Columnas]
0=144
1=84

2=-2
3=-2
4=-2
5=-2
[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Visible=S

[Acciones.Movimiento]
Nombre=Movimiento
Boton=35
NombreDesplegar=<T>&Movimiento<T>
EnBarraHerramientas=S
TipoAccion=Formas
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S
ClaveAccion=MovPropiedades
ConCondicion=S
EjecucionCondicion=ConDatos(SerieLoteD:SerieLoteD.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, SerieLoteD:SerieLoteD.Modulo)<BR>Asigna(Info.ID, SerieLoteD:SerieLoteD.ID)

[Acciones.Examinar]
Nombre=Examinar
Boton=0
NombreDesplegar=&Examinar
EnMenu=S
TipoAccion=Expresion
Expresion=ReportePantalla(SerieLoteD:SerieLoteD.Modulo, SerieLoteD:SerieLoteD.ID)
Activo=S
Visible=S

[Existencia]
Estilo=Hoja
Clave=Existencia
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A2
Vista=SerieLoteExistencia
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
MostrarConteoRegistros=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGeneral=SerieLote.Empresa=<T>{Empresa}<T> AND<BR>SerieLote.Articulo=<T>{Info.Articulo}<T> AND<BR>SerieLote.SerieLote=<T>{Info.SerieLote}<T> AND<BR>SerieLote.Existencia > 0

[Existencia.SerieLote.Existencia]
Carpeta=Existencia
Clave=SerieLote.Existencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Totalizador=1
ColorFondo=Blanco
ColorFuente=Negro

[Existencia.Columnas]
0=71
1=61
Existencia=55
Almacen=90
ExistenciaAlterna=63
CostoPromedio=79
Tarima=68

[Ficha.SerieLote.SubCuenta]
Carpeta=Ficha
Clave=SerieLote.SubCuenta
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Existencia.SerieLote.Almacen]
Carpeta=Existencia
Clave=SerieLote.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Existencia.SerieLote.ExistenciaAlterna]
Carpeta=Existencia
Clave=SerieLote.ExistenciaAlterna
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[VIN]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos VIN
Clave=VIN
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=VIN
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=VIN.VIN=<T>{Info.SerieLote}<T>
CondicionVisible=Info.ArtTipo=TipoVIN

[VIN.VIN.Motor]
Carpeta=VIN
Clave=VIN.Motor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VIN.VIN.Llave]
Carpeta=VIN
Clave=VIN.Llave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VIN.VIN.Aduana]
Carpeta=VIN
Clave=VIN.Aduana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[VIN.VIN.Pedimento]
Carpeta=VIN
Clave=VIN.Pedimento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VIN.VIN.ClaveVehicular]
Carpeta=VIN
Clave=VIN.ClaveVehicular
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VIN.VIN.Cliente]
Carpeta=VIN
Clave=VIN.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[VIN.Cte.Nombre]
Carpeta=VIN
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=39
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Anexo]
Nombre=Anexo
Boton=77
NombreDesplegar=Ane&xos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>VIN<T>)<BR>Asigna(Info.AnexoCfg, Falso)<BR>Asigna(Info.Cuenta, VIN:VIN.VIN)<BR>Asigna(Info.Descripcion, VIN:Art.Descripcion1+<T> (<T>+VIN:VIN.Articulo+<T>)<T>)
VisibleCondicion=Info.ArtTipo=TipoVIN

[VIN.VIN.Placas]
Carpeta=VIN
Clave=VIN.Placas
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[VINCodigos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Códigos VIN
Clave=VINCodigos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=VIN
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=(Lista)
CondicionVisible=Info.ArtTipo=TipoVIN

[VINCodigos.VIN.CodigoRadio]
Carpeta=VINCodigos
Clave=VIN.CodigoRadio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VINCodigos.VIN.CodigoTransmision]
Carpeta=VINCodigos
Clave=VIN.CodigoTransmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VINCodigos.VIN.CodigoColor]
Carpeta=VINCodigos
Clave=VIN.CodigoColor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VINCodigos.VIN.CodigoLlanta1]
Carpeta=VINCodigos
Clave=VIN.CodigoLlanta1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VINCodigos.VIN.CodigoLlanta2]
Carpeta=VINCodigos
Clave=VIN.CodigoLlanta2
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VINCodigos.VIN.CodigoLlanta3]
Carpeta=VINCodigos
Clave=VIN.CodigoLlanta3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VINCodigos.VIN.CodigoLlanta4]
Carpeta=VINCodigos
Clave=VIN.CodigoLlanta4
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VINCodigos.VIN.CodigoLlanta5]
Carpeta=VINCodigos
Clave=VIN.CodigoLlanta5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VIN.VIN.FechaFactura]
Carpeta=VIN
Clave=VIN.FechaFactura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VIN.VIN.FechaUltimoServicio]
Carpeta=VIN
Clave=VIN.FechaUltimoServicio
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VIN.VIN.Registro]
Carpeta=VIN
Clave=VIN.Registro
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Propiedades.SerieLoteProp.Factor1]
Carpeta=Propiedades
Clave=SerieLoteProp.Factor1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Propiedades.SerieLoteProp.Factor2]
Carpeta=Propiedades
Clave=SerieLoteProp.Factor2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Propiedades.SerieLoteProp.Factor3]
Carpeta=Propiedades
Clave=SerieLoteProp.Factor3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Pedimento]
Estilo=Ficha
Clave=Pedimento
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=SerieLote
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Pedimento
CondicionVisible=Usuario.Costos

[Pedimento.SerieLoteProp.PedimentoRegimen]
Carpeta=Pedimento
Clave=SerieLoteProp.PedimentoRegimen
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Pedimento.SerieLoteProp.ValorDolares]
Carpeta=Pedimento
Clave=SerieLoteProp.ValorDolares
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Pedimento.SerieLoteProp.ValorAduana]
Carpeta=Pedimento
Clave=SerieLoteProp.ValorAduana
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Pedimento.SerieLoteProp.ValorComercial]
Carpeta=Pedimento
Clave=SerieLoteProp.ValorComercial
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Pedimento.SerieLoteProp.AgenteAduanal]
Carpeta=Pedimento
Clave=SerieLoteProp.AgenteAduanal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Pedimento.SerieLoteProp.Aduana]
Carpeta=Pedimento
Clave=SerieLoteProp.Aduana
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=42
ColorFondo=Plata
ColorFuente=Negro

[Pedimento.SerieLoteProp.DTA]
Carpeta=Pedimento
Clave=SerieLoteProp.DTA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Pedimento.SerieLoteProp.IVA]
Carpeta=Pedimento
Clave=SerieLoteProp.IVA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Pedimento.SerieLoteProp.IGI]
Carpeta=Pedimento
Clave=SerieLoteProp.IGI
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Pedimento.Total]
Carpeta=Pedimento
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Posicion]
Nombre=Posicion
Boton=95
NombreDesplegar=Posición
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProdSerieLotePos
Activo=S
VisibleCondicion=General.Prod

[Acciones.Accesorios]
Nombre=Accesorios
Boton=47
NombreEnBoton=S
NombreDesplegar=&Componentes
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
Antes=S
Expresion=Asigna(Info.Bloqueado, Verdadero)<BR>Si(Config.VINAccesorioArt, Forma(<T>VINAccesorioArt<T>), Forma(<T>VINAccesorio<T>))
ActivoCondicion=Info.ArtTipo=TipoVIN
AntesExpresiones=Asigna(Info.VIN, SerieLote:SerieLote.SerieLote)

[Acciones.Venta]
Nombre=Venta
Boton=57
NombreDesplegar=Venta
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=VTAS
ListaParametros1=VIN:VIN.VentaID
ListaParametros=S
ConCondicion=S
Visible=S
EspacioPrevio=S
ActivoCondicion=Info.ArtTipo=TipoVIN
EjecucionCondicion=ConDatos(VIN:VIN.VentaID)

[Acciones.FordOasis]
Nombre=FordOasis
Boton=106
NombreDesplegar=Oasis
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
Expresion=URL(<T>http://www.fordmexico.com.mx/oasis/index.asp?distribuidora=<T>+General.FordDistribuidor+<T>&mercado=<T>+General.FordMercado+<T>&vin=<T>+SerieLote:SerieLote.SerieLote)
ActivoCondicion=General.Ford y (Info.ArtTipo=TipoVIN)

[Pedimento.SerieLote.Propiedades]
Carpeta=Pedimento
Clave=SerieLote.Propiedades
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[ControlCalidad]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Control de Calidad
Clave=ControlCalidad
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=SerieLoteCalidad
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Evaluación<T>
ElementosPorPagina=200
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
IconosNombre=SerieLoteCalidad:SerieLoteCalidad.Evaluacion
FiltroGeneral=SerieLoteCalidad.Empresa=<T>{Empresa}<T> AND<BR>SerieLoteCalidad.Articulo=<T>{Info.Articulo}<T> AND<BR>SerieLoteCalidad.SerieLote=<T>{Info.SerieLote}<T>

[ControlCalidad.SerieLoteCalidad.Valor]
Carpeta=ControlCalidad
Clave=SerieLoteCalidad.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[ControlCalidad.SerieLoteCalidad.Fecha]
Carpeta=ControlCalidad
Clave=SerieLoteCalidad.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[ControlCalidad.SerieLoteCalidad.Referencia]
Carpeta=ControlCalidad
Clave=SerieLoteCalidad.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[ControlCalidad.Columnas]
0=207
1=67

2=-2
3=-2
[Existencia.SerieLote.CostoPromedio]
Carpeta=Existencia
Clave=SerieLote.CostoPromedio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[VIN.VIN.Estatus]
Carpeta=VIN
Clave=VIN.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[VIN.VIN.Situacion]
Carpeta=VIN
Clave=VIN.Situacion
Editar=S
ValidaNombre=N
3D=S
Tamano=39
ColorFondo=Plata
ColorFuente=Negro

[VIN.VIN.TipoUnidad]
Carpeta=VIN
Clave=VIN.TipoUnidad
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[VIN.VIN.Modelo]
Carpeta=VIN
Clave=VIN.Modelo
Editar=S
3D=S
Tamano=7
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[Acciones.CostosExtras]
Nombre=CostosExtras
Boton=64
NombreEnBoton=S
NombreDesplegar=Costos E&xtras
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VINCostoExtra
ActivoCondicion=Info.ArtTipo=TipoVIN
Antes=S
AntesExpresiones=Asigna(Info.SerieLote, SerieLote:SerieLote.SerieLote)
Visible=S

[Acciones.DetallePersonalizar]
Nombre=DetallePersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Existencia.SerieLote.Tarima]
Carpeta=Existencia
Clave=SerieLote.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro



[Ficha.ListaEnCaptura]
(Inicio)=SerieLote.SerieLote
SerieLote.SerieLote=SerieLote.Articulo
SerieLote.Articulo=SerieLote.SubCuenta
SerieLote.SubCuenta=Art.Descripcion1
Art.Descripcion1=(Fin)

[Propiedades.ListaEnCaptura]
(Inicio)=SerieLoteProp.Propiedades
SerieLoteProp.Propiedades=SerieLoteProp.Extra1
SerieLoteProp.Extra1=SerieLoteProp.Extra2
SerieLoteProp.Extra2=SerieLoteProp.Extra3
SerieLoteProp.Extra3=SerieLoteProp.Fecha1
SerieLoteProp.Fecha1=SerieLoteProp.Fecha2
SerieLoteProp.Fecha2=SerieLoteProp.Fecha3
SerieLoteProp.Fecha3=SerieLoteProp.Factor1
SerieLoteProp.Factor1=SerieLoteProp.Factor2
SerieLoteProp.Factor2=SerieLoteProp.Factor3
SerieLoteProp.Factor3=(Fin)




[Existencia.ListaEnCaptura]
(Inicio)=SerieLote.Almacen
SerieLote.Almacen=SerieLote.Tarima
SerieLote.Tarima=SerieLote.Existencia
SerieLote.Existencia=SerieLote.ExistenciaAlterna
SerieLote.ExistenciaAlterna=SerieLote.CostoPromedio
SerieLote.CostoPromedio=(Fin)

[VIN.ListaEnCaptura]
(Inicio)=VIN.Motor
VIN.Motor=VIN.Placas
VIN.Placas=VIN.Llave
VIN.Llave=VIN.TipoUnidad
VIN.TipoUnidad=VIN.Modelo
VIN.Modelo=VIN.ClaveVehicular
VIN.ClaveVehicular=VIN.Registro
VIN.Registro=VIN.Aduana
VIN.Aduana=VIN.Pedimento
VIN.Pedimento=VIN.FechaFactura
VIN.FechaFactura=VIN.FechaUltimoServicio
VIN.FechaUltimoServicio=VIN.Cliente
VIN.Cliente=Cte.Nombre
Cte.Nombre=VIN.Estatus
VIN.Estatus=VIN.Situacion
VIN.Situacion=(Fin)

[VINCodigos.ListaEnCaptura]
(Inicio)=VIN.CodigoRadio
VIN.CodigoRadio=VIN.CodigoTransmision
VIN.CodigoTransmision=VIN.CodigoColor
VIN.CodigoColor=VIN.CodigoLlanta1
VIN.CodigoLlanta1=VIN.CodigoLlanta2
VIN.CodigoLlanta2=VIN.CodigoLlanta3
VIN.CodigoLlanta3=VIN.CodigoLlanta4
VIN.CodigoLlanta4=VIN.CodigoLlanta5
VIN.CodigoLlanta5=(Fin)

[Pedimento.ListaEnCaptura]
(Inicio)=SerieLote.Propiedades
SerieLote.Propiedades=SerieLoteProp.PedimentoRegimen
SerieLoteProp.PedimentoRegimen=SerieLoteProp.ValorDolares
SerieLoteProp.ValorDolares=SerieLoteProp.ValorAduana
SerieLoteProp.ValorAduana=SerieLoteProp.ValorComercial
SerieLoteProp.ValorComercial=SerieLoteProp.AgenteAduanal
SerieLoteProp.AgenteAduanal=SerieLoteProp.Aduana
SerieLoteProp.Aduana=SerieLoteProp.DTA
SerieLoteProp.DTA=SerieLoteProp.IVA
SerieLoteProp.IVA=SerieLoteProp.IGI
SerieLoteProp.IGI=Total
Total=(Fin)

[ControlCalidad.ListaEnCaptura]
(Inicio)=SerieLoteCalidad.Valor
SerieLoteCalidad.Valor=SerieLoteCalidad.Fecha
SerieLoteCalidad.Fecha=SerieLoteCalidad.Referencia
SerieLoteCalidad.Referencia=(Fin)





[Acciones.GastoDiverso.AsignaVariable]
Nombre=AsignaVariable
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.ID,SerieLoteD:Mov.ID)
Activo=S
Visible=S

[Acciones.GastoDiverso.Forma]
Nombre=Forma
Boton=0
TipoAccion=Formas
ClaveAccion=CompraGastoDiversoInfo
Activo=S
Visible=S

[Acciones.GastoDiverso]
Nombre=GastoDiverso
Boton=0
NombreDesplegar=Ver Gasto Diverso
Multiple=S
EnMenu=S
ListaAccionesMultiples=(Lista)

Activo=S








VisibleCondicion=SerieLoteD:Mov.Modulo = <T>COMS<T>






[Acciones.GastoDiverso.ListaAccionesMultiples]
(Inicio)=AsignaVariable
AsignaVariable=Forma
Forma=(Fin)

[Detalle.LlaveLocal]
(Inicio)=SerieLoteD.Empresa
SerieLoteD.Empresa=SerieLoteD.Articulo
SerieLoteD.Articulo=SerieLoteD.SubCuenta
SerieLoteD.SubCuenta=SerieLoteD.SerieLote
SerieLoteD.SerieLote=(Fin)

[Detalle.LlaveMaestra]
(Inicio)=SerieLote.Empresa
SerieLote.Empresa=SerieLote.Articulo
SerieLote.Articulo=SerieLote.SubCuenta
SerieLote.SubCuenta=SerieLote.SerieLote
SerieLote.SerieLote=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=Mov.FechaEmision
Mov.FechaEmision=Mov.Referencia
Mov.Referencia=Mov.Concepto
Mov.Concepto=Mov.Proyecto
Mov.Proyecto=Mov.Observaciones
Mov.Observaciones=(Fin)

[Detalle.ListaAcciones]
(Inicio)=Examinar
Examinar=GastoDiverso
GastoDiverso=DetallePersonalizar
DetallePersonalizar=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Existencia
Existencia=VIN
VIN=VINCodigos
VINCodigos=Detalle
Detalle=Propiedades
Propiedades=Pedimento
Pedimento=ControlCalidad
ControlCalidad=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Movimiento
Movimiento=ArtInfo
ArtInfo=Accesorios
Accesorios=CostosExtras
CostosExtras=Venta
Venta=FordOasis
FordOasis=Posicion
Posicion=Anexo
Anexo=(Fin)
