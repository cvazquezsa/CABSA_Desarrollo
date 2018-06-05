[Forma]
Clave=CteEnviarADireccionFiscal
Nombre=Sucursales del Cliente - Direcciones Fiscales
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=225
PosicionInicialArriba=88
PosicionInicialAltura=477
PosicionInicialAncho=915
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
VentanaExclusiva=S
MovModulo=CXC
PosicionInicialAlturaCliente=512
PosicionSec1=435
PosicionCol1=331

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
Comentarios=Info.Cliente
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Info.Accion, <T>No Mapeados<T>) 
Menus=S
MenuPrincipal=&Configuración
[Lista]
Estilo=Iconos
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteEnviarADireccionFiscal
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroTipo=General
FiltroTodoNombre=Todos
FiltroNullNombre=(sin categoría)
FiltroRespetar=S
FiltroFechasNormal=S
PermiteLocalizar=S
FiltroEstatusDefault=(Todos)
FiltroSituacionTodo=S
OtroOrden=S
ListaOrden=CteEnviarADireccionFiscal.ID<TAB>(Acendente)

PestanaOtroNombre=S
PestanaNombre=Sucursales del Cliente
IconosCampo=CteEnviarADireccionFiscal.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>ID<T>
ElementosPorPaginaEsp=200
IconosConSenales=S
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)

ListaEnCaptura=(Lista)
IconosNombre=CteEnviarADireccionFiscal:CteEnviarADireccionFiscal.ID
FiltroGeneral=CteEnviarADireccionFiscal.Cliente = <T>{Info.Cliente}<T><BR>{SI Info.Accion = <T>Mapeados<T> ENTONCES <T> AND Mapeado = 1<T> SINO <T><T>}  {SI Info.Accion = <T>No Mapeados<T> ENTONCES <T> AND Mapeado = 0<T> SINO <T><T>}
[Lista.Columnas]
Cliente=117
Nombre=293
0=66
1=163
RFC=107


ClaveCP=80
ClaveEstado=82
ClaveMunicipio=94
ClaveLocalidad=96
HusoHorario=78
Descripcion=156
VeranoMesInicio=99
VeranoDiaInicio=116
VeranoHoraInicio=104
VeranoDiferenciaHoraria=139
InviernoMesInicio=101
InviernoDiaInicio=105
InviernoHoraInicio=108
InviernoDiferenciaHoraria=139
ClaveColonia=84
SATCatCP.ClaveCP=79
SATCatCP.ClaveMunicipio=82
SATMunicipio.Descripcion=153
SATCatCP.ClaveLocalidad=83
SATLocalidad.Descripcion=137
SATColonia.ClaveColonia=82
SATColonia.Descripcion=205
2=109
3=127
4=92
5=-2
6=119
7=94
8=171
9=93
10=89
11=102
12=108
13=90
14=109
15=82
16=61
17=-2

[Art.Art.Articulo]
Carpeta=Art
Clave=Art.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Art.Art.Descripcion1]
Carpeta=Art
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Art.Columnas]
Articulo=124
Descripcion1=184










[Detalle.Cte.Direccion]
Carpeta=Detalle
Clave=Cte.Direccion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=54
ColorFondo=Blanco

[Detalle.Cte.DireccionNumero]
Carpeta=Detalle
Clave=Cte.DireccionNumero
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=6
ColorFondo=Blanco

Pegado=S
[Detalle.Cte.DireccionNumeroInt]
Carpeta=Detalle
Clave=Cte.DireccionNumeroInt
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=6
ColorFondo=Blanco

Pegado=S
[Detalle.Cte.CodigoPostal]
Carpeta=Detalle
Clave=Cte.CodigoPostal
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.CteDireccionFiscal.ClaveCP]
Carpeta=Detalle
Clave=CteDireccionFiscal.ClaveCP
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

EditarConBloqueo=S
[Detalle.Cte.Colonia]
Carpeta=Detalle
Clave=Cte.Colonia
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.CteDireccionFiscal.ClaveColonia]
Carpeta=Detalle
Clave=CteDireccionFiscal.ClaveColonia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

