[Forma]
Clave=VIN
Nombre=VINs
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=250
PosicionInicialArriba=151
PosicionInicialAltura=471
PosicionInicialAncho=940
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Menus=S
VentanaBloquearAjuste=N
DialogoAbrir=S
PosicionInicialAlturaCliente=564
ExpresionesAlMostrar=Asigna(Info.Articulo, Nulo)
ExpresionesAlCerrar=Asigna(Filtro.Articulo, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)
MovModulo=AUTO
BarraAyuda=S
BarraAyudaBold=S
PosicionSec1=238

MenuPrincipal=(Lista)
[Lista.VIN.VIN]
Carpeta=Lista
Clave=VIN.VIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VIN.Articulo]
Carpeta=Lista
Clave=VIN.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
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
PestanaNombre=Datos Generales
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
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
CondicionEdicion=no VIN:VIN.TieneMovimientos

[Detalle.VIN.VIN]
Carpeta=Detalle
Clave=VIN.VIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.VIN.Articulo]
Carpeta=Detalle
Clave=VIN.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S
Efectos=[Negritas]

[Detalle.Art.Descripcion1]
Carpeta=Detalle
Clave=Art.Descripcion1
Editar=S
3D=S
Tamano=44
ColorFondo=Plata
ColorFuente=Negro

[Detalle.VIN.Motor]
Carpeta=Detalle
Clave=VIN.Motor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EditarConBloqueo=S

[Detalle.VIN.Llave]
Carpeta=Detalle
Clave=VIN.Llave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EditarConBloqueo=S

[Detalle.VIN.Aduana]
Carpeta=Detalle
Clave=VIN.Aduana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S
EditarConBloqueo=S

[Detalle.VIN.Pedimento]
Carpeta=Detalle
Clave=VIN.Pedimento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EditarConBloqueo=S

[Detalle.VIN.ClaveVehicular]
Carpeta=Detalle
Clave=VIN.ClaveVehicular
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EditarConBloqueo=S

[Detalle.VIN.Cliente]
Carpeta=Detalle
Clave=VIN.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EspacioPrevio=N
EditarConBloqueo=S

[Detalle.Cte.Nombre]
Carpeta=Detalle
Clave=Cte.Nombre
Editar=S
ValidaNombre=N
Tamano=44
ColorFondo=Plata
ColorFuente=Negro
3D=S

[Lista.Columnas]
VIN=152
Articulo=131
Descripcion1=244
Cliente_1=64
Cliente=70
0=111
1=144
Fecha=148
Usuario=82
Nombre=304
Sucursal=64
Nombre_1=154
Empresa=69

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N

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

[Lista.VIN.Cliente]
Carpeta=Lista
Clave=VIN.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
EspacioPrevio=S
ActivoCondicion=no VIN:VIN.TieneMovimientos

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S

[Acciones.Informacion]
Nombre=Informacion
Boton=34
Menu=&Ver
NombreDesplegar=Información
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
Activo=S
Visible=S
ClaveAccion=SerieLoteInfo
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(VIN:VIN.VIN) y ConDatos(VIN:VIN.Articulo)
AntesExpresiones=Asigna(Info.SerieLote, VIN:VIN.VIN)<BR>Asigna(Info.Articulo, VIN:VIN.Articulo)<BR>Asigna(Info.SubCuenta, <T><T>)<BR>Asigna(Info.ArtTipo, TipoVIN)

[Acciones.Anexo]
Nombre=Anexo
Boton=77
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=ConDatos(VIN:VIN.VIN)
AntesExpresiones=Asigna(Info.Rama, <T>VIN<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, VIN:VIN.VIN)<BR>Asigna(Info.Descripcion, VIN:Art.Descripcion1+<T> (<T>+VIN:VIN.Articulo+<T>)<T>)

[Acciones.Doc]
Nombre=Doc
Boton=17
Menu=&Edición
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EditarDocumentacion(<T>VIN<T>, VIN:VIN.VIN, <T>Documentación - <T>+VIN:VIN.VIN)
ConCondicion=S
EjecucionCondicion=ConDatos(VIN:VIN.VIN)

[Codigos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Códigos
Clave=Codigos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
Fuente={MS Sans Serif, 8, Negro, []}
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

[Codigos.VIN.VIN]
Carpeta=Codigos
Clave=VIN.VIN
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Codigos.VIN.CodigoRadio]
Carpeta=Codigos
Clave=VIN.CodigoRadio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Codigos.VIN.CodigoTransmision]
Carpeta=Codigos
Clave=VIN.CodigoTransmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Codigos.VIN.CodigoColor]
Carpeta=Codigos
Clave=VIN.CodigoColor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Codigos.VIN.CodigoLlanta1]
Carpeta=Codigos
Clave=VIN.CodigoLlanta1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Codigos.VIN.CodigoLlanta2]
Carpeta=Codigos
Clave=VIN.CodigoLlanta2
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Codigos.VIN.CodigoLlanta3]
Carpeta=Codigos
Clave=VIN.CodigoLlanta3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Codigos.VIN.CodigoLlanta4]
Carpeta=Codigos
Clave=VIN.CodigoLlanta4
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Codigos.VIN.CodigoLlanta5]
Carpeta=Codigos
Clave=VIN.CodigoLlanta5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.Placas]
Carpeta=Detalle
Clave=VIN.Placas
Editar=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EditarConBloqueo=S

