[Forma]
Clave=PersonalPropValor
Nombre=e(<T>Propiedades<T>)+<T> - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=665
PosicionInicialArriba=406
PosicionInicialAltura=388
PosicionInicialAncho=590
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=361

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalPropValor
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=PersonalProp.Categoria
FiltroAutoValidar=PersonalProp.Categoria
FiltroAutoOrden=PersonalProp.Orden
FiltroGrupo1=PersonalProp.Categoria
FiltroValida1=PersonalProp.Categoria
FiltroEstilo=Folder (1 línea)
FiltroAncho=30
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Automático
FiltroEnOrden=S
OtroOrden=S
ListaOrden=(Lista)
ValidarCampos=S
ListaCamposAValidar=PersonalProp.Descripcion
HojaMantenerSeleccion=S
FiltroGeneral=PersonalPropValor.Rama=<T>{Info.Rama}<T> AND<BR>PersonalPropValor.Cuenta=<T>{Info.Cuenta}<T>

[Lista.PersonalPropValor.Valor]
Carpeta=Lista
Clave=PersonalPropValor.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Propiedad=206
Valor=178
Nombre=375

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Lista.PersonalProp.Nombre]
Carpeta=Lista
Clave=PersonalProp.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Guardar
Guardar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PersonalProp.Nombre
PersonalProp.Nombre=PersonalPropValor.Valor
PersonalPropValor.Valor=(Fin)

[Lista.ListaOrden]
(Inicio)=PersonalProp.Orden<TAB>(Acendente)
PersonalProp.Orden<TAB>(Acendente)=PersonalPropValor.Propiedad<TAB>(Acendente)
PersonalPropValor.Propiedad<TAB>(Acendente)=(Fin)
