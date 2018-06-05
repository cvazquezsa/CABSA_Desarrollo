[Forma]
Clave=CarteraVencidaCNBV
Nombre=Marcar / Desmarcar - Cartera Vencida CNBV
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=150
PosicionInicialArriba=243
PosicionInicialAlturaCliente=503
PosicionInicialAncho=979
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxcRama
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
IconosSubTitulo=<T>Movimiento<T>
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosSeleccionMultiple=S
BusquedaRapidaControles=S
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=Cxc.FechaEmision
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
IconosNombre=CxcRama:Cxc.Mov+<T> <T>+CxcRama:Cxc.MovID
FiltroGeneral=Cxc.Empresa=<T>{Empresa}<T> AND CxcRama.Saldo IS NOT NULL

[Lista.Cxc.FechaEmision]
Carpeta=Lista
Clave=Cxc.FechaEmision
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxc.Cliente]
Carpeta=Lista
Clave=Cxc.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxcRama.Saldo]
Carpeta=Lista
Clave=CxcRama.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxc.Moneda]
Carpeta=Lista
Clave=Cxc.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=120
1=88

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

[Lista.Cxc.CarteraVencidaCNBV]
Carpeta=Lista
Clave=Cxc.CarteraVencidaCNBV
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Marcar]
Nombre=Marcar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Marcar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
Expresion=RegistrarSeleccionID(<T>Lista<T>)<BR>EjecutarSQL(<T>spCarteraVencidaCNBV :nEstacion, :nMarcar<T>, EstacionTrabajo, 1) <BR>Forma.ActualizarVista

[Acciones.Desmarcar]
Nombre=Desmarcar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Desmarcar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
Expresion=RegistrarSeleccionID(<T>Lista<T>)<BR>EjecutarSQL(<T>spCarteraVencidaCNBV :nEstacion, :nMarcar<T>, EstacionTrabajo, 0) <BR>Forma.ActualizarVista

[Lista.CxcRama.InteresesOrdinarios]
Carpeta=Lista
Clave=CxcRama.InteresesOrdinarios
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxcRama.InteresesMoratorios]
Carpeta=Lista
Clave=CxcRama.InteresesMoratorios
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Marcar
Marcar=Desmarcar
Desmarcar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cxc.FechaEmision
Cxc.FechaEmision=Cxc.Cliente
Cxc.Cliente=Cte.Nombre
Cte.Nombre=CxcRama.Saldo
CxcRama.Saldo=CxcRama.InteresesOrdinarios
CxcRama.InteresesOrdinarios=CxcRama.InteresesMoratorios
CxcRama.InteresesMoratorios=Cxc.Moneda
Cxc.Moneda=Cxc.CarteraVencidaCNBV
Cxc.CarteraVencidaCNBV=(Fin)
