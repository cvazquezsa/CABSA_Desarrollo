[Forma]
Clave=UsuarioCfg
Nombre=Configuración del Usuario
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Otros
PosicionInicialIzquierda=529
PosicionInicialArriba=132
PosicionInicialAltura=528
PosicionInicialAncho=861
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaBloquearAjuste=N
Comentarios=Info.Usuario
VentanaExclusiva=S
PosicionInicialAlturaCliente=737
BarraAyuda=S
PosicionSec1=238

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
Nombre=304
GrupoTrabajo=143
Fecha=148
Sucursal=64
Nombre_1=154
Empresa=69
0=106
1=301
[Detalle.Usuario.Usuario]
Carpeta=Detalle
Clave=Usuario.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Usuario.Nombre]
Carpeta=Detalle
Clave=Usuario.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Usuario.GrupoTrabajo]
Carpeta=Detalle
Clave=Usuario.GrupoTrabajo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Usuario.Contrasena]
Carpeta=Detalle
Clave=Usuario.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Usuario.Telefono]
Carpeta=Detalle
Clave=Usuario.Telefono
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Usuario.Extencion]
Carpeta=Detalle
Clave=Usuario.Extencion
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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

[Detalle.Usuario.Estatus]
Carpeta=Detalle
Clave=Usuario.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Default]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Valores por omisión
Clave=Default
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=Usuario.Usuario=<T>{Info.Usuario}<T>

[Default.Usuario.DefProyecto]
Carpeta=Default
Clave=Usuario.DefProyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Default.Usuario.DefMoneda]
Carpeta=Default
Clave=Usuario.DefMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Default.Usuario.DefAlmacen]
Carpeta=Default
Clave=Usuario.DefAlmacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Default.Usuario.DefAgente]
Carpeta=Default
Clave=Usuario.DefAgente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
EnMenu=S
GuardarAntes=S
ConCondicion=S
EjecucionConError=S

Antes=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(Usuario:Usuario.DefMoneda)
EjecucionMensaje=<T>Es necesario Especificar la Moneda por Omisión<T>
AntesExpresiones=Asigna(Pos.ValidaUsuario, nulo)<BR>Si<BR>  General.POS<BR>Entonces<BR>  Asigna(Pos.ValidaUsuario,SQL(<T>EXEC spPOSUsuarioValidaCfg :tUsuario<T>, Info.Usuario))<BR>Fin<BR><BR>Si<BR>  ConDatos(Pos.ValidaUsuario)<BR>Entonces<BR>  Precaucion(Pos.ValidaUsuario)<BR>Fin
[Consultas]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Consultas Especiales
Clave=Consultas
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
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

[Consultas.Usuario.VerInfoDeudores]
Carpeta=Consultas
Clave=Usuario.VerInfoDeudores
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Consultas.Usuario.VerInfoAcreedores]
Carpeta=Consultas
Clave=Usuario.VerInfoAcreedores
Editar=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Consultas.Usuario.Costos]
Carpeta=Consultas
Clave=Usuario.Costos
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
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


[Default.Usuario.DefCtaDinero]
Carpeta=Default
Clave=Usuario.DefCtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Movs]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
Clave=Movs
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
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

[Movs.Usuario.Afectar]
Carpeta=Movs
Clave=Usuario.Afectar
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco

[Movs.Usuario.Cancelar]
Carpeta=Movs
Clave=Usuario.Cancelar
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco

[Movs.Usuario.Desafectar]
Carpeta=Movs
Clave=Usuario.Desafectar
Editar=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco

[Movs.Usuario.ConsultarOtrosMovs]
Carpeta=Movs
Clave=Usuario.ConsultarOtrosMovs
Editar=S
LineaNueva=N
3D=S
EspacioPrevio=N
Tamano=30
ValidaNombre=N
ColorFondo=Blanco

[Movs.Usuario.ModificarOtrosMovs]
Carpeta=Movs
Clave=Usuario.ModificarOtrosMovs
Editar=S
3D=S
Tamano=30
ValidaNombre=N
ColorFondo=Blanco

[Movs.Usuario.AfectarOtrosMovs]
Carpeta=Movs
Clave=Usuario.AfectarOtrosMovs
Editar=S
LineaNueva=S
3D=S
Tamano=31
ValidaNombre=N
ColorFondo=Blanco

[Movs.Usuario.CancelarOtrosMovs]
Carpeta=Movs
Clave=Usuario.CancelarOtrosMovs
Editar=S
3D=S
Tamano=31
ValidaNombre=N
ColorFondo=Blanco

[Movs.Usuario.ImprimirMovs]
Carpeta=Movs
Clave=Usuario.ImprimirMovs
Editar=S
LineaNueva=S
3D=S
Tamano=31
ValidaNombre=N
EspacioPrevio=S
ColorFondo=Blanco

[Movs.Usuario.PreliminarMovs]
Carpeta=Movs
Clave=Usuario.PreliminarMovs
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Opciones]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Opciones
Clave=Opciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=233
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
FichaEspacioNombresAuto=S

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

EspacioPrevio=N
ColorFuente=Negro

[Movs.Usuario.ModificarAgente]
Carpeta=Movs
Clave=Usuario.ModificarAgente
Editar=S
ValidaNombre=N
3D=S
Tamano=31
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Movs.Usuario.ModificarUsuario]
Carpeta=Movs
Clave=Usuario.ModificarUsuario
Editar=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco

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

EspacioPrevio=S

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
Tamano=20

[Movs.Usuario.DesReservar]
Carpeta=Movs
Clave=Usuario.DesReservar
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=20

[Movs.Usuario.Asignar]
Carpeta=Movs
Clave=Usuario.Asignar
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=20

[Movs.Usuario.DesAsignar]
Carpeta=Movs
Clave=Usuario.DesAsignar
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=20

[Movs.Usuario.EnviarExcel]
Carpeta=Movs
Clave=Usuario.EnviarExcel
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=30

[Consultas.Usuario.VerComisionesPendientes]
Carpeta=Consultas
Clave=Usuario.VerComisionesPendientes
Editar=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

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
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Usuario.Oficina]
Carpeta=Detalle
Clave=Usuario.Oficina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.ModificarConceptos]
Carpeta=Movs
Clave=Usuario.ModificarConceptos
Editar=N
ValidaNombre=N
3D=S
Tamano=56
ColorFondo=Blanco
LineaNueva=S

[Otros]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros
Clave=Otros
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioCfg2
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=UsuarioCfg2.Usuario=<T>{Info.Usuario}<T>
[Otros.UsuarioCfg2.CxcMovExpress]
Carpeta=Otros
Clave=UsuarioCfg2.CxcMovExpress
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
Tamano=35

[Otros.UsuarioCfg2.CxpMovExpress]
Carpeta=Otros
Clave=UsuarioCfg2.CxpMovExpress
Editar=S
LineaNueva=N
3D=S
ColorFondo=Blanco
Tamano=35

[Otros.UsuarioCfg2.ModificarClienteBackOrder]
Carpeta=Otros
Clave=UsuarioCfg2.ModificarClienteBackOrder
Editar=S
LineaNueva=S
3D=S
Tamano=35
ColorFondo=Blanco

[Otros.UsuarioCfg2.CancelarLote]
Carpeta=Otros
Clave=UsuarioCfg2.CancelarLote
Editar=S
LineaNueva=N
3D=S
ColorFondo=Blanco
Tamano=15

[Otros.UsuarioCfg2.AfectarLote]
Carpeta=Otros
Clave=UsuarioCfg2.AfectarLote
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=14
ColorFondo=Blanco

[Otros.UsuarioCfg2.BloquearMonedaArtPrecio]
Carpeta=Otros
Clave=UsuarioCfg2.BloquearMonedaArtPrecio
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Otros.UsuarioCfg2.BloquearMonedaArtCosto]
Carpeta=Otros
Clave=UsuarioCfg2.BloquearMonedaArtCosto
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Otros.UsuarioCfg2.ModificarObservaciones]
Carpeta=Otros
Clave=UsuarioCfg2.ModificarObservaciones
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Default.Usuario.DefUnidad]
Carpeta=Default
Clave=Usuario.DefUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco


[Default.Usuario.DefArtTipo]
Carpeta=Default
Clave=Usuario.DefArtTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco


