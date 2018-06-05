[Forma]
Clave=RepVentaUtilD
Nombre=<T>Utilidades (Detalle)<T>
Icono=0
Modulos=(Todos)
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=270
PosicionInicialArriba=305
PosicionInicialAltura=151
PosicionInicialAncho=483
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=124

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.ArticuloD, SQL(<T>SELECT MIN(Articulo) FROM Art<T>))<BR>Asigna(Info.ArticuloA, SQL(<T>SELECT MAX(Articulo) FROM Art<T>))<BR>Asigna(Info.FechaD,PrimerDiaMes) <BR>Asigna(Info.FechaA,UltimoDiaMes) <BR>Asigna(Info.Moneda, <T>(Todas)<T>)<BR>Asigna(Info.Desglosar, <T>Si<T>)
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=S
Visible=S
NombreEnBoton=S
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>VentaUtilD
EspacioPrevio=S

[Acciones.PrePan]
Nombre=PrePan
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>VentaUtilD

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

[(Variables).Info.ArticuloA]
Carpeta=(Variables)
Clave=Info.ArticuloA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.ArticuloD]
Carpeta=(Variables)
Clave=Info.ArticuloD
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=N
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

[(Variables).Info.Moneda]
Carpeta=(Variables)
Clave=Info.Moneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.PrePan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.PrePan.VentaUtilD]
Nombre=VentaUtilD
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ReportePantalla( <T>VentaUtilD<T>, Info.FechaD, Info.FechaA )

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir.VentaUtilD]
Nombre=VentaUtilD
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ReporteImpresora(<T>VentaUtilD<T>, Info.FechaD, Info.FechaA)

[(Variables).Info.Desglosar]
Carpeta=(Variables)
Clave=Info.Desglosar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[(Variables).ListaEnCaptura]
(Inicio)=Info.ArticuloD
Info.ArticuloD=Info.ArticuloA
Info.ArticuloA=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.Desglosar
Info.Desglosar=Info.Moneda
Info.Moneda=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=PrePan
PrePan=(Fin)
