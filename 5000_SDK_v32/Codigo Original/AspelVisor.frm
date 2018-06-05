[Forma]
Clave=AspelVisor
Nombre=Importación Aspel
Icono=0
Modulos=(Lista)
ListaCarpetas=Aspelconfig
CarpetaPrincipal=Aspelconfig
PosicionInicialIzquierda=51
PosicionInicialArriba=179
PosicionInicialAlturaCliente=382
PosicionInicialAncho=921
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionSec1=0
ListaAcciones=(Lista)
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
PosicionSec2=663
VentanaEstadoInicial=Normal
BarraHerramientas=S
Menus=S
ExpresionesAlMostrar=Asigna(Info.Formato,SQL(<T>SELECT Valor FROM AspelCfgOpcion WHERE Descripcion = :tDescripcion<T>,<T>Formato Cuentas Contables<T>))<BR>Asigna(Info.Numero,SQL(<T>SELECT LEN(REPLACE(REPLACE(RTRIM(LTRIM(:tFormato)),:tGuion,:tVacio),:tDos,:tVac))<T>,Info.Formato,<T>-<T>,<T><T>,<T>;2<T>,<T><T>))<BR>Asigna(Info.Valor, <T>0<T>)<BR>ActualizarVista
FiltrarFechasSinHora=S
MenuPrincipal=(Lista)
[AspelRubro.AspelRubro.Valor]
Carpeta=AspelRubro
Clave=AspelRubro.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[AspelRubro.AspelRubro.ValorNumero]
Carpeta=AspelRubro
Clave=AspelRubro.ValorNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[AspelRubro.AspelRubro.Rama]
Carpeta=AspelRubro
Clave=AspelRubro.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Rojo
Efectos=[Negritas]
[AspelRubro.Columnas]
Valor=352
ValorNumero=64
Rama=59
Descripcion=485
[AspelRubro.CtaLista.Descripcion]
Carpeta=AspelRubro
Clave=CtaLista.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Cuentas.Columnas]
Valor=304
Nombre=632
Tipo=124
Estatus=94
CuentaConFormato=110
TipoDescrito=124
0=124
1=208
2=110
3=81
4=114
5=116
6=143
[Cuentas.AspelCuenta.Nombre]
Carpeta=Cuentas
Clave=AspelCuenta.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Cuentas.TipoDescrito]
Carpeta=Cuentas
Clave=TipoDescrito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[Cuentas.AspelCuenta.Estatus]
Carpeta=Cuentas
Clave=AspelCuenta.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
[Monedas.AspelMoneda.TipoCambio]
Carpeta=Monedas
Clave=AspelMoneda.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Monedas.AspelMoneda.Clave]
Carpeta=Monedas
Clave=AspelMoneda.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco
ColorFuente=Negro
[Monedas.AspelMoneda.Nombre]
Carpeta=Monedas
Clave=AspelMoneda.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Monedas.Columnas]
Valor=141
Nombre=624
Clave=49
TipoCambio=143
0=130
1=277
2=86
3=115
[Almacenes.AspelAlmacenes.Nombre]
Carpeta=Almacenes
Clave=AspelAlmacenes.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Almacenes.AspelAlmacenes.Estatus]
Carpeta=Almacenes
Clave=AspelAlmacenes.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
[Almacenes.Columnas]
Valor=304
Nombre=562
Estatus=94
0=119
1=459
2=99
[Agentes.AspelAgentes.Nombre]
Carpeta=Agentes
Clave=AspelAgentes.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Agentes.AspelAgentes.Tipo]
Carpeta=Agentes
Clave=AspelAgentes.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Agentes.AspelAgentes.eMail]
Carpeta=Agentes
Clave=AspelAgentes.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[Agentes.AspelAgentes.TipoComision]
Carpeta=Agentes
Clave=AspelAgentes.TipoComision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Agentes.AspelAgentes.Estatus]
Carpeta=Agentes
Clave=AspelAgentes.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
[Agentes.Columnas]
Valor=72
Nombre=237
Tipo=84
eMail=270
TipoComision=115
Porcentaje=109
Estatus=103
PorcentajePorCien=74
0=90
1=224
2=110
3=187
4=114
5=111
6=101
[Agentes.PorcentajePorCien]
Carpeta=Agentes
Clave=PorcentajePorCien
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Clientes.AspelClientes.Nombre]
Carpeta=Clientes
Clave=AspelClientes.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Clientes.AspelClientes.RFC]
Carpeta=Clientes
Clave=AspelClientes.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Clientes.AspelClientes.CURP]
Carpeta=Clientes
Clave=AspelClientes.CURP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Clientes.AspelClientes.Telefonos]
Carpeta=Clientes
Clave=AspelClientes.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Clientes.AspelClientes.Fax]
Carpeta=Clientes
Clave=AspelClientes.Fax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[Clientes.AspelClientes.Direccion]
Carpeta=Clientes
Clave=AspelClientes.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Clientes.AspelClientes.Colonia]
Carpeta=Clientes
Clave=AspelClientes.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Clientes.AspelClientes.Poblacion]
Carpeta=Clientes
Clave=AspelClientes.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Clientes.AspelClientes.Zona]
Carpeta=Clientes
Clave=AspelClientes.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
[Clientes.AspelClientes.CodigoPostal]
Carpeta=Clientes
Clave=AspelClientes.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
[Clientes.AspelClientes.eMail]
Carpeta=Clientes
Clave=AspelClientes.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[Clientes.AspelClientes.Estatus]
Carpeta=Clientes
Clave=AspelClientes.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
[Clientes.Columnas]
Valor=84
Nombre=323
RFC=124
CURP=124
Telefonos=186
Fax=191
Direccion=319
Colonia=107
Poblacion=138
Zona=105
CodigoPostal=85
eMail=210
Estatus=94
0=98
1=256
2=155
3=145
4=139
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
12=-2
[Proveedores.AspelProveedores.Nombre]
Carpeta=Proveedores
Clave=AspelProveedores.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Proveedores.AspelProveedores.RFC]
Carpeta=Proveedores
Clave=AspelProveedores.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Proveedores.AspelProveedores.CURP]
Carpeta=Proveedores
Clave=AspelProveedores.CURP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Proveedores.AspelProveedores.Telefonos]
Carpeta=Proveedores
Clave=AspelProveedores.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Proveedores.AspelProveedores.Direccion]
Carpeta=Proveedores
Clave=AspelProveedores.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Proveedores.AspelProveedores.Colonia]
Carpeta=Proveedores
Clave=AspelProveedores.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Proveedores.AspelProveedores.Poblacion]
Carpeta=Proveedores
Clave=AspelProveedores.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Proveedores.AspelProveedores.Zona]
Carpeta=Proveedores
Clave=AspelProveedores.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
[Proveedores.AspelProveedores.CodigoPostal]
Carpeta=Proveedores
Clave=AspelProveedores.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
[Proveedores.AspelProveedores.Fax]
Carpeta=Proveedores
Clave=AspelProveedores.Fax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[Proveedores.AspelProveedores.eMail]
Carpeta=Proveedores
Clave=AspelProveedores.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[Proveedores.AspelProveedores.Estatus]
Carpeta=Proveedores
Clave=AspelProveedores.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
[Proveedores.Columnas]
Valor=106
Nombre=325
RFC=124
CURP=124
Telefonos=163
Direccion=244
Colonia=120
Poblacion=179
Zona=71
CodigoPostal=94
Fax=155
eMail=221
Estatus=94
0=64
1=322
2=191
3=-2
4=158
5=-2
6=-2
7=-2
8=-2
9=-2
10=-2
11=-2
12=-2
[Articulos.AspelArticulos.Nombre]
Carpeta=Articulos
Clave=AspelArticulos.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.Tipo]
Carpeta=Articulos
Clave=AspelArticulos.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.Unidad]
Carpeta=Articulos
Clave=AspelArticulos.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.TiempoEntrega]
Carpeta=Articulos
Clave=AspelArticulos.TiempoEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.TiempoEntregaU]
Carpeta=Articulos
Clave=AspelArticulos.TiempoEntregaU
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.Peso]
Carpeta=Articulos
Clave=AspelArticulos.Peso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=100
[Articulos.AspelArticulos.Volumen]
Carpeta=Articulos
Clave=AspelArticulos.Volumen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.Proveedor]
Carpeta=Articulos
Clave=AspelArticulos.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.PrecioLista]
Carpeta=Articulos
Clave=AspelArticulos.PrecioLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.Precio2]
Carpeta=Articulos
Clave=AspelArticulos.Precio2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.Precio3]
Carpeta=Articulos
Clave=AspelArticulos.Precio3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.Precio4]
Carpeta=Articulos
Clave=AspelArticulos.Precio4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.Precio5]
Carpeta=Articulos
Clave=AspelArticulos.Precio5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.Impuesto1]
Carpeta=Articulos
Clave=AspelArticulos.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.TipoCosteo]
Carpeta=Articulos
Clave=AspelArticulos.TipoCosteo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.Estatus]
Carpeta=Articulos
Clave=AspelArticulos.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.Columnas]
Valor=117
Nombre=261
Tipo=63
Unidad=67
TiempoEntrega=85
TiempoEntregaU=115
Peso=40
Volumen=64
Proveedor=62
PrecioLista=64
Precio2=64
Precio3=64
Precio4=64
Precio5=64
Impuesto1=64
TipoCosteo=124
Estatus=94
0=147
1=160
2=50
3=48
4=30
5=40
6=44
7=49
8=42
9=108
10=53
11=66
12=71
13=58
14=109
15=52
16=48
17=114
18=41
19=90
20=108
21=115
[Ventas.Columnas]
FechaEmision=94
Mov=124
Cliente=56
Almacen=83
Moneda=64
TipoCambio=64
Estatus=94
Nombre=462
Importe=136
0=91
1=115
2=72
3=197
4=90
5=115
6=147
[Ventas.AspelVentas.Mov]
Carpeta=Ventas
Clave=AspelVentas.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1
[Ventas.AspelVentas.Cliente]
Carpeta=Ventas
Clave=AspelVentas.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[Ventas.AspelVentas.Almacen]
Carpeta=Ventas
Clave=AspelVentas.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[Ventas.Importe]
Carpeta=Ventas
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1
[Ventas.AspelClientes.Nombre]
Carpeta=Ventas
Clave=AspelClientes.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Compras.Mov]
Carpeta=Compras
Clave=Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Compras.Columnas]
FechaEmision=94
Mov=124
Proveedor=64
Nombre=513
Almacen=51
Importe=112
0=103
1=111
2=108
3=221
4=89
5=102
6=101
[Compras.Nombre]
Carpeta=Compras
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Compras.Almacen]
Carpeta=Compras
Clave=Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[Compras.Importe]
Carpeta=Compras
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1
[Polizas.Mov]
Carpeta=Polizas
Clave=Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Polizas.MovID]
Carpeta=Polizas
Clave=MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Polizas.DEBE]
Carpeta=Polizas
Clave=DEBE
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1
[Polizas.HABER]
Carpeta=Polizas
Clave=HABER
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1
[Polizas.Columnas]
FechaEmision=166
Mov=128
MovID=66
DEBE=158
HABER=190
0=92
1=71
2=88
3=169
4=197
[Inventarios.AspelInventarios.Articulo]
Carpeta=Inventarios
Clave=AspelInventarios.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Inventarios.AspelInventarios.Cantidad]
Carpeta=Inventarios
Clave=AspelInventarios.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1
[Inventarios.AspelInventarios.Costo]
Carpeta=Inventarios
Clave=AspelInventarios.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Inventarios.Importe]
Carpeta=Inventarios
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1
[Inventarios.Columnas]
Mov=218
Articulo=182
Cantidad=121
Costo=128
Importe=143
0=135
1=401
2=107
3=123
4=157
[Cxc.Mov]
Carpeta=Cxc
Clave=Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Cxc.Cliente]
Carpeta=Cxc
Clave=Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[Cxc.Importe]
Carpeta=Cxc
Clave=Importe
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Cxc.Columnas]
0=91
1=90
2=95
3=287
4=134
5=109
6=118
[Cxc.Nombre]
Carpeta=Cxc
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Acciones.CxcLocalizar]
Nombre=CxcLocalizar
Boton=0
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Cxc
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
[Acciones.CxcLocalizarSiguiente]
Nombre=CxcLocalizarSiguiente
Boton=0
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=Cxc
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S
[Acciones.CxcPreliminar]
Nombre=CxcPreliminar
Boton=0
NombreDesplegar=Presentación &Preliminar
EnMenu=S
Carpeta=Cxc
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
[Acciones.CxcExcel]
Nombre=CxcExcel
Boton=0
NombreDesplegar=Enviar a &Excel
EnMenu=S
Carpeta=Cxc
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
[Cxp.Mov]
Carpeta=Cxp
Clave=Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Cxp.Importe]
Carpeta=Cxp
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1
[Cxp.Columnas]
0=105
1=113
2=88
3=368
4=106
5=110
[Cxp.Nombre]
Carpeta=Cxp
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
[Acciones.CxpLocalizar]
Nombre=CxpLocalizar
Boton=0
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Cxp
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
[Acciones.CxpLocalizarSiguiente]
Nombre=CxpLocalizarSiguiente
Boton=0
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=Cxp
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S
[Acciones.CxpPreliminar]
Nombre=CxpPreliminar
Boton=0
NombreDesplegar=Presentación &Preliminar
EnMenu=S
Carpeta=Cxp
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
[Acciones.CxpExcel]
Nombre=CxpExcel
Boton=0
NombreDesplegar=Enviar a &Excel
EnMenu=S
Carpeta=Cxp
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
[Acciones.AgentesLocalizar]
Nombre=AgentesLocalizar
Boton=0
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Agentes
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
[Acciones.AgentesLocalizarSiguiente]
Nombre=AgentesLocalizarSiguiente
Boton=0
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=Agentes
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S
[Acciones.AgentesPreliminar]
Nombre=AgentesPreliminar
Boton=0
NombreDesplegar=Presentacion &Preliminar
EnMenu=S
Carpeta=Agentes
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
[Acciones.AgentesExcel]
Nombre=AgentesExcel
Boton=0
NombreDesplegar=Enviar a &Excel
EnMenu=S
Carpeta=Agentes
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
[Acciones.AlmacenesLocalizar]
Nombre=AlmacenesLocalizar
Boton=0
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Almacenes
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
[Acciones.AlmacenesLocalizarSiguiente]
Nombre=AlmacenesLocalizarSiguiente
Boton=0
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=Almacenes
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S
[Acciones.AlmacenesPreliminar]
Nombre=AlmacenesPreliminar
Boton=0
NombreDesplegar=Presentacion &Preliminar
EnMenu=S
Carpeta=Almacenes
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
[Acciones.AlmacenesExcel]
Nombre=AlmacenesExcel
Boton=0
NombreDesplegar=Enviar a &Excel
EnMenu=S
Carpeta=Almacenes
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
[Acciones.ArticulosLocalizar]
Nombre=ArticulosLocalizar
Boton=0
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Articulos
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
[Acciones.ArticulosLocalizarSiguiente]
Nombre=ArticulosLocalizarSiguiente
Boton=0
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=Articulos
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S
[Acciones.ArticulosPreliminar]
Nombre=ArticulosPreliminar
Boton=0
NombreDesplegar=Presentacion Preliminar
EnMenu=S
Carpeta=Articulos
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
[Acciones.ArticulosExcel]
Nombre=ArticulosExcel
Boton=0
NombreDesplegar=Enviar a &Excel
EnMenu=S
Carpeta=Articulos
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
[Acciones.ClientesLocalizar]
Nombre=ClientesLocalizar
Boton=0
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Clientes
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
[Acciones.ClientesLocalizarSiguiente]
Nombre=ClientesLocalizarSiguiente
Boton=0
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=Clientes
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S
[Acciones.ClientesPreliminar]
Nombre=ClientesPreliminar
Boton=0
NombreDesplegar=Presentacion &Preliminar
EnMenu=S
Carpeta=Clientes
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
[Acciones.ClientesExcel]
Nombre=ClientesExcel
Boton=0
NombreDesplegar=Enviar a &Excel
EnMenu=S
Carpeta=Clientes
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
[Acciones.CuentasLocalizar]
Nombre=CuentasLocalizar
Boton=0
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Cuentas
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
[Acciones.CuentasLocalizarSiguiente]
Nombre=CuentasLocalizarSiguiente
Boton=0
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=Cuentas
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S
[Acciones.CuentasPreliminar]
Nombre=CuentasPreliminar
Boton=0
NombreDesplegar=Presentacion &Preliminar
EnMenu=S
Carpeta=Cuentas
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
[Acciones.CuentasExcel]
Nombre=CuentasExcel
Boton=0
NombreDesplegar=Enviar a &Excel
EnMenu=S
Carpeta=Cuentas
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
[Acciones.MonedasLocalizar]
Nombre=MonedasLocalizar
Boton=0
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Monedas
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
[Acciones.MonedasLocalizarSiguiente]
Nombre=MonedasLocalizarSiguiente
Boton=0
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=Monedas
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S
[Acciones.MonedasPreliminar]
Nombre=MonedasPreliminar
Boton=0
NombreDesplegar=Presentacion &Preliminar
EnMenu=S
Carpeta=Monedas
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
[Acciones.MonedasExcel]
Nombre=MonedasExcel
Boton=0
NombreDesplegar=Enviar a &Excel
EnMenu=S
Carpeta=Monedas
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
[Acciones.ProveedoresLocalizar]
Nombre=ProveedoresLocalizar
Boton=0
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Proveedores
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
[Acciones.ProveedoresLocalizarSiguiente]
Nombre=ProveedoresLocalizarSiguiente
Boton=0
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=Proveedores
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S
[Acciones.ProveedoresPreliminar]
Nombre=ProveedoresPreliminar
Boton=0
NombreDesplegar=Presentacion &Preliminar
EnMenu=S
Carpeta=Proveedores
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
[Acciones.ProveedoresExcel]
Nombre=ProveedoresExcel
Boton=0
NombreDesplegar=Enviar a &Excel
EnMenu=S
Carpeta=Proveedores
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
[Acciones.ComprasLocalizar]
Nombre=ComprasLocalizar
Boton=0
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Compras
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
[Acciones.ComprasLocalizarSiguiente]
Nombre=ComprasLocalizarSiguiente
Boton=0
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=Compras
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S
[Acciones.ComprasPreliminar]
Nombre=ComprasPreliminar
Boton=0
NombreDesplegar=Presentacion &Preliminar
EnMenu=S
Carpeta=Compras
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
[Acciones.ComprasExcel]
Nombre=ComprasExcel
Boton=0
NombreDesplegar=Enviar a &Excel
EnMenu=S
Carpeta=Compras
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
[Acciones.AspelComprasD]
Nombre=AspelComprasD
Boton=0
NombreDesplegar=&Detalle Compras
EnMenu=S
TipoAccion=Formas
ClaveAccion=AspelComprasD
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Empresa,AspelCompras:Empresa)<BR>Asigna(Info.Sucursal,AspelCompras:Sucursal)<BR>Asigna(Info.Proveedor,AspelCompras:AspelCompras.Proveedor)<BR>Asigna(Info.Almacen,AspelCompras:Almacen)<BR>Asigna(Info.Fecha,AspelCompras:FechaEmision)<BR>Asigna(Info.Mov,AspelCompras:Mov)<BR>Asigna(Info.Moneda,AspelCompras:Moneda)<BR>Asigna(Info.TipoCambio,AspelCompras:TipoCambio)<BR>Asigna(Info.Estatus,AspelCompras:Estatus)<BR>Asigna(Info.Modulo,AspelCompras:Modulo)
[Acciones.ArticulosSeries]
Nombre=ArticulosSeries
Boton=0
NombreDesplegar=Se&ries Articulos
EnMenu=S
TipoAccion=Expresion
Activo=S
Antes=S
Visible=S
Expresion=Forma(<T>AspelSeries<T>)<BR>Forma.ActualizarVista(<T>Articulos<T>)
AntesExpresiones=Asigna(Info.Articulo,AspelArticulos:AspelArticulos.Valor)<BR>Asigna(Info.Descripcion,AspelArticulos:AspelArticulos.Nombre)<BR>Asigna(Info.Observaciones,AspelArticulos:AspelArticulos.CargaGID)
[Acciones.InventariosLocalizar]
Nombre=InventariosLocalizar
Boton=0
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Inventarios
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
[Acciones.InventariosLocalizarSiguiente]
Nombre=InventariosLocalizarSiguiente
Boton=0
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=Inventarios
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S
[Acciones.InventariosPreliminar]
Nombre=InventariosPreliminar
Boton=0
NombreDesplegar=Presentacion Preliminar
EnMenu=S
Carpeta=Inventarios
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
[Acciones.InventariosExcel]
Nombre=InventariosExcel
Boton=0
NombreDesplegar=Enviar a &Excel
EnMenu=S
Carpeta=Inventarios
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
[Acciones.PolizasLocalizar]
Nombre=PolizasLocalizar
Boton=0
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Polizas
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
[Acciones.PolizasLocalizarSiguiente]
Nombre=PolizasLocalizarSiguiente
Boton=0
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=Polizas
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S
[Acciones.PolizasPreliminar]
Nombre=PolizasPreliminar
Boton=0
NombreDesplegar=Presentacion &Preliminar
EnMenu=S
Carpeta=Polizas
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
[Acciones.PolizasExcel]
Nombre=PolizasExcel
Boton=0
NombreDesplegar=Enviar a &Excel
EnMenu=S
Carpeta=Polizas
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
[Acciones.AspelPolizasD]
Nombre=AspelPolizasD
Boton=0
NombreDesplegar=Detalle de P&olizas
EnMenu=S
TipoAccion=Formas
ClaveAccion=AspelPolizasD
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Empresa,AspelPolizas:Empresa)<BR>Asigna(Info.Sucursal,AspelPolizas:Sucursal)<BR>Asigna(Info.Modulo,AspelPolizas:Modulo)<BR>Asigna(Info.Mov,AspelPolizas:Mov)<BR>Asigna(Info.Fecha,AspelPolizas:FechaEmision)<BR>Asigna(Info.Estatus,AspelPolizas:Estatus)
[Acciones.VentasLocalizar]
Nombre=VentasLocalizar
Boton=0
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=Ventas
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
[Acciones.VentasLocalizarSiguiente]
Nombre=VentasLocalizarSiguiente
Boton=0
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=Ventas
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S
[Acciones.VentasPreliminar]
Nombre=VentasPreliminar
Boton=0
NombreDesplegar=Presentacion &Preliminar
EnMenu=S
Carpeta=Ventas
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
[Acciones.VentasExcel]
Nombre=VentasExcel
Boton=0
NombreDesplegar=Enviar a &Excel
EnMenu=S
Carpeta=Ventas
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S
[Acciones.AspelVentasD]
Nombre=AspelVentasD
Boton=0
NombreDesplegar=&Detalle De Ventas
EnMenu=S
TipoAccion=Formas
ClaveAccion=AspelVentasD
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Empresa,AspelVentas:AspelVentas.Empresa)<BR>Asigna(Info.Sucursal,AspelVentas:AspelVentas.Sucursal)<BR>Asigna(Info.Cliente,AspelVentas:AspelVentas.Cliente)<BR>Asigna(Info.Almacen,AspelVentas:AspelVentas.Almacen)<BR>Asigna(Info.Fecha,AspelVentas:AspelVentas.FechaEmision)<BR>Asigna(Info.Mov,AspelVentas:AspelVentas.Mov)<BR>Asigna(Info.Moneda,AspelVentas:AspelVentas.Moneda)<BR>Asigna(Info.TipoCambio,AspelVentas:AspelVentas.TipoCambio)<BR>Asigna(Info.Estatus,AspelVentas:AspelVentas.Estatus)<BR>Asigna(Info.Modulo,AspelVentas:AspelVentas.Modulo)
Visible=S
[Acciones.Importar]
Nombre=Importar
Boton=7
NombreDesplegar=&Importar todo
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Menu=Importación
EnMenu=S
Expresion=SI Confirmacion(<T>Esta seguro que desea importar la información?<T>,BotonAceptar,BotonCancelar) = BotonAceptar Entonces  <BR>//    SQL(<T>spAspelInsertaTodo :nEstacion<T>,EstacionTrabajo)<BR>   Back.ProcesarSQL(<T>Importando Toda la Información<T>, <T>spAspelInsertaTodo 1<T>)<BR>Fin<BR><BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select SUM(Estatus) FROM AspelProcesos<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.AgentesPersonalizar]
Nombre=AgentesPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=Agentes
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
[Acciones.AlmacenesPersonalizar]
Nombre=AlmacenesPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
[Acciones.ArticulosPersonalizar]
Nombre=ArticulosPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=Articulos
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
[Acciones.ClientesPersonalizar]
Nombre=ClientesPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=Clientes
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
[Acciones.CuentasPersonalizar]
Nombre=CuentasPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=Cuentas
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
[Acciones.MonedasPersonalizar]
Nombre=MonedasPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=Monedas
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
[Acciones.ProveedoresPersonalizar]
Nombre=ProveedoresPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=Proveedores
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
[Acciones.ComprasPersonalizar]
Nombre=ComprasPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=Compras
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
[Acciones.InventariosPersonalizar]
Nombre=InventariosPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=Inventarios
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
[Acciones.PolizasPersonalizar]
Nombre=PolizasPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
[Acciones.VentasPersonalizar]
Nombre=VentasPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=Ventas
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
[Acciones.CxcPersonalizar]
Nombre=CxcPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=Cxc
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
[Acciones.CxpPersonalizar]
Nombre=CxpPersonalizar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=Cxp
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
[Acciones.Cerrar]
Nombre=Cerrar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cerrar
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
EnBarraHerramientas=S
[Ventas.ImporteTotal]
Carpeta=Ventas
Clave=ImporteTotal
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Compras.ImporteTotal]
Carpeta=Compras
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1
[Acciones.BorrarDatos]
Nombre=BorrarDatos
Boton=5
NombreEnBoton=S
NombreDesplegar=&Borrar datos Visor
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=EJECUTARSQL(<T>EXEC spAspelBorraPropReg<T>)<BR>ActualizarForma
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tArt<T>, <T>Tablas Temporales<T>) = 1<BR>Entonces<BR>    Verdadero<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.PresentarDatos]
Nombre=PresentarDatos
Boton=59
NombreEnBoton=S
NombreDesplegar=&Llenar tablas temporales
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=EJECUTARSQL(<T>spAspelPresentaDatos<T>)<BR>ejecutarSQL(<T>spAspelActualizaFlujo :nEstatus, :tProceso<T>, 1, <T>Tablas Temporales<T>)<BR>ActualizarForma<BR>Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tArt<T>, <T>Diagnostico Previo<T>) = 1<BR>Entonces<BR>    Verdadero<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.Configurar]
Nombre=Configurar
Boton=45
NombreEnBoton=S
NombreDesplegar=&Configuración inicial
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S
GuardarAntes=S
Antes=S
Activo=S
AntesExpresiones=forma(<T>aspelcfg2<T>)
[Articulos.AspelSeriesTotal.Series]
Carpeta=Articulos
Clave=AspelSeriesTotal.Series
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1
[Articulos.AspelArticulosTotal.Cantidad]
Carpeta=Articulos
Clave=AspelArticulosTotal.Cantidad
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.Diferencia]
Carpeta=Articulos
Clave=Diferencia
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Compras.AspelCompras.Proveedor]
Carpeta=Compras
Clave=AspelCompras.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[Cxp.AspelCxp.Proveedor]
Carpeta=Cxp
Clave=AspelCxp.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[Acciones.Unidades]
Nombre=Unidades
Boton=0
NombreDesplegar=&Unidades de medida
EnMenu=S
TipoAccion=Formas
ClaveAccion=AspelUnidades
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Articulo,AspelArticulos:AspelArticulos.Valor)<BR>Asigna(Info.Descripcion,AspelArticulos:AspelArticulos.Nombre)
[Cuentas.AspelCuentasTotal.DEBE]
Carpeta=Cuentas
Clave=AspelCuentasTotal.DEBE
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1
[Cuentas.AspelCuentasTotal.HABER]
Carpeta=Cuentas
Clave=AspelCuentasTotal.HABER
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1
[Cuentas.AspelCuentasTotal.SALDO]
Carpeta=Cuentas
Clave=AspelCuentasTotal.SALDO
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1
[Articulos.AspelArticulos.Impuesto2]
Carpeta=Articulos
Clave=AspelArticulos.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Articulos.AspelArticulos.Impuesto3]
Carpeta=Articulos
Clave=AspelArticulos.Impuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[Acciones.ActualizaCostoSerie]
Nombre=ActualizaCostoSerie
Boton=0
NombreDesplegar=&Actualiza costo series
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EJECUTARSQL(<T>SpAspelActualizaCostoSerie :tArticulo, :tAlmacen, :nCosto<T>,AspelInventarios:AspelInventarios.Articulo,AspelInventarios:AspelInventarios.Almacen,AspelInventarios:AspelInventarios.Costo)
[Avance.Info.Tabla]
Carpeta=Avance
Clave=Info.Tabla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Acciones.AspelCfgFinal]
Nombre=AspelCfgFinal
Boton=93
NombreEnBoton=S
NombreDesplegar=Configuración &Final
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AspelCfgFinal
Visible=S
Antes=S
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tArt<T>, <T>Tablas Temporales<T>) = 1<BR>Entonces<BR>    Verdadero<BR>SiNo<BR>    Falso<BR>Fin
AntesExpresiones=Asigna(Info.Formato,SQL(<T>SELECT Valor FROM AspelCfgOpcion WHERE Descripcion = :tDescripcion<T>,<T>Formato Cuentas Contables<T>))
[AspelPolizaAjuste.Mov]
Carpeta=AspelPolizaAjuste
Clave=Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[AspelPolizaAjuste.MovID]
Carpeta=AspelPolizaAjuste
Clave=MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[AspelPolizaAjuste.DEBE]
Carpeta=AspelPolizaAjuste
Clave=DEBE
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[AspelPolizaAjuste.HABER]
Carpeta=AspelPolizaAjuste
Clave=HABER
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[AspelPolizaAjuste.Columnas]
0=-2
1=118
2=119
3=157
4=175
[Acciones.VerDetalle]
Nombre=VerDetalle
Boton=0
NombreDesplegar=&Ver detalla Poliza Ajuste
EnMenu=S
TipoAccion=Formas
ClaveAccion=AspelPolizaAjusteD
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Empresa,AspelPolizaAjuste:Empresa)<BR>Asigna(Info.Sucursal,AspelPolizaAjuste:Sucursal)<BR>Asigna(Info.Modulo,AspelPolizaAjuste:Modulo)<BR>Asigna(Info.Mov,AspelPolizaAjuste:Mov)<BR>Asigna(Info.Fecha,AspelPolizaAjuste:FechaEmision)<BR>Asigna(Info.Estatus,AspelPolizaAjuste:Estatus)
Visible=S
[Acciones.GenerarPolizaAjuste]
Nombre=GenerarPolizaAjuste
Boton=96
NombreDesplegar=&Generar Poliza Ajuste
GuardarAntes=S
EspacioPrevio=S
TipoAccion=Expresion
Menu=Otros
EnMenu=S
Expresion=EJECUTARSQL(<T>spGeneraAspelPolizaAjuste<T>)<BR>ActualizarVista(<T>AspelPolizaAjuste<T>)

