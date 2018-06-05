
[Forma]
Clave=ArtTipo
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
Nombre=Tipo Artículos


ListaCarpetas=Lista
PosicionInicialIzquierda=475
PosicionInicialArriba=215
PosicionInicialAlturaCliente=275
PosicionInicialAncho=280
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[ArtTipo.ArtTipo.Tipo]
Carpeta=ArtTipo
Clave=ArtTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ArtTipo.ArtTipo.Orden]
Carpeta=ArtTipo
Clave=ArtTipo.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[ArtTipo.ArtTipo.INFORDescripcion]
Carpeta=ArtTipo
Clave=ArtTipo.INFORDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ArtTipo.ListaEnCaptura]
(Inicio)=ArtTipo.Tipo
ArtTipo.Tipo=ArtTipo.Orden
ArtTipo.Orden=ArtTipo.INFORDescripcion
ArtTipo.INFORDescripcion=(Fin)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtTipo
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
ListaEnCaptura=ArtTipo.Tipo

CarpetaVisible=S

[Lista.ArtTipo.Tipo]
Carpeta=Lista
Clave=ArtTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Lista.Columnas]
Tipo=124
Orden=38
INFORDescripcion=124

















[Acciones.CampoExtra]
Nombre=CampoExtra
Boton=104
NombreEnBoton=S
NombreDesplegar=&Campo Extra
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CtoTipoCampoExtra
Activo=S
Visible=S




























ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(ArtTipo:ArtTipo.Tipo)
AntesExpresiones=Asigna(Info.Tipo, <T>Articulo<T>)<BR>Asigna(Info.SubTipo,ArtTipo:ArtTipo.Tipo)
[Lista.ListaEnCaptura]
(Inicio)=ArtTipo.Tipo
ArtTipo.Tipo=ArtTipo.INFORDescripcion
ArtTipo.INFORDescripcion=ArtTipo.Orden
ArtTipo.Orden=(Fin)




























[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S













































































































































































































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CampoExtra
CampoExtra=(Fin)
