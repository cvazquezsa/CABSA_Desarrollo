[Forma]
Clave=VerEjercicio
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=399
PosicionInicialArriba=131
PosicionInicialAltura=534
PosicionInicialAncho=1025
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
Comentarios=Si(ConDatos(Info.Almacen), <T>Almacén: <T>+Info.Almacen+NuevaLinea)+<T>Ejercicio: <T>+Info.Ejercicio)
VentanaExclusiva=
VentanaEscCerrar=
ExpresionesAlMostrar=Asigna(Info.VerGrupo, Falso)
EsConsultaExclusiva=S

PosicionInicialAlturaCliente=507
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
NombreEnBoton=
Menu=&Ver
NombreDesplegar=&Desglosar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerAcum
Activo=S
Antes=S
Visible=S
ConCondicion=
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
EnMenu=S
AntesExpresiones=IrDireccion(<T>INV<T>, VerEjercicio:Cuenta)

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

[Acum.Columnas]
Mes=98
InicioU=60
Inicio=85
CargosU=53
Cargos=88
AbonosU=59
Abonos=89
FinalU=58
Final=88
Moneda=55

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
TipoAccion=Reportes Impresora
Activo=S
Visible=S
ClaveAccion=VerAcum

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
EspacioPrevio=
TipoAccion=Reportes Pantalla
Activo=S
Visible=S
ClaveAccion=VerAcum

[Acciones.Excel]
Nombre=Excel
Boton=65
Menu=&Archivo
NombreDesplegar=Enviar a MS E&xcel
EnBarraHerramientas=
EnMenu=S
TipoAccion=Controles Captura
Visible=S
Carpeta=(Carpeta principal)
ClaveAccion=Enviar a Excel
Activo=S

[Acciones.Copiar]
Nombre=Copiar
Boton=65
Menu=&Archivo
NombreDesplegar=C&opiar datos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+C
EspacioPrevio=

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

[Lista]
Estilo=Hoja
PestanaNombre=Cuentas
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerEjercicio
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
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

[Lista.P0]
Carpeta=Lista
Clave=P0
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU0]
Carpeta=Lista
Clave=PU0
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.P1]
Carpeta=Lista
Clave=P1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU1]
Carpeta=Lista
Clave=PU1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.P2]
Carpeta=Lista
Clave=P2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU2]
Carpeta=Lista
Clave=PU2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.P3]
Carpeta=Lista
Clave=P3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU3]
Carpeta=Lista
Clave=PU3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.P4]
Carpeta=Lista
Clave=P4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU4]
Carpeta=Lista
Clave=PU4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.P5]
Carpeta=Lista
Clave=P5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU5]
Carpeta=Lista
Clave=PU5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.P6]
Carpeta=Lista
Clave=P6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU6]
Carpeta=Lista
Clave=PU6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.P7]
Carpeta=Lista
Clave=P7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU7]
Carpeta=Lista
Clave=PU7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.P8]
Carpeta=Lista
Clave=P8
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU8]
Carpeta=Lista
Clave=PU8
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.P9]
Carpeta=Lista
Clave=P9
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU9]
Carpeta=Lista
Clave=PU9
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.P10]
Carpeta=Lista
Clave=P10
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU10]
Carpeta=Lista
Clave=PU10
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.P11]
Carpeta=Lista
Clave=P11
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU11]
Carpeta=Lista
Clave=PU11
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.P12]
Carpeta=Lista
Clave=P12
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU12]
Carpeta=Lista
Clave=PU12
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.P13]
Carpeta=Lista
Clave=P13
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.PU13]
Carpeta=Lista
Clave=PU13
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.Final]
Carpeta=Lista
Clave=Final
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.FinalU]
Carpeta=Lista
Clave=FinalU
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.Moneda]
Carpeta=Lista
Clave=Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

ColorFondo=Blanco
[Lista.Columnas]
0=103
1=52
Cuenta=108
P0=68
P1=69
P2=68
P3=72
P4=71
P5=72
P6=71
P7=74
P8=73
P9=76
P10=73
P11=74
P12=70
Final=78
FinalU=38
Moneda=58
PU0=38
PU1=33
PU2=34
PU3=32
PU4=33
PU5=33
PU6=26
PU7=27
PU8=31
PU9=25
PU10=26
PU11=23
PU12=29

Descripcion=199
[Lista.Cuenta]
Carpeta=Lista
Clave=Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=Cuenta
Cuenta=Descripcion
Descripcion=P0
P0=PU0
PU0=P1
P1=PU1
PU1=P2
P2=PU2
PU2=P3
P3=PU3
PU3=P4
P4=PU4
PU4=P5
P5=PU5
PU5=P6
P6=PU6
PU6=P7
P7=PU7
PU7=P8
P8=PU8
PU8=P9
P9=PU9
PU9=P10
P10=PU10
PU10=P11
P11=PU11
PU11=P12
P12=PU12
PU12=P13
P13=PU13
PU13=Final
Final=FinalU
FinalU=Moneda
Moneda=(Fin)

[Lista.Descripcion]
Carpeta=Lista
Clave=Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Desglose
Desglose=Imprimir
Imprimir=RepPantalla
RepPantalla=Graficar
Graficar=Excel
Excel=Copiar
Copiar=Configurar
Configurar=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)
