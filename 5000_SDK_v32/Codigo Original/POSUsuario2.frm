[Forma]
Clave=POSUsuario2
Nombre=Usuarios
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=POSUsuarioAccion
PosicionInicialIzquierda=284
PosicionInicialArriba=57
PosicionInicialAltura=405
PosicionInicialAncho=797
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Menus=S
BarraAyuda=S
PosicionInicialAlturaCliente=575
PosicionSec1=238

VentanaEstadoInicial=Normal
Comentarios=Info.Usuario
ExpresionesAlMostrar=Asigna(Info.Visible,falso)<BR>Asigna(Info.Bloqueado,verdadero)
MenuPrincipal=(Lista)
[Lista.Usuario.Usuario]
Carpeta=Lista
Clave=Usuario.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Usuario.Nombre]
Carpeta=Lista
Clave=Usuario.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Lista.Columnas]
Usuario=82
Nombre=269
GrupoTrabajo=143
Fecha=148
Sucursal=64
Nombre_1=154
Empresa=69


0=99
1=375
UEN=44
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

[Empresas.UsuarioD.Empresa]
Carpeta=Empresas
Clave=UsuarioD.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5

[Empresas.Empresa.Nombre]
Carpeta=Empresas
Clave=Empresa.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100

[Empresas.Empresa.Grupo]
Carpeta=Empresas
Clave=Empresa.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100

[Empresas.Columnas]
Empresa=45
Nombre=268
Grupo=107



[Default.Usuario.DefProyecto]
Carpeta=Default
Clave=Usuario.DefProyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Default.Usuario.DefMoneda]
Carpeta=Default
Clave=Usuario.DefMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Default.Usuario.DefAlmacen]
Carpeta=Default
Clave=Usuario.DefAlmacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Default.Usuario.DefAgente]
Carpeta=Default
Clave=Usuario.DefAgente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Default.Usuario.Usuario]
Carpeta=Default
Clave=Usuario.Usuario
Editar=N
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro

[Default.Usuario.Nombre]
Carpeta=Default
Clave=Usuario.Nombre
Editar=N
3D=S
Tamano=49
ColorFondo=Plata
Pegado=S
ColorFuente=Negro


[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar cambios
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
EnMenu=S

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

[Consultas.Usuario.VerInfoDeudores]
Carpeta=Consultas
Clave=Usuario.VerInfoDeudores
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Consultas.Usuario.VerInfoAcreedores]
Carpeta=Consultas
Clave=Usuario.VerInfoAcreedores
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Consultas.Usuario.Costos]
Carpeta=Consultas
Clave=Usuario.Costos
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Default.Usuario.DefCliente]
Carpeta=Default
Clave=Usuario.DefCliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Default.Usuario.DefCtaDinero]
Carpeta=Default
Clave=Usuario.DefCtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.Usuario]
Carpeta=Movs
Clave=Usuario.Usuario
LineaNueva=S
3D=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro

[Movs.Usuario.Nombre]
Carpeta=Movs
Clave=Usuario.Nombre
3D=S
Pegado=S
Tamano=49
ColorFondo=Plata
ColorFuente=Negro

[Movs.Usuario.Afectar]
Carpeta=Movs
Clave=Usuario.Afectar
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.Cancelar]
Carpeta=Movs
Clave=Usuario.Cancelar
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.Desafectar]
Carpeta=Movs
Clave=Usuario.Desafectar
Editar=S
ValidaNombre=N
3D=S
Tamano=13
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.ConsultarOtrosMovs]
Carpeta=Movs
Clave=Usuario.ConsultarOtrosMovs
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ValidaNombre=S
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.ModificarOtrosMovs]
Carpeta=Movs
Clave=Usuario.ModificarOtrosMovs
Editar=S
3D=S
Tamano=20
ValidaNombre=S
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.AfectarOtrosMovs]
Carpeta=Movs
Clave=Usuario.AfectarOtrosMovs
Editar=S
LineaNueva=S
3D=S
Tamano=20
ValidaNombre=S
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.CancelarOtrosMovs]
Carpeta=Movs
Clave=Usuario.CancelarOtrosMovs
Editar=S
3D=S
Tamano=20
ValidaNombre=S
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.ImprimirMovs]
Carpeta=Movs
Clave=Usuario.ImprimirMovs
Editar=S
LineaNueva=S
3D=S
Tamano=13
ValidaNombre=N
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.PreliminarMovs]
Carpeta=Movs
Clave=Usuario.PreliminarMovs
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Consultas.Usuario.Usuario]
Carpeta=Consultas
Clave=Usuario.Usuario
3D=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro

