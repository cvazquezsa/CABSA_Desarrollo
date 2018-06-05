
[Forma]
Clave=MovSituacionBinariaSiguiente
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
PosicionInicialIzquierda=543
PosicionInicialArriba=228
PosicionInicialAlturaCliente=233
PosicionInicialAncho=279
ListaCarpetas=Lista
CarpetaPrincipal=Lista
Nombre=<T>Situacion - <T>+Info.Mov+<T> <T>+Info.MovID
VentanaSinIconosMarco=S
VentanaExclusiva=S
VentanaExclusivaOpcion=2
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spMovSituacionBinariaSiguiente :nEstacion, :tModulo, :nID, :tMov, :tEstatus, :tSituacion, @SituacionUsuario = :tUsuario<T>, EstacionTrabajo, Info.Modulo, Info.ID, Info.Mov, Info.Estatus, Info.Situacion, Usuario)
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
Activo=S
Visible=S

Multiple=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)
GuardarAntes=S
[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar/Cancelar Cambios]
Nombre=Cancelar/Cancelar Cambios
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S




[Lista]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovSituacionBinariaSiguiente
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=MovSituacionBinariaSiguiente.Estacion = {EstacionTrabajo}
[Lista.MovSituacionBinariaSiguiente.Situacion]
Carpeta=Lista
Clave=MovSituacionBinariaSiguiente.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

[Lista.MovSituacionBinariaSiguiente.SituacionFecha]
Carpeta=Lista
Clave=MovSituacionBinariaSiguiente.SituacionFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=35
[Lista.MovSituacionBinariaSiguiente.SituacionUsuario]
Carpeta=Lista
Clave=MovSituacionBinariaSiguiente.SituacionUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

[Lista.MovSituacionBinariaSiguiente.SituacionNota]
Carpeta=Lista
Clave=MovSituacionBinariaSiguiente.SituacionNota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35x3
ColorFondo=Blanco


[Lista.Columnas]
Situacion=304
SituacionFecha=94
SituacionUsuario=83
SituacionNota=604
















[Acciones.Retroceder]
Nombre=Retroceder
Boton=72
NombreEnBoton=S
NombreDesplegar=Retroceder
EnBarraHerramientas=S
EspacioPrevio=S
Visible=S
























































TipoAccion=Expresion

Expresion=Asigna(MovSituacionBinariaSiguiente:MovSituacionBinariaSiguiente.Situacion, SQL(<T>EXEC spMovSituacionBinariaSiguiente :nEstacion, :tModulo, :nID, :tMov, :tEstatus, :tSituacion, @EnSilencio = 0, @Retroceder = 1<T>, EstacionTrabajo, Info.Modulo, Info.ID, Info.Mov, Info.Estatus, Info.Situacion))
ActivoCondicion=SQL(<T>SELECT dbo.fnMovSituacionBinariaPermiteRetroceder(:tModulo, :tMov, :tEstatus, :tSituacion)<T>, Info.Modulo, Info.Mov, Info.Estatus, Info.Situacion)
[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si MovSituacionBinariaSiguiente:MovSituacionBinariaSiguiente.Situacion <> Info.Situacion<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spCambiarSituacion :tModulo, :nID, :tSituacion, :tSituacionFecha, :tUsuario, :tSituacionUsuario, :tSituacionNota, :tHora<T>, Info.Modulo, Info.ID, MovSituacionBinariaSiguiente:MovSituacionBinariaSiguiente.Situacion, FechaFormatoServidor(MovSituacionBinariaSiguiente:MovSituacionBinariaSiguiente.SituacionFecha), Usuario, MovSituacionBinariaSiguiente:MovSituacionBinariaSiguiente.SituacionUsuario, MovSituacionBinariaSiguiente:MovSituacionBinariaSiguiente.SituacionNota, ExtraeHora(MovSituacionBinariaSiguiente:MovSituacionBinariaSiguiente.SituacionFecha))<BR>Fin
[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S








[Lista.ListaEnCaptura]
(Inicio)=MovSituacionBinariaSiguiente.Situacion
MovSituacionBinariaSiguiente.Situacion=MovSituacionBinariaSiguiente.SituacionFecha
MovSituacionBinariaSiguiente.SituacionFecha=MovSituacionBinariaSiguiente.SituacionUsuario
MovSituacionBinariaSiguiente.SituacionUsuario=MovSituacionBinariaSiguiente.SituacionNota
MovSituacionBinariaSiguiente.SituacionNota=(Fin)


























[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Retroceder
Retroceder=(Fin)
