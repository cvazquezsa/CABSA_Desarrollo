
[Forma]
Clave=MonCodigoInternacionalLista
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
Nombre=Código Internacional de Monedas

ListaCarpetas=Lista
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=550
PosicionInicialArriba=279
ListaAcciones=Seleccionar
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MonCodigoInternacional
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Código<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MonCodigoInternacional.Descripcion

CarpetaVisible=S
IconosNombre=MonCodigoInternacional:MonCodigoInternacional.Codigo
[Lista.ListaEnCaptura]
(Inicio)=MonCodigoInternacional.Codigo
MonCodigoInternacional.Codigo=MonCodigoInternacional.Descripcion
MonCodigoInternacional.Descripcion=(Fin)


[Lista.MonCodigoInternacional.Descripcion]
Carpeta=Lista
Clave=MonCodigoInternacional.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
0=-2
1=-2

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S
NombreEnBoton=S
ClaveAccion=Seleccionar
