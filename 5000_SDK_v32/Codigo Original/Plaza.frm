[Forma]
Clave=Plaza
Nombre=Plazas
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=315
PosicionInicialArriba=67
PosicionInicialAltura=569
PosicionInicialAncho=735
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=43
PosicionSeccion1=67
BarraAyuda=S
PosicionInicialAlturaCliente=598
PosicionSec1=271
ExpresionesAlMostrar=Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Ult.CtaTipo, Nulo)

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
Vista=Plaza
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
ListaOrden=Plaza.Plaza<TAB>(Acendente)
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
FiltroArbolClave=Plaza.Plaza
FiltroArbolValidar=Plaza.Descripcion
FiltroArbolRama=Plaza.Rama
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
FiltroListasRama=
FiltroListasAplicaEn=
PermiteLocalizar=S
FiltroArbolAcumulativas=Plaza.EsJefe

[Detalle.Cta.Cuenta]
Carpeta=Detalle
Clave=Cta.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
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
ColorFuente=Negro
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
ColorFuente=Negro

[Lista.Columnas]
Cuenta=111
Descripcion=174
Clave=140
Plaza=66
Puesto=90
Personal=68

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

Multiple=S
ListaAccionesMultiples=(Lista)
AntesExpresiones=Asigna(Def.Rama, Plaza:Plaza.Rama)<BR>Si<BR>  Vacio(Def.Rama)<BR>Entonces<BR>  Asigna(Def.Rama, FiltroActual)<BR>Fin
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

Activo=S
ConCondicion=S
EjecucionCondicion=no Plaza:Personal.TieneMovimientos
EjecucionMensaje=<T>Tiene Movimientos, No se puede Eliminar<T>
EjecucionConError=S
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
ColorFuente=Negro

[Detalle.Cta.EsAcreedora]
Carpeta=Detalle
Clave=Cta.EsAcreedora
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

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

[Detalle.Cta.Tipo]
Carpeta=Detalle
Clave=Cta.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=15
Efectos=[Negritas]
ColorFondo=Blanco
ColorFuente=Negro

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
EjecucionCondicion=ConDatos(Plaza:Plaza.Plaza)
AntesExpresiones=Asigna(Info.Rama, <T>PLAZA<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, Plaza:Plaza.Plaza)<BR>Asigna(Info.Descripcion, Plaza:Plaza.Descripcion)
RefrescarDespues=S

[Acciones.Doc]
Nombre=Doc
Boton=17
Menu=&Edición
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=EditarDocumentacion(<T>PLAZA<T>, Plaza:Plaza.Plaza, <T>Documentación - <T>+Plaza:Plaza.Descripcion)
EjecucionCondicion=ConDatos(Plaza:Plaza.Plaza)

[Detalle.Cta.Estatus]
Carpeta=Detalle
Clave=Cta.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

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
ColorFuente=Negro

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
ColorFuente=Negro

[Lista.Plaza.Plaza]
Carpeta=Lista
Clave=Plaza.Plaza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Plaza.Descripcion]
Carpeta=Lista
Clave=Plaza.Descripcion
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
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=Plaza
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales

[Detalle.Plaza.Plaza]
Carpeta=Detalle
Clave=Plaza.Plaza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Plaza.Descripcion]
Carpeta=Detalle
Clave=Plaza.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Plaza.Rama]
Carpeta=Detalle
Clave=Plaza.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Plaza.Tipo]
Carpeta=Detalle
Clave=Plaza.Tipo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Lista.Plaza.Puesto]
Carpeta=Lista
Clave=Plaza.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.PlazaLista.Descripcion]
Carpeta=Detalle
Clave=PlazaLista.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Plaza.EsJefe]
Carpeta=Detalle
Clave=Plaza.EsJefe
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Detalle.Plaza.Estatus]
Carpeta=Detalle
Clave=Plaza.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Puesto]
Nombre=Puesto
Boton=0
Menu=&Maestros
NombreDesplegar=&Puestos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Puesto
Activo=S
Visible=S

[Acciones.Departamento]
Nombre=Departamento
Boton=0
Menu=&Maestros
NombreDesplegar=&Departamentos
EnMenu=S
TipoAccion=Formas
ClaveAccion=Departamento
Activo=S
Visible=S

