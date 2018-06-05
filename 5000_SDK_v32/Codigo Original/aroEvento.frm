[Forma]
Clave=aroEvento
Nombre=Eventos Perdida
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=626
PosicionInicialArriba=294
PosicionInicialAlturaCliente=578
PosicionInicialAncho=668
PosicionSec1=398
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroEvento
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=aroEvento.Orden<TAB>(Acendente)
CarpetaVisible=S

[Lista.aroEvento.EventoRiesgo]
Carpeta=Lista
Clave=aroEvento.EventoRiesgo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroEvento.Nombre]
Carpeta=Lista
Clave=aroEvento.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
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

[Descripcion]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Descripción
Clave=Descripcion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=aroEvento
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
ListaEnCaptura=aroEvento.Descripcion
CarpetaVisible=S
AlinearTodaCarpeta=S

[Descripcion.aroEvento.Descripcion]
Carpeta=Descripcion
Clave=aroEvento.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255x10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
EventoRiesgo=124
Nombre=434
EsEstructura=68

[Lista.aroEvento.EsEstructura]
Carpeta=Lista
Clave=aroEvento.EsEstructura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Descripcion
Descripcion=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=aroEvento.EventoRiesgo
aroEvento.EventoRiesgo=aroEvento.Nombre
aroEvento.Nombre=aroEvento.EsEstructura
aroEvento.EsEstructura=(Fin)
