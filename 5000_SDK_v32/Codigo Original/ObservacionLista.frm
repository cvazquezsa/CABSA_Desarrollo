[Forma]
Clave=ObservacionLista
Nombre=<T>Observaciones - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=456
PosicionInicialArriba=216
PosicionInicialAltura=285
PosicionInicialAncho=453
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=258

[Observacion.Columnas]
Observacion=286

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Observacion
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Observacion.Observacion
CarpetaVisible=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=Actualizar
PermiteLocalizar=S

FiltroGeneral=Observacion.Modulo=<T>{Info.Modulo}<T>
[Lista.Observacion.Observacion]
Carpeta=Lista
Clave=Observacion.Observacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

ColorFondo=Blanco
[Lista.Columnas]
Observacion=416

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Visible=S
Activo=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
