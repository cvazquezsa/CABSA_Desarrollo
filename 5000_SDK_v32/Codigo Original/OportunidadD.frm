
[Forma]
Clave=OportunidadD
Icono=4
Modulos=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal

ListaCarpetas=Actividades
CarpetaPrincipal=Actividades
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=376
PosicionInicialArriba=164
PosicionInicialAlturaCliente=362
PosicionInicialAncho=613
ListaAcciones=(Lista)
Nombre=Actividad
Comentarios=Lista(Info.Mov + <T> <T> + Info.MovID, Info.Tipo +<T> <T>+Info.Clave)
VentanaExclusivaOpcion=2
MovModulo=OPORT
[Actividades]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Actividades
Clave=Actividades
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadD
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







Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=OportunidadD.ID = {Info.ID} AND<BR>OportunidadD.Renglon = {Info.Renglon} AND<BR>OportunidadD.RenglonSub = {Info.RenglonSub}
[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
NombreEnBoton=S
NombreDesplegar=Cancelar
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
ListaAccionesMultiples=(Lista)

Visible=S




Activo=S
[Lista.Columnas]
0=-2
1=232
2=-2
























[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S











Antes=S
Multiple=S
ListaAccionesMultiples=(Lista)
[Actividades.OportunidadD.Tipo]
Carpeta=Actividades
Clave=OportunidadD.Tipo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

Efectos=[Negritas]
[Actividades.OportunidadD.Clave]
Carpeta=Actividades
Clave=OportunidadD.Clave
Editar=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

Efectos=[Negritas]
Pegado=N
[Actividades.OportunidadD.Fecha]
Carpeta=Actividades
Clave=OportunidadD.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[Actividades.OportunidadD.PorcentajeAvance]
Carpeta=Actividades
Clave=OportunidadD.PorcentajeAvance
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


LineaNueva=S
[Actividades.Recurso.Nombre]
Carpeta=Actividades
Clave=Recurso.Nombre
Editar=S
3D=S
Tamano=45
ColorFondo=Blanco

[Actividades.OportunidadD.Comentarios]
Carpeta=Actividades
Clave=OportunidadD.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=66x10
ColorFondo=Blanco














[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar Cambios
Cancelar Cambios=Cancelar
Cancelar=(Fin)









[Actividades.OportunidadD.Recurso]
Carpeta=Actividades
Clave=OportunidadD.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco


















































[Acciones.GuardarCerrar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=GuardarCambios
[Acciones.GuardarCerrar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Actividades.OportunidadD.Estado]
Carpeta=Actividades
Clave=OportunidadD.Estado
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

Pegado=N















[Actividades.OportunidadD.FechaA]
Carpeta=Actividades
Clave=OportunidadD.FechaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=30





[Actividades.ListaEnCaptura]
(Inicio)=OportunidadD.Tipo
OportunidadD.Tipo=OportunidadD.Clave
OportunidadD.Clave=OportunidadD.Fecha
OportunidadD.Fecha=OportunidadD.FechaA
OportunidadD.FechaA=OportunidadD.PorcentajeAvance
OportunidadD.PorcentajeAvance=OportunidadD.Estado
OportunidadD.Estado=OportunidadD.Recurso
OportunidadD.Recurso=Recurso.Nombre
Recurso.Nombre=OportunidadD.Comentarios
OportunidadD.Comentarios=(Fin)












[Acciones.GuardarCerrar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)





[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Cancelar
Cancelar=(Fin)
