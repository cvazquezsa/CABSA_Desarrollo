[Forma]
Clave=CampanaD
Nombre=Detalle Campaña
Icono=1
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=118
PosicionInicialArriba=0
PosicionInicialAlturaCliente=700
PosicionInicialAncho=1129
PosicionCol1=505
PosicionSec1=405
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID, Info.Tipo)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S

AutoGuardar=S
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
PermiteEditar=S
HojaIndicador=S
BusquedaRapidaControles=S
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=CampanaD.SituacionFecha
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroAplicaEn=CampanaD.Situacion
FiltroAutoCampo=CampanaD.Situacion
FiltroAutoValidar=CampanaD.Situacion
FiltroTodo=S
FiltroEstilo=Folder (1 línea)
OtroOrden=S
ListaOrden=ContactoNombre<TAB>(Acendente)
MenuLocal=S
ListaAcciones=ListaContacto

BusquedaRapida=S
BusquedaRespetarFiltros=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGeneral=CampanaD.ID={Info.ID}
[Lista.ContactoNombre]
Carpeta=Lista
Clave=ContactoNombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.ContactoSubTipo]
Carpeta=Lista
Clave=ContactoSubTipo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CampanaD.Situacion]
Carpeta=Lista
Clave=CampanaD.Situacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.CampanaD.SituacionFecha]
Carpeta=Lista
Clave=CampanaD.SituacionFecha
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CampanaD.Calificacion]
Carpeta=Lista
Clave=CampanaD.Calificacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
ContactoNombre=295
ContactoSubTipo=108
Situacion=135
SituacionFecha=95
Calificacion=62

[Tareas]
Estilo=Hoja
Clave=Tareas
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CampanaTarea
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CampanaD
LlaveLocal=(Lista)
LlaveMaestra=(Lista)
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Tareas
ListaEnCaptura=(Lista)
CondicionEdicion=Info.Estatus<>EstatusCancelado
OtroOrden=S
ListaOrden=CampanaTarea.FechaHora<TAB>(Acendente)
Pestana=S

[Tareas.CampanaTarea.Asunto]
Carpeta=Tareas
Clave=CampanaTarea.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco

[Tareas.Columnas]
Asunto=453
Inicio=86
Vencimiento=96
Estado=129
Avance=55
FechaConclusion=89
Orden=38

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Contactos]
Nombre=Contactos
Boton=60
NombreDesplegar=C&ontactos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
ConCondicion=S
Antes=S
Visible=S
Expresion=Caso  CampanaD:CampanaD.ContactoTipo<BR>  Es <T>Cliente<T> Entonces Forma(<T>CteCto<T>)<BR>  Es <T>Prospecto<T> Entonces Forma(<T>ProspectoCto<T>)<BR>Sino<BR>  Falso<BR>Fin
ActivoCondicion=(CampanaD:CampanaD.ContactoTipo en (<T>Prospecto<T>, <T>Cliente<T>)) y (Info.Estatus<>EstatusCancelado)
EjecucionCondicion=ConDatos(CampanaD:CampanaD.Contacto)
AntesExpresiones=Caso  CampanaD:CampanaD.ContactoTipo<BR>  Es <T>Cliente<T> Entonces Asigna(Info.Cliente, CteCampana:Cte.Cliente) Asigna(Info.Nombre, CteCampana:Cte.Nombre)<BR>  Es <T>Prospecto<T> Entonces Asigna(Info.Prospecto, Prospecto:Prospecto.Prospecto) Asigna(Info.Nombre, Prospecto:Prospecto.Nombre)<BR>Sino<BR>  Falso<BR>Fin

[Acciones.Encuesta]
Nombre=Encuesta
Boton=103
NombreEnBoton=S
NombreDesplegar=&Encuesta
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CampanaEncuesta
Visible=S
Antes=S
ConCondicion=S

