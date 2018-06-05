[Forma]
Clave=Espacio
Nombre=Espacios
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=499
PosicionInicialArriba=78
PosicionInicialAlturaCliente=551
PosicionInicialAncho=486
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Menus=S
ListaAcciones=(Lista)
DialogoAbrir=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
MovModulo=ESP
BarraAyuda=S
BarraAyudaBold=S
PosicionSec1=238

MenuPrincipal=(Lista)
[Lista.Columnas]
Espacio=64
Nombre=304
Fecha=148
Usuario=82
Sucursal=64
Nombre_1=154
Empresa=69

[Ficha]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Espacio
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
PermiteEditar=S
Pestana=S

[Ficha.Espacio.Espacio]
Carpeta=Ficha
Clave=Espacio.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Efectos=[Negritas]

[Ficha.Espacio.Nombre]
Carpeta=Ficha
Clave=Espacio.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Ficha.Espacio.Tipo]
Carpeta=Ficha
Clave=Espacio.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Espacio.Estatus]
Carpeta=Ficha
Clave=Espacio.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Espacio.Alta]
Carpeta=Ficha
Clave=Espacio.Alta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[Ficha.Espacio.Baja]
Carpeta=Ficha
Clave=Espacio.Baja
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[Ficha.Espacio.UltimoMantenimiento]
Carpeta=Ficha
Clave=Espacio.UltimoMantenimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[Ficha.Espacio.Observaciones]
Carpeta=Ficha
Clave=Espacio.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=EspacioA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Espacio<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Espacio.Nombre
CarpetaVisible=S
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
PestanaOtroNombre=S
PestanaNombre=Espacios
MenuLocal=S
ListaAcciones=(Lista)
FiltroSituacion=S
FiltroSituacionTodo=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=EspacioTipo
FiltroAplicaEn1=Espacio.Tipo
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por grupos)

IconosConPaginas=S
IconosNombre=EspacioA:Espacio.Espacio
[(Carpeta Abrir).Espacio.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Espacio.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[(Carpeta Abrir).Columnas]
0=109
1=312

[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=Guardar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
ActivoCondicion=no Espacio:Espacio.TieneMovimientos
Visible=S

[Ficha.Espacio.NivelAcceso]
Carpeta=Ficha
Clave=Espacio.NivelAcceso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S
EnBarraHerramientas=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Excel]
Nombre=Excel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.EspacioTipo]
Nombre=EspacioTipo
Boton=0
Menu=&Maestros
NombreDesplegar=Tipos
EnMenu=S
TipoAccion=Formas
ClaveAccion=EspacioTipo
Activo=S
Visible=S

[Auto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Autotransportes
Clave=Auto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Espacio
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
CondicionVisible=General.Autotransportes

[Auto.Espacio.Espacio]
Carpeta=Auto
Clave=Espacio.Espacio
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Auto.Espacio.Nombre]
Carpeta=Auto
Clave=Espacio.Nombre
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Auto.Espacio.Servicio]
Carpeta=Auto
Clave=Espacio.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Auto.Espacio.Rol]
Carpeta=Auto
Clave=Espacio.Rol
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.Espacio.Marca]
Carpeta=Auto
Clave=Espacio.Marca
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.Espacio.Modelo]
Carpeta=Auto
Clave=Espacio.Modelo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.Espacio.Placas]
Carpeta=Auto
Clave=Espacio.Placas
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.Espacio.Legal]
Carpeta=Auto
Clave=Espacio.Legal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.Espacio.Motor]
Carpeta=Auto
Clave=Espacio.Motor
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.Espacio.Chasis]
Carpeta=Auto
Clave=Espacio.Chasis
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Auto.Espacio.TarjetaCirculacion]
Carpeta=Auto
Clave=Espacio.TarjetaCirculacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.Espacio.TarjetaCasetas]
Carpeta=Auto
Clave=Espacio.TarjetaCasetas
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Auto.Espacio.Empresa]
Carpeta=Auto
Clave=Espacio.Empresa
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.Espacio.UltimoMantenimientoKms]
Carpeta=Auto
Clave=Espacio.UltimoMantenimientoKms
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros Datos
Clave=OtrosDatos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Espacio
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[OtrosDatos.Espacio.Descripcion1]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion2]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion3]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion4]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion5]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion6]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion7]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion8]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion8
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion9]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion9
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion10]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion10
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Espacio.Espacio]
Carpeta=OtrosDatos
Clave=Espacio.Espacio
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=19
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[OtrosDatos.Espacio.Nombre]
Carpeta=OtrosDatos
Clave=Espacio.Nombre
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Situacion]
Nombre=Situacion
Boton=71
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12
NombreDesplegar=&Situación
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Visible=S

