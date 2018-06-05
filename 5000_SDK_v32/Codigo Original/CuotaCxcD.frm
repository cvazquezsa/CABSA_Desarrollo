[Forma]
Clave=CuotaCxcD
Icono=0
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
Nombre=<T>Detalle - Cuotas<T>
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=517
PosicionInicialAncho=997
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=221
PosicionInicialArriba=173
BarraHerramientas=S
Comentarios=Lista(Modulo.Nombre(Info.Modulo), Info.Ejercicio,  PeriodoNombre(Info.Periodo) ) 
ListaAcciones=Aceptar
Totalizadores=S
PosicionSec1=452
ExpresionesAlMostrar=EJECUTARSQL(<T>spCuotaCxGenerar :tEmpresa, :tModulo, :nEjercicio, :nPeriodo, 1<T>,Empresa,Info.Modulo,Info.Ejercicio,Info.Periodo)

[DetalleCxp.Cxp.Mov]
Carpeta=DetalleCxp
Clave=Cxp.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DetalleCxp.Cxp.MovID]
Carpeta=DetalleCxp
Clave=Cxp.MovID
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[DetalleCxp.Cxp.FechaEmision]
Carpeta=DetalleCxp
Clave=Cxp.FechaEmision
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[DetalleCxp.CuotaCxD.Importe]
Carpeta=DetalleCxp
Clave=CuotaCxD.Importe
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[DetalleCxp.CuotaCxD.Saldo]
Carpeta=DetalleCxp
Clave=CuotaCxD.Saldo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[DetalleCxp.CuotaCxD.Vencimiento]
Carpeta=DetalleCxp
Clave=CuotaCxD.Vencimiento
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[DetalleCxp.CuotaCxD.ImporteCuota]
Carpeta=DetalleCxp
Clave=CuotaCxD.ImporteCuota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[DetalleCxp.CuotaCxD.FechaCuota]
Carpeta=DetalleCxp
Clave=CuotaCxD.FechaCuota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[DetalleCxp.CuotaCxD.Agente]
Carpeta=DetalleCxp
Clave=CuotaCxD.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[DetalleCxc.Columnas]
Mov=87
MovID=64
FechaEmision=76
Importe=64
Saldo=64
Vencimiento=72
ImporteCuota=96
FechaCuota=79
Agente=47
Observaciones=185
0=-2
1=-2
ImporteReal=66
FechaReal=94

[DetalleCxp.Columnas]
Mov=124
MovID=64
FechaEmision=94
Importe=64
Saldo=64
Vencimiento=94
ImporteCuota=71
FechaCuota=94
Agente=64
Observaciones=604

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[(Carpeta Totalizadores)]
PestanaOtroNombre=S
PestanaNombre=Totales
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
Totalizadores1=Importe<BR>Importe Promesa
Totalizadores2=Suma(CuotaCxDCobros:CuotaCxD.ImporteCuota)<BR>Suma(CuotaCxDCobros:CuotaCxD.ImporteReal)
Totalizadores3=(Monetario)<BR>(Monetario)
Totalizadores=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
TotCarpetaRenglones=DetalleCxc
ListaEnCaptura=(Lista)

[(Carpeta Totalizadores).Importe]
Carpeta=(Carpeta Totalizadores)
Clave=Importe
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[(Carpeta Totalizadores).Importe Promesa]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Promesa
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[Acciones.ObservacionesCxp]
Nombre=ObservacionesCxp
Boton=0
NombreDesplegar=Si(CuotaCxDCobros:CuotaCx.Estatus=<T>Elaboracion<T>, Informacion(CuotaCxDCobros:CuotaCxD.Observaciones), Pregunta(CuotaCxDCobros:CuotaCxD.Observaciones))
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
Expresion=Si(CuotaCxDCobros:CuotaCx.Estatus=<T>Aprobado<T>, Informacion(CuotaCxDCobros:CuotaCxD.Observaciones), Pregunta(CuotaCxDCobros:CuotaCxD.Observaciones))

[Lista]
Estilo=Hoja
PestanaNombre=Cuentas x cobrar
Clave=Lista
Filtros=S
ValidarCampos=S
BusquedaRapidaControles=S
PermiteEditar=S
RefrescarAlEntrar=S
GuardarAlSalir=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CuotaCxDCobros
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaCamposAValidar=Agente.Nombre
FiltroAplicaEn=CuotaCxD.Agente
FiltroPredefinido1=Moneda
FiltroPredefinido=S
FiltroAutoCampo=CuotaCxD.Agente
FiltroAutoValidar=CuotaCxD.Agente
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroEstilo=Folder (1 línea)
FiltroRespetar=S
FiltroTipo=Automático
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroFechasNormal=S
FiltroMonedasCampo=Cxc.Moneda
FiltroFechasNombre=&Fecha
CondicionEdicion=CuotaCx.Estatus = <T>Abierto<T>
CarpetaVisible=S
FiltroGeneral=CuotaCxD.ID = {Info.ID}

[Lista.Cxc.Mov]
Carpeta=Lista
Clave=Cxc.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxc.MovID]
Carpeta=Lista
Clave=Cxc.MovID
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxc.FechaEmision]
Carpeta=Lista
Clave=Cxc.FechaEmision
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxc.Vencimiento]
Carpeta=Lista
Clave=Cxc.Vencimiento
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuotaCxD.Saldo]
Carpeta=Lista
Clave=CuotaCxD.Saldo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuotaCxD.ImporteCuota]
Carpeta=Lista
Clave=CuotaCxD.ImporteCuota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuotaCxD.FechaCuota]
Carpeta=Lista
Clave=CuotaCxD.FechaCuota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuotaCxD.ImporteReal]
Carpeta=Lista
Clave=CuotaCxD.ImporteReal
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuotaCxD.FechaReal]
Carpeta=Lista
Clave=CuotaCxD.FechaReal
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuotaCxD.Agente]
Carpeta=Lista
Clave=CuotaCxD.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CuotaCxD.Observaciones]
Carpeta=Lista
Clave=CuotaCxD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mov=64
MovID=64
FechaEmision=68
Vencimiento=64
Saldo=64
ImporteCuota=88
FechaCuota=94
ImporteReal=66
FechaReal=94
Agente=64
Observaciones=604

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe
Importe=Importe Promesa
Importe Promesa=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cxc.Mov
Cxc.Mov=Cxc.MovID
Cxc.MovID=Cxc.FechaEmision
Cxc.FechaEmision=Cxc.Vencimiento
Cxc.Vencimiento=CuotaCxD.Saldo
CuotaCxD.Saldo=CuotaCxD.ImporteCuota
CuotaCxD.ImporteCuota=CuotaCxD.FechaCuota
CuotaCxD.FechaCuota=CuotaCxD.ImporteReal
CuotaCxD.ImporteReal=CuotaCxD.FechaReal
CuotaCxD.FechaReal=CuotaCxD.Agente
CuotaCxD.Agente=CuotaCxD.Observaciones
CuotaCxD.Observaciones=(Fin)