ActivoCondicion=(CampanaD:CampanaD.ContactoTipo en (<T>Prospecto<T>, <T>Cliente<T>)) y (Info.Estatus noen(EstatusConcluido, EstatusCancelado))
EjecucionCondicion=ConDatos(CampanaD:CampanaD.Contacto)
AntesExpresiones=Asigna(Info.ID,CampanaD:CampanaD.ID)<BR>Asigna(Info.RID, CampanaD:CampanaD.RID)<BR>Asigna(Info.Clave,CampanaD:CampanaD.Contacto)<BR>Asigna(Info.Nombre,CampanaD:ContactoNombre)<BR>Asigna(Info.PuedeEditar, Info.Estatus noen (EstatusConcluido, EstatusCancelado))
[Acciones.Sucursales]
Nombre=Sucursales
Boton=16
NombreDesplegar=&Sucursales
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteEnviarA
Visible=S
ConCondicion=S
Antes=S
ActivoCondicion=(CampanaD:CampanaD.ContactoTipo=<T>Cliente<T>) y (Info.Estatus noen(EstatusConcluido, EstatusCancelado))
EjecucionCondicion=ConDatos(CampanaD:CampanaD.Contacto)
AntesExpresiones=Asigna(Info.Cliente,CampanaD:CampanaD.Contacto)<BR>Asigna(Info.Nombre,CampanaD:ContactoNombre)

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=103
NombreDesplegar=E&valuaciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Antes=S
Expresion=Caso Info.Estatus<BR>  Es EstatusCancelado Entonces Forma(<T>EvaluacionCalificacionInfo<T>)<BR>Sino<BR> Forma(<T>EvaluacionCalificacion<T>)<BR>Fin
EjecucionCondicion=ConDatos(CampanaD:CampanaD.Contacto)
AntesExpresiones=Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Clave, CampanaD:CampanaD.Contacto)<BR>Asigna(Info.Nombre, CampanaD:ContactoNombre)<BR>Asigna(Info.Nombre2, Nulo)<BR><BR>Caso CampanaD:CampanaD.ContactoTipo<BR>  Es <T>Cliente<T> Entonces Asigna(Info.Aplica, <T>Clientes<T>)<BR>  Es <T>Prospecto<T> Entonces Asigna(Info.Aplica, <T>Prospectos<T>)<BR>  Es <T>Proveedor<T> Entonces Asigna(Info.Aplica, <T>Proveedores<T>)<BR>  Es <T>Personal<T> Entonces Asigna(Info.Aplica, <T>Personal<T>)<BR>  Es <T>Agente<T> Entonces Asigna(Info.Aplica, <T>Agentes<T>)<BR>Fin

[Tareas.CampanaTarea.Inicio]
Carpeta=Tareas
Clave=CampanaTarea.Inicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Tareas.CampanaTarea.Vencimiento]
Carpeta=Tareas
Clave=CampanaTarea.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Tareas.CampanaTarea.Estado]
Carpeta=Tareas
Clave=CampanaTarea.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Tareas.CampanaTarea.Avance]
Carpeta=Tareas
Clave=CampanaTarea.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Tareas.CampanaTarea.FechaConclusion]
Carpeta=Tareas
Clave=CampanaTarea.FechaConclusion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

[Acciones.Contacto]
Nombre=Contacto
Boton=35
NombreEnBoton=S
NombreDesplegar=C&ontacto
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
ConCondicion=S
Visible=S
Expresion=Asigna(Info.RID, CampanaD:CampanaD.RID)<BR>Asigna(Info.PuedeEditar, Info.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Clave, CampanaD:CampanaD.Contacto)<BR>Asigna(Info.Nombre, CampanaD:ContactoNombre)<BR>Si<BR>  Caso CampanaD:CampanaD.ContactoTipo<BR>    Es <T>Prospecto<T> Entonces Forma(<T>CampanaProspecto<T>)<BR>    Es <T>Cliente<T>   Entonces Forma(<T>CampanaCte<T>)<BR>  Sino<BR>    Falso<BR>  Fin<BR>Entonces<BR>  Asigna(CampanaD:CampanaD.Calificacion, SQL(<T>spCampanaDCalificacion :nID, :nRID<T>, CampanaD:CampanaD.ID, CampanaD:CampanaD.RID))<BR>  Asigna(CampanaD:CampanaD.Situacion, SQL(<T>spCampanaDSituacion :nID, :nRID<T>, CampanaD:CampanaD.ID, CampanaD:CampanaD.RID))<BR>  Asigna(CampanaD:CampanaD.SituacionFecha, SQL(<T>spCampanaDSituacionFecha :nID, :nRID<T>, CampanaD:CampanaD.ID, CampanaD:CampanaD.RID))<BR>  Asigna(CampanaD:CampanaD.Observaciones, SQL(<T>spCampanaDObservaciones :nID, :nRID<T>, CampanaD:CampanaD.ID, CampanaD:CampanaD.RID))<BR>  GuardarCambios<BR>  Forma.ActualizarVista(<T>Tareas<T>)<BR>  Forma.ActualizarVista(<T>Bitacora<T>)<BR>Fin
ActivoCondicion=Info.Estatus<>EstatusCancelado
EjecucionCondicion=ConDatos(CampanaD:CampanaD.Contacto)