[Acciones.Aduana]
Nombre=Aduana
Boton=0
Menu=&Maestros
NombreDesplegar=A&duanas
EnMenu=S
TipoAccion=Formas
ClaveAccion=Aduana
Activo=S
Visible=S

[Acciones.Aseguradora]
Nombre=Aseguradora
Boton=0
Menu=&Maestros
NombreDesplegar=A&seguradoras
EnMenu=S
TipoAccion=Formas
ClaveAccion=Aseguradora

[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=VIN<T>s
Clave=(Carpeta Abrir)
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=VINA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=CtaSituacion.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=VIN.Fecha<TAB>(Decendente)
FiltroPredefinido=S
FiltroAutoCampo=VIN.Fecha
FiltroAutoValidar=VIN.Fecha
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=VIN.Fecha
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
IconosSubTitulo=<T>VIN<T>
MenuLocal=S
PermiteLocalizar=S
FiltroTodo=S
FiltroFechas=S
FiltroFechasDefault=Este Mes
BusquedaInicializar=S
ListaAcciones=(Lista)
FiltroEstatus=S
FiltroSituacion=S
FiltroSituacionTodo=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
IconosNombre=VINA:VIN.VIN
FiltroGeneral={Si(ConDatos(Filtro.Articulo), <T>VIN.Articulo=<T>+Comillas(Filtro.Articulo), <T><T>)}
FiltroEmpresas=S

[(Carpeta Abrir).VIN.Articulo]
Carpeta=(Carpeta Abrir)
Clave=VIN.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).VIN.Fecha]
Carpeta=(Carpeta Abrir)
Clave=VIN.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=160
1=92

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

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Actualizar
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=0
NombreDesplegar=&Presentacion preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Detalle.VIN.Registro]
Carpeta=Detalle
Clave=VIN.Registro
Editar=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Detalle.VIN.FechaCartaCredito]
Carpeta=Detalle
Clave=VIN.FechaCartaCredito
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=16
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Detalle.VIN.FechaFactura]
Carpeta=Detalle
Clave=VIN.FechaFactura
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Detalle.VIN.FechaUltimoServicio]
Carpeta=Detalle
Clave=VIN.FechaUltimoServicio
Editar=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Detalle.VIN.Tasa]
Carpeta=Detalle
Clave=VIN.Tasa
Editar=S
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S
Pegado=S

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

[Acciones.Accesorios]
Nombre=Accesorios
Boton=47
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Componentes
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
Antes=S
EspacioPrevio=S
GuardarAntes=S
DespuesGuardar=S
UsaTeclaRapida=S
TeclaRapida=F7
RefrescarDespues=S
Expresion=Asigna(Info.Bloqueado, VIN:VIN.TieneMovimientos)<BR>Si(Si(Config.VINAccesorioArt, Forma(<T>VINAccesorioArt<T>), Forma(<T>VINAccesorio<T>)),  Forma.ActualizarForma)
EjecucionCondicion=ConDatos(VIN:VIN.VIN)
AntesExpresiones=Asigna(Info.VIN, VIN:VIN.VIN)<BR>Asigna(Info.Bloqueado, Falso)

[Detalle.VIN.Km]
Carpeta=Detalle
Clave=VIN.Km
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Cambio]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Unidad a Cambio
Clave=Cambio
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
Fuente={Tahoma, 8, Negro, []}
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

[Cambio.VIN.CambioVIN]
Carpeta=Cambio
Clave=VIN.CambioVIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Cambio.VIN.CambioKm]
Carpeta=Cambio
Clave=VIN.CambioKm
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.Conductor]
Carpeta=Detalle
Clave=VIN.Conductor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EditarConBloqueo=S

