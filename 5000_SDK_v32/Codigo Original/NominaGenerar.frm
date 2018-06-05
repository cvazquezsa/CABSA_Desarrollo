[Forma]
Clave=NominaGenerar
Nombre=<T>Generar la Nómina <T>+Si(Info.MovNomAuto, <T>Automática<T>)
Icono=34
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=1762
PosicionInicialArriba=0
PosicionInicialAltura=511
PosicionInicialAncho=1128
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Nomina, Info.PeriodoTipo,  FechaEnTexto(Info.FechaD, <T>dd/mmm/aaaa<T>)+<T> - <T>+FechaEnTexto(Info.FechaA, <T>dd/mmm/aaaa<T>))
VentanaExclusiva=S
PosicionInicialAlturaCliente=484
ExpresionesAlMostrar=Asigna(Info.MovNomAuto, SQL(<T>SELECT NomAuto FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov<T>, <T>NOM<T>, Afectar.Mov))<BR>Asigna(Info.Nomina, SQL(<T>SELECT Nombre FROM NomX WHERE NomMov=:t<T>, Afectar.Mov))<BR>Si(Vacio(Info.Nomina), Asigna(Info.Nomina, Config.NomOmision))<BR>Asigna(Info.PeriodoTipo, Config.NomOmisionPeriodo)<BR>Asigna(Info.Filtrar, SQL(<T>SELECT FiltrarUltimoDiaPagado FROM NomX WHERE NomMov=:t<T>, Afectar.Mov))<BR><BR>Asigna(Info.Fecha, SQL(<T>SELECT UltimoDiaPagado FROM PeriodoTipoMovEmpresa WHERE PeriodoTipo = :tPeriodo AND Mov=:tMov AND Empresa=:tEmpresa<T>,Info.PeriodoTipo, Afectar.Mov, Empresa))<BR>Si(Vacio(Info.Fecha), Asigna(Info.Fecha, SQL(<T>SELECT UltimoDiaPagado FROM PeriodoTipoMov WHERE PeriodoTipo = :tPeriodo AND Mov=:tMov<T>,Info.PeriodoTipo, Afectar.Mov)))<BR>Si(Vacio(Info.Fecha), Asigna(Info.Fecha, SQL(<T>SELECT UltimoDiaPagado FROM PeriodoTipo WHERE PeriodoTipo = :tPeriodo<T>,Info.PeriodoTipo)))<BR>Asigna(Info.PeriodoEsp, Falso)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Personal
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Persona<T>
ElementosPorPagina=200
IconosSeleccionMultiple=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=Personal.UltimoPago<TAB>(Acendente)
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Puesto
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=Departamento
FiltroAplicaEn1=Personal.Puesto
FiltroAplicaEn2=Personal.Departamento
FiltroAncho=25
FiltroListas=S
FiltroListasRama=RH
FiltroListasAplicaEn=Personal.Personal
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
BusquedaRapidaControles=S
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=PersonalCat
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=PersonalGrupo
FiltroAplicaEn3=Personal.Categoria
FiltroAplicaEn4=Personal.Grupo
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroEstatusDefault=ALTA
FiltroFechasCampo=Personal.UltimoPago
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroMonedasCampo=Personal.Moneda
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=25
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=Persona(s)
MenuLocal=S
ListaAcciones=(Lista)
FiltroSucursales=S
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=NominaContratoTipo
FiltroAplicaEn5=Personal.TipoContrato
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroGrupo6=(Validaciones Memoria)
FiltroValida6=MovTipo_NOM_NNE
FiltroAplicaEn6=Personal.MovNomina
PermiteLocalizar=S
FiltroTodoFinal=S
FiltroSucursalesTodasPorOmision=S
FiltroEmpresas=S

IconosNombre=Personal:Personal.Personal
FiltroGeneral=Personal.PeriodoTipo = <T>{Info.PeriodoTipo}<T><BR>{Si<BR>  no Info.PeriodoEsp<BR>Entonces<BR>  Asigna(Info.FechaD, Nomina.PeriodoInicia(Info.PeriodoTipo, Info.Fecha)) <BR>  Asigna(Info.Fecha, Info.FechaD-1)<BR>  Asigna(Info.FechaA, Nomina.PeriodoTermina(Info.PeriodoTipo, Info.Fecha))<BR>Fin<BR>Si(Info.Filtrar, <T> AND (CASE WHEN Personal.UltimoPago IS NULL THEN Personal.FechaAlta ELSE Personal.UltimoPago END)<<T>+Comillas(FechaFormatoServidor(Info.FechaA)), <T><T>)}
[Lista.NombreCompleto]
Carpeta=Lista
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Personal.UltimoPago]
Carpeta=Lista
Clave=Personal.UltimoPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=113
1=163

