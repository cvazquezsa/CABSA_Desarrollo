[Forma]
Clave=VentaCopiar
Nombre=Copiar
Icono=5
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=237
PosicionInicialArriba=233
PosicionInicialAltura=441
PosicionInicialAncho=806
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
EsMovimiento=S
TituloAuto=S
MovModulo=VTAS
MovEspecificos=Todos
Comentarios=Si(ConDatos(Info.EnviarA), <T>Sucursal: <T>+Info.EnviarA+NuevaLinea)+Lista(Info.Cliente, Info.Nombre)
PosicionInicialAlturaCliente=414

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaCteD
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
Filtros=S
BusquedaRapidaControles=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroEstatusDefault=CONCLUIDO
FiltroFechasCampo=VentaCteD.FechaEmision
FiltroFechasDefault=Hoy
FiltroFechasNormal=S
ValidarCampos=S
FiltroMovsTodos=S
FiltroSituacionTodo=S
FiltroUsuarioDefault=(Todos)
FiltroMovDefault=(Todos)
BusquedaRapida=S
BusquedaAncho=20
BusquedaEnLinea=S
MenuLocal=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
ListaCamposAValidar=(Lista)
PermiteEditar=S
HojaMantenerSeleccion=S
HojaFondoGris=S
ListaAcciones=Copiar
FiltroMovs=S
FiltroEstatus=S
FiltroSituacion=S
FiltroListaEstatus=(Lista)
IgnorarControlesEdicion=S
BusquedaRespetarFiltros=S
BusquedaRespetarControles=S

FiltroGeneral=VentaCteD.Estacion = {EstacionTrabajo} AND VentaCteD.Empresa=<T>{Empresa}<T> AND<BR>VentaCteD.Cliente=<T>{Info.Cliente}<T><BR>{Si(ConDatos(Info.EnviarA), <T> AND VentaCteD.EnviarA = <T>+Info.EnviarA, <T><T>)}
FiltroMonedas=S
FiltroMonedasCampo=VentaCteD.Moneda
[Lista.ImporteLinea]
Carpeta=Lista
Clave=ImporteLinea
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
Totalizador=1

[Lista.Columnas]
MovNombre=113
FechaEmision=72
Almacen=66
Articulo=99
Descripcion1=137
Cantidad=47
SubCuenta=86
Precio=62
DescuentoLinea=33
ImporteLinea=85
CantidadA=58
CantidadNeta=48
0=103
1=82
EnviarA=44
Codigo=87

[Lista.CantidadNeta]
Carpeta=Lista
Clave=CantidadNeta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
Totalizador=1

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
Activo=S
Visible=S
TipoAccion=Ventana
ClaveAccion=Cancelar

[Lista.MovNombre]
Carpeta=Lista
Clave=MovNombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Plata

[Acciones.Copiar]
Nombre=Copiar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Copiar
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(VentaCteD:VentaCteD.CantidadA, VentaCteD:CantidadNeta)
ActivoCondicion=ConDatos(VentaCteD:CantidadNeta)

[Lista.VentaCteD.Articulo]
Carpeta=Lista
Clave=VentaCteD.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Lista.VentaCteD.Precio]
Carpeta=Lista
Clave=VentaCteD.Precio
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Lista.VentaCteD.DescuentoLinea]
Carpeta=Lista
Clave=VentaCteD.DescuentoLinea
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Lista.VentaCteD.CantidadA]
Carpeta=Lista
Clave=VentaCteD.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.VentaCteD.FechaEmision]
Carpeta=Lista
Clave=VentaCteD.FechaEmision
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Lista.VentaCteD.Almacen]
Carpeta=Lista
Clave=VentaCteD.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spVentaCteDAceptar :nSucursal, :nEstacion, :nID, :tMovTipo, :nCopiarAplicacion<T>, Sucursal, EstacionTrabajo, Info.ID, Info.MovTipo, 0)
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.VentaCteD.EnviarA]
Carpeta=Lista
Clave=VentaCteD.EnviarA
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata

[Acciones.Todos]
Nombre=Todos
Boton=55
NombreEnBoton=S
NombreDesplegar=&Todas Direcciones Envio
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.EnviarA, Nulo)
VisibleCondicion=ConDatos(Info.EnviarA)

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.VentaCteD.Codigo]
Carpeta=Lista
Clave=VentaCteD.Codigo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata





[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)


[Lista.ListaEnCaptura]
(Inicio)=MovNombre
MovNombre=VentaCteD.FechaEmision
VentaCteD.FechaEmision=VentaCteD.EnviarA
VentaCteD.EnviarA=VentaCteD.Almacen
VentaCteD.Almacen=VentaCteD.Codigo
VentaCteD.Codigo=VentaCteD.Articulo
VentaCteD.Articulo=CantidadNeta
CantidadNeta=VentaCteD.Precio
VentaCteD.Precio=VentaCteD.DescuentoLinea
VentaCteD.DescuentoLinea=ImporteLinea
ImporteLinea=VentaCteD.CantidadA
VentaCteD.CantidadA=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=VentaCteD.Descripcion1
VentaCteD.Descripcion1=VentaCteD.SubCuenta
VentaCteD.SubCuenta=VentaCteD.DescripcionExtra
VentaCteD.DescripcionExtra=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Todos
Todos=Actualizar
Actualizar=(Fin)
