
[Forma]
Clave=HeReorganizaSurtido
Icono=0
Modulos=(Todos)
Nombre=Reorganizar Surtidos

ListaCarpetas=fnWMSListaResurtir
CarpetaPrincipal=fnWMSListaResurtir
PosicionInicialAlturaCliente=373
PosicionInicialAncho=990
PosicionInicialIzquierda=305
PosicionInicialArriba=244
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
Comentarios=Info.Colonia
ExpresionesAlActivar=ActualizarVista

[fnWMSTablaHerramienta.Columnas]
0=190

1=119
2=-2
3=-2
4=-2
5=-2
6=-2
7=75
8=-2
9=-2











[Acciones.Filtro]
Nombre=Filtro
Boton=107
NombreEnBoton=S
NombreDesplegar=&Filtro
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=WMSFiltroSurtido
Activo=S
Visible=S




Multiple=S
ListaAccionesMultiples=(Lista)





EspacioPrevio=S

[Acciones.Filtro.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar


[Acciones.Explosiona.ListaAccionesMultiples]
(Inicio)=Explosion
Explosion=Cerrar
Cerrar=(Fin)






[WMSSurtidoProcesarD.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
































































































































[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[fnWMSTablaHerramienta.ListaEnCaptura]
(Inicio)=FechaEmision
FechaEmision=FechaRequerida
FechaRequerida=Contacto
Contacto=Direccion
Direccion=CodigoPostal
CodigoPostal=Ruta
Ruta=AndenSurtido
AndenSurtido=(Fin)












[fnWMSListaResurtir]
Estilo=Iconos
PestanaOtroNombre=S
Clave=fnWMSListaResurtir
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=fnWMSListaResurtir
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
IconosSeleccionMultiple=S
IconosCambiarOrden=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroGrupo1=Modulo
FiltroGrupo2=Ruta
FiltroGrupo3=FechaRequerida
FiltroGrupo4=FechaEmision
FiltroGrupo5=Contacto
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSucursales=S
FiltroSucursalesTodasPorOmision=S
FiltroFechasCampo=FechaRequerida
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S

IconosNombre=fnWMSListaResurtir:Mov + <T> <T> + fnWMSListaResurtir:MovID
[fnWMSListaResurtir.FechaEmision]
Carpeta=fnWMSListaResurtir
Clave=FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[fnWMSListaResurtir.FechaRequerida]
Carpeta=fnWMSListaResurtir
Clave=FechaRequerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[fnWMSListaResurtir.Contacto]
Carpeta=fnWMSListaResurtir
Clave=Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[fnWMSListaResurtir.Direccion]
Carpeta=fnWMSListaResurtir
Clave=Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[fnWMSListaResurtir.CodigoPostal]
Carpeta=fnWMSListaResurtir
Clave=CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[fnWMSListaResurtir.Ruta]
Carpeta=fnWMSListaResurtir
Clave=Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[fnWMSListaResurtir.AndenSurtido]
Carpeta=fnWMSListaResurtir
Clave=AndenSurtido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[fnWMSListaResurtir.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2
6=-2
7=-2


[Acciones.Filtro.WMSFiltroReorganizarSurtido]
Nombre=WMSFiltroReorganizarSurtido
Boton=0
TipoAccion=Formas
ClaveAccion=WMSFiltroReorganizarSurtido
Activo=S
Visible=S

[Acciones.Filtro.ListaAccionesMultiples]
(Inicio)=Aceptar
Aceptar=WMSFiltroReorganizarSurtido
WMSFiltroReorganizarSurtido=(Fin)








[Acciones.Generar]
Nombre=Generar
Boton=7
NombreDesplegar=&Reorganizar Surtidos
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

NombreEnBoton=S






Expresion=RegistrarSeleccion(<T>fnWMSListaResurtir<T>)<BR>ProcesarSQL(<T>EXEC spWMSResurtir :nEstacion, :tEmpresa<T>, EstacionTrabajo, Empresa)<BR>ActualizarVista
[fnWMSListaResurtir.ListaEnCaptura]
(Inicio)=FechaEmision
FechaEmision=FechaRequerida
FechaRequerida=Contacto
Contacto=Direccion
Direccion=CodigoPostal
CodigoPostal=Ruta
Ruta=AndenSurtido
AndenSurtido=(Fin)





































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Filtro
Filtro=Generar
Generar=(Fin)
