[Forma]
Clave=PersonalInfo
Nombre=Información de la Persona
Icono=6
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=281
PosicionInicialArriba=260
PosicionInicialAltura=496
PosicionInicialAncho=717
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Menus=S
BarraAyuda=S
BarraAyudaBold=S
EsConsultaExclusiva=S
Comentarios=Lista(Personal:NombreCompleto, Info.Personal)
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionColumna1=50
PosicionInicialAlturaCliente=469
MenuPrincipal=(Lista)

[Lista.Personal.Personal]
Carpeta=Lista
Clave=Personal.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NombreCompleto]
Carpeta=Lista
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Personal=115
NombreCompleto=287

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Personal
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroGeneral=Personal.Personal=<T>{Info.Personal}<T>
FiltroRespetar=S
FiltroTipo=General

[Detalle.Personal.Direccion]
Carpeta=Detalle
Clave=Personal.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=41x3
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.Colonia]
Carpeta=Detalle
Clave=Personal.Colonia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.Poblacion]
Carpeta=Detalle
Clave=Personal.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.Estado]
Carpeta=Detalle
Clave=Personal.Estado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.Pais]
Carpeta=Detalle
Clave=Personal.Pais
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.CodigoPostal]
Carpeta=Detalle
Clave=Personal.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.Telefono]
Carpeta=Detalle
Clave=Personal.Telefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=N

[Detalle.Personal.Jornada]
Carpeta=Detalle
Clave=Personal.Jornada
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Detalle.Personal.TipoContrato]
Carpeta=Detalle
Clave=Personal.TipoContrato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

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
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Tarjetas]
Nombre=Tarjetas
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=&Tarjetas
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalTarjeta
Activo=S
Visible=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F11
NombreDesplegar=&Propiedades
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Visible=S
ClaveAccion=PersonalPropValorInfo
Antes=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Rama, <T>PER<T>)<BR>Asigna(Info.Cuenta, Personal:Personal.Personal)<BR>Asigna(Info.Descripcion, Personal:NombreCompleto)

[Detalle.Personal.TipoSalario]
Carpeta=Detalle
Clave=Personal.TipoSalario
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Personal.SalarioFijo]
Carpeta=Detalle
Clave=Personal.SalarioFijo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
EspacioPrevio=S

[Detalle.Personal.SalarioVariable]
Carpeta=Detalle
Clave=Personal.SalarioVariable
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=N

[Detalle.Personal.Moneda]
Carpeta=Detalle
Clave=Personal.Moneda
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro
Pegado=N

[Detalle.]
Carpeta=Detalle
ColorFondo=Negro

[RH]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Recursos Humanos
Clave=RH
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Personal
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[RH.Personal.FechaAlta]
Carpeta=RH
Clave=Personal.FechaAlta
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[RH.Personal.UltimaModificacion]
Carpeta=RH
Clave=Personal.UltimaModificacion
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[RH.Personal.FechaBaja]
Carpeta=RH
Clave=Personal.FechaBaja
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Nomina.Personal.FormaPago]
Carpeta=Nomina
Clave=Personal.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.Personal.CtaDinero]
Carpeta=Nomina
Clave=Personal.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.Personal.Afore]
Carpeta=Nomina
Clave=Personal.Afore
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Nomina.Personal.PersonalCuenta]
Carpeta=Nomina
Clave=Personal.PersonalCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Nomina.Personal.PersonalSucursal]
Carpeta=Nomina
Clave=Personal.PersonalSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Nomina.Prov.Nombre]
Carpeta=Nomina
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=45
ColorFondo=Plata
ColorFuente=Negro

[Nomina.Personal.Personal]
Carpeta=Nomina
Clave=Personal.Personal
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Nomina.NombreCompleto]
Carpeta=Nomina
Clave=NombreCompleto
3D=S
Tamano=66
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[RH.Personal.Categoria]
Carpeta=RH
Clave=Personal.Categoria
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=N

[RH.Personal.Departamento]
Carpeta=RH
Clave=Personal.Departamento
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[RH.Personal.Grupo]
Carpeta=RH
Clave=Personal.Grupo
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[RH.Personal.TipoContrato]
Carpeta=RH
Clave=Personal.TipoContrato
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[RH.Personal.Puesto]
Carpeta=RH
Clave=Personal.Puesto
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=N

