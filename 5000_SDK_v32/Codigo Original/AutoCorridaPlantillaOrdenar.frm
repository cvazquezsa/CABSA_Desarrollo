[Forma]
Clave=AutoCorridaPlantillaOrdenar
Nombre=Ordenar Plantilla
Icono=48
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=300
PosicionInicialArriba=103
PosicionInicialAltura=385
PosicionInicialAncho=423
ListaAcciones=(Lista)
Comentarios=<T>Utilice arrastrar y soltar para cambiar el orden<T>
PosicionInicialAlturaCliente=527

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AutoCorridaPlantilla
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Registros
OtroOrden=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Orden<T>
ElementosPorPagina=200
ListaEnCaptura=(Lista)
ListaOrden=AutoCorridaPlantilla.Orden<TAB>(Acendente)
IconosCambiarOrden=S
IconosNombre=AutoCorridaPlantilla:AutoCorridaPlantilla.Orden

[Lista.Columnas]
0=58
1=87

[Acciones.Ordenar]
Nombre=Ordenar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar Nuevo Orden
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Antes=S
Visible=S
AntesExpresiones=RegistrarListaSt(<T>Lista<T>, <T>AutoCorridaPlantilla.ID<T>)<BR>EjecutarSQL(<T>spOrdenarMaestro :nEstacion, :tTabla, @Cuenta = :tCorrida<T>, EstacionTrabajo, <T>AutoCorridaPlantilla<T>, Info.Corrida)

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.AutoCorridaPlantilla.Articulo]
Carpeta=Lista
Clave=AutoCorridaPlantilla.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Ordenar
Ordenar=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AutoCorridaPlantilla.Articulo
AutoCorridaPlantilla.Articulo=Art.Descripcion1
Art.Descripcion1=(Fin)
