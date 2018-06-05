
[Forma]
Clave=MovSituacionTMABinaria
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=<T>Situaciones Binarias - <T>+Info.Descripcion
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialAlturaCliente=559
PosicionInicialAncho=960
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=203
PosicionInicialArriba=65
ListaAcciones=(Lista)
PosicionSec1=381
PosicionCol2=509
SinTransacciones=S
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovSituacionTMA
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroArbolClave=MovSituacionTMA.Situacion
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=(Todo)
FiltroAncho=40
FiltroTipo=Arbol
FiltroListasRama=(Todos)
FiltroListasAplicaEn=MovSituacionTMA.Situacion
FiltroArbolRama=MovSituacionTMA.Rama
FiltroTodo=S
IconosCampo=NumeroIcono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Situación<T>

ListaEnCaptura=(Lista)
FiltroArbolValidar=MovSituacionTMA.Situacion
AnchoTotalizador1=1
TieneTotalizador2=S
FiltroRespetar=S
FiltroArbolAcumulativas=MovSituacionTMA.EsAcumulativa
FiltroEnOrden=S
IconosNombre=MovSituacionTMA:MovSituacionTMA.Situacion
FiltroGeneral=MovSituacionTMA.Modulo=<T>{Info.Modulo}<T> AND<BR>MovSituacionTMA.Mov=<T>{Info.Mov}<T> AND<BR>MovSituacionTMA.Estatus=<T>{Info.Estatus}<T>
[Lista.Columnas]
Situacion=146

0=146
1=294
2=117
3=124
Expresion1=118
Operador=130
Expresion2=158
Expresion3=177
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

GuardarAntes=S
NombreEnBoton=S
[Acciones.Nueva]
Nombre=Nueva
Boton=1
NombreDesplegar=&Nueva Situación
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S












NombreEnBoton=S
Antes=S
GuardarAntes=S
ActivoCondicion=ConDatos(MovSituacionTMA:MovSituacionTMA.Situacion)
AntesExpresiones=Asigna(Info.Situacion, MovSituacionTMA:MovSituacionTMA.Situacion)<BR><BR>Si SQL(<T>SELECT COUNT(*) FROM MovSituacion WHERE Modulo = :tModulo AND Mov = :tMov AND Estatus = :tEstatus AND Rama = :tSituacion<T>, MovSituacionTMA:MovSituacionTMA.Modulo, MovSituacionTMA:MovSituacionTMA.Mov, MovSituacionTMA:MovSituacionTMA.Estatus, MovSituacionTMA:MovSituacionTMA.Situacion) >= 2<BR>Entonces<BR>  Precaucion(<T>La Situación <T> + MovSituacionTMA:MovSituacionTMA.Situacion + <T> ya cuenta con 2 Situaciones Hijas<BR>  <BR>No se puede agregar una tercera<T>)<BR>  AbortarOperacion<BR>Sino<BR>  Forma.Accion(<T>InsertarSituacion<T>)<BR>Fin
DespuesGuardar=S
[Detalle]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Detalle
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=MovSituacionTMA
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S





FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=(Lista)



Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=MovSituacionTMA.Modulo=<T>{Info.Modulo}<T> AND<BR>MovSituacionTMA.Mov=<T>{Info.Mov}<T> AND<BR>MovSituacionTMA.Estatus=<T>{Info.Estatus}<T>
[Detalle.MovSituacionTMA.Situacion]
Carpeta=Detalle
Clave=MovSituacionTMA.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.MovSituacionTMA.PermiteAfectacion]
Carpeta=Detalle
Clave=MovSituacionTMA.PermiteAfectacion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=15
[Detalle.MovSituacionTMA.PermiteRetroceder]
Carpeta=Detalle
Clave=MovSituacionTMA.PermiteRetroceder
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=15

[Detalle.MovSituacionTMA.ControlUsuarios]
Carpeta=Detalle
Clave=MovSituacionTMA.ControlUsuarios
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=15

[Detalle.MovSituacionTMA.Condicional]
Carpeta=Detalle
Clave=MovSituacionTMA.Condicional
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=15

[Detalle.MovSituacionTMA.SituacionVerdadero]
Carpeta=Detalle
Clave=MovSituacionTMA.SituacionVerdadero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.MovSituacionTMA.Operador]
Carpeta=Detalle
Clave=MovSituacionTMA.Operador
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

































[Icono]
Estilo=Ficha
Clave=Icono
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=MovSituacionTMA
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MovSituacionTMA.Icono
CarpetaVisible=S

FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
[Icono.MovSituacionTMA.Icono]
Carpeta=Icono
Clave=MovSituacionTMA.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Icono.Columnas]
Icono=64










































[CondicionUsuario.MovSituacionTMA.CondicionUsuario]
Carpeta=CondicionUsuario
Clave=MovSituacionTMA.CondicionUsuario
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=100x30
ColorFondo=Blanco



ConScroll=S
SinRecapitular=S






















