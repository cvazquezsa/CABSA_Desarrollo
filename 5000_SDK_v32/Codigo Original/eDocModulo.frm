
[Forma]
Clave=eDocModulo
Icono=0
Modulos=(Todos)
Nombre=Configuración Documento Electrónico

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=452
PosicionInicialAncho=382
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=378
PosicionInicialArriba=160
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Modulo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Modulo<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosNombre=Modulo:Modulo.Modulo
ListaEnCaptura=Modulo.Nombre

[Lista.Modulo.Nombre]
Carpeta=Lista
Clave=Modulo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.eDoc]
Nombre=eDoc
Boton=38
NombreEnBoton=S
NombreDesplegar=&Documento Electrónico
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=eDoc
Activo=S
Antes=S
Visible=S

AntesExpresiones=Asigna(Info.Modulo,Modulo:Modulo.Modulo)<BR>Asigna(Info.Descripcion,Modulo:Modulo.Nombre)
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


[Acciones.XSD]
Nombre=XSD
Boton=83
NombreEnBoton=S
NombreDesplegar=&XSD
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=eDocXSD
Activo=S
Visible=S



Antes=S
AntesExpresiones=Asigna(Info.Modulo,Modulo:Modulo.Modulo)<BR>Asigna(Info.Descripcion,Modulo:Modulo.Nombre)





[Lista.Columnas]
0=-2
1=303







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=eDoc
eDoc=XSD
XSD=(Fin)
