[Forma]
Clave=Clase
Nombre=<T>Clasificaciones - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=616
PosicionInicialArriba=371
PosicionInicialAltura=450
PosicionInicialAncho=688
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=
VentanaEscCerrar=
PosicionInicialAlturaCliente=423
PosicionColumna1=38
PosicionCol1=242

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Clase
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Clase.Clase
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=(Lista)
HojaMantenerSeleccion=S
FiltroGeneral=Clase.Modulo=<T>{Info.Modulo}<T>

[Lista.Clase.Clase]
Carpeta=Lista
Clave=Clase.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
GuardarAntes=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Clase:Clase.Clase)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Lista.Columnas]
Clase=211
Orden=50
Cuenta=94
Descripcion=226

[Acciones.SubClase]
Nombre=SubClase
Boton=47
NombreEnBoton=S
NombreDesplegar=&Subclasificaciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SubClase
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Clase:Clase.Clase)
AntesExpresiones=Asigna(Info.Clase, Clase:Clase.Clase)

[Acciones.Ordear]
Nombre=Ordear
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
AntesExpresiones=Forma(<T>ClaseOrdenar<T>)
DespuesGuardar=S

[Acciones.Comentarios]
Nombre=Comentarios
Boton=57
NombreDesplegar=&Comentarios
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ClaseComentarios
Activo=S
ConCondicion=S
Antes=S
Visible=S
GuardarAntes=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Clase:Clase.Clase)
AntesExpresiones=Asigna(Info.Clase, Clase:Clase.Clase)

[Acciones.Tareas]
Nombre=Tareas
Boton=70
NombreDesplegar=&Tareas por Omisión
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ClaseTarea
Activo=S
Visible=S
ConCondicion=S
Antes=S
GuardarAntes=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(Clase:Clase.Clase)
AntesExpresiones=Asigna(Info.Clase, Clase:Clase.Clase)<BR>Asigna(Info.SubClase, Nulo)

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Clase
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S

[Ficha.Clase.Clase]
Carpeta=Ficha
Clave=Clase.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Clase.Cuenta]
Carpeta=Ficha
Clave=Clase.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Cta.Descripcion]
Carpeta=Ficha
Clave=Cta.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=29
ColorFondo=Plata
ColorFuente=Negro

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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nueva
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Ficha.Clase.Responsable]
Carpeta=Ficha
Clave=Clase.Responsable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Usuario.Nombre]
Carpeta=Ficha
Clave=Usuario.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=29
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Prorrateo]
Nombre=Prorrateo
Boton=61
NombreEnBoton=S
NombreDesplegar=&Prorrateo por Omisión
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ClaseProrrateo
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Clase:Clase.Clase)
Antes=S
AntesExpresiones=Asigna(Info.Clase, Clase:Clase.Clase)<BR>Asigna(Info.SubClase, Nulo)
Visible=S

[Ficha.Clase.Numero]
Carpeta=Ficha
Clave=Clase.Numero
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Clase.Descripcion]
Carpeta=Ficha
Clave=Clase.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=50x3
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Eliminar
Eliminar=SubClase
SubClase=Comentarios
Comentarios=Tareas
Tareas=Prorrateo
Prorrateo=Navegador
Navegador=Ordear
Ordear=(Fin)

[Lista.ListaOrden]
(Inicio)=Clase.Orden<TAB>(Acendente)
Clase.Orden<TAB>(Acendente)=Clase.Clase<TAB>(Acendente)
Clase.Clase<TAB>(Acendente)=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Clase.Clase
Clase.Clase=Clase.Numero
Clase.Numero=Clase.Descripcion
Clase.Descripcion=Clase.Cuenta
Clase.Cuenta=Cta.Descripcion
Cta.Descripcion=Clase.Responsable
Clase.Responsable=Usuario.Nombre
Usuario.Nombre=(Fin)
