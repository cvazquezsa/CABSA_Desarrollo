[Forma]
Clave=RepCompraMov
Nombre=Movimientos - Compras
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=285
PosicionInicialArriba=298
PosicionInicialAltura=171
PosicionInicialAncho=454
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=25x5
AccionesCentro=S
AccionesDivision=S
ListaAcciones=(Lista)
BarraHerramientas=S
VentanaEscCerrar=S

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.Articulo, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Moneda, Usuario.DefMoneda)<BR>Asigna(Info.FechaD, PrimerDiaMes)<BR>Asigna(Info.FechaA, UltimoDiaMes)<BR>Asigna(Info.Nivel, <T>Dia<T>)<BR>Asigna(Info.Vista, <T>Normal<T>)
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

[(Variables).Info.Articulo]
Carpeta=(Variables)
Clave=Info.Articulo
Editar=S
ValidaNombre=S
3D=S
Tamano=20

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
Pegado=N

[(Variables).Info.Nivel]
Carpeta=(Variables)
Clave=Info.Nivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[(Variables).Info.Vista]
Carpeta=(Variables)
Clave=Info.Vista
Editar=S
ValidaNombre=S
3D=S
Tamano=20

[Acciones.RepPan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.RepPan.Ir]
Nombre=Ir
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=IrAuxiliar(<T>COMS<T>, Info.Articulo, Info.Moneda, Info.FechaD, Info.FechaA, Info.Nivel, Info.Vista, Info.Proveedor)

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=Variables Asignar<BR>Ir<BR>VerAux
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.RepPan.VerAux]
Nombre=VerAux
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=VerAux
Activo=S
Visible=S

[(Variables).Info.Moneda]
Carpeta=(Variables)
Clave=Info.Moneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir.Ir]
Nombre=Ir
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=IrAuxiliar(<T>COMS<T>, Info.Articulo, Info.Moneda, Info.FechaD, Info.FechaA, Info.Nivel, Info.Vista, Info.Proveedor)

[Acciones.Imprimir.VerAux]
Nombre=VerAux
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=VerAux
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=Variables Asignar<BR>Ir<BR>VerAux
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S

[(Variables).Info.Proveedor]
Carpeta=(Variables)
Clave=Info.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S


[(Variables).ListaEnCaptura]
(Inicio)=Info.Articulo
Info.Articulo=Info.Moneda
Info.Moneda=Info.Proveedor
Info.Proveedor=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.Nivel
Info.Nivel=Info.Vista
Info.Vista=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
