
[Forma]
Clave=ContParalelaXMLPlantilla
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Contabilidad Paralela - Módulos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=509
PosicionInicialArriba=154
PosicionInicialAlturaCliente=381
PosicionInicialAncho=347

ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spContParalelaXMLPlantillaI<T>)
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Módulos
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalelaXMLPlantilla
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Modulo.Nombre
ListaOrden=ContParalelaXMLPlantilla.Modulo<TAB>(Acendente)
CarpetaVisible=S

IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosNombre=ContParalelaXMLPlantilla:ContParalelaXMLPlantilla.Modulo
IconosSubTitulo=<T>Modulo<T>
ElementosPorPaginaEsp=200

[Lista.Columnas]
Modulo=260

0=-2
1=-2
[Acciones.Plantilla]
Nombre=Plantilla
Boton=75
NombreEnBoton=S
NombreDesplegar=&Plantilla
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ContParalelaXMLPlantillaTexto
Activo=S
Visible=S











Antes=S




















GuardarAntes=S
AntesExpresiones=Asigna(Info.Modulo, ContParalelaXMLPlantilla:ContParalelaXMLPlantilla.Modulo)











































[Lista.Modulo.Nombre]
Carpeta=Lista
Clave=Modulo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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









[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Plantilla
Plantilla=(Fin)