[Otros.UsuarioCfg2.ControlAlmacenes]
Carpeta=Otros
Clave=UsuarioCfg2.ControlAlmacenes
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[Acciones.Almacenes]
Nombre=Almacenes
Boton=80
NombreEnBoton=S
NombreDesplegar=Acceso &Almacenes
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=UsuarioAlm
Visible=S
EspacioPrevio=S
ActivoCondicion=UsuarioCfg2:UsuarioCfg2.ControlAlmacenes

[Otros.UsuarioCfg2.ModificarAnexosMovConcluidos]
Carpeta=Otros
Clave=UsuarioCfg2.ModificarAnexosMovConcluidos
Editar=S
LineaNueva=N
3D=S
Tamano=45
ColorFondo=Blanco

[Opciones.Usuario.BloquearPrecios]
Carpeta=Opciones
Clave=Usuario.BloquearPrecios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
EspacioPrevio=S
ColorFuente=Negro


[Opciones.Usuario.BloquearDescGlobal]
Carpeta=Opciones
Clave=Usuario.BloquearDescGlobal
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
LineaNueva=S
ColorFuente=Negro


[Opciones.Usuario.BloquearDescLinea]
Carpeta=Opciones
Clave=Usuario.BloquearDescLinea
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Prod.UsuarioCfg2.ModificarProdCostosAd]
Carpeta=Prod
Clave=UsuarioCfg2.ModificarProdCostosAd
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Prod.UsuarioCfg2.AutorizarProdAvances]
Carpeta=Prod
Clave=UsuarioCfg2.AutorizarProdAvances
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Otros.UsuarioCfg2.Digitalizar]
Carpeta=Otros
Clave=UsuarioCfg2.Digitalizar
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Otros.UsuarioCfg2.VentaSugerirDisponible]
Carpeta=Otros
Clave=UsuarioCfg2.VentaSugerirDisponible
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Opciones.Usuario.ModificarFechaRequerida]
Carpeta=Opciones
Clave=Usuario.ModificarFechaRequerida
Editar=S
LineaNueva=N
3D=S
Tamano=
ColorFondo=Blanco

ValidaNombre=S
ColorFuente=Negro
[Movs.Usuario.Autorizar]
Carpeta=Movs
Clave=Usuario.Autorizar
Editar=S
ValidaNombre=N
3D=S
Tamano=31
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Movs.Usuario.ModificarListaPrecios]
Carpeta=Movs
Clave=Usuario.ModificarListaPrecios
Editar=S
LineaNueva=S
3D=S
Tamano=31
ColorFondo=Blanco
EspacioPrevio=S

[Movs.Usuario.ModificarZonaImpuesto]
Carpeta=Movs
Clave=Usuario.ModificarZonaImpuesto
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Otros.UsuarioCfg2.LimitarCompraLocal]
Carpeta=Otros
Clave=UsuarioCfg2.LimitarCompraLocal
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[Sucursales]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Sucursales
Clave=Sucursales
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
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
CarpetaVisible=S
ListaEnCaptura=(Lista)

[Sucursales.Usuario.ModificarSucursalDestino]
Carpeta=Sucursales
Clave=Usuario.ModificarSucursalDestino
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Sucursales.Usuario.ConsultarOtrasSucursales]
Carpeta=Sucursales
Clave=Usuario.ConsultarOtrasSucursales
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Sucursales.Usuario.AccesarOtrasSucursalesEnLinea]
Carpeta=Sucursales
Clave=Usuario.AccesarOtrasSucursalesEnLinea
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Consultas.Usuario.ConsultarOtrasEmpresas]
Carpeta=Consultas
Clave=Usuario.ConsultarOtrasEmpresas
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
Tamano=35
ColorFondo=Blanco
ColorFuente=Negro

[Default.Usuario.DefCajero]
Carpeta=Default
Clave=Usuario.DefCajero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Opciones.Usuario.AbrirCajon]
Carpeta=Opciones
Clave=Usuario.AbrirCajon
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearCobroInmediato]
Carpeta=Opciones
Clave=Usuario.BloquearCobroInmediato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Otros.UsuarioCfg2.GastoModificarProrrateo]
Carpeta=Otros
Clave=UsuarioCfg2.GastoModificarProrrateo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco

[Consultas.Usuario.ConsultarCompraPendiente]
Carpeta=Consultas
Clave=Usuario.ConsultarCompraPendiente
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.Refacturar]
Carpeta=Movs
Clave=Usuario.Refacturar
Editar=S
ValidaNombre=N
3D=S
Tamano=31
ColorFondo=Blanco
LineaNueva=S

[Sucursales.Usuario.AfectarOtrasSucursalesEnLinea]
Carpeta=Sucursales
Clave=Usuario.AfectarOtrasSucursalesEnLinea
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Default.Usuario.DefListaPreciosEsp]
Carpeta=Default
Clave=Usuario.DefListaPreciosEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Consultas.Usuario.CteInfo]
Carpeta=Consultas
Clave=Usuario.CteInfo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Otros.UsuarioCfg2.InvFisicoAlmacen]
Carpeta=Otros
Clave=UsuarioCfg2.InvFisicoAlmacen
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco

[Movs.Usuario.ImpresionInmediata]
Carpeta=Movs
Clave=Usuario.ImpresionInmediata
Editar=S
ValidaNombre=N
3D=S
Tamano=31
ColorFondo=Blanco
LineaNueva=S

[Cambios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Módulo Cambios
Clave=Cambios
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
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
CondicionVisible=General.Cambios

[Cambios.Usuario.CambioValidarCobertura]
Carpeta=Cambios
Clave=Usuario.CambioValidarCobertura
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Default.Usuario.DefCtaDineroTrans]
Carpeta=Default
Clave=Usuario.DefCtaDineroTrans
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=N

[Consultas.Usuario.AccesoTotalCuentas]
Carpeta=Consultas
Clave=Usuario.AccesoTotalCuentas
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Otros.UsuarioCfg2.ControlListasPrecios]
Carpeta=Otros
Clave=UsuarioCfg2.ControlListasPrecios
Editar=S
LineaNueva=S
3D=S
Tamano=60
ColorFondo=Blanco

[Acciones.Precios]
Nombre=Precios
Boton=80
NombreEnBoton=S
NombreDesplegar=Acceso &Listas Precios
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=UsuarioPrecios
Visible=S
ActivoCondicion=UsuarioCfg2:UsuarioCfg2.ControlListasPrecios

[Cambios.Usuario.CambioNormatividad]
Carpeta=Cambios
Clave=Usuario.CambioNormatividad
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Cambios.Usuario.CambioEditarCobertura]
Carpeta=Cambios
Clave=Usuario.CambioEditarCobertura
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.AutorizarVenta]
Carpeta=Movs
Clave=Usuario.AutorizarVenta
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Movs.Usuario.AutorizarCxp]
Carpeta=Movs
Clave=Usuario.AutorizarCxp
Editar=S
LineaNueva=S
3D=S
Tamano=31
ColorFondo=Blanco

[Movs.Usuario.AutorizarGasto]
Carpeta=Movs
Clave=Usuario.AutorizarGasto
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Movs.Usuario.MostrarCampos]
Carpeta=Movs
Clave=Usuario.MostrarCampos
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Otros.UsuarioCfg2.CompraSugerirDisponible]
Carpeta=Otros
Clave=UsuarioCfg2.CompraSugerirDisponible
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Opciones.Usuario.AsistentePrecios]
Carpeta=Opciones
Clave=Usuario.AsistentePrecios
Editar=S
3D=S
Tamano=
ColorFondo=Blanco
ValidaNombre=S
ColorFuente=Negro


[Movs.Usuario.AutorizarDinero]
Carpeta=Movs
Clave=Usuario.AutorizarDinero
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=31
ColorFondo=Blanco

[Cambios.Usuario.CambioVerPosicionEmpresa]
Carpeta=Cambios
Clave=Usuario.CambioVerPosicionEmpresa
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Cambios.Usuario.CambioVerPosicionSucursal]
Carpeta=Cambios
Clave=Usuario.CambioVerPosicionSucursal
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Cambios.Usuario.CambioVerPosicionOtraSucursal]
Carpeta=Cambios
Clave=Usuario.CambioVerPosicionOtraSucursal
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.AutorizarPV]
Carpeta=Movs
Clave=Usuario.AutorizarPV
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

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
Vista=Usuario
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
CondicionVisible=General.Autotransportes