2=-2
3=-2
4=-2
[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=<T>&Generar<T>
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=S
Visible=S
ClaveAccion=Actualizar Forma
ConCondicion=S
EspacioPrevio=S
Multiple=S
ListaAccionesMultiples=(Lista)

EjecucionCondicion=Si<BR>  SQL(<T>SELECT Finiquito FROM NomX WHERE Nombre =:t<T>, Info.Nomina)<BR>Entonces<BR>  Forma(<T>Finiquito<T>)<BR>Sino<BR>  Verdadero<BR>Fin
[Acciones.Cancelar]
Nombre=Cancelar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=55
NombreEnBoton=S
NombreDesplegar=&Todos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Mostrar]
Nombre=Mostrar
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.LocalSeleccionarTodo]
Nombre=LocalSeleccionarTodo
Boton=0
NombreDesplegar=Seleccionar &Todos
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Nomina]
Nombre=Nomina
Boton=61
NombreEnBoton=S
NombreDesplegar=&Nomina
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Titulos
Activo=S
Visible=S
Antes=S
EspacioPrevio=S
AntesExpresiones=Forma(<T>EspecificarNomina<T>)

[Acciones.Periodo]
Nombre=Periodo
Boton=88
NombreEnBoton=S
NombreDesplegar=&Tipo Periodo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
Antes=S
Multiple=S
ListaAccionesMultiples=Actualizar Titulos<BR>Actualizar Vista
AntesExpresiones=Si <BR>  Forma(<T>EspecificarPeriodoTipo<T>)<BR>Entonces<BR>  Asigna(Info.Fecha, SQL(<T>SELECT UltimoDiaPagado FROM PeriodoTipo WHERE PeriodoTipo = :tPeriodo<T>,Info.PeriodoTipo))<BR>Fin

[Lista.Personal.Tipo]
Carpeta=Lista
Clave=Personal.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Fecha]
Nombre=Fecha
Boton=53
NombreEnBoton=S
NombreDesplegar=&Fecha
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
Visible=S
ActivoCondicion=Config.NomModificarFechaNomina
AntesExpresiones=Asigna(Info.Fecha, Info.Fecha+1)<BR>Forma(<T>EspecificarFecha<T>)<BR>Asigna(Info.Fecha, Info.Fecha-1)<BR>Asigna(Info.PeriodoEsp, Falso)

[Acciones.Periodo.Actualizar Titulos]
Nombre=Actualizar Titulos
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Titulos
Activo=S
Visible=S

[Acciones.Periodo.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.EstatusNombre]
Carpeta=Lista
Clave=EstatusNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Localizar]
Nombre=Localizar
Boton=73
NombreDesplegar=Localizar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S

