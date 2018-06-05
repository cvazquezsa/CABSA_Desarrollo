[Forma]
Clave=VerAuxAcreedor
Nombre=<T>Explorando - <T>+ Explorar.Direccion
Icono=47
Modulos=(Todos)
ListaCarpetas=Auxiliar
CarpetaPrincipal=Auxiliar
PosicionInicialIzquierda=87
PosicionInicialArriba=192
PosicionInicialAltura=384
PosicionInicialAncho=849
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Menus=S
Comentarios=Lista(Explorar.Moneda, Si(Explorar.Grupo<><T><T>, e(Explorar.GrupoSingular)+<T>: <T>+ Explorar.Grupo), e(Explorar.CuentaSingular)+<T>: <T>+Si(Explorar.Cuenta=<T><T>, <T>(todos)<T>,Explorar.Cuenta),  e(Explorar.PeriodoNombre)+<T>: <T>+FechaEnTexto(Explorar.FechaDe, <T>dd/mmm/aaaa<T>) + Si(Explorar.FechaDe<>Explorar.FechaA,<T> - <T>+FechaEnTexto(Explorar.FechaA, <T>dd/mmm/aaaa<T>)))
VentanaExclusiva=
VentanaEscCerrar=
ExpresionesAlMostrar=Asigna(Info.PeriodoNombre, <T>Este mes<T>)<BR>Asigna(Info.FechaD, PrimerDiaMes)<BR>Asigna(Info.FechaA, UltimoDiaMes)<BR>Asigna( Info.Nivel, <T>Dia<T> ) <BR>Asigna( Info.Vista, <T>Resumen<T> )<BR>Asigna( Info.VerGrupo, Falso)
EsConsultaExclusiva=S
Totalizadores=S
MenuPrincipal=(Lista)

[Auxiliar]
Estilo=Hoja
Clave=Auxiliar
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerAuxAcreedor
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaAjustarColumnas=S
HojaMantenerSeleccion=S

[Auxiliar.SubCuenta]
Carpeta=Auxiliar
Clave=SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=Gris
ColorFondo=Blanco

[Auxiliar.Cargo]
Carpeta=Auxiliar
Clave=Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
Totalizador=1
ColorFondo=Blanco
ColorFuente=Negro

[Auxiliar.Abono]
Carpeta=Auxiliar
Clave=Abono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
Totalizador=1
ColorFondo=Blanco
ColorFuente=Negro

[Auxiliar.Columnas]
0=63
1=98
Fecha=74
Mov=93
MovID=64
SubCuenta=98
CargoU=51
Cargo=115
AbonoU=54
Abono=104
SaldoU=55
Saldo=118
Cuenta=88
TotalU=55
Total=109
Concepto=79
Referencia=60
Movimiento=118
FechaNombre=66

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Auxiliar.CargoU]
Carpeta=Auxiliar
Clave=CargoU
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Auxiliar.AbonoU]
Carpeta=Auxiliar
Clave=AbonoU
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
NombreDesplegar=&Cerrar
EnBarraHerramientas=
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F4

[Acciones.VerDias]
Nombre=VerDias
Boton=53
NombreEnBoton=
Menu=&Ver
NombreDesplegar=por &Día
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=
Antes=S
AntesExpresiones=ReAsignarDesglose(<T>Dia<T>)
Visible=S
ActivoCondicion=Explorar.Nivel<><T>Dia<T>
EspacioPrevio=S

