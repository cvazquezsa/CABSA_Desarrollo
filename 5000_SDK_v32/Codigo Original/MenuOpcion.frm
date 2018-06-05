[Forma]
Clave=MenuOpcion
Nombre=Opciones del Menú
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=645
PosicionInicialArriba=292
PosicionInicialAlturaCliente=580
PosicionInicialAncho=630
PosicionCol1=419
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Menu
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionSec1=403
PosicionCol2=309

[Lista]
Estilo=Hoja
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MenuOpcion
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
ListaOrden=MenuOpcion.OpcionOrden<TAB>(Acendente)
CarpetaVisible=S
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteEditar=S
FiltroGeneral=MenuOpcion.Menu=<T>{Info.Menu}<T>

[Lista.MenuOpcion.Opcion]
Carpeta=Lista
Clave=MenuOpcion.Opcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MenuOpcion.Nombre]
Carpeta=Lista
Clave=MenuOpcion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MenuOpcion.Accion]
Carpeta=Ficha
Clave=MenuOpcion.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Lista.Columnas]
Opcion=95
Nombre=231
Tipo=60

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

[Lista.MenuOpcion.Tipo]
Carpeta=Lista
Clave=MenuOpcion.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MenuOpcion.Reporte]
Carpeta=Ficha
Clave=MenuOpcion.Reporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MenuOpcion.URL]
Carpeta=Ficha
Clave=MenuOpcion.URL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Ficha]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Detalles
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MenuOpcion
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
CondicionVisible=MenuOpcion:MenuOpcion.Tipo en (<T>Submenu<T>, <T>Accion<T>)

[Ficha.MenuOpcion.TeclaRapida]
Carpeta=Ficha
Clave=MenuOpcion.TeclaRapida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.MenuOpcion.Imagen]
Carpeta=Ficha
Clave=MenuOpcion.Imagen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MenuOpcion.BotonGrande]
Carpeta=Ficha
Clave=MenuOpcion.BotonGrande
Editar=S
LineaNueva=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MenuOpcion.EspacioPrevio]
Carpeta=Ficha
Clave=MenuOpcion.EspacioPrevio
Editar=S
LineaNueva=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MenuOpcion.Opcion
MenuOpcion.Opcion=MenuOpcion.Tipo
MenuOpcion.Tipo=MenuOpcion.Nombre
MenuOpcion.Nombre=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=MenuOpcion.Accion
MenuOpcion.Accion=MenuOpcion.TeclaRapida
MenuOpcion.TeclaRapida=MenuOpcion.Imagen
MenuOpcion.Imagen=MenuOpcion.BotonGrande
MenuOpcion.BotonGrande=MenuOpcion.EspacioPrevio
MenuOpcion.EspacioPrevio=(Fin)