[Acciones.Vervisor]
Nombre=Vervisor
Boton=68
NombreDesplegar=&Visor
EnBarraHerramientas=S
TipoAccion=Formas
Visible=S
NombreEnBoton=S
EspacioPrevio=S
RefrescarDespues=S
ClaveAccion=aspelvisordetalle

ActivoCondicion=Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tArt<T>, <T>Tablas Temporales<T>) = 1<BR>Entonces<BR>    Verdadero<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.ImpFacturas]
Nombre=ImpFacturas
Boton=54
NombreDesplegar=Importar Facturas
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
EnBarraAcciones=S
Menu=Importación
EnMenu=S
Expresion=//EjecutarSQL(<T>spaspelinsertaventas :nEstacion<T>,EstacionTrabajo)<BR>//Back.EjecutarSQL(<T>Importando Ventas<T>, <T>spaspelinsertaventas 1<T>)<BR>Back.ProcesarSQL(<T>Importando Ventas<T>, <T>spaspelinsertaventas 1<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>Facturas<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.Impcompras]
Nombre=Impcompras
Boton=0
NombreDesplegar=Importar Compras
EnMenu=S
TipoAccion=Expresion
Visible=S
Menu=Importación
Expresion=//EjecutarSQL(<T>spaspelinsertacompras :nEstacion<T>,EstacionTrabajo)<BR>Back.ProcesarSQL(<T>Importando Compras<T>, <T>spAspelInsertaCompras 1<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>Compras<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.Impcxc]
Nombre=Impcxc
Boton=0
NombreDesplegar=Importar CXC
EnMenu=S
TipoAccion=Expresion
Visible=S
Menu=Importación
Expresion=//EjecutarSQL(<T>spaspelinsertacxc :nEstacion<T>,EstacionTrabajo)<BR>Back.ProcesarSQL(<T>Importando CxC<T>, <T>spAspelInsertaCxC 1<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>CxC<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.Impcxp]
Nombre=Impcxp
Boton=0
NombreDesplegar=Importar CXP
EnMenu=S
TipoAccion=Expresion
Visible=S
Menu=Importación
Expresion=//EjecutarSQL(<T>spaspelinsertacxp :nEstacion<T>,EstacionTrabajo)<BR>Back.ProcesarSQL(<T>Importando CxP<T>, <T>spAspelInsertaCxP 1<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>CxP<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.Impcliente]
Nombre=Impcliente
Boton=0
NombreDesplegar=Importar Clientes
EnMenu=S
TipoAccion=Expresion
Visible=S
Menu=Importación
EspacioPrevio=S
Expresion=//EjecutarSQL(<T>spaspelinsertaclientes<T>)<BR>Back.ProcesarSQL(<T>Importando Clientes<T>, <T>spAspelInsertaClientes<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>Clientes<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.Impprov]
Nombre=Impprov
Boton=0
NombreDesplegar=Importar Proveedores
EnMenu=S
TipoAccion=Expresion
Visible=S
Menu=Importación
Expresion=//EjecutarSQL(<T>spaspelinsertaproveedores<T>)<BR>Back.ProcesarSQL(<T>Importando Proveedores<T>, <T>spAspelInsertaProveedores<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>Proveedores<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.Impvend]
Nombre=Impvend
Boton=0
NombreDesplegar=Importar Vendedores
EnMenu=S
TipoAccion=Expresion
Visible=S
Menu=Importación
Expresion=//EjecutarSQL(<T>spaspelinsertaagentes<T>)<BR>Back.ProcesarSQL(<T>Importando Agentes<T>, <T>spAspelInsertaAgentes<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>Vendedores<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.Impcuentas]
Nombre=Impcuentas
Boton=0
NombreDesplegar=Importar Cuentas
EnMenu=S
TipoAccion=Expresion
Visible=S
Menu=Importación
Expresion=//EjecutarSQL(<T>spaspelinsertacuentas<T>)<BR>Back.ProcesarSQL(<T>Importando Cuentas<T>, <T>spAspelInsertaCuentas<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>Cuentas<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.Imppol]
Nombre=Imppol
Boton=0
NombreDesplegar=Importar Pólizas
EnMenu=S
TipoAccion=Expresion
Visible=S
Menu=Importación
Expresion=//EjecutarSQL(<T>spaspelinsertapolizas :nEstacion<T>,EstacionTrabajo)<BR>Back.ProcesarSQL(<T>Importando Polizas<T>, <T>spAspelInsertaPolizas 1<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>Polizas<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.Impmon]
Nombre=Impmon
Boton=0
NombreDesplegar=Importar Monedas
EnMenu=S
TipoAccion=Expresion
Visible=S
Menu=Importación
Expresion=//EjecutarSQL(<T>spaspelinsertamonedas<T>)<BR>Back.ProcesarSQL(<T>Importando Monedas<T>, <T>spAspelInsertaMonedas<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>Monedas<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.ImpUnidades]
Nombre=ImpUnidades
Boton=0
Menu=Importación
NombreDesplegar=Importar Unidades
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=//EjecutarSQL(<T>spAspelInsertaUnidades<T>)<BR>Back.ProcesarSQL(<T>Importando Unidades<T>, <T>spAspelInsertaUnidades<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>Unidades<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.Impalm]
Nombre=Impalm
Boton=0
NombreDesplegar=Importar Almacenes
EnMenu=S
TipoAccion=Expresion
Visible=S
Menu=Importación
Expresion=//EjecutarSQL(<T>spAspelInsertaAlmacenes<T>)<BR>Back.ProcesarSQL(<T>Importando Almacenes<T>, <T>spAspelInsertaAlmacenes<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>Almacenes<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.ImpArt]
Nombre=ImpArt
Boton=0
NombreDesplegar=Importar Artículos
EnMenu=S
TipoAccion=Expresion
Visible=S
Menu=Importación
Expresion=//EjecutarSQL(<T>spAspelInsertaArticulos<T>)<BR>Back.ProcesarSQL(<T>Importando Artículos<T>, <T>spAspelInsertaArticulos<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>Artículos<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[VentasAspel.AspelVentas.Cliente]
Carpeta=VentasAspel
Clave=AspelVentas.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[VentasAspel.AspelVentas.Almacen]
Carpeta=VentasAspel
Clave=AspelVentas.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[VentasAspel.movid]
Carpeta=VentasAspel
Clave=movid
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[VentasAspel.AspelVentas.FechaEmision]
Carpeta=VentasAspel
Clave=AspelVentas.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[VentasAspel.AspelVentas.Mov]
Carpeta=VentasAspel
Clave=AspelVentas.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[VentasAspel.AspelVentas.Moneda]
Carpeta=VentasAspel
Clave=AspelVentas.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[VentasAspel.AspelVentas.TipoCambio]
Carpeta=VentasAspel
Clave=AspelVentas.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[VentasAspel.Importe]
Carpeta=VentasAspel
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[VentasAspel.ImporteTotal]
Carpeta=VentasAspel
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
[VentasAspel.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2
6=-2
7=-2
8=-2
[Cuentaregistros.Columnas]
Descripcion=304
Valor=184
[Aspelconfig]
Estilo=Hoja
Pestana=S
Clave=Aspelconfig
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aspelcfg
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
PestanaOtroNombre=S
PestanaNombre=Configuración Inicial
ExpAlRefrescar=Si sql(<T>Select SUM(Estatus) FROM AspelProcesos<T>) = <T>14<T><BR>Entonces<BR>    Ejecutarsql(<T>Exec spAspelActualizaProcesos 0<T>)<BR>Sino<BR>    nulo<BR>Fin
[Aspelconfig.AspelCfg.Descripcion]
Carpeta=Aspelconfig
Clave=AspelCfg.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
[Aspelconfig.AspelCfg.Valor]
Carpeta=Aspelconfig
Clave=AspelCfg.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
[Aspelconfig.Columnas]
Descripcion=304
Valor=184

[Acciones.Diagnostico.Diagnostico]
Nombre=Diagnostico
Boton=0
TipoAccion=expresion
Expresion=EjecutarSQL(<T>spdiagnosticosae<T>)<BR><BR>  SI (SQL(<T>SELECT COUNT(*) FROM errorsae<T>) > 0) Entonces<BR>   Informacion(LISTA(<T>Existen los siguientes errores: <T>,SQLENLISTA(<T>SELECT Descr FROM Errorsae<T>)))<BR>  SINO<BR>   Informacion(<T>Diagnóstico terminado, no se detectaron errores<T>)<BR>  FIN
Activo=S
Visible=S
[Acciones.Diagnostico.Muestraerrores]
Nombre=Muestraerrores
Boton=0
TipoAccion=formas
ClaveAccion=Listaerrorsae
Activo=S
Visible=S


[Acciones.ListaErrorCoi.Ejecutasql]
Nombre=Ejecutasql
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ejecutarsql(<T>spAspelDiagnosticoCOI<T>)
[Acciones.ListaErrorCoi.ListaErrores]
Nombre=ListaErrores
Boton=0
TipoAccion=Formas
ClaveAccion=ListaErrorCoi
Activo=S
Visible=S
[Acciones.DirecFacElec]
Nombre=DirecFacElec
Boton=0
Menu=Herramientas
NombreDesplegar=Importa Dirección para Factura Electrónica
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=EJECUTARSQL(<T>spAspelDireccionFE<T>)<BR>Informacion(<T>Proceso Terminado<T>)
Activo=S
[Acciones.IntegrarLineas]
Nombre=IntegrarLineas
Boton=0
Menu=Herramientas
NombreDesplegar=Integrar Descripción de Líneas de Producto
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
Expresion=EJECUTARSQL(<T>spAspelDescripLineas<T>)<BR>Informacion(<T>Proceso Terminado<T>)
Activo=S
[Acciones.Remisiones]
Nombre=Remisiones
Boton=61
NombreEnBoton=S
Menu=Herramientas
NombreDesplegar=&Importar Remisiones
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Procedimientos
Activo=S
Multiple=S
ListaAccionesMultiples=Asigna
VisibleCondicion=//Si SQL(<T>Select Valor From AspelCfgOpcion Where Descripcion = :tPara1<T>, <T>Importar Remisiones<T>) = <T>Si<T><BR>//Entonces<BR>//    verdadero<BR>//Sino<BR>//    falso<BR>//Fin
[Acciones.Remisiones.Asigna]
Nombre=Asigna
Boton=0
TipoAccion=Formas
ClaveAccion=EscojeMov
Activo=S
Visible=S










[Datos por omision.Columnas]
Descripcion=257
Valor=813

[Opciones.Columnas]
Descripcion=304
Valor=766

[AspelCfgConceptos.Columnas]
NumConcepto=124
MovimientoIntelisisCxC=124

[AspelCfgConceptos2.Columnas]
NumConcepto=124
MovimientoIntelisisCxC=124

[AspelCfgConceptosCxP.Columnas]
NumConcepto=124
MovimientoIntelisisCxP=124

[AspelCfgConceptosCxP2.Columnas]
NumConcepto=124
MovimientoIntelisisCxP=124



























































































































































[Acciones.DiagnosticoIntelisis]
Nombre=DiagnosticoIntelisis
Boton=0
NombreDesplegar=&Registros Intelisis
EnMenu=S
Activo=S
Visible=S




Menu=Verificación
Multiple=S
EspacioPrevio=S
ListaAccionesMultiples=(Lista)



[Acciones.DiagnosticoIntelisis.EjecutaSql]
Nombre=EjecutaSql
Boton=0
TipoAccion=Expresion
Expresion=ejecutarsql(<T>EXEC spAspelRevisaTablas<T>)
Activo=S
Visible=S

[Acciones.DiagnosticoIntelisis.Despliega]
Nombre=Despliega
Boton=0
TipoAccion=Formas
ClaveAccion=AspelWarnings
Activo=S
Visible=S


[Acciones.ListaErrorCoi.Refresca]
Nombre=Refresca
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S







[Acciones.ImpInv]
Nombre=ImpInv
Boton=0
NombreDesplegar=Importar Inventarios
EnMenu=S
Visible=S




TipoAccion=Expresion






Menu=Importación

























































Expresion=//EjecutarSQL(<T>spaspelinsertainventarios :nEstacion<T>,EstacionTrabajo)<BR>Back.ProcesarSQL(<T>Importando Inv<T>, <T>spAspelInsertaInventarios 1<T>)<BR>//Informacion(<T>Proceso terminado<T>)
ActivoCondicion=Si sql(<T>Select Estatus FROM AspelProcesos Where Proceso = :tArt<T>, <T>Inventarios<T>) = 0<BR>Entonces<BR>    Si sql(<T>Select Estatus FROM AspelFlujo Where Proceso = :tFlujo<T>, <T>Configuración Final<T>) = 1<BR>    Entonces<BR>        Verdadero<BR>    SiNo<BR>        Falso<BR>    Fin<BR>SiNo<BR>    Falso<BR>Fin
[Acciones.CifrasControl.Ejecuta]
Nombre=Ejecuta
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSql(<T>spAspelCifrasControl<T>)
Activo=S
Visible=S

[Acciones.CifrasControl.Muestra]
Nombre=Muestra
Boton=0
TipoAccion=Formas
ClaveAccion=AspelCifrasControl
Activo=S
Visible=S

[Acciones.CifrasControl]
Nombre=CifrasControl
Boton=23
Menu=Herramientas
NombreDesplegar=Cifras control
Multiple=S
EspacioPrevio=S
ListaAccionesMultiples=(Lista)

NombreEnBoton=S
EnBarraHerramientas=S




















GuardarAntes=S







ActivoCondicion=Si sql(<T>Select SUM(Estatus) FROM AspelProcesos<T>) = 14<BR>Entonces<BR>    Verdadero<BR>SiNo<BR>    Falso<BR>Fin


[Acciones.CifrasControl.ListaAccionesMultiples]
(Inicio)=Ejecuta
Ejecuta=Muestra
Muestra=(Fin)



































[Aspelconfig.ListaEnCaptura]
(Inicio)=AspelCfg.Descripcion
AspelCfg.Descripcion=AspelCfg.Valor
AspelCfg.Valor=(Fin)













[Acciones.DiagnosticoIntelisis.ListaAccionesMultiples]
(Inicio)=EjecutaSql
EjecutaSql=Despliega
Despliega=(Fin)




[Acciones.ListaErrorCoi.ListaAccionesMultiples]
(Inicio)=Ejecutasql
Ejecutasql=ListaErrores
ListaErrores=Refresca
Refresca=(Fin)


































































































































[Acciones.AspelCambiaClaves]
Nombre=AspelCambiaClaves
Boton=72
NombreEnBoton=S
NombreDesplegar=Cambia Claves
EnBarraHerramientas=S
TipoAccion=formas
ClaveAccion=AspelCambiaClaves
Activo=S
Visible=S










RefrescarDespues=S


















EspacioPrevio=S































































[Forma.Modulos]
(Inicio)=(Todos)
(Todos)=VTAS
VTAS=SERV
SERV=CXC
CXC=DIN
DIN=INV
INV=CXP
CXP=COMS
COMS=CONT
CONT=GAS
GAS=EMB
EMB=AF
AF=CC
CC=CAM
CAM=NOM
NOM=RH
RH=VALE
VALE=CR
CR=PC
PC=AGENT
AGENT=ASIS
ASIS=REP
REP=ST
ST=PROD
PROD=PROY
PROY=ESP
ESP=AUTO
AUTO=MANT
MANT=CAP
CAP=AC
AC=WMS
WMS=CMP
CMP=FRM
FRM=OFER
OFER=INC
INC=CONC
CONC=CREDI
CREDI=PPTO
PPTO=ARO
ARO=AROP
AROP=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Configurar
Configurar=PresentarDatos
PresentarDatos=Vervisor
Vervisor=AspelCambiaClaves
AspelCambiaClaves=BorrarDatos
BorrarDatos=AspelCfgFinal
AspelCfgFinal=GenerarPolizaAjuste
GenerarPolizaAjuste=Importar
Importar=Impcliente
Impcliente=Impprov
Impprov=ImpArt
ImpArt=Impalm
Impalm=Impvend
Impvend=Impmon
Impmon=ImpUnidades
ImpUnidades=Impcuentas
Impcuentas=ImpFacturas
ImpFacturas=Impcxc
Impcxc=Impcxp
Impcxp=ImpInv
ImpInv=Imppol
Imppol=CifrasControl
CifrasControl=Impcompras
Impcompras=DirecFacElec
DirecFacElec=IntegrarLineas
IntegrarLineas=Remisiones
Remisiones=DiagnosticoIntelisis
DiagnosticoIntelisis=(Fin)

[Forma.MenuPrincipal]
(Inicio)=Verificación
Verificación=Importación
Importación=Herramientas
Herramientas=(Fin)
