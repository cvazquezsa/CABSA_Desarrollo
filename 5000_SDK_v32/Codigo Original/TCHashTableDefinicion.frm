
[Forma]
Clave=TCHashTableDefinicion
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Definición de Layout
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
Comentarios=Info.Proveedor
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=311
PosicionInicialAncho=418
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=474
PosicionInicialArriba=189
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Campos
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TCHashTableDefinicion
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
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=TCHashTableDefinicion.ProcesadorTrans = <T>{Info.Proveedor}<T>
FiltroRespetar=S
FiltroTipo=General
[Lista.TCHashTableDefinicion.Campo]
Carpeta=Lista
Clave=TCHashTableDefinicion.Campo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.TCHashTableDefinicion.Columna]
Carpeta=Lista
Clave=TCHashTableDefinicion.Columna
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Columnas]
Campo=193
Columna=160

[Lista.ListaEnCaptura]
(Inicio)=TCHashTableDefinicion.Campo
TCHashTableDefinicion.Campo=TCHashTableDefinicion.Columna
TCHashTableDefinicion.Columna=(Fin)
