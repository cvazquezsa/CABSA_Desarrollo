
[Forma]
Clave=POSUsuarioAccionTemp
Icono=0
CarpetaPrincipal=POSUsuarioAccionTemp
Modulos=(Todos)
Nombre=Acciones POS
ListaCarpetas=POSUsuarioAccionTemp

EsConsultaExclusiva=S
PosicionInicialIzquierda=455
PosicionInicialArriba=142
PosicionInicialAltura=467
PosicionInicialAncho=689
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=578



VentanaEstadoInicial=Normal
ListaAcciones=Accion
Comentarios=Info.Usuario
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSInsertarUsuarioAccion :nEstacion, :tUsuario<T>,EstacionTrabajo, Info.Usuario)
[Lista.Columnas]
Sucursal=58
Nombre=266
Prefijo=62
Region=79
0=91
1=267


[Acciones.LocalTodo]
Nombre=LocalTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S


[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)



[POSAccion.Columnas]
0=316







[POSAccion.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)








[POSUsuarioAccionTemp]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Acciones
Clave=POSUsuarioAccionTemp
Filtros=S
MenuLocal=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSUsuarioAccionTemp
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Acción<T>
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaAcciones=(Lista)

CarpetaVisible=S

IconosNombre=POSUsuarioAccionTemp:POSUsuarioAccionTemp.Accion
IconosSeleccionMultiple=S
FiltroGeneral=POSUsuarioAccionTemp.Estacion={EstacionTrabajo}
[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)

[Acciones.Accion.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  CuantosSeleccionID(<T>POSUsuarioAccionTemp<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>POSUsuarioAccionTemp<T>)<BR>  EjecutarSQL(<T>spPOSUsuarioInsertarAccion :nEstacion,  :tUsuario<T>, EstacionTrabajo,Info.Usuario)<BR>Fin
[Acciones.Accion.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Accion]
Nombre=Accion
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S



[POSUsuarioAccionTemp.Columnas]
0=-2

[POSUsuarioAccionTemp.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)

[Acciones.Accion.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)