[Bitacora]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Bitácora
Clave=Bitacora
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CampanaEvento
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tipo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
Detalle=S
VistaMaestra=CampanaD
LlaveLocal=(Lista)
LlaveMaestra=(Lista)
MenuLocal=S
ListaAcciones=EventoInfo

IconosNombre=CampanaEvento:CampanaEvento.Tipo
[Bitacora.Columnas]
0=95
1=79

2=-2
3=-2
4=-2
[Bitacora.CampanaEvento.FechaHora]
Carpeta=Bitacora
Clave=CampanaEvento.FechaHora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Bitacora.CampanaEvento.Situacion]
Carpeta=Bitacora
Clave=CampanaEvento.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Bitacora.CampanaEvento.SituacionFecha]
Carpeta=Bitacora
Clave=CampanaEvento.SituacionFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Bitacora.CampanaEvento.Observaciones]
Carpeta=Bitacora
Clave=CampanaEvento.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Acciones.EventoInfo]
Nombre=EventoInfo
Boton=0
NombreDesplegar=&Información del Evento
EnMenu=S
TipoAccion=Formas
ClaveAccion=CampanaEventoInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(CampanaEvento:CampanaEvento.EventoID)
AntesExpresiones=Asigna(Info.ID, CampanaEvento:CampanaEvento.ID)<BR>Asigna(Info.RID, CampanaEvento:CampanaEvento.RID)<BR>Asigna(Info.EventoID, CampanaEvento:CampanaEvento.EventoID)

[Acciones.ListaContacto]
Nombre=ListaContacto
Boton=0
NombreDesplegar=Contacto
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=F7
EsDefault=S
Expresion=Forma.Accion(<T>Contacto<T>)
EjecucionCondicion=ConDatos(CampanaD:CampanaD.Contacto)

[Acciones.AgregarEvento]
Nombre=AgregarEvento
Boton=56
NombreEnBoton=S
NombreDesplegar=Agregar E&vento
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
ConCondicion=S
EspacioPrevio=S
Expresion=Asigna(Info.RID, CampanaD:CampanaD.RID)<BR>Asigna(Info.PuedeEditar, Info.Estatus noen (EstatusConcluido, EstatusCancelado))<BR>Asigna(Info.Clave, CampanaD:CampanaD.Contacto)<BR>Asigna(Info.Nombre, CampanaD:ContactoNombre)<BR>Si<BR>  Forma(<T>CampanaEvento<T>)<BR>Entonces<BR>  Asigna(CampanaD:CampanaD.Calificacion, SQL(<T>spCampanaDCalificacion :nID, :nRID<T>, CampanaD:CampanaD.ID, CampanaD:CampanaD.RID))<BR>  Asigna(CampanaD:CampanaD.Situacion, SQL(<T>spCampanaDSituacion :nID, :nRID<T>, CampanaD:CampanaD.ID, CampanaD:CampanaD.RID))<BR>  Asigna(CampanaD:CampanaD.SituacionFecha, SQL(<T>spCampanaDSituacionFecha :nID, :nRID<T>, CampanaD:CampanaD.ID, CampanaD:CampanaD.RID))<BR>  Asigna(CampanaD:CampanaD.Observaciones, SQL(<T>spCampanaDObservaciones :nID, :nRID<T>, CampanaD:CampanaD.ID, CampanaD:CampanaD.RID))<BR>  GuardarCambios<BR>  Forma.ActualizarVista(<T>Tareas<T>)<BR>  Forma.ActualizarVista(<T>Bitacora<T>)<BR>Fin
ActivoCondicion=Info.Estatus noen (EstatusConcluido, EstatusCancelado)
EjecucionCondicion=ConDatos(CampanaD:CampanaD.Contacto)







[Lista.ListaEnCaptura]
(Inicio)=ContactoNombre
ContactoNombre=ContactoSubTipo
ContactoSubTipo=CampanaD.Situacion
CampanaD.Situacion=CampanaD.SituacionFecha
CampanaD.SituacionFecha=CampanaD.Calificacion
CampanaD.Calificacion=(Fin)