[Detalle.CteDestino.Nombre]
Carpeta=Detalle
Clave=CteDestino.Nombre
Editar=S
3D=S
Tamano=44
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Historico]
Nombre=Historico
Boton=53
Menu=&Ver
NombreDesplegar=Histórico del Cambios
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+H
ConCondicion=S
Expresion=Asigna(Info.Tabla, <T>VIN<T>)<BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(<T>Ficha<T>, <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>VINHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
EjecucionCondicion=ConDatos(VIN:VIN.VIN)
AntesExpresiones=Asigna(Info.SerieLote, VIN:VIN.VIN)

[Detalle.VIN.FechaSiguienteServicio]
Carpeta=Detalle
Clave=VIN.FechaSiguienteServicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EditarConBloqueo=S

[Acciones.Venta]
Nombre=Venta
Boton=57
Menu=&Ver
NombreDesplegar=&Venta
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=VTAS
ListaParametros1=VIN:VIN.VentaID
ListaParametros=S
Visible=S
EspacioPrevio=S
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(VIN:VIN.VentaID)

[Acciones.FordOasis]
Nombre=FordOasis
Boton=106
Menu=&Ver
NombreDesplegar=&Oasis
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
ConCondicion=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
Expresion=URL(<T>http://www.fordmexico.com.mx/oasis/index.asp?distribuidora=<T>+General.FordDistribuidor+<T>&mercado=<T>+General.FordMercado+<T>&vin=<T>+VIN:VIN.VIN)
ActivoCondicion=General.Ford
EjecucionCondicion=ConDatos(VIN:VIN.VIN)

[Detalle.VIN.NumeroEconomico]
Carpeta=Detalle
Clave=VIN.NumeroEconomico
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro
Editar=S
EspacioPrevio=N
EditarConBloqueo=S
Efectos=[Negritas]
Pegado=S

[Fechas]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Fechas
Clave=Fechas
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
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
PermiteEditar=S

[Fechas.VIN.VIN]
Carpeta=Fechas
Clave=VIN.VIN
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Fechas.VIN.FechaEntrada]
Carpeta=Fechas
Clave=VIN.FechaEntrada
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Fechas.VIN.FechaSalida]
Carpeta=Fechas
Clave=VIN.FechaSalida
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Fechas.Dias]
Carpeta=Fechas
Clave=Dias
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.CostoPiso]
Nombre=CostoPiso
Boton=64
Menu=&Ver
NombreDesplegar=&Costo Piso
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
Activo=S
Visible=S
ConCondicion=S
Antes=S
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=F7
ClaveAccion=VINCostoPiso
EjecucionCondicion=ConDatos(VIN:VIN.VIN)
AntesExpresiones=Asigna(Info.SerieLote, VIN:VIN.VIN)

[Detalle.VIN.TipoUnidad]
Carpeta=Detalle
Clave=VIN.TipoUnidad
Editar=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S
Efectos=[Negritas]

[Detalle.VIN.Holograma]
Carpeta=Detalle
Clave=VIN.Holograma
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S
EditarConBloqueo=S

[Fechas.VIN.FechaMRS]
Carpeta=Fechas
Clave=VIN.FechaMRS
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.VIN.Modelo]
Carpeta=Detalle
Clave=VIN.Modelo
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[FordDatos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ford (Otros Datos)
Clave=FordDatos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
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
CondicionEdicion=(no VIN:VIN.Interfase) y (no VIN:VIN.TieneMovimientos)
CondicionVisible=General.Ford

[FordDatos.VIN.VIN]
Carpeta=FordDatos
Clave=VIN.VIN
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[FordDatos.VIN.PrecioBasicoDistribuidor]
Carpeta=FordDatos
Clave=VIN.PrecioBasicoDistribuidor
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[FordDatos.VIN.PrecioBasicoPublico]
Carpeta=FordDatos
Clave=VIN.PrecioBasicoPublico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.AjusteBasicoDistribuidor]
Carpeta=FordDatos
Clave=VIN.AjusteBasicoDistribuidor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordDatos.VIN.TotalAccesoriosDistribuidor]
Carpeta=FordDatos
Clave=VIN.TotalAccesoriosDistribuidor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[FordDatos.VIN.TotalAccesoriosPublico]
Carpeta=FordDatos
Clave=VIN.TotalAccesoriosPublico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.TotalDescuentoAccesoriosMemo]
Carpeta=FordDatos
Clave=VIN.TotalDescuentoAccesoriosMemo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordDatos.VIN.TotalDescuentoDistribuidorMemo]
Carpeta=FordDatos
Clave=VIN.TotalDescuentoDistribuidorMemo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.TotalDescuentoPepPublico]
Carpeta=FordDatos
Clave=VIN.TotalDescuentoPepPublico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento1Descripcion]
Carpeta=FordDatos
Clave=VIN.Descuento1Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordDatos.VIN.Descuento1Distribuidor]
Carpeta=FordDatos
Clave=VIN.Descuento1Distribuidor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento1Publico]
Carpeta=FordDatos
Clave=VIN.Descuento1Publico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento2Descripcion]
Carpeta=FordDatos
Clave=VIN.Descuento2Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento2Distribuidor]
Carpeta=FordDatos
Clave=VIN.Descuento2Distribuidor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento2Publico]
Carpeta=FordDatos
Clave=VIN.Descuento2Publico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento3Descripcion]
Carpeta=FordDatos
Clave=VIN.Descuento3Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordDatos.VIN.Descuento3Distribuidor]
Carpeta=FordDatos
Clave=VIN.Descuento3Distribuidor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento3Publico]
Carpeta=FordDatos
Clave=VIN.Descuento3Publico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.SeguroProvincial]
Carpeta=FordDatos
Clave=VIN.SeguroProvincial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[FordDatos.VIN.GastosTraslado]
Carpeta=FordDatos
Clave=VIN.GastosTraslado
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.SeguroAsociacion]
Carpeta=FordDatos
Clave=VIN.SeguroAsociacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Bonificacion15DiasSinIntereses]
Carpeta=FordDatos
Clave=VIN.Bonificacion15DiasSinIntereses
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.ReembolsoTransportacion]
Carpeta=FordDatos
Clave=VIN.ReembolsoTransportacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Bonificacion]
Carpeta=FordDatos
Clave=VIN.Bonificacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordDatos.VIN.BonificacionEnPrecio]
Carpeta=FordDatos
Clave=VIN.BonificacionEnPrecio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.GarantiaServicio]
Carpeta=FordDatos
Clave=VIN.GarantiaServicio
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Miscelaneos]
Carpeta=FordDatos
Clave=VIN.Miscelaneos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.SubTotalFacturaCompra]
Carpeta=FordDatos
Clave=VIN.SubTotalFacturaCompra
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S

