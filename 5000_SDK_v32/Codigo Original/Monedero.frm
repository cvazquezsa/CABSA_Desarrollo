
[Forma]
Clave=Monedero
Icono=67
Nombre=Monedero Electrónico
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=310
PosicionInicialArriba=186
PosicionInicialAlturaCliente=376
PosicionInicialAncho=726
PosicionSec1=140
EsMovimiento=S
MovEspecificos=Todos
BarraAyuda=S
BarraAyudaBold=S
TituloAutoNombre=S
TituloAuto=S
Menus=S
ListaAcciones=(Lista)
AutoGuardarEncabezado=S
DialogoAbrir=S
CarpetasMultilinea=S
MenuPrincipal=(Lista)
[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Monedero
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Monedero.Mov<BR>Monedero.MovID<BR>Monedero.UEN<BR>Monedero.FechaEmision<BR>Monedero.Referencia<BR>Monedero.Observaciones
CarpetaVisible=S

GuardarAlSalir=S
[Lista.Monedero.Mov]
Carpeta=Lista
Clave=Monedero.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Monedero.MovID]
Carpeta=Lista
Clave=Monedero.MovID
Editar=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata

Pegado=S
[Lista.Monedero.UEN]
Carpeta=Lista
Clave=Monedero.UEN
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=6
[Lista.Monedero.FechaEmision]
Carpeta=Lista
Clave=Monedero.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Lista.Monedero.Referencia]
Carpeta=Lista
Clave=Monedero.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
UEN=44
Nombre=269

0=430
Observacion=416
[Detalle]
Estilo=Hoja
Clave=Detalle
OtroOrden=S
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=MonederoD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=Monedero
LlaveLocal=MonederoD.ID
LlaveMaestra=Monedero.ID
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MonederoD.Serie<BR>MonederoD.SerieDestino<BR>MonederoD.Importe
ListaOrden=MonederoD.ID<TAB>(Acendente)<BR>MonederoD.Renglon<TAB>(Acendente)<BR>MonederoD.RenglonSub<TAB>(Acendente)
CarpetaVisible=S
ControlRenglon=S
CampoRenglon=MonederoD.Renglon

[Detalle.MonederoD.Serie]
Carpeta=Detalle
Clave=MonederoD.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.MonederoD.SerieDestino]
Carpeta=Detalle
Clave=MonederoD.SerieDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.MonederoD.Importe]
Carpeta=Detalle
Clave=MonederoD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.Columnas]
Serie=146
SerieDestino=157
Importe=125

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=MonederoA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Movimientos
ListaEnCaptura=Monedero.FechaEmision<BR>Monedero.UEN<BR>Monedero.Referencia
ListaOrden=Monedero.Mov<TAB>(Acendente)<BR>Monedero.MovID<TAB>(Acendente)<BR>Monedero.FechaEmision<TAB>(Acendente)
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechas=S
FiltroMovs=S
FiltroMovsTodos=S
FiltroListaEstatus=(Todos)<BR>SINAFECTAR<BR>CANCELADO<BR>CONCLUIDO
FiltroEstatusDefault=SINAFECTAR
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=Monedero.FechaEmision
FiltroFechasDefault=(Todo)
FiltroMovDefault=(Todos)
FiltroFechasCancelacion=Monedero.FechaCancelacion
BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaEnLinea=S
FiltroSucursales=S
FiltroUENsCampo=Monedero.UEN
IconosNombre=MonederoA:Monedero.Mov + <T> <T> + MonederoA:Monedero.MovID
[(Carpeta Abrir).Columnas]
0=173

1=90
2=58
3=416
[(Carpeta Abrir).Monedero.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Monedero.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).Monedero.UEN]
Carpeta=(Carpeta Abrir)
Clave=Monedero.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).Monedero.Referencia]
Carpeta=(Carpeta Abrir)
Clave=Monedero.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Monedero.Observaciones]
Carpeta=Lista
Clave=Monedero.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=75
ColorFondo=Blanco

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S

[Acciones.Abrir]
Nombre=Abrir
Boton=2
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S

Menu=&Archivo
[Acciones.Localizar]
Nombre=Localizar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Shift+F3
NombreDesplegar=L&ocalizar...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Localizar
Activo=S
Visible=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(Monedero:Monedero.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>MONEL<T>)<BR>Asigna(Info.ID, Monedero:Monedero.ID)
Visible=S

