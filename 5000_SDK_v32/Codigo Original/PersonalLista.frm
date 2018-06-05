[Forma]
Clave=PersonalLista
Nombre=Personal
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=297
PosicionInicialArriba=102
PosicionInicialAltura=487
PosicionInicialAncho=771
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaEscCerrar=S
Comentarios=Lista(Si(Info.EspecificarEntradaSalida, Info.EntradaSalida), Si(ConDatos(Filtro.Proyecto), e(<T>Filtro:<T>)+<T> <T>+Filtro.Proyecto))
PosicionInicialAlturaCliente=486
MovModulo=RH

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Personal
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
ListaEnCaptura=NombreCompleto
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Departamento
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=Puesto
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=PersonalCat
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=PersonalGrupo
FiltroAplicaEn1=Personal.Departamento
FiltroAplicaEn2=Personal.Puesto
FiltroAplicaEn3=Personal.Categoria
FiltroAplicaEn4=Personal.Grupo
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=BAJA
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=25
BusquedaEnLinea=S
FiltroListas=S
FiltroListasRama=RH
FiltroListasAplicaEn=Personal.Personal
OtroOrden=S
ListaOrden=(Lista)
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroSucursales=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroUENs=S
FiltroUENsCampo=Personal.UEN
FiltroEmpresas=S

IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosNombre=Personal:Personal.Personal
IconosSubTitulo=<T>Personal<T>
ElementosPorPagina=200
FiltroGeneral={Si(ConDatos(Filtro.Proyecto), <T>Personal.Personal IN (SELECT Personal FROM dbo.fnPersonalAsignadoProyecto(<T>+Comillas(Filtro.Proyecto)+<T>))<T>, <T>1=1<T>)}
[Lista.NombreCompleto]
Carpeta=Lista
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Personal=115
NombreCompleto=294
0=106
1=301

[Detalle.Personal.Personal]
Carpeta=Detalle
Clave=Personal.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Personal.ApellidoPaterno]
Carpeta=Detalle
Clave=Personal.ApellidoPaterno
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.ApellidoMaterno]
Carpeta=Detalle
Clave=Personal.ApellidoMaterno
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.Nombre]
Carpeta=Detalle
Clave=Personal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.Categoria]
Carpeta=Detalle
Clave=Personal.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.Personal.Departamento]
Carpeta=Detalle
Clave=Personal.Departamento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.Grupo]
Carpeta=Detalle
Clave=Personal.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.Direccion]
Carpeta=Detalle
Clave=Personal.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=70
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.Colonia]
Carpeta=Detalle
Clave=Personal.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.Poblacion]
Carpeta=Detalle
Clave=Personal.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.Estado]
Carpeta=Detalle
Clave=Personal.Estado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.Pais]
Carpeta=Detalle
Clave=Personal.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.CodigoPostal]
Carpeta=Detalle
Clave=Personal.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.Telefono]
Carpeta=Detalle
Clave=Personal.Telefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Otros.Personal.Personal]
Carpeta=Otros
Clave=Personal.Personal
Editar=N
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=14
ColorFondo=Plata
ColorFuente=Negro

[Otros.NombreCompleto]
Carpeta=Otros
Clave=NombreCompleto
Editar=S
3D=S
Tamano=66
ColorFondo=Plata
ColorFuente=Negro

[Otros.Personal.FechaNacimiento]
Carpeta=Otros
Clave=Personal.FechaNacimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Otros.Personal.Nacionalidad]
Carpeta=Otros
Clave=Personal.Nacionalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Otros.Personal.Sexo]
Carpeta=Otros
Clave=Personal.Sexo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Otros.Personal.EstadoCivil]
Carpeta=Otros
Clave=Personal.EstadoCivil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Otros.Personal.Beneficiario]
Carpeta=Otros
Clave=Personal.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=36
ColorFondo=Blanco
ColorFuente=Negro

[Otros.Personal.Parentesco]
Carpeta=Otros
Clave=Personal.Parentesco
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Otros.Personal.FormaPago]
Carpeta=Otros
Clave=Personal.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Otros.Personal.CtaDinero]
Carpeta=Otros
Clave=Personal.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Otros.CtaDinero.Descripcion]
Carpeta=Otros
Clave=CtaDinero.Descripcion
Editar=S
3D=S
Tamano=45
ColorFondo=Plata
ColorFuente=Negro

[Otros.Personal.Personalucursal]
Carpeta=Otros
Clave=Personal.Personalucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Otros.Personal.PersonalCuenta]
Carpeta=Otros
Clave=Personal.PersonalCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.Jornada]
Carpeta=Detalle
Clave=Personal.Jornada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.Personal.Sueldo]
Carpeta=Detalle
Clave=Personal.Sueldo
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.TipoContrato]
Carpeta=Detalle
Clave=Personal.TipoContrato
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.PeriodoTipo]
Carpeta=Detalle
Clave=Personal.PeriodoTipo
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Detalle.Personal.eMail]
Carpeta=Detalle
Clave=Personal.eMail
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.Puesto]
Carpeta=Detalle
Clave=Personal.Puesto
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
Menu=&Archivo
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Registro]
Nombre=Registro
Boton=76
NombreEnBoton=S
NombreDesplegar=<T>&Registro<T>
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Titulos
Antes=S
ActivoCondicion=Info.EspecificarEntradaSalida
AntesExpresiones=Si(Info.EntradaSalida=<T>Salida<T>, Asigna(Info.EntradaSalida, <T>Entrada<T>), Asigna(Info.EntradaSalida, <T>Salida<T>))
Visible=S

[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar]
Nombre=Quitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S




[Acciones.Proyecto]
Nombre=Proyecto
Boton=107
NombreDesplegar=Si(Vacio(Filtro.Proyecto), <T>Filtro Proyecto<T>, <T>Quitar Filtro<T>)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S




































Expresion=Si<BR>  Vacio(Filtro.Proyecto)<BR>Entonces<BR>  Asigna(Info.Proyecto, Nulo)<BR>  Si(Forma(<T>EspecificarProyecto<T>), Asigna(Filtro.Proyecto, Info.Proyecto))<BR>Sino<BR>  Asigna(Filtro.Proyecto, Nulo)<BR>Fin<BR>Forma.ActualizarForma
[Lista.ListaOrden]
(Inicio)=Personal.ApellidoPaterno	(Acendente)
Personal.ApellidoPaterno	(Acendente)=Personal.ApellidoMaterno	(Acendente)
Personal.ApellidoMaterno	(Acendente)=Personal.Nombre	(Acendente)
Personal.Nombre	(Acendente)=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos menos uno)
(Todos menos uno)=ASPIRANTE
ASPIRANTE=CANDIDATO
CANDIDATO=ALTA
ALTA=FINIQUITADO
FINIQUITADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionarTodo
SeleccionarTodo=Quitar
Quitar=(Fin)





































[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Registro
Registro=Personalizar
Personalizar=Proyecto
Proyecto=(Fin)
