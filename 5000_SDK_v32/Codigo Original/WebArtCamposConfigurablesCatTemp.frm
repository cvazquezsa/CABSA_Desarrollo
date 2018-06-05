
[Forma]
Clave=WebArtCamposConfigurablesCatTemp
Icono=0
CarpetaPrincipal=WebArtCamposConfigurablesCatTemp
Modulos=(Todos)
Nombre=Tipo Campos Configurables Artículos eCommerce

ListaCarpetas=WebArtCamposConfigurablesCatTemp
PosicionInicialAlturaCliente=115
PosicionInicialAncho=406
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=597
PosicionInicialArriba=373
ExpresionesAlMostrar=EjecutarSQL(<T>spWebArtBorrarCamposConfigurablesTemp :nEstacion<T>,EstacionTrabajo)
[WebArtCamposConfigurablesCatTemp]
Estilo=Ficha
Clave=WebArtCamposConfigurablesCatTemp
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtCamposConfigurablesCatTemp
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
ListaEnCaptura=WebArtCamposConfigurablesCatTemp.Tipo
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

PermiteEditar=S
FiltroGeneral=WebArtCamposConfigurablesCatTemp.Estacion={EstacionTrabajo}
[WebArtCamposConfigurablesCatTemp.WebArtCamposConfigurablesCatTemp.Tipo]
Carpeta=WebArtCamposConfigurablesCatTemp
Clave=WebArtCamposConfigurablesCatTemp.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spWebArtImportarCamposConfigurablesTemp :nEstacion<T>,EstacionTrabajo)<BR>FormaModal(<T>WebArtCamposConfigurablesCatDTemp<T>)
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Expresion<BR>Aceptar
Activo=S
Visible=S

[WebArtCamposConfigurablesCatDTemp.Columnas]
0=216
1=-2
