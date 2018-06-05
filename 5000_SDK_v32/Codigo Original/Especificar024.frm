[Forma]
Clave=Especificar024
Nombre=<T>Parámetros<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
CarpetaPrincipal=(Variables)
BarraAcciones=S
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
AccionesCentro=S
PosicionInicialIzquierda=160
PosicionInicialArriba=207
PosicionInicialAltura=185
PosicionInicialAncho=479
AccionesDivision=S
ExpresionesAlMostrar=Asigna(Info.ArticuloD, SQL(<T>SELECT Min(Articulo) FROM Art<T> ))<BR>Asigna(Info.ArticuloA, SQL(<T>SELECT Max(Articulo) FROM Art<T> ))<BR>Asigna(Info.ProveedorD, SQL(<T>SELECT Min(Proveedor) FROM Prov<T> ))<BR>Asigna(Info.ProveedorA, SQL(<T>SELECT Max(Proveedor) FROM Prov<T> ))<BR>Asigna(Info.FechaD,  PrimerDiaMes(  PeriodoTrabajo ) ) <BR>Asigna(Info.FechaA,   UltimoDiaMes( PeriodoTrabajo ) )<BR>Asigna(Info.Desglosar,<T>Si<T>)<BR>Asigna(Info.Proyecto,<T>(Todos)<T>)

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

[(Variables).Info.ArticuloD]
Carpeta=(Variables)
Clave=Info.ArticuloD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.ArticuloA]
Carpeta=(Variables)
Clave=Info.ArticuloA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.ProveedorD]
Carpeta=(Variables)
Clave=Info.ProveedorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.ProveedorA]
Carpeta=(Variables)
Clave=Info.ProveedorA
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
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=&Aceptar
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=&Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

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

[(Variables).Info.Proyecto]
Carpeta=(Variables)
Clave=Info.Proyecto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.ArticuloD
Info.ArticuloD=Info.ArticuloA
Info.ArticuloA=Info.ProveedorD
Info.ProveedorD=Info.ProveedorA
Info.ProveedorA=Info.Desglosar
Info.Desglosar=Info.Proyecto
Info.Proyecto=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=(Fin)
