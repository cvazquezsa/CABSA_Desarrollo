[Forma]
Clave=EmpresaDireccionFiscal
Nombre=Empresas - Direcciones Fiscales
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=223
PosicionInicialArriba=101
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
Menus=S
PosicionCol1=331
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Info.Accion, <T>No Mapeados<T>) <BR>EjecutarSQL(<T>EXEC spEmpresaDireccionFiscalActualizar<T>)
MenuPrincipal=&Configuración
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Empresas
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaDireccionFiscal
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=EmpresaDireccionFiscal.Icono
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
FiltroTipo=General
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
ListaOrden=EmpresaDireccionFiscal.Empresa<TAB>(Acendente)
MenuLocal=S
PermiteLocalizar=S
ListaAcciones=(Lista)

FiltroSituacionTodo=S
IconosSeleccionMultiple=S


ListaEnCaptura=(Lista)
IconosNombre=EmpresaDireccionFiscal:EmpresaDireccionFiscal.Empresa
FiltroGeneral=1 = 1<BR>{SI Info.Accion = <T>Mapeados<T> ENTONCES <T> AND Mapeado = 1<T> SINO <T><T>}  {SI Info.Accion = <T>No Mapeados<T> ENTONCES <T> AND Mapeado = 0<T> SINO <T><T>}
[Lista.Columnas]
0=108
1=180

2=173
3=108
4=-2
5=110
6=109
7=113
8=-2
9=112
10=102
11=-2
12=113
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


Antes=S
ActivoCondicion=Info.Accion <> <T>Mapeados<T>
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





































Expresion=RegistrarSeleccion<BR>EjecutarSQL(<T>spEmpresaDireccionFiscalMapear :nEstacion<T>, EstacionTrabajo)<BR>ActualizarVista<BR>ActualizarForma
[Lista.Empresa.Nombre]
Carpeta=Lista
Clave=Empresa.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Empresa.Direccion]
Carpeta=Lista
Clave=Empresa.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Empresa.DireccionNumero]
Carpeta=Lista
Clave=Empresa.DireccionNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Empresa.DireccionNumeroInt]
Carpeta=Lista
Clave=Empresa.DireccionNumeroInt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Lista.Empresa.Delegacion]
Carpeta=Lista
Clave=Empresa.Delegacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
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

[Lista.Empresa.Colonia]
Carpeta=Lista
Clave=Empresa.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
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

[Lista.Empresa.Poblacion]
Carpeta=Lista
Clave=Empresa.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
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

[Lista.Empresa.Estado]
Carpeta=Lista
Clave=Empresa.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
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

[Lista.Empresa.Pais]
Carpeta=Lista
Clave=Empresa.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
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









[Lista.Empresa.CodigoPostal]
Carpeta=Lista
Clave=Empresa.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.EmpresaDireccionFiscal.ClaveCP]
Carpeta=Lista
Clave=EmpresaDireccionFiscal.ClaveCP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco



























[(Carpeta Abrir).Columnas]
0=138
1=332
2=-2










[Acciones.Editar]
Nombre=Editar
Boton=0
Menu=&Configuración
NombreDesplegar=&Empresas
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

















ConCondicion=S
Antes=S




Expresion=FormaPos(<T>Empresa<T>, Info.Empresa)<BR>ActualizarVista
EjecucionCondicion=ConDatos(EmpresaDireccionFiscal:EmpresaDireccionFiscal.Empresa)
AntesExpresiones=Asigna(Info.Empresa, EmpresaDireccionFiscal:EmpresaDireccionFiscal.Empresa)
[Acciones.Abrir]
Nombre=Abrir
Boton=0
NombreDesplegar=&Configuración
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Antes=S
Visible=S

Expresion=FormaPos(<T>Empresa<T>, Info.Empresa)<BR>ActualizarVista
EjecucionCondicion=ConDatos(EmpresaDireccionFiscal:EmpresaDireccionFiscal.Empresa)
AntesExpresiones=Asigna(Info.Empresa, EmpresaDireccionFiscal:EmpresaDireccionFiscal.Empresa)




[Lista.ListaEnCaptura]
(Inicio)=Empresa.Nombre
Empresa.Nombre=Empresa.Direccion
Empresa.Direccion=Empresa.DireccionNumero
Empresa.DireccionNumero=Empresa.DireccionNumeroInt
Empresa.DireccionNumeroInt=Empresa.Delegacion
Empresa.Delegacion=MunicipioDescripcion
MunicipioDescripcion=Empresa.Colonia
Empresa.Colonia=ColoniaDescripcion
ColoniaDescripcion=Empresa.CodigoPostal
Empresa.CodigoPostal=EmpresaDireccionFiscal.ClaveCP
EmpresaDireccionFiscal.ClaveCP=Empresa.Poblacion
Empresa.Poblacion=LocalidadDescripcion
LocalidadDescripcion=Empresa.Estado
Empresa.Estado=EstadoDescripcion
EstadoDescripcion=Empresa.Pais
Empresa.Pais=PaisDescripcion
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












[Acciones.ComercioExt]
Nombre=ComercioExt
Boton=0
Menu=&Configuración
NombreDesplegar=Comercio Exterior
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EmpresaCE
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(EmpresaDireccionFiscal:EmpresaDireccionFiscal.Empresa)
Antes=S
AntesExpresiones=Asigna(Info.Empresa, EmpresaDireccionFiscal:EmpresaDireccionFiscal.Empresa)
Visible=S









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
Editar=ComercioExt
ComercioExt=(Fin)
