[Forma]
Clave=CompraGastoDiverso
Nombre=Gastos Diversos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=242
PosicionInicialArriba=204
PosicionInicialAltura=326
PosicionInicialAncho=903
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
PosicionInicialAlturaCliente=301
ExpresionesAlMostrar=EjecutarSQL(<T>xpSugerirGastoDiverso :tEmp, :tModulo, :nID<T>, Empresa, <T>COMS<T>, Info.ID)
PosicionCol1=184

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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=CompraGastoDiverso.ID={Info.ID}

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
Concepto=151
Acreedor=128
Importe=103
Impuestos=100
Moneda=67
TipoCambio=65
Prorrateo=78
Nombre=300
Total=100
PorcentajeImpuestos=64
Condicion=82
Vencimiento=67
FechaEmision=94

Proveedor=118
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
AntesExpresiones=EjecutarSQL(<T>spCompraCostoInv :nID<T>, Info.ID)

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

FiltroGeneral=CompraGastoDiverso.ID={Info.ID}
[Ficha.CompraGastoDiverso.FechaEmision]
Carpeta=Ficha
Clave=CompraGastoDiverso.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
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

[Ficha.CompraGastoDiverso.Vencimiento]
Carpeta=Ficha
Clave=CompraGastoDiverso.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco

[Ficha.CompraGastoDiverso.Importe]
Carpeta=Ficha
Clave=CompraGastoDiverso.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
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
Pegado=N

[Ficha.CompraGastoDiverso.TipoCambio]
Carpeta=Ficha
Clave=CompraGastoDiverso.TipoCambio
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
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
EspacioPrevio=S

[Ficha.CompraGastoDiverso.Concepto]
Carpeta=Ficha
Clave=CompraGastoDiverso.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=44
ColorFondo=Plata

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
ColorFondo=Blanco
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
LineaNueva=S

[Ficha.CompraGastoDiverso.Multiple]
Carpeta=Ficha
Clave=CompraGastoDiverso.Multiple
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Blanco

[Multiple]
Estilo=Hoja
Clave=Multiple
Detalle=S
PermiteEditar=S
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
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalle
CarpetaDesActivada=S
CondicionVisible=CompraGastoDiverso:CompraGastoDiverso.Multiple

[Multiple.CompraGastoDiversoD.ConceptoD]
Carpeta=Multiple
Clave=CompraGastoDiversoD.ConceptoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Multiple.CompraGastoDiversoD.Referencia]
Carpeta=Multiple
Clave=CompraGastoDiversoD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Multiple.CompraGastoDiversoD.Importe]
Carpeta=Multiple
Clave=CompraGastoDiversoD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Multiple.CompraGastoDiversoD.Impuestos]
Carpeta=Multiple
Clave=CompraGastoDiversoD.Impuestos
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
Totalizadores2=Suma( CompraGastoDiversoD:CompraGastoDiversoD.Importe )<BR>Suma( CompraGastoDiversoD:CompraGastoDiversoD.Impuestos )<BR>Suma( CompraGastoDiversoD:Total )
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Multiple
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CondicionVisible=CompraGastoDiverso:CompraGastoDiverso.Multiple
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

[Ficha.CompraGastoDiverso.PedimentoEspecifico]
Carpeta=Ficha
Clave=CompraGastoDiverso.PedimentoEspecifico
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco

[Ficha.CompraGastoDiverso.Retencion]
Carpeta=Ficha
Clave=CompraGastoDiverso.Retencion
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco

[Ficha.CompraGastoDiverso.Retencion2]
Carpeta=Ficha
Clave=CompraGastoDiverso.Retencion2
Editar=S
ValidaNombre=N
3D=S
Tamano=14
ColorFondo=Blanco

[Multiple.CompraGastoDiversoD.Retencion]
Carpeta=Multiple
Clave=CompraGastoDiversoD.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Multiple.CompraGastoDiversoD.Retencion2]
Carpeta=Multiple
Clave=CompraGastoDiversoD.Retencion2
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
ClaveAccion=CompraGastoDiversoD
Antes=S
Visible=S
ConCondicion=S
GuardarAntes=S
DespuesGuardar=S
ActivoCondicion=CompraGastoDiverso:CompraGastoDiverso.Multiple
EjecucionCondicion=ConDatos(CompraGastoDiverso:CompraGastoDiverso.Concepto) y<BR>ConDatos(CompraGastoDiverso:CompraGastoDiverso.Acreedor)
AntesExpresiones=Asigna(Info.Acreedor, CompraGastoDiverso:CompraGastoDiverso.Acreedor)<BR>Asigna(Info.Concepto, CompraGastoDiverso:CompraGastoDiverso.Concepto)<BR>Asigna(Info.IDR, CompraGastoDiverso:CompraGastoDiverso.RenglonID)<BR>Asigna(Info.Zona, CompraGastoDiverso:Prov.ZonaImpuesto)

[Ficha.CompraGastoDiverso.Retencion3]
Carpeta=Ficha
Clave=CompraGastoDiverso.Retencion3
Editar=S
3D=S
Tamano=14
ColorFondo=Blanco

[Multiple.CompraGastoDiversoD.Retencion3]
Carpeta=Multiple
Clave=CompraGastoDiversoD.Retencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro




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
CompraGastoDiversoD.Retencion2=CompraGastoDiversoD.Retencion3
CompraGastoDiversoD.Retencion3=CompraGastoDiversoD.Impuestos
CompraGastoDiversoD.Impuestos=Total
Total=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Impuestos
Impuestos=Total
Total=(Fin)



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
Total=CompraGastoDiverso.ProrrateoNivel
CompraGastoDiverso.ProrrateoNivel=CompraGastoDiverso.Multiple
CompraGastoDiverso.Multiple=(Fin)

[Ficha.CompraGastoDiverso.ProrrateoNivel]
Carpeta=Ficha
Clave=CompraGastoDiverso.ProrrateoNivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Acciones.Filtro]
Nombre=Filtro
Boton=87
NombreEnBoton=S
NombreDesplegar=&Filtro Prorrateo
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S

Antes=S
DespuesGuardar=S












Expresion=Caso Info.BaseProrrateo<BR>  Es <T>PROVEEDOR<T> Entonces Forma(<T>CompraGastoDiversoProv<T>)<BR>  Es <T>REFERENCIA<T> Entonces Forma(<T>CompraGastoDiversoRef<T>)<BR>  Es <T>ARTICULO<T> Entonces Forma(<T>CompraGastoDiversoArt<T>)<BR>Fin
ActivoCondicion=ConDatos(CompraGastoDiverso:CompraGastoDiverso.ProrrateoNivel)
AntesExpresiones=Asigna(Info.BaseProrrateo, CompraGastoDiverso:CompraGastoDiverso.ProrrateoNivel)<BR>Asigna(Info.Concepto, CompraGastoDiverso:CompraGastoDiverso.Concepto)






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
Detalle=Filtro
Filtro=Navegador
Navegador=(Fin)
