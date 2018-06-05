
[Forma]
Clave=MFALayoutLog
Icono=0
BarraHerramientas=S
Modulos=(Todos)
DialogoAbrir=S
MovModulo=(Todos)
Nombre=MFA - Herramienta Adiciones/Excepciones
AccionesTamanoBoton=15x5
AccionesDerecha=S

PosicionInicialAlturaCliente=460
PosicionInicialAncho=711
ListaCarpetas=(Lista)
CarpetaPrincipal=Encabezado
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=386
PosicionInicialArriba=124
ListaAcciones=(Lista)
PosicionSec1=187
Totalizadores=S
PosicionSec2=432
Menus=S
PosicionCol1=309
MenuPrincipal=(Lista)
[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=layout_logA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Acción<T>
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)

OtroOrden=S

ListaOrden=layout_log.log_id<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Predefinido
BusquedaRapidaControles=S
FiltroUsuarios=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroUsuarioDefault=(Usuario)
FiltroFechasCampo=layout_log.inicio
FiltroFechasDefault=Hoy
MenuLocal=S
ListaAcciones=(Lista)
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=SINAFECTAR
PestanaOtroNombre=S
PestanaNombre=MFA - Herramienta Adiciones/Excepciones
IconosConPaginas=S
IconosNombre=layout_logA:layout_log.accion
FiltroGeneral=layout_log.estatus IN(<T>revision<T>, <T>error<T>) AND<BR>layout_log.accion IN(<T>procesar<T>, <T>analizar<T>)
[(Carpeta Abrir).layout_log.estatus]
Carpeta=(Carpeta Abrir)
Clave=layout_log.estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Abrir).layout_log.usuario]
Carpeta=(Carpeta Abrir)
Clave=layout_log.usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Carpeta Abrir).layout_log.conteo]
Carpeta=(Carpeta Abrir)
Clave=layout_log.conteo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).layout_log.inicio]
Carpeta=(Carpeta Abrir)
Clave=layout_log.inicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).layout_log.fin]
Carpeta=(Carpeta Abrir)
Clave=layout_log.fin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).layout_log.error]
Carpeta=(Carpeta Abrir)
Clave=layout_log.error
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).layout_log.error_mensaje]
Carpeta=(Carpeta Abrir)
Clave=layout_log.error_mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[(Carpeta Abrir).Columnas]
0=104
1=115
2=58
3=58
4=90
5=98
6=56
7=240

[Encabezado]
Estilo=Ficha
Clave=Encabezado
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=layout_log
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Generales
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=(Lista)


PermiteEditar=S
[Encabezado.layout_log.accion]
Carpeta=Encabezado
Clave=layout_log.accion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Encabezado.layout_log.estatus]
Carpeta=Encabezado
Clave=layout_log.estatus
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Encabezado.layout_log.usuario]
Carpeta=Encabezado
Clave=layout_log.usuario
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Encabezado.layout_log.conteo]
Carpeta=Encabezado
Clave=layout_log.conteo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[Encabezado.layout_log.inicio]
Carpeta=Encabezado
Clave=layout_log.inicio
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
EspacioPrevio=S
[Encabezado.layout_log.fin]
Carpeta=Encabezado
Clave=layout_log.fin
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[Encabezado.layout_log.error]
Carpeta=Encabezado
Clave=layout_log.error
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[Encabezado.layout_log.error_mensaje]
Carpeta=Encabezado
Clave=layout_log.error_mensaje
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=47
ColorFondo=Blanco


















[Acciones.Navegador (Documentos)]
Nombre=Navegador (Documentos)
Boton=0
NombreDesplegar=Navegador (Documentos)
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S











EspacioPrevio=S

[Detalle]
Estilo=Hoja
PestanaOtroNombre=S
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=layout_logd
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

ListaEnCaptura=(Lista)


PermiteEditar=S
Detalle=S
VistaMaestra=layout_log
LlaveLocal=layout_logd.log_id
LlaveMaestra=layout_log.log_id
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
HojaAjustarColumnas=S
[Detalle.layout_logd.folio]
Carpeta=Detalle
Clave=layout_logd.folio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

EditarConBloqueo=S
[Detalle.layout_logd.referencia]
Carpeta=Detalle
Clave=layout_logd.referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


EditarConBloqueo=S
[Detalle.Columnas]
folio=136
referencia=138












aplicacion_origen_id=48
aplicacion_origen_modulo=48
aplicacion_tipo_aplicacion=83
empresa=49
origen_vista=129
TablaExcepcion=202
Procesar=54
Accion=159

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=No. Registros
Totalizadores2=Conteo(layout_logd:layout_logd.folio)
Totalizadores3=(Cantidades)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=No. Registros
CarpetaVisible=S

