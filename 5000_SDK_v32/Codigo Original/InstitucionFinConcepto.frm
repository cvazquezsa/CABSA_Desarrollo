[Forma]
Clave=InstitucionFinConcepto
Nombre=Conceptos (Conciliación)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Cuenta
ListaAcciones=(Lista)
PosicionInicialIzquierda=261
PosicionInicialArriba=157
PosicionInicialAlturaCliente=518
PosicionInicialAncho=1078
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

Totalizadores=S
PosicionSec1=456
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InstitucionFinConcepto
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
CarpetaVisible=S
Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=(Lista)
ValidarCampos=S
ListaCamposAValidar=Acreedor.Nombre

BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGeneral=InstitucionFinConcepto.Institucion=<T>{Info.Cuenta}<T>
[Lista.InstitucionFinConcepto.ConceptoBanco]
Carpeta=Lista
Clave=InstitucionFinConcepto.ConceptoBanco
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=10

[Lista.InstitucionFinConcepto.TipoMovimiento]
Carpeta=Lista
Clave=InstitucionFinConcepto.TipoMovimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.InstitucionFinConcepto.ConceptoGasto]
Carpeta=Lista
Clave=InstitucionFinConcepto.ConceptoGasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.InstitucionFinConcepto.PermiteAbonoNoIdentificado]
Carpeta=Lista
Clave=InstitucionFinConcepto.PermiteAbonoNoIdentificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Lista.Columnas]
ConceptoBanco=250
TipoMovimiento=84
ConceptoGasto=129
PermiteAbonoNoIdentificado=172
Acreedor=79
ObligacionFiscal=91
Tasa=39
TipoImporte=94
ObligacionFiscal2=95
PermiteCargoNoIdentificado=148

[Lista.InstitucionFinConcepto.Acreedor]
Carpeta=Lista
Clave=InstitucionFinConcepto.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.InstitucionFinConcepto.ObligacionFiscal]
Carpeta=Lista
Clave=InstitucionFinConcepto.ObligacionFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.InstitucionFinConcepto.Tasa]
Carpeta=Lista
Clave=InstitucionFinConcepto.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.InstitucionFinConcepto.TipoImporte]
Carpeta=Lista
Clave=InstitucionFinConcepto.TipoImporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.InstitucionFinConcepto.ObligacionFiscal2]
Carpeta=Lista
Clave=InstitucionFinConcepto.ObligacionFiscal2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.InstitucionFinConcepto.PermiteCargoNoIdentificado]
Carpeta=Lista
Clave=InstitucionFinConcepto.PermiteCargoNoIdentificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Acciones.Conceptos]
Nombre=Conceptos
Boton=55
NombreEnBoton=S
NombreDesplegar=Conceptos (Por Omisón)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion

Activo=S
Visible=S



GuardarAntes=S
Expresion=Si<BR>Confirmacion(<T>Se borraran todos los datos <BR> <BR> ¿Esta Seguro?<T>, BotonSi, BotonNo) = BotonSi<BR>Entonces<BR>  Asigna(Info.CuentaA,SQL(<T>SELECT Layout FROM InstitucionFin WHERE Institucion = :tInstitucion<T>, Info.Cuenta))<BR>  ProcesarSQL(<T>EXEC spConciliacionInsertarInstitucionFinConcepto :tInstitucion, :tLayout<T>, Info.Cuenta, Info.CuentaA)<BR>  ActualizarVista<BR>Fin
[Acciones.Conceptos.ListaAccionesMultiples]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=(Fin)





























[Lista.ListaEnCaptura]
(Inicio)=InstitucionFinConcepto.ConceptoBanco
InstitucionFinConcepto.ConceptoBanco=InstitucionFinConcepto.TipoMovimiento
InstitucionFinConcepto.TipoMovimiento=InstitucionFinConcepto.PermiteAbonoNoIdentificado
InstitucionFinConcepto.PermiteAbonoNoIdentificado=InstitucionFinConcepto.PermiteCargoNoIdentificado
InstitucionFinConcepto.PermiteCargoNoIdentificado=InstitucionFinConcepto.ConceptoGasto
InstitucionFinConcepto.ConceptoGasto=InstitucionFinConcepto.Acreedor
InstitucionFinConcepto.Acreedor=InstitucionFinConcepto.ObligacionFiscal
InstitucionFinConcepto.ObligacionFiscal=InstitucionFinConcepto.ObligacionFiscal2
InstitucionFinConcepto.ObligacionFiscal2=InstitucionFinConcepto.Tasa
InstitucionFinConcepto.Tasa=InstitucionFinConcepto.TipoImporte
InstitucionFinConcepto.TipoImporte=(Fin)

[Lista.ListaOrden]
(Inicio)=InstitucionFinConcepto.TipoMovimiento	(Acendente)
InstitucionFinConcepto.TipoMovimiento	(Acendente)=InstitucionFinConcepto.ConceptoBanco	(Acendente)
InstitucionFinConcepto.ConceptoBanco	(Acendente)=(Fin)
















[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total Registros
Totalizadores2=Conteo(InstitucionFinConcepto:InstitucionFinConcepto.ConceptoBanco)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S

Totalizadores3=#,




ListaEnCaptura=Total Registros

TotAlCambiar=S
[(Carpeta Totalizadores).Total Registros]
Carpeta=(Carpeta Totalizadores)
Clave=Total Registros
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=Conceptos
Conceptos=(Fin)
