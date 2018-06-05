[Forma]
Clave=ExplorarCentroCostos
Nombre=<T>Explorando - Centros de Costos<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=393
PosicionInicialArriba=218
PosicionInicialAltura=461
PosicionInicialAncho=654
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Menus=S
Comentarios=Lista(Info.ContMoneda,<BR>Si <BR>  Explorar.VerSaldoActual<BR>Entonces<BR> <T>Saldo Actual<T><BR>Sino<BR>  +Si(Explorar.Acumulado,<T>Acumulado<T>,<T>De <T>+MesNombre(Explorar.PeriodoDe))<BR>  +Si(Explorar.Acumulado o (Explorar.PeriodoDe<>Explorar.PeriodoA),<T> a <T>+MesNombre(Explorar.PeriodoA))<BR>  +NuevaLinea+<T>Año: <T>+ Explorar.Ejercicio<BR>Fin)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=434
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.ContMoneda, Config.ContMoneda)<BR>Asigna(Info.Vista, <T>Resumen<T>)<BR>IrModulo(<T>CC<T>)
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
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
PermiteLocalizar=S

[Lista.Columnas]
Cuenta=99
Descripcion=206
0=164
1=114
SubCuenta=86
SaldoDeudor=86
SaldoAcreedor=80
Saldo=112
FinalDeudor=108
FinalAcreedor=109
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

[Acciones.Configurar]
Nombre=Configurar
Boton=45
Menu=&Archivo
NombreDesplegar=Con&figurar...
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=F7
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

[Lista.Abonos]
Carpeta=Lista
Clave=Abonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.FinalDeudor]
Carpeta=Lista
Clave=FinalDeudor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InicioDeudor]
Carpeta=Lista
Clave=InicioDeudor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.DesglosarCta]
Nombre=DesglosarCta
Boton=78
Menu=&Ver
NombreDesplegar=Desglosar (por &Cuenta)
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarCentroCostosCta
Activo=S
Visible=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
EspacioPrevio=S
AntesExpresiones=Asigna(Info.SubCuenta, VerRama:Cuenta)<BR>Asigna(Info.Ejercicio, EjercicioTrabajo)

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
EjecucionCondicion=Forma(<T>EspecificarContMoneda<T>)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=RamaSubir
RamaSubir=Imprimir
Imprimir=RepPan
RepPan=Excel
Excel=DesglosarCta
DesglosarCta=Desglosar
Desglosar=Configurar
Configurar=Salir
Salir=Moneda
Moneda=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cuenta
Cuenta=Descripcion
Descripcion=InicioDeudor
InicioDeudor=Cargos
Cargos=Abonos
Abonos=FinalDeudor
FinalDeudor=Comparacion
Comparacion=Presupuesto
Presupuesto=Diferencia
Diferencia=Porcentaje
Porcentaje=(Fin)
