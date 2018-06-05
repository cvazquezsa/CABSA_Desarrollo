[Forma]
Clave=CentroCostos2
Nombre=Centros de Costos 2
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=484
PosicionInicialArriba=152
PosicionInicialAltura=540
PosicionInicialAncho=635
PosicionSeccion1=79
Menus=S
PosicionInicialAlturaCliente=513
PosicionSec1=347

MenuPrincipal=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CentroCostos2
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroArbolClave=CentroCostos2.CentroCostos2
FiltroArbolValidar=CentroCostos2.Descripcion
FiltroArbolRama=CentroCostos2.Rama
FiltroArbolAcumulativas=CentroCostos2.EsAcumulativo
FiltroAncho=30
FiltroTodoNombre=Todos
FiltroNullNombre=(sin agrupar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
HojaMantenerSeleccion=S
FiltroTodo=S
FiltroGrupo1=CentroCostos2.Grupo
FiltroValida1=CentroCostos2.Grupo
FiltroGrupo2=CentroCostos2.SubGrupo
FiltroValida2=CentroCostos2.SubGrupo
FiltroNull=S
FiltroGrupo3=CentroCostos2.SubSubGrupo
FiltroValida3=CentroCostos2.SubSubGrupo
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
HojaColoresPorEstatus=S
FiltroGeneral=CentroCostos2.EsAcumulativo=0

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
EnMenu=S

[Lista.Columnas]
CentroCostos2=125
Categoria=157
Grupo1=125
Grupo2=136
Grupo3=125
Grupo=304
SubGrupo=304
Rama=97
Descripcion=243
EsAcumulativo=77
TieneMovimientos=93

[Lista.CentroCostos2.CentroCostos2]
Carpeta=Lista
Clave=CentroCostos2.CentroCostos2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CentroCostos2.Descripcion]
Carpeta=Lista
Clave=CentroCostos2.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Detalle]
Estilo=Ficha
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CentroCostos2
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
PermiteEditar=S
PestanaNombre=Detalles

[Detalle.CentroCostos2.CentroCostos2]
Carpeta=Detalle
Clave=CentroCostos2.CentroCostos2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CentroCostos2.Descripcion]
Carpeta=Detalle
Clave=CentroCostos2.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

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

[Grupos.CentroCostos2.Grupo]
Carpeta=Grupos
Clave=CentroCostos2.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Grupos.CentroCostos2.SubGrupo]
Carpeta=Grupos
Clave=CentroCostos2.SubGrupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
Menu=&Archivo
EnMenu=S
NombreEnBoton=S
Antes=S
AntesExpresiones=Asigna(Def.Rama, CentroCostos2:CentroCostos2.Rama)<BR>Si(Vacio(Def.Rama), Asigna(Def.Rama, FiltroActual))

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
Menu=&Archivo
EnMenu=S
NombreEnBoton=S
Carpeta=Detalle
ActivoCondicion=no CentroCostos2:CentroCostos2.TieneMovimientos

[Acciones.Presupuesto]
Nombre=Presupuesto
Boton=64
NombreEnBoton=S
NombreDesplegar=&Presupuesto
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Activo=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
EnMenu=S

Expresion=Asigna(Info.Rama, <T>CC<T>)<BR>Asigna(Info.Cuenta, CentroCostos2:CentroCostos2.CentroCostos2)<BR>Asigna(Info.Descripcion, CentroCostos2:CentroCostos2.Descripcion) <BR>Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Info.Acumulativa, CentroCostos2:CentroCostos2.EsAcumulativo)<BR>Asigna(Info.VerAcum, CentroCostos2:CentroCostos2.EsAcumulativo)<BR>Asigna(Info.SubCuenta, Nulo)<BR>Asigna(Info.Tipo, Nulo)<BR>Asigna(Info.VerAcum, CentroCostos2:CentroCostos2.EsAcumulativo)<BR>Si(General.TiposPresupuesto, Forma(<T>PresupuestoTipoLista<T>), Si(Info.VerAcum, Forma(<T>PresupuestoAcum<T>), Forma(<T>Presupuesto<T>)))
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

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Actualizar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S

[Acciones.Explorar]
Nombre=Explorar
Boton=47
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=&Explorar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerAcum
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(CentroCostos2:CentroCostos2.CentroCostos2)
AntesExpresiones=IrDireccion(<T>CC<T>, CentroCostos2:CentroCostos2.CentroCostos2)<BR>Asigna(Info.PuedeDesglosar, no CentroCostos2:CentroCostos2.EsAcumulativo)