[Auto.Usuario.AutoDobleCapturaPrecios]
Carpeta=Auto
Clave=Usuario.AutoDobleCapturaPrecios
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Auto.Usuario.AutoArtGrupo]
Carpeta=Auto
Clave=Usuario.AutoArtGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Default.Usuario.DefActividad]
Carpeta=Default
Clave=Usuario.DefActividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Opciones.Usuario.BloquearActividad]
Carpeta=Opciones
Clave=Usuario.BloquearActividad
Editar=S
LineaNueva=S
3D=S
Tamano=
ColorFondo=Blanco
ValidaNombre=S
ColorFuente=Negro


[Consultas.Usuario.CteBloquearOtrosDatos]
Carpeta=Consultas
Clave=Usuario.CteBloquearOtrosDatos
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[Opciones.Usuario.CteSucursalVenta]
Carpeta=Opciones
Clave=Usuario.CteSucursalVenta
Editar=S
LineaNueva=N
3D=S
Tamano=36
ColorFondo=Blanco
ColorFuente=Negro

[Consultas.Usuario.ArtBloquearOtrosDatos]
Carpeta=Consultas
Clave=Usuario.ArtBloquearOtrosDatos
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.UsuarioSucursalAcceso]
Nombre=UsuarioSucursalAcceso
Boton=80
NombreEnBoton=S
NombreDesplegar=Acceso &Sucursales
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=UsuarioSucursalAcceso
Visible=S

ActivoCondicion=no Usuario:Usuario.AccesarOtrasSucursalesEnLinea

[Default.Usuario.UEN]
Carpeta=Default
Clave=Usuario.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=N

[Default.UEN.Nombre]
Carpeta=Default
Clave=UEN.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata

Pegado=N

[Otros.UsuarioCfg2.PedidoGenerarOT]
Carpeta=Otros
Clave=UsuarioCfg2.PedidoGenerarOT
Editar=S
LineaNueva=N
3D=S
Tamano=57
ColorFondo=Blanco

[Movs.Usuario.CteMov]
Carpeta=Movs
Clave=Usuario.CteMov
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
Tamano=31
ColorFondo=Blanco

[Default.Usuario.DefContUso]
Carpeta=Default
Clave=Usuario.DefContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S

[Opciones.Usuario.BloquearContUso]
Carpeta=Opciones
Clave=Usuario.BloquearContUso
Editar=S
3D=S
Tamano=
ColorFondo=Blanco

ValidaNombre=S
ColorFuente=Negro

[Default.CentroCostos.Descripcion]
Carpeta=Default
Clave=CentroCostos.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata


[Movs.Usuario.ModificarReferenciasSiempre]
Carpeta=Movs
Clave=Usuario.ModificarReferenciasSiempre
Editar=N
LineaNueva=S
3D=S
Tamano=56
ColorFondo=Blanco

[Movs.Usuario.TraspasarTodo]
Carpeta=Movs
Clave=Usuario.TraspasarTodo
Editar=S
3D=S
Tamano=31
ColorFondo=Blanco
LineaNueva=S

[Otros.UsuarioCfg2.BloquearMaestrosPersonal]
Carpeta=Otros
Clave=UsuarioCfg2.BloquearMaestrosPersonal
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Default.Usuario.DefMovVentas]
Carpeta=Default
Clave=Usuario.DefMovVentas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco


[Otros.UsuarioCfg2.GastosPV]
Carpeta=Otros
Clave=UsuarioCfg2.GastosPV
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Auto.Usuario.AutoAgregarRecaudacionConsumo]
Carpeta=Auto
Clave=Usuario.AutoAgregarRecaudacionConsumo
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Otros.UsuarioCfg2.CompraGenerarOrdenesAlProcesar]
Carpeta=Otros
Clave=UsuarioCfg2.CompraGenerarOrdenesAlProcesar
Editar=S
LineaNueva=S
3D=S
Tamano=60
ColorFondo=Blanco

[Otros.UsuarioCfg2.GastosEditarDeducible]
Carpeta=Otros
Clave=UsuarioCfg2.GastosEditarDeducible
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Auto.Usuario.AutoDiesel]
Carpeta=Auto
Clave=Usuario.AutoDiesel
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.ModificarAgenteCxcPendiente]
Carpeta=Opciones
Clave=Usuario.ModificarAgenteCxcPendiente
Editar=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearNotasNegativas]
Carpeta=Opciones
Clave=Usuario.BloquearNotasNegativas
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearDineroCtaDinero]
Carpeta=Opciones
Clave=Usuario.BloquearDineroCtaDinero
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Otros.UsuarioCfg2.PlanEditarOrdenes]
Carpeta=Otros
Clave=UsuarioCfg2.PlanEditarOrdenes
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco

[Opciones.Usuario.ModificarAgente]
Carpeta=Opciones
Clave=Usuario.ModificarAgente
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco

Tamano=
ValidaNombre=S
ColorFuente=Negro
[Movs.Usuario.ModificarSerieLoteProp]
Carpeta=Movs
Clave=Usuario.ModificarSerieLoteProp
Editar=N
LineaNueva=S
3D=S
Tamano=70
ColorFondo=Blanco

[Otros.UsuarioCfg2.ContabilizarLote]
Carpeta=Otros
Clave=UsuarioCfg2.ContabilizarLote
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[Otros.UsuarioCfg2.TraspasarMovimientos]
Carpeta=Otros
Clave=UsuarioCfg2.TraspasarMovimientos
Editar=S
LineaNueva=S
3D=S
Tamano=80
ColorFondo=Blanco

[Movs.Usuario.NominaEliminacionParcial]
Carpeta=Movs
Clave=Usuario.NominaEliminacionParcial
Editar=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco

[Otros.UsuarioCfg2.ControlAlmacenesEnAlm]
Carpeta=Otros
Clave=UsuarioCfg2.ControlAlmacenesEnAlm
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Movs.Usuario.ConsultarOtrosMovsGrupo]
Carpeta=Movs
Clave=Usuario.ConsultarOtrosMovsGrupo
Editar=S
LineaNueva=S
3D=S
Tamano=31
ColorFondo=Blanco
EspacioPrevio=S

[Otros.UsuarioCfg2.BloquearAltaExpressPersonal]
Carpeta=Otros
Clave=UsuarioCfg2.BloquearAltaExpressPersonal
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Otros.UsuarioCfg2.CancelarEmbarquesExplorador]
Carpeta=Otros
Clave=UsuarioCfg2.CancelarEmbarquesExplorador
Editar=S
LineaNueva=S
3D=S
Tamano=35
ColorFondo=Blanco

[Consultas.Usuario.CtaDineroInfo]
Carpeta=Consultas
Clave=Usuario.CtaDineroInfo
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Otros.UsuarioCfg2.OcultarDineroCtaDineroSaldo]
Carpeta=Otros
Clave=UsuarioCfg2.OcultarDineroCtaDineroSaldo
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Default.Usuario.DefZonaImpuesto]
Carpeta=Default
Clave=Usuario.DefZonaImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Movs.Usuario.ModificarProyUENActCC]
Carpeta=Movs
Clave=Usuario.ModificarProyUENActCC
Editar=N
LineaNueva=S
3D=S
Tamano=80
ColorFondo=Blanco

[Default.Usuario.DefFormaPago]
Carpeta=Default
Clave=Usuario.DefFormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Opciones.Usuario.BloquearFormaPago]
Carpeta=Opciones
Clave=Usuario.BloquearFormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[PV]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Punto de Venta
Clave=PV
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
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

[PV.Usuario.PVAbrirCajonSiempre]
Carpeta=PV
Clave=Usuario.PVAbrirCajonSiempre
Editar=S
LineaNueva=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[PV.Usuario.PVBloquearEgresos]
Carpeta=PV
Clave=Usuario.PVBloquearEgresos
Editar=S
LineaNueva=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.ModificarPropiedadesLotes]
Carpeta=Opciones
Clave=Usuario.ModificarPropiedadesLotes
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ImporteMaximo]
Nombre=ImporteMaximo
Boton=64
NombreEnBoton=S
NombreDesplegar=Importe/Desc. &Máximo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=UsuarioMovImporteMaximo
Activo=S
Visible=S
EspacioPrevio=S

