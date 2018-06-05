[Forma]
Clave=POSMovTipo
Nombre=<T>Tipos de Movimientos - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=292
PosicionInicialArriba=99
PosicionInicialAltura=336
PosicionInicialAncho=1016
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=35
PosicionInicialAlturaCliente=623
PosicionCol1=272

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipo
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MovTipo.Mov
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)
PestanaNombre=Lista
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=MovTipo.Modulo
FiltroAncho=30
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todos)
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
HojaMantenerSeleccion=S
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

FiltroGeneral=MovTipo.Modulo=<T>{Info.Modulo}<T>
[Lista.MovTipo.Mov]
Carpeta=Lista
Clave=MovTipo.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Mov=241
Modulo=107
Orden=42
Clave=80
Grupo=304
ConsecutivoModulo=103
ConsecutivoMov=125
ConsecutivoPorPeriodo=132
ConsecutivoPorEjercicio=129
ConsecutivoPorEmpresa=125
ModuloNombre=132
0=37
1=67

2=-2
3=-2
4=-2
[Detalle]
Estilo=Ficha
PestanaNombre=Datos Generales
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MovTipo
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Pestana=S
PestanaOtroNombre=S

[Detalle.MovTipo.Mov]
Carpeta=Detalle
Clave=MovTipo.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.MovTipo.Clave]
Carpeta=Detalle
Clave=MovTipo.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=N
ColorFondo=Blanco
Efectos=[Negritas]

[Consecutivo.MovTipo.ConsecutivoModulo]
Carpeta=Consecutivo
Clave=MovTipo.ConsecutivoModulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S

[Consecutivo.MovTipo.ConsecutivoMov]
Carpeta=Consecutivo
Clave=MovTipo.ConsecutivoMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Consecutivo.MovTipo.ConsecutivoPorPeriodo]
Carpeta=Consecutivo
Clave=MovTipo.ConsecutivoPorPeriodo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20

[Consecutivo.MovTipo.ConsecutivoPorEjercicio]
Carpeta=Consecutivo
Clave=MovTipo.ConsecutivoPorEjercicio
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20

[Consecutivo.MovTipo.ConsecutivoPorEmpresa]
Carpeta=Consecutivo
Clave=MovTipo.ConsecutivoPorEmpresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=S

[Consecutivo.MovTipo.Mov]
Carpeta=Consecutivo
Clave=MovTipo.Mov
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
ConfirmarAntes=S




[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S






[Gasto.MovTipo.GastoMov]
Carpeta=Gasto
Clave=MovTipo.GastoMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco
ColorFuente=Negro

[Gasto.MovTipo.GastoClase]
Carpeta=Gasto
Clave=MovTipo.GastoClase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco
ColorFuente=Negro

[Gasto.MovTipo.GastoSubClase]
Carpeta=Gasto
Clave=MovTipo.GastoSubClase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco
ColorFuente=Negro


[Gasto.MovTipo.GastoAcreedor]
Carpeta=Gasto
Clave=MovTipo.GastoAcreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Gasto.Acreedor.Nombre]
Carpeta=Gasto
Clave=Acreedor.Nombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Pegado=N


[Acciones.MovTipoTarea]
Nombre=MovTipoTarea
Boton=70
NombreDesplegar=Tareas por Omisión
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovTipoTarea
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(MovTipo:MovTipo.Mov)
AntesExpresiones=Asigna(Info.Mov, MovTipo:MovTipo.Mov)


[Detalle.MovTipo.Factor]
Carpeta=Detalle
Clave=MovTipo.Factor
Editar=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
Pegado=S
LineaNueva=N
Efectos=[Negritas]


