[Forma]
Clave=ActividadTipo
Nombre=Tipos de Actividades
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=492
PosicionInicialArriba=279
PosicionInicialAlturaCliente=439
PosicionInicialAncho=295
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionCol1=283
PosicionSec1=340

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActividadTipo
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=ActividadTipo.Orden<TAB>(Acendente)
HojaTitulos=S
HojaMostrarColumnas=S
HojaMantenerSeleccion=S

[Lista.ActividadTipo.Tipo]
Carpeta=Lista
Clave=ActividadTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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
Tipo=214
Orden=42

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ActividadTipo
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
ListaEnCaptura=ActividadTipo.Icono
CarpetaVisible=S
PermiteEditar=S

[Ficha.ActividadTipo.Icono]
Carpeta=Ficha
Clave=ActividadTipo.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActividadTipo.Orden]
Carpeta=Lista
Clave=ActividadTipo.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ActividadTipo.Orden
ActividadTipo.Orden=ActividadTipo.Tipo
ActividadTipo.Tipo=(Fin)
