
[Forma]
Clave=WebEstatusExistencia
Icono=0
Modulos=(Todos)
Nombre=Estatus por Existencia

ListaCarpetas=WebEstatusExistencia
CarpetaPrincipal=WebEstatusExistencia
PosicionInicialAlturaCliente=376
PosicionInicialAncho=1056
PosicionInicialIzquierda=336
PosicionInicialArriba=378
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
BarraHerramientas=S
MovModulo=(Todos)
Comentarios=Lista(Info.Sucursal)
[WebEstatusExistencia]
Estilo=Hoja
Clave=WebEstatusExistencia
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebEstatusExistencia
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
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
PermiteEditar=S
ListaOrden=WebEstatusExistencia.WebEstatusExistencia<TAB>(Acendente)
HojaAjustarColumnas=S
FiltroGeneral=WebEstatusExistencia.Sucursal = {Info.Sucursal}
[WebEstatusExistencia.WebEstatusExistencia.WebEstatusExistencia]
Carpeta=WebEstatusExistencia
Clave=WebEstatusExistencia.WebEstatusExistencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WebEstatusExistencia.WebEstatusExistencia.Descripcion]
Carpeta=WebEstatusExistencia
Clave=WebEstatusExistencia.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[WebEstatusExistencia.WebEstatusExistencia.EntregaDias]
Carpeta=WebEstatusExistencia
Clave=WebEstatusExistencia.EntregaDias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WebEstatusExistencia.WebEstatusExistencia.VentaPermitir]
Carpeta=WebEstatusExistencia
Clave=WebEstatusExistencia.VentaPermitir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WebEstatusExistencia.Columnas]
WebEstatusExistencia=124
Descripcion=604
EntregaDias=80
VentaPermitir=71






Periodo=124
PeriodoEntrega=124
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S
EnBarraHerramientas=S






















[WebEstatusExistencia.WebEstatusExistencia.PeriodoEntrega]
Carpeta=WebEstatusExistencia
Clave=WebEstatusExistencia.PeriodoEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[WebEstatusExistencia.ListaEnCaptura]
(Inicio)=WebEstatusExistencia.WebEstatusExistencia
WebEstatusExistencia.WebEstatusExistencia=WebEstatusExistencia.Descripcion
WebEstatusExistencia.Descripcion=WebEstatusExistencia.EntregaDias
WebEstatusExistencia.EntregaDias=WebEstatusExistencia.VentaPermitir
WebEstatusExistencia.VentaPermitir=WebEstatusExistencia.PeriodoEntrega
WebEstatusExistencia.PeriodoEntrega=(Fin)
