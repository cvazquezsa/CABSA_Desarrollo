[Forma]
Clave=CambioComparativo
Nombre=Comparativo de Ventas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=180
PosicionInicialArriba=121
PosicionInicialAltura=526
PosicionInicialAncho=664
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(e(<T>Del<T>)+<T>: <T>+ FechaEnTexto(Info.FechaD, <T>d/mmm/aaaa<T>), e(<T>Al<T>)+<T>: <T>+ FechaEnTexto(Info.FechaA, <T>d/mmm/aaaa<T>), e(<T>Tipo Cambio<T>)+<T>: <T>+Info.TipoCambio)
ExpresionesAlMostrar=Asigna(Info.TipoCambio, SQL(<T>SELECT TipoCambio FROM Mon WHERE Moneda=:tMon<T>, <T>Dolar<T>))

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerCambioUtil
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Gris
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=VerCambioUtil.Final>0

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
GuardarAntes=S

[Lista.VerCambioUtil.Cotizacion1]
Carpeta=Lista
Clave=VerCambioUtil.Cotizacion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.Ok1]
Carpeta=Lista
Clave=VerCambioUtil.Ok1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.Cotizacion2]
Carpeta=Lista
Clave=VerCambioUtil.Cotizacion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.Ok2]
Carpeta=Lista
Clave=VerCambioUtil.Ok2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.Cotizacion3]
Carpeta=Lista
Clave=VerCambioUtil.Cotizacion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerCambioUtil.Ok3]
Carpeta=Lista
Clave=VerCambioUtil.Ok3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Moneda=64
Cotizacion1=66
Ok1=34
Cotizacion2=66
Ok2=32
Cotizacion3=66
Ok3=34
Cotizacion4=64
Ok4=30
Cotizacion5=64
Ok5=30
Cantidad=74
CostoMN=90
CostoPond=94
Nombre=142
Moneda_1=70

[Lista.Cantidad]
Carpeta=Lista
Clave=Cantidad
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.CostoMN]
Carpeta=Lista
Clave=CostoMN
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.CostoPond]
Carpeta=Lista
Clave=CostoPond
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.TipoCambio]
Nombre=TipoCambio
Boton=64
NombreDesplegar=&Tipo Cambio
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
NombreEnBoton=S
AntesExpresiones=Forma(<T>EspecificarTipoCambio<T>)

[Acciones.Regenerar]
Nombre=Regenerar
Boton=82
NombreDesplegar=&Regenerar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Si(Forma(<T>EspecificarFechas<T>), EjecutarSQL(<T>spVerCambioUtil :nEstacion, :tEmpresa, :fFechaD, :fFechaA, :nSucursal<T>,  EstacionTrabajo , Empresa, Info.FechaD, Info.FechaA, Sucursal), AbortarOperacion)

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=&Preliminar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
Activo=S
Visible=S
ClaveAccion=CambioComparativo
NombreEnBoton=S

[Lista.Mon.Moneda]
Carpeta=Lista
Clave=Mon.Moneda
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreDesplegar=Generar &Operación
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=TipoCambio
TipoCambio=Preliminar
Preliminar=Afectar
Afectar=Regenerar
Regenerar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Mon.Moneda
Mon.Moneda=Cantidad
Cantidad=CostoMN
CostoMN=CostoPond
CostoPond=VerCambioUtil.Cotizacion1
VerCambioUtil.Cotizacion1=VerCambioUtil.Ok1
VerCambioUtil.Ok1=VerCambioUtil.Cotizacion2
VerCambioUtil.Cotizacion2=VerCambioUtil.Ok2
VerCambioUtil.Ok2=VerCambioUtil.Cotizacion3
VerCambioUtil.Cotizacion3=VerCambioUtil.Ok3
VerCambioUtil.Ok3=(Fin)
