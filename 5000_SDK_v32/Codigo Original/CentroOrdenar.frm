[Forma]
Clave=CentroOrdenar
Nombre=Cambiar Orden - Centros Trabajo
Icono=48
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=270
PosicionInicialArriba=185
PosicionInicialAltura=398
PosicionInicialAncho=484
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraHerramientas=S
ListaAcciones=(Lista)
Comentarios=<T>Utilice arrastrar y soltar para cambiar el orden<T>

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Centro
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Orden<T>
ElementosPorPagina=200
IconosCambiarOrden=S
OtroOrden=S
ListaOrden=Centro.Orden<TAB>(Acendente)
PestanaOtroNombre=S
PestanaNombre=Registros
IconosNombre=Centro:Centro.Orden
IconosNombreNumerico=S

[Lista.Centro.Descripcion]
Carpeta=Lista
Clave=Centro.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Orden=42
Centro=114
Descripcion=236
0=45
1=119

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

[Acciones.Ordenar]
Nombre=Ordenar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar Nuevo Orden
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S
ClaveAccion=Cerrar
Antes=S
AntesExpresiones=RegistrarListaSt(<T>Lista<T>, <T>Centro.Centro<T>)<BR>EjecutarSQL(<T>spOrdenarMaestro :nEstacion, :tTabla<T>, EstacionTrabajo, <T>Centro<T>)

[Lista.Centro.Centro]
Carpeta=Lista
Clave=Centro.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Ordenar
Ordenar=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Centro.Centro
Centro.Centro=Centro.Descripcion
Centro.Descripcion=(Fin)
