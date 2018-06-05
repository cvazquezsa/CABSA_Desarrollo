
[Forma]
Clave=POSOfertaFormaPago
Icono=0
CarpetaPrincipal=POSOfertaFormaPago
Modulos=(Todos)
Nombre=Descuentos POS  Por Forma de Pago
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=POSOfertaFormaPago
PosicionInicialIzquierda=381
PosicionInicialArriba=164
PosicionInicialAlturaCliente=379
PosicionInicialAncho=722
BarraAyuda=S
BarraAyudaBold=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
DialogoAbrir=S
[POSOfertaFormaPago]
Estilo=Ficha
Clave=POSOfertaFormaPago
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSOfertaFormaPago
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

[POSOfertaFormaPago.POSOfertaFormaPago.FormaPago]
Carpeta=POSOfertaFormaPago
Clave=POSOfertaFormaPago.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=69
ColorFondo=Blanco

[POSOfertaFormaPago.POSOfertaFormaPago.Descuento]
Carpeta=POSOfertaFormaPago
Clave=POSOfertaFormaPago.Descuento
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

LineaNueva=S
Tamano=20
[POSOfertaFormaPago.POSOfertaFormaPago.MontoMinimo]
Carpeta=POSOfertaFormaPago
Clave=POSOfertaFormaPago.MontoMinimo
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[POSOfertaFormaPago.POSOfertaFormaPago.TodasSucursales]
Carpeta=POSOfertaFormaPago
Clave=POSOfertaFormaPago.TodasSucursales
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20
[POSOfertaFormaPago.POSOfertaFormaPago.Sucursal]
Carpeta=POSOfertaFormaPago
Clave=POSOfertaFormaPago.Sucursal
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

LineaNueva=S
[POSOfertaFormaPago.Sucursal.Nombre]
Carpeta=POSOfertaFormaPago
Clave=Sucursal.Nombre
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata

Pegado=S
[POSOfertaFormaPago.POSOfertaFormaPago.FechaD]
Carpeta=POSOfertaFormaPago
Clave=POSOfertaFormaPago.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[POSOfertaFormaPago.POSOfertaFormaPago.FechaA]
Carpeta=POSOfertaFormaPago
Clave=POSOfertaFormaPago.FechaA
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[POSOfertaFormaPago.POSOfertaFormaPago.HoraD]
Carpeta=POSOfertaFormaPago
Clave=POSOfertaFormaPago.HoraD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSOfertaFormaPago.POSOfertaFormaPago.HoraA]
Carpeta=POSOfertaFormaPago
Clave=POSOfertaFormaPago.HoraA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco














[Lista.Columnas]
0=91
1=267


[POSOfertaFormaPago.POSOfertaFormaPago.Descripcion]
Carpeta=POSOfertaFormaPago
Clave=POSOfertaFormaPago.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=69
ColorFondo=Blanco


[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=POSOfertaFormaPagoA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(por Omisión)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Descripción<T>
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por grupos)
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S

FiltroAutoCampo=POSOfertaFormaPago.FormaPago
FiltroAutoValidar=POSOfertaFormaPago.FormaPago
FiltroAutoOrden=POSOfertaFormaPago.ID
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=FormaPago
FiltroAplicaEn1=POSOfertaFormaPago.FormaPago
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroFechasCampo=POSOfertaFormaPago.FechaD
BusquedaRapida=S
BusquedaEnLinea=S
FiltroModificarEstatus=S
FiltroEstatusDefault=ACTIVA
PestanaOtroNombre=S
PestanaNombre=Descuentos  Forma de Pago
FiltroTodo=S
BusquedaBloquearAsteriscoPrevio=S
FiltroSucursales=S
FiltroSucursalesTodasPorOmision=S
OtroOrden=S
ListaOrden=POSOfertaFormaPago.ID<TAB>(Decendente)
IconosConPaginas=S
IconosNombre=POSOfertaFormaPagoA:POSOfertaFormaPago.Descripcion
[(Carpeta Abrir).POSOfertaFormaPago.FormaPago]
Carpeta=(Carpeta Abrir)
Clave=POSOfertaFormaPago.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).POSOfertaFormaPago.FechaD]
Carpeta=(Carpeta Abrir)
Clave=POSOfertaFormaPago.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).POSOfertaFormaPago.FechaA]
Carpeta=(Carpeta Abrir)
Clave=POSOfertaFormaPago.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).Columnas]
0=158
1=146
2=190
3=-2













[Acciones.Documento Abrir]
Nombre=Documento Abrir
Boton=2
NombreDesplegar=Documento Abrir
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S


[Acciones.Documento Eliminar]
Nombre=Documento Eliminar
Boton=5
NombreDesplegar=Documento Eliminar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Activo=S
Visible=S


EspacioPrevio=S
[Acciones.Documento Nuevo]
Nombre=Documento Nuevo
Boton=1
NombreDesplegar=Documento Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S




[Acciones.Activa]
Nombre=Activa
Boton=23
NombreDesplegar=Oferta  &Activa
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Antes=S
Visible=S


