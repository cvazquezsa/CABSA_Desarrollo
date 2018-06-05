[Forma]
Clave=mcCargaReg
Nombre=<T>Carga en Lote - <T>+Info.Tipo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=170
PosicionInicialArriba=245
PosicionInicialAlturaCliente=625
PosicionInicialAncho=1339
Comentarios=Lista( FechaEnTexto(Info.Fecha, <T>dd/mmm/aaaa<T>), Info.Mayor)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Totalizadores=S
PosicionSec1=562
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.Dato, SQLEnLista(<T>SELECT Dato FROM mcMayorDato WHERE Mayor=:tMayor<T>, Info.Mayor))<BR>Asigna(Info.Medida, SQLEnLista(<T>SELECT Medida FROM mcMayorMedida WHERE Mayor=:tMayor<T>, Info.Mayor))

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=mcCargaReg
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
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=mcCargaReg.CargaGID=(SELECT GID FROM mcCarga WHERE RID={Info.ID}) AND<BR>mcCargaReg.Mayor=<T>{Info.Mayor}<T>

[Lista.mcCargaReg.Sucursal]
Carpeta=Lista
Clave=mcCargaReg.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.CentroCostos]
Carpeta=Lista
Clave=mcCargaReg.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.UEN]
Carpeta=Lista
Clave=mcCargaReg.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Proyecto]
Carpeta=Lista
Clave=mcCargaReg.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Actividad]
Carpeta=Lista
Clave=mcCargaReg.Actividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.RFC]
Carpeta=Lista
Clave=mcCargaReg.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.CURP]
Carpeta=Lista
Clave=mcCargaReg.CURP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Cliente]
Carpeta=Lista
Clave=mcCargaReg.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Proveedor]
Carpeta=Lista
Clave=mcCargaReg.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Personal]
Carpeta=Lista
Clave=mcCargaReg.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Almacen]
Carpeta=Lista
Clave=mcCargaReg.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.FechaEmision]
Carpeta=Lista
Clave=mcCargaReg.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Mov]
Carpeta=Lista
Clave=mcCargaReg.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.MovID]
Carpeta=Lista
Clave=mcCargaReg.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Articulo]
Carpeta=Lista
Clave=mcCargaReg.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.SerieLote]
Carpeta=Lista
Clave=mcCargaReg.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.CtaDinero]
Carpeta=Lista
Clave=mcCargaReg.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Concepto]
Carpeta=Lista
Clave=mcCargaReg.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Referencia]
Carpeta=Lista
Clave=mcCargaReg.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Clase]
Carpeta=Lista
Clave=mcCargaReg.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.SubClase]
Carpeta=Lista
Clave=mcCargaReg.SubClase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Causa]
Carpeta=Lista
Clave=mcCargaReg.Causa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.FormaEnvio]
Carpeta=Lista
Clave=mcCargaReg.FormaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.FormaPago]
Carpeta=Lista
Clave=mcCargaReg.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Condicion]
Carpeta=Lista
Clave=mcCargaReg.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Vencimiento]
Carpeta=Lista
Clave=mcCargaReg.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Recurso]
Carpeta=Lista
Clave=mcCargaReg.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Agente]
Carpeta=Lista
Clave=mcCargaReg.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Cajero]
Carpeta=Lista
Clave=mcCargaReg.Cajero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Espacio]
Carpeta=Lista
Clave=mcCargaReg.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.AFArticulo]
Carpeta=Lista
Clave=mcCargaReg.AFArticulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.AFSerie]
Carpeta=Lista
Clave=mcCargaReg.AFSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Cantidad]
Carpeta=Lista
Clave=mcCargaReg.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Precio]
Carpeta=Lista
Clave=mcCargaReg.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Descuento1]
Carpeta=Lista
Clave=mcCargaReg.Descuento1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Descuento2]
Carpeta=Lista
Clave=mcCargaReg.Descuento2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Costo]
Carpeta=Lista
Clave=mcCargaReg.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Gastos]
Carpeta=Lista
Clave=mcCargaReg.Gastos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Impuesto1]
Carpeta=Lista
Clave=mcCargaReg.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Impuesto2]
Carpeta=Lista
Clave=mcCargaReg.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Impuesto3]
Carpeta=Lista
Clave=mcCargaReg.Impuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Moneda]
Carpeta=Lista
Clave=mcCargaReg.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.TipoCambio]
Carpeta=Lista
Clave=mcCargaReg.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Unidad]
Carpeta=Lista
Clave=mcCargaReg.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Factor]
Carpeta=Lista
Clave=mcCargaReg.Factor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Debe]
Carpeta=Lista
Clave=mcCargaReg.Debe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Haber]
Carpeta=Lista
Clave=mcCargaReg.Haber
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Sucursal=64
CentroCostos=95
UEN=64
Proyecto=93
Actividad=61
RFC=89
CURP=89
Cliente=79
Proveedor=76
Personal=93
Almacen=86
FechaEmision=79
Mov=78
MovID=72
Articulo=76
SubCuenta=114
SerieLote=135
CtaDinero=95
Concepto=126
Referencia=121
Clase=121
SubClase=127
Causa=91
FormaEnvio=111
FormaPago=112
Condicion=97
Vencimiento=65
Recurso=64
Agente=64
Cajero=64
Espacio=64
AFArticulo=107
AFSerie=113
Cantidad=64
Precio=64
Descuento1=97
Descuento2=101
Costo=64
Gastos=64
Impuesto1=64
Impuesto2=64
Impuesto3=72
Moneda=64
TipoCambio=64
Unidad=57
Factor=38
Debe=102
Haber=108
Entrada=64
Salida=64

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreEnBoton=S
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Antes=S
Visible=S
Expresion=Asigna(Info.Campo, Forma.ColumnaCampo(<T>Lista<T>))<BR>Asigna(Info.Valor, Forma.ColumnaValor(<T>Lista<T>))<BR>Si<BR>  ConDatos(Info.Valor) y (Info.Campo noen (<T>Debe<T>, <T>Haber<T>, <T>Presupuesto<T>, <T>Existencia<T>, <T>porSurtir<T>)) <BR>Entonces<BR>  Forma(<T>mcCargaProp<T>)<BR>Fin

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
Totalizadores1=Debe<BR>Haber<BR>Presupuesto<BR>Existencia<BR>por Surtir
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
Totalizadores2=Suma(mcCargaReg:mcCargaReg.Debe)<BR>Suma(mcCargaReg:mcCargaReg.Haber)<BR>Suma(mcCargaReg:mcCargaReg.Presupuesto)<BR>Suma(mcCargaReg:mcCargaReg.Existencia)<BR>Suma(mcCargaReg:mcCargaReg.porSurtir)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Cantidades)<BR>(Cantidades)
ListaEnCaptura=(Lista)