[Tareas.LlaveLocal]
(Inicio)=CampanaTarea.ID
CampanaTarea.ID=CampanaTarea.RID
CampanaTarea.RID=(Fin)

[Tareas.LlaveMaestra]
(Inicio)=CampanaD.ID
CampanaD.ID=CampanaD.RID
CampanaD.RID=(Fin)

[Tareas.ListaEnCaptura]
(Inicio)=CampanaTarea.Asunto
CampanaTarea.Asunto=CampanaTarea.Avance
CampanaTarea.Avance=CampanaTarea.Estado
CampanaTarea.Estado=CampanaTarea.Inicio
CampanaTarea.Inicio=CampanaTarea.Vencimiento
CampanaTarea.Vencimiento=CampanaTarea.FechaConclusion
CampanaTarea.FechaConclusion=(Fin)

[Bitacora.LlaveLocal]
(Inicio)=CampanaEvento.ID
CampanaEvento.ID=CampanaEvento.RID
CampanaEvento.RID=(Fin)

[Bitacora.LlaveMaestra]
(Inicio)=CampanaD.ID
CampanaD.ID=CampanaD.RID
CampanaD.RID=(Fin)

[Bitacora.ListaEnCaptura]
(Inicio)=CampanaEvento.FechaHora
CampanaEvento.FechaHora=CampanaEvento.Situacion
CampanaEvento.Situacion=CampanaEvento.SituacionFecha
CampanaEvento.SituacionFecha=CampanaEvento.Observaciones
CampanaEvento.Observaciones=(Fin)







[Prospecto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Prospecto
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Prospecto
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CampanaD
LlaveLocal=Prospecto.Prospecto
LlaveMaestra=CampanaD.Contacto
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CondicionEdicion=Info.Estatus noen(EstatusConcluido, EstatusCancelado)
ListaEnCaptura=(Lista)
CondicionVisible=CampanaD:CampanaD.ContactoTipo=<T>Prospecto<T>
[Prospecto.Prospecto.Prospecto]
Carpeta=Prospecto
Clave=Prospecto.Prospecto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
Efectos=[Negritas]

[Prospecto.Prospecto.Estatus]
Carpeta=Prospecto
Clave=Prospecto.Estatus
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

Editar=S
LineaNueva=S
[Prospecto.Prospecto.Tipo]
Carpeta=Prospecto
Clave=Prospecto.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Prospecto.Prospecto.Nombre]
Carpeta=Prospecto
Clave=Prospecto.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=100
ColorFondo=Blanco

[Prospecto.Prospecto.SIC]
Carpeta=Prospecto
Clave=Prospecto.SIC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Prospecto.SIC.Nombre]
Carpeta=Prospecto
Clave=SIC.Nombre
Editar=S
3D=S
Tamano=100
ColorFondo=Blanco

LineaNueva=S
ValidaNombre=S
[Prospecto.Prospecto.Categoria]
Carpeta=Prospecto
Clave=Prospecto.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Prospecto.Prospecto.Origen]
Carpeta=Prospecto
Clave=Prospecto.Origen
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

LineaNueva=S
[Prospecto.Prospecto.Grupo]
Carpeta=Prospecto
Clave=Prospecto.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Prospecto.Prospecto.RFC]
Carpeta=Prospecto
Clave=Prospecto.RFC
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Prospecto.Prospecto.Familia]
Carpeta=Prospecto
Clave=Prospecto.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Prospecto.Prospecto.CURP]
Carpeta=Prospecto
Clave=Prospecto.CURP
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Prospecto.Prospecto.Direccion]
Carpeta=Prospecto
Clave=Prospecto.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=54
ColorFondo=Blanco

[Prospecto.Prospecto.DireccionNumero]
Carpeta=Prospecto
Clave=Prospecto.DireccionNumero
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Prospecto.Prospecto.DireccionNumeroInt]
Carpeta=Prospecto
Clave=Prospecto.DireccionNumeroInt
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Prospecto.Prospecto.EntreCalles]
Carpeta=Prospecto
Clave=Prospecto.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Prospecto.Prospecto.Plano]
Carpeta=Prospecto
Clave=Prospecto.Plano
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Prospecto.Prospecto.Observaciones]
Carpeta=Prospecto
Clave=Prospecto.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Prospecto.Prospecto.Delegacion]
Carpeta=Prospecto
Clave=Prospecto.Delegacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Prospecto.Prospecto.Colonia]
Carpeta=Prospecto
Clave=Prospecto.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Prospecto.Prospecto.CodigoPostal]
Carpeta=Prospecto
Clave=Prospecto.CodigoPostal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Prospecto.Prospecto.Poblacion]
Carpeta=Prospecto
Clave=Prospecto.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Prospecto.Prospecto.Estado]
Carpeta=Prospecto
Clave=Prospecto.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Prospecto.Prospecto.Pais]
Carpeta=Prospecto
Clave=Prospecto.Pais
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Prospecto.Prospecto.Telefonos]
Carpeta=Prospecto
Clave=Prospecto.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=60
ColorFondo=Blanco