[Acciones.VerMovimientos]
Nombre=VerMovimientos
Boton=55
NombreEnBoton=
Menu=&Ver
NombreDesplegar=por Mo&vimiento
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=
Antes=S
AntesExpresiones=ReAsignarDesglose(<T>Movimiento<T>)
Visible=S
ActivoCondicion=Explorar.Nivel<><T>Movimiento<T>
UsaTeclaRapida=S
TeclaRapida=Ctrl+D

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
NombreDesplegar=&Presentación preliminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Menu=&Archivo
Expresion=Si(Explorar.Modulo en (<T>VTAS<T>, <T>INV<T>, <T>COMS<T>, <T>NOM<T>), ReportePantalla(<T>VerAuxAcreedorU<T>), ReportePantalla(<T>VerAuxAcreedor<T>))

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Si(Explorar.Modulo en (<T>VTAS<T>, <T>INV<T>, <T>COMS<T>, <T>NOM<T>), ReporteImpresora(<T>VerAuxAcreedorU<T>), ReporteImpresora(<T>VerAuxAcreedor<T>))

[Acciones.Graficar]
Nombre=Graficar
Boton=49
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Graficar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S

[Auxiliar.TotalU]
Carpeta=Auxiliar
Clave=TotalU
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Auxiliar.Total]
Carpeta=Auxiliar
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.VerAplicacion]
Nombre=VerAplicacion
Boton=54
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=por &Aplicación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=
Visible=S
Antes=S
ActivoCondicion=(Explorar.Nivel<><T>Aplicacion<T>) y (Explorar.Rama en (<T>CXC<T>,<T>CXP<T>))
AntesExpresiones=ReAsignarDesglose(<T>Aplicacion<T>)

[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=Enviar a E&xcel
EnMenu=S
TipoAccion=Controles Captura
Visible=S
Carpeta=(Carpeta principal)
ClaveAccion=Enviar a Excel
Activo=S
EnBarraHerramientas=S

[Acciones.Configurar]
Nombre=Configurar
Boton=45
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=Con&figurar...
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
Activo=S
Visible=S
ClaveAccion=Actualizar Vista
ConCondicion=S
EjecucionCondicion=ConfigurarExplorador(<T>Auxiliares<T>)=BotonAceptar
EjecucionMensaje=

[Auxiliar.Saldo]
Carpeta=Auxiliar
Clave=Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
Efectos=[Negritas]
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Examinar]
Nombre=Examinar
Boton=57
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+M
NombreDesplegar=Examinar el &Movimiento
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Visible=S
Expresion=ReportePantalla(VerAuxAcreedor:Modulo, VerAuxAcreedor:ModuloID)
ActivoCondicion=Explorar.Nivel en (<T>Movimiento<T>, <T>Aplicacion<T>)
EjecucionCondicion=ConDatos(VerAuxAcreedor:ModuloID)

[Auxiliar.Concepto]
Carpeta=Auxiliar
Clave=Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Auxiliar.Referencia]
Carpeta=Auxiliar
Clave=Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Auxiliar.Movimiento]
Carpeta=Auxiliar
Clave=Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
Menu=&Ver
NombreDesplegar=&Propiedades del Movimiento
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Visible=S
ConCondicion=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=F11
Activo=S
EjecucionCondicion=ConDatos(VerAuxAcreedor:ModuloID)
AntesExpresiones=Asigna(Info.Modulo, VerAuxAcreedor:Modulo)<BR>Asigna(Info.ID, VerAuxAcreedor:ModuloID)

[Auxiliar.FechaNombre]
Carpeta=Auxiliar
Clave=FechaNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=VerDias
VerDias=VerMovimientos
VerMovimientos=VerAplicacion
VerAplicacion=MovPropiedades
MovPropiedades=Examinar
Examinar=Imprimir
Imprimir=RepPantalla
RepPantalla=Graficar
Graficar=Excel
Excel=Configurar
Configurar=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)

[Auxiliar.ListaEnCaptura]
(Inicio)=FechaNombre
FechaNombre=Movimiento
Movimiento=SubCuenta
SubCuenta=Concepto
Concepto=Referencia
Referencia=Abono
Abono=AbonoU
AbonoU=Cargo
Cargo=CargoU
CargoU=Saldo
Saldo=Total
Total=TotalU
TotalU=(Fin)