ActivoCondicion=Usuario.ModificarSituacion
[Acciones.EspacioFecha]
Nombre=EspacioFecha
Boton=9
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Fechas Válidas
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EspacioFecha
Activo=S
Visible=S
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+F
GuardarAntes=S
ConCondicion=S
Antes=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(Espacio:Espacio.Espacio)
AntesExpresiones=Asigna(Info.Espacio, Espacio:Espacio.Espacio)

[Acciones.Plan]
Nombre=Plan
Boton=88
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+P
NombreDesplegar=&Plan
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=CalendarioReservaciones(<T><T>, Espacio:Espacio.Espacio)

[Acciones.Info]
Nombre=Info
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EspacioInfo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Espacio:Espacio.Espacio)
Antes=S
AntesExpresiones=Asigna(Info.Espacio, Espacio:Espacio.Espacio)
Visible=S

[Auto.Espacio.Mantenimiento]
Carpeta=Auto
Clave=Espacio.Mantenimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.Espacio.KmsAnteriores]
Carpeta=Auto
Clave=Espacio.KmsAnteriores
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[Auto.Espacio.KmsActuales]
Carpeta=Auto
Clave=Espacio.KmsActuales
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Auto.Espacio.Antiguedad]
Carpeta=Auto
Clave=Espacio.Antiguedad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Auto.TiempoTranscurrido]
Carpeta=Auto
Clave=TiempoTranscurrido
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Mantenimientos]
Nombre=Mantenimientos
Boton=0
Menu=&Edición
NombreDesplegar=&Mantenimientos Preventivos
EnMenu=S
TipoAccion=Formas
ClaveAccion=EspacioMant
UsaTeclaRapida=S
TeclaRapida=Ctrl+M
EspacioPrevio=S
ActivoCondicion=General.Autotransportes
Antes=S
AntesExpresiones=Asigna(Info.Espacio, Espacio:Espacio.Espacio)<BR>Asigna(Info.Mantenimiento, Espacio:Espacio.Mantenimiento)
VisibleCondicion=General.Autotransportes

[Auto.Espacio.NumeroEconomico]
Carpeta=Auto
Clave=Espacio.NumeroEconomico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Auto.Espacio.Almacen]
Carpeta=Auto
Clave=Espacio.Almacen
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Auto.Espacio.AlmacenAlterno]
Carpeta=Auto
Clave=Espacio.AlmacenAlterno
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Propietarios]
Nombre=Propietarios
Boton=47
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Propietarios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EspacioPropietario
ConCondicion=S
Antes=S
ActivoCondicion=General.Autotransportes
EjecucionCondicion=ConDatos(Espacio:Espacio.Espacio)
AntesExpresiones=Asigna(Info.Espacio, Espacio:Espacio.Espacio)
VisibleCondicion=General.Autotransportes

[Auto.Espacio.SaldoAFavor]
Carpeta=Auto
Clave=Espacio.SaldoAFavor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.EspacioAF]
Nombre=EspacioAF
Boton=16
Menu=&Ver
NombreDesplegar=Activos Fijos Asignados
EnMenu=S
TipoAccion=Formas
ClaveAccion=EspacioAF
Activo=S
ConCondicion=S
Antes=S
Visible=S
EnBarraHerramientas=S
EjecucionCondicion=ConDatos(Espacio:Espacio.Espacio)
AntesExpresiones=Asigna(Info.Espacio, Espacio:Espacio.Espacio)<BR>Asigna(Info.Nombre, Espacio:Espacio.Nombre)