[RH.Personal.PeriodoTipo]
Carpeta=RH
Clave=Personal.PeriodoTipo
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[RH.Personal.Jornada]
Carpeta=RH
Clave=Personal.Jornada
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[RH.Personal.Valuacion]
Carpeta=RH
Clave=Personal.Valuacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[RH.Personal.NivelAcademico]
Carpeta=RH
Clave=Personal.NivelAcademico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S

[RH.Personal.TipoSueldo]
Carpeta=RH
Clave=Personal.TipoSueldo
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S

[RH.Personal.Moneda]
Carpeta=RH
Clave=Personal.Moneda
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[RH.Personal.ReportaA]
Carpeta=RH
Clave=Personal.ReportaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=N

[RH.NombreReporta]
Carpeta=RH
Clave=NombreReporta
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.Tipo]
Carpeta=Detalle
Clave=Personal.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[RH.Personal.UltimoPago]
Carpeta=RH
Clave=Personal.UltimoPago
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Evaluacion.RHD.Calificacion]
Carpeta=Evaluacion
Clave=RHD.Calificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Evaluacion.RHD.Observaciones]
Carpeta=Evaluacion
Clave=RHD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Evaluacion.RH.FechaEmision]
Carpeta=Evaluacion
Clave=RH.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Evaluacion.Evaluacion.Tipo]
Carpeta=Evaluacion
Clave=Evaluacion.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.EstatusNombre]
Carpeta=Detalle
Clave=EstatusNombre
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Personal.ZonaEconomica]
Carpeta=Detalle
Clave=Personal.ZonaEconomica
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Nomina.CtaDineroDestino.Descripcion]
Carpeta=Nomina
Clave=CtaDineroDestino.Descripcion
Editar=S
3D=S
Tamano=45
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.Registro]
Carpeta=Detalle
Clave=Personal.Registro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Personal.Nacionalidad]
Carpeta=Detalle
Clave=Personal.Nacionalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.FechaNacimiento]
Carpeta=Detalle
Clave=Personal.FechaNacimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.Sexo]
Carpeta=Detalle
Clave=Personal.Sexo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.EstadoCivil]
Carpeta=Detalle
Clave=Personal.EstadoCivil
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.Hijos]
Carpeta=Detalle
Clave=Personal.Hijos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.Cartilla]
Carpeta=Detalle
Clave=Personal.Cartilla
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.Pasaporte]
Carpeta=Detalle
Clave=Personal.Pasaporte
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.Permiso]
Carpeta=Detalle
Clave=Personal.Permiso
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[RH.Personal.FechaAntiguedad]
Carpeta=RH
Clave=Personal.FechaAntiguedad
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[RH.Antiguedad]
Carpeta=RH
Clave=Antiguedad
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Rama, <T>NOM<T>)<BR>Asigna(Info.AnexoCfg, Falso)<BR>Asigna(Info.Cuenta, Personal:Personal.Personal)<BR>Asigna(Info.Descripcion, Personal:NombreCompleto)
RefrescarDespues=S

[Detalle.Personal.Registro2]
Carpeta=Detalle
Clave=Personal.Registro2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Personal.Registro3]
Carpeta=Detalle
Clave=Personal.Registro3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.NombreCompleto]
Carpeta=Detalle
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
Menu=&Ver

[Pendientes]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Pendientes
Clave=Pendientes
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaInfo
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=NominaInfo.FechaEmision<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=NominaInfo:NominaInfo.Mov+<T> <T>+NominaInfo:NominaInfo.MovID
FiltroGeneral=NominaInfo.Empresa=<T>{Empresa}<T> AND<BR>NominaInfo.Personal=<T>{Info.Personal}<T>

[Pendientes.NominaInfo.FechaEmision]
Carpeta=Pendientes
Clave=NominaInfo.FechaEmision
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Pendientes.NominaInfo.Condicion]
Carpeta=Pendientes
Clave=NominaInfo.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Pendientes.NominaInfo.Importe]
Carpeta=Pendientes
Clave=NominaInfo.Importe
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Pendientes.NominaInfo.CantidadPendiente]
Carpeta=Pendientes
Clave=NominaInfo.CantidadPendiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Pendientes.NominaInfo.Saldo]
Carpeta=Pendientes
Clave=NominaInfo.Saldo
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Pendientes.Columnas]
0=131
1=77

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(NominaInfo:NominaInfo.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.ID, NominaInfo:NominaInfo.ID)
Visible=S

