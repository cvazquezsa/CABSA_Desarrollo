[Forma]
Clave=RutaDistribucion
Nombre=Rutas Distribución
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=808
PosicionInicialArriba=439
PosicionInicialAltura=312
PosicionInicialAncho=304
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=285

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RutaDistribucion
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=RutaDistribucion.Ruta
CarpetaVisible=S

[Lista.RutaDistribucion.Ruta]
Carpeta=Lista
Clave=RutaDistribucion.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Ruta=267

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

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Ruta
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=RutaDistribucionD
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(RutaDistribucion:RutaDistribucion.Ruta)
AntesExpresiones=Asigna(Info.Ruta, RutaDistribucion:RutaDistribucion.Ruta)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Detalle
Detalle=(Fin)
