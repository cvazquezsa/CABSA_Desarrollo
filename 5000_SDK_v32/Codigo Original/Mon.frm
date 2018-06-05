[Forma]
Clave=Mon
Nombre=Monedas
Icono=0
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialAltura=299
PosicionInicialAncho=852
CarpetaPrincipal=Lista
PosicionInicialIzquierda=257
PosicionInicialArriba=181
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
PosicionInicialAlturaCliente=327
VentanaEstadoInicial=Normal

[Mon.Columnas]
Moneda=76
Nombre=189
TipoCambio=71

[Acciones.Historia.Expresion]
Nombre=Expresion
Boton=0
Icono=0
NombreDesplegar=Expresion
TipoAccion=Expresion
Expresion=Asigna( Info.Moneda,Mon:Mon.Moneda )
SQL=
ListaParametros=Si
Visible=Si
VisibleCondicion=
Activo=Si
ActivoCondicion=
EjecucionCondicion=
EjecucionMensaje=
AntesExpresiones=

[Lista]
Estilo=Hoja
PestanaNombre=Monedas
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Mon
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
OtroOrden=S
ListaOrden=(Lista)
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática

[Lista.Mon.Moneda]
Carpeta=Lista
Clave=Mon.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.Columnas]
Moneda=122
Nombre=177
TipoCambio=95
Orden=41
Tolerancia=66
TablaISAN=140
TipoCambioVenta=93
TipoCambioCompra=102
Clave=60
Simbolo=40
Codigo=37
0=61
1=217
CodigoInt=40
ReferenciaIntelisisService=304
InforClave=104

2=-2
[Detalle.Mon.Moneda]
Carpeta=Detalle
Clave=Mon.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalle.Mon.TipoCambio]
Carpeta=Detalle
Clave=Mon.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Detalle.Mon.Icono]
Carpeta=Detalle
Clave=Mon.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S
Visible=S
ConCondicion=S
EjecucionConError=S

EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Mon:Mon.Moneda)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
[Detalle.Columnas]
Moneda=75
Nombre=190
TipoCambio=64
Icono=64

[Lista.Mon.TipoCambio]
Carpeta=Lista
Clave=Mon.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Acciones.MonHist]
Nombre=MonHist
Boton=53
NombreEnBoton=S
NombreDesplegar=&Historial
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MonHist
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna( Info.Moneda,Mon:Mon.Moneda )

[Lista.Mon.Tolerancia]
Carpeta=Lista
Clave=Mon.Tolerancia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
GuardarAntes=S
DespuesGuardar=S
AntesExpresiones=Forma(<T>MonOrdenar<T>)

[Lista.Mon.Nombre]
Carpeta=Lista
Clave=Mon.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Mon.TipoCambioVenta]
Carpeta=Lista
Clave=Mon.TipoCambioVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Mon.TipoCambioCompra]
Carpeta=Lista
Clave=Mon.TipoCambioCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Mon.Clave]
Carpeta=Lista
Clave=Mon.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco

[Acciones.ActualizarTipoCambio]
Nombre=ActualizarTipoCambio
Boton=92
NombreEnBoton=S
NombreDesplegar=Actualizar Tipo de Cambio
GuardarAntes=S
EspacioPrevio=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=S
Visible=S
ClaveAccion=Actualizar Forma
Antes=S
DespuesGuardar=S
AntesExpresiones=Forma(<T>MonActualizarTemp<T>)

[Iconos.Columnas]
0=-2
1=-2
2=-2
3=-2

[Acciones.ActualizarTipoCambio.ListaAccionesMultiples]
(Inicio)=Actualizar
Actualizar=ActualizarVista
ActualizarVista=(Fin)



[Lista.Mon.CodigoInt]
Carpeta=Lista
Clave=Mon.CodigoInt
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Acciones.CodigioInternacional]
Nombre=CodigioInternacional
Boton=47
NombreEnBoton=S
NombreDesplegar=Código Internacional
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MonCodigoInternacional
Activo=S
Visible=S
EspacioPrevio=S


[Lista.Mon.InforClave]
Carpeta=Lista
Clave=Mon.InforClave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=4
ColorFondo=Blanco














[Acciones.MonHistTemp]
Nombre=MonHistTemp
Boton=93
NombreEnBoton=S
NombreDesplegar=Generar Historico de Tipos de Cambio
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MonHistTemp
Activo=S
Visible=S



GuardarAntes=S
Antes=S
AntesExpresiones=Asigna(Info.Moneda,Mon:Mon.Moneda)
DespuesGuardar=S





[Lista.ListaEnCaptura]
(Inicio)=Mon.Moneda
Mon.Moneda=Mon.Clave
Mon.Clave=Mon.CodigoInt
Mon.CodigoInt=Mon.Nombre
Mon.Nombre=Mon.TipoCambio
Mon.TipoCambio=Mon.TipoCambioVenta
Mon.TipoCambioVenta=Mon.TipoCambioCompra
Mon.TipoCambioCompra=Mon.Tolerancia
Mon.Tolerancia=Mon.InforClave
Mon.InforClave=(Fin)

[Lista.ListaOrden]
(Inicio)=Mon.Orden	(Acendente)
Mon.Orden	(Acendente)=Mon.Moneda	(Acendente)
Mon.Moneda	(Acendente)=(Fin)































































































































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ordenar
Ordenar=MonHist
MonHist=CodigioInternacional
CodigioInternacional=ActualizarTipoCambio
ActualizarTipoCambio=MonHistTemp
MonHistTemp=(Fin)
