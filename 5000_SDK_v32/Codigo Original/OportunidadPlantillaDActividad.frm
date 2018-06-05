
[Forma]
Clave=OportunidadPlantillaDActividad
Icono=4
Modulos=(Todos)
Nombre=Actividades por Etapa

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=389
PosicionInicialArriba=274
PosicionInicialAlturaCliente=279
PosicionInicialAncho=662
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
ListaAcciones=Cerrar
Comentarios=Lista(<T>Oportunidad: <T> + Info.Concepto, <T>Etapa: <T> + Info.Dato)
PosicionCol1=169
PosicionSec1=144
MovModulo=OPORT
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadPlantillaDActividad
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Gris
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


HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=OportunidadPlantillaDActividad.Actividad<TAB>(Acendente)
HojaPermiteInsertar=S
HojaPermiteEliminar=S
PermiteEditar=S
FiltroGeneral=OportunidadPlantillaDActividad.ID = <T>{Info.ID}<T> AND<BR>OportunidadPlantillaDActividad.Etapa = <T>{Info.Dato}<T>
[Lista.Columnas]
Actividad=70
Titulo=142
Persona=169
Email=167
Concepto=150

0=-2
1=232
2=-2
Recurso=73
Nombre=162
Texto=205

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S














[Detalle.OportunidadPlantillaDActividad.Texto]
Carpeta=Detalle
Clave=OportunidadPlantillaDActividad.Texto
Editar=S
LineaNueva=S
3D=S
Tamano=59x10
ColorFondo=Blanco

















[Lista.OportunidadPlantillaDActividad.Actividad]
Carpeta=Lista
Clave=OportunidadPlantillaDActividad.Actividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco








































[Detalle.ListaEnCaptura]
(Inicio)=OportunidadPlantillaDActividad.Actividad
OportunidadPlantillaDActividad.Actividad=OportunidadPlantillaDActividad.Titulo
OportunidadPlantillaDActividad.Titulo=OportunidadPlantillaDActividad.Recurso
OportunidadPlantillaDActividad.Recurso=Recurso.Nombre
Recurso.Nombre=OportunidadPlantillaDActividad.Concepto
OportunidadPlantillaDActividad.Concepto=OportunidadPlantillaDActividad.Texto
OportunidadPlantillaDActividad.Texto=(Fin)
































[Lista.OportunidadPlantillaDActividad.Titulo]
Carpeta=Lista
Clave=OportunidadPlantillaDActividad.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco









[Lista.OportunidadPlantillaDActividad.Email]
Carpeta=Lista
Clave=OportunidadPlantillaDActividad.Email
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.OportunidadPlantillaDActividad.Recurso]
Carpeta=Lista
Clave=OportunidadPlantillaDActividad.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco







[Lista.Recurso.Nombre]
Carpeta=Lista
Clave=Recurso.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



ColorFuente=Gris







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=OportunidadPlantillaDActividad.Actividad
OportunidadPlantillaDActividad.Actividad=OportunidadPlantillaDActividad.Titulo
OportunidadPlantillaDActividad.Titulo=OportunidadPlantillaDActividad.Recurso
OportunidadPlantillaDActividad.Recurso=Recurso.Nombre
Recurso.Nombre=OportunidadPlantillaDActividad.Email
OportunidadPlantillaDActividad.Email=(Fin)