[Prospecto.Prospecto.TelefonosLada]
Carpeta=Prospecto
Clave=Prospecto.TelefonosLada
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Prospecto.Prospecto.Fax]
Carpeta=Prospecto
Clave=Prospecto.Fax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Prospecto.Prospecto.PedirTono]
Carpeta=Prospecto
Clave=Prospecto.PedirTono
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Prospecto.Prospecto.Agente]
Carpeta=Prospecto
Clave=Prospecto.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Prospecto.Agente.Nombre]
Carpeta=Prospecto
Clave=Agente.Nombre
Editar=S
3D=S
Tamano=35
ColorFondo=Plata





[ProspectoComentarios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comentarios
Clave=ProspectoComentarios
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Prospecto
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CampanaD
LlaveLocal=Prospecto.Prospecto
LlaveMaestra=CampanaD.Contacto
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
AlinearTodaCarpeta=S
CondicionEdicion=Info.Estatus noen(EstatusConcluido, EstatusCancelado)



ListaEnCaptura=Prospecto.Comentarios
CondicionVisible=CampanaD:CampanaD.ContactoTipo=<T>Prospecto<T>
[Cliente]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Cliente
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CteCampana
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=CampanaD
LlaveLocal=Cte.Cliente
LlaveMaestra=CampanaD.Contacto
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CondicionEdicion=Info.Estatus noen(EstatusConcluido, EstatusCancelado)





ListaEnCaptura=(Lista)
CondicionVisible=CampanaD:CampanaD.ContactoTipo=<T>Cliente<T>
[ProspectoComentarios.]
Carpeta=ProspectoComentarios
ColorFondo=Negro





Editar=N

[Cliente.Cte.Cliente]
Carpeta=Cliente
Clave=Cte.Cliente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
Efectos=[Negritas]

[Cliente.Cte.Estatus]
Carpeta=Cliente
Clave=Cte.Estatus
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Cliente.Cte.Tipo]
Carpeta=Cliente
Clave=Cte.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cliente.Cte.Nombre]
Carpeta=Cliente
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=66
ColorFondo=Blanco
Efectos=[Negritas]

[Cliente.Cte.Categoria]
Carpeta=Cliente
Clave=Cte.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cliente.Cte.Grupo]
Carpeta=Cliente
Clave=Cte.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cliente.Cte.RFC]
Carpeta=Cliente
Clave=Cte.RFC
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cliente.Cte.Familia]
Carpeta=Cliente
Clave=Cte.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cliente.Cte.CURP]
Carpeta=Cliente
Clave=Cte.CURP
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cliente.Cte.Direccion]
Carpeta=Cliente
Clave=Cte.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=54
ColorFondo=Blanco

[Cliente.Cte.DireccionNumero]
Carpeta=Cliente
Clave=Cte.DireccionNumero
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Cliente.Cte.DireccionNumeroInt]
Carpeta=Cliente
Clave=Cte.DireccionNumeroInt
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Cliente.Cte.EntreCalles]
Carpeta=Cliente
Clave=Cte.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cliente.Cte.Plano]
Carpeta=Cliente
Clave=Cte.Plano
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cliente.Cte.Observaciones]
Carpeta=Cliente
Clave=Cte.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cliente.Cte.Delegacion]
Carpeta=Cliente
Clave=Cte.Delegacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cliente.Cte.Colonia]
Carpeta=Cliente
Clave=Cte.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cliente.Cte.CodigoPostal]
Carpeta=Cliente
Clave=Cte.CodigoPostal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cliente.Cte.Poblacion]
Carpeta=Cliente
Clave=Cte.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cliente.Cte.Estado]
Carpeta=Cliente
Clave=Cte.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cliente.Cte.Pais]
Carpeta=Cliente
Clave=Cte.Pais
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cliente.Cte.Telefonos]
Carpeta=Cliente
Clave=Cte.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=60
ColorFondo=Blanco

