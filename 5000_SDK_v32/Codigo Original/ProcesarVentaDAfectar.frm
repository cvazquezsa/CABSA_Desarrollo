[Forma]
Clave=ProcesarVentaDAfectar
Nombre=<T>Movimientos a <T>+Afectar.Accion
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=177
PosicionInicialArriba=231
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
EsConsultaExclusiva=S
MenuPrincipal=&Archivo

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProcesarVentaDAfectar
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
IconosNombre=ProcesarVentaDAfectar:Mov+<T> <T>+ProcesarVentaDAfectar:MovID
IconosSeleccionMultiple=S

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

[Lista.Cliente]
Carpeta=Lista
Clave=Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Nombre]
Carpeta=Lista
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EnviarA]
Carpeta=Lista
Clave=EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=132
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
AntesExpresiones=RegistrarSeleccionID(<T>Lista<T>)<BR>ProcesarSQL(<T>spProcesarVentaInvD :nEstacion, :tModulo, :tAccion<T>, EstacionTrabajo, <T>VTAS<T>, Afectar.Accion)

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
EjecucionCondicion=ConDatos(ProcesarVentaDAfectar:ID)
AntesExpresiones=Asigna(Info.Modulo, <T>VTAS<T>)<BR>Asigna(Info.ID, ProcesarVentaDAfectar:ID)

[Forma.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Aceptar
Aceptar=Cancelar
Cancelar=MovPropiedades
MovPropiedades=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=FechaEmision
FechaEmision=FechaRequerida
FechaRequerida=Cliente
Cliente=Nombre
Nombre=EnviarA
EnviarA=(Fin)
