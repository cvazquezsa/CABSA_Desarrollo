[Forma]
Clave=MovProy
Nombre=Generar Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=425
PosicionInicialArriba=246
PosicionInicialAlturaCliente=197
PosicionInicialAncho=515
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Proveedor

PosicionSec1=253
PosicionSec2=474
MovModulo=(Todos)
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Valor,Nulo)
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Mov, Nulo)
[Lista]
Estilo=Hoja
Clave=Lista
Zona=A1
Vista=MovProy
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ListaEnCaptura=(Lista)

HojaTitulos=S
HojaMostrarColumnas=S
[Lista.Columnas]
0=116
Nombre=209

Mov=124
Proveedor=124
1=266
[Acciones.Generar]
Nombre=Generar
Boton=23
NombreEnBoton=S
NombreDesplegar=<T>&Generar<T>
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S

EspacioPrevio=S
GuardarAntes=S
Expresion=Caso MovProy:MovProy.Tipo<BR>  Es <T>Modulo<T><BR>    Entonces<BR>      Asigna(Filtro.Proyecto, Info.Proyecto)<BR>      Asigna(Filtro.Actividad, Info.Actividad)<BR>      Asigna(Filtro.Mov, MovProy:MovProy.Mov)<BR><BR>      Si ConDatos(Info.Valor) Entonces Asigna(Info.ID,Info.Valor) Fin<BR>      Asigna(Info.Mensaje,SQL(<T>EXEC spProyGenerarMov :nID, :tModulo, :tMov, :tEmpresa, :nSucursal, :tUsuario, :tProyecto, :tProveedor<T>, Info.ID, MovProy:MovProy.Modulo, MovProy:MovProy.Mov, Empresa, Sucursal, Usuario, Info.Proyecto, MovProy:MovProy.Proveedor))<BR><BR>      Si izquierda(Info.Mensaje,5) <> <T>Error<T> Entonces<BR>      Caso MovProy:MovProy.Modulo<BR>            Es <T>VTAS<T> Entonces<BR>                        Asigna(Info.Valor,Info.ID)            <BR>                        FormaModal(<T>Venta<T>)<BR>            Es <T>COMS<T> Entonces<BR>                        Asigna(Info.Valor,Info.ID)<BR>                        FormaModal(<T>Compra<T>)<BR>            Es <T>GAS<T> Entonces<BR>                        Asigna(Info.Valor,Info.ID)<BR>                        FormaModal(<T>Gasto<T>)<BR>            Es <T>ST<T>   Entonces<BR>                        Asigna(Info.SubModuloST, Vacio(MovProy:MovProy.SubModulo, MovProy:MovProy.SubModulo))<BR>                        Asigna(Info.STNombre, SQL(<T>SELECT Nombre FROM SubModulo WHERE Modulo=:tModulo AND SubModulo=:tSubModulo<T>, MovProy:MovProy.Modulo, Info.SubModuloST))<BR>                        FormaModal(<T>Soporte<T>)<BR>            Es <T>CXP<T>  Entonces<BR>                        Asigna(Info.Valor,Info.ID)<BR>                        FormaModal(<T>Cxp<T>)<BR>            Es <T>CXC<T>  Entonces<BR>                        Asigna(Info.Valor,Info.ID)<BR>                        FormaModal(<T>Cxc<T>)<BR>          Fin<BR>     Sino<BR>        Informacion(Info.Mensaje)<BR>     Fin<BR>Fin
EjecucionCondicion=ConDatos(MovProy:MovProy.Nombre) y ConDatos(MovProy:MovProy.Tipo)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Lista.MovProy.Nombre]
Carpeta=Lista
Clave=MovProy.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco














[Competidores.Columnas]
Orden=35
Competidor=237
Producto=148
Importe=88
Moneda=64
Situacion=99
Fecha=83
Observaciones=675

[Detalle.Columnas]
Articulo=87
ClaveIdioma=74
CantidadNeta=47
PesoTotal=50
VolumenTotal=54
Unidad=41
Precio=77
DescuentoLinea=36
Importe=87
Impuesto1=35
SubImpuesto1=74
Impuesto2=42
SubImpuesto2=72
Retencion1=86
SubRetencion1=72
Retencion2=86
SubRetencion2=72
ContUso=76
DescripcionExtra=245

[FormaAnexo.Columnas]
0=121
1=48
2=-2

[MovEvento.Columnas]
0=455
1=70
2=-2
3=-2
4=-2

[FormaExtraValor.Columnas]
VerCampo=370
VerValor=370

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

[VentaFlexibleD.Columnas]
Cliente=93
Nombre=207
Articulo=64
Descripcion1=203
Cantidad=64
Precio=64
Importe=64

[(Carpeta Abrir).Columnas]
0=138
1=69
2=156
3=-2
4=-2
5=113
6=72
7=-2
8=-2












































[Lista.MovProy.Mov]
Carpeta=Lista
Clave=MovProy.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



















[Lista.ListaEnCaptura]
(Inicio)=MovProy.Nombre
MovProy.Nombre=MovProy.Mov
MovProy.Mov=MovProy.Proveedor
MovProy.Proveedor=(Fin)

[Lista.ListaOrden]
(Inicio)=MovProy.Orden	(Acendente)
MovProy.Orden	(Acendente)=MovProy.Mov	(Acendente)
MovProy.Mov	(Acendente)=MovProy.Proveedor	(Acendente)
MovProy.Proveedor	(Acendente)=(Fin)

[Lista.MovProy.Proveedor]
Carpeta=Lista
Clave=MovProy.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco









[Forma.ListaAcciones]
(Inicio)=Generar
Generar=Cancelar
Cancelar=(Fin)
