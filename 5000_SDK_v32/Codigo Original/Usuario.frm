[Forma]
Clave=Usuario
Nombre=Usuarios
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=374
PosicionInicialArriba=67
PosicionInicialAltura=405
PosicionInicialAncho=618
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
VentanaBloquearAjuste=N
Menus=S
BarraAyuda=S
DialogoAbrir=S
Plantillas=S
PermiteCopiarDoc=S
PlantillasExcepciones=(Lista)
PosicionInicialAlturaCliente=535
PosicionSec1=238

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
Nombre=304
GrupoTrabajo=143
Fecha=148
Sucursal=64
Nombre_1=154
Empresa=69

0=91
1=267
[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Usuario
Clave=Detalle
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
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Detalle.Usuario.Usuario]
Carpeta=Detalle
Clave=Usuario.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Usuario.Nombre]
Carpeta=Detalle
Clave=Usuario.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Detalle.Usuario.GrupoTrabajo]
Carpeta=Detalle
Clave=Usuario.GrupoTrabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Detalle.Usuario.Contrasena]
Carpeta=Detalle
Clave=Usuario.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

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

[Detalle.Usuario.Extencion]
Carpeta=Detalle
Clave=Usuario.Extencion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S
Menu=&Archivo
EnMenu=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+N

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
Menu=&Archivo
EnMenu=S
EspacioPrevio=S

ActivoCondicion=no Usuario:Usuario.TieneMovimientos
Antes=S
AntesExpresiones=Asigna(Info.Cuenta,Usuario:Usuario.Usuario)<BR>EjecutarSQL(<T>spMESCatalogos :tCatalogo, :tINTCuenta, :nEliminar<T>,<T>UsuarioMES<T>,Info.Cuenta,1)
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

[Acciones.Empresas]
Nombre=Empresas
Boton=47
NombreEnBoton=S
NombreDesplegar=Acceso &Empresas
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=UsuarioD
Activo=S
Antes=S
Visible=S
Menu=&Edición
EnMenu=S
UsaTeclaRapida=S
TeclaRapida=Alt+F7
AntesExpresiones=Asigna(Info.Usuario, Usuario:Usuario.Usuario)<BR>Asigna(Info.Descripcion, Usuario:Usuario.Nombre)

[Detalle.Usuario.Estatus]
Carpeta=Detalle
Clave=Usuario.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

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

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
TipoAccion=Formas
ClaveAccion=Prop
Activo=S
Antes=S
Visible=S
GuardarAntes=S
EspacioPrevio=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F11
EnMenu=S
ConCondicion=S
EjecucionCondicion=ConDatos(Usuario:Usuario.Usuario)
AntesExpresiones=Asigna(Info.Rama, <T>USR<T>)<BR>Asigna(Info.Cuenta, Usuario:Usuario.Usuario)<BR>Asigna(Info.Descripcion, Usuario:Usuario.Nombre)

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
ConCondicion=S
EjecucionConError=S

Multiple=S
ListaAccionesMultiples=(Lista)
EjecucionCondicion=Si<BR>  ContrasenaCorrecta(Usuario:Usuario.Contrasena, Usuario:Usuario.ContrasenaConfirmacion)<BR>Entonces<BR>  Si<BR>    Longitud(Usuario:Usuario.Contrasena)<32<BR>  Entonces<BR>    Asigna(Usuario:Usuario.Contrasena, MD5(Usuario:Usuario.Contrasena, <T>p<T>))<BR>    Asigna(Usuario:Usuario.ContrasenaConfirmacion, MD5(Usuario:Usuario.ContrasenaConfirmacion, <T>p<T>))<BR>  Fin<BR>  Verdadero<BR>Sino<BR>  Falso<BR>Fin
EjecucionMensaje=ContrasenaValidaError
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
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Rama, <T>USR<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, Usuario:Usuario.Usuario)<BR>Asigna(Info.Descripcion, Usuario:Usuario.Nombre)
RefrescarDespues=S

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

