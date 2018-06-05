[Forma]
Clave=GestionAgenda
Nombre=Modificar Agenda
Icono=65
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID)
PosicionInicialIzquierda=505
PosicionInicialArriba=327
PosicionInicialAlturaCliente=510
PosicionInicialAncho=909
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GestionAgenda
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S
ListaOrden=GestionAgenda.Orden<TAB>(Acendente)
HojaAjustarColumnas=S
FiltroGeneral=GestionAgenda.ID={Info.ID}

[Lista.GestionAgenda.Mov]
Carpeta=Lista
Clave=GestionAgenda.Mov
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Editar=S

[Lista.GestionAgenda.MovID]
Carpeta=Lista
Clave=GestionAgenda.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GestionAgenda.Orden]
Carpeta=Lista
Clave=GestionAgenda.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Gestion.Avance]
Carpeta=Lista
Clave=Gestion.Avance
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.EstatusNombre]
Carpeta=Lista
Clave=EstatusNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Gestion.Asunto]
Carpeta=Lista
Clave=Gestion.Asunto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Gestion.Espacio]
Carpeta=Lista
Clave=Gestion.Espacio
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Gestion.FechaA]
Carpeta=Lista
Clave=Gestion.FechaA
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Gestion.Duracion]
Carpeta=Lista
Clave=Gestion.Duracion
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
AntesExpresiones=EjecutarSQL(<T>spGestionModificarAgenda :nID<T>, Info.ID)
DespuesGuardar=S

[Lista.Columnas]
Mov=148
MovID=135
Orden=35
Avance=56
EstatusNombre=77
Asunto=212
Espacio=75
FechaA=79
Duracion=46
FechaEmision=79
Modulo=38

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
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Acciones.Agregar]
Nombre=Agregar
Boton=62
NombreEnBoton=S
NombreDesplegar=Movimientos &Otros Módulos
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
Expresion=Si<BR>  Forma(<T>GestionAgendaMovLista<T>)<BR>Entonces<BR>  Forma.ActualizarVista(<T>Lista<T>) <BR>Fin

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Agregar
Agregar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=GestionAgenda.Mov
GestionAgenda.Mov=GestionAgenda.MovID
GestionAgenda.MovID=GestionAgenda.Orden
GestionAgenda.Orden=Gestion.Avance
Gestion.Avance=EstatusNombre
EstatusNombre=Gestion.Asunto
Gestion.Asunto=Gestion.Espacio
Gestion.Espacio=Gestion.FechaA
Gestion.FechaA=Gestion.Duracion
Gestion.Duracion=(Fin)
