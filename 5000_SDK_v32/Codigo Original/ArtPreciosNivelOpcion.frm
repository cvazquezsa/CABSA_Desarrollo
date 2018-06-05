[Forma]
Clave=ArtPreciosNivelOpcion
Nombre=Listas Precios
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=371
PosicionInicialArriba=214
PosicionInicialAltura=333
PosicionInicialAncho=282
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
PosicionInicialAlturaCliente=306

[Lista]
Estilo=Hoja
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtPreciosNivelOpcion
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ListaPreciosEsp.Lista
ListaOrden=ListaPreciosEsp.Orden<TAB>(Acendente)
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.ListaPreciosEsp.Lista]
Carpeta=Lista
Clave=ListaPreciosEsp.Lista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Lista=252

[Acciones.NivelOpcion]
Nombre=NivelOpcion
Boton=47
NombreEnBoton=S
NombreDesplegar=&Precios a Nivel Opción
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ListaPreciosSub
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(ArtPreciosNivelOpcion:ListaPreciosEsp.Lista)
AntesExpresiones=Asigna(Info.Lista, ArtPreciosNivelOpcion:ListaPreciosEsp.Lista)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=NivelOpcion
NivelOpcion=(Fin)