[FordDatos.VIN.IVAFacturaCompra]
Carpeta=FordDatos
Clave=VIN.IVAFacturaCompra
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=N

[FordDatos.VIN.CoutaPublicidad]
Carpeta=FordDatos
Clave=VIN.CoutaPublicidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.TotalFacturaCompra]
Carpeta=FordDatos
Clave=VIN.TotalFacturaCompra
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S
Efectos=[Negritas]

[FordDatos.VIN.NivelPrecios]
Carpeta=FordDatos
Clave=VIN.NivelPrecios
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.CoutaFondoCivico]
Carpeta=FordDatos
Clave=VIN.CoutaFondoCivico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[FordDatos.VIN.CoutaFordStar]
Carpeta=FordDatos
Clave=VIN.CoutaFordStar
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ford (Datos Generales)
Clave=FordGenerales
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
PermiteEditar=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CondicionEdicion=no VIN:VIN.Interfase
ListaEnCaptura=(Lista)
CondicionVisible=General.Ford

[FordGenerales.VIN.VIN]
Carpeta=FordGenerales
Clave=VIN.VIN
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[FordGenerales.VIN.Modelo]
Carpeta=FordGenerales
Clave=VIN.Modelo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.ClaveFinanciera]
Carpeta=FordGenerales
Clave=VIN.ClaveFinanciera
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordGenerales.VIN.NumeroOrden]
Carpeta=FordGenerales
Clave=VIN.NumeroOrden
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordGenerales.VIN.TipoCompra]
Carpeta=FordGenerales
Clave=VIN.TipoCompra
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.FolioFacturaCompra]
Carpeta=FordGenerales
Clave=VIN.FolioFacturaCompra
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordGenerales.VIN.FechaFacturaCompra]
Carpeta=FordGenerales
Clave=VIN.FechaFacturaCompra
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.Mercado]
Carpeta=FordGenerales
Clave=VIN.Mercado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.ClaveDistribuidor]
Carpeta=FordGenerales
Clave=VIN.ClaveDistribuidor
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.Descripcion1]
Carpeta=FordGenerales
Clave=VIN.Descripcion1
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[FordGenerales.VIN.Descripcion2]
Carpeta=FordGenerales
Clave=VIN.Descripcion2
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.ColorExterior]
Carpeta=FordGenerales
Clave=VIN.ColorExterior
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[FordGenerales.VIN.ColorExteriorDescripcion]
Carpeta=FordGenerales
Clave=VIN.ColorExteriorDescripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.ColorInterior]
Carpeta=FordGenerales
Clave=VIN.ColorInterior
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordGenerales.VIN.ColorInteriorDescripcion]
Carpeta=FordGenerales
Clave=VIN.ColorInteriorDescripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.ClaveAduana]
Carpeta=FordGenerales
Clave=VIN.ClaveAduana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.PedimentoFecha]
Carpeta=FordGenerales
Clave=VIN.PedimentoFecha
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[FordGenerales.VIN.OtrasOpciones]
Carpeta=FordGenerales
Clave=VIN.OtrasOpciones
Editar=S
ValidaNombre=S
3D=S
Tamano=79
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Fechas.VIN.DiasLibresIntereses]
Carpeta=Fechas
Clave=VIN.DiasLibresIntereses
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro

[Fechas.FechaInicioCostoPiso]
Carpeta=Fechas
Clave=FechaInicioCostoPiso
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Fechas.VIN.UltimoPagoCostoPiso]
Carpeta=Fechas
Clave=VIN.UltimoPagoCostoPiso
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.VIN.GarantiaVencimiento]
Carpeta=Detalle
Clave=VIN.GarantiaVencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Fechas.VIN.IntercambioDirecto]
Carpeta=Fechas
Clave=VIN.IntercambioDirecto
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Detalle.VIN.FechaImportacion]
Carpeta=Detalle
Clave=VIN.FechaImportacion
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
ValidaNombre=S
EditarConBloqueo=S

