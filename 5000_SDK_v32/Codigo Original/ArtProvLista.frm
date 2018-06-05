[Forma]
Clave=ArtProvLista
Nombre=Proveedores del Artículo
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=123
PosicionInicialArriba=170
PosicionInicialAltura=470
PosicionInicialAncho=778
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=393
Comentarios=Lista(Info.Articulo, Info.Descripcion, Info.SubCuenta)
ListaAcciones=(Lista)

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtProv
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=ArtProv.UltimoCosto<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=25
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Proveedores
PermiteEditar=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Proveedor<T>
ElementosPorPagina=200
IconosNombre=ArtProv:ArtProv.Proveedor
FiltroGeneral=ArtProv.Articulo=<T>{Info.Articulo}<T> <BR>{Si(ConDatos(Info.SubCuenta), <T> AND ArtProv.SubCuenta IN (<T>+Comillas(<T><T>)+<T>, <T>+Comillas(Info.SubCuenta)+<T>)<T>, <T><T>)}

[Lista.Columnas]
0=79
1=220
Articulo=132
Descripcion1=251
Proveedor=80
Nombre=269
UltimoCosto=96
UltimaCompra=106
DiasRespuesta=133
UltimaCotizacion=85
FechaCotizacion=117

[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtProv.UltimoCosto]
Carpeta=Lista
Clave=ArtProv.UltimoCosto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ArtProv.UltimaCompra]
Carpeta=Lista
Clave=ArtProv.UltimaCompra
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ArtProv.UltimaCotizacion]
Carpeta=Lista
Clave=ArtProv.UltimaCotizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtProv.FechaCotizacion]
Carpeta=Lista
Clave=ArtProv.FechaCotizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Costo, Si(ArtProv:ArtProv.FechaCotizacion>ArtProv:ArtProv.UltimaCompra, ArtProv:ArtProv.UltimaCotizacion, ArtProv:ArtProv.UltimoCosto))

[Acciones.ArtProv]
Nombre=ArtProv
Boton=35
NombreEnBoton=S
NombreDesplegar=&Editar
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtProv
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=ArtProv
ArtProv=Actualizar
Actualizar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Prov.Nombre
Prov.Nombre=ArtProv.UltimaCotizacion
ArtProv.UltimaCotizacion=ArtProv.FechaCotizacion
ArtProv.FechaCotizacion=ArtProv.UltimoCosto
ArtProv.UltimoCosto=ArtProv.UltimaCompra
ArtProv.UltimaCompra=(Fin)
