
[Forma]
Clave=WebArtDescripcion
Icono=0
CarpetaPrincipal=WebArtDescripcion
Modulos=(Todos)
Nombre=Descripción HTML
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=WebArtDescripcion
PosicionInicialIzquierda=415
PosicionInicialArriba=245
PosicionInicialAlturaCliente=371
PosicionInicialAncho=770
ListaAcciones=(Lista)
Comentarios=Info.Articulo

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


GuardarAntes=S
[Acciones.HTML]
Nombre=HTML
Boton=75
NombreEnBoton=S
NombreDesplegar=&Editor HTML
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
EspacioPrevio=S




Expresion=Asigna(Info.Anuncio,EstacionTrabajo&<T>_<T>&Info.ID&<T>.HTML<T>)<BR>Archivo.Escribir(Info.Anuncio,WebArtDescripcion:WebArtDescripcion.DescripcionHTML )<BR>Ejecutar(<T>EditorVisorHTML.exe <T>+Info.Anuncio,verdadero)<BR>Asigna(WebArtDescripcion:WebArtDescripcion.DescripcionHTML,Archivo.Leer(Info.Anuncio))<BR>GuardarCambios<BR>EjecutarSQL(<T>spWebArtActualizarHTML :nID<T>,Info.ID)<BR>Archivo.Eliminar(Info.Anuncio )<BR>ActualizarForma
[WebArtDescripcion]
Estilo=Ficha
Clave=WebArtDescripcion
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtDescripcion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebArtDescripcion.DescripcionHTML
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
AlinearTodaCarpeta=S



PermiteEditar=S
FiltroGeneral=WebArtDescripcion.ID = {Info.ID}
[WebArtDescripcion.WebArtDescripcion.DescripcionHTML]
Carpeta=WebArtDescripcion
Clave=WebArtDescripcion.DescripcionHTML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=HTML
HTML=(Fin)
