
[Forma]
Clave=POSCxcAnticipoTemp
Icono=0
CarpetaPrincipal=POSCxcAnticipoTemp
Modulos=(Todos)
Nombre=Anticipos Facturados Pendientes
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=POSCxcAnticipoTemp
PosicionInicialIzquierda=1831
PosicionInicialArriba=340
PosicionInicialAlturaCliente=305
PosicionInicialAncho=817
Comentarios=Lista(Info.Cliente,Info.Nombre)
ListaAcciones=(Lista)
[POSCxcAnticipoTemp]
Estilo=Hoja
Clave=POSCxcAnticipoTemp
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCxcAnticipoTemp
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
MenuLocal=S
ListaAcciones=Expresion
FiltroGeneral=POSCxcAnticipoTemp.Estacion = {EstacionTrabajo}
[POSCxcAnticipoTemp.POSCxcAnticipoTemp.FechaEmision]
Carpeta=POSCxcAnticipoTemp
Clave=POSCxcAnticipoTemp.FechaEmision
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSCxcAnticipoTemp.POSCxcAnticipoTemp.Referencia]
Carpeta=POSCxcAnticipoTemp
Clave=POSCxcAnticipoTemp.Referencia
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[POSCxcAnticipoTemp.POSCxcAnticipoTemp.Concepto]
Carpeta=POSCxcAnticipoTemp
Clave=POSCxcAnticipoTemp.Concepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[POSCxcAnticipoTemp.POSCxcAnticipoTemp.AnticipoSaldo]
Carpeta=POSCxcAnticipoTemp
Clave=POSCxcAnticipoTemp.AnticipoSaldo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSCxcAnticipoTemp.POSCxcAnticipoTemp.Moneda]
Carpeta=POSCxcAnticipoTemp
Clave=POSCxcAnticipoTemp.Moneda
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[POSCxcAnticipoTemp.POSCxcAnticipoTemp.AnticipoAplicar]
Carpeta=POSCxcAnticipoTemp
Clave=POSCxcAnticipoTemp.AnticipoAplicar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[POSCxcAnticipoTemp.Columnas]
FechaEmision=94
Referencia=173
Concepto=210
AnticipoSaldo=71
Moneda=64
AnticipoAplicar=77


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
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=GuardarCambios<BR>SQL(<T>spPOSVerificarAnticiposTipoServicio :nEstacion, :tID, :tEmpresa<T>, EstacionTrabajo, Info.IDTexto, Empresa)
EjecucionMensaje=<T>La Cantidad a Aplicar es Mayor al Importe<T>
AntesExpresiones=GuardarCambios<BR>EjecutarSQL(<T>EXEC spPOSAplicarAnticiposTipoServicio :nEstacion, :tID<T>,EstacionTrabajo, Info.IDTexto)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S




























































[Acciones.Expresion]
Nombre=Expresion
Boton=0
NombreDesplegar=Copiar
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(POSCxcAnticipoTemp:POSCxcAnticipoTemp.AnticipoAplicar,POSCxcAnticipoTemp:POSCxcAnticipoTemp.AnticipoSaldo)
Activo=S
Visible=S





[POSCxcAnticipoTemp.ListaEnCaptura]
(Inicio)=POSCxcAnticipoTemp.FechaEmision
POSCxcAnticipoTemp.FechaEmision=POSCxcAnticipoTemp.Referencia
POSCxcAnticipoTemp.Referencia=POSCxcAnticipoTemp.Concepto
POSCxcAnticipoTemp.Concepto=POSCxcAnticipoTemp.AnticipoSaldo
POSCxcAnticipoTemp.AnticipoSaldo=POSCxcAnticipoTemp.Moneda
POSCxcAnticipoTemp.Moneda=POSCxcAnticipoTemp.AnticipoAplicar
POSCxcAnticipoTemp.AnticipoAplicar=(Fin)











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
