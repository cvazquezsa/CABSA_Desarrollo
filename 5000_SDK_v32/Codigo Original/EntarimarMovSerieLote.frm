[Forma]
Clave=EntarimarMovSerieLote
Nombre=Series/Lotes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=758
PosicionInicialArriba=346
PosicionInicialAlturaCliente=472
PosicionInicialAncho=403
Totalizadores=S
PosicionSec1=409
VentanaSiempreAlFrente=S
VentanaExclusiva=S
Comentarios=Lista(Info.Articulo, Info.SubCuenta)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EntarimarMovSerieLote
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
MenuLocal=S
ListaAcciones=Copiar
FiltroGeneral=EntarimarMovSerieLote.Estacion={EstacionTrabajo} AND<BR>EntarimarMovSerieLote.RenglonID={Info.RenglonID} AND<BR>EntarimarMovSerieLote.Articulo={Comillas(Info.Articulo)} AND<BR>EntarimarMovSerieLote.SubCuenta={Comillas(Info.SubCuenta)} AND<BR>NULLIF(EntarimarMovSerieLote.Cantidad, 0.0) IS NOT NULL

[Lista.EntarimarMovSerieLote.SerieLote]
Carpeta=Lista
Clave=EntarimarMovSerieLote.SerieLote
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.EntarimarMovSerieLote.Cantidad]
Carpeta=Lista
Clave=EntarimarMovSerieLote.Cantidad
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.EntarimarMovSerieLote.CantidadA]
Carpeta=Lista
Clave=EntarimarMovSerieLote.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
SerieLote=226
Cantidad=64
CantidadA=64

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Acciones.Todo]
Nombre=Todo
Boton=54
NombreEnBoton=S
NombreDesplegar=&Seleccionar Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
Activo=S
Visible=S
ClaveAccion=Aceptar
Antes=S
AntesExpresiones=EjecutarSQL(<T>spEntarimarMovSerieLoteTodo :nEstacion, :nRenglonID, :tArticulo, :tSubCuenta<T>, EstacionTrabajo, Info.RenglonID, Info.Articulo, Info.SubCuenta )

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Cantidad<BR>Cantidad a
Totalizadores2=Suma(EntarimarMovSerieLote:EntarimarMovSerieLote.Cantidad)<BR>Suma(EntarimarMovSerieLote:EntarimarMovSerieLote.CantidadA)
Totalizadores3=(Cantidades)<BR>(Cantidades)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Cantidad]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad
Editar=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
LineaNueva=S
ValidaNombre=S

[(Carpeta Totalizadores).Cantidad a]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad a
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Copiar]
Nombre=Copiar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Copiar
EnMenu=S
TipoAccion=Expresion
Expresion=Asigna(EntarimarMovSerieLote:EntarimarMovSerieLote.CantidadA, EntarimarMovSerieLote:EntarimarMovSerieLote.Cantidad)
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Todo
Todo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=EntarimarMovSerieLote.SerieLote
EntarimarMovSerieLote.SerieLote=EntarimarMovSerieLote.Cantidad
EntarimarMovSerieLote.Cantidad=EntarimarMovSerieLote.CantidadA
EntarimarMovSerieLote.CantidadA=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Cantidad
Cantidad=Cantidad a
Cantidad a=(Fin)
