[Forma]
Clave=RepInvEjercicio
Nombre=Explorando - Inventario del Ejercicio
Icono=47
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=472
PosicionInicialArriba=434
PosicionInicialAltura=119
PosicionInicialAncho=335
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=92

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.Almacen, <T>(Todos)<T>)<BR>Asigna(Info.Ejercicio, EjercicioTrabajo)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
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

[(Variables).Info.Almacen]
Carpeta=(Variables)
Clave=Info.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Ejercicio]
Carpeta=(Variables)
Clave=Info.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Explorar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Explorar]
Nombre=Explorar
Boton=66
NombreEnBoton=S
NombreDesplegar=&Explorar
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
ListaAccionesMultiples=Variables Asignar<BR>Expresion<BR>VerEjercicio
Activo=S
Visible=S

[Acciones.Explorar.VerEjercicio]
Nombre=VerEjercicio
Boton=0
TipoAccion=Formas
ClaveAccion=VerEjercicio
Activo=S
Visible=S

[Acciones.Explorar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=IrModulo(<T>INV<T>)<BR>IrDireccion(<T>INV<T>)<BR>Si(Info.Almacen=<T>(TODOS)<T>, Asigna(Info.Almacen, Nulo))


[(Variables).ListaEnCaptura]
(Inicio)=Info.Almacen
Info.Almacen=Info.Ejercicio
Info.Ejercicio=(Fin)















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Explorar
Explorar=(Fin)