[FormaExtraValor]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Características
Clave=FormaExtraValor
Filtros=S
OtroOrden=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaExtraValor
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaSinBorde=S
HojaFondoGris=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteEditar=S
FiltroGeneral=FormaExtraValor.Aplica=<T>Espacios<T> AND FormaExtraValor.AplicaClave=<T>{Espacio:Espacio.Espacio}<T>
CondicionVisible=General.CamposExtras<><T>Campos Extras<T>

[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[FormaExtraValor.VerValor]
Carpeta=FormaExtraValor
Clave=VerValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[FormaExtraValor.Columnas]
VerCampo=218
VerValor=209

[Acciones.CamposExtras]
Nombre=CamposExtras
Boton=104
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+1
NombreDesplegar=General.CamposExtras+<T>...<T>
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
ConCondicion=S
Visible=S
Expresion=Asigna(Info.Aplica, <T>Espacios<T>)<BR>  Asigna(Info.Clave, Espacio:Espacio.Espacio)<BR>  Asigna(Info.Nombre, Espacio:Espacio.Nombre)<BR>  Asigna(Info.Modulo, Nulo)<BR>  Asigna(Info.Mov, Nulo)<BR>  Asigna(Info.Categoria, Nulo)<BR>  Asigna(Info.Grupo, Nulo)<BR>  Asigna(Info.Familia, Nulo)<BR>  Asigna(Info.Departamento, Nulo)<BR>  Asigna(Info.Puesto, Nulo)<BR>  Asigna(Info.SIC, Nulo)<BR><BR>  Asigna(Temp.Reg, SQL(<T>spFormaExtraVisible :tAplica, :tModulo, :tMov, :tCat, :tGrupo, :tFam, :tDepto, :tPuesto, :tSIC<T>, Info.Aplica, Info.Modulo, Info.Mov, Info.Categoria, Info.Grupo, Info.Familia, Info.Departamento, Info.Puesto, Info.SIC))<BR>  Si(Temp.Reg[1]>1, Si(no Forma(<T>EspecificarFormaTipo<T>), AbortarOperacion), Asigna(Info.FormaTipo, Temp.Reg[2]))<BR>  Si(ConDatos(Info.FormaTipo), iForma(Info.FormaTipo, Info.Aplica, Info.Clave, Info.Nombre), Informacion(<T>No Tiene Definida Ninguna Forma<T>))
ActivoCondicion=General.CamposExtras<><T>Campos Extras<T>
EjecucionCondicion=ConDatos(Espacio:Espacio.Espacio)

[Ficha.Espacio.Metros]
Carpeta=Ficha
Clave=Espacio.Metros
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Historico]
Nombre=Historico
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+H
NombreDesplegar=Histórico de Cambios
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Tabla, <T>Espacio<T>)<BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(<T>Ficha<T>, <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>RegHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Espacio:Espacio.Espacio)
Antes=S
AntesExpresiones=Asigna(Info.Nombre, Espacio:Espacio.Espacio & <T> <T> & Espacio:Espacio.Nombre)
Visible=S

[Detalle.Columnas]
CampoNombre=311
Valor=303
ValorAnterior=285







[Auto.ListaEnCaptura]
(Inicio)=Espacio.Espacio
Espacio.Espacio=Espacio.Nombre
Espacio.Nombre=Espacio.NumeroEconomico
Espacio.NumeroEconomico=Espacio.Empresa
Espacio.Empresa=Espacio.Almacen
Espacio.Almacen=Espacio.AlmacenAlterno
Espacio.AlmacenAlterno=Espacio.Servicio
Espacio.Servicio=Espacio.Rol
Espacio.Rol=Espacio.Marca
Espacio.Marca=Espacio.Modelo
Espacio.Modelo=Espacio.Placas
Espacio.Placas=Espacio.Motor
Espacio.Motor=Espacio.Chasis
Espacio.Chasis=Espacio.Legal
Espacio.Legal=Espacio.TarjetaCirculacion
Espacio.TarjetaCirculacion=Espacio.TarjetaCasetas
Espacio.TarjetaCasetas=Espacio.UltimoMantenimientoKms
Espacio.UltimoMantenimientoKms=Espacio.SaldoAFavor
Espacio.SaldoAFavor=Espacio.KmsAnteriores
Espacio.KmsAnteriores=Espacio.KmsActuales
Espacio.KmsActuales=Espacio.Antiguedad
Espacio.Antiguedad=TiempoTranscurrido
TiempoTranscurrido=Espacio.Mantenimiento
Espacio.Mantenimiento=(Fin)