[Acciones.Grupo]
Nombre=Grupo
Boton=0
Menu=&Maestros
NombreDesplegar=G&rupos
EnMenu=S
TipoAccion=Formas
ClaveAccion=ListaGrupo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Rama, <T>CC<T>)<BR>Asigna(Info.Descripcion, <T>Centros de Costos<T>)

[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

[Acciones.Otros2]
Nombre=Otros2
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

[Acciones.Otros3]
Nombre=Otros3
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

[Acciones.Otros4]
Nombre=Otros4
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

[Acciones.Otros5]
Nombre=Otros5
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

[Acciones.Otros6]
Nombre=Otros6
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

[Acciones.Otros7]
Nombre=Otros7
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

[Acciones.Otros8]
Nombre=Otros8
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

[Acciones.Otros9]
Nombre=Otros9
Menu=&Otros
EnMenu=S
TipoAccion=Expresion
Boton=0

[Grupos.CentroCostos2.NivelAcceso]
Carpeta=Grupos
Clave=CentroCostos2.NivelAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CentroCostos2.Grupo]
Carpeta=Detalle
Clave=CentroCostos2.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CentroCostos2.SubGrupo]
Carpeta=Detalle
Clave=CentroCostos2.SubGrupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CentroCostos2.NivelAcceso]
Carpeta=Detalle
Clave=CentroCostos2.NivelAcceso
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Detalle.CentroCostos2.SubSubGrupo]
Carpeta=Detalle
Clave=CentroCostos2.SubSubGrupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Empresas]
Nombre=Empresas
Boton=0
Menu=&Edición
NombreDesplegar=&Empresas Válidas
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CentroCostos2Empresa
Activo=S
ConCondicion=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
EjecucionCondicion=ConDatos(CentroCostos2:CentroCostos2.CentroCostos2)
AntesExpresiones=Asigna(Info.CentroCostos2, CentroCostos2:CentroCostos2.CentroCostos2)
VisibleCondicion=Config.CentroCostosValidar

[Acciones.Sucursales]
Nombre=Sucursales
Boton=0
Menu=&Edición
NombreDesplegar=&Sucursales Válidas
EnMenu=S
TipoAccion=Formas
ClaveAccion=CentroCostos2Sucursal
Activo=S
ConCondicion=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+S
EjecucionCondicion=ConDatos(CentroCostos2:CentroCostos2.CentroCostos2)
AntesExpresiones=Asigna(Info.CentroCostos2, CentroCostos2:CentroCostos2.CentroCostos2)
VisibleCondicion=Config.CentroCostosValidar

[Acciones.Usuarios]
Nombre=Usuarios
Boton=0
Menu=&Edición
NombreDesplegar=&Usuarios Válidos
EnMenu=S
TipoAccion=Formas
ClaveAccion=CentroCostos2Usuario
Activo=S
ConCondicion=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+U
EjecucionCondicion=ConDatos(CentroCostos2:CentroCostos2.CentroCostos2)
AntesExpresiones=Asigna(Info.CentroCostos2, CentroCostos2:CentroCostos2.CentroCostos2)
VisibleCondicion=Config.CentroCostosValidar

[Detalle.CentroCostos2.Estatus]
Carpeta=Detalle
Clave=CentroCostos2.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CentroCostos2.SubSubSubGrupo]
Carpeta=Detalle
Clave=CentroCostos2.SubSubSubGrupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro




[Lista.ListaEnCaptura]
(Inicio)=CentroCostos2.CentroCostos2
CentroCostos2.CentroCostos2=CentroCostos2.Descripcion
CentroCostos2.Descripcion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=CentroCostos2.CentroCostos2
CentroCostos2.CentroCostos2=CentroCostos2.Descripcion
CentroCostos2.Descripcion=CentroCostos2.Estatus
CentroCostos2.Estatus=CentroCostos2.NivelAcceso
CentroCostos2.NivelAcceso=CentroCostos2.Grupo
CentroCostos2.Grupo=CentroCostos2.SubGrupo
CentroCostos2.SubGrupo=CentroCostos2.SubSubGrupo
CentroCostos2.SubSubGrupo=CentroCostos2.SubSubSubGrupo
CentroCostos2.SubSubSubGrupo=(Fin)






















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Presupuesto
Presupuesto=Empresas
Empresas=Sucursales
Sucursales=Usuarios
Usuarios=Explorar
Explorar=Navegador
Navegador=Actualizar
Actualizar=Cerrar
Cerrar=Grupo
Grupo=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=&Otros
&Otros=(Fin)
