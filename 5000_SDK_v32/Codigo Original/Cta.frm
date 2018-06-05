[Forma]
Clave=Cta
Nombre=Cuentas
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=306
PosicionInicialArriba=62
PosicionInicialAltura=569
PosicionInicialAncho=779
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaBloquearAjuste=
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=43
PosicionSeccion1=67
ExpresionesAlMostrar=Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Ult.CtaTipo, Nulo)
BarraAyuda=S
PosicionInicialAlturaCliente=647
PosicionSec1=330

MenuPrincipal=(Lista)
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cta
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=Cta.Cuenta<TAB>(Acendente)
HojaAjustarColumnas=S
Filtros=S
FiltroGrupo1=Cta.Rama
FiltroAplicaEn=Cta.Cuenta
FiltroTipo=Arbol
FiltroEnOrden=S
FiltroTodoNombre=Contabilidad
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=40
FiltroPredefinido=S
FiltroValida1=CtaLista.Descripcion
FiltroArbolClave=Cta.Cuenta
FiltroArbolValidar=Cta.Descripcion
FiltroArbolRama=Cta.Rama
FiltroArbolAcumulativas=Cta.EsAcumulativa
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=40
BusquedaEnLinea=S
FiltroListas=S
FiltroListasRama=CONT
FiltroListasAplicaEn=Cta.Cuenta
PermiteLocalizar=S

[Lista.Cta.Descripcion]
Carpeta=Lista
Clave=Cta.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalles
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=Cta
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

CondicionEdicion=(no Cta:Cta.TieneMovimientos) y<BR>(vacio(SQL(<T>SELECT Cuenta FROM ContXD WHERE Cuenta=:tClave<T>,Cta:Cta.Cuenta))) y<BR>(vacio(SQL(<T>SELECT CuentaOmision FROM MovTipoContAuto WHERE CuentaOmision=:tClave<T>,Cta:Cta.Cuenta)))
[Detalle.Cta.Cuenta]
Carpeta=Detalle
Clave=Cta.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.Cta.Rama]
Carpeta=Detalle
Clave=Cta.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=N
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.Cta.Descripcion]
Carpeta=Detalle
Clave=Cta.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=45
ColorFondo=Blanco

[Lista.Columnas]
Cuenta=111
Descripcion=303
Clave=140

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Nueva]
Nombre=Nueva
Boton=1
NombreEnBoton=S
Menu=&Archivo
NombreDesplegar=&Nueva
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
GuardarAntes=S
Antes=S
AntesExpresiones=Asigna(Def.Rama, Cta:Cta.Rama)<BR>Asigna(Def.EsAcreedora, Cta:Cta.EsAcreedora)<BR>Si<BR>  Vacio(Def.Rama)<BR>Entonces<BR>  Asigna(Def.Rama, FiltroActual)<BR>  Asigna(Def.EsAcreedora, Falso)<BR>Fin

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
ConfirmarAntes=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ConCondicion=S
EjecucionConError=S

ActivoCondicion=(no Cta:Cta.TieneMovimientos) y<BR>(vacio(SQL(<T>SELECT Cuenta FROM ContXD WHERE Cuenta=:tClave<T>,Cta:Cta.Cuenta))) y<BR>(vacio(SQL(<T>SELECT CuentaOmision FROM MovTipoContAuto WHERE CuentaOmision=:tClave<T>,Cta:Cta.Cuenta)))
EjecucionCondicion=(no Cta:Cta.TieneMovimientos) y<BR>(vacio(SQL(<T>SELECT Cuenta FROM ContXD WHERE Cuenta=:tClave<T>,Cta:Cta.Cuenta))) y<BR>(vacio(SQL(<T>SELECT CuentaOmision FROM MovTipoContAuto WHERE CuentaOmision=:tClave<T>,Cta:Cta.Cuenta)))
EjecucionMensaje=<T>Esta Cuenta Tiene Movimientos o Existen Polizas Configuradas Con Esta Cuenta<T>
[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Detalle.CtaLista.Descripcion]
Carpeta=Detalle
Clave=CtaLista.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=45
ColorFondo=Plata
IgnoraFlujo=N

