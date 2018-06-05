[Forma]
Clave=UnidadOrdenar
Nombre=Ordenar Unidades
Icono=48
BarraAyuda=S
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=304
PosicionInicialArriba=208
PosicionInicialAltura=344
PosicionInicialAncho=416
Comentarios=<T>Utilice arrastrar y soltar para cambiar el orden<T>
PosicionInicialAlturaCliente=317

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Registros
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Unidad
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaOrden=Unidad.Orden<TAB>(Acendente)
CarpetaVisible=S
ListaEnCaptura=Unidad.Unidad
IconosCambiarOrden=S
IconosSubTitulo=<T>Orden<T>
IconosNombre=Unidad:Unidad.Orden

[Acciones.Ordenar]
Nombre=Ordenar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar Nuevo Orden
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
Antes=S
AntesExpresiones=RegistrarListaSt(<T>Lista<T>, <T>Unidad.Unidad<T>)<BR>EjecutarSQL(<T>spOrdenarMaestro :nEstacion, :tTabla<T>, EstacionTrabajo, <T>Unidad<T>)

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

[Lista.Columnas]
0=47
1=173

[Lista.Unidad.Unidad]
Carpeta=Lista
Clave=Unidad.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Ordenar
Ordenar=Campos
Campos=(Fin)