[Acciones.Afectar]
Nombre=Afectar
Boton=7
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=<T>A&fectar<T>
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
ConCondicion=S
Visible=S

Multiple=S
ListaAccionesMultiples=Afectacion<BR>Actualizar Vista
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, Monedero:Monedero.Usuario) y (Monedero:Monedero.Estatus en (EstatusSinAfectar))
EjecucionCondicion=ConDatos(Monedero:Monedero.Mov)
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
ActivoCondicion=Vacio(Monedero:Monedero.MovID) y (Monedero:Monedero.Estatus=EstatusSinAfectar) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Monedero:Monedero.Usuario)
ConCondicion=S
EjecucionCondicion=Vacio(SQL(<T>SELECT MovID FROM Monedero WHERE ID=:nID<T>, Monedero:Monedero.ID))
EjecucionMensaje=Forma.ActualizarForma<BR><T>El movimiento ya fue afectado por otro usuario<T>
EjecucionConError=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=<T>Cancela&r<T>
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
Visible=S

Multiple=S
ListaAccionesMultiples=Cancelacion<BR>Actualizar Cancelar
ConfirmarAntes=S
DialogoMensaje=EstaSeguroPrecaucion
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Monedero:Monedero.Usuario) y ConDatos(Monedero:Monedero.ID) y ConDatos(Monedero:Monedero.MovID) y<BR>(Monedero:Monedero.Estatus en (EstatusSinAfectar, EstatusConcluido))
[Acciones.Anterior]
Nombre=Anterior
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+,
NombreDesplegar=Anterior
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Anterior
Activo=S
Visible=S

[Acciones.Siguiente]
Nombre=Siguiente
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+.
NombreDesplegar=Siguiente
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Siguiente
Activo=S
Visible=S

[Acciones.Tiempo]
Nombre=Tiempo
Boton=0
Menu=&Ver
NombreDesplegar=&Tiempos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerMovTiempo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Monedero:Monedero.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>MONEL<T>)<BR>Asigna(Info.ID, Monedero:Monedero.ID)<BR>Asigna(Info.Mov, Monedero:Monedero.Mov)<BR>Asigna(Info.MovID,Monedero:Monedero.MovID)
Visible=S

[Acciones.MovPos]
Nombre=MovPos
Boton=0
Menu=&Ver
NombreDesplegar=&Posición del Movimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPos
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Monedero:Monedero.MovID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>MONEL<T>)<BR>Asigna(Info.ID, Monedero:Monedero.ID)<BR>Asigna(Info.Mov, Monedero:Monedero.Mov)<BR>Asigna(Info.MovID,Monedero:Monedero.MovID)
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F4
NombreDesplegar=Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Afectar.Afectacion]
Nombre=Afectacion
Boton=0
TipoAccion=Expresion
Expresion=ProcesarSQL(<T>EXEC spAfectarMonedero :tEmp, :nSuc, :tAcc, :nID, :tUsu, :tMod, :tMov, :tEst<T>, Empresa, Sucursal, <T>AFECTAR<T>, Monedero:Monedero.ID, Usuario, <T>MONEL<T>, Monedero:Monedero.Mov, Monedero:Monedero.Estatus )
Activo=S
Visible=S

[Acciones.Afectar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Cancelar.Cancelacion]
Nombre=Cancelacion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=ProcesarSQL(<T>EXEC spAfectarMonedero :tEmp, :nSuc, :tAcc, :nID, :tUsu, :tMod, :tMov, :tEst<T>, Empresa, Sucursal, <T>CANCELAR<T>, Monedero:Monedero.ID, Usuario, <T>MONEL<T>, Monedero:Monedero.Mov, Monedero:Monedero.Estatus )
[Acciones.Cancelar.Actualizar Cancelar]
Nombre=Actualizar Cancelar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S



















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Localizar
Localizar=Guardar
Guardar=Propiedades
Propiedades=Afectar
Afectar=Eliminar
Eliminar=Cancelar
Cancelar=Anterior
Anterior=Siguiente
Siguiente=Tiempo
Tiempo=MovPos
MovPos=Navegador
Navegador=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)