[Configuracion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Configuración
Clave=Configuracion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=Cta
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F11
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Prop
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Cta:Cta.Cuenta)
AntesExpresiones=Asigna(Info.Rama, <T>CONT<T>)<BR>Asigna(Info.Cuenta, Cta:Cta.Cuenta)<BR>Asigna(Info.Descripcion, Cta:Cta.Descripcion)

[Acciones.CentrosCostos]
Nombre=CentrosCostos
Boton=16
Menu=&Edición
UsaTeclaRapida=S
NombreDesplegar=&Centros Costos
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaSub
Antes=S
Visible=S
NombreEnBoton=S
TeclaRapida=F7
ConCondicion=S
DespuesGuardar=S
ActivoCondicion=Cta:Cta.CentrosCostos
EjecucionCondicion=ConDatos(Cta:Cta.Cuenta)
AntesExpresiones=Asigna(Info.Cuenta, Cta:Cta.Cuenta)<BR>Asigna(Info.Descripcion, Cta:Cta.Descripcion)<BR>Asigna(Info.SubCuenta, Nulo)<BR>Asigna(Info.Tipo, Nulo)<BR>Asigna(Info.Rama, <T>CONT<T>)<BR>Asigna(Info.VerAcum, Verdadero)

[Acciones.Informacion]
Nombre=Informacion
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Información
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaInfo
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
ConCondicion=S
EjecucionCondicion=ConDatos(Cta:Cta.Cuenta)
AntesExpresiones=Asigna(Info.Cuenta, Cta:Cta.Cuenta)

[Lista.Clave]
Carpeta=Lista
Clave=Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Cta.EsAcumulativa]
Carpeta=Detalle
Clave=Cta.EsAcumulativa
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Detalle.Cta.EsAcreedora]
Carpeta=Detalle
Clave=Cta.EsAcreedora
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco

[Configuracion.Cta.Categoria]
Carpeta=Configuracion
Clave=Cta.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.Familia]
Carpeta=Configuracion
Clave=Cta.Familia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.Grupo]
Carpeta=Configuracion
Clave=Cta.Grupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Presupuesto]
Nombre=Presupuesto
Boton=0
Menu=&Edición
NombreDesplegar=P&resupuesto
GuardarAntes=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
EspacioPrevio=S
ConCondicion=S
Antes=S
DespuesGuardar=S

Expresion=Si(Config.ContMovPresupuesto, Forma(<T>PresupuestoAcum<T>), Si(General.TiposPresupuesto, Forma(<T>PresupuestoTipoLista<T>), Si(Info.VerAcum, Forma(<T>PresupuestoAcum<T>), Forma(<T>Presupuesto<T>))))
EjecucionCondicion=ConDatos(Cta:Cta.Cuenta)
AntesExpresiones=Asigna(Info.Rama, <T>CONT<T>)<BR>Asigna(Info.Cuenta, Cta:Cta.Cuenta)<BR>Asigna(Info.Descripcion, Cta:Cta.Descripcion) <BR>Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Info.Acumulativa, Cta:Cta.EsAcumulativa)<BR>Asigna(Info.SubCuenta, Nulo)<BR>Asigna(Info.Tipo, Nulo)<BR>Caso Config.ContNivelPresupuesto<BR>  Es <T>Detalle<T> Entonces Asigna(Info.VerAcum, Cta:Cta.EsAcumulativa)<BR>  Es <T>Mayor<T>   Entonces Asigna(Info.VerAcum, Cta:Cta.Tipo<><T>Mayor<T>)<BR>Fin
[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Actualizar
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S
Carpeta=Lista

[Configuracion.Cta.CentrosCostos]
Carpeta=Configuracion
Clave=Cta.CentrosCostos
Editar=S
LineaNueva=S
3D=S
Tamano=20
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CtaIVA]
Nombre=CtaIVA
Boton=0
Menu=&Maestros
NombreDesplegar=Cuentas para Verificar IVA
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaIVA
Activo=S
VisibleCondicion=Config.ContVerificarIVA

[Detalle.Cta.Tipo]
Carpeta=Detalle
Clave=Cta.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=15
Efectos=[Negritas]
ColorFondo=Blanco

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.RepCta]
Nombre=RepCta
Boton=6
Menu=&Ver
NombreDesplegar=Catálogo de Cuentas...
EnMenu=S
TipoAccion=Formas
ClaveAccion=RepCta
Activo=S
Visible=S
EspacioPrevio=S

