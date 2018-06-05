[Forma]
Clave=Instrumento
Nombre=Instrumentos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=549
PosicionInicialArriba=395
PosicionInicialAltura=398
PosicionInicialAncho=821
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=51
PosicionInicialAlturaCliente=374
PosicionCol1=409

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Instrumento
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
PestanaNombre=Lista
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=Instrumento.Instrumento<TAB>(Acendente)
PermiteLocalizar=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Mon
FiltroAplicaEn1=Instrumento.Moneda
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroTodoFinal=S
FiltroAncho=15
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=15
BusquedaEnLinea=S

[Lista.Columnas]
Instrumento=107
CtaDinero=64
FormaPago=304
Descripcion=155
CtaDinero_1=64
Tipo=124
NumeroCta=304
Sucursal=304
Moneda=92
Estatus=94

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Detalle]
Estilo=Ficha
PestanaNombre=Detalles
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Instrumento
Fuente={MS Sans Serif, 8, Negro, []}
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

[Detalle.Instrumento.Instrumento]
Carpeta=Detalle
Clave=Instrumento.Instrumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Instrumento.Descripcion]
Carpeta=Detalle
Clave=Instrumento.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.Instrumento.Instrumento]
Carpeta=Lista
Clave=Instrumento.Instrumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Instrumento.Descripcion]
Carpeta=Lista
Clave=Instrumento.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
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
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

[Detalle.Instrumento.Moneda]
Carpeta=Detalle
Clave=Instrumento.Moneda
ValidaNombre=S
3D=S
Tamano=22
Editar=S
LineaNueva=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Instrumento.RequiereBeneficiario]
Carpeta=Detalle
Clave=Instrumento.RequiereBeneficiario
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=22
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Instrumento.UnidadMinima]
Carpeta=Detalle
Clave=Instrumento.UnidadMinima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Instrumento.CtaDineroVenta]
Carpeta=Detalle
Clave=Instrumento.CtaDineroVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Instrumento.CtaDineroCompra]
Carpeta=Detalle
Clave=Instrumento.CtaDineroCompra
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Instrumento.FormaPagoVenta]
Carpeta=Detalle
Clave=Instrumento.FormaPagoVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Instrumento.FormaPagoCompra]
Carpeta=Detalle
Clave=Instrumento.FormaPagoCompra
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Instrumento.Uso]
Carpeta=Detalle
Clave=Instrumento.Uso
Editar=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Cobertura.Instrumento.FormulaCobertura]
Carpeta=Cobertura
Clave=Instrumento.FormulaCobertura
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=96x17
ColorFondo=Blanco
ColorFuente=Negro
ConScroll=N

[Detalle.Instrumento.Tipo]
Carpeta=Detalle
Clave=Instrumento.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Instrumento.Cobertura]
Carpeta=Detalle
Clave=Instrumento.Cobertura
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Instrumento.MargenCompra]
Carpeta=Detalle
Clave=Instrumento.MargenCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Instrumento.MargenVenta]
Carpeta=Detalle
Clave=Instrumento.MargenVenta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Mon.TipoCambio]
Carpeta=Detalle
Clave=Mon.TipoCambio
Editar=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[Detalle.Instrumento.Mostrar]
Carpeta=Detalle
Clave=Instrumento.Mostrar
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Instrumento.Ventanilla]
Carpeta=Detalle
Clave=Instrumento.Ventanilla
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Denominaciones]
Nombre=Denominaciones
Boton=47
NombreEnBoton=S
NombreDesplegar=&Denominaciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=InstrumentoD
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Instrumento:Instrumento.Instrumento)
Antes=S
AntesExpresiones=Asigna(Info.Instrumento, Instrumento:Instrumento.Instrumento)
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Eliminar
Eliminar=Denominaciones
Denominaciones=Navegador
Navegador=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Instrumento.Instrumento
Instrumento.Instrumento=Instrumento.Descripcion
Instrumento.Descripcion=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=Instrumento.Instrumento
Instrumento.Instrumento=Instrumento.Descripcion
Instrumento.Descripcion=Instrumento.Moneda
Instrumento.Moneda=Instrumento.Uso
Instrumento.Uso=Instrumento.CtaDineroVenta
Instrumento.CtaDineroVenta=Instrumento.CtaDineroCompra
Instrumento.CtaDineroCompra=Instrumento.FormaPagoVenta
Instrumento.FormaPagoVenta=Instrumento.FormaPagoCompra
Instrumento.FormaPagoCompra=Instrumento.UnidadMinima
Instrumento.UnidadMinima=Instrumento.Tipo
Instrumento.Tipo=Instrumento.RequiereBeneficiario
Instrumento.RequiereBeneficiario=Instrumento.Mostrar
Instrumento.Mostrar=Instrumento.Ventanilla
Instrumento.Ventanilla=Instrumento.Cobertura
Instrumento.Cobertura=Mon.TipoCambio
Mon.TipoCambio=Instrumento.MargenCompra
Instrumento.MargenCompra=Instrumento.MargenVenta
Instrumento.MargenVenta=(Fin)
