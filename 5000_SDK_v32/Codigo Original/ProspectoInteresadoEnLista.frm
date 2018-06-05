
[Forma]
Clave=ProspectoInteresadoEnLista
Icono=0
Modulos=(Todos)
Nombre=Prospecto Interesado En 

ListaCarpetas=ProspectoInteresadoEnLista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
CarpetaPrincipal=ProspectoInteresadoEnLista
PosicionInicialIzquierda=351
PosicionInicialArriba=232
PosicionInicialAlturaCliente=325
PosicionInicialAncho=573
[ProspectoInteresadoEnLista]
Estilo=Hoja
Clave=ProspectoInteresadoEnLista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProspectoInteresadoEn
Fuente={Tahoma, 8, Negro, []}
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
[ProspectoInteresadoEnLista.ListaEnCaptura]
(Inicio)=ProspectoInteresadoEn.InteresadoEn
ProspectoInteresadoEn.InteresadoEn=ProspectoInteresadoEn.Articulo
ProspectoInteresadoEn.Articulo=Art.Descripcion1
Art.Descripcion1=(Fin)

[ProspectoInteresadoEnLista.ProspectoInteresadoEn.InteresadoEn]
Carpeta=ProspectoInteresadoEnLista
Clave=ProspectoInteresadoEn.InteresadoEn
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[ProspectoInteresadoEnLista.ProspectoInteresadoEn.Articulo]
Carpeta=ProspectoInteresadoEnLista
Clave=ProspectoInteresadoEn.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[ProspectoInteresadoEnLista.Art.Descripcion1]
Carpeta=ProspectoInteresadoEnLista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.seleccionar]
Nombre=seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S




[ProspectoInteresadoEnLista.Columnas]
InteresadoEn=252
Articulo=86
Descripcion1=203

[Forma.ListaAcciones]
(Inicio)=seleccionar
seleccionar=Cancelar
Cancelar=(Fin)
