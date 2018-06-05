[Forma]
Clave=OutlookNombre
Nombre=Identificar Nombres Outlook
Icono=0
Modulos=(Todos)
MovModulo=Nombre
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=184
PosicionInicialArriba=230
PosicionInicialAlturaCliente=537
PosicionInicialAncho=911
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OutlookNombre
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=NUEVO
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S

[Lista.OutlookNombre.Nombre]
Carpeta=Lista
Clave=OutlookNombre.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OutlookNombre.Cliente]
Carpeta=Lista
Clave=OutlookNombre.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OutlookNombre.ClienteContacto]
Carpeta=Lista
Clave=OutlookNombre.ClienteContacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OutlookNombre.Proveedor]
Carpeta=Lista
Clave=OutlookNombre.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OutlookNombre.Agente]
Carpeta=Lista
Clave=OutlookNombre.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OutlookNombre.Personal]
Carpeta=Lista
Clave=OutlookNombre.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OutlookNombre.Usuario]
Carpeta=Lista
Clave=OutlookNombre.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Nombre=335
Cliente=90
ClienteContacto=92
Proveedor=87
Agente=78
Personal=74
Usuario=61
Estatus=59

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreEnBoton=S
NombreDesplegar=Actualizar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Antes=S
DespuesGuardar=S
AntesExpresiones=EjecutarSQL(<T>spOutlookNombreActualizar<T>)

[Lista.OutlookNombre.Estatus]
Carpeta=Lista
Clave=OutlookNombre.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Guardar
Guardar=Actualizar
Actualizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=OutlookNombre.Nombre
OutlookNombre.Nombre=OutlookNombre.Cliente
OutlookNombre.Cliente=OutlookNombre.ClienteContacto
OutlookNombre.ClienteContacto=OutlookNombre.Proveedor
OutlookNombre.Proveedor=OutlookNombre.Agente
OutlookNombre.Agente=OutlookNombre.Personal
OutlookNombre.Personal=OutlookNombre.Usuario
OutlookNombre.Usuario=OutlookNombre.Estatus
OutlookNombre.Estatus=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Cte.Nombre
Cte.Nombre=CteCto.Nombre
CteCto.Nombre=Prov.Nombre
Prov.Nombre=Agente.Nombre
Agente.Nombre=PersonalNombreCompleto
PersonalNombreCompleto=Usuario.Nombre
Usuario.Nombre=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=NUEVO
NUEVO=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)
