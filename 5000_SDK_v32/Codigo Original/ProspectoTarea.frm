
[Forma]
Clave=ProspectoTarea
Icono=0
Modulos=(All)

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=609
PosicionInicialArriba=329
PosicionInicialAlturaCliente=507
PosicionInicialAncho=701
Nombre=Tareas a Prospectos
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProspectoTarea
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
OtroOrden=S
PermiteEditar=S
ListaEnCaptura=(Lista)

ListaOrden=ProspectoTarea.Orden<TAB>(Acendente)

[Lista.ProspectoTarea.Tarea]
Carpeta=Lista
Clave=ProspectoTarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProspectoTarea.Orden]
Carpeta=Lista
Clave=ProspectoTarea.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProspectoTarea.EsFinal]
Carpeta=Lista
Clave=ProspectoTarea.EsFinal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
Tarea=604
Orden=35
EsFinal=31

[Lista.ListaEnCaptura]
(Inicio)=ProspectoTarea.Tarea
ProspectoTarea.Tarea=ProspectoTarea.EsFinal
ProspectoTarea.EsFinal=ProspectoTarea.Orden
ProspectoTarea.Orden=(Fin)
