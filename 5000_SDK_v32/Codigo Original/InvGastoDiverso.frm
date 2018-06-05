[Forma]
Clave=InvGastoDiverso
Nombre=Gastos Diversos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=199
PosicionInicialArriba=353
PosicionInicialAltura=326
PosicionInicialAncho=881
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
Comentarios=Info.Mov+<T> <T>+Info.MovID
PosicionColumna1=21
PosicionSeccion1=88
AutoGuardar=S
PosicionInicialAlturaCliente=290
ExpresionesAlMostrar=EjecutarSQL(<T>xpSugerirGastoDiverso :tEmp, :tModulo, :nID<T>, Empresa, <T>INV<T>, Info.ID)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InvGastoDiverso
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=InvGastoDiverso.Concepto
CarpetaVisible=S
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=InvGastoDiverso.ID={Info.ID}

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
Concepto=151
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
NombreDesplegar=&Aplicar Gastos
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S
ClaveAccion=Aceptar
Antes=S
GuardarAntes=S
DespuesGuardar=S
AntesExpresiones=EjecutarSQL(<T>spInvCostoInv :nID<T>, Info.ID)

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
Vista=InvGastoDiverso
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
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
FiltroGeneral=InvGastoDiverso.ID={Info.ID}

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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

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

[Multiple]
Estilo=Hoja
Clave=Multiple
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=InvGastoDiversoD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=InvGastoDiverso
LlaveLocal=(Lista)
LlaveMaestra=InvGastoDiverso.ID<BR>InvGastoDiverso.Concepto<BR>InvGastoDiverso.Acreedor<BR>InvGastoDiverso.RenglonID
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
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalle
CarpetaDesActivada=S
CondicionVisible=InvGastoDiverso:InvGastoDiverso.Multiple

[Multiple.InvGastoDiversoD.ConceptoD]
Carpeta=Multiple
Clave=InvGastoDiversoD.ConceptoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Multiple.InvGastoDiversoD.Referencia]
Carpeta=Multiple
Clave=InvGastoDiversoD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Multiple.InvGastoDiversoD.Importe]
Carpeta=Multiple
Clave=InvGastoDiversoD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Multiple.InvGastoDiversoD.Impuestos]
Carpeta=Multiple
Clave=InvGastoDiversoD.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Multiple.Total]
Carpeta=Multiple
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

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
TotCarpetaRenglones=Multiple
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CondicionVisible=InvGastoDiverso:InvGastoDiverso.Multiple
CarpetaDesActivada=S

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

[Multiple.InvGastoDiversoD.Retencion]
Carpeta=Multiple
Clave=InvGastoDiversoD.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Multiple.InvGastoDiversoD.Retencion2]
Carpeta=Multiple
Clave=InvGastoDiversoD.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=InvGastoDiversoD
Antes=S
Visible=S
ConCondicion=S
GuardarAntes=S
ActivoCondicion=InvGastoDiverso:InvGastoDiverso.Multiple
EjecucionCondicion=ConDatos(InvGastoDiverso:InvGastoDiverso.Concepto) y<BR>ConDatos(InvGastoDiverso:InvGastoDiverso.Acreedor)
AntesExpresiones=Asigna(Info.Acreedor, InvGastoDiverso:InvGastoDiverso.Acreedor)<BR>Asigna(Info.Concepto, InvGastoDiverso:InvGastoDiverso.Concepto)<BR>Asigna(Info.IDR, InvGastoDiverso:InvGastoDiverso.RenglonID)<BR>Asigna(Info.Zona, InvGastoDiverso:Prov.ZonaImpuesto)
DespuesGuardar=S

[Ficha.InvGastoDiverso.Retencion3]
Carpeta=Ficha
Clave=InvGastoDiverso.Retencion3
Editar=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Multiple.InvGastoDiversoD.Retencion3]
Carpeta=Multiple
Clave=InvGastoDiversoD.Retencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=Multiple
Multiple=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Detalle
Detalle=Navegador
Navegador=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=InvGastoDiverso.Concepto
InvGastoDiverso.Concepto=InvGastoDiverso.Acreedor
InvGastoDiverso.Acreedor=Prov.Nombre
Prov.Nombre=InvGastoDiverso.FechaEmision
InvGastoDiverso.FechaEmision=InvGastoDiverso.Referencia
InvGastoDiverso.Referencia=InvGastoDiverso.Condicion
InvGastoDiverso.Condicion=InvGastoDiverso.Vencimiento
InvGastoDiverso.Vencimiento=InvGastoDiverso.Prorrateo
InvGastoDiverso.Prorrateo=InvGastoDiverso.PedimentoEspecifico
InvGastoDiverso.PedimentoEspecifico=InvGastoDiverso.Moneda
InvGastoDiverso.Moneda=InvGastoDiverso.TipoCambio
InvGastoDiverso.TipoCambio=InvGastoDiverso.Importe
InvGastoDiverso.Importe=InvGastoDiverso.Retencion
InvGastoDiverso.Retencion=InvGastoDiverso.Retencion2
InvGastoDiverso.Retencion2=InvGastoDiverso.Retencion3
InvGastoDiverso.Retencion3=InvGastoDiverso.Impuestos
InvGastoDiverso.Impuestos=Total
Total=InvGastoDiverso.Multiple
InvGastoDiverso.Multiple=(Fin)

[Multiple.LlaveLocal]
(Inicio)=InvGastoDiversoD.ID
InvGastoDiversoD.ID=InvGastoDiversoD.Concepto
InvGastoDiversoD.Concepto=InvGastoDiversoD.Acreedor
InvGastoDiversoD.Acreedor=InvGastoDiversoD.RenglonID
InvGastoDiversoD.RenglonID=(Fin)

[Multiple.ListaEnCaptura]
(Inicio)=InvGastoDiversoD.ConceptoD
InvGastoDiversoD.ConceptoD=InvGastoDiversoD.Referencia
InvGastoDiversoD.Referencia=InvGastoDiversoD.Importe
InvGastoDiversoD.Importe=InvGastoDiversoD.Retencion
InvGastoDiversoD.Retencion=InvGastoDiversoD.Retencion2
InvGastoDiversoD.Retencion2=InvGastoDiversoD.Retencion3
InvGastoDiversoD.Retencion3=InvGastoDiversoD.Impuestos
InvGastoDiversoD.Impuestos=Total
Total=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Impuestos
Impuestos=Total
Total=(Fin)
