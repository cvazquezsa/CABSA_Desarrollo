
[Forma]
Clave=HerrAlmPos
Icono=0
Modulos=(Todos)
Nombre=Ubicaciones de Almacén

ListaCarpetas=Alm
CarpetaPrincipal=Alm
PosicionInicialAlturaCliente=445
PosicionInicialAncho=505
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=387
PosicionInicialArriba=68
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Alm]
Estilo=Iconos
Clave=Alm
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Alm
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Alm.Nombre
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Almacenes
IconosConRejilla=S
IconosNombre=Alm:Alm.Almacen
FiltroGeneral=Alm.Ubicaciones  = 1  AND Alm.Sucursal = {Sucursal}
[Alm.Alm.Nombre]
Carpeta=Alm
Clave=Alm.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Alm.Columnas]
0=120
1=-2

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.CambioPos]
Nombre=CambioPos
Boton=95
NombreDesplegar=Cambio Posición
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S





NombreEnBoton=S
EspacioPrevio=S




ConCondicion=S
EjecucionConError=S










Multiple=S
ListaAccionesMultiples=(Lista)
EjecucionCondicion=ConDatos(Alm:Alm.Almacen)
EjecucionMensaje=<T>Es Necesario asignar un Almacen<T>

[Acciones.CambioPos.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spInsertarAlmPosTemp :nEstacion, :tEmpresa, :tUsuario, :tAlmacen<T>,EstacionTrabajo,Empresa,Usuario,Alm:Alm.Almacen)<BR>PlugIn(<T>Almacen<T>)
Activo=S
Visible=S

[Acciones.CambioPos.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.CambioPos.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)









[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CambioPos
CambioPos=(Fin)
