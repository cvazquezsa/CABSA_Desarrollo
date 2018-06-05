[Forma]
Clave=ArtCB
Nombre=Códigos Barras - Artículos
Icono=49
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=548
PosicionInicialArriba=354
PosicionInicialAltura=483
PosicionInicialAncho=824
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=456

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtCB
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteLocalizar=S
Filtros=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
HojaConfirmarEliminar=S
FiltroTipo=Predefinido
FiltroPredefinido=S
FiltroPredefinido1=por Código Barras<BR>por Artículo
FiltroPredefinido2=TipoCuenta=<T>Articulos<T><BR>TipoCuenta=<T>Articulos<T>
FiltroPredefinido3=ArtCB.Codigo<BR>ArtCB.Cuenta
FiltroEstilo=Directorio
HojaMantenerSeleccion=S
HojaIndicador=S
ValidarCampos=S
ListaCamposAValidar=SubCuentaNom

[Lista.ArtCB.Codigo]
Carpeta=Lista
Clave=ArtCB.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCB.Cuenta]
Carpeta=Lista
Clave=ArtCB.Cuenta
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
ColorFuente=Gris

[Lista.ArtCB.SubCuenta]
Carpeta=Lista
Clave=ArtCB.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Lista.ArtCB.Cantidad]
Carpeta=Lista
Clave=ArtCB.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Codigo=124
Cuenta=111
Descripcion1=188
SubCuenta=111
Cantidad=47
Unidad=38
SerieLote=94
Observaciones=180
Referencia=176

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Vista]
Nombre=Vista
Boton=0
NombreDesplegar=Cambiar Vista Hoja (Normal-Detalle)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S

[Lista.ArtCB.Unidad]
Carpeta=Lista
Clave=ArtCB.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Acciones.Sugerir]
Nombre=Sugerir
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=Agregar<BR>Expresion
EspacioPrevio=S

[Acciones.Sugerir.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(ArtCB:ArtCB.Codigo, SQL(<T>SELECT MAX(convert(money, Codigo))+1 FROM CB WHERE isnumeric(Codigo) = 1<T>))
Activo=S
Visible=S

[Acciones.Sugerir.Agregar]
Nombre=Agregar
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Lista.ArtCB.SerieLote]
Carpeta=Lista
Clave=ArtCB.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
TipoAccion=Reportes Impresora
ClaveAccion=CB
ListaParametros1=<T>Articulos<T>
ListaParametros=S
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=68
NombreDesplegar=&Presentación Preliminar
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=CB
ListaParametros1=<T>Articulos<T>
ListaParametros=S
Activo=S
Visible=S

[Lista.ArtCB.Observaciones]
Carpeta=Lista
Clave=ArtCB.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCB.Referencia]
Carpeta=Lista
Clave=ArtCB.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Componentes]
Nombre=Componentes
Boton=47
NombreEnBoton=S
NombreDesplegar=Co&mponentes
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtCBJuego
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=General.CR
EjecucionCondicion=ConDatos(ArtCB:ArtCB.Codigo)
AntesExpresiones=Asigna(Info.Codigo, ArtCB:ArtCB.Codigo)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Componentes
Componentes=Sugerir
Sugerir=Eliminar
Eliminar=Vista
Vista=Excel
Excel=Preliminar
Preliminar=Imprimir
Imprimir=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtCB.Codigo
ArtCB.Codigo=ArtCB.Cuenta
ArtCB.Cuenta=ArtCB.SubCuenta
ArtCB.SubCuenta=Art.Descripcion1
Art.Descripcion1=ArtCB.Cantidad
ArtCB.Cantidad=ArtCB.Unidad
ArtCB.Unidad=ArtCB.SerieLote
ArtCB.SerieLote=ArtCB.Referencia
ArtCB.Referencia=ArtCB.Observaciones
ArtCB.Observaciones=(Fin)