[Acciones.Situacion]
Nombre=Situacion
Boton=71
Menu=&Archivo
UsaTeclaRapida=S
NombreDesplegar=&Situación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Visible=S
TeclaRapida=Ctrl+F12
EspacioPrevio=S

ActivoCondicion=Usuario.ModificarSituacion
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
Vista=VIN
Fuente={Tahoma, 8, Negro, []}
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

[OtrosDatos.VIN.VIN]
Carpeta=OtrosDatos
Clave=VIN.VIN
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[OtrosDatos.VIN.ColorExterior]
Carpeta=OtrosDatos
Clave=VIN.ColorExterior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.VIN.ColorExteriorDescripcion]
Carpeta=OtrosDatos
Clave=VIN.ColorExteriorDescripcion
Editar=S
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.VIN.ColorInterior]
Carpeta=OtrosDatos
Clave=VIN.ColorInterior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.VIN.ColorInteriorDescripcion]
Carpeta=OtrosDatos
Clave=VIN.ColorInteriorDescripcion
Editar=S
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Colores]
Nombre=Colores
Boton=0
Menu=&Maestros
NombreDesplegar=&Colores
EnMenu=S
TipoAccion=Formas
ClaveAccion=VINColor
Activo=S
Visible=S
GuardarAntes=S

[Precios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Precios
Clave=Precios
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
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
CondicionVisible=Usuario.Costos y Config.VINCostoSumaAccesorios

[Precios.VIN.PrecioDistribuidor]
Carpeta=Precios
Clave=VIN.PrecioDistribuidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Precios.VIN.PrecioPublico]
Carpeta=Precios
Clave=VIN.PrecioPublico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S
Tamano=20

[Precios.VIN.ISANPublico]
Carpeta=Precios
Clave=VIN.ISANPublico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Precios.VIN.IVAPublico]
Carpeta=Precios
Clave=VIN.IVAPublico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Precios.PrecioPublicoTotal]
Carpeta=Precios
Clave=PrecioPublicoTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20
Efectos=[Negritas]

[Precios.VIN.PrecioContado]
Carpeta=Precios
Clave=VIN.PrecioContado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S
Tamano=20

[Precios.VIN.ISANContado]
Carpeta=Precios
Clave=VIN.ISANContado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Precios.VIN.IVAContado]
Carpeta=Precios
Clave=VIN.IVAContado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Precios.PrecioContadoTotal]
Carpeta=Precios
Clave=PrecioContadoTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20
Efectos=[Negritas]

[Detalle.VIN.TipoCompra]
Carpeta=Detalle
Clave=VIN.TipoCompra
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S
EditarConBloqueo=S

[Fechas.VIN.FechaFacturaCompra]
Carpeta=Fechas
Clave=VIN.FechaFacturaCompra
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Fechas.VIN.FechaBaja]
Carpeta=Fechas
Clave=VIN.FechaBaja
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro

[Fechas.VIN.DiasLibresAdicionales]
Carpeta=Fechas
Clave=VIN.DiasLibresAdicionales
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[OtrosDatos.VIN.BonoLealtad]
Carpeta=OtrosDatos
Clave=VIN.BonoLealtad
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[OtrosDatos.VIN.OtrasBonificaciones1]
Carpeta=OtrosDatos
Clave=VIN.OtrasBonificaciones1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[OtrosDatos.VIN.OtrasBonificaciones2]
Carpeta=OtrosDatos
Clave=VIN.OtrasBonificaciones2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[OtrosDatos.VIN.OtrasBonificaciones3]
Carpeta=OtrosDatos
Clave=VIN.OtrasBonificaciones3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[OtrosDatos.VIN.TipoVenta]
Carpeta=OtrosDatos
Clave=VIN.TipoVenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[OtrosDatos.VIN.ImporteVenta]
Carpeta=OtrosDatos
Clave=VIN.ImporteVenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=28

[OtrosDatos.VIN.Contrato]
Carpeta=OtrosDatos
Clave=VIN.Contrato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.VIN.BonificacionContratoServicio]
Carpeta=OtrosDatos
Clave=VIN.BonificacionContratoServicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro

[FordFI]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ford (FI)
Clave=FordFI
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
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
CondicionVisible=General.Ford

[FordFI.VIN.FIFSCAR]
Carpeta=FordFI
Clave=VIN.FIFSCAR
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordFI.VIN.FITipoFinanciamiento]
Carpeta=FordFI
Clave=VIN.FITipoFinanciamiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordFI.VIN.FIFechaFactura]
Carpeta=FordFI
Clave=VIN.FIFechaFactura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordFI.VIN.FINumeroContrato]
Carpeta=FordFI
Clave=VIN.FINumeroContrato
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordFI.VIN.FIMontoFinanciar]
Carpeta=FordFI
Clave=VIN.FIMontoFinanciar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordFI.VIN.FIFechaCompra]
Carpeta=FordFI
Clave=VIN.FIFechaCompra
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordFI.VIN.FIFechaPagare]
Carpeta=FordFI
Clave=VIN.FIFechaPagare
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordFI.VIN.VIN]
Carpeta=FordFI
Clave=VIN.VIN
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[OtrosDatos.VIN.KmSalida]
Carpeta=OtrosDatos
Clave=VIN.KmSalida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seguros]
Nombre=Seguros
Boton=61
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Seguros
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VINSeguro
Activo=S
ConCondicion=S
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+S
EjecucionCondicion=ConDatos(VIN:VIN.VIN)
AntesExpresiones=Asigna(Info.VIN, VIN:VIN.VIN)

