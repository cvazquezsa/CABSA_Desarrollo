[Forma]
Clave=aroRiesgoPlantillaProyecto
Nombre=<T>Plantillas - <T> + Info.Riesgo
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=703
PosicionInicialArriba=410
PosicionInicialAlturaCliente=345
PosicionInicialAncho=513
PosicionCol1=87
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PlantillaProyecto
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=PlantillaProyecto.Version
CarpetaVisible=S
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=PlantillaProyecto.Version<TAB>(Acendente)
FiltroGeneral=PlantillaProyecto.Riesgo = <T>{Info.Riesgo}<T>

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=PlantillaProyecto
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

[Ficha.PlantillaProyecto.Descripcion]
Carpeta=Ficha
Clave=PlantillaProyecto.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PlantillaProyecto.Estatus]
Carpeta=Ficha
Clave=PlantillaProyecto.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Lista.Columnas]
Plantilla=277
Version=55

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
GuardarAntes=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
NombreEnBoton=S
GuardarAntes=S
RefrescarDespues=S
Expresion=EjecutarSQL(<T>spRiesgoPlantillaNueva :tRiesgo<T>, Info.Riesgo)<BR>Forma.ActualizarForma

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
NombreEnBoton=S
ActivoCondicion=no PlantillaProyecto:PlantillaProyecto.TieneMovimientos

[Acciones.Actividades]
Nombre=Actividades
Boton=70
NombreEnBoton=S
NombreDesplegar=&Actividades
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PlantillaProyectoD
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(PlantillaProyecto:PlantillaProyecto.Version)
AntesExpresiones=Asigna(Info.Plantilla, Info.Riesgo+<T>/<T>+PlantillaProyecto:PlantillaProyecto.Version)

[Lista.PlantillaProyecto.Version]
Carpeta=Lista
Clave=PlantillaProyecto.Version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Eliminar
Eliminar=Actividades
Actividades=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=PlantillaProyecto.Descripcion
PlantillaProyecto.Descripcion=PlantillaProyecto.Estatus
PlantillaProyecto.Estatus=(Fin)
