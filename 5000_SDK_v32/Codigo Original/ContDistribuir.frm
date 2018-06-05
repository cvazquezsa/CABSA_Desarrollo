[Forma]
Clave=ContDistribuir
Nombre=Distribuir Presupuesto
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=271
PosicionInicialArriba=255
PosicionInicialAlturaCliente=487
PosicionInicialAncho=737
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Totalizadores=S
PosicionSeccion1=92
Comentarios=Lista(Info.Cuenta, Info.SubCuenta)
VentanaExclusiva=S
ExpresionesAlMostrar=EjecutarSQL(<T>spContDistribuirSugerir :nEstacion, :tCta<T>, EstacionTrabajo, Info.Cuenta)

[Lista]
Estilo=Hoja
Clave=Lista
ValidarCampos=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContDistribuir
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
ListaCamposAValidar=CentroCostos.Descripcion
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ContDistribuir.Estacion={EstacionTrabajo}

[Lista.ContDistribuir.Cuenta]
Carpeta=Lista
Clave=ContDistribuir.Cuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.ContDistribuir.SubCuenta]
Carpeta=Lista
Clave=ContDistribuir.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.ContDistribuir.Importe]
Carpeta=Lista
Clave=ContDistribuir.Importe
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
Antes=S
DespuesGuardar=S
AntesExpresiones=EjecutarSQL(<T>spContDistribuir :nEstacion, :tCta, :nID, :nRenglon, :nRenglonSub<T>,  EstacionTrabajo , Info.Cuenta, Info.ID, Info.Renglon, Info.RenglonSub)

[Lista.Columnas]
Cuenta=124
SubCuenta=124
Importe=128
Descripcion=320

[Lista.Cta.Descripcion]
Carpeta=Lista
Clave=Cta.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
NombreDesplegar=CambiarVista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
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
Totalizadores1=Importe Total<BR>Saldo Inicial<BR>Saldo Final
Totalizadores2=Suma(ContDistribuir:ContDistribuir.Importe)<BR>Info.Saldo<BR>Info.Saldo-Suma(ContDistribuir:ContDistribuir.Importe)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Saldo Inicial]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo Inicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[(Carpeta Totalizadores).Importe Total]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Total
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[(Carpeta Totalizadores).Saldo Final]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo Final
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

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

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=Guardar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
GuardarAntes=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Guardar
Guardar=CambiarVista
CambiarVista=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ContDistribuir.Cuenta
ContDistribuir.Cuenta=Cta.Descripcion
Cta.Descripcion=ContDistribuir.SubCuenta
ContDistribuir.SubCuenta=ContDistribuir.Importe
ContDistribuir.Importe=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Saldo Inicial
Saldo Inicial=Importe Total
Importe Total=Saldo Final
Saldo Final=(Fin)
