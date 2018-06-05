[Forma]
Clave=EmpresaLista
Nombre=<T>Empresas<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=658
PosicionInicialArriba=380
PosicionInicialAltura=300
PosicionInicialAncho=603
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=412

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Empresa
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=EmpresaGrupo
FiltroEstilo=Folder (1 línea)
FiltroAplicaEn=Empresa.Grupo
FiltroAncho=30
FiltroTipo=Automático
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroTodoFinal=S
FiltroNullNombre=(sin clasificar)
FiltroGeneral=
FiltroRespetar=S
CarpetaVisible=S
MenuLocal=S
ListaAcciones=SeleccionarTodo

[Lista.Empresa.Empresa]
Carpeta=Lista
Clave=Empresa.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100

[Lista.Empresa.Nombre]
Carpeta=Lista
Clave=Empresa.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100

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

[Lista.Columnas]
Empresa=71
Nombre=371

[Acciones.SeleccionarTodo]
Nombre=SeleccionarTodo
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=Empresa.Empresa
Empresa.Empresa=Empresa.Nombre
Empresa.Nombre=(Fin)
