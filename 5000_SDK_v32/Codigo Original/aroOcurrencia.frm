[Forma]
Clave=aroOcurrencia
Nombre=Ocurrencias
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=717
PosicionInicialArriba=277
PosicionInicialAlturaCliente=611
PosicionInicialAncho=485
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionSec1=335

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroOcurrencia
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
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=aroOcurrencia.Valor<TAB>(Decendente)

[Lista.aroOcurrencia.Ocurrencia]
Carpeta=Lista
Clave=aroOcurrencia.Ocurrencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Ocurrencia=382
Calificacion=63
Valor=61

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
Vista=aroOcurrencia
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
ListaEnCaptura=aroOcurrencia.Descripcion
CarpetaVisible=S
AlinearTodaCarpeta=S

[Descripcion.aroOcurrencia.Descripcion]
Carpeta=Descripcion
Clave=aroOcurrencia.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255x12
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroOcurrencia.Valor]
Carpeta=Lista
Clave=aroOcurrencia.Valor
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
(Inicio)=aroOcurrencia.Ocurrencia
aroOcurrencia.Ocurrencia=aroOcurrencia.Valor
aroOcurrencia.Valor=(Fin)
