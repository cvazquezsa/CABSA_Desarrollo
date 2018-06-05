[Forma]
Clave=EmbarqueAsistenteGeneral
Nombre=Asistente Embarques
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=171
PosicionInicialArriba=248
PosicionInicialAlturaCliente=493
PosicionInicialAncho=938
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Estado, <T>Cobrado<T>)<BR>Asigna(Info.Nombre, SQLEnLista(<T>SELECT DISTINCT Mov FROM EmbarqueMov WHERE Empresa=:tEmpresa<T>, Empresa))

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmbarqueAsistenteGeneral
Fuente={Tahoma, 8, Negro, []}
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
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=EmbarqueAsistenteGeneral.Empresa=<T>{Empresa}<T> AND EmbarqueAsistenteGeneral.Estacion={EstacionTrabajo}

[Lista.EmbarqueAsistenteGeneral.Mov]
Carpeta=Lista
Clave=EmbarqueAsistenteGeneral.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteGeneral.MovID]
Carpeta=Lista
Clave=EmbarqueAsistenteGeneral.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteGeneral.Importe]
Carpeta=Lista
Clave=EmbarqueAsistenteGeneral.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteGeneral.Forma]
Carpeta=Lista
Clave=EmbarqueAsistenteGeneral.Forma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Guardar Cambios<BR>Aceptar

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

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Lista.Columnas]
Mov=112
MovID=66
Importe=112
Forma=83
Estado=85
Causa=115
FechaHora=72
Persona=72
PersonaID=72
Referencia=111

[Acciones.Aceptar.Guardar Cambios]
Nombre=Guardar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
EjecucionCondicion=Asigna(Temp.Texto, SQL(<T>spEmbarqueAsistenteGeneralAceptar :tEmpresa, :nEstacion<T>, Empresa, EstacionTrabajo))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Temp.Texto

[Lista.EmbarqueAsistenteGeneral.Estado]
Carpeta=Lista
Clave=EmbarqueAsistenteGeneral.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteGeneral.Causa]
Carpeta=Lista
Clave=EmbarqueAsistenteGeneral.Causa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteGeneral.FechaHora]
Carpeta=Lista
Clave=EmbarqueAsistenteGeneral.FechaHora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteGeneral.Persona]
Carpeta=Lista
Clave=EmbarqueAsistenteGeneral.Persona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteGeneral.PersonaID]
Carpeta=Lista
Clave=EmbarqueAsistenteGeneral.PersonaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteGeneral.Referencia]
Carpeta=Lista
Clave=EmbarqueAsistenteGeneral.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=EmbarqueAsistenteGeneral.Mov
EmbarqueAsistenteGeneral.Mov=EmbarqueAsistenteGeneral.MovID
EmbarqueAsistenteGeneral.MovID=EmbarqueAsistenteGeneral.Estado
EmbarqueAsistenteGeneral.Estado=EmbarqueAsistenteGeneral.Importe
EmbarqueAsistenteGeneral.Importe=EmbarqueAsistenteGeneral.Forma
EmbarqueAsistenteGeneral.Forma=EmbarqueAsistenteGeneral.Causa
EmbarqueAsistenteGeneral.Causa=EmbarqueAsistenteGeneral.FechaHora
EmbarqueAsistenteGeneral.FechaHora=EmbarqueAsistenteGeneral.Persona
EmbarqueAsistenteGeneral.Persona=EmbarqueAsistenteGeneral.PersonaID
EmbarqueAsistenteGeneral.PersonaID=EmbarqueAsistenteGeneral.Referencia
EmbarqueAsistenteGeneral.Referencia=(Fin)
