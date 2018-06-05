[Forma]
Clave=PlantillaProyecto
Nombre=Plantillas - Proyectos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=605
PosicionInicialArriba=406
PosicionInicialAlturaCliente=352
PosicionInicialAncho=709
PosicionCol1=310
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
ListaEnCaptura=PlantillaProyecto.Plantilla
CarpetaVisible=S
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=PlantillaProyecto.Riesgo IS NULL
FiltroRespetar=S
FiltroTipo=General

[Lista.PlantillaProyecto.Plantilla]
Carpeta=Lista
Clave=PlantillaProyecto.Plantilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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

[Ficha.PlantillaProyecto.Plantilla]
Carpeta=Ficha
Clave=PlantillaProyecto.Plantilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

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
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Lista.Columnas]
Plantilla=279

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
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
EspacioPrevio=S
NombreEnBoton=S

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
EjecucionCondicion=ConDatos(PlantillaProyecto:PlantillaProyecto.Plantilla)
AntesExpresiones=Asigna(Info.Plantilla, PlantillaProyecto:PlantillaProyecto.Plantilla)

[Ficha.PlantillaProyecto.Version]
Carpeta=Ficha
Clave=PlantillaProyecto.Version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

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
(Inicio)=PlantillaProyecto.Plantilla
PlantillaProyecto.Plantilla=PlantillaProyecto.Descripcion
PlantillaProyecto.Descripcion=PlantillaProyecto.Version
PlantillaProyecto.Version=PlantillaProyecto.Estatus
PlantillaProyecto.Estatus=(Fin)