[Detalle.NombreCompleto]
Carpeta=Detalle
Clave=NombreCompleto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Plaza.Personal]
Carpeta=Detalle
Clave=Plaza.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.PersonalEstatus]
Carpeta=Detalle
Clave=PersonalEstatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Plaza.Empresa]
Carpeta=Detalle
Clave=Plaza.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Plaza.Sucursal]
Carpeta=Detalle
Clave=Plaza.Sucursal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=9

[Detalle.Sucursal.Nombre]
Carpeta=Detalle
Clave=Sucursal.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.VerPlazas]
Nombre=VerPlazas
Boton=73
Menu=&Ver
NombreDesplegar=Presupuesto de Plazas
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VerPlazas
Activo=S
Visible=S

[Detalle.Plaza.VigenciaD]
Carpeta=Detalle
Clave=Plaza.VigenciaD
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Plaza.VigenciaA]
Carpeta=Detalle
Clave=Plaza.VigenciaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Plaza.APartirDe]
Carpeta=Detalle
Clave=Plaza.APartirDe
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Plaza.Personal]
Carpeta=Lista
Clave=Plaza.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Opciones]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Información Adicional
Clave=Opciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=Plaza
Fuente={Tahoma, 8, Negro, []}
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

[Opciones.Plaza.UEN]
Carpeta=Opciones
Clave=Plaza.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Opciones.UEN.Nombre]
Carpeta=Opciones
Clave=UEN.Nombre
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Opciones.Plaza.Departamento]
Carpeta=Opciones
Clave=Plaza.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Plaza.Puesto]
Carpeta=Opciones
Clave=Plaza.Puesto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Plaza.Sueldo]
Carpeta=Opciones
Clave=Plaza.Sueldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Opciones.Plaza.CentroCostos]
Carpeta=Opciones
Clave=Plaza.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.CentroCostos.Descripcion]
Carpeta=Opciones
Clave=CentroCostos.Descripcion
Editar=N
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Opciones.Plaza.Area]
Carpeta=Opciones
Clave=Plaza.Area
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Area]
Nombre=Area
Boton=0
Menu=&Maestros
NombreDesplegar=&Areas
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=Area
Activo=S
Visible=S




[Lista.ListaEnCaptura]
(Inicio)=Plaza.Plaza
Plaza.Plaza=Plaza.Descripcion
Plaza.Descripcion=Plaza.Puesto
Plaza.Puesto=Plaza.Personal
Plaza.Personal=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=Plaza.Plaza
Plaza.Plaza=Plaza.Descripcion
Plaza.Descripcion=Plaza.Estatus
Plaza.Estatus=Plaza.Rama
Plaza.Rama=PlazaLista.Descripcion
PlazaLista.Descripcion=Plaza.EsJefe
Plaza.EsJefe=Plaza.Tipo
Plaza.Tipo=Plaza.VigenciaD
Plaza.VigenciaD=Plaza.VigenciaA
Plaza.VigenciaA=Plaza.APartirDe
Plaza.APartirDe=Plaza.Empresa
Plaza.Empresa=Plaza.Sucursal
Plaza.Sucursal=Sucursal.Nombre
Sucursal.Nombre=Plaza.Personal
Plaza.Personal=NombreCompleto
NombreCompleto=PersonalEstatus
PersonalEstatus=(Fin)

[Opciones.ListaEnCaptura]
(Inicio)=Plaza.Departamento
Plaza.Departamento=Plaza.Puesto
Plaza.Puesto=Plaza.Area
Plaza.Area=Plaza.UEN
Plaza.UEN=UEN.Nombre
UEN.Nombre=Plaza.CentroCostos
Plaza.CentroCostos=CentroCostos.Descripcion
CentroCostos.Descripcion=Plaza.Sueldo
Plaza.Sueldo=(Fin)




[Acciones.Nueva.Agregar]
Nombre=Agregar
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Nueva.Estatus]
Nombre=Estatus
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S









Expresion=Si(Config.RHAutorizarPlazas, Asigna(Plaza:Plaza.Estatus, <T>AUTORIZARE<T>))




[Acciones.Nueva.ListaAccionesMultiples]
(Inicio)=Agregar
Agregar=Estatus
Estatus=(Fin)





































[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=Opciones
Opciones=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Nueva
Nueva=Eliminar
Eliminar=Anexos
Anexos=Doc
Doc=VerPlazas
VerPlazas=Navegador
Navegador=Actualizar
Actualizar=Cerrar
Cerrar=Puesto
Puesto=Departamento
Departamento=Area
Area=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)
