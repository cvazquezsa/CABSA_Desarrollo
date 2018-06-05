[Forma]
Clave=Fase
Nombre=Fases del Proyecto
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=523
PosicionInicialArriba=341
PosicionInicialAlturaCliente=490
PosicionInicialAncho=873
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Comentarios=Info.Proyecto
ExpresionesAlMostrar=Asigna(Info.Fase, Nulo)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Fase
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=Fase.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
FiltroGeneral=Fase.ProyectoID={Info.ID}

[Lista.Fase.Fase]
Carpeta=Lista
Clave=Fase.Fase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Fase.Nombre]
Carpeta=Lista
Clave=Fase.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Fase.Peso]
Carpeta=Lista
Clave=Fase.Peso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Fase.Predecesora]
Carpeta=Lista
Clave=Fase.Predecesora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Fase.EsAgrupador]
Carpeta=Lista
Clave=Fase.EsAgrupador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Fase=64
Nombre=359
Peso=46
Predecesora=64
EsAgrupador=40
Color=70
Categoria=96
Grupo=87
Familia=82

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Actividades]
Nombre=Actividades
Boton=70
NombreEnBoton=S
NombreDesplegar=&Actividades
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ProyectoAct
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Fase:Fase.Fase)
AntesExpresiones=Asigna(Info.Fase, Fase:Fase.Fase)<BR>Asigna(Info.Nombre, Fase:Fase.Nombre)

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
GuardarAntes=S
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S
EspacioPrevio=S

[Lista.Fase.Categoria]
Carpeta=Lista
Clave=Fase.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Fase.Grupo]
Carpeta=Lista
Clave=Fase.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Fase.Familia]
Carpeta=Lista
Clave=Fase.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Actividades
Actividades=Actualizar
Actualizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Fase.Fase
Fase.Fase=Fase.Nombre
Fase.Nombre=Fase.Predecesora
Fase.Predecesora=Fase.EsAgrupador
Fase.EsAgrupador=Fase.Categoria
Fase.Categoria=Fase.Grupo
Fase.Grupo=Fase.Familia
Fase.Familia=Fase.Peso
Fase.Peso=(Fin)
