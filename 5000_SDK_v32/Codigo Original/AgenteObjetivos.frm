
[Forma]
Clave=AgenteObjetivos
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Objetivos
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=448
PosicionInicialArriba=275
PosicionInicialAlturaCliente=305
PosicionInicialAncho=569
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=Guardar
Comentarios=Lista(Info.Agente, Info.Nombre)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AgenteObjetivos
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
FiltroGeneral=AgenteObjetivos.Agente=<T>{Info.Agente}<T>
FiltroRespetar=S
FiltroTipo=General
[Lista.AgenteObjetivos.ArtCat]
Carpeta=Lista
Clave=AgenteObjetivos.ArtCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.AgenteObjetivos.Moneda]
Carpeta=Lista
Clave=AgenteObjetivos.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.AgenteObjetivos.Importe]
Carpeta=Lista
Clave=AgenteObjetivos.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=AgenteObjetivos.ArtCat
AgenteObjetivos.ArtCat=AgenteObjetivos.Moneda
AgenteObjetivos.Moneda=AgenteObjetivos.Importe
AgenteObjetivos.Importe=(Fin)

[Lista.Columnas]
ArtCat=293
Moneda=82
Importe=153

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)