[Acciones.PolizaTipo]
Nombre=PolizaTipo
Boton=0
Menu=&Maestros
NombreDesplegar=Tipos de Pólizas
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PolizaTipo
Activo=S
Visible=S

[Acciones.PolizaPlan]
Nombre=PolizaPlan
Boton=0
Menu=&Maestros
NombreDesplegar=Planes de Pólizas
EnMenu=S
TipoAccion=Formas
ClaveAccion=PolizaPlan
Activo=S
Visible=S

[Acciones.PolizaEstado]
Nombre=PolizaEstado
Boton=0
Menu=&Maestros
NombreDesplegar=Estados de Pólizas
EnMenu=S
TipoAccion=Formas
ClaveAccion=PolizaEstado
Activo=S
Visible=S

[OtrosDatos.VIN.OtrasBonificaciones1F]
Carpeta=OtrosDatos
Clave=VIN.OtrasBonificaciones1F
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.VIN.OtrasBonificaciones2F]
Carpeta=OtrosDatos
Clave=VIN.OtrasBonificaciones2F
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.VIN.OtrasBonificaciones3F]
Carpeta=OtrosDatos
Clave=VIN.OtrasBonificaciones3F
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.VIN.BonificacionContratoServicioF]
Carpeta=OtrosDatos
Clave=VIN.BonificacionContratoServicioF
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.Compra.Mov]
Carpeta=FordGenerales
Clave=Compra.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[FordGenerales.Compra.MovID]
Carpeta=FordGenerales
Clave=Compra.MovID
Editar=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[FordGenerales.Compra.FechaEmision]
Carpeta=FordGenerales
Clave=Compra.FechaEmision
Editar=S
ValidaNombre=N
3D=S
Tamano=21
ColorFondo=Plata
ColorFuente=Negro

[FordGenerales.Compra.Moneda]
Carpeta=FordGenerales
Clave=Compra.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[FordGenerales.Compra.TipoCambio]
Carpeta=FordGenerales
Clave=Compra.TipoCambio
Editar=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[Fechas.VIN.FechaPago]
Carpeta=Fechas
Clave=VIN.FechaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[OtrosDatos.VIN.UltimaLlamada]
Carpeta=OtrosDatos
Clave=VIN.UltimaLlamada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=28
EspacioPrevio=S

[OtrosDatos.VIN.SiguienteLlamada]
Carpeta=OtrosDatos
Clave=VIN.SiguienteLlamada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=28

[OtrosDatos.VIN.NoLlamar]
Carpeta=OtrosDatos
Clave=VIN.NoLlamar
Editar=S
ValidaNombre=N
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=N

[Detalle.VIN.ValidarVIN]
Carpeta=Detalle
Clave=VIN.ValidarVIN
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.VIN.CantidadLlamadas]
Carpeta=OtrosDatos
Clave=VIN.CantidadLlamadas
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S
Pegado=S

[Fechas.VIN.FechaSalidaMRS]
Carpeta=Fechas
Clave=VIN.FechaSalidaMRS
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.VIN.Blindado]
Carpeta=Detalle
Clave=VIN.Blindado
Editar=S
EditarConBloqueo=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Columnas]
CampoNombre=311
Valor=303
ValorAnterior=285