[Movs.Usuario.ProvMov]
Carpeta=Movs
Clave=Usuario.ProvMov
Editar=S
3D=S
Tamano=31
ColorFondo=Blanco

[Movs.Usuario.ArtMov]
Carpeta=Movs
Clave=Usuario.ArtMov
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[PV.Usuario.PVCobrarNotasEstatusBorrador]
Carpeta=PV
Clave=Usuario.PVCobrarNotasEstatusBorrador
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Opciones.Usuario.BloquearPersonalCfg]
Carpeta=Opciones
Clave=Usuario.BloquearPersonalCfg
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.ModificarMovsNominaVigentes]
Carpeta=Opciones
Clave=Usuario.ModificarMovsNominaVigentes
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=38
ColorFuente=Negro


[Movs.Usuario.BloquearFacturacionDirecta]
Carpeta=Movs
Clave=Usuario.BloquearFacturacionDirecta
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Acciones.ExcepcionesCancelación]
Nombre=ExcepcionesCancelación
Boton=30
NombreDesplegar=Excepciones Movimientos a Cancelar
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=UsuarioMovCancelacionEx
Visible=S
EspacioPrevio=S
ActivoCondicion=Usuario:Usuario.Cancelar

[Movs.Usuario.AutorizarCompra]
Carpeta=Movs
Clave=Usuario.AutorizarCompra
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Opciones.Usuario.ModificarDatosCliente]
Carpeta=Opciones
Clave=Usuario.ModificarDatosCliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.CxcExpress]
Carpeta=Movs
Clave=Usuario.CxcExpress
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco

[Movs.Usuario.CxpExpress]
Carpeta=Movs
Clave=Usuario.CxpExpress
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[PV.Usuario.PVModificarEstatusBorrador]
Carpeta=PV
Clave=Usuario.PVModificarEstatusBorrador
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Intelisis]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Intelisis
Clave=Intelisis
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
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
ListaEnCaptura=Usuario.SubModuloAtencion
PermiteEditar=S
CondicionVisible=General.Intelisis

[Intelisis.Usuario.SubModuloAtencion]
Carpeta=Intelisis
Clave=Usuario.SubModuloAtencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Consultas.Usuario.BloquearCostos]
Carpeta=Consultas
Clave=Usuario.BloquearCostos
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Default.Usuario.DefAlmacenTrans]
Carpeta=Default
Clave=Usuario.DefAlmacenTrans
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Otros.UsuarioCfg2.RecibirDemasSinLimites]
Carpeta=Otros
Clave=UsuarioCfg2.RecibirDemasSinLimites
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Otros.UsuarioCfg2.ModificarFactorMovTipo]
Carpeta=Otros
Clave=UsuarioCfg2.ModificarFactorMovTipo
Editar=S
3D=S
Tamano=35
ColorFondo=Blanco

[Opciones.Usuario.BloquearCancelarFactura]
Carpeta=Opciones
Clave=Usuario.BloquearCancelarFactura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Otros.UsuarioCfg2.BloquearListaMateriales]
Carpeta=Otros
Clave=UsuarioCfg2.BloquearListaMateriales
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Otros.UsuarioCfg2.VINTransferirComponentes]
Carpeta=Otros
Clave=UsuarioCfg2.VINTransferirComponentes
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Movs.Usuario.AutorizarSeriesLotes]
Carpeta=Movs
Clave=Usuario.AutorizarSeriesLotes
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Opciones.Usuario.CambioPresentacionExpress]
Carpeta=Opciones
Clave=Usuario.CambioPresentacionExpress
Editar=S
LineaNueva=N
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Otros.UsuarioCfg2.PedidoGenerarOTAbrir]
Carpeta=Otros
Clave=UsuarioCfg2.PedidoGenerarOTAbrir
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco

[Movs.Usuario.ModificarConsecutivos]
Carpeta=Movs
Clave=Usuario.ModificarConsecutivos
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco

[VIN]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=VIN
Clave=VIN
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CondicionVisible=Config.VIN

[VIN.Usuario.ModificarVINFechaBaja]
Carpeta=VIN
Clave=Usuario.ModificarVINFechaBaja
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[VIN.Usuario.ModificarVINAccesorio]
Carpeta=VIN
Clave=Usuario.ModificarVINAccesorio
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[VIN.Columnas]
ModificarVINFechaBaja=103
ModificarVINAccesorio=116

[VIN.Usuario.ModificarDatosVIN]
Carpeta=VIN
Clave=Usuario.ModificarDatosVIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[PV.Usuario.PVEditarNota]
Carpeta=PV
Clave=Usuario.PVEditarNota
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Opciones.Usuario.ModificarDescGlobalImporte]
Carpeta=Opciones
Clave=Usuario.ModificarDescGlobalImporte
Editar=S
3D=S
Tamano=38
ColorFondo=Blanco
ColorFuente=Negro

[VIN.Usuario.ModificarVINFechaPago]
Carpeta=VIN
Clave=Usuario.ModificarVINFechaPago
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Consultas.Usuario.ConsultarClientesOtrosAgentes]
Carpeta=Consultas
Clave=Usuario.ConsultarClientesOtrosAgentes
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[AC]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Administración Créditos
Clave=AC
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
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
CondicionVisible=General.AC

[AC.Usuario.ACLCUsoEspecifico]
Carpeta=AC
Clave=Usuario.ACLCUsoEspecifico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AC.Usuario.ACEditarTablaAmortizacion]
Carpeta=AC
Clave=Usuario.ACEditarTablaAmortizacion
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Movs.Usuario.CteArt]
Carpeta=Movs
Clave=Usuario.CteArt
Editar=S
LineaNueva=S
3D=S
Tamano=31
ColorFondo=Blanco

[Cambios.Usuario.CambioAutorizarOperacionLimite]
Carpeta=Cambios
Clave=Usuario.CambioAutorizarOperacionLimite
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.PlantillasOffice]
Carpeta=Opciones
Clave=Usuario.PlantillasOffice
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=
ColorFondo=Blanco

ValidaNombre=S
ColorFuente=Negro

[Opciones.Usuario.ConfigPlantillasOffice]
Carpeta=Opciones
Clave=Usuario.ConfigPlantillasOffice
Editar=S
LineaNueva=N
3D=S
Tamano=
ColorFondo=Blanco

ValidaNombre=S
ColorFuente=Negro
[AC.Usuario.ACTasaGrupo]
Carpeta=AC
Clave=Usuario.ACTasaGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cambios.Usuario.CambioAgregarBeneficiarios]
Carpeta=Cambios
Clave=Usuario.CambioAgregarBeneficiarios
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.AgregarConceptoExpress]
Carpeta=Opciones
Clave=Usuario.AgregarConceptoExpress
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearArtMaterial]
Carpeta=Opciones
Clave=Usuario.BloquearArtMaterial
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[InfoPath]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=InfoPath
Clave=InfoPath
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
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
CondicionVisible=General.InfoPath

[InfoPath.Usuario.InfoPath]
Carpeta=InfoPath
Clave=Usuario.InfoPath
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[InfoPath.Usuario.InfoPathExe]
Carpeta=InfoPath
Clave=Usuario.InfoPathExe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[FEA]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=FEA
Clave=FEA
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
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
CondicionVisible=General.FEA
CarpetaDesActivada=S

[FEA.Usuario.FEA]
Carpeta=FEA
Clave=Usuario.FEA
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=30

[FEA.Usuario.FEACertificado]
Carpeta=FEA
Clave=Usuario.FEACertificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[FEA.Usuario.FEALlave]
Carpeta=FEA
Clave=Usuario.FEALlave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.ContrasenaNuncaExpira]
Carpeta=Opciones
Clave=Usuario.ContrasenaNuncaExpira
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.AgregarProvExpress]
Carpeta=Opciones
Clave=Usuario.AgregarProvExpress
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearPDF]
Carpeta=Opciones
Clave=Usuario.BloquearPDF
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.UsuarioModuloEx]
Nombre=UsuarioModuloEx
Boton=30
NombreDesplegar=Excepciones a Nivel Módulo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=UsuarioModuloEx
Activo=S
Visible=S

