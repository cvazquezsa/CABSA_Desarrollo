[Forma]
Clave=PersonalDireccionFiscal
Nombre=Personal - Direcciones Fiscales
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=283
PosicionInicialArriba=100
PosicionInicialAltura=504
PosicionInicialAncho=908
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=502

VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)<BR>Asigna(Info.Accion, <T>No Mapeados<T>) <BR>EjecutarSQL(<T>EXEC spPersonalDireccionFiscalActualizar<T>)
Menus=S
PosicionCol1=331
MenuPrincipal=&Configuración
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Personas
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalDireccionFiscal
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=PersonalDireccionFiscal.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=25
FiltroListasRama=RH
FiltroListasAplicaEn=Personal.Personal
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=25
BusquedaEnLinea=S
CarpetaVisible=S
FiltroTodo=S
FiltroTodoFinal=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
MenuLocal=S
PermiteLocalizar=S
ListaAcciones=(Lista)
OtroOrden=S
ListaOrden=Personal.ApellidoPaterno<TAB>(Acendente)
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=PersonalCat
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=PersonalGrupo
FiltroAplicaEn3=Personal.Categoria
FiltroAplicaEn4=Personal.Grupo
FiltroListas=S
FiltroFechas=S
FiltroFechasCampo=Personal.VencimientoContrato
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
FiltroFechasNombre=&Vencimiento
FiltroUENs=S
FiltroUENsCampo=Personal.UEN
FiltroSucursales=S

FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=PersonalTipo
FiltroAplicaEn5=Personal.Tipo
IconosSeleccionMultiple=S
IconosNombre=PersonalDireccionFiscal:PersonalDireccionFiscal.Personal
FiltroGeneral=1 = 1<BR>{SI Info.Accion = <T>Mapeados<T> ENTONCES <T> AND Mapeado = 1<T> SINO <T><T>}  {SI Info.Accion = <T>No Mapeados<T> ENTONCES <T> AND Mapeado = 0<T> SINO <T><T>}
[Lista.Personal.Tipo]
Carpeta=Lista
Clave=Personal.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
0=108
1=241

2=84
3=177
4=102
5=95
6=102
7=103
8=106
9=124
10=102
11=104
12=98
13=115
14=108
15=98
16=95
17=101
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





[Lista.NombreCompleto]
Carpeta=Lista
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Acciones.Mensajes]
Nombre=Mensajes
Boton=112
NombreDesplegar=&Mensajes
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=OutlookPersonal
Activo=S
ConCondicion=S
Antes=S
Visible=S

EjecucionCondicion=ConDatos(PersonalDireccionFiscal:PersonalDireccionFiscal.Personal)
AntesExpresiones=Asigna(Info.Personal, PersonalDireccionFiscal:PersonalDireccionFiscal.Personal)
[Acciones.PersonalInfo]
Nombre=PersonalInfo
Boton=34
NombreDesplegar=Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PersonalInfo
Activo=S
Visible=S
ConCondicion=S
Antes=S





EjecucionCondicion=ConDatos(PersonalDireccionFiscal:PersonalDireccionFiscal.Personal)
AntesExpresiones=Asigna(Info.Personal, PersonalDireccionFiscal:PersonalDireccionFiscal.Personal)
[Lista.ListaOrden]
(Inicio)=Personal.ApellidoPaterno<TAB>(Acendente)
Personal.ApellidoPaterno<TAB>(Acendente)=Personal.ApellidoMaterno<TAB>(Acendente)
Personal.ApellidoMaterno<TAB>(Acendente)=Personal.Nombre<TAB>(Acendente)
Personal.Nombre<TAB>(Acendente)=(Fin)



[Lista.Personal.Direccion]
Carpeta=Lista
Clave=Personal.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Personal.DireccionNumero]
Carpeta=Lista
Clave=Personal.DireccionNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Personal.DireccionNumeroInt]
Carpeta=Lista
Clave=Personal.DireccionNumeroInt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Personal.Delegacion]
Carpeta=Lista
Clave=Personal.Delegacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Personal.Colonia]
Carpeta=Lista
Clave=Personal.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Personal.CodigoPostal]
Carpeta=Lista
Clave=Personal.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Personal.Poblacion]
Carpeta=Lista
Clave=Personal.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Personal.Estado]
Carpeta=Lista
Clave=Personal.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.Personal.Pais]
Carpeta=Lista
Clave=Personal.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco





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

















[Lista.PersonalDireccionFiscal.ClaveCP]
Carpeta=Lista
Clave=PersonalDireccionFiscal.ClaveCP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
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


Antes=S
ActivoCondicion=Info.Accion <> <T>Todos<T>
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






























































Expresion=RegistrarSeleccion<BR>EjecutarSQL(<T>spPersonalDireccionFiscalMapear :nEstacion<T>, EstacionTrabajo)<BR>ActualizarVista<BR>ActualizarForma





[FormaExtraValor.Columnas]
VerCampo=293
VerValor=296

[SituacionCta.Columnas]
0=188
1=148
2=-2
3=-2
4=-2

[(Carpeta Abrir).Columnas]
0=99
1=358





[Acciones.Editar]
Nombre=Editar
Boton=0
Menu=&Configuración
NombreDesplegar=&Personal
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S













Expresion=Forma(<T>PersonalSAT<T>)<BR>ActualizarVista
ConCondicion=S
EjecucionCondicion=ConDatos(PersonalDireccionFiscal:PersonalDireccionFiscal.Personal)
Antes=S
AntesExpresiones=Asigna(Info.Personal, PersonalDireccionFiscal:PersonalDireccionFiscal.Personal)
[Acciones.Abrir]
Nombre=Abrir
Boton=0
NombreDesplegar=&Configuración
EnMenu=S
TipoAccion=Expresion
Activo=S
Antes=S
Visible=S
ConCondicion=S

EspacioPrevio=S
Expresion=Forma(<T>PersonalSAT<T>)<BR>ActualizarVista
EjecucionCondicion=ConDatos(PersonalDireccionFiscal:PersonalDireccionFiscal.Personal)
AntesExpresiones=Asigna(Info.Personal, PersonalDireccionFiscal:PersonalDireccionFiscal.Personal)




[Lista.ListaEnCaptura]
(Inicio)=NombreCompleto
NombreCompleto=Personal.Tipo
Personal.Tipo=Personal.Direccion
Personal.Direccion=Personal.DireccionNumero
Personal.DireccionNumero=Personal.DireccionNumeroInt
Personal.DireccionNumeroInt=Personal.Delegacion
Personal.Delegacion=MunicipioDescripcion
MunicipioDescripcion=Personal.Colonia
Personal.Colonia=ColoniaDescripcion
ColoniaDescripcion=Personal.CodigoPostal
Personal.CodigoPostal=PersonalDireccionFiscal.ClaveCP
PersonalDireccionFiscal.ClaveCP=Personal.Poblacion
Personal.Poblacion=LocalidadDescripcion
LocalidadDescripcion=Personal.Estado
Personal.Estado=EstadoDescripcion
EstadoDescripcion=Personal.Pais
Personal.Pais=PaisDescripcion
PaisDescripcion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ASPIRANTE
ASPIRANTE=CANDIDATO
CANDIDATO=ALTA
ALTA=FINIQUITADO
FINIQUITADO=BAJA
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
Excel=PersonalInfo
PersonalInfo=Mensajes
Mensajes=Campos
Campos=Mapeados
Mapeados=NoMapeados
NoMapeados=Todos
Todos=Mapear
Mapear=Editar
Editar=(Fin)
