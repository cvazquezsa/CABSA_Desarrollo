[Forma]
Clave=ListaPrecios
Nombre=Listas Precios Específicos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAltura=314
PosicionInicialAncho=956
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=482
PosicionInicialArriba=344
PosicionInicialAlturaCliente=476

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ListaPrecios
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)
HojaTitulos=S
HojaMostrarColumnas=S
OtroOrden=S
ListaOrden=(Lista)
Filtros=S
FiltroAplicaEn=ListaPrecios.Grupo
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=ListaPreciosGrupo
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=20
FiltroEstilo=Directorio
FiltroRespetar=S
FiltroTipo=Automático

[Lista.ListaPrecios.Lista]
Carpeta=Lista
Clave=ListaPrecios.Lista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar 
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S
GuardarAntes=S

[Lista.Columnas]
Lista=166
Moneda=68
PreciosNetos=72
Nombre=304
Grupo=99
Zona=93
NivelAcceso=86
Descripcion=239
Region=97

[Acciones.Editar]
Nombre=Editar
Boton=47
NombreEnBoton=S
NombreDesplegar=E&ditar Lista
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ListaPreciosD
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=ConDatos(ListaPrecios:ListaPrecios.Lista) y ConDatos(ListaPrecios:ListaPrecios.Moneda)
AntesExpresiones=Asigna(Info.Lista, ListaPrecios:ListaPrecios.Lista)<BR>Asigna(Info.Moneda, ListaPrecios:ListaPrecios.Moneda)<BR>Asigna(Info.TipoCambio, ListaPrecios:Mon.TipoCambio)

[Lista.ListaPrecios.Moneda]
Carpeta=Lista
Clave=ListaPrecios.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaPrecios.PreciosNetos]
Carpeta=Lista
Clave=ListaPrecios.PreciosNetos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaPrecios.Grupo]
Carpeta=Lista
Clave=ListaPrecios.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaPrecios.Zona]
Carpeta=Lista
Clave=ListaPrecios.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaPrecios.Descripcion]
Carpeta=Lista
Clave=ListaPrecios.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaPrecios.NivelAcceso]
Carpeta=Lista
Clave=ListaPrecios.NivelAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Grupos]
Nombre=Grupos
Boton=91
NombreDesplegar=&Grupos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ListaPreciosGrupo
Activo=S
Visible=S
NombreEnBoton=S

[Lista.ListaPrecios.Region]
Carpeta=Lista
Clave=ListaPrecios.Region
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Herramienta]
Nombre=Herramienta
Boton=61
NombreEnBoton=S
NombreDesplegar=&Herramienta
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ListaPreciosD_H1
Visible=S
ConCondicion=S
Antes=S
ActivoCondicion=Config.PC_H1
EjecucionCondicion=ConDatos(ListaPrecios:ListaPrecios.Lista) y ConDatos(ListaPrecios:ListaPrecios.Moneda) y ConDatos(ListaPrecios:ListaPrecios.Region)
EjecucionMensaje=<T>Falta Configurar Moneda o Región<T>
EjecucionConError=S
AntesExpresiones=Asigna(Info.Lista, ListaPrecios:ListaPrecios.Lista)<BR>Asigna(Info.Moneda, ListaPrecios:ListaPrecios.Moneda)<BR>Asigna(Info.TipoCambio, ListaPrecios:Mon.TipoCambio)<BR>Asigna(Info.Region, ListaPrecios:ListaPrecios.Region)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Editar
Editar=Herramienta
Herramienta=Grupos
Grupos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ListaPrecios.Lista
ListaPrecios.Lista=ListaPrecios.Descripcion
ListaPrecios.Descripcion=ListaPrecios.Moneda
ListaPrecios.Moneda=ListaPrecios.PreciosNetos
ListaPrecios.PreciosNetos=ListaPrecios.Grupo
ListaPrecios.Grupo=ListaPrecios.Zona
ListaPrecios.Zona=ListaPrecios.Region
ListaPrecios.Region=ListaPrecios.NivelAcceso
ListaPrecios.NivelAcceso=(Fin)

[Lista.ListaOrden]
(Inicio)=ListaPrecios.Lista<TAB>(Acendente)
ListaPrecios.Lista<TAB>(Acendente)=Mon.Orden<TAB>(Acendente)
Mon.Orden<TAB>(Acendente)=(Fin)
