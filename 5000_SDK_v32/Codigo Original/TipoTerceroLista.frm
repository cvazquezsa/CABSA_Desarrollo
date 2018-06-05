[Forma]
Clave=TipoTerceroLista
Nombre=Tipo Tercero (Proveedores)
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=604
PosicionInicialArriba=241
PosicionInicialAltura=345
PosicionInicialAncho=401
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
Vista=TipoTercero
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TipoTercero.Codigo
ListaOrden=(Lista)
CarpetaVisible=S

IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPaginaEsp=200

IconosNombre=TipoTercero:TipoTercero.Clave
[Lista.Columnas]
Categoria=242
Descripcion=325

0=161
1=213
2=-2
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

[Lista.ListaEnCaptura]
(Inicio)=TipoTercero.Codigo
TipoTercero.Codigo=TipoTercero.Clave
TipoTercero.Clave=(Fin)


[Lista.TipoTercero.Codigo]
Carpeta=Lista
Clave=TipoTercero.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Lista.ListaOrden]
(Inicio)=TipoTercero.Codigo	(Acendente)
TipoTercero.Codigo	(Acendente)=TipoTercero.Clave	(Acendente)
TipoTercero.Clave	(Acendente)=(Fin)
