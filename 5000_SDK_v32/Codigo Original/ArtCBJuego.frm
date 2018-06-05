[Forma]
Clave=ArtCBJuego
Nombre=Componentes - Código Barras
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=616
PosicionInicialArriba=381
PosicionInicialAlturaCliente=401
PosicionInicialAncho=687
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Totalizadores=S
PosicionSeccion1=90
Comentarios=Info.Codigo
PosicionSec1=335

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtCBJuego
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PermiteEditar=S
FiltroGeneral=ArtCBJuego.Codigo=<T>{Info.Codigo}<T>

[Lista.ArtCBJuego.Articulo]
Carpeta=Lista
Clave=ArtCBJuego.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=100

[Lista.ArtCBJuego.SubCuenta]
Carpeta=Lista
Clave=ArtCBJuego.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCBJuego.Cantidad]
Carpeta=Lista
Clave=ArtCBJuego.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCBJuego.Precio]
Carpeta=Lista
Clave=ArtCBJuego.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Articulo=124
SubCuenta=128
Cantidad=48
Precio=75
Descripcion1=184
Importe=85

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Importe]
Carpeta=Lista
Clave=Importe
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Importe Total<BR>Conteo
Totalizadores2=Suma(ArtCBJuego:Importe)<BR>Conteo(ArtCBJuego:ArtCBJuego.Articulo)
Totalizadores3=(Monetario)<BR>#,
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
NombreDesplegar=CambiarVista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S

[(Carpeta Totalizadores).Importe Total]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
ValidaNombre=N
3D=S
Pegado=S
Tamano=5
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Asistente]
Nombre=Asistente
Boton=12
NombreEnBoton=S
NombreDesplegar=Importe &Total
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Importe, Suma(ArtCBJuego:Importe))<BR>Si<BR>  Forma(<T>EspecificarImporte<T>)<BR>Entonces<BR>  EjecutarSQL(<T>spArtCBJuegoImporte :tCodigo, :nImporte<T>, Info.Codigo, Info.Importe) <BR>  Forma.ActualizarVista(<T>Lista<T>) <BR>Fin

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=CambiarVista
CambiarVista=Asistente
Asistente=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtCBJuego.Articulo
ArtCBJuego.Articulo=Art.Descripcion1
Art.Descripcion1=ArtCBJuego.SubCuenta
ArtCBJuego.SubCuenta=ArtCBJuego.Cantidad
ArtCBJuego.Cantidad=ArtCBJuego.Precio
ArtCBJuego.Precio=Importe
Importe=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe Total
Importe Total=Conteo
Conteo=(Fin)
