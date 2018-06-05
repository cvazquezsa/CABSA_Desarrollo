[Forma]
Clave=Reevaluacion
Nombre=<T>Reevaluar - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=690
PosicionInicialArriba=248
PosicionInicialAlturaCliente=340
PosicionInicialAncho=246
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=12
ExpresionesAlMostrar=Asigna(Info.Fecha, UltimoDiaMes(Hoy))<BR>EjecutarSQL(<T>spReevaluacionPreparar :nEstacion<T>,  EstacionTrabajo)

PosicionSec1=41
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=Reevaluacion
Fuente={Tahoma, 8, Negro, []}
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=Reevaluacion.Estacion={EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General

[Lista.Reevaluacion.Moneda]
Carpeta=Lista
Clave=Reevaluacion.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Reevaluacion.TipoCambio]
Carpeta=Lista
Clave=Reevaluacion.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Moneda=113
TipoCambio=83

[Acciones.Reevaluar]
Nombre=Reevaluar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Reevaluar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>Expresion<BR>Aceptar

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[(Variables)]
Estilo=Ficha
Clave=(Variables)
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
ListaEnCaptura=Info.Fecha
CarpetaVisible=S

[(Variables).Info.Fecha]
Carpeta=(Variables)
Clave=Info.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Reevaluar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Reevaluar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spReevaluar :nEstacion, :nSuc, :tEmp, :tUsr, :tModulo, :fFecha<T>, EstacionTrabajo, Sucursal, Empresa, Usuario, Info.Modulo, Info.Fecha)

[Acciones.Reevaluar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Lista.ListaEnCaptura]
(Inicio)=Reevaluacion.Moneda
Reevaluacion.Moneda=Reevaluacion.TipoCambio
Reevaluacion.TipoCambio=(Fin)



[Forma.ListaCarpetas]
(Inicio)=(Variables)
(Variables)=Lista
Lista=(Fin)

[Forma.ListaAcciones]
(Inicio)=Reevaluar
Reevaluar=Cancelar
Cancelar=(Fin)
