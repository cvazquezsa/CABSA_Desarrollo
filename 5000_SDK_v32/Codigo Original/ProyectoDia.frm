[Forma]
Clave=ProyectoDia
Nombre=Días del Proyecto
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=768
PosicionInicialArriba=385
PosicionInicialAlturaCliente=393
PosicionInicialAncho=383
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Proyecto
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoDia
Fuente={Tahoma, 8, Negro, []}
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
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
FiltroGeneral=ProyectoDia.ID={Info.ID}

[Lista.ProyectoDia.Fecha]
Carpeta=Lista
Clave=ProyectoDia.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Fecha=80
Concepto=210
HorasDia=54

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

[Acciones.Sugerir]
Nombre=Sugerir
Boton=20
NombreDesplegar=Sugerir
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
NombreEnBoton=S
Expresion=EjecutarSQL(<T>spProyectoDiaSugerir :nID, :fDe, :fA<T>, Info.ID, Info.FechaD, Info.FechaA) <BR>Forma.ActualizarVista(<T>Lista<T>)
EjecucionCondicion=Forma(<T>EspecificarFechas<T>)

[Lista.ProyectoDia.Concepto]
Carpeta=Lista
Clave=ProyectoDia.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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

[Lista.ProyectoDia.HorasDia]
Carpeta=Lista
Clave=ProyectoDia.HorasDia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Sugerir
Sugerir=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProyectoDia.Fecha
ProyectoDia.Fecha=ProyectoDia.HorasDia
ProyectoDia.HorasDia=ProyectoDia.Concepto
ProyectoDia.Concepto=(Fin)
