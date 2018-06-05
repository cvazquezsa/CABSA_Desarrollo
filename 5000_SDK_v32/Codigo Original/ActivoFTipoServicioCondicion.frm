
[Forma]
Clave=ActivoFTipoServicioCondicion
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Condiciones para Generar Servicios
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Condiciones
CarpetaPrincipal=Condiciones
PosicionInicialAlturaCliente=273
PosicionInicialAncho=686
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=377
PosicionInicialArriba=300
Comentarios=<T>Tipo: <T> + Info.Tipo + <T>           Servicio: <T> + Info.Servicio
ListaAcciones=Guardar
[Condiciones]
Estilo=Hoja
Clave=Condiciones
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFTipoServicioCondicion
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


FiltroGeneral=ActivoFTipoServicioCondicion.Tipo = {Comillas(Info.Tipo)}<BR>AND ActivoFTipoServicioCondicion.Servicio = {Comillas(Info.Servicio)}
[Condiciones.ActivoFTipoServicioCondicion.Orden]
Carpeta=Condiciones
Clave=ActivoFTipoServicioCondicion.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.ActivoFTipoServicioCondicion.Operador]
Carpeta=Condiciones
Clave=ActivoFTipoServicioCondicion.Operador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=1
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.ActivoFTipoServicioCondicion.Indicador]
Carpeta=Condiciones
Clave=ActivoFTipoServicioCondicion.Indicador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.ActivoFTipoServicioCondicion.Condicion]
Carpeta=Condiciones
Clave=ActivoFTipoServicioCondicion.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.ActivoFTipoServicioCondicion.Valor]
Carpeta=Condiciones
Clave=ActivoFTipoServicioCondicion.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.ActivoFTipoServicioCondicion.Valor2]
Carpeta=Condiciones
Clave=ActivoFTipoServicioCondicion.Valor2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Condiciones.Columnas]
Servicio=126
Orden=64
Operador=61
Indicador=181
Condicion=124
Valor=105
Valor2=116








[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Condiciones.ListaEnCaptura]
(Inicio)=ActivoFTipoServicioCondicion.Indicador
ActivoFTipoServicioCondicion.Indicador=ActivoFTipoServicioCondicion.Condicion
ActivoFTipoServicioCondicion.Condicion=ActivoFTipoServicioCondicion.Valor
ActivoFTipoServicioCondicion.Valor=ActivoFTipoServicioCondicion.Valor2
ActivoFTipoServicioCondicion.Valor2=ActivoFTipoServicioCondicion.Operador
ActivoFTipoServicioCondicion.Operador=ActivoFTipoServicioCondicion.Orden
ActivoFTipoServicioCondicion.Orden=(Fin)
