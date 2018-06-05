[Forma]
Clave=aroProcedimiento
Nombre=Procedimientos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=688
PosicionInicialArriba=333
PosicionInicialAlturaCliente=499
PosicionInicialAncho=543
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionSec1=373

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroProcedimiento
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

[Lista.aroProcedimiento.Procedimiento]
Carpeta=Lista
Clave=aroProcedimiento.Procedimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroProcedimiento.Nombre]
Carpeta=Lista
Clave=aroProcedimiento.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Procedimiento=145
Nombre=358
Proceso=124
CentroCostos=124
UnidadOrganizacional=118

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

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=aroProcedimiento
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

[Ficha.aroProcedimiento.Proceso]
Carpeta=Ficha
Clave=aroProcedimiento.Proceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.aroProceso.Nombre]
Carpeta=Ficha
Clave=aroProceso.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Ficha.aroProcedimiento.CentroCostos]
Carpeta=Ficha
Clave=aroProcedimiento.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CentroCostos.Descripcion]
Carpeta=Ficha
Clave=CentroCostos.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Articulos]
Nombre=Articulos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Artículos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=aroProcedimientoArt
Activo=S
ConCondicion=S
Antes=S
Visible=S
GuardarAntes=S
EjecucionCondicion=ConDatos(aroProcedimiento:aroProcedimiento.Procedimiento)
AntesExpresiones=Asigna(Info.Procedimiento, aroProcedimiento:aroProcedimiento.Procedimiento)

[Acciones.Unidad]
Nombre=Unidad
Boton=47
NombreEnBoton=S
NombreDesplegar=&Unidades Organizacionales
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=aroProcedimientoUnidad
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(aroProcedimiento:aroProcedimiento.Procedimiento)
Antes=S
AntesExpresiones=Asigna(Info.Procedimiento, aroProcedimiento:aroProcedimiento.Procedimiento)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Articulos
Articulos=Unidad
Unidad=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=aroProcedimiento.Procedimiento
aroProcedimiento.Procedimiento=aroProcedimiento.Nombre
aroProcedimiento.Nombre=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=aroProcedimiento.Proceso
aroProcedimiento.Proceso=aroProceso.Nombre
aroProceso.Nombre=aroProcedimiento.CentroCostos
aroProcedimiento.CentroCostos=CentroCostos.Descripcion
CentroCostos.Descripcion=(Fin)
