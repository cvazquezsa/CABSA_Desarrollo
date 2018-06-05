[Forma]
Clave=VINRenombrar
Nombre=Renombrar VIN<T>s
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=408
PosicionInicialArriba=320
PosicionInicialAlturaCliente=93
PosicionInicialAncho=208
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S
ExpresionesAlMostrar=Asigna(Info.VIND, Nulo)<BR>Asigna(Info.VINA, Nulo)

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
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Variables).Info.VIND]
Carpeta=(Variables)
Clave=Info.VIND
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.VINA]
Carpeta=(Variables)
Clave=Info.VINA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Renombrar]
Nombre=Renombrar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Renombrar
GuardarAntes=S
EnBarraHerramientas=S
ConfirmarAntes=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=ProcesarSQL(<T>spVINRenombrar :tD, :tA<T>, Info.VIND, Info.VINA)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=<T>&Cerrar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Renombrar
Renombrar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.VIND
Info.VIND=Info.VINA
Info.VINA=(Fin)