[Acciones.Doc]
Nombre=Doc
Boton=17
Menu=&Ver
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Expresion=VerDocumentacion(<T>RH<T>, Personal:Personal.Personal, <T>Documentación - <T>+Personal:NombreCompleto)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
Visible=S

[RH.Personal.VencimientoContrato]
Carpeta=RH
Clave=Personal.VencimientoContrato
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[RH.Personal.SucursalTrabajo]
Carpeta=RH
Clave=Personal.SucursalTrabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[RH.Sucursal.Nombre]
Carpeta=RH
Clave=Sucursal.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[RH.Personal.SueldoDiario]
Carpeta=RH
Clave=Personal.SueldoDiario
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[RH.Personal.SDI]
Carpeta=RH
Clave=Personal.SDI
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[RH.Personal.ConceptoBaja]
Carpeta=RH
Clave=Personal.ConceptoBaja
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Vacaciones]
Nombre=Vacaciones
Boton=66
Menu=&Explorar
NombreDesplegar=&Días Vacaciones
EnMenu=S
TipoAccion=Formas
ClaveAccion=VerAcum
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
AntesExpresiones=IrModulo(<T>NOM<T>)<BR>IrDireccion(<T>VAC<T>, Personal:Personal.Personal)

[Acciones.VentanaCerrar]
Nombre=VentanaCerrar
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.SoporteProp]
Nombre=SoporteProp
Boton=0
NombreDesplegar=Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(SoporteA:Soporte.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>ST<T>)<BR>Asigna(Info.ID, SoporteA:Soporte.ID)
Visible=S

[Soporte]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Atención Personal
Clave=Soporte
Filtros=S
BusquedaRapidaControles=S
MenuLocal=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SoporteA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroEstatus=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechasCampo=Soporte.Vencimiento
FiltroFechasDefault=(Todo)
FiltroFechasVencimiento=S
FiltroFechasCancelacion=Soporte.FechaCancelacion
FiltroFechasNombre=&Vencimiento
ListaAcciones=SoporteProp
CarpetaVisible=S
IconosNombre=SoporteA:Soporte.Mov+<T> <T>+SoporteA:Soporte.MovID
FiltroGeneral=Soporte.Personal=<T>{Info.Personal}<T>

[Soporte.Soporte.FechaEmision]
Carpeta=Soporte
Clave=Soporte.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Soporte.Vencimiento]
Carpeta=Soporte
Clave=Soporte.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Soporte.Titulo]
Carpeta=Soporte
Clave=Soporte.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Soporte.Columnas]
0=123
1=79

[Prestamos]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Prestamos (Inventario)
Clave=Prestamos
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InvA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
MenuLocal=S
IconosNombre=InvA:Inv.Mov+<T> <T>+InvA:Inv.MovID
FiltroGeneral=Inv.Empresa=<T>{Empresa}<T> AND Inv.Estatus=<T>PENDIENTE<T> AND Inv.Personal=<T>{Info.Personal}<T>
ListaAcciones=(Lista)

[Prestamos.Inv.FechaEmision]
Carpeta=Prestamos
Clave=Inv.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Prestamos.Inv.Almacen]
Carpeta=Prestamos
Clave=Inv.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Prestamos.Inv.AlmacenDestino]
Carpeta=Prestamos
Clave=Inv.AlmacenDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Prestamos.Columnas]
0=151
1=102

[Acciones.PrestamosPersonalizar]
Nombre=PrestamosPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=Prestamos
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.PrestamosPropiedades]
Nombre=PrestamosPropiedades
Boton=0
NombreDesplegar=Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(InvA:Inv.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, InvA:Inv.ID)
Visible=S

[Acciones.Cubos]
Nombre=Cubos
Boton=100
Menu=&Ver
NombreDesplegar=<T>Cubos<T>
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Dialogos
ClaveAccion=CuboPersonal
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Nombre, Personal:NombreCompleto)