EditarConBloqueo=S
[Detalle.Cte.Delegacion]
Carpeta=Detalle
Clave=Cte.Delegacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.CteDireccionFiscal.ClaveMunicipio]
Carpeta=Detalle
Clave=CteDireccionFiscal.ClaveMunicipio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

EditarConBloqueo=S
[Detalle.Cte.Poblacion]
Carpeta=Detalle
Clave=Cte.Poblacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.CteDireccionFiscal.ClaveLocalidad]
Carpeta=Detalle
Clave=CteDireccionFiscal.ClaveLocalidad
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

EditarConBloqueo=S
[Detalle.Cte.Pais]
Carpeta=Detalle
Clave=Cte.Pais
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.CteDireccionFiscal.ClavePais]
Carpeta=Detalle
Clave=CteDireccionFiscal.ClavePais
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

EditarConBloqueo=S
[Detalle.Cte.Estado]
Carpeta=Detalle
Clave=Cte.Estado
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.CteDireccionFiscal.ClaveEstado]
Carpeta=Detalle
Clave=CteDireccionFiscal.ClaveEstado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco









EditarConBloqueo=S

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










[Detalle.SATColonia.Descripcion]
Carpeta=Detalle
Clave=SATColonia.Descripcion
3D=S
Pegado=S
Tamano=30
ColorFondo=Blanco

[Detalle.SATMunicipio.Descripcion]
Carpeta=Detalle
Clave=SATMunicipio.Descripcion
3D=S
Pegado=S
Tamano=30
ColorFondo=Blanco

[Detalle.SATLocalidad.Descripcion]
Carpeta=Detalle
Clave=SATLocalidad.Descripcion
3D=S
Pegado=S
Tamano=30
ColorFondo=Blanco

[Detalle.SATPais.Descripcion]
Carpeta=Detalle
Clave=SATPais.Descripcion
3D=S
Pegado=S
Tamano=30
ColorFondo=Blanco

[Detalle.SATEstado.Descripcion]
Carpeta=Detalle
Clave=SATEstado.Descripcion
3D=S
Pegado=S
Tamano=30
ColorFondo=Blanco








[Acciones.Mapeados]
Nombre=Mapeados
Boton=71
NombreDesplegar=&Mapeados
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S



NombreEnBoton=S




EspacioPrevio=S










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
[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)







[Acciones.Todos]
Nombre=Todos
Boton=71
NombreEnBoton=S
NombreDesplegar=&Todos
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S











Antes=S





















ActivoCondicion=Info.Accion <> <T>Todos<T>
AntesExpresiones=Asigna(Info.Accion,<T>Todos<T>)
[Detalle.ListaEnCaptura]
(Inicio)=Cte.Direccion
Cte.Direccion=Cte.DireccionNumero
Cte.DireccionNumero=Cte.DireccionNumeroInt
Cte.DireccionNumeroInt=Cte.CodigoPostal
Cte.CodigoPostal=CteDireccionFiscal.ClaveCP
CteDireccionFiscal.ClaveCP=Cte.Colonia
Cte.Colonia=CteDireccionFiscal.ClaveColonia
CteDireccionFiscal.ClaveColonia=SATColonia.Descripcion
SATColonia.Descripcion=Cte.Delegacion
Cte.Delegacion=CteDireccionFiscal.ClaveMunicipio
CteDireccionFiscal.ClaveMunicipio=SATMunicipio.Descripcion
SATMunicipio.Descripcion=Cte.Poblacion
Cte.Poblacion=CteDireccionFiscal.ClaveLocalidad
CteDireccionFiscal.ClaveLocalidad=SATLocalidad.Descripcion
SATLocalidad.Descripcion=Cte.Estado
Cte.Estado=CteDireccionFiscal.ClaveEstado
CteDireccionFiscal.ClaveEstado=SATEstado.Descripcion
SATEstado.Descripcion=Cte.Pais
Cte.Pais=CteDireccionFiscal.ClavePais
CteDireccionFiscal.ClavePais=SATPais.Descripcion
SATPais.Descripcion=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)
















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




































