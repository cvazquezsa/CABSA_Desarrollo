
[Forma]
Clave=AuxiliarActivoFijo
Icono=0
Modulos=(Todos)
Nombre=Auxiliar Activo Fijo

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=421
PosicionInicialAncho=826
PosicionInicialIzquierda=261
PosicionInicialArriba=102
PosicionSec1=204
Comentarios=Lista(Info.Modulo,Info.MovID)
BarraAcciones=S
Menus=S
MovModulo=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Mensaje,SQL(<T>spCalculoValorAdquisicionAF :nEstacion, :nIdMov, :nRenglon, :tEmpresa, :tModulo, :nBandera<T>, EstacionTrabajo, Info.ID, Info.Renglon,  Empresa, Info.Modulo, 0))<BR>Si<BR>  Info.Mensaje <> <T>Proceso concluido.<T><BR>Entonces<BR>  Informacion(<T>La Fecha de Inicio de la depreciación del Artículo AF dede ser mayor o igual a la fecha emisión del movimiento<T>)<BR>Sino<BR>  Si<BR>     SQL(<T>SELECT COUNT(*) FROM AuxiliarActivoFijo WHERE IDMov = :nID AND Modulo = :tModulo AND Aplicar = 1<T>, Info.ID, Info.Modulo ) >=1<BR>  Entonces<BR>     Asigna(Info.Aplica,<T>1<T>)<BR>  Sino<BR>     Asigna(Info.Aplica,<T>0<T>)<BR>  Fin<BR>  ActualizarForma<BR>Fin
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GastoDActivosFijos
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=AgregarDF

GuardarAlSalir=S
CarpetaVisible=S
FiltroGeneral=(GastoDActivosFijos.ID = {Info.ID})
[Lista.Columnas]
ID=64
Renglon=64
Concepto=268
Referencia=304
Cantidad=64
Precio=64
Importe=64
Total=64


Fecha=94
Impuestos=64












0=104
1=241
2=76
3=103

[Lista.GastoDActivosFijos.Concepto]
Carpeta=Lista
Clave=GastoDActivosFijos.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco

[Lista.GastoDActivosFijos.Fecha]
Carpeta=Lista
Clave=GastoDActivosFijos.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.GastoDActivosFijos.Importe]
Carpeta=Lista
Clave=GastoDActivosFijos.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle]
Estilo=Iconos
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=AuxiliarActivoFijo
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Detalle=S
VistaMaestra=GastoDActivosFijos
LlaveLocal=AuxiliarActivoFijo.IDMov

LlaveMaestra=GastoDActivosFijos.ID





ListaEnCaptura=(Lista)
IconosCampo=AuxiliarActivoFijo.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPaginaEsp=200
PermiteEditar=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=AuxiliarActivoFijo:AuxiliarActivoFijo.Articulo
[Acciones.AgregarDF]
Nombre=AgregarDF
Boton=0
NombreDesplegar=Agregar Activo Fijo


EnMenu=S
Antes=S
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=(Lista)

Visible=S
Activo=S
AntesExpresiones=GuardarCambios  <BR>Asigna(Info.Articulo, SQL(<T>SELECT AFArticulo FROM Gasto WHERE ID = :n<T>, GastoDActivosFijos:GastoDActivosFijos.ID))<BR>Asigna(Info.Serielote, SQL(<T>SELECT AFSerie FROM Gasto WHERE ID = :n<T>, GastoDActivosFijos:GastoDActivosFijos.ID))<BR>Asigna(Info.Renglon,GastoDActivosFijos:GastoDActivosFijos.Renglon)
[Detalle.AuxiliarActivoFijo.Serie]
Carpeta=Detalle
Clave=AuxiliarActivoFijo.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco

[Detalle.AuxiliarActivoFijo.Cantidad]
Carpeta=Detalle
Clave=AuxiliarActivoFijo.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AuxiliarActivoFijo.ValorAdquisicion]
Carpeta=Detalle
Clave=AuxiliarActivoFijo.ValorAdquisicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.AuxiliarActivoFijo.ImporteMov]
Carpeta=Detalle
Clave=AuxiliarActivoFijo.ImporteMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Detalle.AuxiliarActivoFijo.Total]
Carpeta=Detalle
Clave=AuxiliarActivoFijo.Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Detalle.Columnas]
ID=64
IDMov=64
Modulo=38
Articulo=124
Serie=95
Cantidad=64
ValorAdquisicion=125
ImporteMov=77
FactorCalculo=81
Total=64
FechaEmisión=94
FechaInicioDepreciación=119





0=92
1=60
2=67
3=121
4=120
5=96
6=147
7=-2
[Acciones.EditarLista.AfGastos]
Nombre=AfGastos
Boton=0
TipoAccion=Formas
ClaveAccion=ActivoFListaGasto
Activo=S
Visible=S









[Acciones.AgregarDF.AF]
Nombre=AF
Boton=0
TipoAccion=Formas
ClaveAccion=ActivoFListaGasto
Activo=S
Visible=S



















[Lista.ListaAcciones]
(Inicio)=AgregarDF
AgregarDF=oooo
oooo=(Fin)



[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





EspacioPrevio=S

[Acciones.AgregarDF.FormaActivoFijo]
Nombre=FormaActivoFijo
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=FormaModal(<T>ActivoFListaGasto<T>)<BR>ActualizarVista(<T>Detalle<T>)

[Lista.GastoDActivosFijos.Impuestos]
Carpeta=Lista
Clave=GastoDActivosFijos.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Total]
Carpeta=Lista
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Detalle.AuxiliarActivoFijo.FechaInicioDepreciacion]
Carpeta=Detalle
Clave=AuxiliarActivoFijo.FechaInicioDepreciacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco











[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



EnBarraHerramientas=S










[Acciones.Aplicar]
Nombre=Aplicar
Boton=7
NombreEnBoton=S
NombreDesplegar=Aplicar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S









Antes=S
Expresion=EjecutarSQL(<T>spAplicaGastoActivoFijo :tEmpresa, :tModulo, :tIDMov<T>, Empresa, Info.Modulo, Info.ID )<BR>ActualizarVista(<T>Detalle<T>)<BR>ActualizarForma
ActivoCondicion=(Info.Estatus <> <T>CANCELADO<T>) y (Info.Estatus <> <T>CONCLUIDO<T>) y (Info.Aplica = <T>0<T>)
AntesExpresiones=Asigna(Info.Aplica,<T>1<T>)
[Acciones.Eliminar]
Nombre=Eliminar
Boton=0
NombreDesplegar=Eliminar Artículo
EnMenu=S
TipoAccion=Expresion
Visible=S







Multiple=S
ListaAccionesMultiples=(Lista)
ActivoCondicion=Info.Aplica = <T>0<T>
[Acciones.EliminarTodo]
Nombre=EliminarTodo
Boton=0
NombreDesplegar=Eliminar Todo
EnMenu=S
TipoAccion=Expresion
Visible=S

















Multiple=S
ListaAccionesMultiples=(Lista)
ActivoCondicion=Info.Aplica = <T>0<T>
[Acciones.AgregarDF.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=Si<BR>  ConDatos(AuxiliarActivoFijo:AuxiliarActivoFijo.Icono)<BR>Entonces<BR>  Asigna(Info.Aplica,<T>1<T>)<BR>Sino<BR>  Asigna(Info.Aplica,<T>0<T>)<BR>Fin<BR><BR>ActualizarForma<BR>ActualizarVista
[Acciones.Eliminar.Exp]
Nombre=Exp
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>EXEC spEliminaAuxiliarAF :tEmpresa, :tModulo, :nID, :nArticuloID, 0<T>, EMPRESA, AuxiliarActivoFijo:AuxiliarActivoFijo.Modulo,AuxiliarActivoFijo:AuxiliarActivoFijo.IDMov,AuxiliarActivoFijo:AuxiliarActivoFijo.ID)<BR>ActualizarVista(<T>Detalle<T>)
Activo=S
Visible=S

[Acciones.Eliminar.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Expresion
Expresion=ActualizarForma<BR>ActualizarVista
Activo=S
Visible=S


[Acciones.EliminarTodo.Exp]
Nombre=Exp
Boton=0
TipoAccion=EXpresion
Expresion=EjecutarSQL(<T>EXEC spEliminaAuxiliarAF :tEmpresa, :tModulo, :nID, :nArticuloID, 1<T>, EMPRESA, AuxiliarActivoFijo:AuxiliarActivoFijo.Modulo,AuxiliarActivoFijo:AuxiliarActivoFijo.IDMov,AuxiliarActivoFijo:AuxiliarActivoFijo.ID)<BR>ActualizarVista(<T>Detalle<T>)
Activo=S
Visible=S

[Acciones.EliminarTodo.Act]
Nombre=Act
Boton=0
TipoAccion=Expresion
Expresion=ActualizarForma<BR>ActualizarVista
Activo=S
Visible=S


[Detalle.LlaveLocal]
(Inicio)=AuxiliarActivoFijo.IDMov
AuxiliarActivoFijo.IDMov=AuxiliarActivoFijo.Renglon
AuxiliarActivoFijo.Renglon=(Fin)

[Detalle.LlaveMaestra]
(Inicio)=GastoDActivosFijos.ID
GastoDActivosFijos.ID=GastoDActivosFijos.Renglon
GastoDActivosFijos.Renglon=(Fin)







[Acciones.AgregarDF.ListaAccionesMultiples]
(Inicio)=FormaActivoFijo
FormaActivoFijo=Actualizar
Actualizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=GastoDActivosFijos.Concepto
GastoDActivosFijos.Concepto=GastoDActivosFijos.Fecha
GastoDActivosFijos.Fecha=GastoDActivosFijos.Importe
GastoDActivosFijos.Importe=GastoDActivosFijos.Impuestos
GastoDActivosFijos.Impuestos=Total
Total=(Fin)























































[Acciones.Eliminar.ListaAccionesMultiples]
(Inicio)=Exp
Exp=Actualizar
Actualizar=(Fin)

[Acciones.EliminarTodo.ListaAccionesMultiples]
(Inicio)=Exp
Exp=Act
Act=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=AuxiliarActivoFijo.Serie
AuxiliarActivoFijo.Serie=AuxiliarActivoFijo.Cantidad
AuxiliarActivoFijo.Cantidad=AuxiliarActivoFijo.ValorAdquisicion
AuxiliarActivoFijo.ValorAdquisicion=AuxiliarActivoFijo.ImporteMov
AuxiliarActivoFijo.ImporteMov=AuxiliarActivoFijo.Total
AuxiliarActivoFijo.Total=AuxiliarActivoFijo.FechaInicioDepreciacion
AuxiliarActivoFijo.FechaInicioDepreciacion=(Fin)

[Detalle.ListaAcciones]
(Inicio)=Eliminar
Eliminar=EliminarTodo
EliminarTodo=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cerrar
Cerrar=Aplicar
Aplicar=(Fin)