[Opciones.Usuario.VerificarOrtografia]
Carpeta=Opciones
Clave=Usuario.VerificarOrtografia
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.ContSinOrigen]
Carpeta=Opciones
Clave=Usuario.ContSinOrigen
Editar=S
LineaNueva=N
3D=S
ColorFondo=Blanco
ValidaNombre=S
ColorFuente=Negro


[Default.Usuario.UnidadOrganizacional]
Carpeta=Default
Clave=Usuario.UnidadOrganizacional
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Default.aroUnidad.Nombre]
Carpeta=Default
Clave=aroUnidad.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata


[Otros.UsuarioCfg2.TransferirEntradas]
Carpeta=Otros
Clave=UsuarioCfg2.TransferirEntradas
Editar=S
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco

[Otros.UsuarioCfg2.LimitarDialogoAbrirGuardar]
Carpeta=Otros
Clave=UsuarioCfg2.LimitarDialogoAbrirGuardar
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Movs.Usuario.ProyMov]
Carpeta=Movs
Clave=Usuario.ProyMov
Editar=S
LineaNueva=S
3D=S
Tamano=31
ColorFondo=Blanco

[Movs.Usuario.CompraDevTodo]
Carpeta=Movs
Clave=Usuario.CompraDevTodo
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Web]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
Clave=Web
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
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
PestanaNombre=Web

[Web.Usuario.BloquearWebContenido]
Carpeta=Web
Clave=Usuario.BloquearWebContenido
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Web.Usuario.BloquearWebHTML]
Carpeta=Web
Clave=Usuario.BloquearWebHTML
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Default.Usuario.DBMailPerfil]
Carpeta=Default
Clave=Usuario.DBMailPerfil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Otros.UsuarioCfg2.ModificarEstatusCuotaCx]
Carpeta=Otros
Clave=UsuarioCfg2.ModificarEstatusCuotaCx
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Movs.Usuario.AutorizarGestion]
Carpeta=Movs
Clave=Usuario.AutorizarGestion
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Otros.UsuarioCfg2.ModificarGestionAgenda]
Carpeta=Otros
Clave=UsuarioCfg2.ModificarGestionAgenda
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=S

[Otros.UsuarioCfg2.AgendaAccesoOtrosModulos]
Carpeta=Otros
Clave=UsuarioCfg2.AgendaAccesoOtrosModulos
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=40

[Acciones.Historico]
Nombre=Historico
Boton=53
NombreDesplegar=Histórico de Cambios
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Caso   CarpetaActiva(<T>A1<T>)<BR>  Es <T>Default<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>  Es <T>Movs<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>  Es <T>Sucursales<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>  Es <T>Consultas<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>  Es <T>Opciones<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>  Es <T>InfoPath<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>  Es <T>Web<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>  Es <T>FEA<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>  Es <T>Otros<T> Entonces Asigna(Info.Tabla,<T>UsuarioCfg2<T>)<BR>  Es <T>VIN<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>  Es <T>Cambios<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>  Es <T>Auto<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>  Es <T>PV<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>  Es <T>AC<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>  Es <T>Intelisis<T> Entonces Asigna(Info.Tabla,<T>Usuario<T>)<BR>Fin<BR><BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(CarpetaActiva(<T>A1<T>), <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>RegHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
ConCondicion=S
EjecucionCondicion=ConDatos(Usuario:Usuario.Usuario)
Antes=S
AntesExpresiones=Asigna(Info.Nombre,Usuario:Usuario.Usuario & <T> <T> & Usuario:Usuario.Nombre )

[Detalle.Columnas]
CampoNombre=311
Valor=303
ValorAnterior=285

[Consultas.Usuario.InformacionConfidencial]
Carpeta=Consultas
Clave=Usuario.InformacionConfidencial
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Opciones.Usuario.BloquearSituacionUsuario]
Carpeta=Opciones
Clave=Usuario.BloquearSituacionUsuario
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro






























[Consultas.ListaEnCaptura]
(Inicio)=Usuario.CteInfo
Usuario.CteInfo=Usuario.VerInfoDeudores
Usuario.VerInfoDeudores=Usuario.VerInfoAcreedores
Usuario.VerInfoAcreedores=Usuario.CtaDineroInfo
Usuario.CtaDineroInfo=Usuario.AccesoTotalCuentas
Usuario.AccesoTotalCuentas=Usuario.InformacionConfidencial
Usuario.InformacionConfidencial=Usuario.Costos
Usuario.Costos=Usuario.ConsultarCompraPendiente
Usuario.ConsultarCompraPendiente=Usuario.BloquearCostos
Usuario.BloquearCostos=Usuario.ConsultarOtrasEmpresas
Usuario.ConsultarOtrasEmpresas=Usuario.ConsultarClientesOtrosAgentes
Usuario.ConsultarClientesOtrosAgentes=Usuario.VerComisionesPendientes
Usuario.VerComisionesPendientes=Usuario.CteBloquearOtrosDatos
Usuario.CteBloquearOtrosDatos=Usuario.ArtBloquearOtrosDatos
Usuario.ArtBloquearOtrosDatos=(Fin)
[Sucursales.ListaEnCaptura]
(Inicio)=Usuario.ModificarSucursalDestino
Usuario.ModificarSucursalDestino=Usuario.ConsultarOtrasSucursales
Usuario.ConsultarOtrasSucursales=Usuario.AfectarOtrasSucursalesEnLinea
Usuario.AfectarOtrasSucursalesEnLinea=Usuario.AccesarOtrasSucursalesEnLinea
Usuario.AccesarOtrasSucursalesEnLinea=(Fin)
[Cambios.ListaEnCaptura]
(Inicio)=Usuario.CambioValidarCobertura
Usuario.CambioValidarCobertura=Usuario.CambioEditarCobertura
Usuario.CambioEditarCobertura=Usuario.CambioNormatividad
Usuario.CambioNormatividad=Usuario.CambioVerPosicionEmpresa
Usuario.CambioVerPosicionEmpresa=Usuario.CambioVerPosicionSucursal
Usuario.CambioVerPosicionSucursal=Usuario.CambioVerPosicionOtraSucursal
Usuario.CambioVerPosicionOtraSucursal=Usuario.CambioAutorizarOperacionLimite
Usuario.CambioAutorizarOperacionLimite=Usuario.CambioAgregarBeneficiarios
Usuario.CambioAgregarBeneficiarios=(Fin)
[Auto.ListaEnCaptura]
(Inicio)=Usuario.AutoArtGrupo
Usuario.AutoArtGrupo=Usuario.AutoDobleCapturaPrecios
Usuario.AutoDobleCapturaPrecios=Usuario.AutoAgregarRecaudacionConsumo
Usuario.AutoAgregarRecaudacionConsumo=Usuario.AutoDiesel
Usuario.AutoDiesel=(Fin)
[PV.ListaEnCaptura]
(Inicio)=Usuario.PVAbrirCajonSiempre
Usuario.PVAbrirCajonSiempre=Usuario.PVBloquearEgresos
Usuario.PVBloquearEgresos=Usuario.PVEditarNota
Usuario.PVEditarNota=Usuario.PVModificarEstatusBorrador
Usuario.PVModificarEstatusBorrador=Usuario.PVCobrarNotasEstatusBorrador
Usuario.PVCobrarNotasEstatusBorrador=(Fin)
[VIN.ListaEnCaptura]
(Inicio)=Usuario.ModificarVINFechaBaja
Usuario.ModificarVINFechaBaja=Usuario.ModificarVINFechaPago
Usuario.ModificarVINFechaPago=Usuario.ModificarVINAccesorio
Usuario.ModificarVINAccesorio=Usuario.ModificarDatosVIN
Usuario.ModificarDatosVIN=(Fin)
[AC.ListaEnCaptura]
(Inicio)=Usuario.ACLCUsoEspecifico
Usuario.ACLCUsoEspecifico=Usuario.ACEditarTablaAmortizacion
Usuario.ACEditarTablaAmortizacion=Usuario.ACTasaGrupo
Usuario.ACTasaGrupo=(Fin)
[InfoPath.ListaEnCaptura]
(Inicio)=Usuario.InfoPath
Usuario.InfoPath=Usuario.InfoPathExe
Usuario.InfoPathExe=(Fin)
[FEA.ListaEnCaptura]
(Inicio)=Usuario.FEA
Usuario.FEA=Usuario.FEACertificado
Usuario.FEACertificado=Usuario.FEALlave
Usuario.FEALlave=(Fin)
[Web.ListaEnCaptura]
(Inicio)=Usuario.BloquearWebContenido
Usuario.BloquearWebContenido=Usuario.BloquearWebHTML
Usuario.BloquearWebHTML=(Fin)
[Movs.Usuario.BloquearInvSalidaDirecta]
Carpeta=Movs
Clave=Usuario.BloquearInvSalidaDirecta
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
[Generales]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Generales
Clave=Generales
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
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
[Generales.Usuario.ModificarSituacion]
Carpeta=Generales
Clave=Usuario.ModificarSituacion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=16
[Generales.Usuario.SituacionArea]
Carpeta=Generales
Clave=Usuario.SituacionArea
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
Pegado=S
[Generales.ListaEnCaptura]
(Inicio)=Usuario.ModificarSituacion
Usuario.ModificarSituacion=Usuario.SituacionArea
Usuario.SituacionArea=(Fin)

