
[Forma]
Clave=POSCierreSucursalTemp
Icono=0
CarpetaPrincipal=POSCierreSucursalTemp
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=POSCierreSucursalTemp
PosicionInicialIzquierda=534
PosicionInicialArriba=274
PosicionInicialAlturaCliente=140
PosicionInicialAncho=297
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSBorrarCierreSucursalTemp :nEstacion<T>,EstacionTrabajo)
Nombre=Generar Cierre Sucursal
[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


Multiple=S
ListaAccionesMultiples=(Lista)
[POSCierreSucursalTemp]
Estilo=Ficha
Clave=POSCierreSucursalTemp
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCierreSucursalTemp
Fuente={Tahoma, 8, Negro, []}
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
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

FiltroGeneral=POSCierreSucursalTemp.Estacion = {EstacionTrabajo}
[POSCierreSucursalTemp.POSCierreSucursalTemp.Fecha]
Carpeta=POSCierreSucursalTemp
Clave=POSCierreSucursalTemp.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[POSCierreSucursalTemp.POSCierreSucursalTemp.Mov]
Carpeta=POSCierreSucursalTemp
Clave=POSCierreSucursalTemp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[POSCierreSucursalTemp.Columnas]
Fecha=107
Mov=124


[POSCierreSucursalTemp.POSCierreSucursalTemp.CtaDineroDestino]
Carpeta=POSCierreSucursalTemp
Clave=POSCierreSucursalTemp.CtaDineroDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




[Acciones.Aceptar.Generar]
Nombre=Generar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=ProcesarSQL(<T>spPOSGenerarCierreSucursal :tEmpresa, :nSucursal, :nEstacion, :tUsuario, :tMov, :tCUenta, :tFecha<T>,Empresa, Sucursal, EstacionTrabajo, Usuario,POSCierreSucursalTemp:POSCierreSucursalTemp.Mov,POSCierreSucursalTemp:POSCierreSucursalTemp.CtaDineroDestino,POSCierreSucursalTemp:POSCierreSucursalTemp.Fecha)<BR><T>FREY<T>,0,1,<T>1<T>,<T>Corte Caja<T>,<T>001<T>,<T>31/05/2013<T>
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S








[POSCierreSucursalTemp.ListaEnCaptura]
(Inicio)=POSCierreSucursalTemp.Fecha
POSCierreSucursalTemp.Fecha=POSCierreSucursalTemp.Mov
POSCierreSucursalTemp.Mov=POSCierreSucursalTemp.CtaDineroDestino
POSCierreSucursalTemp.CtaDineroDestino=(Fin)








[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Generar
Generar=Aceptar
Aceptar=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Aceptar
Aceptar=(Fin)
