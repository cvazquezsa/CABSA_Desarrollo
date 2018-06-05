[Forma]
Clave=aroFactor
Nombre=Factores Riesgo
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=623
PosicionInicialArriba=284
PosicionInicialAlturaCliente=597
PosicionInicialAncho=674
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionSec1=408

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroFactor
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
ListaOrden=aroFactor.Orden<TAB>(Acendente)

[Lista.aroFactor.FactorRiesgo]
Carpeta=Lista
Clave=aroFactor.FactorRiesgo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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

[Lista.Columnas]
FactorRiesgo=132
Nombre=445
Descripcion=503
Orden=37
EsEstructura=56

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
Clave=Descripcion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=aroFactor
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
ListaEnCaptura=aroFactor.Descripcion
CarpetaVisible=S
AlinearTodaCarpeta=S
PestanaOtroNombre=S
PestanaNombre=Descripción

[Descripcion.aroFactor.Descripcion]
Carpeta=Descripcion
Clave=aroFactor.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroFactor.EsEstructura]
Carpeta=Lista
Clave=aroFactor.EsEstructura
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
(Inicio)=aroFactor.FactorRiesgo
aroFactor.FactorRiesgo=aroFactor.Nombre
aroFactor.Nombre=aroFactor.EsEstructura
aroFactor.EsEstructura=(Fin)
