[Forma]
Clave=CxpPagarEnLote
Nombre=Pagar en Lote
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=470
PosicionInicialArriba=244
PosicionInicialAlturaCliente=675
PosicionInicialAncho=980
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Totalizadores=S
PosicionSec1=612

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxpPagarEnLote
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
PestanaNombre=Movimientos
HojaMostrarColumnas=S
ValidarCampos=S
ListaCamposAValidar=Prov.Nombre
MenuLocal=S
ListaAcciones=Copiar
FiltroGeneral=CxpPagarEnLote.Estacion={EstacionTrabajo}

[Lista.MovNombre]
Carpeta=Lista
Clave=MovNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
MovNombre=120
Referencia=93
Concepto=92
Proveedor=69
ImporteTotal=112
ImporteAPagar=94
Condicion=107
Vencimiento=81
Saldo=95
Calificacion=59

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

[Lista.Cxp.Referencia]
Carpeta=Lista
Clave=Cxp.Referencia
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxp.Concepto]
Carpeta=Lista
Clave=Cxp.Concepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxp.Condicion]
Carpeta=Lista
Clave=Cxp.Condicion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxp.Proveedor]
Carpeta=Lista
Clave=Cxp.Proveedor
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxp.Vencimiento]
Carpeta=Lista
Clave=Cxp.Vencimiento
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cxp.Saldo]
Carpeta=Lista
Clave=Cxp.Saldo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxpPagarEnLote.ImporteAPagar]
Carpeta=Lista
Clave=CxpPagarEnLote.ImporteAPagar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Sugerir]
Nombre=Sugerir
Boton=20
NombreEnBoton=S
NombreDesplegar=&Sugerir
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Info.Vencimiento, Hoy)<BR>Si<BR>  Forma(<T>EspecificarPagarEnLote<T>)<BR>Entonces<BR>   EjecutarSQL(<T>spCxpPagarEnLoteSugerir :tEmpresa, :nEstacion, :fVencimiento, :nImporte, :tMoneda<T>, Empresa, EstacionTrabajo, Info.Vencimiento, Info.Importe, Info.Moneda )<BR>   Forma.ActualizarVista(<T>Lista<T>) <BR>Fin

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
Totalizadores1=Saldo<BR>Importe a Pagar<BR>Conteo
Totalizadores2=Suma(CxpPagarEnLote:Cxp.Saldo)<BR>Suma(CxpPagarEnLote:CxpPagarEnLote.ImporteAPagar)<BR>Conteo
Totalizadores3=(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Saldo]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Importe a Pagar]
Carpeta=(Carpeta Totalizadores)
Clave=Importe a Pagar
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Copiar]
Nombre=Copiar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Copiar
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(CxpPagarEnLote:CxpPagarEnLote.ImporteAPagar, CxpPagarEnLote:Cxp.Saldo)
Activo=S
Visible=S

[Acciones.Procesar]
Nombre=Procesar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Procesar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spCxpPagarEnLoteProcesar :tEmpresa, :nEstacion<T>, Empresa, EstacionTrabajo)<BR>Forma.ActualizarVista(<T>Lista<T>)

[Lista.CxpPagarEnLote.Calificacion]
Carpeta=Lista
Clave=CxpPagarEnLote.Calificacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Sugerir
Sugerir=Procesar
Procesar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MovNombre
MovNombre=Cxp.Referencia
Cxp.Referencia=Cxp.Concepto
Cxp.Concepto=Cxp.Condicion
Cxp.Condicion=Cxp.Proveedor
Cxp.Proveedor=CxpPagarEnLote.Calificacion
CxpPagarEnLote.Calificacion=Cxp.Vencimiento
Cxp.Vencimiento=ImporteTotal
ImporteTotal=Cxp.Saldo
Cxp.Saldo=CxpPagarEnLote.ImporteAPagar
CxpPagarEnLote.ImporteAPagar=(Fin)

[Lista.ListaOrden]
(Inicio)=CxpPagarEnLote.Calificacion<TAB>(Decendente)
CxpPagarEnLote.Calificacion<TAB>(Decendente)=Cxp.Proveedor<TAB>(Acendente)
Cxp.Proveedor<TAB>(Acendente)=Cxp.Vencimiento<TAB>(Acendente)
Cxp.Vencimiento<TAB>(Acendente)=Cxp.ID<TAB>(Acendente)
Cxp.ID<TAB>(Acendente)=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Saldo
Saldo=Importe a Pagar
Importe a Pagar=Conteo
Conteo=(Fin)
