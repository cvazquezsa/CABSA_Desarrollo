[Forma]
Clave=InvGastoDiversoInfo
Nombre=Gastos Diversos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=198
PosicionInicialArriba=333
PosicionInicialAltura=326
PosicionInicialAncho=883
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
PosicionInicialAlturaCliente=330
VentanaExclusiva=S

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
FiltroGeneral=InvGastoDiverso.ID={Info.ID}

[Ficha.InvGastoDiverso.FechaEmision]
Carpeta=Ficha
Clave=InvGastoDiverso.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
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
ColorFondo=Plata
ColorFuente=Negro

[Ficha.InvGastoDiverso.Vencimiento]
Carpeta=Ficha
Clave=InvGastoDiverso.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Plata
ColorFuente=Negro

[Ficha.InvGastoDiverso.Importe]
Carpeta=Ficha
Clave=InvGastoDiverso.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
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
ColorFondo=Plata
ColorFuente=Negro
Pegado=N

[Ficha.InvGastoDiverso.TipoCambio]
Carpeta=Ficha
Clave=InvGastoDiverso.TipoCambio
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Plata
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
ColorFondo=Plata
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
ColorFondo=Plata

[Ficha.InvGastoDiverso.Acreedor]
Carpeta=Ficha
Clave=InvGastoDiverso.Acreedor
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

[Ficha.InvGastoDiverso.Referencia]
Carpeta=Ficha
Clave=InvGastoDiverso.Referencia
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=14
ColorFondo=Plata
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
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S

[Ficha.InvGastoDiverso.Multiple]
Carpeta=Ficha
Clave=InvGastoDiverso.Multiple
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
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalle
HojaFondoGris=S
CondicionVisible=InvGastoDiverso:InvGastoDiverso.Multiple

[Multiple.InvGastoDiversoD.ConceptoD]
Carpeta=Multiple
Clave=InvGastoDiversoD.ConceptoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Multiple.InvGastoDiversoD.Referencia]
Carpeta=Multiple
Clave=InvGastoDiversoD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Multiple.InvGastoDiversoD.Importe]
Carpeta=Multiple
Clave=InvGastoDiversoD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Multiple.InvGastoDiversoD.Impuestos]
Carpeta=Multiple
Clave=InvGastoDiversoD.Impuestos
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
Totalizadores2=Suma( InvGastoDiversoD:InvGastoDiversoD.Importe )<BR>Suma( InvGastoDiversoD:InvGastoDiversoD.Impuestos )<BR>Suma( InvGastoDiversoD:Total )
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Multiple
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CondicionVisible=InvGastoDiverso:InvGastoDiverso.Multiple

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
ColorFondo=Plata
ColorFuente=Negro

[Ficha.InvGastoDiverso.Retencion]
Carpeta=Ficha
Clave=InvGastoDiverso.Retencion
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Plata
ColorFuente=Negro

[Ficha.InvGastoDiverso.Retencion2]
Carpeta=Ficha
Clave=InvGastoDiverso.Retencion2
Editar=S
ValidaNombre=N
3D=S
Tamano=14
ColorFondo=Plata
ColorFuente=Negro

[Multiple.InvGastoDiversoD.Retencion]
Carpeta=Multiple
Clave=InvGastoDiversoD.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Multiple.InvGastoDiversoD.Retencion2]
Carpeta=Multiple
Clave=InvGastoDiversoD.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Ficha.InvGastoDiverso.Retencion3]
Carpeta=Ficha
Clave=InvGastoDiverso.Retencion3
Editar=S
3D=S
Tamano=14
ColorFondo=Plata
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=Multiple
Multiple=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Navegador
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
InvGastoDiversoD.Retencion2=InvGastoDiversoD.Impuestos
InvGastoDiversoD.Impuestos=Total
Total=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Impuestos
Impuestos=Total
Total=(Fin)
