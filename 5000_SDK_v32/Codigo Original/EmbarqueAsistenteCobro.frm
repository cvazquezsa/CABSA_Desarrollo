[Forma]
Clave=EmbarqueAsistenteCobro
Nombre=Asistente del Embarque
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=172
PosicionInicialArriba=248
PosicionInicialAlturaCliente=493
PosicionInicialAncho=935
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Estado, <T>Cobrado<T>)<BR>Asigna(Info.Nombre, SQLEnLista(<T>SELECT DISTINCT Mov FROM EmbarqueMov WHERE AsignadoID=:nID<T>, Info.ID))

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmbarqueAsistenteCobro
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
FiltroGeneral=EmbarqueAsistenteCobro.ID={Info.ID}

[Lista.EmbarqueAsistenteCobro.Mov]
Carpeta=Lista
Clave=EmbarqueAsistenteCobro.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteCobro.MovID]
Carpeta=Lista
Clave=EmbarqueAsistenteCobro.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteCobro.Importe]
Carpeta=Lista
Clave=EmbarqueAsistenteCobro.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteCobro.Forma]
Carpeta=Lista
Clave=EmbarqueAsistenteCobro.Forma
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
MovID=65
Importe=112
Forma=83
Estado=85
Causa=130
FechaHora=75
Persona=74
PersonaID=68
Referencia=93

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
EjecucionCondicion=Asigna(Temp.Texto, SQL(<T>spEmbarqueAsistenteCobroAceptar :nID<T>, Info.ID))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Temp.Texto

[Lista.EmbarqueAsistenteCobro.Estado]
Carpeta=Lista
Clave=EmbarqueAsistenteCobro.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteCobro.Causa]
Carpeta=Lista
Clave=EmbarqueAsistenteCobro.Causa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteCobro.FechaHora]
Carpeta=Lista
Clave=EmbarqueAsistenteCobro.FechaHora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteCobro.Persona]
Carpeta=Lista
Clave=EmbarqueAsistenteCobro.Persona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteCobro.PersonaID]
Carpeta=Lista
Clave=EmbarqueAsistenteCobro.PersonaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueAsistenteCobro.Referencia]
Carpeta=Lista
Clave=EmbarqueAsistenteCobro.Referencia
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
(Inicio)=EmbarqueAsistenteCobro.Mov
EmbarqueAsistenteCobro.Mov=EmbarqueAsistenteCobro.MovID
EmbarqueAsistenteCobro.MovID=EmbarqueAsistenteCobro.Estado
EmbarqueAsistenteCobro.Estado=EmbarqueAsistenteCobro.Importe
EmbarqueAsistenteCobro.Importe=EmbarqueAsistenteCobro.Forma
EmbarqueAsistenteCobro.Forma=EmbarqueAsistenteCobro.Causa
EmbarqueAsistenteCobro.Causa=EmbarqueAsistenteCobro.FechaHora
EmbarqueAsistenteCobro.FechaHora=EmbarqueAsistenteCobro.Persona
EmbarqueAsistenteCobro.Persona=EmbarqueAsistenteCobro.PersonaID
EmbarqueAsistenteCobro.PersonaID=EmbarqueAsistenteCobro.Referencia
EmbarqueAsistenteCobro.Referencia=(Fin)
