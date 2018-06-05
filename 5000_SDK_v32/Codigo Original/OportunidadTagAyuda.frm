
[Forma]
Clave=OportunidadTagAyuda
Icono=5
Modulos=(Todos)
Nombre=Ayuda Etiquetas

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialAlturaCliente=420
PosicionInicialAncho=620
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=380
PosicionInicialArriba=134
Comentarios=Info.Anuncio
MovModulo=OPORT
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadTagAyuda
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Etiqueta<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=OportunidadTagAyuda.Descripcion

CarpetaVisible=S

IconosNombre=OportunidadTagAyuda:OportunidadTagAyuda.Tag

[Lista.OportunidadTagAyuda.Descripcion]
Carpeta=Lista
Clave=OportunidadTagAyuda.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

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

[Lista.Columnas]
0=122
1=446
2=-2
3=-2
4=55
5=-2







[Lista.ListaEnCaptura]
(Inicio)=OportunidadTagAyuda.Asunto
OportunidadTagAyuda.Asunto=OportunidadTagAyuda.Descripcion
OportunidadTagAyuda.Descripcion=(Fin)
