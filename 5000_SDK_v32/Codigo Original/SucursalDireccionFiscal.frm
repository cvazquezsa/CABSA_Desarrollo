[Forma]
Clave=SucursalDireccionFiscal
Nombre=Sucursales - Direcciones Fiscales
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=262
PosicionInicialArriba=153
PosicionInicialAltura=477
PosicionInicialAncho=915
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=514

VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Info.Accion, <T>No Mapeados<T>) <BR>EjecutarSQL(<T>EXEC spSucursalDireccionFiscalActualizar<T>)
Menus=S
PosicionCol1=331
MenuPrincipal=&Configuración
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Sucursales
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SucursalDireccionFiscal
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=SucursalDireccionFiscal.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=Todos
FiltroAncho=25
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=25
BusquedaEnLinea=S
CarpetaVisible=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=BAJA
OtroOrden=S
ListaOrden=SucursalDireccionFiscal.Sucursal<TAB>(Acendente)
MenuLocal=S
PermiteLocalizar=S
ListaAcciones=(Lista)

FiltroSituacionTodo=S
IconosSeleccionMultiple=S


ListaEnCaptura=(Lista)
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=SucursalRegion
FiltroAplicaEn1=Sucursal.Region
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoFinal=S
FiltroNull=S
IconosNombre=SucursalDireccionFiscal:SucursalDireccionFiscal.Sucursal
FiltroGeneral=1 = 1<BR>{SI Info.Accion = <T>Mapeados<T> ENTONCES <T> AND Mapeado = 1<T> SINO <T><T>}  {SI Info.Accion = <T>No Mapeados<T> ENTONCES <T> AND Mapeado = 0<T> SINO <T><T>}
[Lista.Columnas]
0=108
1=180

2=173
3=108
4=-2
5=110
6=110
7=-2
8=-2
9=135
10=111
11=-2
12=89
13=107
14=132
15=93
16=78
17=103
SATEstado.Descripcion=129
SATMunicipio.Descripcion=123
SATColonia.Descripcion=296
SATCatCP.ClaveCP=104
SATLocalidad.Descripcion=137
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S



[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S





















[Acciones.Mapeados]
Nombre=Mapeados
Boton=71
NombreEnBoton=S
NombreDesplegar=&Mapeados
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S


ActivoCondicion=Info.Accion <> <T>Mapeados<T>
Antes=S
AntesExpresiones=Asigna(Info.Accion, <T>Mapeados<T>)
[Acciones.NoMapeados]
Nombre=NoMapeados
Boton=71
NombreEnBoton=S
NombreDesplegar=&No Mapeados
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S


Antes=S
ActivoCondicion=Info.Accion <>  <T>No Mapeados<T>
AntesExpresiones=Asigna(Info.Accion, <T>No Mapeados<T>)
[Acciones.Todos]
Nombre=Todos
Boton=71
NombreEnBoton=S
NombreDesplegar=&Todos
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S


ActivoCondicion=Info.Accion <> <T>Todos<T>
Antes=S
AntesExpresiones=Asigna(Info.Accion,<T>Todos<T>)
[Acciones.Mapear]
Nombre=Mapear
Boton=70
NombreEnBoton=S
NombreDesplegar=&Mapear
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S










































Expresion=RegistrarSeleccion<BR>EjecutarSQL(<T>spSucursalDireccionFiscalMapear :nEstacion<T>, EstacionTrabajo)<BR>ActualizarVista<BR>ActualizarForma
[Lista.MunicipioDescripcion]
Carpeta=Lista
Clave=MunicipioDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Lista.ColoniaDescripcion]
Carpeta=Lista
Clave=ColoniaDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Lista.LocalidadDescripcion]
Carpeta=Lista
Clave=LocalidadDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Lista.EstadoDescripcion]
Carpeta=Lista
Clave=EstadoDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Lista.PaisDescripcion]
Carpeta=Lista
Clave=PaisDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco









[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Sucursal.Direccion]
Carpeta=Lista
Clave=Sucursal.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Sucursal.DireccionNumero]
Carpeta=Lista
Clave=Sucursal.DireccionNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Sucursal.DireccionNumeroInt]
Carpeta=Lista
Clave=Sucursal.DireccionNumeroInt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Sucursal.Delegacion]
Carpeta=Lista
Clave=Sucursal.Delegacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Sucursal.Colonia]
Carpeta=Lista
Clave=Sucursal.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.Sucursal.CodigoPostal]
Carpeta=Lista
Clave=Sucursal.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.SucursalDireccionFiscal.ClaveCP]
Carpeta=Lista
Clave=SucursalDireccionFiscal.ClaveCP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.Sucursal.Poblacion]
Carpeta=Lista
Clave=Sucursal.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.Sucursal.Estado]
Carpeta=Lista
Clave=Sucursal.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.Sucursal.Pais]
Carpeta=Lista
Clave=Sucursal.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco






































[(Carpeta Abrir).Columnas]
0=62
1=424









[Acciones.Editar]
Nombre=Editar
Boton=0
NombreDesplegar=&<T>Sucursal<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S



Menu=&Configuración







ConCondicion=S
Antes=S




Expresion=FormaPos(<T>Sucursal<T>, Info.Sucursal)<BR>ActualizarVista
EjecucionCondicion=ConDatos(SucursalDireccionFiscal:SucursalDireccionFiscal.Sucursal)
AntesExpresiones=Asigna(Info.Sucursal, SucursalDireccionFiscal:SucursalDireccionFiscal.Sucursal)
[Acciones.Abrir]
Nombre=Abrir
Boton=0
NombreDesplegar=&Configuración
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Antes=S
Visible=S

EspacioPrevio=S




Expresion=FormaPos(<T>Sucursal<T>, Info.Sucursal)<BR>ActualizarVista
EjecucionCondicion=ConDatos(SucursalDireccionFiscal:SucursalDireccionFiscal.Sucursal)
AntesExpresiones=Asigna(Info.Sucursal, SucursalDireccionFiscal:SucursalDireccionFiscal.Sucursal)




[Lista.ListaEnCaptura]
(Inicio)=Sucursal.Nombre
Sucursal.Nombre=Sucursal.Direccion
Sucursal.Direccion=Sucursal.DireccionNumero
Sucursal.DireccionNumero=Sucursal.DireccionNumeroInt
Sucursal.DireccionNumeroInt=Sucursal.Delegacion
Sucursal.Delegacion=MunicipioDescripcion
MunicipioDescripcion=Sucursal.Colonia
Sucursal.Colonia=ColoniaDescripcion
ColoniaDescripcion=Sucursal.CodigoPostal
Sucursal.CodigoPostal=SucursalDireccionFiscal.ClaveCP
SucursalDireccionFiscal.ClaveCP=Sucursal.Poblacion
Sucursal.Poblacion=LocalidadDescripcion
LocalidadDescripcion=Sucursal.Estado
Sucursal.Estado=EstadoDescripcion
EstadoDescripcion=Sucursal.Pais
Sucursal.Pais=PaisDescripcion
PaisDescripcion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos menos uno)
(Todos menos uno)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=Abrir
Abrir=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=Mapeados
Mapeados=NoMapeados
NoMapeados=Todos
Todos=Mapear
Mapear=Editar
Editar=(Fin)
