
[Forma]
Clave=POSFacturarNotasTemp
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=POSFacturarNotasTemp
CarpetaPrincipal=POSFacturarNotasTemp
PosicionInicialIzquierda=620
PosicionInicialArriba=356
PosicionInicialAlturaCliente=109
PosicionInicialAncho=360
ListaAcciones=(Lista)
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSBorrarPOSFacturarNotasTemp :nEstacion<T>,EstacionTrabajo)
[POSFacturarNotasTemp]
Estilo=Ficha
Clave=POSFacturarNotasTemp
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSFacturarNotasTemp
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
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=POSFacturarNotasTemp.Estacion = {EstacionTrabajo}
[POSFacturarNotasTemp.POSFacturarNotasTemp.MovFactura]
Carpeta=POSFacturarNotasTemp
Clave=POSFacturarNotasTemp.MovFactura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSFacturarNotasTemp.POSFacturarNotasTemp.Cliente]
Carpeta=POSFacturarNotasTemp
Clave=POSFacturarNotasTemp.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSFacturarNotasTemp.ListaEnCaptura]
(Inicio)=POSFacturarNotasTemp.MovFactura
POSFacturarNotasTemp.MovFactura=POSFacturarNotasTemp.Cliente
POSFacturarNotasTemp.Cliente=(Fin)

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
GuardarAntes=S

Multiple=S
ListaAccionesMultiples=(Lista)
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=ConDatos(POSFacturarNotasTemp:POSFacturarNotasTemp.MovFactura) y ConDatos(POSFacturarNotasTemp:POSFacturarNotasTemp.Cliente)
EjecucionMensaje=<T>Es Necesario Seleccionar el Movimiento y el Cliente<T>
[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Temp.Reg5,SQL(<T>spPOSFacturarNotas :nEstacion, :tID, :tEmpresa, :nSucursal, :tUsuario, :tMov, :tCliente<T>, EstacionTrabajo, Info.IDTextoAnterior, Empresa, Sucursal, Usuario, POSFacturarNotasTemp:POSFacturarNotasTemp.MovFactura, POSFacturarNotasTemp:POSFacturarNotasTemp.Cliente))<BR>Reexpresa( Temp.Reg5[2])<BR>Asigna(Info.Descripcion, Temp.Reg5[5]+<T> <T>+Temp.Reg5[6])
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Acciones.Cancelar/Cancelar Cambios]
Nombre=Cancelar/Cancelar Cambios
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S
















[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)






[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107



























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar/Cancelar Cambios
Cancelar/Cancelar Cambios=(Fin)