[Detalle.Usuario.Oficina]
Carpeta=Detalle
Clave=Usuario.Oficina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[Movs.Usuario.ModificarConceptos]
Carpeta=Movs
Clave=Usuario.ModificarConceptos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Configuracion]
Nombre=Configuracion
Boton=35
Menu=&Edición
NombreDesplegar=&Configuración
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=UsuarioCfg
ConCondicion=S
Visible=S
EnBarraHerramientas=S
NombreEnBoton=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=F7
EspacioPrevio=S

RefrescarDespues=S
ActivoCondicion=Vacio(Usuario:Usuario.Configuracion)
EjecucionCondicion=ConDatos(Usuario:Usuario.Usuario)
AntesExpresiones=Asigna(Info.Usuario, Usuario:Usuario.Usuario)<BR>Asigna(Info.Nombre, Usuario:Usuario.Nombre)
[Detalle.Usuario.Configuracion]
Carpeta=Detalle
Clave=Usuario.Configuracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Detalle.UsuarioCopia.Nombre]
Carpeta=Detalle
Clave=UsuarioCopia.Nombre
3D=S
Tamano=20
ColorFondo=Plata
ValidaNombre=S

[Detalle.UsuarioCopia.GrupoTrabajo]
Carpeta=Detalle
Clave=UsuarioCopia.GrupoTrabajo
3D=S
Tamano=20
ColorFondo=Plata
ValidaNombre=S
LineaNueva=N

[Detalle.Usuario.ContrasenaConfirmacion]
Carpeta=Detalle
Clave=Usuario.ContrasenaConfirmacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.GrupoTrabajo]
Nombre=GrupoTrabajo
Boton=0
Menu=&Maestros
NombreDesplegar=&Grupos Trabajo
EnMenu=S
TipoAccion=Formas
ClaveAccion=GrupoTrabajo
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
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=98
1=378
2=-2

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

[(Carpeta Abrir).Sucursal.Sucursal]
Carpeta=(Carpeta Abrir)
Clave=Sucursal.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Usuario.Sucursal]
Carpeta=Detalle
Clave=Usuario.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Sucursal.Nombre]
Carpeta=Detalle
Clave=Sucursal.Nombre
Editar=S
3D=S
Tamano=41
ColorFondo=Plata
ValidaNombre=S

[Detalle.Usuario.Acceso]
Carpeta=Detalle
Clave=Usuario.Acceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.UsuarioDestino.Nombre]
Carpeta=Detalle
Clave=UsuarioDestino.Nombre
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Detalle.UsuarioDestino.GrupoTrabajo]
Carpeta=Detalle
Clave=UsuarioDestino.GrupoTrabajo
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Detalle.Usuario.eMail]
Carpeta=Detalle
Clave=Usuario.eMail
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Usuario.Observaciones]
Carpeta=Detalle
Clave=Usuario.Observaciones
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Detalle.Usuario.Departamento]
Carpeta=Detalle
Clave=Usuario.Departamento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.Usuario.Idioma]
Carpeta=Detalle
Clave=Usuario.Idioma
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S

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

[Acciones.Mensajes]
Nombre=Mensajes
Boton=112
NombreDesplegar=&Mensajes
EnMenu=S
TipoAccion=Formas
ClaveAccion=OutlookUsuario
Activo=S
ConCondicion=S
Antes=S
Visible=S
Menu=&Ver
EspacioPrevio=S
EjecucionCondicion=ConDatos(Usuario:Usuario.Usuario)
AntesExpresiones=Asigna(Info.Usuario, Usuario:Usuario.Usuario)

[Acciones.Impresoras]
Nombre=Impresoras
Boton=4
Menu=&Edición
NombreDesplegar=&Impresoras del Usuario
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=UsuarioImpresora
Activo=S
Visible=S
Antes=S
ConCondicion=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
EspacioPrevio=S
EjecucionCondicion=ConDatos(Usuario:Usuario.Usuario)
AntesExpresiones=Asigna(Info.Usuario, Usuario:Usuario.Usuario)