GuardarAntes=S
ConCondicion=S
DespuesGuardar=S
EspacioPrevio=S
Expresion=Asigna( POSOfertaFormaPago:POSOfertaFormaPago.Estatus,EstatusActiva )<BR>GuardarCambios<BR>ActualizarForma
EjecucionCondicion=Asigna(Temp.Logico,SQL(<T>spPOSValidaAltaOfertaFormaPago  :nID, :tEmpresa,:tEstatus, :lTodasSucursales, :nSucursal, :tFormaPago, :nDescuento, :nMonto, :tFechaD, :tFechaA,:tHoraD, :tHoraA<T>,POSOfertaFormaPago:POSOfertaFormaPago.ID,POSOfertaFormaPago:POSOfertaFormaPago.Empresa,POSOfertaFormaPago:POSOfertaFormaPago.Estatus,POSOfertaFormaPago:POSOfertaFormaPago.TodasSucursales,POSOfertaFormaPago:POSOfertaFormaPago.Sucursal,POSOfertaFormaPago:POSOfertaFormaPago.FormaPago,POSOfertaFormaPago:POSOfertaFormaPago.Descuento,POSOfertaFormaPago:POSOfertaFormaPago.MontoMinimo, FechaFormatoServidor( POSOfertaFormaPago:POSOfertaFormaPago.FechaD ) , FechaFormatoServidor( POSOfertaFormaPago:POSOfertaFormaPago.FechaA ) ,POSOfertaFormaPago:POSOfertaFormaPago.HoraD,POSOfertaFormaPago:POSOfertaFormaPago.HoraA))<BR><BR>(POSOfertaFormaPago:POSOfertaFormaPago.Estatus <> EstatusActiva)y (No(Temp.Logico))
[Acciones.InActiva]
Nombre=InActiva
Boton=21
NombreDesplegar=Oferta &Inactiva
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Antes=S
Visible=S





GuardarAntes=S
















Expresion=Asigna(POSOfertaFormaPago:POSOfertaFormaPago.Estatus, EstatusInactiva )<BR>GuardarCambios<BR>ActualizarForma
[Acciones.Navegador (Documentos)]
Nombre=Navegador (Documentos)
Boton=0
NombreDesplegar=Navegador (Documentos)
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S



EspacioPrevio=S











































































[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
































EjecucionCondicion=Asigna(Temp.Logico,SQL(<T>spPOSValidaAltaOfertaFormaPago  :nID, :tEmpresa, :tEstatus, :lTodasSucursales, :nSucursal, :tFormaPago, :nDescuento, :nMonto, :tFechaD, :tFechaA,:tHoraD, :tHoraA<T>,POSOfertaFormaPago:POSOfertaFormaPago.ID,POSOfertaFormaPago:POSOfertaFormaPago.Empresa,POSOfertaFormaPago:POSOfertaFormaPago.Estatus,POSOfertaFormaPago:POSOfertaFormaPago.TodasSucursales,POSOfertaFormaPago:POSOfertaFormaPago.Sucursal,POSOfertaFormaPago:POSOfertaFormaPago.FormaPago,POSOfertaFormaPago:POSOfertaFormaPago.Descuento,POSOfertaFormaPago:POSOfertaFormaPago.MontoMinimo, FechaFormatoServidor( POSOfertaFormaPago:POSOfertaFormaPago.FechaD ) , FechaFormatoServidor( POSOfertaFormaPago:POSOfertaFormaPago.FechaA ) ,POSOfertaFormaPago:POSOfertaFormaPago.HoraD,POSOfertaFormaPago:POSOfertaFormaPago.HoraA))<BR><BR>No(Temp.Logico)
EjecucionMensaje=<T>Ya Existen Ofertas Para La Fecha Y Hora Indicada<T>
[POSOfertaFormaPago.ListaEnCaptura]
(Inicio)=POSOfertaFormaPago.Descripcion
POSOfertaFormaPago.Descripcion=POSOfertaFormaPago.FormaPago
POSOfertaFormaPago.FormaPago=POSOfertaFormaPago.Descuento
POSOfertaFormaPago.Descuento=POSOfertaFormaPago.MontoMinimo
POSOfertaFormaPago.MontoMinimo=POSOfertaFormaPago.FechaD
POSOfertaFormaPago.FechaD=POSOfertaFormaPago.FechaA
POSOfertaFormaPago.FechaA=POSOfertaFormaPago.HoraD
POSOfertaFormaPago.HoraD=POSOfertaFormaPago.HoraA
POSOfertaFormaPago.HoraA=POSOfertaFormaPago.TodasSucursales
POSOfertaFormaPago.TodasSucursales=POSOfertaFormaPago.Sucursal
POSOfertaFormaPago.Sucursal=Sucursal.Nombre
Sucursal.Nombre=(Fin)
































































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=POSOfertaFormaPago.FormaPago
POSOfertaFormaPago.FormaPago=POSOfertaFormaPago.FechaD
POSOfertaFormaPago.FechaD=POSOfertaFormaPago.FechaA
POSOfertaFormaPago.FechaA=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ACTIVA
ACTIVA=INACTIVA
INACTIVA=(Fin)



[Forma.ListaAcciones]
(Inicio)=Documento Nuevo
Documento Nuevo=Documento Abrir
Documento Abrir=Guardar
Guardar=Documento Eliminar
Documento Eliminar=Activa
Activa=InActiva
InActiva=Navegador (Documentos)
Navegador (Documentos)=(Fin)
