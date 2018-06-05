[Forma]
Clave=SAUXIndicador
Nombre=Indicadores
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=409
PosicionInicialArriba=206
PosicionInicialAlturaCliente=419
PosicionInicialAncho=782
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionCol1=253
PosicionSec1=192
Menus=S

CarpetasMultilinea=S
PosicionSec2=144
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

Indicador=219
[Acciones.Grupos]
Nombre=Grupos
Boton=91
NombreEnBoton=S
NombreDesplegar=&Grupos
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SAUXIndicadorGrupo
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

EspacioPrevio=S
Carpeta=(Carpeta principal)
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
EjecucionCondicion=SQL(<T>IF EXISTS (SELECT * FROM SAUXServIndicador WHERE Indicador = :tIndicador) SELECT 1 ELSE SELECT 0<T>, SAUXIndicador:SAUXIndicador.Indicador)= 0
EjecucionMensaje=<T>El indicador tiene servicios asociados<T>
EjecucionConError=S
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=SAUXIndicador
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
PestanaNombre=Indicadores
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
Vista=SAUXIndicador
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Indicador<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=SAUXIndicador.Descripcion
ListaOrden=SAUXIndicador.Indicador<TAB>(Acendente)
FiltroPredefinido=S
FiltroGrupo1=SAUXIndicador.Grupo
FiltroValida1=SAUXIndicador.Grupo
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
PestanaNombre=Indicadores
IconosNombre=SAUXIndicador:SAUXIndicador.Indicador
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

[Ficha.SAUXIndicador.Estatus]
Carpeta=Ficha
Clave=SAUXIndicador.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SAUXIndicador.Grupo]
Carpeta=Ficha
Clave=SAUXIndicador.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SAUXIndicador.Indicador]
Carpeta=Ficha
Clave=SAUXIndicador.Indicador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SAUXIndicador.Descripcion]
Carpeta=Ficha
Clave=SAUXIndicador.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=54
[Ficha.SAUXIndicador.Descripcion2]
Carpeta=Ficha
Clave=SAUXIndicador.Descripcion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=54
ColorFondo=Blanco

[Ficha.SAUXIndicador.Categoria]
Carpeta=Ficha
Clave=SAUXIndicador.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SAUXIndicador.Familia]
Carpeta=Ficha
Clave=SAUXIndicador.Familia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SAUXIndicador.Tipo]
Carpeta=Ficha
Clave=SAUXIndicador.Tipo
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
ClaveAccion=SAUXIndicadorFamilia
Activo=S
Visible=S



[Acciones.Categoria]
Nombre=Categoria
Boton=0
Menu=&Maestros
NombreDesplegar=Categoria
EnMenu=S
TipoAccion=Formas
ClaveAccion=SAUXIndicadorCategoria
Activo=S
Visible=S




































[(Carpeta Abrir).SAUXIndicador.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=SAUXIndicador.Descripcion
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
















































[Detalle.SAUXIndicadorD.Parametro]
Carpeta=Detalle
Clave=SAUXIndicadorD.Parametro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle.SAUXIndicadorD.IndicadorMinimo]
Carpeta=Detalle
Clave=SAUXIndicadorD.IndicadorMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.SAUXIndicadorD.IndicadorMaximo]
Carpeta=Detalle
Clave=SAUXIndicadorD.IndicadorMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.SAUXIndicadorD.Observaciones]
Carpeta=Detalle
Clave=SAUXIndicadorD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco




[Detalle.Columnas]
Parametro=210
IndicadorMinimo=81
IndicadorMaximo=85
Observaciones=226





















[Detalle.ListaEnCaptura]
(Inicio)=SAUXIndicadorD.Parametro
SAUXIndicadorD.Parametro=SAUXIndicadorD.IndicadorMinimo
SAUXIndicadorD.IndicadorMinimo=SAUXIndicadorD.IndicadorMaximo
SAUXIndicadorD.IndicadorMaximo=SAUXIndicadorD.Observaciones
SAUXIndicadorD.Observaciones=(Fin)


















[Ficha.SAUXIndicador.ParametroValido]
Carpeta=Ficha
Clave=SAUXIndicador.ParametroValido
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
Vista=SAUXIndicador
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
ListaEnCaptura=SAUXIndicador.Indicador
CarpetaVisible=S

[Lista.SAUXIndicador.Indicador]
Carpeta=Lista
Clave=SAUXIndicador.Indicador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.ListaEnCaptura]
(Inicio)=SAUXIndicador.Indicador
SAUXIndicador.Indicador=SAUXIndicador.Estatus
SAUXIndicador.Estatus=SAUXIndicador.Descripcion
SAUXIndicador.Descripcion=SAUXIndicador.Descripcion2
SAUXIndicador.Descripcion2=SAUXIndicador.Categoria
SAUXIndicador.Categoria=SAUXIndicador.Familia
SAUXIndicador.Familia=SAUXIndicador.Grupo
SAUXIndicador.Grupo=SAUXIndicador.Tipo
SAUXIndicador.Tipo=SAUXIndicador.ParametroValido
SAUXIndicador.ParametroValido=(Fin)






















[Acciones.Parametros]
Nombre=Parametros
Boton=47
NombreEnBoton=S
NombreDesplegar=&Parámetro
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=SAUXIndicadorD
Activo=S
Visible=S










Antes=S






























EspacioPrevio=S
GuardarAntes=S
AntesExpresiones=Asigna(Info.Tipo,SAUXIndicador:SAUXIndicador.Tipo)<BR>Asigna(Info.Nombre,SAUXIndicador:SAUXIndicador.Indicador)<BR>Asigna(Info.Descripcion,SAUXIndicador:SAUXIndicador.Descripcion)
[Hoja.Columnas]
Parametro=124
Observaciones=336
















































































































































































































[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Guardar Cambios
Guardar Cambios=Eliminar
Eliminar=Parametros
Parametros=Grupos
Grupos=Categoria
Categoria=Familia
Familia=Excel
Excel=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Maestros
&Maestros=(Fin)
