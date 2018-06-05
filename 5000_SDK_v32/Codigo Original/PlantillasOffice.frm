[Forma]
Clave=PlantillasOffice
Nombre=<T>Plantillas Office - <T>+Info.Nombre
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=695
PosicionInicialArriba=422
PosicionInicialAlturaCliente=319
PosicionInicialAncho=530
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaEscCerrar=S
VentanaExclusiva=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PlantillaOffice
Fuente={Tahoma, 8, Negro, []}
IconosCampo=PlantillaOffice.Icono
IconosEstilo=Iconos grandes
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Nombre<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Negro
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Plantillas
MenuLocal=S
ListaAcciones=LocalSeleccionar
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=PlantillaOffice:PlantillaOffice.Nombre
FiltroGeneral=PlantillaOffice.Forma=<T>{Info.Forma}<T> OR <BR>(PlantillaOffice.Modulo=<T>{Info.Modulo}<T> AND PlantillaOffice.Mov=<T>{Info.Mov}<T>)

[Lista.Columnas]
0=50

[Acciones.Configurar]
Nombre=Configurar
Boton=45
NombreEnBoton=S
NombreDesplegar=&Configurar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ConfigPlantillaOffice
RefrescarDespues=S
ActivoCondicion=Usuario.ConfigPlantillasOffice
VisibleCondicion=Vacio(Info.Modulo)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(PlantillaOffice:PlantillaOffice.ID)
AntesExpresiones=Asigna(Info.PlantillaID, PlantillaOffice:PlantillaOffice.ID)

[Acciones.LocalSeleccionar]
Nombre=LocalSeleccionar
Boton=0
NombreDesplegar=&Seleccionar
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(PlantillaOffice:PlantillaOffice.ID)
Antes=S
AntesExpresiones=Asigna(Info.PlantillaID, PlantillaOffice:PlantillaOffice.ID)
Visible=S

[Acciones.Actualizar Vista]
Nombre=Actualizar Vista
Boton=82
NombreDesplegar=Actualizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Actualizar Vista
Actualizar Vista=Configurar
Configurar=(Fin)
