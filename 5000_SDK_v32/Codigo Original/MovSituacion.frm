[Forma]
Clave=MovSituacion
Nombre=<T>Situaciones - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=239
PosicionInicialArriba=208
PosicionInicialAltura=301
PosicionInicialAncho=887
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=50
PosicionColumna1=91
PosicionInicialAlturaCliente=274
PosicionCol1=761

SinTransacciones=S
[Lista.MovSituacion.Mov]
Carpeta=Lista
Clave=MovSituacion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovSituacion.Estatus]
Carpeta=Lista
Clave=MovSituacion.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovSituacion.Situacion]
Carpeta=Lista
Clave=MovSituacion.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Lista.Columnas]
Modulo=69
Mov=138
Estatus=132
Situacion=161
Descripcion=185
ConCostos=42
Cuesta=41
Orden=38
Flujo=91
PermiteAfectacion=79
Tipo=114
PermiteRetroceder=59
PermiteBrincar=40
ControlUsuarios=83
Tiempo=40
AvanzarSMS=67
SMS=63

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Flujo]
Nombre=Flujo
Boton=47
NombreEnBoton=S
NombreDesplegar=&Flujo Especial
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovSituacionD
Visible=S
EspacioPrevio=S
ConCondicion=S
Antes=S
GuardarAntes=S
DespuesGuardar=S

ActivoCondicion=MovSituacion:MovSituacion.Flujo en (<T>Especial<T>, <T>Inicial Especial<T>)
EjecucionCondicion=ConDatos(MovSituacion:MovSituacion.Mov) y ConDatos(MovSituacion:MovSituacion.Estatus) y ConDatos(MovSituacion:MovSituacion.Situacion)
AntesExpresiones=Asigna(Info.ID, MovSituacion:MovSituacion.ID)<BR>Asigna(Info.Situacion, MovSituacion:MovSituacion.Situacion)
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar situación
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
ConfirmarAntes=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nueva situación
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Lista]
Estilo=Hoja
PestanaNombre=Detalles
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovSituacion
Fuente={MS Sans Serif, 8, Negro, []}
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
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=(Lista)
HojaSinBorde=S

FiltroGeneral=MovSituacion.Modulo=<T>{Info.Modulo}<T> AND<BR>MovSituacion.Mov=<T>{Info.Mov}<T> AND<BR>MovSituacion.Estatus=<T>{Info.Estatus}<T>
[Lista.MovSituacion.Tipo]
Carpeta=Lista
Clave=MovSituacion.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Lista.MovSituacion.Orden]
Carpeta=Lista
Clave=MovSituacion.Orden
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MovSituacion
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MovSituacion.Icono
CarpetaVisible=S

[Ficha.MovSituacion.Icono]
Carpeta=Ficha
Clave=MovSituacion.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovSituacion.Flujo]
Carpeta=Lista
Clave=MovSituacion.Flujo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MovSituacion.PermiteAfectacion]
Carpeta=Lista
Clave=MovSituacion.PermiteAfectacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MovSituacion.PermiteRetroceder]
Carpeta=Lista
Clave=MovSituacion.PermiteRetroceder
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MovSituacion.PermiteBrincar]
Carpeta=Lista
Clave=MovSituacion.PermiteBrincar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MovSituacion.ControlUsuarios]
Carpeta=Lista
Clave=MovSituacion.ControlUsuarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Usuarios]
Nombre=Usuarios
Boton=80
NombreEnBoton=S
NombreDesplegar=&Usuarios con Acceso
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovSituacionUsuario
ConCondicion=S
Visible=S
GuardarAntes=S
ActivoCondicion=MovSituacion:MovSituacion.ControlUsuarios
EjecucionCondicion=ConDatos(MovSituacion:MovSituacion.Mov) y ConDatos(MovSituacion:MovSituacion.Estatus) y ConDatos(MovSituacion:MovSituacion.Situacion)
Antes=S
AntesExpresiones=Asigna(Info.ID, MovSituacion:MovSituacion.ID)<BR>Asigna(Info.Situacion, MovSituacion:MovSituacion.Situacion)
DespuesGuardar=S

[Lista.MovSituacion.Tiempo]
Carpeta=Lista
Clave=MovSituacion.Tiempo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MovSituacion.SMS]
Carpeta=Lista
Clave=MovSituacion.SMS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=MovSituacion.Tipo
MovSituacion.Tipo=MovSituacion.Situacion
MovSituacion.Situacion=MovSituacion.Orden
MovSituacion.Orden=MovSituacion.Flujo
MovSituacion.Flujo=MovSituacion.PermiteAfectacion
MovSituacion.PermiteAfectacion=MovSituacion.PermiteRetroceder
MovSituacion.PermiteRetroceder=MovSituacion.PermiteBrincar
MovSituacion.PermiteBrincar=MovSituacion.SMS
MovSituacion.SMS=MovSituacion.ControlUsuarios
MovSituacion.ControlUsuarios=MovSituacion.Tiempo
MovSituacion.Tiempo=(Fin)

[Lista.ListaOrden]
(Inicio)=MovSituacion.Tipo	(Acendente)
MovSituacion.Tipo	(Acendente)=MovSituacion.Orden	(Acendente)
MovSituacion.Orden	(Acendente)=(Fin)



















































































[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Eliminar
Eliminar=Flujo
Flujo=Usuarios
Usuarios=Navegador
Navegador=(Fin)
