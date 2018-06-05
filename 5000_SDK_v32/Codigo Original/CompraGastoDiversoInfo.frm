[Forma]
Clave=CompraGastoDiversoInfo
Nombre=Gastos Diversos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=299
PosicionInicialArriba=161
PosicionInicialAltura=326
PosicionInicialAncho=807
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Mov+<T> <T>+Info.MovID
PosicionColumna1=21
PosicionSeccion1=88
Totalizadores=S
AutoGuardar=S
PosicionInicialAlturaCliente=388
VentanaExclusiva=S

PosicionSec1=313
PosicionCol1=185
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraGastoDiverso
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CompraGastoDiverso.Concepto
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.CompraGastoDiverso.Concepto]
Carpeta=Lista
Clave=CompraGastoDiverso.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Concepto=153
Acreedor=128
Importe=103
Impuestos=100
Moneda=67
TipoCambio=65
Prorrateo=78
Nombre=210
Total=100
PorcentajeImpuestos=64
Condicion=82
Vencimiento=67
FechaEmision=94

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S
ClaveAccion=Cerrar

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CompraGastoDiverso
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
CarpetaVisible=S
PestanaNombre=Gasto
Pestana=S
PestanaOtroNombre=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=CompraGastoDiverso.ID={Info.ID}

[Ficha.CompraGastoDiverso.FechaEmision]
Carpeta=Ficha
Clave=CompraGastoDiverso.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=N
Pegado=N

[Ficha.CompraGastoDiverso.Condicion]
Carpeta=Ficha
Clave=CompraGastoDiverso.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CompraGastoDiverso.Vencimiento]
Carpeta=Ficha
Clave=CompraGastoDiverso.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CompraGastoDiverso.Importe]
Carpeta=Ficha
Clave=CompraGastoDiverso.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Ficha.CompraGastoDiverso.Moneda]
Carpeta=Ficha
Clave=CompraGastoDiverso.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
ColorFondo=Plata
ColorFuente=Negro
Pegado=N

[Ficha.CompraGastoDiverso.TipoCambio]
Carpeta=Ficha
Clave=CompraGastoDiverso.TipoCambio
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=5
Pegado=S

[Ficha.CompraGastoDiverso.Prorrateo]
Carpeta=Ficha
Clave=CompraGastoDiverso.Prorrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[Ficha.CompraGastoDiverso.Concepto]
Carpeta=Ficha
Clave=CompraGastoDiverso.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=Negro
ColorFondo=Plata

[Ficha.CompraGastoDiverso.Acreedor]
Carpeta=Ficha
Clave=CompraGastoDiverso.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=44
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Total]
Carpeta=Ficha
Clave=Total
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Ficha.CompraGastoDiverso.Referencia]
Carpeta=Ficha
Clave=CompraGastoDiverso.Referencia
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=14
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

[Ficha.CompraGastoDiverso.Impuestos]
Carpeta=Ficha
Clave=CompraGastoDiverso.Impuestos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S

[Ficha.CompraGastoDiverso.Multiple]
Carpeta=Ficha
Clave=CompraGastoDiverso.Multiple
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Multiple]
Estilo=Hoja
Clave=Multiple
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CompraGastoDiversoD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=CompraGastoDiverso
LlaveLocal=(Lista)
LlaveMaestra=CompraGastoDiverso.ID<BR>CompraGastoDiverso.Concepto<BR>CompraGastoDiverso.Acreedor<BR>CompraGastoDiverso.RenglonID
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalle
HojaFondoGris=S
CondicionVisible=CompraGastoDiverso:CompraGastoDiverso.Multiple

