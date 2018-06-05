[Forma]
Clave=EspacioConsumo
Nombre=Consumos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=213
PosicionInicialArriba=135
PosicionInicialAlturaCliente=463
PosicionInicialAncho=598
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Totalizadores=S
PosicionSeccion1=92

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EspacioConsumo
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
BusquedaRapidaControles=S
FiltroPeriodos=S
FiltroEjercicios=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroEditarFueraPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha

[Lista.Columnas]
Ejercicio=72
Periodo=56
Indirectos=69
Espacio=75
Nombre=304
Importe=114
Porcentaje=63

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.EspacioConsumo.Espacio]
Carpeta=Lista
Clave=EspacioConsumo.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Espacio.Nombre]
Carpeta=Lista
Clave=Espacio.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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
Totalizadores1=Total<BR>%
Totalizadores2=Suma(EspacioConsumo:EspacioConsumo.Importe)<BR>Suma(EspacioConsumo:EspacioConsumo.Porcentaje)
Totalizadores3=(Monetario)<BR>0.00
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.EspacioConsumo.Importe]
Carpeta=Lista
Clave=EspacioConsumo.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioConsumo.Porcentaje]
Carpeta=Lista
Clave=EspacioConsumo.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).%]
Carpeta=(Carpeta Totalizadores)
Clave=%
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.ListaEnCaptura]
(Inicio)=EspacioConsumo.Espacio
EspacioConsumo.Espacio=Espacio.Nombre
Espacio.Nombre=EspacioConsumo.Importe
EspacioConsumo.Importe=EspacioConsumo.Porcentaje
EspacioConsumo.Porcentaje=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Total
Total=%
%=(Fin)
