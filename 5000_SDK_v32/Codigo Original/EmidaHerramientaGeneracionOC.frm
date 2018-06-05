
[Forma]
Clave=EmidaHerramientaGeneracionOC
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Emida - Generar Orden Compra
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Variables
CarpetaPrincipal=Variables
PosicionInicialIzquierda=460
PosicionInicialArriba=289
PosicionInicialAlturaCliente=112
PosicionInicialAncho=360
ListaAcciones=(Lista)
ExpresionesAlMostrar=Asigna(Info.FechaD, Nulo)<BR>Asigna(Info.FechaA, Nulo)
PosicionSec1=261
PosicionSec2=482
[Variables]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Variables
Clave=Variables
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
[Variables.ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=(Fin)

[Variables.Info.FechaD]
Carpeta=Variables
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Variables.Info.FechaA]
Carpeta=Variables
Clave=Info.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Afectar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Afectar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=ProcesarSQL(<T>EXEC spEmidaGenerarOC :tUsuario, :tEmpresa, :nSucursal, :tFechaD, :tFechaA<T>, Usuario, Empresa, Sucursal, FechaFormatoServidor(Info.FechaD), FechaFormatoServidor(Info.FechaA))<BR>Forma(<T>Compra<T>)
[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreEnBoton=S
NombreDesplegar=Generar O.C.
Multiple=S
EnBarraHerramientas=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S












[Detalle.Columnas]
Articulo=84
CantidadNeta=49
Costo=75
DescuentoLinea=32
Importe=79
FechaRequerida=87
Almacen=69

Cantidad=48
FechaEntrega=77
[FormaExtraValor.Columnas]
VerCampo=360
VerValor=360

[MovImpuesto.Columnas]
0=100
1=100
2=100
3=100
4=100
5=100
6=100
7=100
8=100
9=100
10=100
11=100
12=100

[(Carpeta Abrir).Columnas]
0=155
1=78
2=100
3=100
4=100
5=100
6=100



[Acciones.Afectar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=(Fin)





















































[Forma.ListaAcciones]
(Inicio)=Afectar
Afectar=Cancelar
Cancelar=(Fin)
