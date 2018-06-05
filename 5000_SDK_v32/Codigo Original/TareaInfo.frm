[Forma]
Clave=TareaInfo
Nombre=Información de la Tarea
Icono=62
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=581
PosicionInicialArriba=307
PosicionInicialAlturaCliente=550
PosicionInicialAncho=767
PosicionSeccion1=30
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=TareaComentarios:Tarea.Tarea
PosicionSec1=148

[Ficha]
Estilo=Ficha
PestanaNombre=Datos Generales
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TareaComentarios
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Tarea.Tarea=<T>{Info.Tarea}<T>

[Comentarios.Tarea.Comentarios]
Carpeta=Comentarios
Clave=Tarea.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Tarea.Asunto]
Carpeta=Ficha
Clave=Tarea.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios]
Estilo=Ficha
Clave=Comentarios
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=TareaComentarios
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Tarea.Comentarios
CarpetaVisible=S
AlinearTodaCarpeta=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comentarios

[Ficha.Tarea.Vencimiento]
Carpeta=Ficha
Clave=Tarea.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=30

[Ficha.Tarea.Estado]
Carpeta=Ficha
Clave=Tarea.Estado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Tarea.Prioridad]
Carpeta=Ficha
Clave=Tarea.Prioridad
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Tarea.FechaInicio]
Carpeta=Ficha
Clave=Tarea.FechaInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Eliminar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Eliminar.Guardar]
Nombre=Guardar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Eliminar.Eliminar]
Nombre=Eliminar
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Ficha.Tarea.Forzosa]
Carpeta=Ficha
Clave=Tarea.Forzosa
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Tarea.Completada]
Carpeta=Ficha
Clave=Tarea.Completada
Editar=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Bitacora]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Bitácora
Clave=Bitacora
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=TareaBitacora
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Fecha/Hora<T>
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=FechaEnTexto(TareaBitacora:TareaBitacora.Fecha, <T>dd/mmm/aaaa hh:nn am/pm<T>)
FiltroGeneral=TareaBitacora.ID={Info.TareaID}

[Ficha.Tarea.FechaInicioEst]
Carpeta=Ficha
Clave=Tarea.FechaInicioEst
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Tarea.FechaConclusionEst]
Carpeta=Ficha
Clave=Tarea.FechaConclusionEst
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Tarea.Revision]
Carpeta=Ficha
Clave=Tarea.Revision
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Tarea.FechaConclusion]
Carpeta=Ficha
Clave=Tarea.FechaConclusion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Bitacora.TareaBitacora.Evento]
Carpeta=Bitacora
Clave=TareaBitacora.Evento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Bitacora.TareaBitacora.Usuario]
Carpeta=Bitacora
Clave=TareaBitacora.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Bitacora.Columnas]
0=136
1=437

[Ficha.Tarea.Tipo]
Carpeta=Ficha
Clave=Tarea.Tipo
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[Ficha.Tarea.UsuarioResponsable]
Carpeta=Ficha
Clave=Tarea.UsuarioResponsable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Tarea.UsuarioAsignado]
Carpeta=Ficha
Clave=Tarea.UsuarioAsignado
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Bitacora
Bitacora=Comentarios
Comentarios=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Tarea.Asunto
Tarea.Asunto=Tarea.Tipo
Tarea.Tipo=Tarea.Prioridad
Tarea.Prioridad=Tarea.Vencimiento
Tarea.Vencimiento=Tarea.Estado
Tarea.Estado=Tarea.Completada
Tarea.Completada=Tarea.FechaInicioEst
Tarea.FechaInicioEst=Tarea.FechaConclusionEst
Tarea.FechaConclusionEst=Tarea.Revision
Tarea.Revision=Tarea.FechaInicio
Tarea.FechaInicio=Tarea.FechaConclusion
Tarea.FechaConclusion=Tarea.Forzosa
Tarea.Forzosa=Tarea.UsuarioResponsable
Tarea.UsuarioResponsable=Tarea.UsuarioAsignado
Tarea.UsuarioAsignado=(Fin)

[Bitacora.ListaEnCaptura]
(Inicio)=TareaBitacora.Evento
TareaBitacora.Evento=TareaBitacora.Usuario
TareaBitacora.Usuario=(Fin)
