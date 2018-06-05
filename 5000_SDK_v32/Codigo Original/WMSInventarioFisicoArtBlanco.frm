

[Forma]
Clave=WMSInventarioFisicoArtBlanco
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Datos Genéricos Inventario Físico
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=382
PosicionInicialArriba=287
PosicionInicialAlturaCliente=114
PosicionInicialAncho=558
ListaAcciones=GuardarCerrar
[Lista]
Estilo=Ficha
PestanaOtroNombre=S
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSInventarioFisicoArtBlanco
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

[Lista.WMSInventarioFisicoArtBlanco.Articulo]
Carpeta=Lista
Clave=WMSInventarioFisicoArtBlanco.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=$00F0F0F0

[Lista.WMSInventarioFisicoArtBlanco.Tarima]
Carpeta=Lista
Clave=WMSInventarioFisicoArtBlanco.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Columnas]
Articulo=131
Descripcion1=244
Tarima=124





[Lista.ListaEnCaptura]
(Inicio)=WMSInventarioFisicoArtBlanco.Articulo
WMSInventarioFisicoArtBlanco.Articulo=Art.Descripcion1
Art.Descripcion1=WMSInventarioFisicoArtBlanco.Tarima
WMSInventarioFisicoArtBlanco.Tarima=(Fin)

[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
