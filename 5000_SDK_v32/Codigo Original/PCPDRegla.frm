
[Forma]
Clave=PCPDRegla
Icono=0
Modulos=(Todos)
Nombre=Regla Clave Presupuestal

ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=Aceptar
Comentarios=Lista(Info.Descripcion)
PosicionInicialIzquierda=477
PosicionInicialArriba=185
PosicionInicialAlturaCliente=316
PosicionInicialAncho=326
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PCPDRegla
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

CondicionEdicion=(Info.Estatus = EstatusBorrador) O (Info.Estatus = EstatusSinAfectar) O (Info.Estatus = EstatusPorConfirmar)
FiltroGeneral=PCPDRegla.ID = {Info.ID} AND PCPDRegla.Renglon = {Info.Renglon}
[Lista.PCPDRegla.FechaD]
Carpeta=Lista
Clave=PCPDRegla.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.PCPDRegla.FechaA]
Carpeta=Lista
Clave=PCPDRegla.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.PCPDRegla.MascaraFecha]
Carpeta=Lista
Clave=PCPDRegla.MascaraFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S




[Lista.Columnas]
FechaD=94
FechaA=94
MascaraFecha=105













[Lista.ListaEnCaptura]
(Inicio)=PCPDRegla.FechaD
PCPDRegla.FechaD=PCPDRegla.FechaA
PCPDRegla.FechaA=PCPDRegla.MascaraFecha
PCPDRegla.MascaraFecha=(Fin)
