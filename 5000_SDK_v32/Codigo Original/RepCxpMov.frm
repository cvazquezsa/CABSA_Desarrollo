[Forma]
Clave=RepCxpMov
Nombre=Movimientos - Cuentas por Pagar
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=285
PosicionInicialArriba=308
PosicionInicialAltura=145
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
PosicionInicialAlturaCliente=118

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Moneda, Usuario.DefMoneda)<BR>Asigna(Info.FechaD, PrimerDiaMes)<BR>Asigna(Info.FechaA, UltimoDiaMes)<BR>Asigna(Info.Nivel, <T>Dia<T>)<BR>Asigna(Info.Vista, <T>Normal<T>)
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

[(Variables).Info.Proveedor]
Carpeta=(Variables)
Clave=Info.Proveedor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
Pegado=N
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Nivel]
Carpeta=(Variables)
Clave=Info.Nivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Vista]
Carpeta=(Variables)
Clave=Info.Vista
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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
Expresion=IrAuxiliar(<T>CXP<T>, Info.Proveedor, Info.Moneda, Info.FechaD, Info.FechaA, Info.Nivel, Info.Vista)

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
ColorFondo=Blanco
ColorFuente=Negro

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
Expresion=IrAuxiliar(<T>CXP<T>, Info.Proveedor, Info.Moneda, Info.FechaD, Info.FechaA, Info.Nivel, Info.Vista)
Activo=S
Visible=S

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
(Inicio)=Info.Proveedor
Info.Proveedor=Info.Moneda
Info.Moneda=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.Nivel
Info.Nivel=Info.Vista
Info.Vista=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
