
[Forma]
Clave=CFDINominaRecibo
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
PosicionInicialIzquierda=230
PosicionInicialArriba=100
PosicionInicialAlturaCliente=529
PosicionInicialAncho=899
Comentarios=Info.Mov + <T> <T> + Info.MovID

VentanaExclusiva=S
VentanaExclusivaOpcion=2
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
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=CFDINominaRecibo:CFDINominaRecibo.Personal
FiltroGeneral=CFDINominaRecibo.ID = {Info.ID} AND<BR>CFDINominaRecibo.Timbrado IN(<T>No Timbrado<T>, <T>Timbrado<T>)
[Lista.Columnas]
0=59

1=185
2=108
3=111
4=108
5=102
6=106
7=102

8=97
9=97
10=105
11=-2
[Lista.CFDINominaRecibo.TotalPercepciones]
Carpeta=Lista
Clave=CFDINominaRecibo.TotalPercepciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.CFDINominaRecibo.PercepcionesTotalGravado]
Carpeta=Lista
Clave=CFDINominaRecibo.PercepcionesTotalGravado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=0
[Lista.CFDINominaRecibo.PercepcionesTotalExcento]
Carpeta=Lista
Clave=CFDINominaRecibo.PercepcionesTotalExcento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=0
[Lista.CFDINominaRecibo.TotalDeducciones]
Carpeta=Lista
Clave=CFDINominaRecibo.TotalDeducciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.CFDINominaRecibo.DeduccionesTotalGravado]
Carpeta=Lista
Clave=CFDINominaRecibo.DeduccionesTotalGravado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=0
[Lista.CFDINominaRecibo.DeduccionesTotalExcento]
Carpeta=Lista
Clave=CFDINominaRecibo.DeduccionesTotalExcento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=0
[Lista.CFDINominaRecibo.TotalDescuento]
Carpeta=Lista
Clave=CFDINominaRecibo.TotalDescuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Totalizador=0
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









[Acciones.PercepcionDeduccion]
Nombre=PercepcionDeduccion
Boton=99
NombreEnBoton=S
NombreDesplegar=Percepciones / Deducciones
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CFDINominaPercepcionDeduccion
Activo=S
Visible=S



EspacioPrevio=S




Antes=S
















AntesExpresiones=Asigna(Info.Personal, CFDINominaRecibo:CFDINominaRecibo.Personal)
[Acciones.HorasExtra]
Nombre=HorasExtra
Boton=15
NombreEnBoton=S
NombreDesplegar=&Horas Extra
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDINominaHoraExtra
Activo=S
Visible=S




Antes=S
AntesExpresiones=Asigna(Info.Personal, CFDINominaRecibo:CFDINominaRecibo.Personal)
[Acciones.Incapacidades]
Nombre=Incapacidades
Boton=53
NombreEnBoton=S
NombreDesplegar=&Incapacidades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CFDINominaIncapacidad
Activo=S
Visible=S


























Antes=S
AntesExpresiones=Asigna(Info.Personal, CFDINominaRecibo:CFDINominaRecibo.Personal)
[Lista.CFDINominaRecibo.OkRef]
Carpeta=Lista
Clave=CFDINominaRecibo.OkRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


























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



































[Lista.MensajeLista.Descripcion]
Carpeta=Lista
Clave=MensajeLista.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco










[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
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
NombreDesplegar=&Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S




[Acciones.SugerirRecibo]
Nombre=SugerirRecibo
Boton=0
NombreDesplegar=Sugerir Recibo
EnLote=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=ProcesarSQL(<T>EXEC spCFDINominaGenerar :nEstacionTrabajo, 0, :tUsuario, @IDEsp = :nID, @PersonalEsp = :tPersonal<T>, EstacionTrabajo, Usuario, CFDINominaRecibo:CFDINominaRecibo.ID, CFDINominaRecibo:CFDINominaRecibo.Personal)
[Acciones.TimbrarCFDI]
Nombre=TimbrarCFDI
Boton=0
NombreDesplegar=Generar CFDI
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

ConfirmarAntes=S
EnLote=S





Expresion=ProcesarSQL(<T>EXEC spCFDINominaGenerar :nEstacionTrabajo, 1, :tUsuario, @IDEsp = :nID, @PersonalEsp = :tPersonal<T>, EstacionTrabajo, Usuario, CFDINominaRecibo:CFDINominaRecibo.ID, CFDINominaRecibo:CFDINominaRecibo.Personal)
[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=&Actualizar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S













EspacioPrevio=S












Expresion=Forma.ActualizarArbol(<T>Lista<T>)<BR>ActualizarVista<BR>ActualizarForma





































[Lista.ListaEnCaptura]
(Inicio)=NombrePersonal
NombrePersonal=CFDINominaRecibo.TotalPercepciones
CFDINominaRecibo.TotalPercepciones=CFDINominaRecibo.PercepcionesTotalGravado
CFDINominaRecibo.PercepcionesTotalGravado=CFDINominaRecibo.PercepcionesTotalExcento
CFDINominaRecibo.PercepcionesTotalExcento=CFDINominaRecibo.TotalDeducciones
CFDINominaRecibo.TotalDeducciones=CFDINominaRecibo.DeduccionesTotalGravado
CFDINominaRecibo.DeduccionesTotalGravado=CFDINominaRecibo.DeduccionesTotalExcento
CFDINominaRecibo.DeduccionesTotalExcento=CFDINominaRecibo.TotalDescuento
CFDINominaRecibo.TotalDescuento=MensajeLista.Descripcion
MensajeLista.Descripcion=CFDINominaRecibo.OkRef
CFDINominaRecibo.OkRef=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionarTodo
SeleccionarTodo=QuitarSeleccion
QuitarSeleccion=SugerirRecibo
SugerirRecibo=TimbrarCFDI
TimbrarCFDI=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=PercepcionDeduccion
PercepcionDeduccion=HorasExtra
HorasExtra=Incapacidades
Incapacidades=Actualizar
Actualizar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=MostrarCampos
MostrarCampos=(Fin)
