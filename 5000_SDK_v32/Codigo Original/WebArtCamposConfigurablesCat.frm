
[Forma]
Clave=WebArtCamposConfigurablesCat
Icono=0
CarpetaPrincipal=WebArtCamposConfigurablesCat
Modulos=(Todos)

ListaCarpetas=WebArtCamposConfigurablesCat
PosicionInicialIzquierda=517
PosicionInicialArriba=294
PosicionInicialAlturaCliente=273
PosicionInicialAncho=396
PosicionSec1=-32
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Nombre=Campos Configurables Artículos eCommerce
[WebArtCamposConfigurablesCat]
Estilo=Hoja
Clave=WebArtCamposConfigurablesCat
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtCamposConfigurablesCat
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
ListaEnCaptura=WebArtCamposConfigurablesCat.Tipo
CarpetaVisible=S

PermiteEditar=S
[WebArtCamposConfigurablesCat.WebArtCamposConfigurablesCat.Tipo]
Carpeta=WebArtCamposConfigurablesCat
Clave=WebArtCamposConfigurablesCat.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[WebArtCamposConfigurablesCatD.WebArtCamposConfigurablesCatD.Nombre]
Carpeta=WebArtCamposConfigurablesCatD
Clave=WebArtCamposConfigurablesCatD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[WebArtCamposConfigurablesCatD.WebArtCamposConfigurablesCatD.TipoCampo]
Carpeta=WebArtCamposConfigurablesCatD
Clave=WebArtCamposConfigurablesCatD.TipoCampo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[WebArtCamposConfigurablesCat.Columnas]
Tipo=358

[WebArtCamposConfigurablesCatD.Columnas]
Nombre=215
TipoCampo=311

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Expresion]
Nombre=Expresion
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
EspacioPrevio=S

Expresion=Asigna(Info.Tipo,WebArtCamposConfigurablesCat:WebArtCamposConfigurablesCat.Tipo)<BR>FormaModal(<T>WebArtCamposConfigurablesCatD<T>)
[WebArtCamposConfigurablesCatDD.Columnas]
Valor=604

















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=(Fin)
