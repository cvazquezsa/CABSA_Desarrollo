[Forma]
Clave=InstrumentoLista
Nombre=Instrumentos
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=673
PosicionInicialArriba=429
PosicionInicialAltura=333
PosicionInicialAncho=574
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=306

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Instrumento
Fuente={MS Sans Serif, 8, Negro, []}
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
FiltroPredefinido=S
FiltroAncho=15
FiltroGrupo1=(Validaciones Memoria)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
HojaMantenerSeleccion=S
FiltroValida1=Mon
FiltroAplicaEn1=Instrumento.Moneda
OtroOrden=
MenuLocal=S
ListaAcciones=Actualizar
PermiteLocalizar=S

[Lista.Instrumento.Instrumento]
Carpeta=Lista
Clave=Instrumento.Instrumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Instrumento.Descripcion]
Carpeta=Lista
Clave=Instrumento.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Lista.Columnas]
Instrumento=95
Descripcion=263
CtaDinero=64
Moneda=65

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.Instrumento.Moneda]
Carpeta=Lista
Clave=Instrumento.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=Instrumento.Instrumento
Instrumento.Instrumento=Instrumento.Descripcion
Instrumento.Descripcion=Instrumento.Moneda
Instrumento.Moneda=(Fin)
