
[Forma]
Clave=WebArtAtributosCatTemp
Icono=0
CarpetaPrincipal=WebArtAtributosCatTemp
Modulos=(Todos)
Nombre=Tipo Atributos Artículos eCommerce
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=WebArtAtributosCatTemp
PosicionInicialIzquierda=516
PosicionInicialArriba=294
PosicionInicialAlturaCliente=140
PosicionInicialAncho=567
ListaAcciones=Expresion
ExpresionesAlMostrar=EjecutarSQL(<T>spWebArtBorrarAtributosTemp :nEstacion<T>,EstacionTrabajo)
[WebArtAtributosCatTemp]
Estilo=Ficha
Clave=WebArtAtributosCatTemp
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtAtributosCatTemp
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
ListaEnCaptura=WebArtAtributosCatTemp.Tipo
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=WebArtAtributosCatTemp.Estacion ={EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[WebArtAtributosCatTemp.WebArtAtributosCatTemp.Tipo]
Carpeta=WebArtAtributosCatTemp
Clave=WebArtAtributosCatTemp.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Expresion.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=FormaModal(<T>WebArtAtributosCatDtemp<T>)
[Acciones.Expresion.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Expresion]
Nombre=Expresion
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
TipoAccion=Expresion
ListaAccionesMultiples=Expresion<BR>Aceptar
Activo=S
Visible=S

[WebArtCamposConfigurablesCatDTemp.Columnas]
0=216
1=-2