[Consultas.Usuario.Nombre]
Carpeta=Consultas
Clave=Usuario.Nombre
3D=S
Tamano=49
ColorFondo=Plata
Pegado=S
ColorFuente=Negro

[Opciones.Usuario.Usuario]
Carpeta=Opciones
Clave=Usuario.Usuario
3D=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro

[Opciones.Usuario.Nombre]
Carpeta=Opciones
Clave=Usuario.Nombre
3D=S
Pegado=S
Tamano=49
ColorFondo=Plata
ColorFuente=Negro

[Opciones.Usuario.ModificarVencimientos]
Carpeta=Opciones
Clave=Usuario.ModificarVencimientos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.ModificarEntregas]
Carpeta=Opciones
Clave=Usuario.ModificarEntregas
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.ModificarEnvios]
Carpeta=Opciones
Clave=Usuario.ModificarEnvios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.ModificarReferencias]
Carpeta=Opciones
Clave=Usuario.ModificarReferencias
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.ModificarAlmacenEntregas]
Carpeta=Opciones
Clave=Usuario.ModificarAlmacenEntregas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.AgregarCteExpress]
Carpeta=Opciones
Clave=Usuario.AgregarCteExpress
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearEncabezadoVenta]
Carpeta=Opciones
Clave=Usuario.BloquearEncabezadoVenta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.ModificarSituacion]
Carpeta=Movs
Clave=Usuario.ModificarSituacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Movs.Usuario.ModificarAgente]
Carpeta=Movs
Clave=Usuario.ModificarAgente
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[Movs.Usuario.ModificarUsuario]
Carpeta=Movs
Clave=Usuario.ModificarUsuario
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.AgregarArtExpress]
Carpeta=Opciones
Clave=Usuario.AgregarArtExpress
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.ModificarAlmacenPedidos]
Carpeta=Opciones
Clave=Usuario.ModificarAlmacenPedidos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Default.Usuario.DefLocalidad]
Carpeta=Default
Clave=Usuario.DefLocalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearCxcCtaDinero]
Carpeta=Opciones
Clave=Usuario.BloquearCxcCtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearCxpCtaDinero]
Carpeta=Opciones
Clave=Usuario.BloquearCxpCtaDinero
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.Reservar]
Carpeta=Movs
Clave=Usuario.Reservar
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=13

[Movs.Usuario.DesReservar]
Carpeta=Movs
Clave=Usuario.DesReservar
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=14

[Movs.Usuario.Asignar]
Carpeta=Movs
Clave=Usuario.Asignar
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=13

[Movs.Usuario.DesAsignar]
Carpeta=Movs
Clave=Usuario.DesAsignar
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=14

[Movs.Usuario.EnviarExcel]
Carpeta=Movs
Clave=Usuario.EnviarExcel
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20


[Consultas.Usuario.VerComisionesPendientes]
Carpeta=Consultas
Clave=Usuario.VerComisionesPendientes
Editar=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearCondiciones]
Carpeta=Opciones
Clave=Usuario.BloquearCondiciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearMoneda]
Carpeta=Opciones
Clave=Usuario.BloquearMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearAlmacen]
Carpeta=Opciones
Clave=Usuario.BloquearAlmacen
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearAgente]
Carpeta=Opciones
Clave=Usuario.BloquearAgente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearProyecto]
Carpeta=Opciones
Clave=Usuario.BloquearProyecto
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearFechaEmision]
Carpeta=Opciones
Clave=Usuario.BloquearFechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro


[Movs.Usuario.ModificarConceptos]
Carpeta=Movs
Clave=Usuario.ModificarConceptos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro






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
NombreDesplegar=&Presentación preliminar
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

[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Usuarios
Clave=(Carpeta Abrir)
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=UsuarioA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Usuario<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=Usuario.Usuario<TAB>(Acendente)
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=GrupoTrabajo
FiltroAplicaEn1=Usuario.GrupoTrabajo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
ListaAcciones=(Lista)
CarpetaVisible=S
FiltroTodo=S

IconosNombre=UsuarioA:Usuario.Usuario
[(Carpeta Abrir).Usuario.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Usuario.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[(Carpeta Abrir).Columnas]
0=98
1=378

2=-2

[(Carpeta Abrir).Sucursal.Sucursal]
Carpeta=(Carpeta Abrir)
Clave=Sucursal.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Acciones.Otros1]
Nombre=Otros1
Boton=0
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Menu=&Otros

[Acciones.Otros2]
Nombre=Otros2
Boton=0
Menu=&Otros
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros3]
Nombre=Otros3
Boton=0
Menu=&Otros
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros4]
Nombre=Otros4
Boton=0
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Menu=&Otros

