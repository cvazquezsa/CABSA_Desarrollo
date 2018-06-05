
[Forma]
Clave=WMSEspecificarSerieLote
Icono=67
Modulos=(Todos)
Nombre=Especificar Series/Lotes

ListaCarpetas=Variables
CarpetaPrincipal=Variables
BarraAcciones=S
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
PosicionInicialIzquierda=534
PosicionInicialArriba=284
PosicionInicialAlturaCliente=122
PosicionInicialAncho=297
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaBloquearAjuste=S
VentanaEstadoInicial=Normal
[Variables]
Estilo=Ficha
Clave=Variables
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
[Variables.ListaEnCaptura]
(Inicio)=Info.WMSSerieLoteD
Info.WMSSerieLoteD=Info.WMSSerieLoteA
Info.WMSSerieLoteA=(Fin)

[Variables.Info.WMSSerieLoteD]
Carpeta=Variables
Clave=Info.WMSSerieLoteD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Variables.Info.WMSSerieLoteA]
Carpeta=Variables
Clave=Info.WMSSerieLoteA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=&Aceptar
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S












[WMSSerieLoteLista.Columnas]
SerieLote=202

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
