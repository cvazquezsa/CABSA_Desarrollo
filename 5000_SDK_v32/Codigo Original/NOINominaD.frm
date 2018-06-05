
[Forma]
Clave=NOINominaD
Icono=0
Modulos=(Todos)
CarpetaPrincipal=NOINominaD
Modulos=(Todos)
Nombre=Detalle Nomina

ListaCarpetas=NOINominaD
PosicionInicialAlturaCliente=175
PosicionInicialAncho=612
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=447
PosicionInicialArriba=323

Comentarios=Lista(Info.Personal,Info.Nombre)
[NOIDepartamento.ListaEnCaptura]
(Inicio)=NOIDepartamento.Departamento
NOIDepartamento.Departamento=NOIDepartamento.Sucursal
NOIDepartamento.Sucursal=NOIDepartamento.Ok
NOIDepartamento.Ok=NOIDepartamento.OkRef
NOIDepartamento.OkRef=(Fin)





[NOIDepartamento.Columnas]
Departamento=304
Sucursal=64
Ok=64
OkRef=198

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
















[NOINomina.Columnas]
Personal=64
Tipo=76
FechaD=94
FechaA=94
SueldoDiario=64
TotalPer=64
TotalDed=64
IMSS=64
ISPT=64
Infonavit=64
NetoPagado=64
Ok=64
OkRef=192








[NOINomina.ListaEnCaptura]
(Inicio)=NOINomina.Personal
NOINomina.Personal=NOINomina.Tipo
NOINomina.Tipo=NOINomina.FechaD
NOINomina.FechaD=NOINomina.FechaA
NOINomina.FechaA=NOINomina.SueldoDiario
NOINomina.SueldoDiario=NOINomina.TotalPer
NOINomina.TotalPer=NOINomina.TotalDed
NOINomina.TotalDed=NOINomina.IMSS
NOINomina.IMSS=NOINomina.ISPT
NOINomina.ISPT=NOINomina.Infonavit
NOINomina.Infonavit=NOINomina.NetoPagado
NOINomina.NetoPagado=NOINomina.Ok
NOINomina.Ok=NOINomina.OkRef
NOINomina.OkRef=(Fin)









[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=ReImportar
ReImportar=(Fin)

[NOINominaD]
Estilo=Hoja
Clave=NOINominaD
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NOINominaD
Fuente={Tahoma, 8, Negro, []}
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S















FiltroGeneral=NOINominaD.Estacion= {EstacionTrabajo} AND NOINominaD.Nomina = <T>{Info.Aplica}<T> AND NOINominaD.Personal = <T>{Info.Personal}<T>
[NOINominaD.NOINominaD.NominaConcepto]
Carpeta=NOINominaD
Clave=NOINominaD.NominaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[NOINominaD.NOINominaD.Valor]
Carpeta=NOINominaD
Clave=NOINominaD.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[NOINominaD.Columnas]
NominaConcepto=161
Valor=64

Concepto=212
Movimiento=124

[NOINominaD.NOINominaConcepto.Concepto]
Carpeta=NOINominaD
Clave=NOINominaConcepto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[NOINominaD.NOINominaConcepto.Movimiento]
Carpeta=NOINominaD
Clave=NOINominaConcepto.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[NOINominaD.ListaEnCaptura]
(Inicio)=NOINominaD.NominaConcepto
NOINominaD.NominaConcepto=NOINominaConcepto.Concepto
NOINominaConcepto.Concepto=NOINominaConcepto.Movimiento
NOINominaConcepto.Movimiento=NOINominaD.Valor
NOINominaD.Valor=(Fin)
