[Forma]
Clave=MovSituacionL
Nombre=<T>Situaciones - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=481
PosicionInicialArriba=209
PosicionInicialAltura=300
PosicionInicialAncho=424
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

PosicionInicialAlturaCliente=306
PosicionSec1=381
PosicionCol1=761
PosicionCol2=509
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovSituacionL
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=MovSituacionL.Modulo=<T>{Info.Modulo}<T>
[Lista.MovSituacionL.Mov]
Carpeta=Lista
Clave=MovSituacionL.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MovSituacionL.Estatus]
Carpeta=Lista
Clave=MovSituacionL.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Columnas]
Modulo=39
Mov=156
Estatus=115

Flujo=91
Situacion=161
Orden=38
PermiteAfectacion=79
PermiteRetroceder=59
PermiteBrincar=40
SMS=63
ControlUsuarios=83
Tiempo=40

0=146
1=294
2=117
3=124
[Acciones.Situaciones]
Nombre=Situaciones
Boton=47
NombreEnBoton=S
NombreDesplegar=&Situaciones
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Antes=S
ConCondicion=S
EspacioPrevio=S


Expresion=Si no(General.MovSituacionBinaria) o(General.MovSituacionBinaria y(MovSituacionL:MovSituacionL.Flujo = <T>Normal<T>))<BR>Entonces<BR>  Forma(<T>MovSituacion<T>)<BR>Sino<BR>  Caso MovSituacionL:MovSituacionL.Modulo<BR>    Es <T>AF<T> Entonces Forma(<T>MovSituacionAFBinaria<T>)<BR>    Es <T>AGENT<T> Entonces Forma(<T>MovSituacionAGENTBinaria<T>)  <BR>    Es <T>ASIS<T> Entonces Forma(<T>MovSituacionASISBinaria<T>)  <BR>    Es <T>CAM<T> Entonces Forma(<T>MovSituacionCAMBinaria<T>)  <BR>    Es <T>CAP<T> Entonces Forma(<T>MovSituacionCAPBinaria<T>)  <BR>    Es <T>CAPT<T> Entonces Forma(<T>MovSituacionCAPTBinaria<T>)  <BR>    Es <T>CMP<T> Entonces Forma(<T>MovSituacionCMPBinaria<T>)  <BR>    Es <T>COMS<T> Entonces Forma(<T>MovSituacionCOMSBinaria<T>)  <BR>    Es <T>CONC<T> Entonces Forma(<T>MovSituacionCONCBinaria<T>)  <BR>    Es <T>CONT<T> Entonces Forma(<T>MovSituacionCONTBinaria<T>)  <BR>    Es <T>CORTE<T> Entonces Forma(<T>MovSituacionCORTEBinaria<T>)  <BR>    Es <T>CP<T> Entonces Forma(<T>MovSituacionCPBinaria<T>)  <BR>    Es <T>CR<T> Entonces Forma(<T>MovSituacionCRBinaria<T>)  <BR>    Es <T>CREDI<T> Entonces Forma(<T>MovSituacionCREDIBinaria<T>)  <BR>    Es <T>CXC<T> Entonces Forma(<T>MovSituacionCXCBinaria<T>)  <BR>    Es <T>CXP<T> Entonces Forma(<T>MovSituacionCXPBinaria<T>)  <BR>    Es <T>DIN<T> Entonces Forma(<T>MovSituacionDINBinaria<T>)  <BR>    Es <T>EMB<T> Entonces Forma(<T>MovSituacionEMBBinaria<T>)  <BR>    Es <T>FIS<T> Entonces Forma(<T>MovSituacionFISBinaria<T>)  <BR>    Es <T>FRM<T> Entonces Forma(<T>MovSituacionFRMBinaria<T>)  <BR>    Es <T>GAS<T> Entonces Forma(<T>MovSituacionGASBinaria<T>)  <BR>    Es <T>GES<T> Entonces Forma(<T>MovSituacionGESBinaria<T>)  <BR>    Es <T>INC<T> Entonces Forma(<T>MovSituacionINCBinaria<T>)  <BR>    Es <T>INV<T> Entonces Forma(<T>MovSituacionINVBinaria<T>)  <BR>    Es <T>ISL<T> Entonces Forma(<T>MovSituacionISLBinaria<T>)  <BR>    Es <T>MEX01<T> Entonces Forma(<T>MovSituacionMEX01Binaria<T>)  <BR>    Es <T>NOM<T> Entonces Forma(<T>MovSituacionNOMBinaria<T>)  <BR>    Es <T>OFER<T> Entonces Forma(<T>MovSituacionOFERBinaria<T>)  <BR>    Es <T>ORG<T> Entonces Forma(<T>MovSituacionORGBinaria<T>)  <BR>    Es <T>PACTO<T> Entonces Forma(<T>MovSituacionPACTOBinaria<T>)  <BR>    Es <T>PC<T> Entonces Forma(<T>MovSituacionPCBinaria<T>)  <BR>    Es <T>PCP<T> Entonces Forma(<T>MovSituacionPCPBinaria<T>)  <BR>    Es <T>PPTO<T> Entonces Forma(<T>MovSituacionPPTOBinaria<T>)  <BR>    Es <T>PROD<T> Entonces Forma(<T>MovSituacionPRODBinaria<T>)  <BR>    Es <T>PROY<T> Entonces Forma(<T>MovSituacionPROYBinaria<T>)  <BR>    Es <T>RE<T> Entonces Forma(<T>MovSituacionREBinaria<T>)  <BR>    Es <T>RH<T> Entonces Forma(<T>MovSituacionRHBinaria<T>)  <BR>    Es <T>RSS<T> Entonces Forma(<T>MovSituacionRSSBinaria<T>)  <BR>    Es <T>SAUX<T> Entonces Forma(<T>MovSituacionSAUXBinaria<T>)  <BR>    Es <T>ST<T> Entonces Forma(<T>MovSituacionSTBinaria<T>)  <BR>    Es <T>TMA<T> Entonces Forma(<T>MovSituacionTMABinaria<T>)  <BR>    Es <T>VALE<T> Entonces Forma(<T>MovSituacionVALEBinaria<T>)  <BR>    Es <T>VTAS<T> Entonces Forma(<T>MovSituacionVTASBinaria<T>)<BR>  Sino<BR>    Forma(<T>MovSituacionBinaria<T>)<BR>Fin
EjecucionCondicion=ConDatos(MovSituacionL:MovSituacionL.Mov) y ConDatos(MovSituacionL:MovSituacionL.Estatus)
AntesExpresiones=Asigna(Info.Mov, MovSituacionL:MovSituacionL.Mov)<BR>Asigna(Info.Estatus, MovSituacionL:MovSituacionL.Estatus)<BR>Asigna(Info.Descripcion, Info.Mov+<T> (<T>+ Minusculas(Info.Estatus)+<T>)<T> )
[Lista.ListaEnCaptura]
(Inicio)=MovSituacionL.Mov
MovSituacionL.Mov=MovSituacionL.Estatus
MovSituacionL.Estatus=MovSituacionL.Flujo
MovSituacionL.Flujo=(Fin)

[Lista.MovSituacionL.Flujo]
Carpeta=Lista
Clave=MovSituacionL.Flujo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Situaciones
Situaciones=(Fin)