[Configuracion.Cta.CentroCostosOmision]
Carpeta=Configuracion
Clave=Cta.CentroCostosOmision
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Configuracion.Cta.CentroCostosRequerido]
Carpeta=Configuracion
Clave=Cta.CentroCostosRequerido
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
ConCondicion=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Cta:Cta.Cuenta)
AntesExpresiones=Asigna(Info.Rama, <T>CONT<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, Cta:Cta.Cuenta)<BR>Asigna(Info.Descripcion, Cta:Cta.Descripcion)
RefrescarDespues=S

[Acciones.Doc]
Nombre=Doc
Boton=17
Menu=&Edición
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Expresion=EditarDocumentacion(<T>CONT<T>, Cta:Cta.Cuenta, <T>Documentación - <T>+Cta:Cta.Descripcion)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Cta:Cta.Cuenta)
Visible=S

[Acciones.CtaCat]
Nombre=CtaCat
Boton=0
Menu=&Maestros
NombreDesplegar=&Categorías
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaCat
Activo=S
Visible=S

[Acciones.CtaGrupo]
Nombre=CtaGrupo
Boton=0
Menu=&Maestros
NombreDesplegar=&Grupos
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaGrupo
Activo=S
Visible=S

[Acciones.CtaFam]
Nombre=CtaFam
Boton=0
Menu=&Maestros
NombreDesplegar=&Familias
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaFam
Activo=S
Visible=S

[Acciones.ContUso]
Nombre=ContUso
Boton=0
Menu=&Maestros
NombreDesplegar=&Usos Contables
EnMenu=S
TipoAccion=Formas
ClaveAccion=ContUso
EspacioPrevio=S

[Detalle.Cta.Estatus]
Carpeta=Detalle
Clave=Cta.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros2]
Nombre=Otros2
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros3]
Nombre=Otros3
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros4]
Nombre=Otros4
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros5]
Nombre=Otros5
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros6]
Nombre=Otros6
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros7]
Nombre=Otros7
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros8]
Nombre=Otros8
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros9]
Nombre=Otros9
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Configuracion.Cta.NivelAcceso]
Carpeta=Configuracion
Clave=Cta.NivelAcceso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.AjusteInflacionario]
Carpeta=Configuracion
Clave=Cta.AjusteInflacionario
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N

[Detalle.Cta.Bucket]
Carpeta=Detalle
Clave=Cta.Bucket
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Configuracion.Cta.CuadreContable]
Carpeta=Configuracion
Clave=Cta.CuadreContable
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[Acciones.CtaMov]
Nombre=CtaMov
Boton=65
Menu=&Edición
NombreDesplegar=Movimientos (Cuadre Contable)
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaMov
Antes=S
Visible=S
ActivoCondicion=Cta:Cta.CuadreContable
AntesExpresiones=Asigna(Info.Cuenta, Cta:Cta.Cuenta)

[Configuracion.Cta.PresupuestoNivelUEN]
Carpeta=Configuracion
Clave=Cta.PresupuestoNivelUEN
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Cta.CuentaDistribucion]
Carpeta=Detalle
Clave=Cta.CuentaDistribucion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Configuracion.Cta.PresupuestoOtrosPeriodos]
Carpeta=Configuracion
Clave=Cta.PresupuestoOtrosPeriodos
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.DetalleTipo]
Carpeta=Configuracion
Clave=Cta.DetalleTipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Historico]
Nombre=Historico
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+H
NombreDesplegar=Histórico de Cambios
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Tabla, <T>Cta<T>)<BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(<T>Ficha<T>, <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>RegHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Cta:Cta.Cuenta)
Antes=S
AntesExpresiones=Asigna(Info.Nombre, Cta:Cta.Cuenta & <T> <T> & Cta:Cta.Descripcion)
Visible=S

[Acciones.CentrosCostos2]
Nombre=CentrosCostos2
Boton=0
Menu=&Edición
NombreDesplegar=Centros Costos 2
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaSub2
ConCondicion=S
Antes=S
Visible=S
GuardarAntes=S
ActivoCondicion=Cta:Cta.CentroCostos2
EjecucionCondicion=ConDatos(Cta:Cta.Cuenta)
AntesExpresiones=Asigna(Info.Cuenta, Cta:Cta.Cuenta)<BR>Asigna(Info.Descripcion, Cta:Cta.Descripcion)<BR>Asigna(Info.SubCuenta, Nulo)

