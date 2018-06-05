[Forma]
Clave=SubClase
Nombre=<T>Subclasificaciones<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAltura=306
PosicionInicialAncho=713
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=603
PosicionInicialArriba=418
Comentarios=Info.Clase
PosicionInicialAlturaCliente=329
PosicionColumna1=43
PosicionCol1=281

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SubClase
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
FiltroGeneral=SubClase.Modulo=<T>{Info.Modulo}<T> AND SubClase.Clase=<T>{Info.Clase}<T>

[Lista.SubClase.SubClase]
Carpeta=Lista
Clave=SubClase.SubClase
Editar=N
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
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(SubClase:SubClase.SubClase)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Lista.Columnas]
SubClase=210
Orden=37
Cuenta=104
Descripcion=212

[Lista.SubClase.Orden]
Carpeta=Lista
Clave=SubClase.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Comentarios]
Nombre=Comentarios
Boton=57
NombreDesplegar=&Comentarios
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SubClaseComentarios
Activo=S
ConCondicion=S
Antes=S
Visible=S
GuardarAntes=S
EjecucionCondicion=ConDatos(SubClase:SubClase.SubClase)
AntesExpresiones=Asigna(Info.SubClase, SubClase:SubClase.SubClase)

[Acciones.Tareas]
Nombre=Tareas
Boton=70
NombreDesplegar=&Tareas por Omisión
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ClaseTarea
Activo=S
Visible=S
Antes=S
ConCondicion=S
GuardarAntes=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(SubClase:SubClase.SubClase)
AntesExpresiones=Asigna(Info.SubClase, SubClase:SubClase.SubClase)

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=SubClase
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

[Ficha.SubClase.SubClase]
Carpeta=Ficha
Clave=SubClase.SubClase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.SubClase.Cuenta]
Carpeta=Ficha
Clave=SubClase.Cuenta
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

[Ficha.SubClase.InflacionPresupuesto]
Carpeta=Ficha
Clave=SubClase.InflacionPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
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
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(SubClase:SubClase.SubClase)
AntesExpresiones=Asigna(Info.SubClase, SubClase:SubClase.SubClase)

[Ficha.SubClase.Numero]
Carpeta=Ficha
Clave=SubClase.Numero
Editar=S
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.SubClase.Descripcion]
Carpeta=Ficha
Clave=SubClase.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
Eliminar=Comentarios
Comentarios=Tareas
Tareas=Prorrateo
Prorrateo=Navegador
Navegador=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SubClase.SubClase
SubClase.SubClase=SubClase.Orden
SubClase.Orden=(Fin)

[Lista.ListaOrden]
(Inicio)=SubClase.Orden<TAB>(Acendente)
SubClase.Orden<TAB>(Acendente)=SubClase.SubClase<TAB>(Acendente)
SubClase.SubClase<TAB>(Acendente)=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=SubClase.SubClase
SubClase.SubClase=SubClase.Numero
SubClase.Numero=SubClase.Descripcion
SubClase.Descripcion=SubClase.Cuenta
SubClase.Cuenta=Cta.Descripcion
Cta.Descripcion=SubClase.InflacionPresupuesto
SubClase.InflacionPresupuesto=(Fin)