PestanaOtroNombre=S

[Acciones.Abrir]
Nombre=Abrir
Boton=2
NombreDesplegar=&Abrir
EnBarraHerramientas=S
Activo=S
Visible=S

Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir














[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S





EspacioPrevio=S
Menu=&Archivo
[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación Preliminar
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S



Menu=&Archivo
[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=&Enviar a Excel
EnBarraHerramientas=S
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S





EspacioPrevio=S








Menu=&Archivo






[Acciones.Aplicacion]
Nombre=Aplicacion
Boton=47
NombreEnBoton=S
NombreDesplegar=Propiedades Aplicación
EnMenu=S
EspacioPrevio=S
Activo=S
Visible=S



Menu=&Archivo
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
AntesExpresiones=Asigna(Info.Modulo, layout_logd:layout_logd.aplicacion_origen_modulo)<BR>Asigna(Info.Rama, layout_logd:layout_logd.aplicacion_origen_modulo)<BR>Asigna(Info.ID, SQL(<T>SELECT ID FROM MFAMovimientoLista WHERE Modulo = :tModulo AND Movimiento = :tMovimiento AND Empresa = :tEmpresa<T>, layout_logd:layout_logd.aplicacion_origen_modulo, layout_logd:layout_logd.folio, Empresa))<BR>Asigna(Info.Cuenta, SQL(<T>SELECT ID FROM MFAMovimientoLista WHERE Modulo = :tModulo AND Movimiento = :tMovimiento AND Empresa = :tEmpresa<T>, layout_logd:layout_logd.aplicacion_origen_modulo, layout_logd:layout_logd.folio, Empresa))<BR>Asigna(Info.Descripcion, layout_logd:layout_logd.folio)
[Acciones.Documento]
Nombre=Documento
Boton=47
NombreEnBoton=S
NombreDesplegar=Propiedades Documento
EnMenu=S
Activo=S
Visible=S







Menu=&Archivo


















TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
AntesExpresiones=Asigna(Info.Modulo, layout_logd:layout_logd.aplicacion_origen_modulo)<BR>Asigna(Info.Rama, layout_logd:layout_logd.aplicacion_origen_modulo)<BR>Asigna(Info.ID, SQL(<T>SELECT ID FROM MFAMovimientoLista WHERE Modulo = :tModulo AND Movimiento = :tMovimiento AND Empresa = :tEmpresa<T>, layout_logd:layout_logd.aplicacion_origen_modulo, layout_logd:layout_logd.referencia, Empresa))<BR>Asigna(Info.Cuenta, SQL(<T>SELECT ID FROM MFAMovimientoLista WHERE Modulo = :tModulo AND Movimiento = :tMovimiento AND Empresa = :tEmpresa<T>, layout_logd:layout_logd.aplicacion_origen_modulo, layout_logd:layout_logd.referencia, Empresa))<BR>Asigna(Info.Descripcion, layout_logd:layout_logd.referencia)
[Acciones.AbrirImprimir]
Nombre=AbrirImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.AbrirPreliminar]
Nombre=AbrirPreliminar
Boton=0
NombreDesplegar=Presentación Preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.AbrirExcel]
Nombre=AbrirExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S



[Acciones.MovPos]
Nombre=MovPos
Boton=0
NombreDesplegar=&Posición del Movimiento (Documento)
EnMenu=S
TipoAccion=Expresion
Activo=S
Antes=S
Visible=S

Menu=&Ver






Expresion=Si SQL(<T>SELECT Version FROM Version<T>) >= 4500<BR>Entonces<BR>  Si SQL(<T>SELECT ISNULL(MovPosicionAnterior, 0) FROM EmpresaGral WHERE Empresa = :tEmpresa<T>, Empresa) = Falso<BR>  Entonces<BR>    EjecutarSQL(<T>EXEC spMovPos :nEstacion, :tModulo, :tModuloID<T>, EstacionTrabajo, Info.Modulo, Info.ID)<BR>    Forma(<T>MovPosArbol<T>)<BR>  Sino<BR>    Forma(<T>MovPos<T>)<BR>  Fin<BR>Sino<BR>  Forma(<T>MovPos<T>)<BR>Fin
AntesExpresiones=Asigna(Info.Modulo, layout_logd:layout_logd.aplicacion_origen_modulo)<BR>Asigna(Info.ID, SQL(<T>SELECT ID FROM MFAMovimientoLista WHERE Modulo = :tModulo AND Movimiento = :tMovimiento AND Empresa = :tEmpresa<T>, layout_logd:layout_logd.aplicacion_origen_modulo, layout_logd:layout_logd.referencia, Empresa))<BR>Asigna(Info.Mov, SQL(<T>SELECT Mov FROM MFAMovimientoLista WHERE Modulo = :tModulo AND Movimiento = :tMovimiento AND Empresa = :tEmpresa<T>, layout_logd:layout_logd.aplicacion_origen_modulo, layout_logd:layout_logd.referencia, Empresa))<BR>Asigna(Info.MovID, SQL(<T>SELECT MovID FROM MFAMovimientoLista WHERE Modulo = :tModulo AND Movimiento = :tMovimiento AND Empresa = :tEmpresa<T>, layout_logd:layout_logd.aplicacion_origen_modulo, layout_logd:layout_logd.referencia, Empresa))
[Origen.Columnas]
0=276
1=121

[Destino.Columnas]
0=277
1=122











































[Detalle.layout_logd.Accion]
Carpeta=Detalle
Clave=layout_logd.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco









EditarConBloqueo=S
[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S


































[Acciones.Procesar]
Nombre=Procesar
Boton=7
NombreDesplegar=&Procesar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
















GuardarAntes=S
























Antes=S
DespuesGuardar=S



























































































































Menu=&Archivo
EnMenu=S
UsaTeclaRapida=S
TeclaRapida=F12
Expresion=ProcesarSQL(<T>EXEC spMFALayoutDProcesar :nlog_id, @Cancelar = 0<T>, layout_log:layout_log.log_id)<BR>ActualizarVista<BR>ActualizarForma<BR>//Forma(<T>MFALayoutLogSQL<T>)
ActivoCondicion=//layout_log:layout_log.Procesado = Falso<BR>layout_log:layout_log.EstatusAnalisis = EstatusSinAfectar
AntesExpresiones=Asigna(Info.ID, layout_log:layout_log.log_id)
[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
NombreDesplegar=Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S










UsaTeclaRapida=S
TeclaRapida=Ctrl+N



















[Detalle.layout_logd.aplicacion_origen_modulo]
Carpeta=Detalle
Clave=layout_logd.aplicacion_origen_modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





























EditarConBloqueo=S












[Lista.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2
6=-2



























































































[Acciones.AbrirPersonalizar]
Nombre=AbrirPersonalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S




[(Carpeta Totalizadores).No. Registros]
Carpeta=(Carpeta Totalizadores)
Clave=No. Registros
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata





























































[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S



















Menu=&Archivo
EnMenu=S
ConfirmarAntes=S
Expresion=ProcesarSQL(<T>EXEC spMFALayoutDProcesar :nlog_id, @Cancelar = 1<T>, layout_log:layout_log.log_id)<BR>ActualizarVista<BR>ActualizarForma
ActivoCondicion=layout_log:layout_log.EstatusAnalisis = EstatusConcluido
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=Eliminar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S




EspacioPrevio=S

































Menu=&Archivo
EnMenu=S






















































ActivoCondicion=layout_log:layout_log.accion <> <T>procesar<T>  y(layout_log:layout_log.EstatusAnalisis = EstatusSinAfectar)




[Encabezado.ListaEnCaptura]
(Inicio)=layout_log.accion
layout_log.accion=layout_log.estatus
layout_log.estatus=layout_log.usuario
layout_log.usuario=layout_log.conteo
layout_log.conteo=layout_log.inicio
layout_log.inicio=layout_log.fin
layout_log.fin=layout_log.error
layout_log.error=layout_log.error_mensaje
layout_log.error_mensaje=(Fin)



















[Detalle.ListaEnCaptura]
(Inicio)=layout_logd.aplicacion_origen_modulo
layout_logd.aplicacion_origen_modulo=layout_logd.referencia
layout_logd.referencia=layout_logd.folio
layout_logd.folio=layout_logd.Accion
layout_logd.Accion=(Fin)
















































































































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=layout_log.estatus
layout_log.estatus=layout_log.usuario
layout_log.usuario=layout_log.conteo
layout_log.conteo=layout_log.inicio
layout_log.inicio=layout_log.fin
layout_log.fin=layout_log.error
layout_log.error=layout_log.error_mensaje
layout_log.error_mensaje=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CONCLUIDO
CONCLUIDO=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirPersonalizar
AbrirPersonalizar=(Fin)




[Forma.ListaCarpetas]
(Inicio)=Encabezado
Encabezado=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Aplicacion
Aplicacion=Documento
Documento=MovPos
MovPos=Procesar
Procesar=Eliminar
Eliminar=Cancelar
Cancelar=Navegador (Documentos)
Navegador (Documentos)=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)
