
[Forma]
Clave=FiltrosExitenciaWMS
Icono=0
Modulos=(Todos)
Nombre=Existencia Disponible por Artículo

CarpetaPrincipal=FiltrosExitenciaWMS
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=474
PosicionInicialArriba=273
PosicionInicialAlturaCliente=158
PosicionInicialAncho=525
BarraAyuda=S
BarraAyudaBold=S
BarraAyudaEsp=S

ListaCarpetas=FiltrosExitenciaWMS
[(Variables).Info.MovWMS]
Carpeta=(Variables)
Clave=Info.MovWMS
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.IDMovWMS]
Carpeta=(Variables)
Clave=Info.IDMovWMS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.Aceptar.Asignar]
Nombre=Asignar
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

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Aceptar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
NombreEnBoton=S


GuardarAntes=S

[(Variables).ListaEnCaptura]
(Inicio)=Info.ModuloWMS
Info.ModuloWMS=Info.MovWMS
Info.MovWMS=Info.IDMovWMS
Info.IDMovWMS=(Fin)

[(Variables).Info.ModuloWMS]
Carpeta=(Variables)
Clave=Info.ModuloWMS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MovWMS.Columnas]
ID=168
Mov=404

[FiltrosExitenciaWMS]
Estilo=Ficha
Clave=FiltrosExitenciaWMS
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FiltrosExitenciaWMS
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)

FichaEspacioEntreLineas=12
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

PermiteEditar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=FiltrosExitenciaWMS.Estacion={EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
[FiltrosExitenciaWMS.FiltrosExitenciaWMS.Modulo]
Carpeta=FiltrosExitenciaWMS
Clave=FiltrosExitenciaWMS.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[FiltrosExitenciaWMS.FiltrosExitenciaWMS.Mov]
Carpeta=FiltrosExitenciaWMS
Clave=FiltrosExitenciaWMS.Mov
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[FiltrosExitenciaWMS.FiltrosExitenciaWMS.ID]
Carpeta=FiltrosExitenciaWMS
Clave=FiltrosExitenciaWMS.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[FiltrosExitenciaWMS.Columnas]
Modulo=64
Mov=64
ID=64













[FiltrosExitenciaWMS.ListaEnCaptura]
(Inicio)=FiltrosExitenciaWMS.Modulo
FiltrosExitenciaWMS.Modulo=FiltrosExitenciaWMS.Mov
FiltrosExitenciaWMS.Mov=FiltrosExitenciaWMS.ID
FiltrosExitenciaWMS.ID=(Fin)

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Asignar
Asignar=Aceptar
Aceptar=(Fin)


[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=E
E=(Fin)
