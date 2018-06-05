[Forma]
Clave=AutoRuta
Nombre=Rutas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=264
PosicionInicialArriba=176
PosicionInicialAlturaCliente=381
PosicionInicialAncho=495
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AutoRuta
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

[Lista.AutoRuta.Ruta]
Carpeta=Lista
Clave=AutoRuta.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoRuta.Nombre]
Carpeta=Lista
Clave=AutoRuta.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Ruta=92
Nombre=373

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

[Acciones.Localidades]
Nombre=Localidades
Boton=47
NombreEnBoton=S
NombreDesplegar=&Localidades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AutoRutaD
Activo=S
ConCondicion=S
Antes=S
Visible=S
GuardarAntes=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(AutoRuta:AutoRuta.Ruta)
AntesExpresiones=Asigna(Info.Ruta, AutoRuta:AutoRuta.Ruta)<BR>Asigna(Info.Nombre, AutoRuta:AutoRuta.Nombre)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Localidades
Localidades=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AutoRuta.Ruta
AutoRuta.Ruta=AutoRuta.Nombre
AutoRuta.Nombre=(Fin)
