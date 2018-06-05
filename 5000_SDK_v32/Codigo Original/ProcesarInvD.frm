[Forma]
Clave=ProcesarInvD
Nombre=Solicitudes - Procesar en Lote (a Nivel Detalle)
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=50
PosicionInicialArriba=136
PosicionInicialAltura=488
PosicionInicialAncho=924
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

PosicionSec1=364
MenuPrincipal=&Archivo
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProcesarInvD
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
ListaCamposAValidar=Art.Descripcion1
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
FiltroGrupo1=InvD.Almacen
FiltroValida1=InvD.Almacen
FiltroGrupo2=InvD.Articulo
FiltroValida2=InvD.Articulo
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=15
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroFechas=S
FiltroFechasCampo=InvD.FechaRequerida
FiltroFechasDefault=(Todo)
MenuLocal=S
ListaAcciones=Copiar
FiltroTodoFinal=S
FiltroGeneral=Inv.Estatus=<T>PENDIENTE<T> AND Inv.Mov IN ({MovListaSQL(<T>INV<T>, INV.SOL, INV.OT, INV.OI)})

[Lista.InvD.Articulo]
Carpeta=Lista
Clave=InvD.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.InvD.SubCuenta]
Carpeta=Lista
Clave=InvD.SubCuenta
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

[Lista.InvD.CantidadReservada]
Carpeta=Lista
Clave=InvD.CantidadReservada
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Azul
Efectos=[Negritas]

[Lista.InvD.CantidadOrdenada]
Carpeta=Lista
Clave=InvD.CantidadOrdenada
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Lista.InvD.CantidadPendiente]
Carpeta=Lista
Clave=InvD.CantidadPendiente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=$00004080
Efectos=[Negritas]

[Lista.InvD.CantidadA]
Carpeta=Lista
Clave=InvD.CantidadA
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
MovNombre=124
Cliente=62
Disponible=55
Almacen=50
FechaRequerida=68
Unidad=42
AlmacenDestino=83


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

[Lista.InvD.Almacen]
Carpeta=Lista
Clave=InvD.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Lista.InvD.Unidad]
Carpeta=Lista
Clave=InvD.Unidad
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
Expresion=Asigna(ProcesarInvD:InvD.CantidadA, ProcesarInvD:InvD.CantidadPendiente+ProcesarInvD:InvD.CantidadReservada)

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
Totalizadores2=Suma(ProcesarInvD:InvD.CantidadA)<BR>Suma(ProcesarInvD:InvD.CantidadPendiente)<BR>Suma(ProcesarInvD:InvD.CantidadReservada)<BR>Suma(ProcesarInvD:InvD.CantidadOrdenada)
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


[Lista.InvD.FechaRequerida]
Carpeta=Lista
Clave=InvD.FechaRequerida
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.Inv.AlmacenDestino]
Carpeta=Lista
Clave=Inv.AlmacenDestino
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=MovNombre
MovNombre=InvD.FechaRequerida
InvD.FechaRequerida=InvD.Articulo
InvD.Articulo=InvD.SubCuenta
InvD.SubCuenta=InvD.Unidad
InvD.Unidad=InvD.Almacen
InvD.Almacen=Inv.AlmacenDestino
Inv.AlmacenDestino=CantidadNeta
CantidadNeta=ArtSubDisponible.Disponible
ArtSubDisponible.Disponible=InvD.CantidadOrdenada
InvD.CantidadOrdenada=InvD.CantidadReservada
InvD.CantidadReservada=InvD.CantidadPendiente
InvD.CantidadPendiente=InvD.CantidadA
InvD.CantidadA=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Ordenado
Ordenado=Reservado
Reservado=Pendiente
Pendiente=a Afectar
a Afectar=(Fin)
























[Acciones.Afectar.AfectarProcesarInvD]
Nombre=AfectarProcesarInvD
Boton=0
TipoAccion=Dialogos
ClaveAccion=AfectarProcesarInvD
Activo=S
Visible=S

[Acciones.Afectar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreDesplegar=Afectar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
[Acciones.Afectar.ListaAccionesMultiples]
(Inicio)=AfectarProcesarInvD
AfectarProcesarInvD=Actualizar Vista
Actualizar Vista=(Fin)







[Forma.ListaAcciones]
(Inicio)=Guardar Cambios
Guardar Cambios=Afectar
Afectar=CambiarVista
CambiarVista=Cerrar
Cerrar=(Fin)
