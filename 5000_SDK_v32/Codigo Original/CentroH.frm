[Forma]
Clave=CentroH
Nombre=Centros Trabajo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=128
PosicionInicialArriba=142
PosicionInicialAltura=484
PosicionInicialAncho=768
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Centro
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
OtroOrden=S
ListaOrden=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CentroTipo
FiltroAplicaEn1=Centro.Tipo
FiltroTodo=S
HojaAjustarColumnas=S

[Lista.Centro.Centro]
Carpeta=Lista
Clave=Centro.Centro
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Centro.CostoManoObra]
Carpeta=Lista
Clave=Centro.CostoManoObra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Centro.CostoIndirectos]
Carpeta=Lista
Clave=Centro.CostoIndirectos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Centro.CostoMoneda]
Carpeta=Lista
Clave=Centro.CostoMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
Centro=104
TiempoEntrada=100
TiempoSalida=114
CostoManoObra=139
CostoIndirectos=132
CostoMoneda=62
Descripcion=128
Tipo=70
Almacen=87
TiempoCola=100
TiempoEspera=112

[Lista.Centro.Descripcion]
Carpeta=Lista
Clave=Centro.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Centro.Tipo]
Carpeta=Lista
Clave=Centro.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Centro.Almacen]
Carpeta=Lista
Clave=Centro.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Centro.TiempoCola]
Carpeta=Lista
Clave=Centro.TiempoCola
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Centro.TiempoEspera]
Carpeta=Lista
Clave=Centro.TiempoEspera
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=Centro.Centro
Centro.Centro=Centro.TiempoCola
Centro.TiempoCola=Centro.TiempoEspera
Centro.TiempoEspera=Centro.CostoManoObra
Centro.CostoManoObra=Centro.CostoIndirectos
Centro.CostoIndirectos=Centro.CostoMoneda
Centro.CostoMoneda=Centro.Descripcion
Centro.Descripcion=Centro.Tipo
Centro.Tipo=Centro.Almacen
Centro.Almacen=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Centro.Centro
Centro.Centro=Centro.Descripcion
Centro.Descripcion=Centro.Tipo
Centro.Tipo=(Fin)

[Lista.ListaOrden]
(Inicio)=Centro.Orden<TAB>(Acendente)
Centro.Orden<TAB>(Acendente)=Centro.Centro<TAB>(Acendente)
Centro.Centro<TAB>(Acendente)=(Fin)