[Detalle.Usuario.Menu]
Carpeta=Detalle
Clave=Usuario.Menu
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Acciones.Historico]
Nombre=Historico
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+H
NombreDesplegar=Histórico de Cambios
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(Info.Tabla, <T>Usuario<T>)<BR>Asigna(Info.Llave, Carpeta.LlavePrimaria(<T>Ficha<T>, <T>|<T>))<BR>Si<BR> SQL(<T>SELECT RegHist FROM Version<T>) y (SQL(<T>SELECT Estatus FROM CfgRegHist WHERE SysTabla=:tTabla<T>, Info.Tabla)=EstatusActivo)<BR>Entonces<BR> Forma(<T>RegHist<T>)<BR>Sino<BR> Informacion(<T>Es necesario activar la opción Registro Cambios Históricos (Automático) en la configuración de Versión<T>)<BR>Fin
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Usuario:Usuario.Usuario)
Antes=S
AntesExpresiones=Asigna(Info.Nombre, Usuario:Usuario.Usuario & <T> <T> & Usuario:Usuario.Nombre)
Visible=S

[Detalle.Columnas]
CampoNombre=311
Valor=303
ValorAnterior=285

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

[Detalle.Usuario.ContrasenaModificar]
Carpeta=Detalle
Clave=Usuario.ContrasenaModificar
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.Usuario.PerfilForma]
Carpeta=Detalle
Clave=Usuario.PerfilForma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.PerfilForma]
Nombre=PerfilForma
Boton=80
Menu=&Edición
NombreDesplegar=&Perfiles (Formas)
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=UsuarioPerfilForma
Activo=S
Visible=S


[Detalle.Usuario.Licenciamiento]
Carpeta=Detalle
Clave=Usuario.Licenciamiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.AccesoDirecto]
Nombre=AccesoDirecto
Boton=47
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=Acceso &Directo
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=UsuarioAccesoForma
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Usuario:Usuario.Usuario)
Antes=S
AntesExpresiones=Asigna(Info.Usuario, Usuario:Usuario.Usuario)
Visible=S




[MES]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Intelisis Factory
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

CondicionVisible=General.ProdInterfazINFOR
[MES.Usuario.INFORSupervisor]
Carpeta=MES
Clave=Usuario.INFORSupervisor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MES.Usuario.INFORPerfil]
Carpeta=MES
Clave=Usuario.INFORPerfil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MES.Usuario.ISMESNotificarError]
Carpeta=MES
Clave=Usuario.ISMESNotificarError
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco













[Acciones.PerfilMES]
Nombre=PerfilMES
Boton=0
Menu=&Maestros
NombreDesplegar=Perfil Factory
EnMenu=S
TipoAccion=Formas
Activo=S
ClaveAccion=PerfilMES











VisibleCondicion=General.ProdInterfazINFOR y 1=2
[Acciones.POSUsuario]
Nombre=POSUsuario
Boton=0
Menu=&Edición
NombreDesplegar=POS Acciones/Movimientos
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=POSUsuario2
Activo=S
Antes=S






AntesExpresiones=Asigna(Info.Usuario,Usuario:Usuario.Usuario)<BR>Asigna(Info.UsuarioNuevo,Usuario:Usuario.POSPerfil)
DespuesGuardar=S
VisibleCondicion=General.POS
[Detalle.Usuario.POSPerfil]
Carpeta=Detalle
Clave=Usuario.POSPerfil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[Detalle.ListaEnCaptura]
(Inicio)=Usuario.Usuario
Usuario.Usuario=Usuario.Nombre
Usuario.Nombre=Usuario.Sucursal
Usuario.Sucursal=Sucursal.Nombre
Sucursal.Nombre=Usuario.Estatus
Usuario.Estatus=Usuario.Contrasena
Usuario.Contrasena=Usuario.ContrasenaConfirmacion
Usuario.ContrasenaConfirmacion=Usuario.ContrasenaModificar
Usuario.ContrasenaModificar=Usuario.GrupoTrabajo
Usuario.GrupoTrabajo=Usuario.Departamento
Usuario.Departamento=Usuario.eMail
Usuario.eMail=Usuario.Oficina
Usuario.Oficina=Usuario.Telefono
Usuario.Telefono=Usuario.Extencion
Usuario.Extencion=Usuario.Idioma
Usuario.Idioma=Usuario.Observaciones
Usuario.Observaciones=Usuario.Configuracion
Usuario.Configuracion=UsuarioCopia.Nombre
UsuarioCopia.Nombre=UsuarioCopia.GrupoTrabajo
UsuarioCopia.GrupoTrabajo=Usuario.Acceso
Usuario.Acceso=UsuarioDestino.Nombre
UsuarioDestino.Nombre=UsuarioDestino.GrupoTrabajo
UsuarioDestino.GrupoTrabajo=Usuario.PerfilForma
Usuario.PerfilForma=Usuario.Licenciamiento
Usuario.Licenciamiento=Usuario.Menu
Usuario.Menu=Usuario.POSPerfil
Usuario.POSPerfil=(Fin)





























