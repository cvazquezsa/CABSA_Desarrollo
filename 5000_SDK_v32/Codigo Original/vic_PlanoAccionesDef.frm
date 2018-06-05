
[Forma]
Clave=vic_PlanoAccionesDef
Icono=4
Modulos=(Todos)
Nombre=Definición de la Acción
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal

ListaCarpetas=Definicion
CarpetaPrincipal=Definicion
PosicionInicialIzquierda=493
PosicionInicialArriba=361
PosicionInicialAlturaCliente=279
PosicionInicialAncho=934
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraAyuda=S
BarraAyudaBold=S
ListaAcciones=(Lista)
Comentarios=Lista(<T>Planograma <T> +Info.Plano, <T>Acción: <T> + Info.Nombre)
[Definicion]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Definición
Clave=Definicion
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=vic_PlanoAccionesDef
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S
OtroOrden=S

ListaOrden=vic_PlanoAccionesDef.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ControlRenglon=S
CampoRenglon=vic_PlanoAccionesDef.Renglon
PermiteEditar=S
FiltroGeneral=vic_PlanoAccionesDef.Plano = <T>{Info.Plano}<T> AND  <BR>vic_PlanoAccionesDef.Nombre = <T>{Info.Nombre}<T>
[Definicion.vic_PlanoAccionesDef.Orden]
Carpeta=Definicion
Clave=vic_PlanoAccionesDef.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Definicion.vic_PlanoAccionesDef.Color]
Carpeta=Definicion
Clave=vic_PlanoAccionesDef.Color
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Definicion.vic_PlanoAccionesDef.Expresion]
Carpeta=Definicion
Clave=vic_PlanoAccionesDef.Expresion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Definicion.Columnas]
Orden=64
Color=64
Expresion=391

LeyendaColor=135
NombreColor=244
Color_1=128
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

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

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S


[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar Cambios
Cancelar Cambios=Cancelar
Cancelar=(Fin)

























[Definicion.vic_PlanoAccionesDef.LeyendaColor]
Carpeta=Definicion
Clave=vic_PlanoAccionesDef.LeyendaColor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro










[Color.Columnas]
Color=144
Numero=64





[Definicion.Color.Color]
Carpeta=Definicion
Clave=Color.Color
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris








[Definicion.ListaEnCaptura]
(Inicio)=vic_PlanoAccionesDef.Orden
vic_PlanoAccionesDef.Orden=vic_PlanoAccionesDef.LeyendaColor
vic_PlanoAccionesDef.LeyendaColor=vic_PlanoAccionesDef.Color
vic_PlanoAccionesDef.Color=Color.Color
Color.Color=vic_PlanoAccionesDef.Expresion
vic_PlanoAccionesDef.Expresion=(Fin)



















[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cancelar
Cancelar=(Fin)
