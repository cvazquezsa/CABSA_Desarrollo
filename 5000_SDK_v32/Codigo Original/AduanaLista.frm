[Forma]
Clave=AduanaLista
Nombre=Aduanas
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=324
PosicionInicialArriba=298
PosicionInicialAltura=345
PosicionInicialAncho=632
CarpetaPrincipal=Lista
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
PosicionInicialAlturaCliente=400

[Aduana.Columnas]
Aduana=104

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Aduana
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaAjustarColumnas=S
HojaConfirmarEliminar=S
HojaVistaOmision=Automática
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.Aduana.Aduana]
Carpeta=Lista
Clave=Aduana.Aduana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Aduana=194
Descripcion=325
Seccion=46
Denominacion=362

[Detalles.Aduana.Aduana]
Carpeta=Detalles
Clave=Aduana.Aduana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.Aduana.Icono]
Carpeta=Detalles
Clave=Aduana.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Aduana.Seccion]
Carpeta=Lista
Clave=Aduana.Seccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Aduana.Denominacion]
Carpeta=Lista
Clave=Aduana.Denominacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
EnMenu=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=Aduana.Aduana
Aduana.Aduana=Aduana.Seccion
Aduana.Seccion=Aduana.Denominacion
Aduana.Denominacion=(Fin)