[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=111
NombreDesplegar=&Plantillas Office
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovTipoPlantillaOffice
Activo=S
Visible=S
EspacioPrevio=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(MovTipo:MovTipo.Mov)
AntesExpresiones=Asigna(Info.Mov, MovTipo:MovTipo.Mov)<BR>Asigna(Info.Forma, Nulo)


[Detalle.MovTipo.TipoPago]
Carpeta=Detalle
Clave=MovTipo.TipoPago
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
ValidaNombre=S
Pegado=S

[Gasto.MovTipo.GastoFactor]
Carpeta=Gasto
Clave=MovTipo.GastoFactor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro





[NomAuto.MovTipo.NomAutoTipo]
Carpeta=NomAuto
Clave=MovTipo.NomAutoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[NomAuto.MovTipo.NomAutoCxc]
Carpeta=NomAuto
Clave=MovTipo.NomAutoCxc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[NomAuto.MovTipo.NomAutoCalcSDI]
Carpeta=NomAuto
Clave=MovTipo.NomAutoCalcSDI
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Acciones.FormasAnexas]
Nombre=FormasAnexas
Boton=113
NombreDesplegar=Formas Anexas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovTipoFormaAnexo
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Mov, MovTipo:MovTipo.Mov)

[NomAuto.MovTipo.NomAutoCalendarioEsp]
Carpeta=NomAuto
Clave=MovTipo.NomAutoCalendarioEsp
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro




[Detalle.MovTipo.Icono]
Carpeta=Detalle
Clave=MovTipo.Icono
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco


[Proyecto.MovTipo.ProyectoContactoTipo]
Carpeta=Proyecto
Clave=MovTipo.ProyectoContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.MovTipo.CFD]
Carpeta=Detalle
Clave=MovTipo.CFD
Editar=S
3D=S
Tamano=6
ColorFondo=Blanco



LineaNueva=S
EspacioPrevio=S
[CFD.MovTipo.CFD_tipoDeComprobante]
Carpeta=CFD
Clave=MovTipo.CFD_tipoDeComprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[CFD.MovTipo.CFD_Reporte]
Carpeta=CFD
Clave=MovTipo.CFD_Reporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=48
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Instrucciones]
Nombre=Instrucciones
Boton=90
NombreDesplegar=&Instrucciones Especiales
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovTipoInstrucciones
Activo=S
Visible=S
EspacioPrevio=S
ConCondicion=S
Antes=S

EjecucionCondicion=ConDatos(MovTipo:MovTipo.Mov)
AntesExpresiones=Asigna(Info.Mov, MovTipo:MovTipo.Mov)
[Proyecto.MovTipo.PlantillaProyecto]
Carpeta=Proyecto
Clave=MovTipo.PlantillaProyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Proyecto.MovTipo.PlantillaProyectoFija]
Carpeta=Proyecto
Clave=MovTipo.PlantillaProyectoFija
Editar=S
LineaNueva=N
3D=S
EspacioPrevio=N
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Gasto.MovTipo.GastoConcepto]
Carpeta=Gasto
Clave=MovTipo.GastoConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=31
ColorFondo=Blanco
ColorFuente=Negro

[Campana.MovTipo.ParaProspectos]
Carpeta=Campana
Clave=MovTipo.ParaProspectos
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Campana.MovTipo.ParaClientes]
Carpeta=Campana
Clave=MovTipo.ParaClientes
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Campana.MovTipo.ParaProveedores]
Carpeta=Campana
Clave=MovTipo.ParaProveedores
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Campana.MovTipo.ParaPersonal]
Carpeta=Campana
Clave=MovTipo.ParaPersonal
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Campana.MovTipo.ParaAgentes]
Carpeta=Campana
Clave=MovTipo.ParaAgentes
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Campana.MovTipo.OportunidadMov]
Carpeta=Campana
Clave=MovTipo.OportunidadMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[FormaTipo.MovTipo.FormaTipo]
Carpeta=FormaTipo
Clave=MovTipo.FormaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[FormaTipo.FormaTipoFormas.NombreCorto]
Carpeta=FormaTipo
Clave=FormaTipoFormas.NombreCorto
Editar=S
3D=S
Tamano=35
ColorFondo=Plata
ColorFuente=Negro

[FormaTipo.MovTipo.FormaFija]
Carpeta=FormaTipo
Clave=MovTipo.FormaFija
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S


