[Forma]
Clave=InvGastoDiversoD
Nombre=Gastos Diversos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=216
PosicionInicialArriba=287
PosicionInicialAltura=326
PosicionInicialAncho=848
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

[Lista.InvGastoDiverso.Concepto]
Carpeta=Lista
Clave=InvGastoDiverso.Concepto
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
Retencion3=69

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

[Ficha.InvGastoDiverso.FechaEmision]
Carpeta=Ficha
Clave=InvGastoDiverso.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N
Pegado=N

[Ficha.InvGastoDiverso.Condicion]
Carpeta=Ficha
Clave=InvGastoDiverso.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.InvGastoDiverso.Vencimiento]
Carpeta=Ficha
Clave=InvGastoDiverso.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.InvGastoDiverso.Importe]
Carpeta=Ficha
Clave=InvGastoDiverso.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.InvGastoDiverso.Moneda]
Carpeta=Ficha
Clave=InvGastoDiverso.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Ficha.InvGastoDiverso.TipoCambio]
Carpeta=Ficha
Clave=InvGastoDiverso.TipoCambio
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=5
Pegado=S

[Ficha.InvGastoDiverso.Prorrateo]
Carpeta=Ficha
Clave=InvGastoDiverso.Prorrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.InvGastoDiverso.Concepto]
Carpeta=Ficha
Clave=InvGastoDiverso.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=Negro
ColorFondo=Blanco

[Ficha.InvGastoDiverso.Acreedor]
Carpeta=Ficha
Clave=InvGastoDiverso.Acreedor
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

[Ficha.InvGastoDiverso.Referencia]
Carpeta=Ficha
Clave=InvGastoDiverso.Referencia
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

[Ficha.InvGastoDiverso.Impuestos]
Carpeta=Ficha
Clave=InvGastoDiverso.Impuestos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Ficha.InvGastoDiverso.Multiple]
Carpeta=Ficha
Clave=InvGastoDiverso.Multiple
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
Totalizadores2=Suma( InvGastoDiversoD:InvGastoDiversoD.Importe )<BR>Suma( InvGastoDiversoD:InvGastoDiversoD.Impuestos )<BR>Suma( InvGastoDiversoD:Total )
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

[Ficha.InvGastoDiverso.PedimentoEspecifico]
Carpeta=Ficha
Clave=InvGastoDiverso.PedimentoEspecifico
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.InvGastoDiverso.Retencion]
Carpeta=Ficha
Clave=InvGastoDiverso.Retencion
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.InvGastoDiverso.Retencion2]
Carpeta=Ficha
Clave=InvGastoDiverso.Retencion2
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
Vista=InvGastoDiversoD
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
FiltroGeneral=InvGastoDiversoD.ID={Info.ID} AND <BR>InvGastoDiversoD.Concepto=<T>{Info.Concepto}<T> AND<BR>InvGastoDiversoD.Acreedor=<T>{Info.Acreedor}<T>

[Lista.InvGastoDiversoD.ConceptoD]
Carpeta=Lista
Clave=InvGastoDiversoD.ConceptoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvGastoDiversoD.Referencia]
Carpeta=Lista
Clave=InvGastoDiversoD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvGastoDiversoD.Importe]
Carpeta=Lista
Clave=InvGastoDiversoD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvGastoDiversoD.Retencion]
Carpeta=Lista
Clave=InvGastoDiversoD.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvGastoDiversoD.Retencion2]
Carpeta=Lista
Clave=InvGastoDiversoD.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InvGastoDiversoD.Impuestos]
Carpeta=Lista
Clave=InvGastoDiversoD.Impuestos
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

[Lista.InvGastoDiversoD.Retencion3]
Carpeta=Lista
Clave=InvGastoDiversoD.Retencion3
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
(Inicio)=InvGastoDiversoD.ConceptoD
InvGastoDiversoD.ConceptoD=InvGastoDiversoD.Referencia
InvGastoDiversoD.Referencia=InvGastoDiversoD.Importe
InvGastoDiversoD.Importe=InvGastoDiversoD.Retencion
InvGastoDiversoD.Retencion=InvGastoDiversoD.Retencion2
InvGastoDiversoD.Retencion2=InvGastoDiversoD.Retencion3
InvGastoDiversoD.Retencion3=InvGastoDiversoD.Impuestos
InvGastoDiversoD.Impuestos=Total
Total=(Fin)
