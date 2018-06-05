
[Forma]
Clave=ZonaImpLista
Nombre=Zonas de Impuestos Especiales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=2046
PosicionInicialArriba=322
PosicionInicialAltura=368
PosicionInicialAncho=430
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

PosicionInicialAlturaCliente=341
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ZonaImp
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaNombre=Zonas
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Zona<T>
ElementosPorPagina=200
PestanaOtroNombre=S

ListaEnCaptura=(Lista)
IconosNombre=ZonaImp:ZonaImp.Zona
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Visible=S
Activo=S

[Lista.Columnas]
Zona=274
0=216



1=-2
2=-2
[Lista.ZonaImp.Impuesto]
Carpeta=Lista
Clave=ZonaImp.Impuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ZonaImp.Porcentaje]
Carpeta=Lista
Clave=ZonaImp.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ZonaImp.Impuesto
ZonaImp.Impuesto=ZonaImp.Porcentaje
ZonaImp.Porcentaje=(Fin)
