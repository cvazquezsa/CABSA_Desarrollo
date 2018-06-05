[Forma]
Clave=CentroCostos
Nombre=Centros de Costos
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
PosicionInicialArriba=147
PosicionInicialAltura=540
PosicionInicialAncho=635
PosicionSeccion1=79
Menus=S
PosicionInicialAlturaCliente=522
PosicionSec1=346

MenuPrincipal=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CentroCostos
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroArbolClave=CentroCostos.CentroCostos
FiltroArbolValidar=CentroCostos.Descripcion
FiltroArbolRama=CentroCostos.Rama
FiltroArbolAcumulativas=CentroCostos.EsAcumulativo
FiltroAncho=30
FiltroTodoNombre=Todos
FiltroNullNombre=(sin agrupar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
HojaMantenerSeleccion=S
FiltroTodo=S
FiltroGrupo1=CentroCostos.Grupo
FiltroValida1=CentroCostos.Grupo
FiltroGrupo2=CentroCostos.SubGrupo
FiltroValida2=CentroCostos.SubGrupo
FiltroNull=S
FiltroGrupo3=CentroCostos.SubSubGrupo
FiltroValida3=CentroCostos.SubSubGrupo
BusquedaRapidaControles=S
FiltroGeneral=CentroCostos.EsAcumulativo=0
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
CentroCostos=125
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
Fecha=148
Usuario=82
Nombre=304
Sucursal=64
Nombre_1=154
Empresa=69

Periodo=42
PeriodoNombre=89
Presupuesto=123
[Lista.CentroCostos.CentroCostos]
Carpeta=Lista
Clave=CentroCostos.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CentroCostos.Descripcion]
Carpeta=Lista
Clave=CentroCostos.Descripcion
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
Vista=CentroCostos
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

[Detalle.CentroCostos.CentroCostos]
Carpeta=Detalle
Clave=CentroCostos.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CentroCostos.Descripcion]
Carpeta=Detalle
Clave=CentroCostos.Descripcion
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

[Grupos.CentroCostos.Grupo]
Carpeta=Grupos
Clave=CentroCostos.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Grupos.CentroCostos.SubGrupo]
Carpeta=Grupos
Clave=CentroCostos.SubGrupo
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
AntesExpresiones=Asigna(Def.Rama, CentroCostos:CentroCostos.Rama)<BR>Si(Vacio(Def.Rama), Asigna(Def.Rama, FiltroActual))

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
ActivoCondicion=no CentroCostos:CentroCostos.TieneMovimientos

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

Expresion=Asigna(Info.Rama, <T>CC<T>)<BR>Asigna(Info.Cuenta, CentroCostos:CentroCostos.CentroCostos)<BR>Asigna(Info.Descripcion, CentroCostos:CentroCostos.Descripcion) <BR>Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Info.Acumulativa, CentroCostos:CentroCostos.EsAcumulativo)<BR>Asigna(Info.VerAcum, CentroCostos:CentroCostos.EsAcumulativo)<BR>Asigna(Info.SubCuenta, Nulo)<BR>Asigna(Info.Tipo, Nulo)<BR>Asigna(Info.VerAcum, CentroCostos:CentroCostos.EsAcumulativo)<BR>Si(General.TiposPresupuesto, Forma(<T>PresupuestoTipoLista<T>), Si(Info.VerAcum, Forma(<T>PresupuestoAcum<T>), Forma(<T>Presupuesto<T>)))
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
EjecucionCondicion=ConDatos(CentroCostos:CentroCostos.CentroCostos)
AntesExpresiones=IrDireccion(<T>CC<T>, CentroCostos:CentroCostos.CentroCostos)<BR>Asigna(Info.PuedeDesglosar, no CentroCostos:CentroCostos.EsAcumulativo)

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
Boton=0

[Grupos.CentroCostos.NivelAcceso]
Carpeta=Grupos
Clave=CentroCostos.NivelAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CentroCostos.Grupo]
Carpeta=Detalle
Clave=CentroCostos.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CentroCostos.SubGrupo]
Carpeta=Detalle
Clave=CentroCostos.SubGrupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CentroCostos.NivelAcceso]
Carpeta=Detalle
Clave=CentroCostos.NivelAcceso
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Detalle.CentroCostos.SubSubGrupo]
Carpeta=Detalle
Clave=CentroCostos.SubSubGrupo
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
ClaveAccion=CentroCostosEmpresa
Activo=S
ConCondicion=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
EjecucionCondicion=ConDatos(CentroCostos:CentroCostos.CentroCostos)
AntesExpresiones=Asigna(Info.CentroCostos, CentroCostos:CentroCostos.CentroCostos)
VisibleCondicion=Config.CentroCostosValidar

[Acciones.Sucursales]
Nombre=Sucursales
Boton=0
Menu=&Edición
NombreDesplegar=&Sucursales Válidas
EnMenu=S
TipoAccion=Formas
ClaveAccion=CentroCostosSucursal
Activo=S
ConCondicion=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+S
EjecucionCondicion=ConDatos(CentroCostos:CentroCostos.CentroCostos)
AntesExpresiones=Asigna(Info.CentroCostos, CentroCostos:CentroCostos.CentroCostos)
VisibleCondicion=Config.CentroCostosValidar

[Acciones.Usuarios]
Nombre=Usuarios
Boton=0
Menu=&Edición
NombreDesplegar=&Usuarios Válidos
EnMenu=S
TipoAccion=Formas
ClaveAccion=CentroCostosUsuario
Activo=S
ConCondicion=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+U
EjecucionCondicion=ConDatos(CentroCostos:CentroCostos.CentroCostos)
AntesExpresiones=Asigna(Info.CentroCostos, CentroCostos:CentroCostos.CentroCostos)
VisibleCondicion=Config.CentroCostosValidar

[Detalle.CentroCostos.Estatus]
Carpeta=Detalle
Clave=CentroCostos.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CentroCostos.SubSubSubGrupo]
Carpeta=Detalle
Clave=CentroCostos.SubSubSubGrupo
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
Expresion=Asigna(Info.Tabla, <T>CentroCostos<T>)<BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(<T>Lista<T>, <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>RegHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CentroCostos:CentroCostos.CentroCostos)
Antes=S
AntesExpresiones=Asigna(Info.Nombre, CentroCostos:CentroCostos.CentroCostos & <T> <T> & CentroCostos:CentroCostos.Descripcion)
Visible=S

[Detalle.Columnas]
CampoNombre=311
Valor=303
ValorAnterior=285




[Lista.ListaEnCaptura]
(Inicio)=CentroCostos.CentroCostos
CentroCostos.CentroCostos=CentroCostos.Descripcion
CentroCostos.Descripcion=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=CentroCostos.CentroCostos
CentroCostos.CentroCostos=CentroCostos.Descripcion
CentroCostos.Descripcion=CentroCostos.Estatus
CentroCostos.Estatus=CentroCostos.NivelAcceso
CentroCostos.NivelAcceso=CentroCostos.Grupo
CentroCostos.Grupo=CentroCostos.SubGrupo
CentroCostos.SubGrupo=CentroCostos.SubSubGrupo
CentroCostos.SubSubGrupo=CentroCostos.SubSubSubGrupo
CentroCostos.SubSubSubGrupo=(Fin)



































































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
Grupo=Historico
Historico=Otros1
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