[OtrosDatos.ListaEnCaptura]
(Inicio)=Espacio.Espacio
Espacio.Espacio=Espacio.Nombre
Espacio.Nombre=Espacio.Descripcion1
Espacio.Descripcion1=Espacio.Descripcion2
Espacio.Descripcion2=Espacio.Descripcion3
Espacio.Descripcion3=Espacio.Descripcion4
Espacio.Descripcion4=Espacio.Descripcion5
Espacio.Descripcion5=Espacio.Descripcion6
Espacio.Descripcion6=Espacio.Descripcion7
Espacio.Descripcion7=Espacio.Descripcion8
Espacio.Descripcion8=Espacio.Descripcion9
Espacio.Descripcion9=Espacio.Descripcion10
Espacio.Descripcion10=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)







[SituacionCta]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Situaciones por Area
Clave=SituacionCta
Filtros=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=SituacionCta
Fuente={Tahoma, 8, Negro, []}
IconosCampo=CtaSituacion.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosSubTitulo=<T>Area<T>
ListaEnCaptura=(Lista)
IconosNombre=SituacionCta:SituacionCta.Area
FiltroGeneral=SituacionCta.Rama=<T>ESP<T> AND SituacionCta.Cuenta=<T>{Espacio:Espacio.Espacio}<T>
CondicionVisible=General.SituacionesPorArea

[SituacionCta.SituacionCta.Situacion]
Carpeta=SituacionCta
Clave=SituacionCta.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[SituacionCta.SituacionCta.SituacionFecha]
Carpeta=SituacionCta
Clave=SituacionCta.SituacionFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SituacionCta.SituacionCta.SituacionUsuario]
Carpeta=SituacionCta
Clave=SituacionCta.SituacionUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SituacionCta.SituacionCta.SituacionNota]
Carpeta=SituacionCta
Clave=SituacionCta.SituacionNota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[SituacionCta.Columnas]
0=188
1=148
2=-2
3=-2
4=-2

[SituacionCta.ListaEnCaptura]
(Inicio)=SituacionCta.Situacion
SituacionCta.Situacion=SituacionCta.SituacionFecha
SituacionCta.SituacionFecha=SituacionCta.SituacionUsuario
SituacionCta.SituacionUsuario=SituacionCta.SituacionNota
SituacionCta.SituacionNota=(Fin)




[Ficha.ListaEnCaptura]
(Inicio)=Espacio.Espacio
Espacio.Espacio=Espacio.Nombre
Espacio.Nombre=Espacio.Tipo
Espacio.Tipo=Espacio.Metros
Espacio.Metros=Espacio.OcupacionMaxima
Espacio.OcupacionMaxima=Espacio.NivelAcceso
Espacio.NivelAcceso=Espacio.Alta
Espacio.Alta=Espacio.Baja
Espacio.Baja=Espacio.UltimoMantenimiento
Espacio.UltimoMantenimiento=Espacio.Observaciones
Espacio.Observaciones=Espacio.Estatus
Espacio.Estatus=(Fin)

[Ficha.Espacio.OcupacionMaxima]
Carpeta=Ficha
Clave=Espacio.OcupacionMaxima
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




























[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)




[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Auto
Auto=OtrosDatos
OtrosDatos=FormaExtraValor
FormaExtraValor=SituacionCta
SituacionCta=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Situacion
Situacion=Eliminar
Eliminar=CamposExtras
CamposExtras=EspacioFecha
EspacioFecha=Propietarios
Propietarios=Mantenimientos
Mantenimientos=Info
Info=EspacioAF
EspacioAF=Plan
Plan=EspacioTipo
EspacioTipo=Navegador
Navegador=Cerrar
Cerrar=Historico
Historico=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)
