
[Forma]
Clave=EspecificaDiezAlmacenes
Icono=0
Modulos=(Todos)

ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=531
PosicionInicialArriba=191
PosicionInicialAlturaCliente=336
PosicionInicialAncho=244
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
Nombre=Especificar Almacenes
BarraAcciones=S
AccionesCentro=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
VentanaEstadoInicial=Normal
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

[Lista.Columnas]
Almacen=90
Nombre=229
Grupo=100
Sucursal=46

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

EnBarraAcciones=S
EspacioPrevio=S
Multiple=S
ListaAccionesMultiples=(Lista)

[(Variables).Info.Almacen2]
Carpeta=(Variables)
Clave=Info.Almacen2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Almacen3]
Carpeta=(Variables)
Clave=Info.Almacen3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Almacen4]
Carpeta=(Variables)
Clave=Info.Almacen4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Almacen5]
Carpeta=(Variables)
Clave=Info.Almacen5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Almacen6]
Carpeta=(Variables)
Clave=Info.Almacen6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Almacen7]
Carpeta=(Variables)
Clave=Info.Almacen7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Almacen8]
Carpeta=(Variables)
Clave=Info.Almacen8
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Almacen9]
Carpeta=(Variables)
Clave=Info.Almacen9
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Almacen10]
Carpeta=(Variables)
Clave=Info.Almacen10
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
















[Acciones.Aceptar.VariablesAsignar]
Nombre=VariablesAsignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=VariablesAsignar
VariablesAsignar=Cerrar
Cerrar=(Fin)


[(Variables).ListaEnCaptura]
(Inicio)=Info.Almacen
Info.Almacen=Info.Almacen2
Info.Almacen2=Info.Almacen3
Info.Almacen3=Info.Almacen4
Info.Almacen4=Info.Almacen5
Info.Almacen5=Info.Almacen6
Info.Almacen6=Info.Almacen7
Info.Almacen7=Info.Almacen8
Info.Almacen8=Info.Almacen9
Info.Almacen9=Info.Almacen10
Info.Almacen10=(Fin)





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cerrar
Cerrar=(Fin)
