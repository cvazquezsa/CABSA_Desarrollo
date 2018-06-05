[Forma]
Clave=aroUnidad
Nombre=Unidades Organizacionales
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=643
PosicionInicialArriba=319
PosicionInicialAlturaCliente=527
PosicionInicialAncho=634
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=Aceptar
PosicionSec1=399

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroUnidad
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
OtroOrden=S
ListaOrden=aroUnidad.Orden<TAB>(Acendente)
HojaAjustarColumnas=S
HojaMantenerSeleccion=S

[Lista.aroUnidad.UnidadOrganizacional]
Carpeta=Lista
Clave=aroUnidad.UnidadOrganizacional
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroUnidad.Nombre]
Carpeta=Lista
Clave=aroUnidad.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
UnidadOrganizacional=66
Nombre=470
CentroCostos=95
LineaNegocios=83
EsEstructura=57

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

[Lista.aroUnidad.EsEstructura]
Carpeta=Lista
Clave=aroUnidad.EsEstructura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=aroUnidad
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.aroUnidad.CentroCostos]
Carpeta=Ficha
Clave=aroUnidad.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=Negro
ColorFondo=Blanco

[Ficha.CentroCostos.Descripcion]
Carpeta=Ficha
Clave=CentroCostos.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Ficha.aroUnidad.LineaNegocios]
Carpeta=Ficha
Clave=aroUnidad.LineaNegocios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.aroLinea.Nombre]
Carpeta=Ficha
Clave=aroLinea.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=aroUnidad.UnidadOrganizacional
aroUnidad.UnidadOrganizacional=aroUnidad.Nombre
aroUnidad.Nombre=aroUnidad.EsEstructura
aroUnidad.EsEstructura=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=aroUnidad.CentroCostos
aroUnidad.CentroCostos=CentroCostos.Descripcion
CentroCostos.Descripcion=aroUnidad.LineaNegocios
aroUnidad.LineaNegocios=aroLinea.Nombre
aroLinea.Nombre=(Fin)
