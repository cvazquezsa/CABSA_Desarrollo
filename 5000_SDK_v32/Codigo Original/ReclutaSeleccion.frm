
[Forma]
Clave=ReclutaSeleccion
Icono=0
Modulos=(Todos)
Nombre=Seleccionar Personal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Mov, Info.MovID)
ListaAcciones=(Lista)
PosicionInicialIzquierda=263
PosicionInicialArriba=158
PosicionInicialAlturaCliente=415
PosicionInicialAncho=840
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Movimientos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ReclutaA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
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
OtroOrden=S
ListaOrden=Calificacion<TAB>(Decendente)
IconosNombre=ReclutaA:Recluta.Mov+<T> <T>+ReclutaA:Recluta.MovID
FiltroGeneral=Recluta.OrigenTipo=<T>RE<T> AND Recluta.Origen=<T>{Info.Mov}<T> AND Recluta.OrigenID=<T>{Info.MovID}<T> AND Recluta.Estatus=<T>CONCLUIDO<T>
[Lista.Recluta.FechaEmision]
Carpeta=Lista
Clave=Recluta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Recluta.Personal]
Carpeta=Lista
Clave=Recluta.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.NombreCompleto]
Carpeta=Lista
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Lista.Recluta.Puesto]
Carpeta=Lista
Clave=Recluta.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Calificacion]
Carpeta=Lista
Clave=Calificacion
Editar=S
Totalizador=2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Lista.Columnas]
0=128
1=84
2=62
3=186
4=113
5=94
6=73

7=51
8=-2
[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S












[Acciones.Detalles]
Nombre=Detalles
Boton=57
NombreEnBoton=S
NombreDesplegar=&Detalles
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=ReportePantalla(ReporteMovPantalla(<T>RE<T>, ReclutaA:Recluta.Mov, ReclutaA:Recluta.Estatus), ReclutaA:Recluta.ID)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ReclutaA:Recluta.ID)
Visible=S










[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
ConCondicion=S
Visible=S

















ClaveAccion=Aceptar
EjecucionCondicion=Asigna(Info.ID, ReclutaA:Recluta.ID)             <BR>ConDatos(ReclutaA:Recluta.ID)







[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S





[Lista.Califica]
Carpeta=Lista
Clave=Califica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Lista.ListaEnCaptura]
(Inicio)=Recluta.FechaEmision
Recluta.FechaEmision=Recluta.Personal
Recluta.Personal=NombreCompleto
NombreCompleto=Recluta.Puesto
Recluta.Puesto=Califica
Califica=Calificacion
Calificacion=(Fin)









[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=Detalles
Detalles=Personalizar
Personalizar=(Fin)
