[Forma]
Clave=RepNominaTabularAcum
Nombre=<T>Nómina Tabular Acumulado<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=356
PosicionInicialArriba=240
PosicionInicialAltura=281
PosicionInicialAncho=312
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=254

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.FechaD, PrimerDiaAño(Año(Hoy)))<BR>Asigna(Info.FechaA, Hoy)<BR>Asigna(Rep.Titulo, <T>Nómina Tabular Acumulado<T>)<BR>Asigna(Rep.PersonaEspecifica, Nulo)<BR>Asigna(Info.Departamento, <T>(Todos)<T>)<BR>Asigna(Info.Puesto, <T>(Todos)<T>)<BR>Asigna(Info.PersonalCat, <T>(Todos)<T>)<BR>Asigna(Info.PersonalGrupo, <T>(Todos)<T>)
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
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)

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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
ListaAccionesMultiples=Variables Asignar<BR>NominaTabularAcum
Activo=S
Visible=S

[Acciones.Preliminar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Variables Asignar<BR>NominaTabularAcum
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Preliminar.NominaTabularAcum]
Nombre=NominaTabularAcum
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=NominaTabularAcum
Activo=S
Visible=S

[Acciones.Imprimir.NominaTabularAcum]
Nombre=NominaTabularAcum
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=NominaTabularAcum
Activo=S
Visible=S

[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[(Variables).Info.Departamento]
Carpeta=(Variables)
Clave=Info.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Puesto]
Carpeta=(Variables)
Clave=Info.Puesto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.PersonalCat]
Carpeta=(Variables)
Clave=Info.PersonalCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.PersonalGrupo]
Carpeta=(Variables)
Clave=Info.PersonalGrupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Rep.PersonaEspecifica]
Carpeta=(Variables)
Clave=Rep.PersonaEspecifica
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


[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Rep.PersonaEspecifica
Rep.PersonaEspecifica=Info.Departamento
Info.Departamento=Info.Puesto
Info.Puesto=Info.PersonalCat
Info.PersonalCat=Info.PersonalGrupo
Info.PersonalGrupo=Rep.Titulo
Rep.Titulo=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=(Fin)
