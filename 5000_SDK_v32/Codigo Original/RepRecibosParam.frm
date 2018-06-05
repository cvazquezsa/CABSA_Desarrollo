
[Forma]
Clave=RepRecibosParam
Icono=0
Modulos=(Todos)
Nombre=Parámetros
AccionesTamanoBoton=15x5
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaColor=Plata

ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=541
PosicionInicialArriba=233
PosicionInicialAlturaCliente=222
PosicionInicialAncho=284
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaExclusivaOpcion=0
BarraAcciones=S
AccionesDivision=S
AccionesCentro=S
VentanaEscCerrar=S
ExpresionesAlMostrar=Asigna(Info.Personal, <T>(Todos)<T>)<BR>Asigna(Info.PersonalEstatus, <T>(Todos)<T>)<BR>Asigna(Info.PersonalVioDetalle,<T>No<T>)<BR>Asigna(Info.PersonalAcuerdo,<T>No<T>)<BR>Asigna(Info.FechaD,PrimerDiaMes(Ahora))<BR>Asigna(Info.FechaA,UltimoDiaMes(Ahora))
[(Variables)]
Estilo=Ficha
Clave=(Variables)
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
ListaEnCaptura=(Lista)

CarpetaVisible=S

[(Variables).Info.Personal]
Carpeta=(Variables)
Clave=Info.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Acciones.Aceptar]
Nombre=Aceptar
Boton=-1
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

EnBarraAcciones=S
[Acciones.Cancelar]
Nombre=Cancelar
Boton=-1
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S











EnBarraAcciones=S











[(Variables).ListaEnCaptura]
(Inicio)=Info.Personal
Info.Personal=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.PersonalEstatus
Info.PersonalEstatus=Info.PersonalVioDetalle
Info.PersonalVioDetalle=Info.PersonalAcuerdo
Info.PersonalAcuerdo=(Fin)

[(Variables).Info.PersonalEstatus]
Carpeta=(Variables)
Clave=Info.PersonalEstatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.PersonalVioDetalle]
Carpeta=(Variables)
Clave=Info.PersonalVioDetalle
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.PersonalAcuerdo]
Carpeta=(Variables)
Clave=Info.PersonalAcuerdo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