[Proyecto.MovTipo.ProyectoSugerir]
Carpeta=Proyecto
Clave=MovTipo.ProyectoSugerir
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[Inv.MovTipo.TraspasoExpress]
Carpeta=Inv
Clave=MovTipo.TraspasoExpress
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[Detalle.MovTipo.SubClave]
Carpeta=Detalle
Clave=MovTipo.SubClave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Gasto.ListaEnCaptura]
(Inicio)=MovTipo.GastoMov
MovTipo.GastoMov=MovTipo.GastoClase
MovTipo.GastoClase=MovTipo.GastoSubClase
MovTipo.GastoSubClase=MovTipo.GastoConcepto
MovTipo.GastoConcepto=MovTipo.GastoAcreedor
MovTipo.GastoAcreedor=Acreedor.Nombre
Acreedor.Nombre=MovTipo.GastoFactor
MovTipo.GastoFactor=(Fin)

[NomAuto.ListaEnCaptura]
(Inicio)=MovTipo.NomAutoTipo
MovTipo.NomAutoTipo=MovTipo.NomAutoCxc
MovTipo.NomAutoCxc=MovTipo.NomAutoCalcSDI
MovTipo.NomAutoCalcSDI=MovTipo.NomAutoCalendarioEsp
MovTipo.NomAutoCalendarioEsp=(Fin)

[Proyecto.ListaEnCaptura]
(Inicio)=MovTipo.ProyectoContactoTipo
MovTipo.ProyectoContactoTipo=MovTipo.PlantillaProyecto
MovTipo.PlantillaProyecto=MovTipo.PlantillaProyectoFija
MovTipo.PlantillaProyectoFija=MovTipo.ProyectoSugerir
MovTipo.ProyectoSugerir=(Fin)

[CFD.ListaEnCaptura]
(Inicio)=MovTipo.CFD_tipoDeComprobante
MovTipo.CFD_tipoDeComprobante=MovTipo.CFD_Reporte
MovTipo.CFD_Reporte=(Fin)

[FormaTipo.ListaEnCaptura]
(Inicio)=MovTipo.FormaTipo
MovTipo.FormaTipo=FormaTipoFormas.NombreCorto
FormaTipoFormas.NombreCorto=MovTipo.FormaFija
MovTipo.FormaFija=(Fin)













[Lista.ListaOrden]
(Inicio)=MovTipo.Modulo	(Acendente)
MovTipo.Modulo	(Acendente)=MovTipo.Orden	(Acendente)
MovTipo.Orden	(Acendente)=(Fin)






[Ecuador.MovTipo.EcuadorMostrarAnexo]
Carpeta=Ecuador
Clave=MovTipo.EcuadorMostrarAnexo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





























[Guatemala.MovTipo.GuatemalaLibroVentaExento]
Carpeta=Guatemala
Clave=MovTipo.GuatemalaLibroVentaExento
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco



Tamano=20


















































[Detalle.MovTipo.Orden]
Carpeta=Detalle
Clave=MovTipo.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Detalle.MovTipo.CFD_tipoDeComprobante]
Carpeta=Detalle
Clave=MovTipo.CFD_tipoDeComprobante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








[Detalle.MovTipo.CFDFlex]
Carpeta=Detalle
Clave=MovTipo.CFDFlex
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Detalle.MovTipo.ConsecutivoModulo]
Carpeta=Detalle
Clave=MovTipo.ConsecutivoModulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco



[Detalle.ListaEnCaptura]
(Inicio)=MovTipo.Mov
MovTipo.Mov=MovTipo.TipoPago
MovTipo.TipoPago=MovTipo.Clave
MovTipo.Clave=MovTipo.Factor
MovTipo.Factor=MovTipo.Icono
MovTipo.Icono=MovTipo.SubClave
MovTipo.SubClave=MovTipo.CFD
MovTipo.CFD=MovTipo.Orden
MovTipo.Orden=MovTipo.CFD_tipoDeComprobante
MovTipo.CFD_tipoDeComprobante=MovTipo.CFDFlex
MovTipo.CFDFlex=MovTipo.ConsecutivoModulo
MovTipo.ConsecutivoModulo=(Fin)















































[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Eliminar
Eliminar=MovTipoTarea
MovTipoTarea=PlantillasOffice
PlantillasOffice=FormasAnexas
FormasAnexas=Instrucciones
Instrucciones=Navegador
Navegador=(Fin)
