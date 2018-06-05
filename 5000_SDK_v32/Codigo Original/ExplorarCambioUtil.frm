[Forma]
Clave=ExplorarCambioUtil
Nombre=Explorando - Utilidades
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=288
PosicionInicialArriba=262
PosicionInicialAltura=236
PosicionInicialAncho=448
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.FechaD, Info.FechaA)
ExpresionesAlMostrar=Forma(<T>EspecificarFechas<T>)<BR>EjecutarSQL(<T>spVerCambioUtil :nEstacion, :tEmpresa, :fFechaD, :fFechaA, :nSucursal<T>,  EstacionTrabajo , Empresa, Info.FechaD, Info.FechaA, Sucursal)
PosicionInicialAlturaCliente=209

[Lista]
Estilo=Ficha
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerCambioUtil
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
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=VerCambioUtil.Moneda
FiltroAutoValidar=VerCambioUtil.Moneda
FiltroAutoOrden=Mon.Orden
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroEstilo=Folder (1 línea)
FiltroRespetar=S
FiltroTipo=Automático
FiltroGeneral=VerCambioUtil.Estacion={EstacionTrabajo} AND VerCambioUtil.Empresa=<T>{Empresa}<T>

[Lista.VerCambioUtil.Inicio]
Carpeta=Lista
Clave=VerCambioUtil.Inicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.InicioTC]
Carpeta=Lista
Clave=VerCambioUtil.InicioTC
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.InicioMN]
Carpeta=Lista
Clave=VerCambioUtil.InicioMN
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.Compra]
Carpeta=Lista
Clave=VerCambioUtil.Compra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.CompraTC]
Carpeta=Lista
Clave=VerCambioUtil.CompraTC
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.CompraMN]
Carpeta=Lista
Clave=VerCambioUtil.CompraMN
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.Venta]
Carpeta=Lista
Clave=VerCambioUtil.Venta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.VentaTC]
Carpeta=Lista
Clave=VerCambioUtil.VentaTC
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.VentaMN]
Carpeta=Lista
Clave=VerCambioUtil.VentaMN
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.Final]
Carpeta=Lista
Clave=VerCambioUtil.Final
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.FinalTC]
Carpeta=Lista
Clave=VerCambioUtil.FinalTC
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.FinalMN]
Carpeta=Lista
Clave=VerCambioUtil.FinalMN
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.UtilidadMN]
Carpeta=Lista
Clave=VerCambioUtil.UtilidadMN
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N
Efectos=[Negritas]

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

[Acciones.Fechas]
Nombre=Fechas
Boton=53
NombreEnBoton=S
NombreDesplegar=&Fechas
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Antes=S
AntesExpresiones=Si(Forma(<T>EspecificarFechas<T>), EjecutarSQL(<T>spVerCambioUtil :nEstacion, :tEmpresa, :fFechaD, :fFechaA, :nSucursal<T>,  EstacionTrabajo , Empresa, Info.FechaD, Info.FechaA, Sucursal), AbortarOperacion)

[Lista.VerCambioUtil.FechaD]
Carpeta=Lista
Clave=VerCambioUtil.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
EspacioPrevio=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Lista.VerCambioUtil.FechaA]
Carpeta=Lista
Clave=VerCambioUtil.FechaA
Editar=S
ValidaNombre=S
3D=N
Tamano=11
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Fechas
Fechas=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VerCambioUtil.Inicio
VerCambioUtil.Inicio=VerCambioUtil.InicioTC
VerCambioUtil.InicioTC=VerCambioUtil.InicioMN
VerCambioUtil.InicioMN=VerCambioUtil.Compra
VerCambioUtil.Compra=VerCambioUtil.CompraTC
VerCambioUtil.CompraTC=VerCambioUtil.CompraMN
VerCambioUtil.CompraMN=VerCambioUtil.Venta
VerCambioUtil.Venta=VerCambioUtil.VentaTC
VerCambioUtil.VentaTC=VerCambioUtil.VentaMN
VerCambioUtil.VentaMN=VerCambioUtil.Final
VerCambioUtil.Final=VerCambioUtil.FinalTC
VerCambioUtil.FinalTC=VerCambioUtil.FinalMN
VerCambioUtil.FinalMN=VerCambioUtil.FechaD
VerCambioUtil.FechaD=VerCambioUtil.FechaA
VerCambioUtil.FechaA=VerCambioUtil.UtilidadMN
VerCambioUtil.UtilidadMN=(Fin)
