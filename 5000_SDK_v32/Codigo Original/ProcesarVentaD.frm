[Forma]
Clave=ProcesarVentaD
Nombre=Ventas - Procesar en Lote (a Nivel Detalle)
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=74
PosicionInicialArriba=136
PosicionInicialAltura=488
PosicionInicialAncho=875
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Totalizadores=S
Menus=S
PosicionSeccion1=92
PosicionInicialAlturaCliente=461
EsConsultaExclusiva=S

MenuPrincipal=&Archivo
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProcesarVentaD
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaAjustarColumnas=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
HojaFondoGris=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=15
BusquedaEnLinea=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=VentaD.Almacen
FiltroValida1=VentaD.Almacen
FiltroGrupo2=VentaD.Articulo
FiltroValida2=VentaD.Articulo
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=15
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroFechas=S
FiltroFechasCampo=VentaD.FechaRequerida
FiltroFechasDefault=(Todo)
MenuLocal=S
ListaAcciones=Copiar
FiltroTodoFinal=S
FiltroGeneral=Venta.Estatus=<T>PENDIENTE<T> AND Venta.Mov IN ({MovListaSQL(<T>VTAS<T>, VTAS.P, VTAS.S, VTAS.F, VTAS.FAR)})

[Lista.VentaD.Articulo]
Carpeta=Lista
Clave=VentaD.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.VentaD.SubCuenta]
Carpeta=Lista
Clave=VentaD.SubCuenta
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=$00808040

[Lista.CantidadNeta]
Carpeta=Lista
Clave=CantidadNeta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.VentaD.CantidadReservada]
Carpeta=Lista
Clave=VentaD.CantidadReservada
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Azul
Efectos=[Negritas]

[Lista.VentaD.CantidadOrdenada]
Carpeta=Lista
Clave=VentaD.CantidadOrdenada
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Lista.VentaD.CantidadPendiente]
Carpeta=Lista
Clave=VentaD.CantidadPendiente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=$00004080
Efectos=[Negritas]

[Lista.VentaD.CantidadA]
Carpeta=Lista
Clave=VentaD.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=78
SubCuenta=78
Precio=64
CantidadNeta=48
DescuentoLinea=64
CantidadReservada=58
CantidadOrdenada=52
CantidadPendiente=52
CantidadA=52
Descripcion1=244
Importe=75
MovNombre=96
Cliente=62
Disponible=55
Almacen=50
FechaRequerida=68
Unidad=42

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreDesplegar=Afectar
EnBarraHerramientas=S
Activo=S
Visible=S
EspacioPrevio=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
EnMenu=S
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
NombreDesplegar=CambiarVista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S

[Lista.VentaD.Almacen]
Carpeta=Lista
Clave=VentaD.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Lista.VentaD.Unidad]
Carpeta=Lista
Clave=VentaD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.MovNombre]
Carpeta=Lista
Clave=MovNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Lista.Venta.Cliente]
Carpeta=Lista
Clave=Venta.Cliente
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Copiar]
Nombre=Copiar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Copiar Pendiente
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(ProcesarVentaD:VentaD.CantidadA, ProcesarVentaD:VentaD.CantidadPendiente+ProcesarVentaD:VentaD.CantidadReservada)

[Lista.ArtSubDisponible.Disponible]
Carpeta=Lista
Clave=ArtSubDisponible.Disponible
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

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
Totalizadores1=a Afectar<BR>Pendiente<BR>Reservado<BR>Ordenado
Totalizadores2=Suma(ProcesarVentaD:VentaD.CantidadA)<BR>Suma(ProcesarVentaD:VentaD.CantidadPendiente)<BR>Suma(ProcesarVentaD:VentaD.CantidadReservada)<BR>Suma(ProcesarVentaD:VentaD.CantidadOrdenada)
Totalizadores3=(Cantidades)<BR>(Cantidades)<BR>(Cantidades)<BR>(Cantidades)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=$00808040
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).a Afectar]
Carpeta=(Carpeta Totalizadores)
Clave=a Afectar
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Ordenado]
Carpeta=(Carpeta Totalizadores)
Clave=Ordenado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[(Carpeta Totalizadores).Reservado]
Carpeta=(Carpeta Totalizadores)
Clave=Reservado
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Azul
Efectos=[Negritas]

[(Carpeta Totalizadores).Pendiente]
Carpeta=(Carpeta Totalizadores)
Clave=Pendiente
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=$00004080
Efectos=[Negritas]

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
NombreDesplegar=Guardar Cambios
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
EnMenu=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
EnMenu=S
EspacioPrevio=S

[Acciones.Afectar.AfectarProcesarVentaD]
Nombre=AfectarProcesarVentaD
Boton=0
TipoAccion=Dialogos
ClaveAccion=AfectarProcesarVentaD
Activo=S
Visible=S

[Acciones.Afectar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.VentaD.FechaRequerida]
Carpeta=Lista
Clave=VentaD.FechaRequerida
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=MovNombre
MovNombre=VentaD.FechaRequerida
VentaD.FechaRequerida=Venta.Cliente
Venta.Cliente=VentaD.Articulo
VentaD.Articulo=VentaD.SubCuenta
VentaD.SubCuenta=VentaD.Unidad
VentaD.Unidad=VentaD.Almacen
VentaD.Almacen=CantidadNeta
CantidadNeta=ArtSubDisponible.Disponible
ArtSubDisponible.Disponible=VentaD.CantidadOrdenada
VentaD.CantidadOrdenada=VentaD.CantidadReservada
VentaD.CantidadReservada=VentaD.CantidadPendiente
VentaD.CantidadPendiente=VentaD.CantidadA
VentaD.CantidadA=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Cte.Nombre
Cte.Nombre=Venta.EnviarA
Venta.EnviarA=Art.Descripcion1
Art.Descripcion1=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Ordenado
Ordenado=Reservado
Reservado=Pendiente
Pendiente=a Afectar
a Afectar=(Fin)






[Acciones.Afectar.ListaAccionesMultiples]
(Inicio)=AfectarProcesarVentaD
AfectarProcesarVentaD=Actualizar Vista
Actualizar Vista=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar Cambios
Guardar Cambios=Afectar
Afectar=CambiarVista
CambiarVista=Cerrar
Cerrar=(Fin)