[Otros.UsuarioCfg2.ModificarAsisteExtra]
Carpeta=Otros
Clave=UsuarioCfg2.ModificarAsisteExtra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=50
ColorFondo=Blanco
[Otros.UsuarioCfg2.ModificarAsisteMovimientoRef]
Carpeta=Otros
Clave=UsuarioCfg2.ModificarAsisteMovimientoRef
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Otros.UsuarioCfg2.ModificarAsisteGestionRef]
Carpeta=Otros
Clave=UsuarioCfg2.ModificarAsisteGestionRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
[Otros.UsuarioCfg2.ModificarAsisteActividadABCRef]
Carpeta=Otros
Clave=UsuarioCfg2.ModificarAsisteActividadABCRef
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
[Movs.Usuario.ModificarTipoImpuesto]
Carpeta=Movs
Clave=Usuario.ModificarTipoImpuesto
Editar=S
3D=S
Tamano=31
ColorFondo=Blanco
LineaNueva=S


[SincroIS]
Estilo=Ficha
Pestana=S
Clave=SincroIS
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioCfg2
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
PestanaOtroNombre=S
PestanaNombre=Sincro IS
ListaEnCaptura=UsuarioCfg2.SincroISNotificarError
CondicionVisible=SI(SQL(<T>IF EXISTS(SELECT * FROM Version WHERE SincroIS = 1) SELECT 1 ELSE SELECT 0<T>)=1,VERDADERO,FALSO)


[MES]
Estilo=Ficha
Pestana=S
Clave=MES
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
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
PestanaOtroNombre=S
PestanaNombre=Accesos MES


[MES.Usuario.MESAcceso]
Carpeta=MES
Clave=Usuario.MESAcceso
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[MES.Usuario.MESEstructura]
Carpeta=MES
Clave=Usuario.MESEstructura
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[MES.Usuario.MESPlanificacion]
Carpeta=MES
Clave=Usuario.MESPlanificacion
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[MES.Usuario.MESVariantes]
Carpeta=MES
Clave=Usuario.MESVariantes
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[MES.Usuario.MESScheduling]
Carpeta=MES
Clave=Usuario.MESScheduling
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco


[SincroIS.UsuarioCfg2.SincroISNotificarError]
Carpeta=SincroIS
Clave=UsuarioCfg2.SincroISNotificarError
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[Opciones.ListaEnCaptura]
(Inicio)=Usuario.ModificarVencimientos
Usuario.ModificarVencimientos=Usuario.ModificarEntregas
Usuario.ModificarEntregas=Usuario.ModificarFechaRequerida
Usuario.ModificarFechaRequerida=Usuario.ModificarAgente
Usuario.ModificarAgente=Usuario.ModificarAgenteCxcPendiente
Usuario.ModificarAgenteCxcPendiente=Usuario.ModificarDescGlobalImporte
Usuario.ModificarDescGlobalImporte=Usuario.ModificarEnvios
Usuario.ModificarEnvios=Usuario.ModificarReferencias
Usuario.ModificarReferencias=Usuario.ModificarMovsNominaVigentes
Usuario.ModificarMovsNominaVigentes=Usuario.ModificarAlmacenEntregas
Usuario.ModificarAlmacenEntregas=Usuario.ModificarAlmacenPedidos
Usuario.ModificarAlmacenPedidos=Usuario.ModificarPropiedadesLotes
Usuario.ModificarPropiedadesLotes=Usuario.AgregarCteExpress
Usuario.AgregarCteExpress=Usuario.AgregarArtExpress
Usuario.AgregarArtExpress=Usuario.AgregarConceptoExpress
Usuario.AgregarConceptoExpress=Usuario.AgregarProvExpress
Usuario.AgregarProvExpress=Usuario.ContSinOrigen
Usuario.ContSinOrigen=Usuario.ModificarDatosCliente
Usuario.ModificarDatosCliente=Usuario.CteSucursalVenta
Usuario.CteSucursalVenta=Usuario.CambioPresentacionExpress
Usuario.CambioPresentacionExpress=Usuario.BloquearCxcCtaDinero
Usuario.BloquearCxcCtaDinero=Usuario.BloquearCxpCtaDinero
Usuario.BloquearCxpCtaDinero=Usuario.BloquearDineroCtaDinero
Usuario.BloquearDineroCtaDinero=Usuario.BloquearCondiciones
Usuario.BloquearCondiciones=Usuario.BloquearFechaEmision
Usuario.BloquearFechaEmision=Usuario.BloquearPDF
Usuario.BloquearPDF=Usuario.BloquearMoneda
Usuario.BloquearMoneda=Usuario.BloquearAlmacen
Usuario.BloquearAlmacen=Usuario.BloquearTipoCambio
Usuario.BloquearTipoCambio=Usuario.BloquearAgente
Usuario.BloquearAgente=Usuario.BloquearProyecto
Usuario.BloquearProyecto=Usuario.BloquearActividad
Usuario.BloquearActividad=Usuario.BloquearContUso
Usuario.BloquearContUso=Usuario.BloquearFormaPago
Usuario.BloquearFormaPago=Usuario.BloquearPersonalCfg
Usuario.BloquearPersonalCfg=Usuario.BloquearCancelarFactura
Usuario.BloquearCancelarFactura=Usuario.BloquearArtMaterial
Usuario.BloquearArtMaterial=Usuario.BloquearPrecios
Usuario.BloquearPrecios=Usuario.AsistentePrecios
Usuario.AsistentePrecios=Usuario.BloquearEncabezadoVenta
Usuario.BloquearEncabezadoVenta=Usuario.BloquearDescGlobal
Usuario.BloquearDescGlobal=Usuario.BloquearDescLinea
Usuario.BloquearDescLinea=Usuario.BloquearNotasNegativas
Usuario.BloquearNotasNegativas=Usuario.BloquearCobroInmediato
Usuario.BloquearCobroInmediato=Usuario.BloquearSituacionUsuario
Usuario.BloquearSituacionUsuario=Usuario.PlantillasOffice
Usuario.PlantillasOffice=Usuario.ConfigPlantillasOffice
Usuario.ConfigPlantillasOffice=Usuario.VerificarOrtografia
Usuario.VerificarOrtografia=Usuario.AbrirCajon
Usuario.AbrirCajon=Usuario.ContrasenaNuncaExpira
Usuario.ContrasenaNuncaExpira=(Fin)

[Opciones.Usuario.BloquearTipoCambio]
Carpeta=Opciones
Clave=Usuario.BloquearTipoCambio
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Default.Usuario.Personal]
Carpeta=Default
Clave=Usuario.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Otros.UsuarioCfg2.NotificacionAlAcceso]
Carpeta=Otros
Clave=UsuarioCfg2.NotificacionAlAcceso
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco









[Movs.Usuario.AfectarCORTE]
Carpeta=Movs
Clave=Usuario.AfectarCORTE
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco












ValidaNombre=N
[Acciones.UsuarioPlantaAcceso]
Nombre=UsuarioPlantaAcceso
Boton=87
NombreEnBoton=S
NombreDesplegar=Plantas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=UsuarioPlantaAcceso
Activo=S
Visible=S