[Acciones.Otros5]
Nombre=Otros5
Boton=0
Menu=&Otros
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros6]
Nombre=Otros6
Boton=0
Menu=&Otros
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros7]
Nombre=Otros7
Boton=0
Menu=&Otros
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros8]
Nombre=Otros8
Boton=0
Menu=&Otros
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros9]
Nombre=Otros9
Boton=0
Menu=&Otros
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion



[Detalle.Columnas]
CampoNombre=311
Valor=303
ValorAnterior=285







[Detalle.ListaEnCaptura]
(Inicio)=POSUsuario.Usuario
POSUsuario.Usuario=POSUsuario.Nombre
POSUsuario.Nombre=POSUsuario.DefCajero
POSUsuario.DefCajero=POSUsuario.DefAlmacen
POSUsuario.DefAlmacen=POSUsuario.DefCtaDinero
POSUsuario.DefCtaDinero=POSUsuario.DefMoneda
POSUsuario.DefMoneda=POSUsuario.DefCliente
POSUsuario.DefCliente=POSUsuario.DefAgente
POSUsuario.DefAgente=POSUsuario.DefListaPreciosEsp
POSUsuario.DefListaPreciosEsp=POSUsuario.UEN
POSUsuario.UEN=POSUsuario.DefZonaImpuesto
POSUsuario.DefZonaImpuesto=POSUsuario.DefProyecto
POSUsuario.DefProyecto=POSUsuario.DefFormaPago
POSUsuario.DefFormaPago=(Fin)








[Default.POSUsuario.Usuario]
Carpeta=Default
Clave=POSUsuario.Usuario
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata

[Default.POSUsuario.Nombre]
Carpeta=Default
Clave=POSUsuario.Nombre
Editar=S
3D=S
Pegado=S
Tamano=50
ColorFondo=Plata

[Default.POSUsuario.DefCajero]
Carpeta=Default
Clave=POSUsuario.DefCajero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Default.POSUsuario.DefAlmacen]
Carpeta=Default
Clave=POSUsuario.DefAlmacen
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Default.POSUsuario.DefCtaDinero]
Carpeta=Default
Clave=POSUsuario.DefCtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Default.POSUsuario.DefMoneda]
Carpeta=Default
Clave=POSUsuario.DefMoneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Default.POSUsuario.DefCliente]
Carpeta=Default
Clave=POSUsuario.DefCliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Default.POSUsuario.DefAgente]
Carpeta=Default
Clave=POSUsuario.DefAgente
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Default.POSUsuario.DefListaPreciosEsp]
Carpeta=Default
Clave=POSUsuario.DefListaPreciosEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Default.POSUsuario.UEN]
Carpeta=Default
Clave=POSUsuario.UEN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Default.POSUsuario.DefZonaImpuesto]
Carpeta=Default
Clave=POSUsuario.DefZonaImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=54
ColorFondo=Blanco

[Default.POSUsuario.DefProyecto]
Carpeta=Default
Clave=POSUsuario.DefProyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=54
ColorFondo=Blanco

[Default.POSUsuario.DefFormaPago]
Carpeta=Default
Clave=POSUsuario.DefFormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=54
ColorFondo=Blanco










[POSUsuarioAccion]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Acciones POS
Clave=POSUsuarioAccion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSUsuarioAccion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

ListaEnCaptura=POSUsuarioAccion.Accion




Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
RefrescarAlEntrar=S
ExpAntesRefrescar=Asigna(Info.Visible,Falso)<BR>Asigna(Info.Bloqueado,verdadero)   <BR>Forma.ActualizarControles
CondicionEdicion=Vacio(Info.UsuarioNuevo)
FiltroGeneral=POSUsuarioAccion.Usuario = <T>{SI(ConDatos(Info.UsuarioNuevo),Info.UsuarioNuevo,Info.Usuario)}<T>
[POSUsuarioAccion.POSUsuarioAccion.Accion]
Carpeta=POSUsuarioAccion
Clave=POSUsuarioAccion.Accion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[POSUsuarioAccion.Columnas]
Accion=736









[POSAccion.Columnas]
0=316









































































[POSUsuarioMov]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Movimientos POS
Clave=POSUsuarioMov
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSUsuarioMov
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

