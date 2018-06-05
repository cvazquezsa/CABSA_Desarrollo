
[Forma]
Clave=CFDINominaReciboCancelar
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI - Recibo Nómina SAT
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=173
PosicionInicialArriba=79
PosicionInicialAlturaCliente=531
PosicionInicialAncho=1020
Comentarios=Info.Mov + <T> <T> + Info.MovID

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaRecibo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Personal<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

ListaEnCaptura=(Lista)
Filtros=S
OtroOrden=S
ListaOrden=CFDINominaRecibo.Personal<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGrupo1=CFDINominaRecibo.Timbrado
FiltroValida1=CFDINominaRecibo.Timbrado
FiltroTodo=S
FiltroAutoCampo=CFDINominaRecibo.Timbrado
FiltroAutoValidar=CFDINominaRecibo.Timbrado
MenuLocal=S
ListaAcciones=(Lista)
IconosSeleccionMultiple=S
IconosNombre=CFDINominaRecibo:CFDINominaRecibo.Personal
FiltroGeneral=CFDINominaRecibo.ID = {Info.ID} AND<BR>CFDINominaRecibo.Timbrado IN(<T>Timbrado<T>, <T>Cancelado<T>)
[Lista.Columnas]
0=75

1=117
2=102
3=203
4=1272
5=91
6=106
7=102

8=97
9=52
10=252
11=-2







[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S





[Lista.NombrePersonal]
Carpeta=Lista
Clave=NombrePersonal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco














[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


EspacioPrevio=S
[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación Preliminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S


















[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=&Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.QuitarSeleccion]
Nombre=QuitarSeleccion
Boton=0
NombreDesplegar=Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S










































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
























[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreEnBoton=S
NombreDesplegar=Actualizar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

EspacioPrevio=S












Expresion=Forma.ActualizarArbol(<T>Lista<T>)<BR>ActualizarVista<BR>ActualizarForma



[Acciones.CancelarRecibo]
Nombre=CancelarRecibo
Boton=0
NombreDesplegar=&Cancelar Timbre
EnLote=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
























Expresion=ProcesarSQL(<T>EXEC spCFDINominaCancelar :nID, :tPersonal<T>, CFDINominaRecibo:CFDINominaRecibo.ID, CFDINominaRecibo:CFDINominaRecibo.Personal)
[Lista.CFDINominaRecibo.OkCancela]
Carpeta=Lista
Clave=CFDINominaRecibo.OkCancela
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFDINominaRecibo.OkRefCancela]
Carpeta=Lista
Clave=CFDINominaRecibo.OkRefCancela
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco







[Lista.DescripcionCancelacion]
Carpeta=Lista
Clave=DescripcionCancelacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco















[Lista.ListaEnCaptura]
(Inicio)=NombrePersonal
NombrePersonal=CFDINominaRecibo.OkCancela
CFDINominaRecibo.OkCancela=DescripcionCancelacion
DescripcionCancelacion=CFDINominaRecibo.OkRefCancela
CFDINominaRecibo.OkRefCancela=(Fin)

[Lista.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=QuitarSeleccion
QuitarSeleccion=CancelarRecibo
CancelarRecibo=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Actualizar
Actualizar=MostrarCampos
MostrarCampos=(Fin)
