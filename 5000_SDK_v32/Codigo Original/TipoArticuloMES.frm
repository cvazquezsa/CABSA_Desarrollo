
[Forma]
Clave=TipoArticuloMES
Icono=0
Modulos=(Todos)
Nombre=Tipo de Artículo

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=592
PosicionInicialArriba=344
PosicionInicialAlturaCliente=161
PosicionInicialAncho=225
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Tipos de Artículo
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoArticuloMES
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)


[Lista.TipoArticuloMES.Codigo]
Carpeta=Lista
Clave=TipoArticuloMES.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.TipoArticuloMES.Descripcion]
Carpeta=Lista
Clave=TipoArticuloMES.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=TipoArticuloMES.Codigo
TipoArticuloMES.Codigo=TipoArticuloMES.Descripcion
TipoArticuloMES.Descripcion=(Fin)

[Lista.Columnas]
Codigo=64
Descripcion=124

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
GuardarAntes=S