[Acciones.Evaluaciones]
Nombre=Evaluaciones
Boton=103
Menu=&Ver
NombreDesplegar=E&valuaciones
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EvaluacionCalificacionInfo
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Clave, Personal:Personal.Personal)<BR>Asigna(Info.Nombre, Personal:NombreCompleto)<BR>Asigna(Info.Aplica, <T>Personal<T>)<BR>Asigna(Info.Nombre2, Nulo)
Visible=S

[Pendientes.NominaInfo.Concepto]
Carpeta=Pendientes
Clave=NominaInfo.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[ActivoF]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Activos Fijos (Asignados)
Clave=ActivoF
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoF
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=ActivoF:ActivoF.Articulo
FiltroGeneral=ActivoF.Responsable=<T>{Info.Personal}<T>

[ActivoF.ActivoF.Serie]
Carpeta=ActivoF
Clave=ActivoF.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[ActivoF.ActivoF.Almacen]
Carpeta=ActivoF
Clave=ActivoF.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[ActivoF.ActivoF.Categoria]
Carpeta=ActivoF
Clave=ActivoF.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[ActivoF.Columnas]
0=100
1=168

[ActivoF.Art.Descripcion1]
Carpeta=ActivoF
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ExplorarRH]
Nombre=ExplorarRH
Boton=66
Menu=&Explorar
NombreDesplegar=R&H
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarRHPersonal
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+R
AntesExpresiones=Asigna(Info.Personal, Personal:Personal.Personal)<BR>Asigna(Info.Nombre, Personal:NombreCompleto)

[Acciones.ExplorarNomina]
Nombre=ExplorarNomina
Boton=66
NombreEnBoton=S
Menu=&Explorar
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nomina
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ExplorarNominaPersonal
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Personal, Personal:Personal.Personal)<BR>Asigna(Info.Nombre, Personal:NombreCompleto)

[Acciones.Tareas]
Nombre=Tareas
Boton=70
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=Tareas
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.PuedeEditar, Falso)<BR>Asigna(Info.Nombre, Personal:NombreCompleto)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Personal:Personal.Personal)<BR>Asigna(Info.Proyecto, Nulo)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.ID, Nulo)<BR>Asigna(Info.Reporte, Nulo)

[Acciones.PendientesPersonalizar]
Nombre=PendientesPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Politica]
Nombre=Politica
Boton=22
Menu=&Ver
NombreDesplegar=Política
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+O
EjecucionCondicion=ConDatos(Personal:Personal.Personal)
AntesExpresiones=Asigna(Info.Rama, <T>PER<T>)<BR>Asigna(Info.Clave, Personal:Personal.Personal)

[Acciones.Correos]
Nombre=Correos
Boton=112
Menu=&Ver
NombreDesplegar=&Correos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=OutlookPersonal
Activo=S
Visible=S

[FormaExtraValor]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Características
Clave=FormaExtraValor
Filtros=S
OtroOrden=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaExtraValor
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaSinBorde=S
HojaFondoGris=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=FormaExtraValor.FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisiblePersonal(<T>{Personal:Personal.Categoria}<T>, <T>{Personal:Personal.Grupo}<T>, <T>{Personal:Personal.Departamento}<T>, <T>{Personal:Personal.Puesto}<T>)) AND FormaExtraValor.Aplica=<T>Personal<T> AND FormaExtraValor.AplicaClave=<T>{Personal:Personal.Personal}<T>
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>

