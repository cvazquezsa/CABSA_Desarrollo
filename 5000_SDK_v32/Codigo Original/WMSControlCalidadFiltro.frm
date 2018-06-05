
[Forma]
Clave=WMSControlCalidadFiltro
Icono=67
Modulos=(Todos)
Nombre=Especificar Filtros

ListaCarpetas=Variables
CarpetaPrincipal=Variables
BarraAcciones=S
AccionesTamanoBoton=15x5
PosicionInicialIzquierda=533
PosicionInicialArriba=240
PosicionInicialAlturaCliente=235
PosicionInicialAncho=300
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaBloquearAjuste=S
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
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

[Variables.Info.WMSEstatusControlCalidad]
Carpeta=Variables
Clave=Info.WMSEstatusControlCalidad
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
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[Variables.Info.WMSSerieLoteD]
Carpeta=Variables
Clave=Info.WMSSerieLoteD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[Variables.Info.WMSFechaCaducidad]
Carpeta=Variables
Clave=Info.WMSFechaCaducidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco


[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

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














[Variables.ListaEnCaptura]
(Inicio)=Info.WMSEstatusControlCalidad
Info.WMSEstatusControlCalidad=Info.WMSSerieLoteD
Info.WMSSerieLoteD=Info.WMSSerieLoteA
Info.WMSSerieLoteA=Info.WMSFechaCaducidad
Info.WMSFechaCaducidad=Info.Almacen
Info.Almacen=(Fin)

[Variables.Info.Almacen]
Carpeta=Variables
Clave=Info.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
