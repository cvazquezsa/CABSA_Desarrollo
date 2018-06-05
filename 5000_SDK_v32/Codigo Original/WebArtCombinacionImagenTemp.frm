[Forma]
Clave=WebArtCombinacionImagenTemp
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=WebArtCombinacionImagenTemp
Nombre=Imagenes

ListaCarpetas=WebArtCombinacionImagenTemp
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=580
PosicionInicialArriba=380
PosicionInicialAlturaCliente=102
PosicionInicialAncho=440


ExpresionesAlMostrar=EjecutarSQL(<T>spWebArtBorrarCombImagenTemp :nEstacion<T>,EstacionTrabajo)
Comentarios=Info.Pedimento
[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Directorio,SQL(<T>SELECT WebArtDirectorio FROM WebVersion<T>))<BR>Asigna(Info.Nombre2,SQL(<T> SELECT dbo.fnWebConsecutivoImagen2(:nIDCombinacion,:nIDArt,:tArchivo)<T>,WebArtCombinacionImagenTemp:WebArtCombinacionImagenTemp.IDCombinacion,WebArtCombinacionImagenTemp:WebArtCombinacionImagenTemp.IDArt,WebArtCombinacionImagenTemp:WebArtCombinacionImagenTemp.Archivo))<BR>Asigna(Info.Directorio,Info.Directorio+<T>\<T>+WebArtCombinacionImagenTemp:WebArtCombinacionImagenTemp.IDArt)<BR>Directorio.Verificar(Info.Directorio,verdadero )<BR>Asigna(Info.Directorio,Info.Directorio+ <T>\<T>+Info.Nombre2)<BR>CopiarArchivo(WebArtCombinacionImagenTemp:WebArtCombinacionImagenTemp.Archivo,Info.Directorio)<BR>EjecutarSQL(<T>spWebArtInsertarImagenCombinacion :nID,:tDirectorio,:tNombre<T>,WebArtCombinacionImagenTemp:WebArtCombinacionImagenTemp.IDCombinacion,Info.Directorio,Info.Nombre2)
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
ListaAccionesMultiples=Expresion<BR>Aceptar
Activo=S
Visible=S
NombreEnBoton=S
GuardarAntes=S

[WebArtCombinacionImagenTemp]
Estilo=Ficha
Clave=WebArtCombinacionImagenTemp
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtCombinacionImagenTemp
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
ListaEnCaptura=WebArtCombinacionImagenTemp.Archivo
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S



FiltroGeneral=WebArtCombinacionImagenTemp.Estacion = {EstacionTrabajo} AND<BR>WebArtCombinacionImagenTemp.IDArt = {Info.ID}     AND<BR>WebArtCombinacionImagenTemp.IDVariacion    = {Info.RID}   AND<BR>WebArtCombinacionImagenTemp.IDCombinacion    = {Info.GID}
[WebArtCombinacionImagenTemp.WebArtCombinacionImagenTemp.Archivo]
Carpeta=WebArtCombinacionImagenTemp
Clave=WebArtCombinacionImagenTemp.Archivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
