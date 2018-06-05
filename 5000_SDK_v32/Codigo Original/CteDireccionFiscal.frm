[Forma]
Clave=CteDireccionFiscal
Nombre=Clientes - Direcciones Fiscales
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
Comentarios=Si(no Usuario.ConsultarClientesOtrosAgentes, e(<T>Agente<T>)+<T>: <T>+Usuario.DefAgente)
PosicionSec1=435
PosicionCol1=315

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Info.Accion, <T>No Mapeados<T>) <BR>EjecutarSQL(<T>EXEC spCteDireccionFiscalActualizar<T>)
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
Vista=CteDireccionFiscal
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
Filtros=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CteCat
FiltroPredefinido=S
FiltroAplicaEn=Cte.Categoria
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroNullNombre=(sin categoría)
FiltroRespetar=S
FiltroAncho=20
FiltroFechasNormal=S
FiltroListas=S
FiltroListasRama=CXC
FiltroListasAplicaEn=Cte.Cliente
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=CteFam
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CteGrupo
FiltroAplicaEn1=Cte.Categoria
FiltroAplicaEn2=Cte.Familia
FiltroAplicaEn3=Cte.Grupo
PermiteLocalizar=S
FiltroEstatusDefault=(Todos)
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=Agente
FiltroAplicaEn4=Cte.Agente
FiltroSituacionTodo=S
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=CteTipo
FiltroAplicaEn5=Cte.Tipo
FiltroGrupo6=(Validaciones Memoria)
FiltroValida6=Espacio
FiltroAplicaEn6=Cte.Espacio
OtroOrden=S
ListaOrden=CteDireccionFiscal.Cliente<TAB>(Acendente)

PestanaOtroNombre=S
PestanaNombre=Clientes
IconosCampo=CteDireccionFiscal.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Cliente<T>
ElementosPorPaginaEsp=200
IconosConSenales=S
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=CteDireccionFiscal:CteDireccionFiscal.Cliente
FiltroGeneral=Cte.Tipo<><T>Estructura<T><BR>{Si(no Usuario.ConsultarClientesOtrosAgentes, <T> AND Cte.Agente=<T>+Comillas(Usuario.DefAgente), <T><T>)}<BR>{SI Info.Accion = <T>Mapeados<T> ENTONCES <T> AND Mapeado = 1<T> SINO <T><T>}  {SI Info.Accion = <T>No Mapeados<T> ENTONCES <T> AND Mapeado = 0<T> SINO <T><T>}
[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Cliente=117
Nombre=293
0=104
1=162
RFC=107


ClaveCP=80
ClaveEstado=82
ClaveMunicipio=94
ClaveLocalidad=96
HusoHorario=78
Descripcion=362
VeranoMesInicio=99
VeranoDiaInicio=116
VeranoHoraInicio=104
VeranoDiferenciaHoraria=139
InviernoMesInicio=101
InviernoDiaInicio=105
InviernoHoraInicio=108
InviernoDiferenciaHoraria=139
ClaveColonia=84
SATCatCP.ClaveCP=104
SATCatCP.ClaveMunicipio=82
SATMunicipio.Descripcion=123
SATCatCP.ClaveLocalidad=83
SATLocalidad.Descripcion=137
SATColonia.ClaveColonia=82
SATColonia.Descripcion=296
2=111
3=132
4=92
5=-2
6=119
7=94
8=171
9=93
10=89
11=102
12=113
13=90
14=109
15=82
16=61
17=-2
SATEstado.Descripcion=129
FiscalRegimen=124
Extranjero=64
[Acciones.CteInfo]
Nombre=CteInfo
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteInfo
Antes=S
Visible=S
ConCondicion=S



EspacioPrevio=S
ActivoCondicion=Usuario.CteInfo
EjecucionCondicion=ConDatos(CteDireccionFiscal:CteDireccionFiscal.Cliente) y ((CteDireccionFiscal:Cte.Tipo<><T>Deudor<T>) o Usuario.VerInfoDeudores)
AntesExpresiones=Asigna(Info.Cliente, CteDireccionFiscal:CteDireccionFiscal.Cliente)
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
[Lista.Cte.RFC]
Carpeta=Lista
Clave=Cte.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


































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







[Acciones.EnviarA]
Nombre=EnviarA
Boton=16
NombreDesplegar=&Sucursales
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteEnviarADireccionFiscal
Visible=S



ConCondicion=S
Antes=S
DespuesGuardar=S











ActivoCondicion=CteDireccionFiscal:Cte.Tipo<><T>Estructura<T>
EjecucionCondicion=ConDatos(CteDireccionFiscal:CteDireccionFiscal.Cliente)
AntesExpresiones=Asigna(Info.Cliente,CteDireccionFiscal:CteDireccionFiscal.Cliente)<BR>Asigna(Info.Nombre,CteDireccionFiscal:Cte.Nombre)
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





[Lista.Cte.Direccion]
Carpeta=Lista
Clave=Cte.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Cte.DireccionNumero]
Carpeta=Lista
Clave=Cte.DireccionNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Cte.DireccionNumeroInt]
Carpeta=Lista
Clave=Cte.DireccionNumeroInt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Cte.Delegacion]
Carpeta=Lista
Clave=Cte.Delegacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Lista.Cte.Colonia]
Carpeta=Lista
Clave=Cte.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Lista.Cte.CodigoPostal]
Carpeta=Lista
Clave=Cte.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.CteDireccionFiscal.ClaveCP]
Carpeta=Lista
Clave=CteDireccionFiscal.ClaveCP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.Cte.Poblacion]
Carpeta=Lista
Clave=Cte.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Lista.Cte.Estado]
Carpeta=Lista
Clave=Cte.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[Lista.Cte.Pais]
Carpeta=Lista
Clave=Cte.Pais
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




































