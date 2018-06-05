[Forma]
Clave=PersonalProp
Nombre=Propiedades de la Nómina
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=581
PosicionInicialArriba=341
PosicionInicialAltura=525
PosicionInicialAncho=758
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=73
PosicionInicialAlturaCliente=490
PosicionColumna1=56
PosicionCol1=418

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalProp
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
OtroOrden=S
ListaEnCaptura=PersonalProp.Propiedad
ListaOrden=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=PersonalPropCat
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroAplicaEn=PersonalProp.Categoria
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=PersonalPropCat
FiltroAplicaEn1=PersonalProp.Categoria
FiltroTodo=S
FiltroNull=S

[Lista.PersonalProp.Propiedad]
Carpeta=Lista
Clave=PersonalProp.Propiedad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Propiedad=235
Categoria=72
porOmision=84
NivelEmpresa=72
NivelCategoria=77
NivelPersonal=70
NivelSucursal=70
NivelPuesto=62

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
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(PersonalProp:PersonalProp.Propiedad)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Detalle.PersonalProp.Propiedad]
Carpeta=Detalle
Clave=PersonalProp.Propiedad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.PersonalProp.Categoria]
Carpeta=Detalle
Clave=PersonalProp.Categoria
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.PersonalProp.NivelEmpresa]
Carpeta=Detalle
Clave=PersonalProp.NivelEmpresa
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S
Tamano=15

[Detalle.PersonalProp.NivelCategoria]
Carpeta=Detalle
Clave=PersonalProp.NivelCategoria
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=15

[Detalle.PersonalProp.NivelPersonal]
Carpeta=Detalle
Clave=PersonalProp.NivelPersonal
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=15

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nueva
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Detalle.PersonalProp.porOmision]
Carpeta=Detalle
Clave=PersonalProp.porOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
GuardarAntes=S
AntesExpresiones=Forma(<T>PersonalPropOrdenar<T>)
DespuesGuardar=S

[Acciones.Categorias]
Nombre=Categorias
Boton=91
NombreEnBoton=S
NombreDesplegar=Categorías
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S
Antes=S
Carpeta=(Carpeta principal)
AntesExpresiones=Forma(<T>PersonalPropCat<T>)

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=PersonalProp
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.PersonalProp.Propiedad]
Carpeta=Ficha
Clave=PersonalProp.Propiedad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.PersonalProp.Categoria]
Carpeta=Ficha
Clave=PersonalProp.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PersonalProp.porOmision]
Carpeta=Ficha
Clave=PersonalProp.porOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PersonalProp.NivelEmpresa]
Carpeta=Ficha
Clave=PersonalProp.NivelEmpresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PersonalProp.NivelSucursal]
Carpeta=Ficha
Clave=PersonalProp.NivelSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PersonalProp.NivelPuesto]
Carpeta=Ficha
Clave=PersonalProp.NivelPuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PersonalProp.NivelCategoria]
Carpeta=Ficha
Clave=PersonalProp.NivelCategoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PersonalProp.NivelPersonal]
Carpeta=Ficha
Clave=PersonalProp.NivelPersonal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PersonalProp.TipoDatos]
Carpeta=Ficha
Clave=PersonalProp.TipoDatos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PersonalProp.LongitudMaxima]
Carpeta=Ficha
Clave=PersonalProp.LongitudMaxima
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.PersonalProp.Nombre]
Carpeta=Ficha
Clave=PersonalProp.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PersonalProp.Descripcion]
Carpeta=Ficha
Clave=PersonalProp.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=N
Tamano=30x3
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Paises]
Nombre=Paises
Boton=47
NombreEnBoton=S
NombreDesplegar=&Paises
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PersonalPropPais
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(PersonalProp:PersonalProp.Propiedad)
Antes=S
AntesExpresiones=Asigna(Info.Propiedad, PersonalProp:PersonalProp.Propiedad)
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Paises
Paises=Ordenar
Ordenar=Categorias
Categorias=Navegador
Navegador=(Fin)

[Lista.ListaOrden]
(Inicio)=PersonalProp.Categoria<TAB>(Acendente)
PersonalProp.Categoria<TAB>(Acendente)=PersonalProp.Orden<TAB>(Acendente)
PersonalProp.Orden<TAB>(Acendente)=PersonalProp.Propiedad<TAB>(Acendente)
PersonalProp.Propiedad<TAB>(Acendente)=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=PersonalProp.Propiedad
PersonalProp.Propiedad=PersonalProp.Nombre
PersonalProp.Nombre=PersonalProp.Descripcion
PersonalProp.Descripcion=PersonalProp.Categoria
PersonalProp.Categoria=PersonalProp.porOmision
PersonalProp.porOmision=PersonalProp.TipoDatos
PersonalProp.TipoDatos=PersonalProp.LongitudMaxima
PersonalProp.LongitudMaxima=PersonalProp.NivelEmpresa
PersonalProp.NivelEmpresa=PersonalProp.NivelSucursal
PersonalProp.NivelSucursal=PersonalProp.NivelPuesto
PersonalProp.NivelPuesto=PersonalProp.NivelCategoria
PersonalProp.NivelCategoria=PersonalProp.NivelPersonal
PersonalProp.NivelPersonal=(Fin)
