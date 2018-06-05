[Forma]
Clave=EspacioAsignacion
Nombre=Asignación Directa
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=213
PosicionInicialArriba=82
PosicionInicialAlturaCliente=505
PosicionInicialAncho=598
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Cliente, Info.Proyecto)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EspacioAsignacion
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
ValidarCampos=S
ListaCamposAValidar=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=EspacioAsignacion.Empresa=<T>{Empresa}<T><BR>{Si(ConDatos(Info.Cliente), <T> AND EspacioAsignacion.Cliente=<T>+Comillas(Info.Cliente), <T><T>)}<BR>{Si(ConDatos(Info.Proyecto), <T> AND EspacioAsignacion.Proyecto=<T>+Comillas(Info.Proyecto), <T><T>)}

[Lista.EspacioAsignacion.Espacio]
Carpeta=Lista
Clave=EspacioAsignacion.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioAsignacion.Fecha]
Carpeta=Lista
Clave=EspacioAsignacion.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioAsignacion.Hora]
Carpeta=Lista
Clave=EspacioAsignacion.Hora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioAsignacion.Cliente]
Carpeta=Lista
Clave=EspacioAsignacion.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioAsignacion.Proyecto]
Carpeta=Lista
Clave=EspacioAsignacion.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Lista.Columnas]
Espacio=97
Fecha=82
Hora=58
Cliente=98
Proyecto=132
Estatus=91

[Lista.EspacioAsignacion.Estatus]
Carpeta=Lista
Clave=EspacioAsignacion.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Acciones.EspacioInfo]
Nombre=EspacioInfo
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EspacioInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(EspacioAsignacion:EspacioAsignacion.Espacio)
AntesExpresiones=Asigna(Info.Espacio, EspacioAsignacion:EspacioAsignacion.Espacio)

[Acciones.Plan]
Nombre=Plan
Boton=88
NombreDesplegar=Plan
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=CalendarioReservaciones(<T><T>, EspacioAsignacion:EspacioAsignacion.Espacio)
EjecucionCondicion=ConDatos(EspacioAsignacion:EspacioAsignacion.Espacio)

[Acciones.Asistente.Asistente Espacios]
Nombre=Asistente Espacios
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Wizards
ClaveAccion=Asistente Espacios
ListaParametros1=EspacioAsignacion:EspacioAsignacion.Espacio<BR>EspacioAsignacion:EspacioAsignacion.Fecha<BR>EspacioAsignacion:EspacioAsignacion.Hora
ListaParametros=S
Activo=S
Visible=S

[Acciones.Asistente]
Nombre=Asistente
Boton=12
NombreEnBoton=S
NombreDesplegar=&Asistente
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Wizards
ClaveAccion=Asistente Espacios
ListaParametros1=EspacioAsignacion:EspacioAsignacion.Espacio<BR>EspacioAsignacion:EspacioAsignacion.Fecha<BR>EspacioAsignacion:EspacioAsignacion.Hora
ListaParametros=S
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Asistente
Asistente=EspacioInfo
EspacioInfo=Plan
Plan=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=EspacioAsignacion.Fecha
EspacioAsignacion.Fecha=EspacioAsignacion.Espacio
EspacioAsignacion.Espacio=EspacioAsignacion.Hora
EspacioAsignacion.Hora=EspacioAsignacion.Cliente
EspacioAsignacion.Cliente=EspacioAsignacion.Proyecto
EspacioAsignacion.Proyecto=EspacioAsignacion.Estatus
EspacioAsignacion.Estatus=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Espacio.Nombre
Espacio.Nombre=Cte.Nombre
Cte.Nombre=(Fin)

[Lista.ListaOrden]
(Inicio)=EspacioAsignacion.Fecha<TAB>(Acendente)
EspacioAsignacion.Fecha<TAB>(Acendente)=EspacioAsignacion.Espacio<TAB>(Acendente)
EspacioAsignacion.Espacio<TAB>(Acendente)=(Fin)
