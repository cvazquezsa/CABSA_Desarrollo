[Forma]
Clave=ArtProvSucursal
Nombre=Proveedores del Artículo (Nivel Sucursal)
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=650
PosicionInicialArriba=384
PosicionInicialAltura=325
PosicionInicialAncho=620
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.Descripcion, Info.SubCuenta, Info.Proveedor)
PosicionInicialAlturaCliente=404

[Lista]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtProvSucursal
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=Personalizar
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
FiltroGeneral=ArtProvSucursal.Articulo=<T>{Info.Articulo}<T> AND<BR>ArtProvSucursal.Proveedor=<T>{Info.Proveedor}<T>              <BR>{Si(ConDatos(Info.SubCuenta), <T> AND ArtProvSucursal.SubCuenta=<T>+Comillas(Info.SubCuenta), <T><T>)}

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalles
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtProvSucursal
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

[Detalle.ArtProvSucursal.CostoAutorizado]
Carpeta=Detalle
Clave=ArtProvSucursal.CostoAutorizado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
EspacioPrevio=N

[Detalle.ArtProvSucursal.UltimoCosto]
Carpeta=Detalle
Clave=ArtProvSucursal.UltimoCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
EspacioPrevio=S

[Lista.Columnas]
Proveedor=88
Nombre=281
Clave=127
0=67
1=122
UltimoCosto=111
UltimaCompra=111
CostoAutorizado=125
SubCuenta=121
Sucursal=54
Nombre_1=256

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Detalle.ArtProvSucursal.UltimaCompra]
Carpeta=Detalle
Clave=ArtProvSucursal.UltimaCompra
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
LineaNueva=N

[Detalle.ArtProvSucursal.DiasRespuesta]
Carpeta=Detalle
Clave=ArtProvSucursal.DiasRespuesta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtProvSucursal.UltimoCosto]
Carpeta=Lista
Clave=ArtProvSucursal.UltimoCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Personalizar]
Nombre=Personalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Detalle.ArtProvSucursal.UltimaCotizacion]
Carpeta=Detalle
Clave=ArtProvSucursal.UltimaCotizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ArtProvSucursal.FechaCotizacion]
Carpeta=Detalle
Clave=ArtProvSucursal.FechaCotizacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Lista.ArtProvSucursal.Sucursal]
Carpeta=Lista
Clave=ArtProvSucursal.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtProvSucursal.CostoAutorizado]
Carpeta=Lista
Clave=ArtProvSucursal.CostoAutorizado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ArtProvSucursal.Sucursal]
Carpeta=Detalle
Clave=ArtProvSucursal.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Sucursal.Nombre]
Carpeta=Detalle
Clave=Sucursal.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtProvSucursal.Sucursal
ArtProvSucursal.Sucursal=Sucursal.Nombre
Sucursal.Nombre=ArtProvSucursal.UltimoCosto
ArtProvSucursal.UltimoCosto=ArtProvSucursal.CostoAutorizado
ArtProvSucursal.CostoAutorizado=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=ArtProvSucursal.Sucursal
ArtProvSucursal.Sucursal=Sucursal.Nombre
Sucursal.Nombre=ArtProvSucursal.DiasRespuesta
ArtProvSucursal.DiasRespuesta=ArtProvSucursal.CostoAutorizado
ArtProvSucursal.CostoAutorizado=ArtProvSucursal.UltimoCosto
ArtProvSucursal.UltimoCosto=ArtProvSucursal.UltimaCompra
ArtProvSucursal.UltimaCompra=ArtProvSucursal.UltimaCotizacion
ArtProvSucursal.UltimaCotizacion=ArtProvSucursal.FechaCotizacion
ArtProvSucursal.FechaCotizacion=(Fin)
