
[Forma]
Clave=ProspectoInteresadoEn
Icono=0
Modulos=(All)
Nombre=Interesado en

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=181
PosicionInicialArriba=168
PosicionInicialAlturaCliente=429
PosicionInicialAncho=918
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProspectoInteresadoEn
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
[Lista.ListaEnCaptura]
(Inicio)=ProspectoInteresadoEn.InteresadoEn
ProspectoInteresadoEn.InteresadoEn=ProspectoInteresadoEn.Articulo
ProspectoInteresadoEn.Articulo=Art.Descripcion1
Art.Descripcion1=(Fin)

[Lista.ProspectoInteresadoEn.InteresadoEn]
Carpeta=Lista
Clave=ProspectoInteresadoEn.InteresadoEn
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProspectoInteresadoEn.Articulo]
Carpeta=Lista
Clave=ProspectoInteresadoEn.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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

[Lista.Columnas]
InteresadoEn=485
Articulo=124
Descripcion1=277
