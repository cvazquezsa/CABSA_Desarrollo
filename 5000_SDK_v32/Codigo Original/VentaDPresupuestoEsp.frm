[Forma]
Clave=VentaDPresupuestoEsp
Nombre=Presupuesto Especifico
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=410
PosicionInicialArriba=281
PosicionInicialAlturaCliente=434
PosicionInicialAncho=460
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Totalizadores=S
PosicionSec1=369
Comentarios=Lista(Info.Articulo,  MonetarioEnTexto(Info.Importe))
ExpresionesAlMostrar=EjecutarSQL(<T>spVentaDPresupuestoEsp :nID, :nRenglon, :nRenglonSub, :tArt, :nImporte<T>, Info.ID, Info.Renglon, Info.RenglonSub, Info.Articulo, Info.Importe)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaDPresupuestoEsp
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=VentaDPresupuestoEsp.ID={Info.ID} AND VentaDPresupuestoEsp.Renglon={Info.Renglon} AND VentaDPresupuestoEsp.RenglonSub={Info.RenglonSub}
CondicionEdicion=Info.PuedeEditar

[Lista.VentaDPresupuestoEsp.CuentaPresupuesto]
Carpeta=Lista
Clave=VentaDPresupuestoEsp.CuentaPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDPresupuestoEsp.Importe]
Carpeta=Lista
Clave=VentaDPresupuestoEsp.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Si(Suma(VentaDPresupuestoEsp:VentaDPresupuestoEsp.Importe)<>Info.Importe, Si(Precaucion(<T>No Cuadra<T>, BotonAceptar, BotonCancelar)=BotonAceptar, Verdadero, Falso), Verdadero)

[Lista.Columnas]
CuentaPresupuesto=124
Importe=86
Descripcion=210

[Lista.Cta.Descripcion]
Carpeta=Lista
Clave=Cta.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total
Totalizadores2=Suma(VentaDPresupuestoEsp:VentaDPresupuestoEsp.Importe)
Totalizadores3=(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CarpetaVisible=S

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaDPresupuestoEsp.CuentaPresupuesto
VentaDPresupuestoEsp.CuentaPresupuesto=Cta.Descripcion
Cta.Descripcion=VentaDPresupuestoEsp.Importe
VentaDPresupuestoEsp.Importe=(Fin)
