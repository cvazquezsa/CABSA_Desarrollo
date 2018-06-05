[Forma]
Clave=CampanaCorreo
Nombre=Enviar Correo
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=496
PosicionInicialArriba=279
PosicionInicialAlturaCliente=605
PosicionInicialAncho=927
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionSec1=52
VentanaExclusiva=S
Comentarios=Lista(Info.Mov, Info.MovID)
IniciarAgregando=S

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaCorreo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S

[Ficha.CampanaCorreo.Pagina]
Carpeta=Ficha
Clave=CampanaCorreo.Pagina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaCorreo.Asunto]
Carpeta=Ficha
Clave=CampanaCorreo.Asunto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=100
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

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CampanaCorreoD
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tipo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
CarpetaVisible=S
PestanaOtroNombre=S
FiltroAutoCampo=Situacion
FiltroAutoValidar=Situacion
FiltroTodo=S
FiltroTodoFinal=S
FiltroEstilo=Folder (varias líneas)
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroAplicaEn=Situacion
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=SituacionFecha
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroFechasDefault=(Todo)
IconosNombre=CampanaCorreoD:ContactoSubTipo
FiltroGeneral=CampanaD.ID={Info.ID}
FiltroUsuarios=S
FiltroUsuarioDefault=(Todos)

[Lista.ContactoNombre]
Carpeta=Lista
Clave=ContactoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=100
1=268

[Acciones.ListaTodo]
Nombre=ListaTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.ListaQuitar]
Nombre=ListaQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.ListaPersonalizar]
Nombre=ListaPersonalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.Observaciones]
Carpeta=Lista
Clave=Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Calificacion]
Carpeta=Lista
Clave=Calificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Enviar]
Nombre=Enviar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Enviar Correos
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si<BR>  Confirmacion(<T>Esta Seguro que desea enviar este Correo a:<T> + NuevaLinea + NuevaLinea + SQLEnLista(<T>SELECT Cargo FROM CampanaTipoCargo WHERE CampanaTipo=:tTipo<T>, Info.Tipo), BotonSi, BotonNo)=BotonSi<BR>Entonces<BR>  RegistrarListaSt(<T>Lista<T>, <T>RID<T>)<BR>  ProcesarSQL(<T>spCampanaCorreoEnviarListaSt :nID, :nCorreoID, :nEstacion<T>, Info.ID, CampanaCorreo:CampanaCorreo.CorreoID, EstacionTrabajo)<BR>Fin

[Lista.Situacion]
Carpeta=Lista
Clave=Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SituacionFecha]
Carpeta=Lista
Clave=SituacionFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
Multiple=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cerrar

[Acciones.Cerrar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cerrar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Lista
Lista=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Enviar
Enviar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=CampanaCorreo.Pagina
CampanaCorreo.Pagina=CampanaCorreo.Asunto
CampanaCorreo.Asunto=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ContactoNombre
ContactoNombre=Situacion
Situacion=SituacionFecha
SituacionFecha=Observaciones
Observaciones=Calificacion
Calificacion=(Fin)

[Lista.ListaAcciones]
(Inicio)=ListaTodo
ListaTodo=ListaQuitar
ListaQuitar=ListaPersonalizar
ListaPersonalizar=(Fin)
