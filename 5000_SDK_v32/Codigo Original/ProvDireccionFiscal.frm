[Forma]
Clave=ProvDireccionFiscal
Nombre=Proveedores - Direcciones Fiscales
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=226
PosicionInicialArriba=97
PosicionInicialAltura=504
PosicionInicialAncho=913
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=495

VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Info.Accion, <T>No Mapeados<T>) <BR>EjecutarSQL(<T>EXEC spProvDireccionFiscalActualizar<T>)
Menus=S
MenuPrincipal=&Configuración
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Proveedores
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProvDireccionFiscal
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=ProvDireccionFiscal.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ProvCat
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ProvFam
FiltroAplicaEn1=Prov.Categoria
FiltroAplicaEn2=Prov.Familia
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=25
FiltroListas=S
FiltroListasRama=CXP
FiltroListasAplicaEn=Prov.Proveedor
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
FiltroTodo=S
FiltroTodoFinal=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=BAJA
OtroOrden=S
ListaOrden=ProvDireccionFiscal.Proveedor<TAB>(Acendente)
MenuLocal=S
PermiteLocalizar=S
ListaAcciones=(Lista)

FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ProvTipo
FiltroAplicaEn3=Prov.Tipo
FiltroSituacionTodo=S
FiltroArbol=Proveedores
FiltroArbolAplica=Prov.Rama
IconosSeleccionMultiple=S
IconosNombre=ProvDireccionFiscal:ProvDireccionFiscal.Proveedor
FiltroGeneral=1 = 1<BR>{SI Info.Accion = <T>Mapeados<T> ENTONCES <T> AND Mapeado = 1<T> SINO <T><T>}  {SI Info.Accion = <T>No Mapeados<T> ENTONCES <T> AND Mapeado = 0<T> SINO <T><T>}
[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Prov.Tipo]
Carpeta=Lista
Clave=Prov.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Columnas]
0=108
1=216

2=83
3=181
4=-2
5=-2
6=104
7=-2
8=-2
9=135
10=93
11=-2
12=-2
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

[Acciones.ProvInfo]
Nombre=ProvInfo
Boton=34
NombreDesplegar=Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S






EjecucionCondicion=ConDatos(ProvDireccionFiscal:ProvDireccionFiscal.Proveedor)
AntesExpresiones=Asigna(Info.Proveedor, ProvDireccionFiscal:ProvDireccionFiscal.Proveedor)
[Acciones.MovProv]
Nombre=MovProv
Boton=25
NombreDesplegar=Generar &Movimientos...
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovProv
ConCondicion=S
Antes=S
Visible=S


ActivoCondicion=Usuario.ProvMov
EjecucionCondicion=ConDatos(ProvDireccionFiscal:ProvDireccionFiscal.Proveedor)
AntesExpresiones=Asigna(Info.Proveedor, ProvDireccionFiscal:ProvDireccionFiscal.Proveedor)<BR>Asigna(Info.Nombre, ProvDireccionFiscal:Prov.Nombre)
[Acciones.Mensajes]
Nombre=Mensajes
Boton=112
NombreDesplegar=&Mensajes
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=OutlookProv
Activo=S
ConCondicion=S
Antes=S
Visible=S







EjecucionCondicion=ConDatos(ProvDireccionFiscal:ProvDireccionFiscal.Proveedor)
AntesExpresiones=Asigna(Info.Proveedor, ProvDireccionFiscal:ProvDireccionFiscal.Proveedor)
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












[Lista.Prov.Direccion]
Carpeta=Lista
Clave=Prov.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Prov.DireccionNumero]
Carpeta=Lista
Clave=Prov.DireccionNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Prov.DireccionNumeroInt]
Carpeta=Lista
Clave=Prov.DireccionNumeroInt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Prov.Colonia]
Carpeta=Lista
Clave=Prov.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Prov.CodigoPostal]
Carpeta=Lista
Clave=Prov.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Prov.Delegacion]
Carpeta=Lista
Clave=Prov.Delegacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Prov.Poblacion]
Carpeta=Lista
Clave=Prov.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Prov.Estado]
Carpeta=Lista
Clave=Prov.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.Prov.Pais]
Carpeta=Lista
Clave=Prov.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco








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

[Lista.ProvDireccionFiscal.ClaveCP]
Carpeta=Lista
Clave=ProvDireccionFiscal.ClaveCP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
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


ActivoCondicion=Info.Accion <>  <T>No Mapeados<T>
Antes=S
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






























Expresion=RegistrarSeleccion<BR>EjecutarSQL(<T>spProvDireccionFiscalMapear :nEstacion<T>, EstacionTrabajo)<BR>ActualizarVista<BR>ActualizarForma




[Acciones.Abrir]
Nombre=Abrir
Boton=0
NombreDesplegar=&Configuración
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

EspacioPrevio=S




ConCondicion=S
Antes=S
Expresion=Forma(<T>ProvSAT<T>)<BR>ActualizarVista
EjecucionCondicion=ConDatos(ProvDireccionFiscal:ProvDireccionFiscal.Proveedor)
AntesExpresiones=Asigna(Info.Proveedor, ProvDireccionFiscal:ProvDireccionFiscal.Proveedor)
[FormaExtraValor.Columnas]
VerCampo=278
VerValor=303

[SituacionCta.Columnas]
0=188
1=148
2=-2
3=-2
4=-2

[(Carpeta Abrir).Columnas]
0=114
1=362





[Lista.ListaEnCaptura]
(Inicio)=Prov.Nombre
Prov.Nombre=Prov.Tipo
Prov.Tipo=Prov.Direccion
Prov.Direccion=Prov.DireccionNumero
Prov.DireccionNumero=Prov.DireccionNumeroInt
Prov.DireccionNumeroInt=Prov.Delegacion
Prov.Delegacion=MunicipioDescripcion
MunicipioDescripcion=Prov.Colonia
Prov.Colonia=ColoniaDescripcion
ColoniaDescripcion=Prov.CodigoPostal
Prov.CodigoPostal=ProvDireccionFiscal.ClaveCP
ProvDireccionFiscal.ClaveCP=Prov.Poblacion
Prov.Poblacion=LocalidadDescripcion
LocalidadDescripcion=Prov.Estado
Prov.Estado=EstadoDescripcion
EstadoDescripcion=Prov.Pais
Prov.Pais=PaisDescripcion
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


[Acciones.Editar]
Nombre=Editar
Boton=0
Menu=&Configuración
NombreDesplegar=&Proveedor
EnMenu=S
TipoAccion=Expresion
Expresion=Forma(<T>ProvSAT<T>)<BR>ActualizarVista
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ProvDireccionFiscal:ProvDireccionFiscal.Proveedor)
Antes=S
AntesExpresiones=Asigna(Info.Proveedor,ProvDireccionFiscal:ProvDireccionFiscal.Proveedor)
Visible=S





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=ProvInfo
ProvInfo=Mensajes
Mensajes=MovProv
MovProv=Campos
Campos=Mapeados
Mapeados=NoMapeados
NoMapeados=Todos
Todos=Mapear
Mapear=Editar
Editar=(Fin)
