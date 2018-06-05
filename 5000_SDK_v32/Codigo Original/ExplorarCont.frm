[Forma]
Clave=ExplorarCont
Nombre=<T>Explorando - <T>+Explorar.ModuloNombre
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=291
PosicionInicialArriba=218
PosicionInicialAltura=461
PosicionInicialAncho=858
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Menus=S
Comentarios=Lista(Info.ContMoneda, <BR>Si <BR>  Explorar.VerSaldoActual<BR>Entonces<BR> <T>Saldo Actual<T><BR>Sino<BR>  +Si(Explorar.Acumulado,<T>Acumulado<T>,<T>De <T>+PeriodoNombre(Explorar.PeriodoDe, Explorar.Modulo))<BR>  +Si(Explorar.Acumulado o (Explorar.PeriodoDe<>Explorar.PeriodoA),<T> a <T>+PeriodoNombre(Explorar.PeriodoA, Explorar.Modulo))<BR>  +NuevaLinea+<T>Ejercicio: <T>+ Explorar.Ejercicio<BR>Fin)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=434
ExpresionesAlMostrar=Asigna(Info.ContMoneda, Config.ContMoneda)<BR>Asigna(Info.Vista, <T>Resumen<T>)<BR>IrModulo(<T>CONT<T>)
ExpresionesAlCerrar=Asigna(Info.ContMoneda, Nulo)
MenuPrincipal=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerRama
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroArbolClave=Cuenta
FiltroArbolValidar=Descripcion
FiltroArbolRama=Rama
FiltroArbolAcumulativas=EsAcumulativa
FiltroAncho=30
FiltroTipo=Arbol
FiltroEnOrden=S
FiltroTodoNombre=Contabilidad
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
PestanaOtroNombre=S
PestanaNombre=Cuentas
FiltroArbolTotalizarNivel2=
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
TablaIndependiente=Cta
FiltroExpresion=IrRama(FiltroActual)
FiltroIndependiente=S
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
FiltroListas=S
FiltroListasRama=CONT
FiltroListasAplicaEn=Cuenta
PermiteLocalizar=S

[Lista.Columnas]
Cuenta=99
Descripcion=176
0=164
1=114
SubCuenta=86
SaldoDeudor=86
SaldoAcreedor=80
Saldo=112
FinalDeudor=100
FinalAcreedor=98
InicioDeudor=80
InicoAcreedor=89
Inicio=93
Cargos=80
Abonos=85
Final=92
InicioAcreedor=83
CambioNeto=105
SaldoMedio=94
Comparacion=88
Diferencia=84
Porcentaje=36
Presupuesto=80

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

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreDesplegar=Información de la Cuenta
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
EnMenu=S
EspacioPrevio=S
Expresion=Asigna(Info.Cuenta, VerRama:Cuenta)<BR>Caso Explorar.Modulo <BR>  Es <T>CONT<T> Entonces Forma(<T>CtaInfo<T>)<BR>  Es <T>INV<T> Entonces Forma(<T>ArtInfo<T>)<BR>  Es <T>CXC<T> Entonces Forma(<T>CteInfo<T>)<BR>Fin
ActivoCondicion=Usuario.CteInfo

[Acciones.RamaSubir]
Nombre=RamaSubir
Boton=44
NombreDesplegar=Subir un nivel
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Rama Subir
Activo=S
Visible=S
EspacioPrevio=S
Carpeta=Lista
Menu=&Ver
EnMenu=S

[Acciones.Salir]
Nombre=Salir
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Desglosar]
Nombre=Desglosar
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Desglosar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VerAcum
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=IrDireccion(Explorar.Modulo, VerRama:Cuenta)

[Lista.Cuenta]
Carpeta=Lista
Clave=Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Descripcion]
Carpeta=Lista
Clave=Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SubCuenta]
Carpeta=Lista
Clave=SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.FinalDeudor]
Carpeta=Lista
Clave=FinalDeudor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.FinalAcreedor]
Carpeta=Lista
Clave=FinalAcreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Configurar]
Nombre=Configurar
Boton=45
Menu=&Archivo
NombreDesplegar=Con&figurar...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=F7
EspacioPrevio=S
EjecucionCondicion=ConfigurarExplorador(<T>Saldos<T>)=BotonAceptar

[Lista.Cargos]
Carpeta=Lista
Clave=Cargos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Abonos]
Carpeta=Lista
Clave=Abonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InicioDeudor]
Carpeta=Lista
Clave=InicioDeudor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InicioAcreedor]
Carpeta=Lista
Clave=InicioAcreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CambioNeto]
Carpeta=Lista
Clave=CambioNeto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SaldoMedio]
Carpeta=Lista
Clave=SaldoMedio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Diferencia]
Carpeta=Lista
Clave=Diferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Porcentaje]
Carpeta=Lista
Clave=Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Presupuesto]
Carpeta=Lista
Clave=Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Comparacion]
Carpeta=Lista
Clave=Comparacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
EspacioPrevio=
EnBarraHerramientas=S

[Acciones.RepPan]
Nombre=RepPan
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentación preliminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=VerRama
Activo=S
Visible=S
EspacioPrevio=

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Imprimir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Reportes Impresora
ClaveAccion=VerRama
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Moneda]
Nombre=Moneda
Boton=61
Menu=&Archivo
NombreDesplegar=Especificar Moneda...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=Forma(<T>EspecificarContMoneda<T>)

[Acciones.CuboDW]
Nombre=CuboDW
Boton=108
Menu=&Ver
NombreDesplegar=<T>Analizar &Detalle<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CuboContDW
Visible=S
ConCondicion=S
Antes=S
ActivoCondicion=General.Registro
EjecucionCondicion=ConDatos(VerRama:Cuenta)
AntesExpresiones=Asigna(Info.Cuenta, VerRama:Cuenta)<BR>Asigna(Info.Descripcion, VerRama:Descripcion)

[Acciones.AuditorNivelCta]
Nombre=AuditorNivelCta
Boton=0
Menu=&Ver
NombreDesplegar=<T>Auditor a Nivel Cuenta<T>
EnMenu=S
TipoAccion=Formas
ClaveAccion=ContDWSaldoModulo
Visible=S
ConCondicion=S
ActivoCondicion=General.Registro
EjecucionCondicion=ConDatos(VerRama:Cuenta)
Antes=S
AntesExpresiones=Asigna(Info.Cuenta, VerRama:Cuenta)<BR>Asigna(Info.Descripcion, VerRama:Descripcion)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=RamaSubir
RamaSubir=Imprimir
Imprimir=RepPan
RepPan=Excel
Excel=Desglosar
Desglosar=CuboDW
CuboDW=AuditorNivelCta
AuditorNivelCta=Informacion
Informacion=Configurar
Configurar=Moneda
Moneda=Salir
Salir=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cuenta
Cuenta=Descripcion
Descripcion=SubCuenta
SubCuenta=InicioDeudor
InicioDeudor=InicioAcreedor
InicioAcreedor=Cargos
Cargos=Abonos
Abonos=FinalDeudor
FinalDeudor=FinalAcreedor
FinalAcreedor=CambioNeto
CambioNeto=SaldoMedio
SaldoMedio=Comparacion
Comparacion=Presupuesto
Presupuesto=Diferencia
Diferencia=Porcentaje
Porcentaje=(Fin)
