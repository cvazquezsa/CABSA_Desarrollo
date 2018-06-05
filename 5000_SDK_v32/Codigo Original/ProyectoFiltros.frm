
[Forma]
Clave=ProyectoFiltros
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Filtros
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=572
PosicionInicialArriba=286
PosicionInicialAlturaCliente=261
PosicionInicialAncho=326
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaExclusivaOpcion=0
Comentarios=Info.Proyecto
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
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[(Variables).Info.ProyectoActividad]
Carpeta=(Variables)
Clave=Info.ProyectoActividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ProyectoEstado]
Carpeta=(Variables)
Clave=Info.ProyectoEstado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ProyectoRecurso]
Carpeta=(Variables)
Clave=Info.ProyectoRecurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[(Variables).Info.ProyectoAvanceD]
Carpeta=(Variables)
Clave=Info.ProyectoAvanceD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ProyectoAvanceA]
Carpeta=(Variables)
Clave=Info.ProyectoAvanceA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ProyectoFechaInicioD]
Carpeta=(Variables)
Clave=Info.ProyectoFechaInicioD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ProyectoFechaInicioA]
Carpeta=(Variables)
Clave=Info.ProyectoFechaInicioA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ProyectoFechaConclusionD]
Carpeta=(Variables)
Clave=Info.ProyectoFechaConclusionD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ProyectoFechaConclusionA]
Carpeta=(Variables)
Clave=Info.ProyectoFechaConclusionA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S








[Lista.Columnas]
0=98
1=-2
2=-2






















[(Variables).ListaEnCaptura]
(Inicio)=Info.ProyectoActividad
Info.ProyectoActividad=Info.ProyectoEstado
Info.ProyectoEstado=Info.ProyectoRecurso
Info.ProyectoRecurso=Info.ProyectoAvanceD
Info.ProyectoAvanceD=Info.ProyectoAvanceA
Info.ProyectoAvanceA=Info.ProyectoFechaInicioD
Info.ProyectoFechaInicioD=Info.ProyectoFechaInicioA
Info.ProyectoFechaInicioA=Info.ProyectoFechaConclusionD
Info.ProyectoFechaConclusionD=Info.ProyectoFechaConclusionA
Info.ProyectoFechaConclusionA=(Fin)
























[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.Aplica, SQL(<T>SELECT Orden FROM ProyectoD WHERE ID = :nID AND Actividad = :tActividad<T>, Info.ID, Info.ProyectoActividad))
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Aceptar
Aceptar=(Fin)





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
