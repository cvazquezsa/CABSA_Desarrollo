
[Forma]
Clave=TarjetaMonedero
Icono=67
Modulos=(Todos)
Nombre=Monedero Electrónico
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=404
PosicionInicialArriba=321
PosicionInicialAlturaCliente=93
PosicionInicialAncho=565
BarraAyuda=S
BarraAyudaBold=S
DialogoAbrir=S
Menus=S
ListaAcciones=(Lista)
MenuPrincipal=&Archivo
[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TarjetaMonedero
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TarjetaMonedero.Serie<BR>TarjetaMonedero.FechaAlta<BR>TarjetaMonedero.FechaActivacion<BR>TarjetaMonedero.FechaBaja
CarpetaVisible=S

CondicionEdicion=no TarjetaMonedero:TarjetaMonedero.TieneMovimientos
[Lista.TarjetaMonedero.Serie]
Carpeta=Lista
Clave=TarjetaMonedero.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.TarjetaMonedero.FechaAlta]
Carpeta=Lista
Clave=TarjetaMonedero.FechaAlta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Lista.TarjetaMonedero.FechaActivacion]
Carpeta=Lista
Clave=TarjetaMonedero.FechaActivacion
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Lista.TarjetaMonedero.FechaBaja]
Carpeta=Lista
Clave=TarjetaMonedero.FechaBaja
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Monedero Electrónico
Clave=(Carpeta Abrir)
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=TarjetaMonederoA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Monedero Electrónico<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Negro
ListaOrden=TarjetaMonedero.Serie<TAB>(Acendente)<BR>TarjetaMonedero.FechaAlta<TAB>(Acendente)
FiltroEstatus=S
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Todos)<BR>ALTA<BR>ACTIVA<BR>BAJA
FiltroEstatusDefault=ALTA
FiltroUsuarioDefault=(Todos)
FiltroFechasCampo=TarjetaMonedero.FechaAlta
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S

RefrescarAlEntrar=S
IconosNombre=TarjetaMonederoA:TarjetaMonedero.Serie
[(Carpeta Abrir).Columnas]
0=-2

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S

[Acciones.Abrir]
Nombre=Abrir
Boton=2
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S

Menu=&Archivo
[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=Guardar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=Eliminar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
ActivoCondicion=No TarjetaMonedero:TarjetaMonedero.TieneMovimientos
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S























[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Navegador
Navegador=Cerrar
Cerrar=(Fin)