[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[FormaExtraValor.VerValor]
Carpeta=FormaExtraValor
Clave=VerValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[FormaExtraValor.Columnas]
VerCampo=296
VerValor=364

[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=RH
RH=Pendientes
Pendientes=Soporte
Soporte=Prestamos
Prestamos=ActivoF
ActivoF=FormaExtraValor
FormaExtraValor=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Tarjetas
Tarjetas=Tareas
Tareas=Propiedades
Propiedades=Evaluaciones
Evaluaciones=Anexos
Anexos=Doc
Doc=Politica
Politica=Cubos
Cubos=Correos
Correos=ExplorarNomina
ExplorarNomina=ExplorarRH
ExplorarRH=Vacaciones
Vacaciones=VentanaCerrar
VentanaCerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Ver
&Ver=&Explorar
&Explorar=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=NombreCompleto
NombreCompleto=Personal.Tipo
Personal.Tipo=EstatusNombre
EstatusNombre=Personal.Registro
Personal.Registro=Personal.Registro2
Personal.Registro2=Personal.Registro3
Personal.Registro3=Personal.Direccion
Personal.Direccion=Personal.Colonia
Personal.Colonia=Personal.CodigoPostal
Personal.CodigoPostal=Personal.Poblacion
Personal.Poblacion=Personal.Estado
Personal.Estado=Personal.Pais
Personal.Pais=Personal.ZonaEconomica
Personal.ZonaEconomica=Personal.Telefono
Personal.Telefono=Personal.eMail
Personal.eMail=Personal.Nacionalidad
Personal.Nacionalidad=Personal.FechaNacimiento
Personal.FechaNacimiento=Personal.Sexo
Personal.Sexo=Personal.EstadoCivil
Personal.EstadoCivil=Personal.Hijos
Personal.Hijos=Personal.Cartilla
Personal.Cartilla=Personal.Pasaporte
Personal.Pasaporte=Personal.Permiso
Personal.Permiso=(Fin)

[RH.ListaEnCaptura]
(Inicio)=Personal.ReportaA
Personal.ReportaA=NombreReporta
NombreReporta=Personal.NivelAcademico
Personal.NivelAcademico=Personal.Valuacion
Personal.Valuacion=Personal.Departamento
Personal.Departamento=Personal.Puesto
Personal.Puesto=Personal.Categoria
Personal.Categoria=Personal.Grupo
Personal.Grupo=Personal.TipoContrato
Personal.TipoContrato=Personal.VencimientoContrato
Personal.VencimientoContrato=Personal.PeriodoTipo
Personal.PeriodoTipo=Personal.Jornada
Personal.Jornada=Personal.TipoSueldo
Personal.TipoSueldo=Personal.SueldoDiario
Personal.SueldoDiario=Personal.SDI
Personal.SDI=Personal.Moneda
Personal.Moneda=Personal.FechaAntiguedad
Personal.FechaAntiguedad=Antiguedad
Antiguedad=Personal.UltimoPago
Personal.UltimoPago=Personal.FechaAlta
Personal.FechaAlta=Personal.UltimaModificacion
Personal.UltimaModificacion=Personal.FechaBaja
Personal.FechaBaja=Personal.ConceptoBaja
Personal.ConceptoBaja=Personal.SucursalTrabajo
Personal.SucursalTrabajo=Sucursal.Nombre
Sucursal.Nombre=(Fin)

[Pendientes.ListaEnCaptura]
(Inicio)=NominaInfo.Concepto
NominaInfo.Concepto=NominaInfo.FechaEmision
NominaInfo.FechaEmision=NominaInfo.Condicion
NominaInfo.Condicion=NominaInfo.Importe
NominaInfo.Importe=NominaInfo.CantidadPendiente
NominaInfo.CantidadPendiente=NominaInfo.Saldo
NominaInfo.Saldo=(Fin)

[Pendientes.ListaAcciones]
(Inicio)=MovPropiedades
MovPropiedades=PendientesPersonalizar
PendientesPersonalizar=(Fin)

[Soporte.ListaEnCaptura]
(Inicio)=Soporte.FechaEmision
Soporte.FechaEmision=Soporte.Vencimiento
Soporte.Vencimiento=Soporte.Titulo
Soporte.Titulo=(Fin)

[Soporte.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=ALTAPRIORIDAD
ALTAPRIORIDAD=PRIORIDADBAJA
PRIORIDADBAJA=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)

[Prestamos.ListaEnCaptura]
(Inicio)=Inv.FechaEmision
Inv.FechaEmision=Inv.Almacen
Inv.Almacen=Inv.AlmacenDestino
Inv.AlmacenDestino=(Fin)

[Prestamos.ListaAcciones]
(Inicio)=PrestamosPropiedades
PrestamosPropiedades=PrestamosPersonalizar
PrestamosPersonalizar=(Fin)

[ActivoF.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Categoria
ActivoF.Categoria=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Grupo<TAB>(Acendente)
FormaExtraCampo.Grupo<TAB>(Acendente)=(Fin)
