
[Forma]
Clave=WebArtImagenTemp
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=WebArtImagenTemp
Nombre=Imágenes

ListaCarpetas=WebArtImagenTemp
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
ExpresionesAlMostrar=EjecutarSQL(<T>spWebArtBorrarImagenTemp :nEstacion<T>,EstacionTrabajo)
PosicionInicialIzquierda=504
PosicionInicialArriba=360
PosicionInicialAlturaCliente=102
PosicionInicialAncho=591
Comentarios=Info.Articulo
[WebArtImagenTemp]
Estilo=Ficha
Clave=WebArtImagenTemp
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtImagenTemp
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebArtImagenTemp.Archivo
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=WebArtImagenTemp.Estacion = {EstacionTrabajo} AND<BR>WebArtImagenTemp.IDArt = {Info.ID}
[WebArtImagenTemp.WebArtImagenTemp.Archivo]
Carpeta=WebArtImagenTemp
Clave=WebArtImagenTemp.Archivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Directorio,SQL(<T>SELECT WebArtDirectorio FROM WebVersion<T>))<BR>Asigna(Info.Nombre2,SQL(<T> SELECT dbo.fnWebConsecutivoImagen(:nID,:tArchivo)<T>,WebArtImagenTemp:WebArtImagenTemp.IDArt,WebArtImagenTemp:WebArtImagenTemp.Archivo))<BR>Asigna(Info.Directorio,Info.Directorio+<T>\<T>+WebArtImagenTemp:WebArtImagenTemp.IDArt)<BR>Directorio.Verificar(Info.Directorio,verdadero )<BR>Asigna(Info.Directorio,Info.Directorio+ <T>\<T>+Info.Nombre2)<BR><BR>CopiarArchivo(WebArtImagenTemp:WebArtImagenTemp.Archivo,Info.Directorio  )<BR><BR>EjecutarSQL(<T>spWebArtInsertarImagen :nID,:tDirectorio,:tNombre<T>,WebArtImagenTemp:WebArtImagenTemp.IDArt,Info.Directorio,Info.Nombre2)
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Aceptar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
NombreEnBoton=S
GuardarAntes=S







[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)
