
[Forma]
Clave=OportunidadeMailEnviar
Icono=240
Modulos=(Todos)
MovModulo=OPORT
Nombre=Enviar Correo Electrónico
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=320
PosicionInicialArriba=86
PosicionInicialAlturaCliente=518
PosicionInicialAncho=726
PosicionSec1=43
Comentarios=Lista(Info.Mov +<T> <T>+Info.MovID)
VentanaExclusiva=S
VentanaExclusivaOpcion=2
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spOportunidadeMailObtener :nEstacion, :nID<T>, EstacionTrabajo, Info.ID)
[Acciones.Enviar]
Nombre=Enviar
Boton=84
NombreEnBoton=S
NombreDesplegar=&Enviar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
GuardarAntes=S
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=OportunidadeMailEnviar
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
OtroOrden=S
BusquedaRapidaControles=S

ListaOrden=(Lista)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=32
BusquedaEnLinea=S
ValidarCampos=S
MenuLocal=S
ListaAcciones=(Lista)
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=OportunidadeMailEnviar.EstacionTrabajo = {EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
[Lista.Cte.Cliente]
Carpeta=Lista
Clave=Cte.Cliente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.OportunidadeMailEnviar.Enviar]
Carpeta=Lista
Clave=OportunidadeMailEnviar.Enviar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
Cliente_1=93
Enviar=70






eMail=296



Nombre=196
0=191
[Lista.CteCto.eMail]
Carpeta=Lista
Clave=CteCto.eMail
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




[Acciones.Cancelar]
Nombre=Cancelar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S










[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
NombreDesplegar=&Seleccionar Todo
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

GuardarAntes=S
Expresion=EjecutarSQL(<T>EXEC spOportunidadeMailSeleccionar :nEstacionTrabajo, :tBase<T>, EstacionTrabajo, <T>Todo<T>)<BR>ActualizarVista<BR>ActualizarForma
[Acciones.SeleccionarNada]
Nombre=SeleccionarNada
Boton=0
NombreDesplegar=Quitar Selección
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

GuardarAntes=S




Expresion=EjecutarSQL(<T>EXEC spOportunidadeMailSeleccionar :nEstacionTrabajo, :tBase<T>, EstacionTrabajo, <T>Nada<T>)<BR>ActualizarVista<BR>ActualizarForma














[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco













[Lista.ListaCamposAValidar]
(Inicio)=CteCto.Nombre
CteCto.Nombre=CteCto.ApellidoPaterno
CteCto.ApellidoPaterno=CteCto.ApellidoMaterno
CteCto.ApellidoMaterno=(Fin)



[(Variables)]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Plantilla
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
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
ListaEnCaptura=Info.OPORTPlantillaeMail
CarpetaVisible=S





[Acciones.Enviar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=ProcesarSQL(<T>spOportunidadeMailEnviar :nID, :tUsuario, :nEstacionTrabajo, :tPlantilla<T>, Info.ID, Usuario, EstacionTrabajo, Info.OPORTPlantillaeMail)
[Acciones.Enviar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S





[Acciones.OportunidadeMailUsuario]
Nombre=OportunidadeMailUsuario
Boton=50
NombreEnBoton=S
NombreDesplegar=Correos Enviados
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=OportunidadeMailUsuario
Activo=S
Visible=S















[(Variables).Info.OPORTPlantillaeMail]
Carpeta=(Variables)
Clave=Info.OPORTPlantillaeMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco









[Lista.ListaEnCaptura]
(Inicio)=Cte.Cliente
Cte.Cliente=Cte.Nombre
Cte.Nombre=CteCto.eMail
CteCto.eMail=OportunidadeMailEnviar.Enviar
OportunidadeMailEnviar.Enviar=(Fin)

[Lista.ListaOrden]
(Inicio)=CteCto.Cliente	(Acendente)
CteCto.Cliente	(Acendente)=CteCto.ID	(Acendente)
CteCto.ID	(Acendente)=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionarTodo
SeleccionarTodo=SeleccionarNada
SeleccionarNada=(Fin)








[Acciones.Enviar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Enviar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Cerrar
Cerrar=(Fin)















[Forma.ListaCarpetas]
(Inicio)=(Variables)
(Variables)=Lista
Lista=(Fin)

[Forma.ListaAcciones]
(Inicio)=Enviar
Enviar=Cancelar
Cancelar=OportunidadeMailUsuario
OportunidadeMailUsuario=(Fin)
