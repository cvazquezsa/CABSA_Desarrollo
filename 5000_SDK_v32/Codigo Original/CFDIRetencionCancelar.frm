

[Forma]
Clave=CFDIRetencionCancelar
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Retenciones - Cancelar Timbrado
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=269
PosicionInicialArriba=74
PosicionInicialAlturaCliente=542
PosicionInicialAncho=828
ExpresionesAlMostrar=Asigna(Info.Mov, SQL(<T>SELECT MovTimbrado FROM  CFDIRetencionCfg<T>))
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxpA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
ListaEnCaptura=(Lista)

FiltroUsuarios=S
FiltroFechas=S
FiltroSucursales=S
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=Cxp.FechaEmision
FiltroFechasDefault=Este Mes
BusquedaRapida=S
BusquedaEnLinea=S

IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=CxpA:Cxp.Mov+<T> <T>+CxpA:Cxp.MovID
FiltroGeneral=Cxp.Mov = <T>{Info.Mov}<T> AND Cxp.Estatus = <T>CONCLUIDO<T> AND Cxp.CFDRetencionTimbrado = 1
[Lista.Cxp.Proveedor]
Carpeta=Lista
Clave=Cxp.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco



[Lista.Cxp.FechaEmision]
Carpeta=Lista
Clave=Cxp.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
0=152
1=78
2=150
3=91
4=95
5=96
6=90
7=95












[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Cxp.Moneda]
Carpeta=Lista
Clave=Cxp.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
NombreDesplegar=&Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.QuitarSeleccion]
Nombre=QuitarSeleccion
Boton=0
NombreDesplegar=&Quitar Selección
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S



[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación Preliminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S










[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=&Cancelar Timbrado
EnLote=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

EspacioPrevio=S









Expresion=ProcesarSQL(<T>EXEC spCFDIRetencionCancelar :nID, :nEstacion<T>, CxpA:Cxp.ID, EstacionTrabajo)<BR><BR>Si SQL(<T>SELECT CASE WHEN COUNT(ID) <= 0 THEN 1 ELSE  0 END FROM ListaID where Estacion = :tEstacion <T>, EstacionTrabajo)<BR>Entonces<BR>  Asigna(Temp.texto,<T>Proceso Concluido<T>)<BR>  Informacion(Temp.Texto)<BR>  ActualizarForma<BR>  ActualizarVista<BR>Sino<BR>  Asigna(Temp.Texto,<T><T>)    <BR>Fin
Antes=S
AntesExpresiones=RegistrarSeleccionID(<T>Lista<T>)



[Lista.ListaEnCaptura]
(Inicio)=Cxp.Proveedor
Cxp.Proveedor=Prov.Nombre
Prov.Nombre=Cxp.FechaEmision
Cxp.FechaEmision=ImporteTotal
ImporteTotal=Cxp.Moneda
Cxp.Moneda=(Fin)

[Lista.ListaAcciones]
(Inicio)=SeleccionarTodo
SeleccionarTodo=QuitarSeleccion
QuitarSeleccion=Cancelar
Cancelar=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=(Fin)
