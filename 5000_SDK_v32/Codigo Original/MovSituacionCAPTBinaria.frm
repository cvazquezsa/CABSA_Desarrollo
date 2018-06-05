
[Forma]
Clave=MovSituacionCAPTBinaria
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
Vista=MovSituacionCAPT
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroArbolClave=MovSituacionCAPT.Situacion
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=(Todo)
FiltroAncho=40
FiltroTipo=Arbol
FiltroListasRama=(Todos)
FiltroListasAplicaEn=MovSituacionCAPT.Situacion
FiltroArbolRama=MovSituacionCAPT.Rama
FiltroTodo=S
IconosCampo=NumeroIcono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Situación<T>

ListaEnCaptura=(Lista)
FiltroArbolValidar=MovSituacionCAPT.Situacion
AnchoTotalizador1=1
TieneTotalizador2=S
FiltroRespetar=S
FiltroArbolAcumulativas=MovSituacionCAPT.EsAcumulativa
FiltroEnOrden=S
IconosNombre=MovSituacionCAPT:MovSituacionCAPT.Situacion
FiltroGeneral=MovSituacionCAPT.Modulo=<T>{Info.Modulo}<T> AND<BR>MovSituacionCAPT.Mov=<T>{Info.Mov}<T> AND<BR>MovSituacionCAPT.Estatus=<T>{Info.Estatus}<T>
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
ActivoCondicion=ConDatos(MovSituacionCAPT:MovSituacionCAPT.Situacion)
AntesExpresiones=Asigna(Info.Situacion, MovSituacionCAPT:MovSituacionCAPT.Situacion)<BR><BR>Si SQL(<T>SELECT COUNT(*) FROM MovSituacion WHERE Modulo = :tModulo AND Mov = :tMov AND Estatus = :tEstatus AND Rama = :tSituacion<T>, MovSituacionCAPT:MovSituacionCAPT.Modulo, MovSituacionCAPT:MovSituacionCAPT.Mov, MovSituacionCAPT:MovSituacionCAPT.Estatus, MovSituacionCAPT:MovSituacionCAPT.Situacion) >= 2<BR>Entonces<BR>  Precaucion(<T>La Situación <T> + MovSituacionCAPT:MovSituacionCAPT.Situacion + <T> ya cuenta con 2 Situaciones Hijas<BR>  <BR>No se puede agregar una tercera<T>)<BR>  AbortarOperacion<BR>Sino<BR>  Forma.Accion(<T>InsertarSituacion<T>)<BR>Fin
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
Vista=MovSituacionCAPT
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
FiltroGeneral=MovSituacionCAPT.Modulo=<T>{Info.Modulo}<T> AND<BR>MovSituacionCAPT.Mov=<T>{Info.Mov}<T> AND<BR>MovSituacionCAPT.Estatus=<T>{Info.Estatus}<T>
[Detalle.MovSituacionCAPT.Situacion]
Carpeta=Detalle
Clave=MovSituacionCAPT.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.MovSituacionCAPT.PermiteAfectacion]
Carpeta=Detalle
Clave=MovSituacionCAPT.PermiteAfectacion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=15
[Detalle.MovSituacionCAPT.PermiteRetroceder]
Carpeta=Detalle
Clave=MovSituacionCAPT.PermiteRetroceder
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=15

[Detalle.MovSituacionCAPT.ControlUsuarios]
Carpeta=Detalle
Clave=MovSituacionCAPT.ControlUsuarios
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=15

[Detalle.MovSituacionCAPT.Condicional]
Carpeta=Detalle
Clave=MovSituacionCAPT.Condicional
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=15

[Detalle.MovSituacionCAPT.SituacionVerdadero]
Carpeta=Detalle
Clave=MovSituacionCAPT.SituacionVerdadero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.MovSituacionCAPT.Operador]
Carpeta=Detalle
Clave=MovSituacionCAPT.Operador
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
Vista=MovSituacionCAPT
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MovSituacionCAPT.Icono
CarpetaVisible=S

FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
[Icono.MovSituacionCAPT.Icono]
Carpeta=Icono
Clave=MovSituacionCAPT.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Icono.Columnas]
Icono=64










































[CondicionUsuario.MovSituacionCAPT.CondicionUsuario]
Carpeta=CondicionUsuario
Clave=MovSituacionCAPT.CondicionUsuario
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








ActivoCondicion=MovSituacionCAPT:MovSituacionCAPT.EsPadre = 0 y(SQL(<T>SELECT COUNT(*) FROM MovSituacionCAPT WHERE Modulo = :tModulo AND Mov = :tMov AND Estatus = :tEstatus AND Rama = :tSituacion<T>, MovSituacionCAPT:MovSituacionCAPT.Modulo, MovSituacionCAPT:MovSituacionCAPT.Mov, MovSituacionCAPT:MovSituacionCAPT.Estatus, MovSituacionCAPT:MovSituacionCAPT.Situacion) = 0)
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



























ActivoCondicion=MovSituacionCAPT:MovSituacionCAPT.ControlUsuarios
EjecucionCondicion=ConDatos(MovSituacionCAPT:MovSituacionCAPT.Mov) y ConDatos(MovSituacionCAPT:MovSituacionCAPT.Estatus) y ConDatos(MovSituacionCAPT:MovSituacionCAPT.Situacion)
AntesExpresiones=Asigna(Info.ID, MovSituacionCAPT:MovSituacionCAPT.ID)<BR>Asigna(Info.Situacion, MovSituacionCAPT:MovSituacionCAPT.Situacion)
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
ActivoCondicion=MovSituacionCAPT:MovSituacionCAPT.Condicional
AntesExpresiones=Asigna(Info.ID, MovSituacionCAPT:MovSituacionCAPT.ID)<BR>Asigna(Info.Situacion, MovSituacionCAPT:MovSituacionCAPT.Situacion)
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
ActivoCondicion=MovSituacionCAPT:MovSituacionCAPT.Condicional
AntesExpresiones=Asigna(Info.ID, MovSituacionCAPT:MovSituacionCAPT.ID)<BR>Asigna(Info.Situacion, MovSituacionCAPT:MovSituacionCAPT.Situacion)










[Lista.MovSituacionCAPT.SituacionVerdadero]
Carpeta=Lista
Clave=MovSituacionCAPT.SituacionVerdadero
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
(Inicio)=MovSituacionCAPT.Situacion
MovSituacionCAPT.Situacion=MovSituacionCAPT.PermiteAfectacion
MovSituacionCAPT.PermiteAfectacion=MovSituacionCAPT.PermiteRetroceder
MovSituacionCAPT.PermiteRetroceder=MovSituacionCAPT.ControlUsuarios
MovSituacionCAPT.ControlUsuarios=MovSituacionCAPT.Condicional
MovSituacionCAPT.Condicional=MovSituacionCAPT.Operador
MovSituacionCAPT.Operador=MovSituacionCAPT.SituacionVerdadero
MovSituacionCAPT.SituacionVerdadero=(Fin)

































[Lista.ListaEnCaptura]
(Inicio)=CondicionesTexto
CondicionesTexto=MovSituacionCAPT.SituacionVerdadero
MovSituacionCAPT.SituacionVerdadero=SituacionFalso
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
