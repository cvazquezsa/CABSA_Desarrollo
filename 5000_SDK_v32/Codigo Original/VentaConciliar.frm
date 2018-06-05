[Forma]
Clave=VentaConciliar
Nombre=Generar la Lista de Empaque
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Nuevos
PosicionInicialAltura=478
PosicionInicialAncho=821
PosicionInicialIzquierda=101
PosicionInicialArriba=142
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSeccion1=44
PosicionColumna1=54
PosicionSeccion2=91
PosicionColumna2=55
VentanaExclusiva=S
VentanaSinIconosMarco=S
PosicionInicialAlturaCliente=449

[Lista.Columnas]
Estacion=64
Clave=105
0=276
1=53
Orden=45
ArticuloA=108
SubCuentaA=84
CantidadA=50
ArticuloN=110
SubCuentaN=105
CantidadN=61
OrdenN=40
OrdenA=44
Articulo=124
SubCuenta=124
Cantidad=64

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

[Contrasena]
Estilo=Ficha
Clave=Contrasena
InicializarVariables=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Vista=(Variables)
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
ListaEnCaptura=Info.Contrasena
CondicionVisible=Vacio(Venta:Venta.MovID) o (Venta:Venta.Estatus=EstatusSinAfectar)

[Contrasena.Info.Contrasena]
Carpeta=Contrasena
Clave=Info.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Pedidio.Columnas]
Articulo=124
SubCuenta=124
Cantidad=64

[Anteriores]
Estilo=Hoja
PestanaNombre=Anteriores
Clave=Anteriores
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=VentaConciliarA
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
OtroOrden=S
ListaEnCaptura=(Lista)
ListaOrden=VentaConciliarA.Orden<TAB>(Acendente)
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaFondoGris=S
HojaSinBorde=S
HojaMostrarColumnas=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=VentaConciliarA.Estacion={EstacionTrabajo}
CondicionVisible=Vacio(Venta:Venta.MovID) o (Venta:Venta.Estatus=EstatusSinAfectar)

[Nuevos]
Estilo=Hoja
PestanaNombre=Anteriores
Clave=Nuevos
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=VentaConciliarN
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=VentaConciliarN.Orden<TAB>(Acendente)
PermiteEditar=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
HojaFondoGris=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=VentaConciliarN.Estacion={EstacionTrabajo}
CondicionVisible=Vacio(Venta:Venta.MovID) o (Venta:Venta.Estatus=EstatusSinAfectar)

[Nuevos.VentaConciliarN.Orden]
Carpeta=Nuevos
Clave=VentaConciliarN.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Nuevos.VentaConciliarN.Articulo]
Carpeta=Nuevos
Clave=VentaConciliarN.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Nuevos.VentaConciliarN.SubCuenta]
Carpeta=Nuevos
Clave=VentaConciliarN.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Nuevos.VentaConciliarN.Cantidad]
Carpeta=Nuevos
Clave=VentaConciliarN.Cantidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Anteriores.VentaConciliarA.Orden]
Carpeta=Anteriores
Clave=VentaConciliarA.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Anteriores.VentaConciliarA.Articulo]
Carpeta=Anteriores
Clave=VentaConciliarA.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Anteriores.VentaConciliarA.SubCuenta]
Carpeta=Anteriores
Clave=VentaConciliarA.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Anteriores.VentaConciliarA.Cantidad]
Carpeta=Anteriores
Clave=VentaConciliarA.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Nuevos.Columnas]
Orden=53
Articulo=119
SubCuenta=89
Cantidad=48
Unidad=53
CantidadAlterna=48

[Anteriores.Columnas]
Orden=43
Articulo=103
SubCuenta=85
Cantidad=54
Unidad=49

[Acciones.Afectar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Afectar.PostConciliar]
Nombre=PostConciliar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spProcesarCBPostConciliar :nEstacion, :nID, :nGenerarID, :tPassword<T>, EstacionTrabajo, Info.ID, Venta:Venta.ID, Info.Contrasena)<BR>Afectar(<T>VTAS<T>, Venta:Venta.ID,  Venta:Venta.Mov, Venta:Venta.MovID)

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreEnBoton=S
NombreDesplegar=<T>&Afectar<T>
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Variables Asignar<BR>PostConciliar<BR>Actualizar Forma<BR>Refrescar Controles
Visible=S
ConCondicion=S
EspacioPrevio=S
ActivoCondicion=Vacio(Venta:Venta.MovID) o (Venta:Venta.Estatus=EstatusSinAfectar)
EjecucionCondicion=ConDatos(Venta:Venta.ID) y (Vacio(Venta:Venta.MovID) o (Venta:Venta.Estatus=EstatusSinAfectar))

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
TipoAccion=Expresion
ListaParametros1=Venta:Venta.ID
ConCondicion=S
EjecucionConError=S
Visible=S
Expresion=ReportePantalla(ReporteMovPantalla(<T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.Estatus), Venta:Venta.ID)
ActivoCondicion=Venta:Venta.Estatus=EstatusPendiente
EjecucionCondicion=Venta:Venta.Estatus=EstatusPendiente
EjecucionMensaje=<T>Necesita Afectar Antes<T>

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Visible=S
ConfirmarAntes=S
Antes=S
ConCondicion=S
GuardarAntes=S
DespuesGuardar=S
ActivoCondicion=Vacio(Venta:Venta.MovID) o (Venta:Venta.Estatus=EstatusSinAfectar)
EjecucionCondicion=Vacio(Venta:Venta.MovID) o (Venta:Venta.Estatus=EstatusSinAfectar)
AntesExpresiones=Si(ConDatos(Venta:Venta.ID), EjecutarSQL(<T>spMovEliminarSinAfectar :tModulo, :nID<T>, <T>VTAS<T>, Venta:Venta.ID))

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Venta
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
CarpetaVisible=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Venta.ID={Afectar.ID}

