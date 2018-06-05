
[Forma]
Clave=ProyClavePresupuestalRegla
Icono=0
Modulos=(Todos)
Nombre=Reglas de Claves Presupuestales

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=334
PosicionInicialAncho=678
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=386
PosicionInicialArriba=207
ListaAcciones=(Lista)
Comentarios=Info.Proyecto
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyClavePresupuestalRegla
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

BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
OtroOrden=S
ListaOrden=ProyClavePresupuestalRegla.Orden<TAB>(Acendente)
HojaAjustarColumnas=S
FiltroGeneral=ProyClavePresupuestalRegla.Proyecto = <T>{Info.Proyecto}<T>
[Lista.ProyClavePresupuestalRegla.Orden]
Carpeta=Lista
Clave=ProyClavePresupuestalRegla.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ProyClavePresupuestalRegla.Mascara]
Carpeta=Lista
Clave=ProyClavePresupuestalRegla.Mascara
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ProyClavePresupuestalRegla.Tipo]
Carpeta=Lista
Clave=ProyClavePresupuestalRegla.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ProyClavePresupuestalRegla.Estatus]
Carpeta=Lista
Clave=ProyClavePresupuestalRegla.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Columnas]
Orden=39
Mascara=167
Tipo=124
Estatus=94

Descripcion=218
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S








[Acciones.Vigencia]
Nombre=Vigencia
Boton=53
NombreEnBoton=S
NombreDesplegar=&Vigencia
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProyClavePresupuestalReglaVig
Activo=S
Visible=S



Antes=S














AntesExpresiones=Asigna(Info.ID, ProyClavePresupuestalRegla:ProyClavePresupuestalRegla.RID)<BR>Asigna(Info.Descripcion,ProyClavePresupuestalRegla:ProyClavePresupuestalRegla.Descripcion)
[Lista.ProyClavePresupuestalRegla.Descripcion]
Carpeta=Lista
Clave=ProyClavePresupuestalRegla.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




[Lista.ListaEnCaptura]
(Inicio)=ProyClavePresupuestalRegla.Orden
ProyClavePresupuestalRegla.Orden=ProyClavePresupuestalRegla.Mascara
ProyClavePresupuestalRegla.Mascara=ProyClavePresupuestalRegla.Descripcion
ProyClavePresupuestalRegla.Descripcion=ProyClavePresupuestalRegla.Tipo
ProyClavePresupuestalRegla.Tipo=ProyClavePresupuestalRegla.Estatus
ProyClavePresupuestalRegla.Estatus=(Fin)







[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Vigencia
Vigencia=(Fin)
