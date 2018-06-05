
[Forma]
Clave=RepLayoutNomina
Icono=0
Modulos=(Todos)
MovModulo=RepLayoutNomina
Nombre=Dispersión de Nómina

ListaCarpetas=RepLayoutNomina
CarpetaPrincipal=RepLayoutNomina
PosicionInicialAlturaCliente=300
PosicionInicialAncho=458
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=454
PosicionInicialArriba=194
ExpresionesAlMostrar=Asigna(Info.Layout,<T>Bancomer<T>)
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[RepLayoutNomina]
Estilo=Ficha
Clave=RepLayoutNomina
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepLayoutNomina
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

PermiteEditar=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=RepLayoutNomina.Estacion = {EstacionTrabajo}
[RepLayoutNomina.RepLayoutNomina.InfoLayoutNomina]
Carpeta=RepLayoutNomina
Clave=RepLayoutNomina.InfoLayoutNomina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepLayoutNomina.RepLayoutNomina.InfoMov]
Carpeta=RepLayoutNomina
Clave=RepLayoutNomina.InfoMov
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepLayoutNomina.RepLayoutNomina.InfoMovID]
Carpeta=RepLayoutNomina
Clave=RepLayoutNomina.InfoMovID
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepLayoutNomina.RepLayoutNomina.InfoSucursal]
Carpeta=RepLayoutNomina
Clave=RepLayoutNomina.InfoSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[RepLayoutNomina.RepLayoutNomina.InfoCtaDinero]
Carpeta=RepLayoutNomina
Clave=RepLayoutNomina.InfoCtaDinero
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[RepLayoutNomina.RepLayoutNomina.InfoDescripcion]
Carpeta=RepLayoutNomina
Clave=RepLayoutNomina.InfoDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[RepLayoutNomina.RepLayoutNomina.InfoFechaD]
Carpeta=RepLayoutNomina
Clave=RepLayoutNomina.InfoFechaD
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[RepLayoutNomina.RepLayoutNomina.InfoNumeroCliente]
Carpeta=RepLayoutNomina
Clave=RepLayoutNomina.InfoNumeroCliente
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[RepLayoutNomina.RepLayoutNomina.InfoConsecutivo]
Carpeta=RepLayoutNomina
Clave=RepLayoutNomina.InfoConsecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreDesplegar=Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

NombreEnBoton=S
GuardarAntes=S

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=RepNominaLayout
Activo=S
Visible=S




EspacioPrevio=S
GuardarAntes=S
Antes=S
AntesExpresiones=Asigna(Info.Layout,RepLayoutNomina:RepLayoutNomina.InfoLayoutNomina)
[Acciones.RepPan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

[Acciones.RepPan.Ir a la Carpeta]
Nombre=Ir a la Carpeta
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Ir a la Carpeta
Activo=S
Visible=S





[Acciones.RepPan.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Ir a la Carpeta
Ir a la Carpeta=(Fin)





















[(Carpeta Abrir).Columnas]
0=122
1=159
2=-2
3=-2
4=-2
5=-2




[Lista.Columnas]
0=84
1=111
2=-2












































































































[RepLayoutNomina.ListaEnCaptura]
(Inicio)=RepLayoutNomina.InfoLayoutNomina
RepLayoutNomina.InfoLayoutNomina=RepLayoutNomina.InfoMov
RepLayoutNomina.InfoMov=RepLayoutNomina.InfoMovID
RepLayoutNomina.InfoMovID=RepLayoutNomina.InfoSucursal
RepLayoutNomina.InfoSucursal=RepLayoutNomina.InfoCtaDinero
RepLayoutNomina.InfoCtaDinero=RepLayoutNomina.InfoNumeroCliente
RepLayoutNomina.InfoNumeroCliente=RepLayoutNomina.InfoDescripcion
RepLayoutNomina.InfoDescripcion=RepLayoutNomina.InfoFechaD
RepLayoutNomina.InfoFechaD=RepLayoutNomina.InfoConsecutivo
RepLayoutNomina.InfoConsecutivo=(Fin)





















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=RepPan
RepPan=(Fin)
