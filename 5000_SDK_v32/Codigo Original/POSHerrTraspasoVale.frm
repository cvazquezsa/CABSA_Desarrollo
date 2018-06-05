
[Forma]
Clave=POSHerrTraspasoVale
Icono=0
CarpetaPrincipal=POSHerrTraspasoVale
Modulos=(Todos)
Nombre=Herramienta Traspaso Monedero

ListaCarpetas=POSHerrTraspasoVale
PosicionInicialIzquierda=433
PosicionInicialArriba=187
PosicionInicialAlturaCliente=447
PosicionInicialAncho=734
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSBorrarHerrTransferirVale :nEstacion<T>,EstacionTrabajo)
SinTransacciones=S
[POSHerrTraspasoVale]
Estilo=Hoja
Clave=POSHerrTraspasoVale
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSHerrTraspasoVale
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

FiltroGeneral=POSHerrTraspasoVale.Estacion = {EstacionTrabajo}
[POSHerrTraspasoVale.POSHerrTraspasoVale.MonederoD]
Carpeta=POSHerrTraspasoVale
Clave=POSHerrTraspasoVale.MonederoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSHerrTraspasoVale.Saldo]
Carpeta=POSHerrTraspasoVale
Clave=Saldo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSHerrTraspasoVale.POSHerrTraspasoVale.MonederoA]
Carpeta=POSHerrTraspasoVale
Clave=POSHerrTraspasoVale.MonederoA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSHerrTraspasoVale.Columnas]
MonederoD=124
Saldo=124
MonederoA=124

Error=321
[Lista.Columnas]
0=172
1=82
2=142

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
EnBarraHerramientas=S
ConfirmarAntes=S
DialogoMensaje=POSEstaSeguro
TipoAccion=Expresion
Activo=S
Visible=S


EspacioPrevio=S

GuardarAntes=S
Antes=S
DespuesGuardar=S
Expresion=ProcesarSQL(<T>spPOSHerrTransferirVale  :nEstacion,:tEmpresa,:tUsuario,:nSucursal<T>, EstacionTrabajo,Empresa,Usuario,Sucursal)
[POSHerrTraspasoVale.POSHerrTraspasoVale.Error]
Carpeta=POSHerrTraspasoVale
Clave=POSHerrTraspasoVale.Error
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco








[POSHerrTraspasoVale.ListaEnCaptura]
(Inicio)=POSHerrTraspasoVale.MonederoD
POSHerrTraspasoVale.MonederoD=Saldo
Saldo=POSHerrTraspasoVale.MonederoA
POSHerrTraspasoVale.MonederoA=POSHerrTraspasoVale.Error
POSHerrTraspasoVale.Error=(Fin)













[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Generar
Generar=(Fin)