[Movs.Usuario.ModificarPosicionSugeridaWMS]
Carpeta=Movs
Clave=Usuario.ModificarPosicionSugeridaWMS
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=31
ColorFondo=Blanco

[Movs.Usuario.ModificarAgenteWMS]
Carpeta=Movs
Clave=Usuario.ModificarAgenteWMS
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=30
ColorFondo=Blanco










[FiscalAvanzado.ListaEnCaptura]
(Inicio)=UsuarioCfg2.InterfazExentus
UsuarioCfg2.InterfazExentus=UsuarioCfg2.AccesoInterfazExentus
UsuarioCfg2.AccesoInterfazExentus=(Fin)

[MFA]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Módulo Fiscal Avanzado
Clave=MFA
PermiteEditar=S

AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioCfg2
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=250

FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


CondicionVisible=General.InterfazExentus
[MFA.UsuarioCfg2.InterfazExentus]
Carpeta=MFA
Clave=UsuarioCfg2.InterfazExentus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MFA.UsuarioCfg2.AccesoInterfazExentus]
Carpeta=MFA
Clave=UsuarioCfg2.AccesoInterfazExentus

Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

ColorFondo=Blanco


[Otros.UsuarioCfg2.eCommerce]
Carpeta=Otros
Clave=UsuarioCfg2.eCommerce
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Otros.UsuarioCfg2.eCommerceMostrarHerramienta]
Carpeta=Otros
Clave=UsuarioCfg2.eCommerceMostrarHerramienta
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco















[Otros.ListaEnCaptura]
(Inicio)=UsuarioCfg2.CxcMovExpress
UsuarioCfg2.CxcMovExpress=UsuarioCfg2.CxpMovExpress
UsuarioCfg2.CxpMovExpress=UsuarioCfg2.ModificarClienteBackOrder
UsuarioCfg2.ModificarClienteBackOrder=UsuarioCfg2.PedidoGenerarOT
UsuarioCfg2.PedidoGenerarOT=UsuarioCfg2.PedidoGenerarOTAbrir
UsuarioCfg2.PedidoGenerarOTAbrir=UsuarioCfg2.CancelarEmbarquesExplorador
UsuarioCfg2.CancelarEmbarquesExplorador=UsuarioCfg2.ModificarFactorMovTipo
UsuarioCfg2.ModificarFactorMovTipo=UsuarioCfg2.AfectarLote
UsuarioCfg2.AfectarLote=UsuarioCfg2.CancelarLote
UsuarioCfg2.CancelarLote=UsuarioCfg2.ContabilizarLote
UsuarioCfg2.ContabilizarLote=UsuarioCfg2.BloquearMonedaArtPrecio
UsuarioCfg2.BloquearMonedaArtPrecio=UsuarioCfg2.BloquearMonedaArtCosto
UsuarioCfg2.BloquearMonedaArtCosto=UsuarioCfg2.BloquearListaMateriales
UsuarioCfg2.BloquearListaMateriales=UsuarioCfg2.ModificarObservaciones
UsuarioCfg2.ModificarObservaciones=UsuarioCfg2.ModificarAnexosMovConcluidos
UsuarioCfg2.ModificarAnexosMovConcluidos=UsuarioCfg2.BloquearMaestrosPersonal
UsuarioCfg2.BloquearMaestrosPersonal=UsuarioCfg2.BloquearAltaExpressPersonal
UsuarioCfg2.BloquearAltaExpressPersonal=UsuarioCfg2.VINTransferirComponentes
UsuarioCfg2.VINTransferirComponentes=UsuarioCfg2.ControlAlmacenes
UsuarioCfg2.ControlAlmacenes=UsuarioCfg2.ControlAlmacenesEnAlm
UsuarioCfg2.ControlAlmacenesEnAlm=UsuarioCfg2.ControlListasPrecios
UsuarioCfg2.ControlListasPrecios=UsuarioCfg2.LimitarCompraLocal
UsuarioCfg2.LimitarCompraLocal=UsuarioCfg2.VentaSugerirDisponible
UsuarioCfg2.VentaSugerirDisponible=UsuarioCfg2.CompraSugerirDisponible
UsuarioCfg2.CompraSugerirDisponible=UsuarioCfg2.InvFisicoAlmacen
UsuarioCfg2.InvFisicoAlmacen=UsuarioCfg2.GastoModificarProrrateo
UsuarioCfg2.GastoModificarProrrateo=UsuarioCfg2.GastosPV
UsuarioCfg2.GastosPV=UsuarioCfg2.GastosEditarDeducible
UsuarioCfg2.GastosEditarDeducible=UsuarioCfg2.PlanEditarOrdenes
UsuarioCfg2.PlanEditarOrdenes=UsuarioCfg2.CompraGenerarOrdenesAlProcesar
UsuarioCfg2.CompraGenerarOrdenesAlProcesar=UsuarioCfg2.TraspasarMovimientos
UsuarioCfg2.TraspasarMovimientos=UsuarioCfg2.OcultarDineroCtaDineroSaldo
UsuarioCfg2.OcultarDineroCtaDineroSaldo=UsuarioCfg2.ModificarEstatusCuotaCx
UsuarioCfg2.ModificarEstatusCuotaCx=UsuarioCfg2.RecibirDemasSinLimites
UsuarioCfg2.RecibirDemasSinLimites=UsuarioCfg2.TransferirEntradas
UsuarioCfg2.TransferirEntradas=UsuarioCfg2.ModificarGestionAgenda
UsuarioCfg2.ModificarGestionAgenda=UsuarioCfg2.AgendaAccesoOtrosModulos
UsuarioCfg2.AgendaAccesoOtrosModulos=UsuarioCfg2.Digitalizar
UsuarioCfg2.Digitalizar=UsuarioCfg2.LimitarDialogoAbrirGuardar
UsuarioCfg2.LimitarDialogoAbrirGuardar=UsuarioCfg2.ModificarAsisteExtra
UsuarioCfg2.ModificarAsisteExtra=UsuarioCfg2.ModificarAsisteMovimientoRef
UsuarioCfg2.ModificarAsisteMovimientoRef=UsuarioCfg2.ModificarAsisteGestionRef
UsuarioCfg2.ModificarAsisteGestionRef=UsuarioCfg2.ModificarAsisteActividadABCRef
UsuarioCfg2.ModificarAsisteActividadABCRef=UsuarioCfg2.NotificacionAlAcceso
UsuarioCfg2.NotificacionAlAcceso=UsuarioCfg2.eCommerce
UsuarioCfg2.eCommerce=UsuarioCfg2.eCommerceMostrarHerramienta
UsuarioCfg2.eCommerceMostrarHerramienta=(Fin)







































[Default.ListaEnCaptura]
(Inicio)=Usuario.DefProyecto
Usuario.DefProyecto=Usuario.DefLocalidad
Usuario.DefLocalidad=Usuario.DefMoneda
Usuario.DefMoneda=Usuario.DefAlmacen
Usuario.DefAlmacen=Usuario.DefAlmacenTrans
Usuario.DefAlmacenTrans=Usuario.DefCtaDinero
Usuario.DefCtaDinero=Usuario.DefCtaDineroTrans
Usuario.DefCtaDineroTrans=Usuario.DefAgente
Usuario.DefAgente=Usuario.DefCajero
Usuario.DefCajero=Usuario.DefFormaPago
Usuario.DefFormaPago=Usuario.DefCliente
Usuario.DefCliente=Usuario.Personal
Usuario.Personal=Usuario.DefListaPreciosEsp
Usuario.DefListaPreciosEsp=Usuario.DefActividad
Usuario.DefActividad=Usuario.DefZonaImpuesto
Usuario.DefZonaImpuesto=Usuario.DefContUso
Usuario.DefContUso=CentroCostos.Descripcion
CentroCostos.Descripcion=Usuario.UEN
Usuario.UEN=UEN.Nombre
UEN.Nombre=Usuario.UnidadOrganizacional
Usuario.UnidadOrganizacional=aroUnidad.Nombre
aroUnidad.Nombre=Usuario.DefArtTipo
Usuario.DefArtTipo=Usuario.DefUnidad
Usuario.DefUnidad=Usuario.DefMovVentas
Usuario.DefMovVentas=Usuario.DBMailPerfil
Usuario.DBMailPerfil=Usuario.OPORTPlantilla
Usuario.OPORTPlantilla=(Fin)