Expresion=RegistrarSeleccion<BR>EjecutarSQL(<T>spCteDireccionFiscalMapear :nEstacion<T>, EstacionTrabajo)<BR>ActualizarVista<BR>ActualizarForma
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














[UsoServicio.Columnas]
Servicio=293
Fecha=94
Porcentaje=38
Evaluacion=87
Observaciones=189

[FormaExtraValor.Columnas]
VerCampo=346
VerValor=364

[SituacionCta.Columnas]
0=188
1=148
2=-2
3=-2
4=-2

[(Carpeta Abrir).Columnas]
0=106
1=283


















[Acciones.Editar]
Nombre=Editar
Boton=0
Menu=&Configuración
NombreDesplegar=&Cliente
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S















































ConCondicion=S
Antes=S







Expresion=Forma(<T>CteSAT<T>)<BR>ActualizarVista
EjecucionCondicion=ConDatos(CteDireccionFiscal:CteDireccionFiscal.Cliente)
AntesExpresiones=Asigna(Info.Cliente, CteDireccionFiscal:CteDireccionFiscal.Cliente)
[Acciones.CfgCliente]
Nombre=CfgCliente
Boton=0
NombreDesplegar=&Configuración
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Antes=S
Visible=S

EspacioPrevio=S





Expresion=Forma(<T>CteSAT<T>)<BR>ActualizarVista
EjecucionCondicion=ConDatos(CteDireccionFiscal:CteDireccionFiscal.Cliente)
AntesExpresiones=Asigna(Info.Cliente, CteDireccionFiscal:CteDireccionFiscal.Cliente)






[Lista.ListaEnCaptura]
(Inicio)=Cte.Nombre
Cte.Nombre=Cte.RFC
Cte.RFC=Cte.Direccion
Cte.Direccion=Cte.DireccionNumero
Cte.DireccionNumero=Cte.DireccionNumeroInt
Cte.DireccionNumeroInt=Cte.Delegacion
Cte.Delegacion=MunicipioDescripcion
MunicipioDescripcion=Cte.Colonia
Cte.Colonia=ColoniaDescripcion
ColoniaDescripcion=Cte.CodigoPostal
Cte.CodigoPostal=CteDireccionFiscal.ClaveCP
CteDireccionFiscal.ClaveCP=Cte.Poblacion
Cte.Poblacion=LocalidadDescripcion
LocalidadDescripcion=Cte.Estado
Cte.Estado=EstadoDescripcion
EstadoDescripcion=Cte.Pais
Cte.Pais=PaisDescripcion
PaisDescripcion=(Fin)

[Lista.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=CfgCliente
CfgCliente=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=CteInfo
CteInfo=EnviarA
EnviarA=Personalizar
Personalizar=Mapeados
Mapeados=NoMapeados
NoMapeados=Todos
Todos=Mapear
Mapear=Editar
Editar=(Fin)