[POSUsuarioMovTemp.Columnas]
0=-2





































[POSUsuarioAccionTemp.Columnas]
0=-2






























































[Acciones.Guardar.Guarda]
Nombre=Guarda
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Guardar.Accesos]
Nombre=Accesos
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S






















Expresion=EjecutarSQL(<T>spCopiarUsuarioAcceso :tAcceso,:tUsuario<T>,Usuario:Usuario.Acceso,Usuario:Usuario.Usuario )
[Acciones.ConfiguraMovil]
Nombre=ConfiguraMovil
Boton=0
Menu=&Edición
NombreDesplegar=Móvil
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovilUsuarioCfg
Activo=S

















































Visible=S








Antes=S
AntesExpresiones=Asigna(Info.Usuario, Usuario:Usuario.Usuario)












[Acciones.Guardar.Valida]
Nombre=Valida
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S





















Expresion=Asigna(Pos.ValidaUsuario, nulo)<BR>Asigna(Info.Usuario, Usuario:Usuario.Usuario)<BR><BR>Si<BR>  General.POS<BR>Entonces<BR>  Asigna(Pos.ValidaUsuario,SQL(<T>EXEC spPOSUsuarioValidaCfg :tUsuario<T>, Info.Usuario))<BR>Fin<BR><BR>Si<BR>  ConDatos(Pos.ValidaUsuario)<BR>Entonces<BR>  Precaucion(Pos.ValidaUsuario)<BR>Fin






[MES.ListaEnCaptura]
(Inicio)=Usuario.INFORSupervisor
Usuario.INFORSupervisor=Usuario.INFORPerfil
Usuario.INFORPerfil=Usuario.ISMESNotificarError
Usuario.ISMESNotificarError=(Fin)













[Acciones.Guardar.MES]
Nombre=MES
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Cuenta,Usuario:Usuario.Usuario)<BR>EjecutarSQL(<T>spMESCatalogos :tCatalogo, :tINTCuenta<T>,<T>UsuarioMES<T>,Info.Cuenta)





[Acciones.Guardar.ListaAccionesMultiples]
(Inicio)=Guarda
Guarda=Valida
Valida=Accesos
Accesos=MES
MES=(Fin)









[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=MES
MES=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Configuracion
Configuracion=Empresas
Empresas=AccesoDirecto
AccesoDirecto=PerfilForma
PerfilForma=Impresoras
Impresoras=Anexos
Anexos=Propiedades
Propiedades=Mensajes
Mensajes=Historico
Historico=Navegador
Navegador=Cerrar
Cerrar=GrupoTrabajo
GrupoTrabajo=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=PerfilMES
PerfilMES=POSUsuario
POSUsuario=ConfiguraMovil
ConfiguraMovil=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=&Otros
&Otros=(Fin)

[Forma.PlantillasExcepciones]
(Inicio)=Usuario:Usuario.Estatus
Usuario:Usuario.Estatus=Usuario:Usuario.TieneMovimientos
Usuario:Usuario.TieneMovimientos=(Fin)
