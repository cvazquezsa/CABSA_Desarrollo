
[Forma]
Clave=ClavePresupuestalCatalogoTipo
Icono=0
Modulos=(Todos)
Nombre=Tipos de Catalogos de Claves Presupuestales

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=416
PosicionInicialAncho=440
VentanaTipoMarco=Sencillo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=420
PosicionInicialArriba=178
AccionesTamanoBoton=15x5
BarraHerramientas=S
ListaAcciones=(Lista)
Comentarios=Info.Proyecto
PosicionSec1=179
AccionesCentro=S
Menus=S
MenuPrincipal=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ClavePresupuestalCatalogoTipo
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
ListaEnCaptura=(Lista)

CarpetaVisible=S


Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Arbol
FiltroArbolClave=ClavePresupuestalCatalogoTipo.Tipo
FiltroArbolValidar=ClavePresupuestalCatalogoTipo.Tipo
FiltroArbolRama=ClavePresupuestalCatalogoTipo.Rama
FiltroArbolAcumulativas=ClavePresupuestalCatalogoTipo.EsAcumulativa
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
GuardarPorRegistro=S
HojaConfirmarEliminar=S
FiltroTodo=S
PermiteEditar=S
OtroOrden=S
ListaOrden=ClavePresupuestalCatalogoTipo.Categoria<TAB>(Acendente)
FiltroGeneral=ClavePresupuestalCatalogoTipo.Proyecto = <T>{Info.Proyecto}<T>
[Lista.ClavePresupuestalCatalogoTipo.Tipo]
Carpeta=Lista
Clave=ClavePresupuestalCatalogoTipo.Tipo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.Columnas]
Proyecto=304
Tipo=201
Categoria=51
Digitos=64
Rama=143
TechoPresupuesto=101


[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S










Menu=&Archivo
EnMenu=S
[Acciones.Catalogo]
Nombre=Catalogo
Boton=47
NombreDesplegar=&Catalogo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ClavePresupuestalCatalogo
Activo=S
Visible=S



EspacioPrevio=S
Antes=S



























GuardarAntes=S

















Menu=&Ver
EnMenu=S
AntesExpresiones=Asigna(Info.Tipo, ClavePresupuestalCatalogoTipo:ClavePresupuestalCatalogoTipo.Tipo)<BR>Asigna(Info.Clave, Nulo)<BR>Asigna(Temp.Logico, ClavePresupuestalCatalogoTipo:ClavePresupuestalCatalogoTipo.TechoPresupuesto)<BR>Asigna(Info.Categoria, ClavePresupuestalCatalogoTipo:ClavePresupuestalCatalogoTipo.Categoria)<BR>Asigna(Info.Mensaje, <T>Proyecto = <T> & Comillas(Info.Proyecto) & <T> AND Tipo = <T> & Comillas(Info.Tipo))
[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalle
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ClavePresupuestalCatalogoTipo
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S















FichaEspacioEntreLineas=6
FichaEspacioNombres=115
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=(Lista)

GuardarPorRegistro=S
[Detalle.ClavePresupuestalCatalogoTipo.Tipo]
Carpeta=Detalle
Clave=ClavePresupuestalCatalogoTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

[Detalle.ClavePresupuestalCatalogoTipo.Categoria]
Carpeta=Detalle
Clave=ClavePresupuestalCatalogoTipo.Categoria
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Detalle.ClavePresupuestalCatalogoTipo.Digitos]
Carpeta=Detalle
Clave=ClavePresupuestalCatalogoTipo.Digitos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=5
[Detalle.ClavePresupuestalCatalogoTipo.TechoPresupuesto]
Carpeta=Detalle
Clave=ClavePresupuestalCatalogoTipo.TechoPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=5
EspacioPrevio=S
[Detalle.ClavePresupuestalCatalogoTipo.EsAcumulativa]
Carpeta=Detalle
Clave=ClavePresupuestalCatalogoTipo.EsAcumulativa
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco




Tamano=5
















[Acciones.Nueva]
Nombre=Nueva
Boton=1
NombreDesplegar=Nueva
EnBarraHerramientas=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S














NombreEnBoton=S
EspacioPrevio=S






Antes=S


GuardarAntes=S
Menu=&Archivo
EnMenu=S
AntesExpresiones=Asigna(Def.Rama, FiltroActual)
[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
NombreDesplegar=Actualizar
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S















UsaTeclaRapida=S
TeclaRapida=F5
EnMenu=S
















Menu=&Ver
EspacioPrevio=S



[Lista.ClavePresupuestalCatalogoTipo.Categoria]
Carpeta=Lista
Clave=ClavePresupuestalCatalogoTipo.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=1
ColorFondo=Blanco






































[Detalle.ClavePresupuestalCatalogoTipo.Validacion]
Carpeta=Detalle
Clave=ClavePresupuestalCatalogoTipo.Validacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco




















[Detalle.ListaEnCaptura]
(Inicio)=ClavePresupuestalCatalogoTipo.Tipo
ClavePresupuestalCatalogoTipo.Tipo=ClavePresupuestalCatalogoTipo.Validacion
ClavePresupuestalCatalogoTipo.Validacion=ClavePresupuestalCatalogoTipo.Digitos
ClavePresupuestalCatalogoTipo.Digitos=ClavePresupuestalCatalogoTipo.Categoria
ClavePresupuestalCatalogoTipo.Categoria=ClavePresupuestalCatalogoTipo.TechoPresupuesto
ClavePresupuestalCatalogoTipo.TechoPresupuesto=ClavePresupuestalCatalogoTipo.EsAcumulativa
ClavePresupuestalCatalogoTipo.EsAcumulativa=(Fin)







[Acciones.Salir]
Nombre=Salir
Boton=0
Menu=&Archivo
NombreDesplegar=&Salir
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
































































































































































































































































































EspacioPrevio=S
[Lista.ListaEnCaptura]
(Inicio)=ClavePresupuestalCatalogoTipo.Tipo
ClavePresupuestalCatalogoTipo.Tipo=ClavePresupuestalCatalogoTipo.Categoria
ClavePresupuestalCatalogoTipo.Categoria=(Fin)




















































































































































[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nueva
Nueva=Guardar
Guardar=Catalogo
Catalogo=Actualizar
Actualizar=Salir
Salir=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)
