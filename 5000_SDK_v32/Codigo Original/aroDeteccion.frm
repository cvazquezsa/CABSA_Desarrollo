[Forma]
Clave=aroDeteccion
Nombre=Detecciones
Icono=0
Modulos=(Todos)
PosicionInicialAlturaCliente=503
PosicionInicialAncho=411
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=754
PosicionInicialArriba=331
PosicionSec1=321
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroDeteccion
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
CarpetaVisible=S
OtroOrden=S
PermiteEditar=S
ListaEnCaptura=(Lista)
ListaOrden=aroDeteccion.Valor<TAB>(Decendente)
HojaAjustarColumnas=S
HojaMantenerSeleccion=S

[Lista.aroDeteccion.Deteccion]
Carpeta=Lista
Clave=aroDeteccion.Deteccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Deteccion=309
Calificacion=62
Valor=59

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
Vista=aroDeteccion
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
ListaEnCaptura=aroDeteccion.Descripcion
CarpetaVisible=S
AlinearTodaCarpeta=S

[Descripcion.aroDeteccion.Descripcion]
Carpeta=Descripcion
Clave=aroDeteccion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255x12
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

[Lista.aroDeteccion.Valor]
Carpeta=Lista
Clave=aroDeteccion.Valor
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
(Inicio)=aroDeteccion.Deteccion
aroDeteccion.Deteccion=aroDeteccion.Valor
aroDeteccion.Valor=(Fin)