[Cliente.Cte.TelefonosLada]
Carpeta=Cliente
Clave=Cte.TelefonosLada
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Cliente.Cte.Fax]
Carpeta=Cliente
Clave=Cte.Fax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cliente.Cte.PedirTono]
Carpeta=Cliente
Clave=Cte.PedirTono
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cliente.Cte.Agente]
Carpeta=Cliente
Clave=Cte.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Cliente.Agente.Nombre]
Carpeta=Cliente
Clave=Agente.Nombre
Editar=S
3D=S
Tamano=35
ColorFondo=Plata



[ProspectoComentarios.Prospecto.Comentarios]
Carpeta=ProspectoComentarios
Clave=Prospecto.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Prospecto.ListaEnCaptura]
(Inicio)=Prospecto.Prospecto
Prospecto.Prospecto=Prospecto.Estatus
Prospecto.Estatus=Prospecto.Tipo
Prospecto.Tipo=Prospecto.Nombre
Prospecto.Nombre=Prospecto.SIC
Prospecto.SIC=SIC.Nombre
SIC.Nombre=Prospecto.Categoria
Prospecto.Categoria=Prospecto.Origen
Prospecto.Origen=Prospecto.Grupo
Prospecto.Grupo=Prospecto.RFC
Prospecto.RFC=Prospecto.Familia
Prospecto.Familia=Prospecto.CURP
Prospecto.CURP=Prospecto.Direccion
Prospecto.Direccion=Prospecto.DireccionNumero
Prospecto.DireccionNumero=Prospecto.DireccionNumeroInt
Prospecto.DireccionNumeroInt=Prospecto.EntreCalles
Prospecto.EntreCalles=Prospecto.Plano
Prospecto.Plano=Prospecto.Observaciones
Prospecto.Observaciones=Prospecto.Delegacion
Prospecto.Delegacion=Prospecto.Colonia
Prospecto.Colonia=Prospecto.CodigoPostal
Prospecto.CodigoPostal=Prospecto.Poblacion
Prospecto.Poblacion=Prospecto.Estado
Prospecto.Estado=Prospecto.Pais
Prospecto.Pais=Prospecto.Telefonos
Prospecto.Telefonos=Prospecto.TelefonosLada
Prospecto.TelefonosLada=Prospecto.Fax
Prospecto.Fax=Prospecto.PedirTono
Prospecto.PedirTono=Prospecto.Agente
Prospecto.Agente=Agente.Nombre
Agente.Nombre=(Fin)

[Cliente.ListaEnCaptura]
(Inicio)=Cte.Cliente
Cte.Cliente=Cte.Estatus
Cte.Estatus=Cte.Tipo
Cte.Tipo=Cte.Nombre
Cte.Nombre=Cte.Categoria
Cte.Categoria=Cte.Grupo
Cte.Grupo=Cte.RFC
Cte.RFC=Cte.Familia
Cte.Familia=Cte.CURP
Cte.CURP=Cte.Direccion
Cte.Direccion=Cte.DireccionNumero
Cte.DireccionNumero=Cte.DireccionNumeroInt
Cte.DireccionNumeroInt=Cte.EntreCalles
Cte.EntreCalles=Cte.Plano
Cte.Plano=Cte.Observaciones
Cte.Observaciones=Cte.Delegacion
Cte.Delegacion=Cte.Colonia
Cte.Colonia=Cte.CodigoPostal
Cte.CodigoPostal=Cte.Poblacion
Cte.Poblacion=Cte.Estado
Cte.Estado=Cte.Pais
Cte.Pais=Cte.Telefonos
Cte.Telefonos=Cte.TelefonosLada
Cte.TelefonosLada=Cte.Fax
Cte.Fax=Cte.PedirTono
Cte.PedirTono=Cte.Agente
Cte.Agente=Agente.Nombre
Agente.Nombre=(Fin)











[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Bitacora
Bitacora=Tareas
Tareas=Prospecto
Prospecto=ProspectoComentarios
ProspectoComentarios=Cliente
Cliente=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Guardar Cambios
Guardar Cambios=Contacto
Contacto=AgregarEvento
AgregarEvento=Navegador
Navegador=Contactos
Contactos=Encuesta
Encuesta=Sucursales
Sucursales=Evaluaciones
Evaluaciones=(Fin)