[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar Situación
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S



ConfirmarAntes=S








ActivoCondicion=MovSituacionTMA:MovSituacionTMA.EsPadre = 0 y(SQL(<T>SELECT COUNT(*) FROM MovSituacionTMA WHERE Modulo = :tModulo AND Mov = :tMov AND Estatus = :tEstatus AND Rama = :tSituacion<T>, MovSituacionTMA:MovSituacionTMA.Modulo, MovSituacionTMA:MovSituacionTMA.Mov, MovSituacionTMA:MovSituacionTMA.Estatus, MovSituacionTMA:MovSituacionTMA.Situacion) = 0)
[Acciones.Usuarios]
Nombre=Usuarios
Boton=80
NombreEnBoton=S
NombreDesplegar=&Usuarios con Acceso
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovSituacionUsuario
Visible=S





GuardarAntes=S
ConCondicion=S
Antes=S
DespuesGuardar=S



























ActivoCondicion=MovSituacionTMA:MovSituacionTMA.ControlUsuarios
EjecucionCondicion=ConDatos(MovSituacionTMA:MovSituacionTMA.Mov) y ConDatos(MovSituacionTMA:MovSituacionTMA.Estatus) y ConDatos(MovSituacionTMA:MovSituacionTMA.Situacion)
AntesExpresiones=Asigna(Info.ID, MovSituacionTMA:MovSituacionTMA.ID)<BR>Asigna(Info.Situacion, MovSituacionTMA:MovSituacionTMA.Situacion)
[Acciones.Condiciones]
Nombre=Condiciones
Boton=107
NombreEnBoton=S
NombreDesplegar=&Condiciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S















GuardarAntes=S
Antes=S
DespuesGuardar=S







































Expresion=Forma(<T>MovSituacionBinariaCondicion<T>)<BR>ActualizarVista
ActivoCondicion=MovSituacionTMA:MovSituacionTMA.Condicional
AntesExpresiones=Asigna(Info.ID, MovSituacionTMA:MovSituacionTMA.ID)<BR>Asigna(Info.Situacion, MovSituacionTMA:MovSituacionTMA.Situacion)
[Acciones.Ayuda]
Nombre=Ayuda
Boton=101
NombreEnBoton=S
NombreDesplegar=&Ayuda Etiquetas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovSituacionBinariaTagAyuda
Activo=S
Visible=S













[Acciones.CondicionUsuario]
Nombre=CondicionUsuario
Boton=94
NombreEnBoton=S
NombreDesplegar=&Condición Usuario
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovSituacionBinariaCondUsuario
Visible=S



Antes=S
GuardarAntes=S
DespuesGuardar=S
ActivoCondicion=MovSituacionTMA:MovSituacionTMA.Condicional
AntesExpresiones=Asigna(Info.ID, MovSituacionTMA:MovSituacionTMA.ID)<BR>Asigna(Info.Situacion, MovSituacionTMA:MovSituacionTMA.Situacion)










[Lista.MovSituacionTMA.SituacionVerdadero]
Carpeta=Lista
Clave=MovSituacionTMA.SituacionVerdadero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco












[Lista.CondicionesTexto]
Carpeta=Lista
Clave=CondicionesTexto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8000
ColorFondo=Blanco








[Lista.SituacionFalso]
Carpeta=Lista
Clave=SituacionFalso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco









[Acciones.ActualizarArbol]
Nombre=ActualizarArbol
Boton=82
NombreEnBoton=S
NombreDesplegar=Act&ualizar Árbol
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S



EspacioPrevio=S


























Expresion=Forma.ActualizarArbol(<T>Lista<T>)<BR>ActualizarVista







[Detalle.ListaEnCaptura]
(Inicio)=MovSituacionTMA.Situacion
MovSituacionTMA.Situacion=MovSituacionTMA.PermiteAfectacion
MovSituacionTMA.PermiteAfectacion=MovSituacionTMA.PermiteRetroceder
MovSituacionTMA.PermiteRetroceder=MovSituacionTMA.ControlUsuarios
MovSituacionTMA.ControlUsuarios=MovSituacionTMA.Condicional
MovSituacionTMA.Condicional=MovSituacionTMA.Operador
MovSituacionTMA.Operador=MovSituacionTMA.SituacionVerdadero
MovSituacionTMA.SituacionVerdadero=(Fin)

































[Lista.ListaEnCaptura]
(Inicio)=CondicionesTexto
CondicionesTexto=MovSituacionTMA.SituacionVerdadero
MovSituacionTMA.SituacionVerdadero=SituacionFalso
SituacionFalso=(Fin)







































[Acciones.InsertarSituacion]
Nombre=InsertarSituacion
Boton=0
NombreDesplegar=Insertar
EnBarraHerramientas=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=Icono
Icono=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=ActualizarArbol
ActualizarArbol=Nueva
Nueva=Eliminar
Eliminar=Usuarios
Usuarios=Condiciones
Condiciones=CondicionUsuario
CondicionUsuario=Ayuda
Ayuda=InsertarSituacion
InsertarSituacion=(Fin)
