
[Forma]
Clave=DispersionCtaDinero
Icono=0
Modulos=(Todos)
Nombre=<T>Especificar Cuenta Dinero<T>
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
VentanaColor=Plata

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=537
PosicionInicialArriba=304
PosicionInicialAlturaCliente=92
PosicionInicialAncho=291
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
ExpresionesAlMostrar=Asigna(Info.CtaDinero, NULO)
[Lista]
Estilo=Ficha
Clave=Lista
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
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Info.CtaDinero
CarpetaVisible=S

[Lista.Info.CtaDinero]
Carpeta=Lista
Clave=Info.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
0=84
1=111
2=544


[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
Activo=S
Visible=S
NombreEnBoton=S

EspacioPrevio=S
ConCondicion=S
EjecucionConError=S
GuardarAntes=S
TipoAccion=Formas
ClaveAccion=ExplorarDispersion
Multiple=S
ListaAccionesMultiples=(Lista)
EjecucionCondicion=ConDatos(Info.CtaDinero)
EjecucionMensaje=<T>Se debe seleccionar una Cuenta de Dinero<T>
[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S










[Acciones.Aceptar.Forma]
Nombre=Forma
Boton=0
TipoAccion=Formas
ClaveAccion=ExploraDispersion
Activo=S
Visible=S





[Acciones.Aceptar.Variables]
Nombre=Variables
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Forma1]
Nombre=Forma1
Boton=0
TipoAccion=Formas
ClaveAccion=ExplorarDispersion
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables
Variables=Forma1
Forma1=(Fin)



























[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Aceptar
Aceptar=(Fin)
