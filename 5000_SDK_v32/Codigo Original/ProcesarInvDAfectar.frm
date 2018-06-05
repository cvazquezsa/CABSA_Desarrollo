[Forma]
Clave=ProcesarInvDAfectar
Nombre=<T>Movimientos a <T>+Afectar.Accion
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=177
PosicionInicialArriba=235
PosicionInicialAltura=298
PosicionInicialAncho=670
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaSiempreAlFrente=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Menus=S
PosicionInicialAlturaCliente=271
MenuPrincipal=&Archivo

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProcesarInvDAfectar
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
PestanaOtroNombre=S
PestanaNombre=Movimiento(s)
IconosSeleccionMultiple=S
IconosNombre=ProcesarInvDAfectar:Mov+<T> <T>+ProcesarInvDAfectar:MovID

[Lista.FechaEmision]
Carpeta=Lista
Clave=FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.FechaRequerida]
Carpeta=Lista
Clave=FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=172
1=85

[Acciones.Aceptar]
Nombre=Aceptar
Boton=7
NombreDesplegar=&Afectar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
EnMenu=S
EspacioPrevio=S
ConCondicion=S
EjecucionConError=S
Antes=S
EjecucionCondicion=CuantosSeleccionID(<T>Lista<T>)>0
EjecucionMensaje=<T>Falta Seleccionar<T>
AntesExpresiones=RegistrarSeleccionID(<T>Lista<T>)<BR>ProcesarSQL(<T>spProcesarVentaInvD :nEstacion, :tModulo, :tAccion<T>, EstacionTrabajo, <T>INV<T>, Afectar.Accion)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
NombreDesplegar=Cancelar
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
Menu=&Archivo
EnMenu=S
EnBarraHerramientas=S

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=55
NombreEnBoton=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
Menu=&Archivo
NombreDesplegar=Propiedades
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ProcesarInvDAfectar:ID)
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, ProcesarInvDAfectar:ID)

[Lista.Almacen]
Carpeta=Lista
Clave=Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AlmacenDestino]
Carpeta=Lista
Clave=AlmacenDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Aceptar
Aceptar=Cancelar
Cancelar=MovPropiedades
MovPropiedades=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=FechaEmision
FechaEmision=FechaRequerida
FechaRequerida=Almacen
Almacen=AlmacenDestino
AlmacenDestino=(Fin)
