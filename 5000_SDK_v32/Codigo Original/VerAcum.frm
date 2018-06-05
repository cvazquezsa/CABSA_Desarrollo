[Forma]
Clave=VerAcum
Icono=47
Modulos=(Todos)
ListaCarpetas=Acum
CarpetaPrincipal=Acum
PosicionInicialIzquierda=312
PosicionInicialArriba=274
PosicionInicialAltura=348
PosicionInicialAncho=816
PosicionSeccion1=82
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Nombre=<T>Explorando - <T>+Explorar.Direccion
Menus=S
PosicionColumna1=55
Comentarios=Lista(Info.ContMoneda, Si(Explorar.Grupo<><T><T>,e(Explorar.GrupoSingular)+<T>: <T>+Explorar.Grupo,<T><T>), e(Explorar.CuentaSingular)+<T>: <T>+Si(Explorar.Cuenta=<T><T>, <T>(todos)<T>,Explorar.Cuenta), e(<T>Ejercicio<T>)+<T>: <T>+Explorar.Ejercicio)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=321

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
ExpresionesAlMostrar=Asigna(Info.Almacen, <T>(todos)<T>)<BR>Asigna(Info.VerGrupo, Falso)
MenuPrincipal=(Lista)
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Desglose]
Nombre=Desglose
Boton=47
Menu=&Ver
NombreDesplegar=&Desglosar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerAux
Antes=S
Visible=S
ConCondicion=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
EnMenu=S
ActivoCondicion=Info.PuedeDesglosar
EjecucionCondicion=(VerAcum:Periodo>=1) y (VerAcum:Periodo<>999)
AntesExpresiones=IrDesglose(VerAcum:Ejercicio, VerAcum:Periodo, VerAcum:Moneda, <T>Dia<T>, <T>Normal<T>)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F4

[Acum]
Estilo=Hoja
PestanaNombre=Unidades
Clave=Acum
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerAcum
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática

[Acum.Mes]
Carpeta=Acum
Clave=Mes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acum.InicioU]
Carpeta=Acum
Clave=InicioU
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acum.Inicio]
Carpeta=Acum
Clave=Inicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acum.CargosU]
Carpeta=Acum
Clave=CargosU
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acum.Cargos]
Carpeta=Acum
Clave=Cargos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acum.AbonosU]
Carpeta=Acum
Clave=AbonosU
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acum.Abonos]
Carpeta=Acum
Clave=Abonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acum.FinalU]
Carpeta=Acum
Clave=FinalU
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acum.Final]
Carpeta=Acum
Clave=Final
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acum.Columnas]
Mes=86
InicioU=48
Inicio=106
CargosU=52
Cargos=109
AbonosU=52
Abonos=110
FinalU=50
Final=108
Moneda=57

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si(Explorar.Modulo en (<T>VTAS<T>, <T>INV<T>, <T>COMS<T>, <T>NOM<T>), ReporteImpresora(<T>VerAcumU<T>), ReporteImpresora(<T>VerAcum<T>))

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

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
NombreDesplegar=&Presentación preliminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si(Explorar.Modulo en (<T>VTAS<T>, <T>INV<T>, <T>COMS<T>, <T>NOM<T>), ReportePantalla(<T>VerAcumU<T>), ReportePantalla(<T>VerAcum<T>))

[Acum.Moneda]
Carpeta=Acum
Clave=Moneda
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
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
Visible=S
Carpeta=(Carpeta principal)
ClaveAccion=Enviar a Excel
Activo=S

[Acciones.Configurar]
Nombre=Configurar
Boton=45
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=Con&figurar...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
Activo=S
Visible=S
EspacioPrevio=S
ClaveAccion=Actualizar Vista
ConCondicion=S
EjecucionCondicion=ConfigurarExplorador(<T>Acumulados<T>)=BotonAceptar
EjecucionMensaje=

[Acciones.Almacen]
Nombre=Almacen
Boton=16
Menu=&Ver
NombreDesplegar=&Almacén Especifico...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
Antes=S
EnBarraHerramientas=S
EjecucionCondicion=Forma(<T>EspecificarAlmacen<T>)
AntesExpresiones=Si(Info.Almacen=<T>(TODOS)<T>, Asigna(Info.Almacen, Nulo))<BR>IrDireccion(<T>INV<T>, Explorar.Cuenta, Info.Almacen)
VisibleCondicion=Explorar.Rama=<T>INV<T>

[Acciones.Moneda]
Nombre=Moneda
Boton=64
Menu=&Ver
NombreDesplegar=&Moneda Especifica...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Forma(<T>EspecificarContMoneda<T>)



[Acum.ListaEnCaptura]
(Inicio)=Mes
Mes=Moneda
Moneda=Inicio
Inicio=InicioU
InicioU=Cargos
Cargos=CargosU
CargosU=Abonos
Abonos=AbonosU
AbonosU=Final
Final=FinalU
FinalU=(Fin)















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Desglose
Desglose=Moneda
Moneda=Imprimir
Imprimir=RepPantalla
RepPantalla=Graficar
Graficar=Excel
Excel=Configurar
Configurar=Almacen
Almacen=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)
