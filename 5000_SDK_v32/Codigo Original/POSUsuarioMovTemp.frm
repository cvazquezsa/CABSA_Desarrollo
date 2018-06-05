
[Forma]
Clave=POSUsuarioMovTemp
Icono=0
CarpetaPrincipal=POSUsuarioMovTemp
Modulos=(Todos)
Nombre=Movimientos POS
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=POSUsuarioMovTemp
PosicionInicialIzquierda=550
PosicionInicialArriba=164
PosicionInicialAlturaCliente=534
PosicionInicialAncho=500
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Expresion
Comentarios=Info.Usuario
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSUsuarioMov :nEstacion, :tUsuario,:tEmpresa<T>,EstacionTrabajo, Info.Usuario,Empresa)
[POSUsuarioMovTemp]
Estilo=Iconos
Clave=POSUsuarioMovTemp
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSUsuarioMovTemp
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSeleccionMultiple=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=POSUsuarioMovTemp.Mov
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Movimientos
MenuLocal=S
FiltroGeneral=POSUsuarioMovTemp.Estacion={EstacionTrabajo}
ListaAcciones=(Lista)
[POSUsuarioMovTemp.POSUsuarioMovTemp.Mov]
Carpeta=POSUsuarioMovTemp
Clave=POSUsuarioMovTemp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSUsuarioMovTemp.Columnas]
0=-2

[Acciones.Expresion]
Nombre=Expresion
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[POSUsuarioMovTemp.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=(Fin)

[Acciones.Expresion.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  CuantosSeleccionID(<T>POSUsuarioMovTemp<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>POSUsuarioMovTemp<T>)<BR>  EjecutarSQL(<T>spPOSUsuarioInsertarMov :nEstacion,  :tUsuario<T>, EstacionTrabajo,Info.Usuario)<BR>Fin
[Acciones.Expresion.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Acciones.Expresion.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)
