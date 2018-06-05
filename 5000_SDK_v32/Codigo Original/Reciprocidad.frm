[Forma]
Clave=Reciprocidad
Nombre=Reciprocidad
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=513
PosicionInicialArriba=419
PosicionInicialAlturaCliente=158
PosicionInicialAncho=254
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
BarraAcciones=S
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
ExpresionesAlMostrar=Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Importe, Nulo)<BR>Asigna(Info.TipoCredito, Nulo)<BR>Asigna(Info.Articulo, Nulo)

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

[(Variables).Info.Cliente]
Carpeta=(Variables)
Clave=Info.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Importe]
Carpeta=(Variables)
Clave=Info.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.TipoCredito]
Carpeta=(Variables)
Clave=Info.TipoCredito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Articulo]
Carpeta=(Variables)
Clave=Info.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Ver]
Nombre=Ver
Boton=0
NombreDesplegar=&Ver
GuardarAntes=S
EnBarraAcciones=S
TipoAccion=Formas
ClaveAccion=VerReciprocidad
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
NombreDesplegar=<T>&Cerrar<T>
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Ver
Ver=Cerrar
Cerrar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.Cliente
Info.Cliente=Info.Importe
Info.Importe=Info.TipoCredito
Info.TipoCredito=Info.Articulo
Info.Articulo=(Fin)
