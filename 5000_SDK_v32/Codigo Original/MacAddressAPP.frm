
[Forma]
Clave=MacAddressAPP
Icono=32
CarpetaPrincipal=Lista
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
PosicionInicialIzquierda=305
PosicionInicialArriba=129
PosicionInicialAlturaCliente=307
PosicionInicialAncho=820
PosicionCol1=194
ListaAcciones=Aceptar
PosicionSec1=346
Nombre=Dirección MAC
Menus=S
MenuPrincipal=Archivo
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MacAddressAPP
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
ListaEnCaptura=MacAddressAPP.MacAddress

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
PermiteEditar=S
[Lista.MacAddressAPP.MacAddress]
Carpeta=Lista
Clave=MacAddressAPP.MacAddress
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
MacAddress=160

Empresa=71
Nombre=371
0=116
1=266
CentroCostos=125
Descripcion=243
Activa=64
[Detalle]
Estilo=Ficha
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MacAddressAPP
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=123
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S











ListaEnCaptura=(Lista)

PermiteEditar=S

[Detalle.MacAddressAPP.Empresa]
Carpeta=Detalle
Clave=MacAddressAPP.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Empresa.Nombre]
Carpeta=Detalle
Clave=Empresa.Nombre
Editar=N
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Plata



Pegado=S




[Detalle.MacAddressAPP.Sucursal]
Carpeta=Detalle
Clave=MacAddressAPP.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Sucursal.Nombre]
Carpeta=Detalle
Clave=Sucursal.Nombre
Editar=N
3D=S
Pegado=S
Tamano=40
ColorFondo=Plata





[Detalle.MacAddressAPP.Usuario]
Carpeta=Detalle
Clave=MacAddressAPP.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Usuario.Nombre]
Carpeta=Detalle
Clave=Usuario.Nombre
3D=S
Pegado=S
Tamano=40
ColorFondo=Plata





[Detalle.MacAddressAPP.Proveedor]
Carpeta=Detalle
Clave=MacAddressAPP.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Prov.Nombre]
Carpeta=Detalle
Clave=Prov.Nombre
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata





Pegado=S


[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S









GuardarAntes=S
Menu=Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
[Detalle.MacAddressAPP.CentroCostos]
Carpeta=Detalle
Clave=MacAddressAPP.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.CentroCostos.Descripcion]
Carpeta=Detalle
Clave=CentroCostos.Descripcion
3D=S
Pegado=S
Tamano=40
ColorFondo=Plata







[Lista.ListaEnCaptura]
(Inicio)=MacAddressAPP.MacAddress
MacAddressAPP.MacAddress=MacAddressAPP.Activa
MacAddressAPP.Activa=(Fin)




[Detalle.MacAddressAPP.Activa]
Carpeta=Detalle
Clave=MacAddressAPP.Activa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco












































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Concepto
Concepto=(Fin)













[Detalle.MacAddressAPP.AltaAcreedor]
Carpeta=Detalle
Clave=MacAddressAPP.AltaAcreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

















Tamano=20





























[Detalle.ListaEnCaptura]
(Inicio)=MacAddressAPP.Empresa
MacAddressAPP.Empresa=Empresa.Nombre
Empresa.Nombre=MacAddressAPP.Sucursal
MacAddressAPP.Sucursal=Sucursal.Nombre
Sucursal.Nombre=MacAddressAPP.Usuario
MacAddressAPP.Usuario=Usuario.Nombre
Usuario.Nombre=MacAddressAPP.Proveedor
MacAddressAPP.Proveedor=Prov.Nombre
Prov.Nombre=MacAddressAPP.CentroCostos
MacAddressAPP.CentroCostos=CentroCostos.Descripcion
CentroCostos.Descripcion=MacAddressAPP.Activa
MacAddressAPP.Activa=MacAddressAPP.AltaAcreedor
MacAddressAPP.AltaAcreedor=(Fin)



















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)