[Detalle.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.Modelo
VIN.Modelo=VIN.TipoUnidad
VIN.TipoUnidad=VIN.ValidarVIN
VIN.ValidarVIN=VIN.Articulo
VIN.Articulo=Art.Descripcion1
Art.Descripcion1=VIN.Motor
VIN.Motor=VIN.Placas
VIN.Placas=VIN.Llave
VIN.Llave=VIN.Km
VIN.Km=VIN.ClaveVehicular
VIN.ClaveVehicular=VIN.Registro
VIN.Registro=VIN.Aduana
VIN.Aduana=VIN.Pedimento
VIN.Pedimento=VIN.FechaImportacion
VIN.FechaImportacion=VIN.FechaCartaCredito
VIN.FechaCartaCredito=VIN.Tasa
VIN.Tasa=VIN.FechaFactura
VIN.FechaFactura=VIN.FechaUltimoServicio
VIN.FechaUltimoServicio=VIN.FechaSiguienteServicio
VIN.FechaSiguienteServicio=VIN.GarantiaVencimiento
VIN.GarantiaVencimiento=VIN.Holograma
VIN.Holograma=VIN.TipoCompra
VIN.TipoCompra=VIN.NumeroEconomico
VIN.NumeroEconomico=VIN.Blindado
VIN.Blindado=VIN.Cliente
VIN.Cliente=Cte.Nombre
Cte.Nombre=VIN.Conductor
VIN.Conductor=CteDestino.Nombre
CteDestino.Nombre=(Fin)

[Codigos.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.CodigoRadio
VIN.CodigoRadio=VIN.CodigoTransmision
VIN.CodigoTransmision=VIN.CodigoColor
VIN.CodigoColor=VIN.CodigoLlanta1
VIN.CodigoLlanta1=VIN.CodigoLlanta2
VIN.CodigoLlanta2=VIN.CodigoLlanta3
VIN.CodigoLlanta3=VIN.CodigoLlanta4
VIN.CodigoLlanta4=VIN.CodigoLlanta5
VIN.CodigoLlanta5=(Fin)

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=VIN.Articulo
VIN.Articulo=VIN.Fecha
VIN.Fecha=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=Actualizar
Actualizar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ORDENADO
ORDENADO=DISPONIBLE
DISPONIBLE=RESERVADO
RESERVADO=ENFIRME
ENFIRME=FACTURADO
FACTURADO=SERVICIO
SERVICIO=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[Cambio.ListaEnCaptura]
(Inicio)=VIN.CambioVIN
VIN.CambioVIN=VIN.CambioKm
VIN.CambioKm=(Fin)

[Fechas.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.FechaFacturaCompra
VIN.FechaFacturaCompra=VIN.FechaMRS
VIN.FechaMRS=VIN.FechaSalidaMRS
VIN.FechaSalidaMRS=VIN.FechaEntrada
VIN.FechaEntrada=VIN.FechaSalida
VIN.FechaSalida=VIN.FechaPago
VIN.FechaPago=VIN.FechaBaja
VIN.FechaBaja=Dias
Dias=VIN.DiasLibresIntereses
VIN.DiasLibresIntereses=VIN.DiasLibresAdicionales
VIN.DiasLibresAdicionales=FechaInicioCostoPiso
FechaInicioCostoPiso=VIN.UltimoPagoCostoPiso
VIN.UltimoPagoCostoPiso=VIN.IntercambioDirecto
VIN.IntercambioDirecto=(Fin)

[FordDatos.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.PrecioBasicoDistribuidor
VIN.PrecioBasicoDistribuidor=VIN.PrecioBasicoPublico
VIN.PrecioBasicoPublico=VIN.AjusteBasicoDistribuidor
VIN.AjusteBasicoDistribuidor=VIN.TotalAccesoriosDistribuidor
VIN.TotalAccesoriosDistribuidor=VIN.TotalAccesoriosPublico
VIN.TotalAccesoriosPublico=VIN.TotalDescuentoAccesoriosMemo
VIN.TotalDescuentoAccesoriosMemo=VIN.TotalDescuentoDistribuidorMemo
VIN.TotalDescuentoDistribuidorMemo=VIN.TotalDescuentoPepPublico
VIN.TotalDescuentoPepPublico=VIN.Descuento1Descripcion
VIN.Descuento1Descripcion=VIN.Descuento1Distribuidor
VIN.Descuento1Distribuidor=VIN.Descuento1Publico
VIN.Descuento1Publico=VIN.Descuento2Descripcion
VIN.Descuento2Descripcion=VIN.Descuento2Distribuidor
VIN.Descuento2Distribuidor=VIN.Descuento2Publico
VIN.Descuento2Publico=VIN.Descuento3Descripcion
VIN.Descuento3Descripcion=VIN.Descuento3Distribuidor
VIN.Descuento3Distribuidor=VIN.Descuento3Publico
VIN.Descuento3Publico=VIN.SeguroProvincial
VIN.SeguroProvincial=VIN.GastosTraslado
VIN.GastosTraslado=VIN.SeguroAsociacion
VIN.SeguroAsociacion=VIN.Bonificacion15DiasSinIntereses
VIN.Bonificacion15DiasSinIntereses=VIN.ReembolsoTransportacion
VIN.ReembolsoTransportacion=VIN.Bonificacion
VIN.Bonificacion=VIN.BonificacionEnPrecio
VIN.BonificacionEnPrecio=VIN.GarantiaServicio
VIN.GarantiaServicio=VIN.Miscelaneos
VIN.Miscelaneos=VIN.SubTotalFacturaCompra
VIN.SubTotalFacturaCompra=VIN.IVAFacturaCompra
VIN.IVAFacturaCompra=VIN.CoutaPublicidad
VIN.CoutaPublicidad=VIN.CoutaFondoCivico
VIN.CoutaFondoCivico=VIN.CoutaFordStar
VIN.CoutaFordStar=VIN.TotalFacturaCompra
VIN.TotalFacturaCompra=VIN.NivelPrecios
VIN.NivelPrecios=(Fin)

[FordGenerales.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.Modelo
VIN.Modelo=VIN.ClaveFinanciera
VIN.ClaveFinanciera=VIN.NumeroOrden
VIN.NumeroOrden=VIN.TipoCompra
VIN.TipoCompra=VIN.FolioFacturaCompra
VIN.FolioFacturaCompra=VIN.FechaFacturaCompra
VIN.FechaFacturaCompra=VIN.Mercado
VIN.Mercado=VIN.ClaveDistribuidor
VIN.ClaveDistribuidor=VIN.ColorExterior
VIN.ColorExterior=VIN.ColorExteriorDescripcion
VIN.ColorExteriorDescripcion=VIN.ColorInterior
VIN.ColorInterior=VIN.ColorInteriorDescripcion
VIN.ColorInteriorDescripcion=VIN.ClaveAduana
VIN.ClaveAduana=VIN.PedimentoFecha
VIN.PedimentoFecha=VIN.Descripcion1
VIN.Descripcion1=VIN.Descripcion2
VIN.Descripcion2=VIN.OtrasOpciones
VIN.OtrasOpciones=Compra.Mov
Compra.Mov=Compra.MovID
Compra.MovID=Compra.FechaEmision
Compra.FechaEmision=Compra.Moneda
Compra.Moneda=Compra.TipoCambio
Compra.TipoCambio=(Fin)

[OtrosDatos.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.ColorExterior
VIN.ColorExterior=VIN.ColorExteriorDescripcion
VIN.ColorExteriorDescripcion=VIN.ColorInterior
VIN.ColorInterior=VIN.ColorInteriorDescripcion
VIN.ColorInteriorDescripcion=VIN.OtrasBonificaciones1
VIN.OtrasBonificaciones1=VIN.OtrasBonificaciones1F
VIN.OtrasBonificaciones1F=VIN.OtrasBonificaciones2
VIN.OtrasBonificaciones2=VIN.OtrasBonificaciones2F
VIN.OtrasBonificaciones2F=VIN.OtrasBonificaciones3
VIN.OtrasBonificaciones3=VIN.OtrasBonificaciones3F
VIN.OtrasBonificaciones3F=VIN.BonificacionContratoServicio
VIN.BonificacionContratoServicio=VIN.BonificacionContratoServicioF
VIN.BonificacionContratoServicioF=VIN.TipoVenta
VIN.TipoVenta=VIN.ImporteVenta
VIN.ImporteVenta=VIN.KmSalida
VIN.KmSalida=VIN.Contrato
VIN.Contrato=VIN.UltimaLlamada
VIN.UltimaLlamada=VIN.SiguienteLlamada
VIN.SiguienteLlamada=VIN.NoLlamar
VIN.NoLlamar=VIN.CantidadLlamadas
VIN.CantidadLlamadas=VIN.BonoLealtad
VIN.BonoLealtad=(Fin)

[Precios.ListaEnCaptura]
(Inicio)=VIN.PrecioDistribuidor
VIN.PrecioDistribuidor=VIN.PrecioPublico
VIN.PrecioPublico=VIN.ISANPublico
VIN.ISANPublico=VIN.IVAPublico
VIN.IVAPublico=PrecioPublicoTotal
PrecioPublicoTotal=VIN.PrecioContado
VIN.PrecioContado=VIN.ISANContado
VIN.ISANContado=VIN.IVAContado
VIN.IVAContado=PrecioContadoTotal
PrecioContadoTotal=(Fin)

[FordFI.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.FIFSCAR
VIN.FIFSCAR=VIN.FITipoFinanciamiento
VIN.FITipoFinanciamiento=VIN.FIFechaFactura
VIN.FIFechaFactura=VIN.FINumeroContrato
VIN.FINumeroContrato=VIN.FIMontoFinanciar
VIN.FIMontoFinanciar=VIN.FIFechaCompra
VIN.FIFechaCompra=VIN.FIFechaPagare
VIN.FIFechaPagare=(Fin)




[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=Precios
Precios=Fechas
Fechas=Codigos
Codigos=FordGenerales
FordGenerales=FordDatos
FordDatos=FordFI
FordFI=OtrosDatos
OtrosDatos=Cambio
Cambio=SituacionCta
SituacionCta=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Situacion
Situacion=Eliminar
Eliminar=Accesorios
Accesorios=Seguros
Seguros=Anexo
Anexo=Doc
Doc=Informacion
Informacion=CostoPiso
CostoPiso=Historico
Historico=Venta
Venta=FordOasis
FordOasis=Navegador
Navegador=Cerrar
Cerrar=Aduana
Aduana=Aseguradora
Aseguradora=Colores
Colores=PolizaTipo
PolizaTipo=PolizaPlan
PolizaPlan=PolizaEstado
PolizaEstado=Otros1
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
&Maestros=(Fin)

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
FiltroGeneral=SituacionCta.Rama=<T>AUTO<T> AND SituacionCta.Cuenta=<T>{VIN:VIN.VIN}<T>
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
