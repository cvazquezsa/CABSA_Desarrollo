
[Forma]
Clave=TipoImpuesto
Icono=0
Modulos=(Todos)
Nombre=Tipos Impuestos

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=83
PosicionInicialArriba=158
PosicionInicialAlturaCliente=478
PosicionInicialAncho=630
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionCol1=376
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoImpuesto
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

OtroOrden=S
ListaOrden=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=TipoImpuesto.Tipo
FiltroAutoValidar=TipoImpuesto.Tipo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroEstilo=Directorio
FiltroRespetar=S
FiltroTipo=Automático
[Lista.TipoImpuesto.TipoImpuesto]
Carpeta=Lista
Clave=TipoImpuesto.TipoImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco




[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
TipoImpuesto=98
Porcentaje=57
Concepto=189
Referencia=143



Tasa=41
CodigoFiscal=126
Tipo=77
CuentaDeudora=124
CuentaAcreedora=124
0=207
Clave=80
Descripcion=305
[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TipoImpuestoD
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(TipoImpuesto:TipoImpuesto.TipoImpuesto)
Antes=S
AntesExpresiones=Asigna(Info.TipoImpuesto, TipoImpuesto:TipoImpuesto.TipoImpuesto)
DespuesGuardar=S
Visible=S











[Lista.TipoImpuesto.Tasa]
Carpeta=Lista
Clave=TipoImpuesto.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco














[Lista.TipoImpuesto.Tipo]
Carpeta=Lista
Clave=TipoImpuesto.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



















[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=TipoImpuesto
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Detalle.TipoImpuesto.TipoImpuesto]
Carpeta=Detalle
Clave=TipoImpuesto.TipoImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.TipoImpuesto.Tasa]
Carpeta=Detalle
Clave=TipoImpuesto.Tasa
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco

[Detalle.TipoImpuesto.Concepto]
Carpeta=Detalle
Clave=TipoImpuesto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.TipoImpuesto.Referencia]
Carpeta=Detalle
Clave=TipoImpuesto.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[Detalle.TipoImpuesto.CodigoFiscal]
Carpeta=Detalle
Clave=TipoImpuesto.CodigoFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Detalle.TipoImpuesto.Tipo]
Carpeta=Detalle
Clave=TipoImpuesto.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.TipoImpuesto.CuentaDeudora]
Carpeta=Detalle
Clave=TipoImpuesto.CuentaDeudora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

EspacioPrevio=S
[Detalle.Cta.Descripcion]
Carpeta=Detalle
Clave=Cta.Descripcion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata

[Detalle.TipoImpuesto.CuentaAcreedora]
Carpeta=Detalle
Clave=TipoImpuesto.CuentaAcreedora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.CtaDestino.Descripcion]
Carpeta=Detalle
Clave=CtaDestino.Descripcion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata








[Lista.TipoImpuesto.CodigoFiscal]
Carpeta=Lista
Clave=TipoImpuesto.CodigoFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
















[Lista.ListaEnCaptura]
(Inicio)=TipoImpuesto.TipoImpuesto
TipoImpuesto.TipoImpuesto=TipoImpuesto.Tipo
TipoImpuesto.Tipo=TipoImpuesto.Tasa
TipoImpuesto.Tasa=TipoImpuesto.CodigoFiscal
TipoImpuesto.CodigoFiscal=(Fin)

[Lista.ListaOrden]
(Inicio)=TipoImpuesto.Tipo	(Acendente)
TipoImpuesto.Tipo	(Acendente)=TipoImpuesto.TipoImpuesto	(Acendente)
TipoImpuesto.TipoImpuesto	(Acendente)=(Fin)








[Detalle.TipoImpuesto.Clave]
Carpeta=Detalle
Clave=TipoImpuesto.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








[Detalle.ListaEnCaptura]
(Inicio)=TipoImpuesto.TipoImpuesto
TipoImpuesto.TipoImpuesto=TipoImpuesto.Tipo
TipoImpuesto.Tipo=TipoImpuesto.Tasa
TipoImpuesto.Tasa=TipoImpuesto.CodigoFiscal
TipoImpuesto.CodigoFiscal=TipoImpuesto.Concepto
TipoImpuesto.Concepto=TipoImpuesto.Referencia
TipoImpuesto.Referencia=TipoImpuesto.CuentaAcreedora
TipoImpuesto.CuentaAcreedora=Cta.Descripcion
Cta.Descripcion=TipoImpuesto.CuentaDeudora
TipoImpuesto.CuentaDeudora=CtaDestino.Descripcion
CtaDestino.Descripcion=TipoImpuesto.Clave
TipoImpuesto.Clave=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Detalle
Detalle=(Fin)
