
[Forma]
Clave=MovPresupProy
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
MovModulo=MovPresupProy
Nombre=Generar Presupuestos

ListaCarpetas=Lista
PosicionInicialIzquierda=468
PosicionInicialArriba=231
PosicionInicialAlturaCliente=227
PosicionInicialAncho=429
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSec1=124
PosicionSec2=462
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovPresupProy
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

[Lista.CfgMovProy.Mov]
Carpeta=Lista
Clave=CfgMovProy.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Modulo=49
Mov=124

SubTipo=124
[Acciones.Generar]
Nombre=Generar
Boton=41
NombreDesplegar=&Generar
EnBarraHerramientas=S
Activo=S
Visible=S
NombreEnBoton=S

GuardarAntes=S
TipoAccion=Expresion
Antes=S
Expresion=Asigna(Info.Mensaje,SQL(<T>EXEC spProyGenerarPresup :nID, :tModulo, :tMov, :tEmpresa, :nSucursal, :tUsuario, :tSubTipo, :tProyecto, :tProveedor<T>, Info.ID, MovPresupProy:CfgMovProy.Modulo, MovPresupProy:CfgMovProy.Mov, Empresa, Sucursal, Usuario, MovPresupProy:CfgMovProy.SubTipo, Info.Proyecto, MovPresupProy:CfgMovProy.Proveedor))<BR><BR>Si izquierda(Info.Mensaje,5) <> <T>Error<T> Entonces<BR>    Caso MovPresupProy:CfgMovProy.Modulo<BR>        Es <T>COMS<T> Entonces<BR>            FormaModal(<T>Compra<T>)<BR>        Es <T>GAS<T> Entonces<BR>            FormaModal(<T>Gasto<T>)<BR>    Fin<BR>Sino<BR>    Informacion(Info.Mensaje)<BR>Fin
AntesExpresiones=Asigna(Info.Modulo, MovPresupProy:CfgMovProy.Modulo)<BR>Asigna(Info.Mov, MovPresupProy:CfgMovProy.Mov)<BR>Asigna(Info.Tipo, MovPresupProy:CfgMovProy.Tipo)<BR>Asigna(Info.SubTipo, MovPresupProy:CfgMovProy.SubTipo)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S





[Lista.CfgMovProy.Modulo]
Carpeta=Lista
Clave=CfgMovProy.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco







[Lista.CfgMovProy.SubTipo]
Carpeta=Lista
Clave=CfgMovProy.SubTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




























[Detalle.Columnas]
Articulo=84
CantidadNeta=49
Unidad=39
CantidadInvNeta=53
Costo=75
DescuentoLinea=32
Importe=83
Impuesto1=64
SubImpuesto1=64
Impuesto2=47
SubImpuesto2=64
Impuesto3=64
SubImpuesto3=78
Retencion1=86
Retencion2=86
Retencion3=75
ContUso=73
FechaRequerida=87
DescripcionExtra=117

Cantidad=48
CantidadInventario=52
FechaEntrega=77
Concepto=134
Referencia=57
Precio=64
PorcentajeDeducible=68
Impuestos=67
Total=77
[FormaExtraValor.Columnas]
VerCampo=350
VerValor=350

[MovImpuesto.Columnas]
Impuesto1=64
Impuesto2=64
Impuesto3=72
Importe1=64
Importe2=64
Importe3=64
Retencion1=64
Retencion2=64
Retencion3=64
ContUso=124
ContUso2=124
ContUso3=124

[(Carpeta Abrir).Columnas]
0=205
1=89
2=206
3=100
4=100
5=100
6=100
7=-2
























































[Antecedentes.Columnas]
Aplica=124
AplicaID=65
Saldo=114
Vencimiento=86

































































Importe=118













































[ListaMovimientos.MovProy.Nombre]
Carpeta=ListaMovimientos
Clave=MovProy.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[ListaMovimientos.MovProy.Mov]
Carpeta=ListaMovimientos
Clave=MovProy.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[ListaMovimientos.Columnas]
Nombre=183
Mov=124
Proveedor=78





























[ListaMovimientos.ListaEnCaptura]
(Inicio)=MovProy.Nombre
MovProy.Nombre=MovProy.Mov
MovProy.Mov=(Fin)

[ListaMovimientos.ListaOrden]
(Inicio)=MovProy.Nombre	(Acendente)
MovProy.Nombre	(Acendente)=MovProy.Mov	(Acendente)
MovProy.Mov	(Acendente)=MovProy.Proveedor	(Acendente)
MovProy.Proveedor	(Acendente)=(Fin)











[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=ListaMovimientos
ListaMovimientos=(Fin)






[Lista.ListaEnCaptura]
(Inicio)=CfgMovProy.Modulo
CfgMovProy.Modulo=CfgMovProy.Mov
CfgMovProy.Mov=CfgMovProy.SubTipo
CfgMovProy.SubTipo=(Fin)





























[Forma.ListaAcciones]
(Inicio)=Generar
Generar=Cancelar
Cancelar=(Fin)