[Acciones.Generar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  Confirmacion(<T>Desea Generar Borrador<T>+NuevaLinea+NuevaLinea+<BR>               <T>Nómina: <T>+Info.Nomina+NuevaLinea+<BR>               <T>Periodo: <T>+Si(Info.PeriodoEsp, <T>(Especial)<T>, Info.PeriodoTipo)+NuevaLinea+<BR>               <T>Del: <T>+FechaEnTexto(Info.FechaD, <T>dd/mmm/aaaa<T>)+NuevaLinea+<BR>               <T>Al: <T>+FechaEnTexto(Info.FechaA, <T>dd/mmm/aaaa<T>), BotonSi, BotonNo)=BotonSi<BR>Entonces<BR>  Asigna(Info.ID, Nulo)<BR>  Asigna(Info.ID, SQL(<T>SELECT MAX(ID) FROM Asiste WHERE Empresa=:tEmp AND Mov=:tMov AND Estatus=:tEstatus<T>, Empresa, ConfigMov.AsisteCorte, EstatusBorrador))<BR>  Si<BR>    ConDatos(Info.ID)<BR>  Entonces<BR>    Si(Confirmacion(<T>Desea Afectar el Borrador del Corte de Asistencias<T>, BotonSi, BotonNo)=BotonSi,Afectar(<T>ASIS<T>, Info.ID, Nulo, Nulo))<BR>  Fin<BR>  Si<BR>    Info.MovNomAuto<BR>  Entonces<BR>    RegistrarSeleccion(<T>Lista<T>) <BR>    ProcesarSQL(<T>spNominaGenerar :nEstacion, :nID, :fFechaD, :fFechaA, :tPeriodoTipo, :fHoy<T>, EstacionTrabajo, Afectar.ID, Info.FechaD, Info.FechaA, Info.PeriodoTipo, FechaTrabajo)<BR>  Sino<BR>    EjecutarSQL(<T>spSPIDTemp @Numerico=:nID<T>, Afectar.ID)<BR>    Nomina.Generar(Afectar.ID, Info.Nomina, Info.PeriodoTipo, ListaSeleccion(<T>Lista<T>), Info.Fecha)<BR>  Fin<BR>Sino<BR>  AbortarOperacion<BR>Fin
[Acciones.Generar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.ModificarPeriodo]
Nombre=ModificarPeriodo
Boton=53
NombreEnBoton=S
NombreDesplegar=&Periodo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Titulos
ConCondicion=S
EjecucionCondicion=Si(Forma(<T>EspecificarFechas<T>), Asigna(Info.PeriodoEsp, Verdadero) Verdadero, Falso)





[Lista.ListaEnCaptura]
(Inicio)=NombreCompleto
NombreCompleto=Personal.Tipo
Personal.Tipo=Personal.UltimoPago
Personal.UltimoPago=EstatusNombre
EstatusNombre=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=ASPIRANTE
ASPIRANTE=CANDIDATO
CANDIDATO=FINIQUITADO
FINIQUITADO=BAJA
BAJA=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalSeleccionarTodo
LocalSeleccionarTodo=LocalQuitar
LocalQuitar=(Fin)













[Acciones.Generar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Actualizar Forma
Actualizar Forma=(Fin)






[Acciones.NominaG4.Ejecuta]
Nombre=Ejecuta
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  Confirmacion(<T>Desea Utilizar el Motor de Nomina G4<T>+NuevaLinea+NuevaLinea+<BR>               <T>Nómina: <T>+Info.Nomina+NuevaLinea+<BR>               <T>Periodo: <T>+Si(Info.PeriodoEsp, <T>(Especial)<T>, Info.PeriodoTipo)+NuevaLinea+<BR>               <T>Del: <T>+FechaEnTexto(Info.FechaD, <T>dd/mmm/aaaa<T>)+NuevaLinea+<BR>               <T>Al: <T>+FechaEnTexto(Info.FechaA, <T>dd/mmm/aaaa<T>), BotonSi, BotonNo)=BotonSi<BR>Entonces<BR>  RegistrarSeleccion(<T>Lista<T>)<BR>  ProcesarSQL(<T>EXEC spNominaG4 :nEsta, :tEmpre, :nSuc, :nID, :tPeriodoTipo, :fFechaD, :fFechaA<T>, EstacionTrabajo, Empresa, Sucursal, Afectar.ID, Info.PeriodoTipo, Info.FechaD, Info.FechaA)<BR>Sino<BR>  AbortarOperacion<BR>Fin
[Acciones.NominaG4.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.NominaG4]
Nombre=NominaG4
Boton=93
NombreEnBoton=S
NombreDesplegar=&Motor Nomina G4
Multiple=S
EnBarraHerramientas=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S






EspacioPrevio=S



















VisibleCondicion=General.NominaG4

[Acciones.NominaG4.ListaAccionesMultiples]
(Inicio)=Ejecuta
Ejecuta=Cerrar
Cerrar=(Fin)











[Forma.ListaAcciones]
(Inicio)=Cancelar
Cancelar=Seleccionar
Seleccionar=Localizar
Localizar=Generar
Generar=Nomina
Nomina=Periodo
Periodo=Fecha
Fecha=Mostrar
Mostrar=ModificarPeriodo
ModificarPeriodo=NominaG4
NominaG4=(Fin)