[(Carpeta Totalizadores).Debe]
Carpeta=(Carpeta Totalizadores)
Clave=Debe
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Haber]
Carpeta=(Carpeta Totalizadores)
Clave=Haber
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Lista.mcCargaReg.TipoCambio2]
Carpeta=Lista
Clave=mcCargaReg.TipoCambio2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Cuenta]
Carpeta=Lista
Clave=mcCargaReg.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Opcion]
Carpeta=Lista
Clave=mcCargaReg.Opcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Presupuesto]
Carpeta=Lista
Clave=mcCargaReg.Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.Existencia]
Carpeta=Lista
Clave=mcCargaReg.Existencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaReg.porSurtir]
Carpeta=Lista
Clave=mcCargaReg.porSurtir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Presupuesto]
Carpeta=(Carpeta Totalizadores)
Clave=Presupuesto
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Existencia]
Carpeta=(Carpeta Totalizadores)
Clave=Existencia
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).por Surtir]
Carpeta=(Carpeta Totalizadores)
Clave=por Surtir
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Propiedades
Propiedades=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=mcCargaReg.Sucursal
mcCargaReg.Sucursal=mcCargaReg.Cuenta
mcCargaReg.Cuenta=mcCargaReg.CentroCostos
mcCargaReg.CentroCostos=mcCargaReg.UEN
mcCargaReg.UEN=mcCargaReg.Proyecto
mcCargaReg.Proyecto=mcCargaReg.Actividad
mcCargaReg.Actividad=mcCargaReg.RFC
mcCargaReg.RFC=mcCargaReg.CURP
mcCargaReg.CURP=mcCargaReg.Cliente
mcCargaReg.Cliente=mcCargaReg.Proveedor
mcCargaReg.Proveedor=mcCargaReg.Personal
mcCargaReg.Personal=mcCargaReg.Almacen
mcCargaReg.Almacen=mcCargaReg.FechaEmision
mcCargaReg.FechaEmision=mcCargaReg.Mov
mcCargaReg.Mov=mcCargaReg.MovID
mcCargaReg.MovID=mcCargaReg.Articulo
mcCargaReg.Articulo=mcCargaReg.Opcion
mcCargaReg.Opcion=mcCargaReg.SerieLote
mcCargaReg.SerieLote=mcCargaReg.CtaDinero
mcCargaReg.CtaDinero=mcCargaReg.Concepto
mcCargaReg.Concepto=mcCargaReg.Referencia
mcCargaReg.Referencia=mcCargaReg.Clase
mcCargaReg.Clase=mcCargaReg.SubClase
mcCargaReg.SubClase=mcCargaReg.Causa
mcCargaReg.Causa=mcCargaReg.FormaEnvio
mcCargaReg.FormaEnvio=mcCargaReg.FormaPago
mcCargaReg.FormaPago=mcCargaReg.Condicion
mcCargaReg.Condicion=mcCargaReg.Vencimiento
mcCargaReg.Vencimiento=mcCargaReg.Recurso
mcCargaReg.Recurso=mcCargaReg.Agente
mcCargaReg.Agente=mcCargaReg.Cajero
mcCargaReg.Cajero=mcCargaReg.Espacio
mcCargaReg.Espacio=mcCargaReg.AFArticulo
mcCargaReg.AFArticulo=mcCargaReg.AFSerie
mcCargaReg.AFSerie=mcCargaReg.Cantidad
mcCargaReg.Cantidad=mcCargaReg.Precio
mcCargaReg.Precio=mcCargaReg.Descuento1
mcCargaReg.Descuento1=mcCargaReg.Descuento2
mcCargaReg.Descuento2=mcCargaReg.Costo
mcCargaReg.Costo=mcCargaReg.Gastos
mcCargaReg.Gastos=mcCargaReg.Impuesto1
mcCargaReg.Impuesto1=mcCargaReg.Impuesto2
mcCargaReg.Impuesto2=mcCargaReg.Impuesto3
mcCargaReg.Impuesto3=mcCargaReg.Debe
mcCargaReg.Debe=mcCargaReg.Haber
mcCargaReg.Haber=mcCargaReg.Presupuesto
mcCargaReg.Presupuesto=mcCargaReg.Moneda
mcCargaReg.Moneda=mcCargaReg.TipoCambio
mcCargaReg.TipoCambio=mcCargaReg.TipoCambio2
mcCargaReg.TipoCambio2=mcCargaReg.Existencia
mcCargaReg.Existencia=mcCargaReg.porSurtir
mcCargaReg.porSurtir=mcCargaReg.Unidad
mcCargaReg.Unidad=mcCargaReg.Factor
mcCargaReg.Factor=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Debe
Debe=Haber
Haber=Presupuesto
Presupuesto=Existencia
Existencia=por Surtir
por Surtir=(Fin)