[Multiple.CompraGastoDiversoD.ConceptoD]
Carpeta=Multiple
Clave=CompraGastoDiversoD.ConceptoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Multiple.CompraGastoDiversoD.Referencia]
Carpeta=Multiple
Clave=CompraGastoDiversoD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Multiple.CompraGastoDiversoD.Importe]
Carpeta=Multiple
Clave=CompraGastoDiversoD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Multiple.CompraGastoDiversoD.Impuestos]
Carpeta=Multiple
Clave=CompraGastoDiversoD.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Multiple.Total]
Carpeta=Multiple
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Multiple.Columnas]
ConceptoD=129
Referencia=57
Importe=79
Impuestos=57
Total=73
Retencion=72
Retencion2=72

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Importe<BR>Impuestos<BR>Total
Totalizadores2=Suma( CompraGastoDiversoD:CompraGastoDiversoD.Importe )<BR>Suma( CompraGastoDiversoD:CompraGastoDiversoD.Impuestos )<BR>Suma( CompraGastoDiversoD:Total )
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Multiple
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CondicionVisible=CompraGastoDiverso:CompraGastoDiverso.Multiple

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Impuestos]
Carpeta=(Carpeta Totalizadores)
Clave=Impuestos
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.CompraGastoDiverso.PedimentoEspecifico]
Carpeta=Ficha
Clave=CompraGastoDiverso.PedimentoEspecifico
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CompraGastoDiverso.Retencion]
Carpeta=Ficha
Clave=CompraGastoDiverso.Retencion
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CompraGastoDiverso.Retencion2]
Carpeta=Ficha
Clave=CompraGastoDiverso.Retencion2
Editar=S
ValidaNombre=N
3D=S
Tamano=14
ColorFondo=Plata
ColorFuente=Negro

[Multiple.CompraGastoDiversoD.Retencion]
Carpeta=Multiple
Clave=CompraGastoDiversoD.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Multiple.CompraGastoDiversoD.Retencion2]
Carpeta=Multiple
Clave=CompraGastoDiversoD.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CompraGastoDiverso.Retencion3]
Carpeta=Ficha
Clave=CompraGastoDiverso.Retencion3
Editar=S
3D=S
Tamano=14
ColorFondo=Plata
ColorFuente=Negro



[Ficha.ListaEnCaptura]
(Inicio)=CompraGastoDiverso.Concepto
CompraGastoDiverso.Concepto=CompraGastoDiverso.Acreedor
CompraGastoDiverso.Acreedor=Prov.Nombre
Prov.Nombre=CompraGastoDiverso.FechaEmision
CompraGastoDiverso.FechaEmision=CompraGastoDiverso.Referencia
CompraGastoDiverso.Referencia=CompraGastoDiverso.Condicion
CompraGastoDiverso.Condicion=CompraGastoDiverso.Vencimiento
CompraGastoDiverso.Vencimiento=CompraGastoDiverso.Prorrateo
CompraGastoDiverso.Prorrateo=CompraGastoDiverso.PedimentoEspecifico
CompraGastoDiverso.PedimentoEspecifico=CompraGastoDiverso.Moneda
CompraGastoDiverso.Moneda=CompraGastoDiverso.TipoCambio
CompraGastoDiverso.TipoCambio=CompraGastoDiverso.Importe
CompraGastoDiverso.Importe=CompraGastoDiverso.Retencion
CompraGastoDiverso.Retencion=CompraGastoDiverso.Retencion2
CompraGastoDiverso.Retencion2=CompraGastoDiverso.Retencion3
CompraGastoDiverso.Retencion3=CompraGastoDiverso.Impuestos
CompraGastoDiverso.Impuestos=Total
Total=CompraGastoDiverso.Multiple
CompraGastoDiverso.Multiple=(Fin)

[Multiple.LlaveLocal]
(Inicio)=CompraGastoDiversoD.ID
CompraGastoDiversoD.ID=CompraGastoDiversoD.Concepto
CompraGastoDiversoD.Concepto=CompraGastoDiversoD.Acreedor
CompraGastoDiversoD.Acreedor=CompraGastoDiversoD.RenglonID
CompraGastoDiversoD.RenglonID=(Fin)

[Multiple.ListaEnCaptura]
(Inicio)=CompraGastoDiversoD.ConceptoD
CompraGastoDiversoD.ConceptoD=CompraGastoDiversoD.Referencia
CompraGastoDiversoD.Referencia=CompraGastoDiversoD.Importe
CompraGastoDiversoD.Importe=CompraGastoDiversoD.Retencion
CompraGastoDiversoD.Retencion=CompraGastoDiversoD.Retencion2
CompraGastoDiversoD.Retencion2=CompraGastoDiversoD.Impuestos
CompraGastoDiversoD.Impuestos=Total
Total=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Impuestos
Impuestos=Total
Total=(Fin)





[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=Multiple
Multiple=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Navegador
Navegador=(Fin)
