[Forma]
Clave=RepContPoliza
Nombre=Impresión de Pólizas
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=833
PosicionInicialArriba=482
PosicionInicialAltura=228
PosicionInicialAncho=254
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=25x5
AccionesCentro=S
ListaAcciones=(Lista)
AccionesDivision=S
EsMovimiento=S
TituloAuto=S
MovModulo=CONT
MovEspecificos=Todos
BarraHerramientas=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=201

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.Rama, <T>CONT<T>)<BR>Asigna(Info.Descripcion, <T>Contabilidad<T>)<BR>Asigna(Info.Mov, <T><T>)<BR>Asigna(Info.MovIDD, Nulo)<BR>Asigna(Info.MovIDA, Nulo)<BR>Asigna(Info.FechaD, Nulo)<BR>Asigna(Info.FechaA, Nulo)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=5
FichaEspacioNombres=62
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
ListaEnCaptura=(Lista)
PermiteEditar=S

[Acciones.RepPan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.RepPan.Cont]
Nombre=Cont
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=ContPoliza
ListaParametros1=EstatusPlantilla<BR>Info.Mov<BR>Info.MovIDD<BR>Info.MovIDA<BR>Info.FechaD<BR>Info.FechaA<BR>Empresa
Activo=S
Visible=S

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=Variables Asignar<BR>Cont
Activo=S
Visible=S
EnBarraHerramientas=S
NombreEnBoton=S

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir.Cont]
Nombre=Cont
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=ContPoliza
ListaParametros1=EstatusPlantilla<BR>Info.Mov<BR>Info.MovIDD<BR>Info.MovIDA<BR>Info.FechaD<BR>Info.FechaA<BR>Empresa
ListaParametros=S
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=Variables Asignar<BR>Cont
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S

[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[(Variables).Info.MovIDD]
Carpeta=(Variables)
Clave=Info.MovIDD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[(Variables).Info.MovIDA]
Carpeta=(Variables)
Clave=Info.MovIDA
Editar=S
LineaNueva=S
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
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.OrdenConsecutivo]
Carpeta=(Variables)
Clave=Info.OrdenConsecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[(Variables).ListaEnCaptura]
(Inicio)=Info.Mov
Info.Mov=Info.MovIDD
Info.MovIDD=Info.MovIDA
Info.MovIDA=Info.OrdenConsecutivo
Info.OrdenConsecutivo=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=(Fin)



















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