RefrescarAlEntrar=S
ExpAntesRefrescar=Asigna(Info.Visible,verdadero)<BR>Asigna(Info.Bloqueado,Falso)   <BR>Forma.ActualizarControles
OtroOrden=S
ListaOrden=POSUsuarioMov.Mov<TAB>(Acendente)
PermiteEditar=S
CondicionEdicion=Vacio(Info.UsuarioNuevo)
FiltroGeneral=POSUsuarioMov.Usuario =<T>{SI(ConDatos(Info.UsuarioNuevo),Info.UsuarioNuevo,Info.Usuario)}<T>
[POSUsuarioMov.POSUsuarioMov.Mov]
Carpeta=POSUsuarioMov
Clave=POSUsuarioMov.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[POSUsuarioMov.Columnas]
Mov=658





PuedeAutorizar=81
[Acciones.Mov]
Nombre=Mov
Boton=55
NombreDesplegar=Movimientos
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S

NombreEnBoton=S








EspacioPrevio=S




Expresion=FormaModal(<T>POSUsuarioMovTemp<T>)<BR> Forma.ActualizarVista(<T>POSUsuarioMov<T>)
ActivoCondicion=(Info.Visible)y(Vacio(Info.UsuarioNuevo))
[POSUsuarioMovTemp.Columnas]
0=-2






























































[POSUsuarioAccionTemp.Columnas]
0=-2


[Acciones.Accion]
Nombre=Accion
Boton=98
NombreEnBoton=S
NombreDesplegar=&Acciones
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S





















Expresion=FormaModal(<T>POSUsuarioAccionTemp<T>)<BR> Forma.ActualizarVista(<T>POSUsuarioAccion<T>)
ActivoCondicion=(Info.Bloqueado)y(Vacio(Info.UsuarioNuevo))
[Default.POSUsuario.POSPerfil]
Carpeta=Default
Clave=POSUsuario.POSPerfil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[POSUsuarioMov.POSUsuarioMov.PuedeAutorizar]
Carpeta=POSUsuarioMov
Clave=POSUsuarioMov.PuedeAutorizar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






























[Forma.PlantillasExcepciones]
(Inicio)=Usuario:Usuario.Estatus
Usuario:Usuario.Estatus=Usuario:Usuario.TieneMovimientos
Usuario:Usuario.TieneMovimientos=(Fin)







[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Usuario.Nombre
Usuario.Nombre=Sucursal.Sucursal
Sucursal.Sucursal=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=Actualizar
Actualizar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)


























[Acciones.EliminarUsuarioAccion]
Nombre=EliminarUsuarioAccion
Boton=5
NombreDesplegar=Registro Eliminar
EnBarraHerramientas=S
Carpeta=POSUsuarioAccion
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar













EspacioPrevio=S
ActivoCondicion=Vacio(Info.UsuarioNuevo)
VisibleCondicion=CarpetaActiva(<T>A1<T>)=<T>POSUsuarioAccion<T>
[Acciones.EliminarUsuarioMov]
Nombre=EliminarUsuarioMov
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=POSUsuarioMov
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar





















































ActivoCondicion=Vacio(Info.UsuarioNuevo)
VisibleCondicion=CarpetaActiva(<T>A1<T>)=<T>POSUsuarioMov<T>
[Default.ListaEnCaptura]
(Inicio)=POSUsuario.Usuario
POSUsuario.Usuario=POSUsuario.Nombre
POSUsuario.Nombre=POSUsuario.DefCajero
POSUsuario.DefCajero=POSUsuario.DefAlmacen
POSUsuario.DefAlmacen=POSUsuario.DefCtaDinero
POSUsuario.DefCtaDinero=POSUsuario.DefMoneda
POSUsuario.DefMoneda=POSUsuario.DefCliente
POSUsuario.DefCliente=POSUsuario.DefAgente
POSUsuario.DefAgente=POSUsuario.DefListaPreciosEsp
POSUsuario.DefListaPreciosEsp=POSUsuario.UEN
POSUsuario.UEN=POSUsuario.DefZonaImpuesto
POSUsuario.DefZonaImpuesto=POSUsuario.DefProyecto
POSUsuario.DefProyecto=POSUsuario.DefFormaPago
POSUsuario.DefFormaPago=POSUsuario.POSPerfil
POSUsuario.POSPerfil=(Fin)




























[POSUsuarioMov.ListaEnCaptura]
(Inicio)=POSUsuarioMov.Mov
POSUsuarioMov.Mov=POSUsuarioMov.PuedeAutorizar
POSUsuarioMov.PuedeAutorizar=(Fin)






















[Forma.ListaCarpetas]
(Inicio)=POSUsuarioAccion
POSUsuarioAccion=POSUsuarioMov
POSUsuarioMov=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Accion
Accion=Mov
Mov=EliminarUsuarioAccion
EliminarUsuarioAccion=EliminarUsuarioMov
EliminarUsuarioMov=Navegador
Navegador=Cerrar
Cerrar=Otros1
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
