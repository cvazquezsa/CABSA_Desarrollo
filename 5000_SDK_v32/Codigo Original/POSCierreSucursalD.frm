
[Forma]
Clave=POSCierreSucursalD
Icono=0
CarpetaPrincipal=POSCierreSucursalD
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=POSCierreSucursalD
ListaAcciones=(Lista)
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSGenerarCierreSucursalInicializar :tEmpresa,:nSucursal,:nEstacion,:tUsuario<T>,Empresa,Sucursal,EstacionTrabajo,Usuario)
PosicionInicialIzquierda=467
PosicionInicialArriba=245
PosicionInicialAlturaCliente=273
PosicionInicialAncho=720
Comentarios=Usuario
Nombre=Generar Cierre Sucursal
[POSCierreSucursalD]
Estilo=Hoja
Clave=POSCierreSucursalD
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCierreSucursalD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
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
FiltroGeneral=POSCierreSucursalD.Estacion = {EstacionTrabajo}
[POSCierreSucursalD.POSCierreSucursalD.FormaPago]
Carpeta=POSCierreSucursalD
Clave=POSCierreSucursalD.FormaPago
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[POSCierreSucursalD.POSCierreSucursalD.Importe]
Carpeta=POSCierreSucursalD
Clave=POSCierreSucursalD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSCierreSucursalD.POSCierreSucursalD.Referencia]
Carpeta=POSCierreSucursalD
Clave=POSCierreSucursalD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Expresion]
Nombre=Expresion
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar Cierre
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

GuardarAntes=S





EspacioPrevio=S

ConCondicion=S
Expresion=FormaModal(<T>POSCierreSucursalTemp<T>)
EjecucionCondicion=ConDatos(POSCierreSucursalD:POSCierreSucursalD.CtaDineroDestino)
EjecucionMensaje=<T>Es Necesario Capturar la Cuenta de Dinero<T>
EjecucionConError=S
[POSCierreSucursalD.Columnas]
FormaPago=304
Importe=64
Referencia=304






























CtaDineroDestino=112
[Lista.Columnas]
0=84
1=111
2=-2






















[POSCierreSucursalD.ListaEnCaptura]
(Inicio)=POSCierreSucursalD.FormaPago
POSCierreSucursalD.FormaPago=POSCierreSucursalD.Importe
POSCierreSucursalD.Importe=POSCierreSucursalD.CtaDineroDestino
POSCierreSucursalD.CtaDineroDestino=POSCierreSucursalD.Referencia
POSCierreSucursalD.Referencia=(Fin)

[POSCierreSucursalD.POSCierreSucursalD.CtaDineroDestino]
Carpeta=POSCierreSucursalD
Clave=POSCierreSucursalD.CtaDineroDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco





































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Expresion
Expresion=(Fin)
