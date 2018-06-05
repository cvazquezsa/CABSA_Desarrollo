[Forma]
Clave=CompraGastoDiversoD
Nombre=Gastos Diversos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=215
PosicionInicialArriba=290
PosicionInicialAltura=326
PosicionInicialAncho=850
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaExclusiva=S
Comentarios=Lista(Info.Mov+<T> <T>+Info.MovID, Info.Concepto, Info.Acreedor)
PosicionColumna1=24
PosicionSeccion1=91
Totalizadores=S
AutoGuardar=S
PosicionInicialAlturaCliente=416

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
ConceptoD=161
Referencia=124
Retencion=72
Retencion2=72
Retencion3=72

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S
ClaveAccion=Aceptar
GuardarAntes=S

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

[Ficha.CompraGastoDiverso.FechaEmision]
Carpeta=Ficha
Clave=CompraGastoDiverso.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
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
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CompraGastoDiverso.Vencimiento]
Carpeta=Ficha
Clave=CompraGastoDiverso.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CompraGastoDiverso.Importe]
Carpeta=Ficha
Clave=CompraGastoDiverso.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
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
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Ficha.CompraGastoDiverso.TipoCambio]
Carpeta=Ficha
Clave=CompraGastoDiverso.TipoCambio
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
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
ColorFondo=Blanco
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
ColorFondo=Blanco

[Ficha.CompraGastoDiverso.Acreedor]
Carpeta=Ficha
Clave=CompraGastoDiverso.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
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

[Ficha.CompraGastoDiverso.Referencia]
Carpeta=Ficha
Clave=CompraGastoDiverso.Referencia
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=14
ColorFondo=Blanco
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
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Ficha.CompraGastoDiverso.Multiple]
Carpeta=Ficha
Clave=CompraGastoDiverso.Multiple
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Multiple.Columnas]
ConceptoD=126
Referencia=56
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
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[(Carpeta Totalizadores).Impuestos]
Carpeta=(Carpeta Totalizadores)
Clave=Impuestos
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

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
Pegado=S

[Ficha.CompraGastoDiverso.PedimentoEspecifico]
Carpeta=Ficha
Clave=CompraGastoDiverso.PedimentoEspecifico
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CompraGastoDiverso.Retencion]
Carpeta=Ficha
Clave=CompraGastoDiverso.Retencion
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CompraGastoDiverso.Retencion2]
Carpeta=Ficha
Clave=CompraGastoDiverso.Retencion2
Editar=S
ValidaNombre=N
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Detalle
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraGastoDiversoD
Fuente={MS Sans Serif, 8, Negro, []}
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=CompraGastoDiversoD.ID={Info.ID} AND <BR>CompraGastoDiversoD.Concepto=<T>{Info.Concepto}<T> AND<BR>CompraGastoDiversoD.Acreedor=<T>{Info.Acreedor}<T>

[Lista.CompraGastoDiversoD.ConceptoD]
Carpeta=Lista
Clave=CompraGastoDiversoD.ConceptoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraGastoDiversoD.Referencia]
Carpeta=Lista
Clave=CompraGastoDiversoD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraGastoDiversoD.Importe]
Carpeta=Lista
Clave=CompraGastoDiversoD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraGastoDiversoD.Retencion]
Carpeta=Lista
Clave=CompraGastoDiversoD.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraGastoDiversoD.Retencion2]
Carpeta=Lista
Clave=CompraGastoDiversoD.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CompraGastoDiversoD.Impuestos]
Carpeta=Lista
Clave=CompraGastoDiversoD.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Total]
Carpeta=Lista
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.CompraGastoDiversoD.Retencion3]
Carpeta=Lista
Clave=CompraGastoDiversoD.Retencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Impuestos
Impuestos=Total
Total=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CompraGastoDiversoD.ConceptoD
CompraGastoDiversoD.ConceptoD=CompraGastoDiversoD.Referencia
CompraGastoDiversoD.Referencia=CompraGastoDiversoD.Importe
CompraGastoDiversoD.Importe=CompraGastoDiversoD.Retencion
CompraGastoDiversoD.Retencion=CompraGastoDiversoD.Retencion2
CompraGastoDiversoD.Retencion2=CompraGastoDiversoD.Retencion3
CompraGastoDiversoD.Retencion3=CompraGastoDiversoD.Impuestos
CompraGastoDiversoD.Impuestos=Total
Total=(Fin)
