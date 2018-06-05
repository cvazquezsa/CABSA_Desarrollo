
[Forma]
Clave=OfertaCascadaGrupo
Icono=0
Modulos=(Todos)

MovModulo=OFER
Nombre=Cascada Por Grupo
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=606
PosicionInicialArriba=363
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraHerramientas=S
ListaAcciones=Aceptar
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
[Forma.Modulos]
(Inicio)=(Todos)
(Todos)=OFER
OFER=(Fin)

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OfertaCascadaGrupo
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
PermiteEditar=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CondicionEdicion=Info.Estatus=<T>SINAFECTAR<T>
FiltroGeneral=OfertaCascadaGrupo.ID={Info.ID}
[Lista.OfertaCascadaGrupo.Desde]
Carpeta=Lista
Clave=OfertaCascadaGrupo.Desde
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.OfertaCascadaGrupo.Hasta]
Carpeta=Lista
Clave=OfertaCascadaGrupo.Hasta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.OfertaCascadaGrupo.Porcentaje]
Carpeta=Lista
Clave=OfertaCascadaGrupo.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
Desde=64
Hasta=64
Porcentaje=64




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


[Lista.ListaEnCaptura]
(Inicio)=OfertaCascadaGrupo.Desde
OfertaCascadaGrupo.Desde=OfertaCascadaGrupo.Hasta
OfertaCascadaGrupo.Hasta=OfertaCascadaGrupo.Porcentaje
OfertaCascadaGrupo.Porcentaje=(Fin)





































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
