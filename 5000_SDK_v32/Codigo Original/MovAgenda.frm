[Forma]
Clave=MovAgenda
Nombre=Agenda
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=257
PosicionInicialArriba=151
PosicionInicialAlturaCliente=431
PosicionInicialAncho=509
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID)
ExpresionesAlMostrar=Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Fecha, Nulo)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AgenteAgenda
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
CarpetaVisible=S
Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CondicionEdicion=Info.PuedeEditar
HojaMantenerSeleccion=S
FiltroGeneral=AgenteAgenda.Modulo=<T>{Info.Modulo}<T> AND AgenteAgenda.ID={Info.ID}

[Lista.AgenteAgenda.Agente]
Carpeta=Lista
Clave=AgenteAgenda.Agente
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
Editar=S

[Lista.Agente.Nombre]
Carpeta=Lista
Clave=Agente.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.AgenteAgenda.Fecha]
Carpeta=Lista
Clave=AgenteAgenda.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AgenteAgenda.Hora]
Carpeta=Lista
Clave=AgenteAgenda.Hora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Agente=100
Nombre=237
Fecha=87
Hora=53

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Agenda]
Nombre=Agenda
Boton=9
NombreEnBoton=S
NombreDesplegar=Agen&da
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerAgenteAgenda
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Agente, AgenteAgenda:AgenteAgenda.Agente)<BR>Asigna(Info.Fecha, Vacio(AgenteAgenda:AgenteAgenda.Fecha, Hoy))

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Agenda
Agenda=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AgenteAgenda.Agente
AgenteAgenda.Agente=Agente.Nombre
Agente.Nombre=AgenteAgenda.Fecha
AgenteAgenda.Fecha=AgenteAgenda.Hora
AgenteAgenda.Hora=(Fin)