[Default.Usuario.OPORTPlantilla]
Carpeta=Default
Clave=Usuario.OPORTPlantilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





















































































[CONTP]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Contabilidad Paralela
Clave=CONTP
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioCfg2
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
ListaEnCaptura=UsuarioCfg2.CONTPModificarDatosMov
CondicionVisible=fnContParalela

[CONTP.UsuarioCfg2.CONTPModificarDatosMov]
Carpeta=CONTP
Clave=UsuarioCfg2.CONTPModificarDatosMov
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco





[MFA.ListaEnCaptura]
(Inicio)=UsuarioCfg2.InterfazExentus
UsuarioCfg2.InterfazExentus=UsuarioCfg2.AccesoInterfazExentus
UsuarioCfg2.AccesoInterfazExentus=(Fin)




[Movs.Usuario.AutorizaAltaTarima]
Carpeta=Movs
Clave=Usuario.AutorizaAltaTarima
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=30









[MES.ListaEnCaptura]
(Inicio)=Usuario.MESAcceso
Usuario.MESAcceso=Usuario.MESEstructura
Usuario.MESEstructura=Usuario.MESPlanificacion
Usuario.MESPlanificacion=Usuario.MESVariantes
Usuario.MESVariantes=Usuario.MESScheduling
Usuario.MESScheduling=(Fin)












[Movs.Usuario.vic_VerPlanoGramaDiseno]
Carpeta=Movs
Clave=Usuario.vic_VerPlanoGramaDiseno
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco

Tamano=31
[Movs.Usuario.vic_CopiarAccionesPlanoGrama]
Carpeta=Movs
Clave=Usuario.vic_CopiarAccionesPlanoGrama
Editar=S
3D=S
ColorFondo=Blanco

Tamano=30
[Movs.Usuario.vic_VerPlanoGramaProduccion]
Carpeta=Movs
Clave=Usuario.vic_VerPlanoGramaProduccion
Editar=S
3D=S
ColorFondo=Blanco

Tamano=30
[Movs.Usuario.vic_ActualizarPlanoGrama]
Carpeta=Movs
Clave=Usuario.vic_ActualizarPlanoGrama
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco

Tamano=31
[Movs.Usuario.vic_AccionesPlanoGrama]
Carpeta=Movs
Clave=Usuario.vic_AccionesPlanoGrama
Editar=S
3D=S
ColorFondo=Blanco

Tamano=30
[Movs.Usuario.vic_EliminarPlanoGrama]
Carpeta=Movs
Clave=Usuario.vic_EliminarPlanoGrama
Editar=S
3D=S
ColorFondo=Blanco



Tamano=30


[Movs.ListaEnCaptura]
(Inicio)=Usuario.Afectar
Usuario.Afectar=Usuario.Cancelar
Usuario.Cancelar=Usuario.Desafectar
Usuario.Desafectar=Usuario.AfectarCORTE
Usuario.AfectarCORTE=Usuario.Reservar
Usuario.Reservar=Usuario.DesReservar
Usuario.DesReservar=Usuario.Asignar
Usuario.Asignar=Usuario.DesAsignar
Usuario.DesAsignar=Usuario.ImprimirMovs
Usuario.ImprimirMovs=Usuario.PreliminarMovs
Usuario.PreliminarMovs=Usuario.ImpresionInmediata
Usuario.ImpresionInmediata=Usuario.EnviarExcel
Usuario.EnviarExcel=Usuario.MostrarCampos
Usuario.MostrarCampos=Usuario.ModificarAgente
Usuario.ModificarAgente=Usuario.ModificarUsuario
Usuario.ModificarUsuario=Usuario.ModificarConsecutivos
Usuario.ModificarConsecutivos=Usuario.ModificarConceptos
Usuario.ModificarConceptos=Usuario.ModificarReferenciasSiempre
Usuario.ModificarReferenciasSiempre=Usuario.ModificarSerieLoteProp
Usuario.ModificarSerieLoteProp=Usuario.ModificarProyUENActCC
Usuario.ModificarProyUENActCC=Usuario.ConsultarOtrosMovsGrupo
Usuario.ConsultarOtrosMovsGrupo=Usuario.ConsultarOtrosMovs
Usuario.ConsultarOtrosMovs=Usuario.ModificarOtrosMovs
Usuario.ModificarOtrosMovs=Usuario.AfectarOtrosMovs
Usuario.AfectarOtrosMovs=Usuario.CancelarOtrosMovs
Usuario.CancelarOtrosMovs=Usuario.ModificarListaPrecios
Usuario.ModificarListaPrecios=Usuario.ModificarZonaImpuesto
Usuario.ModificarZonaImpuesto=Usuario.BloquearFacturacionDirecta
Usuario.BloquearFacturacionDirecta=Usuario.Refacturar
Usuario.Refacturar=Usuario.NominaEliminacionParcial
Usuario.NominaEliminacionParcial=Usuario.BloquearInvSalidaDirecta
Usuario.BloquearInvSalidaDirecta=Usuario.TraspasarTodo
Usuario.TraspasarTodo=Usuario.CompraDevTodo
Usuario.CompraDevTodo=Usuario.Autorizar
Usuario.Autorizar=Usuario.AutorizarVenta
Usuario.AutorizarVenta=Usuario.AutorizarCompra
Usuario.AutorizarCompra=Usuario.AutorizarCxp
Usuario.AutorizarCxp=Usuario.AutorizarGasto
Usuario.AutorizarGasto=Usuario.AutorizarGestion
Usuario.AutorizarGestion=Usuario.AutorizarDinero
Usuario.AutorizarDinero=Usuario.AutorizarPV
Usuario.AutorizarPV=Usuario.AutorizarSeriesLotes
Usuario.AutorizarSeriesLotes=Usuario.CteMov
Usuario.CteMov=Usuario.ArtMov
Usuario.ArtMov=Usuario.ProvMov
Usuario.ProvMov=Usuario.ProyMov
Usuario.ProyMov=Usuario.CteArt
Usuario.CteArt=Usuario.CxcExpress
Usuario.CxcExpress=Usuario.CxpExpress
Usuario.CxpExpress=Usuario.ModificarTipoImpuesto
Usuario.ModificarTipoImpuesto=Usuario.ModificarPosicionSugeridaWMS
Usuario.ModificarPosicionSugeridaWMS=Usuario.ModificarAgenteWMS
Usuario.ModificarAgenteWMS=Usuario.AutorizaAltaTarima
Usuario.AutorizaAltaTarima=Usuario.vic_VerPlanoGramaDiseno
Usuario.vic_VerPlanoGramaDiseno=Usuario.vic_CopiarAccionesPlanoGrama
Usuario.vic_CopiarAccionesPlanoGrama=Usuario.vic_VerPlanoGramaProduccion
Usuario.vic_VerPlanoGramaProduccion=Usuario.vic_ActualizarPlanoGrama
Usuario.vic_ActualizarPlanoGrama=Usuario.vic_AccionesPlanoGrama
Usuario.vic_AccionesPlanoGrama=Usuario.vic_EliminarPlanoGrama
Usuario.vic_EliminarPlanoGrama=(Fin)

















[Forma.ListaCarpetas]
(Inicio)=Default
Default=Movs
Movs=Sucursales
Sucursales=Consultas
Consultas=Opciones
Opciones=Generales
Generales=InfoPath
InfoPath=Web
Web=FEA
FEA=Otros
Otros=VIN
VIN=Cambios
Cambios=Auto
Auto=PV
PV=AC
AC=Intelisis
Intelisis=SincroIS
SincroIS=MES
MES=MFA
MFA=CONTP
CONTP=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Almacenes
Almacenes=Precios
Precios=UsuarioSucursalAcceso
UsuarioSucursalAcceso=UsuarioPlantaAcceso
UsuarioPlantaAcceso=ExcepcionesCancelación
ExcepcionesCancelación=UsuarioModuloEx
UsuarioModuloEx=ImporteMaximo
ImporteMaximo=Historico
Historico=(Fin)
