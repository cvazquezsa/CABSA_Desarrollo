[Forma]
Clave=SAUXServicio
Nombre=Servicios
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=416
PosicionInicialArriba=201
PosicionInicialAlturaCliente=408
PosicionInicialAncho=767
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionCol1=232
PosicionSec1=367
Menus=S

MenuPrincipal=(Lista)
[Lista.Recurso.Recurso]
Carpeta=Lista
Clave=Recurso.Recurso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Recurso.Nombre]
Carpeta=Lista
Clave=Recurso.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Recurso.Estatus]
Carpeta=Lista
Clave=Recurso.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Recurso.Grupo]
Carpeta=Lista
Clave=Recurso.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Recurso=68
Nombre=201
Personal=64
Agente=64
Usuario=57
Estatus=56
Grupo=152
eMail=134
NombreExchange=136

Servicio=201
[Acciones.Grupos]
Nombre=Grupos
Boton=91
NombreEnBoton=S
NombreDesplegar=&Grupos
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SAUXServicioGrupo
Activo=S
Visible=S
Menu=&Maestros
EnMenu=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
EnMenu=S

Carpeta=(Carpeta principal)
EspacioPrevio=S
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar ...
EnBarraHerramientas=S
ConfirmarAntes=S
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
EspacioPrevio=S
Menu=&Archivo
EnMenu=S

Activo=S
Carpeta=(Carpeta principal)
ConCondicion=S
EjecucionCondicion=SI SQL(<T>IF EXISTS (SELECT * FROM ArtMaterial WHERE LugarConsumo = :tServicio) SELECT 1 ELSE SELECT 0<T>, SAUXServicio:SAUXServicio.Servicio)=1<BR>Entonces<BR>  Falso<BR>  Error(<T>No se Puede Eliminar el Servicio porque tiene artículos asociados<T>)<BR>SiNo<BR>  Verdadero<BR>Fin
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=SAUXServicio
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






PestanaOtroNombre=S
PestanaNombre=Servicios
[Lista.Recurso.NombreExchange]
Carpeta=Lista
Clave=Recurso.NombreExchange
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro







[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=SAUXServicio
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Servicio<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=SAUXServicio.Descripcion
ListaOrden=SAUXServicio.Servicio<TAB>(Acendente)
FiltroPredefinido=S
FiltroGrupo1=SAUXServicio.Grupo
FiltroValida1=SAUXServicio.Grupo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
CarpetaVisible=S
FiltroTodo=S


PestanaOtroNombre=S
PestanaNombre=Servicios
IconosNombre=SAUXServicio:SAUXServicio.Servicio
[(Carpeta Abrir).Columnas]
0=122
1=435


[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=Guardar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

NombreEnBoton=S
EnBarraHerramientas=S
[Acciones.Excel]
Nombre=Excel
Boton=0
Menu=&Archivo
NombreDesplegar=Excel ...
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S









ActivoCondicion=Usuario.EnviarExcel
[Ficha.SAUXServicio.Estatus]
Carpeta=Ficha
Clave=SAUXServicio.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SAUXServicio.Grupo]
Carpeta=Ficha
Clave=SAUXServicio.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SAUXServicio.Servicio]
Carpeta=Ficha
Clave=SAUXServicio.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SAUXServicio.Descripcion]
Carpeta=Ficha
Clave=SAUXServicio.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=54
[Ficha.SAUXServicio.Descripcion2]
Carpeta=Ficha
Clave=SAUXServicio.Descripcion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=54
ColorFondo=Blanco

[Ficha.SAUXServicio.Categoria]
Carpeta=Ficha
Clave=SAUXServicio.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SAUXServicio.Familia]
Carpeta=Ficha
Clave=SAUXServicio.Familia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SAUXServicio.Tipo]
Carpeta=Ficha
Clave=SAUXServicio.Tipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Acciones.Familia]
Nombre=Familia
Boton=0
Menu=&Maestros
NombreDesplegar=Familia
EnMenu=S
TipoAccion=Formas
ClaveAccion=SAUXServicioFamilia
Activo=S
Visible=S



[Acciones.Categoria]
Nombre=Categoria
Boton=0
Menu=&Maestros
NombreDesplegar=Categoria
EnMenu=S
TipoAccion=Formas
ClaveAccion=SAUXServicioCategoria
Activo=S
Visible=S




































[(Carpeta Abrir).SAUXServicio.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=SAUXServicio.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco











[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BAJA
BAJA=(Fin)



































[Ficha.SAUXServicio.Movimiento]
Carpeta=Ficha
Clave=SAUXServicio.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


















































































[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SAUXServicio
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
ListaEnCaptura=SAUXServicio.Servicio
CarpetaVisible=S

[Lista.SAUXServicio.Servicio]
Carpeta=Lista
Clave=SAUXServicio.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



















[Ficha.ListaEnCaptura]
(Inicio)=SAUXServicio.Servicio
SAUXServicio.Servicio=SAUXServicio.Estatus
SAUXServicio.Estatus=SAUXServicio.Descripcion
SAUXServicio.Descripcion=SAUXServicio.Descripcion2
SAUXServicio.Descripcion2=SAUXServicio.Categoria
SAUXServicio.Categoria=SAUXServicio.Familia
SAUXServicio.Familia=SAUXServicio.Grupo
SAUXServicio.Grupo=SAUXServicio.Tipo
SAUXServicio.Tipo=SAUXServicio.Movimiento
SAUXServicio.Movimiento=(Fin)
































































[Acciones.SAUXServIndicador]
Nombre=SAUXServIndicador
Boton=47
NombreEnBoton=S
NombreDesplegar=&Indicadores
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=SAUXServIndicador
Activo=S
Visible=S







EspacioPrevio=S












Antes=S
AntesExpresiones=Asigna(Info.Servicio,SAUXServicio:SAUXServicio.Servicio)<BR>Asigna(Info.Descripcion,SAUXServicio:SAUXServicio.Descripcion)













































[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Guardar Cambios
Guardar Cambios=Eliminar
Eliminar=Grupos
Grupos=Categoria
Categoria=Familia
Familia=SAUXServIndicador
SAUXServIndicador=Excel
Excel=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Maestros
&Maestros=(Fin)
