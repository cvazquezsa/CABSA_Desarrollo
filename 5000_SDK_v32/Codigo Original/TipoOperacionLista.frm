[Forma]
Clave=TipoOperacionLista
Nombre=Tipo Operación (Proveedores)
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=600
PosicionInicialArriba=241
PosicionInicialAltura=345
PosicionInicialAncho=409
CarpetaPrincipal=Lista
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S

PosicionInicialAlturaCliente=318
[ProvCat.Columnas]
Categoria=104
Descripcion=304

[Lista]
Estilo=Iconos
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoOperacion
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TipoOperacion.Codigo
ListaOrden=(Lista)
CarpetaVisible=S

IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPaginaEsp=200

IconosNombre=TipoOperacion:TipoOperacion.Clave
[Lista.Columnas]
Categoria=242
Descripcion=325

0=180
1=201
2=-2
3=-2
[Detalles.ProvCat.Categoria]
Carpeta=Detalles
Clave=ProvCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.ProvCat.Icono]
Carpeta=Detalles
Clave=ProvCat.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
EnMenu=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S




[Lista.TipoOperacion.Codigo]
Carpeta=Lista
Clave=TipoOperacion.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=TipoOperacion.Codigo
TipoOperacion.Codigo=TipoOperacion.Clave
TipoOperacion.Clave=(Fin)





[Lista.ListaOrden]
(Inicio)=TipoOperacion.Codigo	(Acendente)
TipoOperacion.Codigo	(Acendente)=TipoOperacion.Clave	(Acendente)
TipoOperacion.Clave	(Acendente)=(Fin)