Expresion=RegistrarSeleccion<BR>EjecutarSQL(<T>spCteEnviarADireccionFiscalMapear :nEstacion, :tCliente<T>, EstacionTrabajo, Info.Cliente)<BR>ActualizarVista          <BR>ActualizarForma
[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
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
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S




[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=&Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S


[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=&Personalizar
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
NombreDesplegar=Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S









[Lista.CteEnviarA.Direccion]
Carpeta=Lista
Clave=CteEnviarA.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.CteEnviarA.DireccionNumero]
Carpeta=Lista
Clave=CteEnviarA.DireccionNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CteEnviarA.DireccionNumeroInt]
Carpeta=Lista
Clave=CteEnviarA.DireccionNumeroInt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CteEnviarA.Delegacion]
Carpeta=Lista
Clave=CteEnviarA.Delegacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.CteEnviarA.Colonia]
Carpeta=Lista
Clave=CteEnviarA.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.CteEnviarA.CodigoPostal]
Carpeta=Lista
Clave=CteEnviarA.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.CteEnviarA.Poblacion]
Carpeta=Lista
Clave=CteEnviarA.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.CteEnviarA.Estado]
Carpeta=Lista
Clave=CteEnviarA.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.CteEnviarA.Pais]
Carpeta=Lista
Clave=CteEnviarA.Pais
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

[Lista.CteEnviarADireccionFiscal.ClaveCP]
Carpeta=Lista
Clave=CteEnviarADireccionFiscal.ClaveCP
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































[Lista.CteEnviarA.Nombre]
Carpeta=Lista
Clave=CteEnviarA.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



















[Acciones.Editar]
Nombre=Editar
Boton=0
Menu=&Configuración
NombreDesplegar=&Sucursal del Cliente
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S





Antes=S















Expresion=Forma(<T>CteEnviarASAT<T>)<BR>ActualizarVista
AntesExpresiones=Asigna(Info.Cliente, Info.Cliente)<BR>Asigna(Info.ID, CteEnviarADireccionFiscal:CteEnviarADireccionFiscal.ID)
[Acciones.CfgCteEnviarA]
Nombre=CfgCteEnviarA
Boton=0
NombreDesplegar=&Configuración
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Antes=S
Visible=S




Expresion=Forma(<T>CteEnviarASAT<T>)<BR>ActualizarVista
EjecucionCondicion=ConDatos(Info.Cliente) y ConDatos(CteEnviarADireccionFiscal:CteEnviarADireccionFiscal.ID)
AntesExpresiones=Asigna(Info.Cliente, Info.Cliente)<BR>Asigna(Info.ID, CteEnviarADireccionFiscal:CteEnviarADireccionFiscal.ID)



[Lista.ListaEnCaptura]
(Inicio)=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Direccion
CteEnviarA.Direccion=CteEnviarA.DireccionNumero
CteEnviarA.DireccionNumero=CteEnviarA.DireccionNumeroInt
CteEnviarA.DireccionNumeroInt=CteEnviarA.Delegacion
CteEnviarA.Delegacion=MunicipioDescripcion
MunicipioDescripcion=CteEnviarA.Colonia
CteEnviarA.Colonia=ColoniaDescripcion
ColoniaDescripcion=CteEnviarA.CodigoPostal
CteEnviarA.CodigoPostal=CteEnviarADireccionFiscal.ClaveCP
CteEnviarADireccionFiscal.ClaveCP=CteEnviarA.Poblacion
CteEnviarA.Poblacion=LocalidadDescripcion
LocalidadDescripcion=CteEnviarA.Estado
CteEnviarA.Estado=EstadoDescripcion
EstadoDescripcion=CteEnviarA.Pais
CteEnviarA.Pais=PaisDescripcion
PaisDescripcion=(Fin)

[Lista.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=CfgCteEnviarA
CfgCteEnviarA=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=Mapeados
Mapeados=NoMapeados
NoMapeados=Todos
Todos=Mapear
Mapear=Editar
Editar=(Fin)
