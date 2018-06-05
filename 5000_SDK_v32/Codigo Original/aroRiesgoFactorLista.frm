[Forma]
Clave=aroRiesgoFactorLista
Nombre=Factores del Riesgo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialIzquierda=538
PosicionInicialArriba=375
PosicionInicialAlturaCliente=415
PosicionInicialAncho=843
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Riesgo

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroRiesgoFactor
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
ListaOrden=aroFactor.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=aroRiesgoFactor.Riesgo=<T>{Info.Riesgo}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.aroRiesgoFactor.FactorRiesgo]
Carpeta=Lista
Clave=aroRiesgoFactor.FactorRiesgo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.n1]
Carpeta=Lista
Clave=n1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.n2]
Carpeta=Lista
Clave=n2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroFactor.Nombre]
Carpeta=Lista
Clave=aroFactor.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.Columnas]
FactorRiesgo=107
n1=237
n2=263
Nombre=204

[Lista.ListaEnCaptura]
(Inicio)=aroRiesgoFactor.FactorRiesgo
aroRiesgoFactor.FactorRiesgo=n1
n1=n2
n2=aroFactor.Nombre
aroFactor.Nombre=(Fin)
