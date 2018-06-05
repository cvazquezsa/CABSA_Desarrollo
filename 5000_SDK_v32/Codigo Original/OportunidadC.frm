
[Forma]
Clave=OportunidadC
Icono=4
Modulos=(Todos)
Nombre=<T>Consecutivos - Oportunidad<T>
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=414
PosicionInicialArriba=177
PosicionInicialAlturaCliente=336
PosicionInicialAncho=378
Comentarios=Empresa

ListaAcciones=Cerrar
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
MovModulo=OPORT
[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Hoja]
Estilo=Hoja
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadC
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
ListaEnCaptura=(Lista)

Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaOrden=(Lista)
FiltroGeneral=Sucursal={Sucursal} AND   OportunidadC.Empresa = <T>{Empresa}<T>
[Hoja.OportunidadC.Mov]
Carpeta=Hoja
Clave=OportunidadC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Hoja.OportunidadC.Consecutivo]
Carpeta=Hoja
Clave=OportunidadC.Consecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Hoja.Columnas]
Mov=128
Serie=124
Consecutivo=110



[Hoja.ListaEnCaptura]
(Inicio)=OportunidadC.Mov
OportunidadC.Mov=OportunidadC.Consecutivo
OportunidadC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=OportunidadC.Mov	(Acendente)
OportunidadC.Mov	(Acendente)=OportunidadC.Serie	(Acendente)
OportunidadC.Serie	(Acendente)=OportunidadC.Periodo	(Acendente)
OportunidadC.Periodo	(Acendente)=OportunidadC.Ejercicio	(Acendente)
OportunidadC.Ejercicio	(Acendente)=(Fin)
