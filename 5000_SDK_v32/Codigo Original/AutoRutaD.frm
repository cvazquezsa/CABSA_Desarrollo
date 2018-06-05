[Forma]
Clave=AutoRutaD
Nombre=Ruta
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=262
PosicionInicialArriba=201
PosicionInicialAlturaCliente=331
PosicionInicialAncho=500
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Ruta, Info.Nombre)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AutoRutaD
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
ListaOrden=AutoRutaD.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=AutoRutaD.Ruta=<T>{Info.Ruta}<T>

[Lista.AutoRutaD.Localidad]
Carpeta=Lista
Clave=AutoRutaD.Localidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoLocalidad.Nombre]
Carpeta=Lista
Clave=AutoLocalidad.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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

[Lista.Columnas]
Localidad=90
Nombre=342
Orden=37

[Lista.AutoRutaD.Orden]
Carpeta=Lista
Clave=AutoRutaD.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar Orden
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Forma(<T>AutoRutaDOrdenar<T>)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ordenar
Ordenar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AutoRutaD.Localidad
AutoRutaD.Localidad=AutoLocalidad.Nombre
AutoLocalidad.Nombre=AutoRutaD.Orden
AutoRutaD.Orden=(Fin)