[Ficha.Venta.FechaEmision]
Carpeta=Ficha
Clave=Venta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Venta.Cliente]
Carpeta=Ficha
Clave=Venta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
3D=S
Pegado=N
Tamano=50
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Venta.Almacen]
Carpeta=Ficha
Clave=Venta.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Venta.Agente]
Carpeta=Ficha
Clave=Venta.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CteEnviarA.Nombre]
Carpeta=Ficha
Clave=CteEnviarA.Nombre
Editar=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Venta.Mov]
Carpeta=Ficha
Clave=Venta.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Detalles]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
Clave=Detalles
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaD
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Subcuenta
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaNombre=Detalles
HojaFondoGris=S
HojaMostrarColumnas=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=VentaD.ID={Afectar.ID}

[Detalles.VentaD.Articulo]
Carpeta=Detalles
Clave=VentaD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.VentaD.SubCuenta]
Carpeta=Detalles
Clave=VentaD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.VentaD.Cantidad]
Carpeta=Detalles
Clave=VentaD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.Columnas]
Articulo=144
SubCuenta=147
Cantidad=64
Descripcion1=236
Unidad=60

[Detalles.Art.Descripcion1]
Carpeta=Detalles
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Detalles.VentaD.Unidad]
Carpeta=Detalles
Clave=VentaD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Venta.MovID]
Carpeta=Ficha
Clave=Venta.MovID
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Visible=S
ConCondicion=S
EjecucionConError=S
ActivoCondicion=ConDatos(Venta:Venta.MovID) y (Venta:Venta.Estatus<>EstatusSinAfectar)
EjecucionCondicion=ConDatos(Venta:Venta.MovID) y (Venta:Venta.Estatus<>EstatusSinAfectar)
EjecucionMensaje=<T>Oprima Eliminar para Salir<T>

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
TipoAccion=Expresion
EspacioPrevio=S
ConCondicion=S
Visible=S
EjecucionConError=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>VTAS<T>, Venta:Venta.Mov, Venta:Venta.Estatus), Venta:Venta.ID)
ActivoCondicion=Venta:Venta.Estatus=EstatusPendiente
EjecucionCondicion=Venta:Venta.Estatus=EstatusPendiente
EjecucionMensaje=<T>Necesita Afectar Antes<T>

[Acciones.Afectar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Afectar.Refrescar Controles]
Nombre=Refrescar Controles
Boton=0
Carpeta=(Todos)
TipoAccion=Controles Captura
ClaveAccion=Refrescar Controles
Activo=S
Visible=S

[Anteriores.VentaConciliarA.Unidad]
Carpeta=Anteriores
Clave=VentaConciliarA.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Nuevos.CantidadAlterna]
Carpeta=Nuevos
Clave=CantidadAlterna
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Nuevos.VentaConciliarN.Unidad]
Carpeta=Nuevos
Clave=VentaConciliarN.Unidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Detalles
Detalles=Nuevos
Nuevos=Anteriores
Anteriores=Contrasena
Contrasena=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Afectar
Afectar=Eliminar
Eliminar=Imprimir
Imprimir=Preliminar
Preliminar=(Fin)

[Anteriores.ListaEnCaptura]
(Inicio)=VentaConciliarA.Orden
VentaConciliarA.Orden=VentaConciliarA.Articulo
VentaConciliarA.Articulo=VentaConciliarA.SubCuenta
VentaConciliarA.SubCuenta=VentaConciliarA.Cantidad
VentaConciliarA.Cantidad=VentaConciliarA.Unidad
VentaConciliarA.Unidad=(Fin)

[Nuevos.ListaEnCaptura]
(Inicio)=VentaConciliarN.Orden
VentaConciliarN.Orden=VentaConciliarN.Articulo
VentaConciliarN.Articulo=VentaConciliarN.SubCuenta
VentaConciliarN.SubCuenta=CantidadAlterna
CantidadAlterna=VentaConciliarN.Cantidad
VentaConciliarN.Cantidad=VentaConciliarN.Unidad
VentaConciliarN.Unidad=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Venta.Mov
Venta.Mov=Venta.MovID
Venta.MovID=Venta.FechaEmision
Venta.FechaEmision=Venta.Cliente
Venta.Cliente=Cte.Nombre
Cte.Nombre=Venta.Almacen
Venta.Almacen=Venta.Agente
Venta.Agente=CteEnviarA.Nombre
CteEnviarA.Nombre=(Fin)

[Detalles.ListaEnCaptura]
(Inicio)=VentaD.Articulo
VentaD.Articulo=Art.Descripcion1
Art.Descripcion1=VentaD.SubCuenta
VentaD.SubCuenta=VentaD.Cantidad
VentaD.Cantidad=VentaD.Unidad
VentaD.Unidad=(Fin)
