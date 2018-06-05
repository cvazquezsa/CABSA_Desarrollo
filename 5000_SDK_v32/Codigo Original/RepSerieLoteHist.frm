[Forma]
Clave=RepSerieLoteHist
Nombre=<T>Historial de Serie/Lote/VIN<T>
Icono=0
Modulos=INV
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
ListaCarpetas=(Variables)
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=(Variables)
ListaAcciones=(Lista)
PosicionInicialIzquierda=390
PosicionInicialArriba=335
PosicionInicialAltura=91
PosicionInicialAncho=255
PosicionInicialAlturaCliente=64

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.SerieLote,Nulo)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Fixedsys, 9, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Info.SerieLote
CarpetaVisible=S

[(Variables).Info.SerieLote]
Carpeta=(Variables)
Clave=Info.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

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

[Acciones.SerieLoteHist.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.SerieLoteHist.SerieLoteHist]
Nombre=SerieLoteHist
Boton=0
TipoAccion=Formas
ClaveAccion=SerieLoteHist
Activo=S
Visible=S

[Acciones.SerieLoteHist]
Nombre=SerieLoteHist
Boton=34
NombreDesplegar=Ver &Información
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Variables Asignar<BR>SerieLoteHist
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S











[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=SerieLoteHist
SerieLoteHist=(Fin)