[Acciones.CentrosCostos3]
Nombre=CentrosCostos3
Boton=0
Menu=&Edición
NombreDesplegar=Centros Costos 3
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CtaSub3
ActivoCondicion=Cta:Cta.CentroCostos3
ConCondicion=S
EjecucionCondicion=ConDatos(Cta:Cta.Cuenta)
Antes=S
AntesExpresiones=Asigna(Info.Cuenta, Cta:Cta.Cuenta)<BR>Asigna(Info.Descripcion, Cta:Cta.Descripcion)<BR>Asigna(Info.SubCuenta, Nulo)
Visible=S

[Configuracion.Cta.CentroCostos2]
Carpeta=Configuracion
Clave=Cta.CentroCostos2
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.CentroCostosRequerido2]
Carpeta=Configuracion
Clave=Cta.CentroCostosRequerido2
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.CentroCostosOmision2]
Carpeta=Configuracion
Clave=Cta.CentroCostosOmision2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.CentroCostos3]
Carpeta=Configuracion
Clave=Cta.CentroCostos3
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.CentroCostosRequerido3]
Carpeta=Configuracion
Clave=Cta.CentroCostosRequerido3
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Configuracion.Cta.CentroCostosOmision3]
Carpeta=Configuracion
Clave=Cta.CentroCostosOmision3
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro




[Lista.ListaEnCaptura]
(Inicio)=Clave
Clave=Cta.Descripcion
Cta.Descripcion=(Fin)


[Configuracion.ListaEnCaptura]
(Inicio)=Cta.Categoria
Cta.Categoria=Cta.Familia
Cta.Familia=Cta.Grupo
Cta.Grupo=Cta.DetalleTipo
Cta.DetalleTipo=Cta.NivelAcceso
Cta.NivelAcceso=Cta.CuadreContable
Cta.CuadreContable=Cta.AjusteInflacionario
Cta.AjusteInflacionario=Cta.PresupuestoNivelUEN
Cta.PresupuestoNivelUEN=Cta.PresupuestoOtrosPeriodos
Cta.PresupuestoOtrosPeriodos=Cta.CentrosCostos
Cta.CentrosCostos=Cta.CentroCostosRequerido
Cta.CentroCostosRequerido=Cta.CentroCostosOmision
Cta.CentroCostosOmision=Cta.CentroCostos2
Cta.CentroCostos2=Cta.CentroCostosRequerido2
Cta.CentroCostosRequerido2=Cta.CentroCostosOmision2
Cta.CentroCostosOmision2=Cta.CentroCostos3
Cta.CentroCostos3=Cta.CentroCostosRequerido3
Cta.CentroCostosRequerido3=Cta.CentroCostosOmision3
Cta.CentroCostosOmision3=(Fin)






































































[Detalle.ListaEnCaptura]
(Inicio)=Cta.Cuenta
Cta.Cuenta=Cta.Descripcion
Cta.Descripcion=Cta.Tipo
Cta.Tipo=Cta.Bucket
Cta.Bucket=Cta.Rama
Cta.Rama=CtaLista.Descripcion
CtaLista.Descripcion=Cta.Estatus
Cta.Estatus=Cta.CuentaDistribucion
Cta.CuentaDistribucion=Cta.EsAcumulativa
Cta.EsAcumulativa=Cta.EsAcreedora
Cta.EsAcreedora=(Fin)




[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=Configuracion
Configuracion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Nueva
Nueva=Eliminar
Eliminar=Propiedades
Propiedades=CentrosCostos
CentrosCostos=CentrosCostos2
CentrosCostos2=CentrosCostos3
CentrosCostos3=CtaMov
CtaMov=Anexos
Anexos=Doc
Doc=Presupuesto
Presupuesto=Informacion
Informacion=RepCta
RepCta=Navegador
Navegador=Actualizar
Actualizar=Cerrar
Cerrar=CtaCat
CtaCat=CtaGrupo
CtaGrupo=CtaFam
CtaFam=ContUso
ContUso=CtaIVA
CtaIVA=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=Historico
Historico=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)
