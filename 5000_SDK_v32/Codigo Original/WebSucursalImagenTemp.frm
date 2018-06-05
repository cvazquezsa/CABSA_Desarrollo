
[Forma]
Clave=WebSucursalImagenTemp
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=WebSucursalImagenTemp
Nombre=Imágenes

ListaCarpetas=WebSucursalImagenTemp
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
ExpresionesAlMostrar=EjecutarSQL(<T>spWebArtBorrarImagenTemp :nEstacion<T>,EstacionTrabajo)
PosicionInicialIzquierda=504
PosicionInicialArriba=360
PosicionInicialAlturaCliente=102
PosicionInicialAncho=591
Comentarios=Info.Sucursal

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Directorio,SQL(<T>SELECT WebArtDirectorio FROM WebVersion<T>))<BR>Asigna(Info.Nombre2,SQL(<T> SELECT dbo.fnWebConsecutivoImagenSucursal(:nSuc,:tArchivo)<T>,WebSucursalImagenTemp:WebSucursalImagenTemp.Sucursal,WebSucursalImagenTemp:WebSucursalImagenTemp.Archivo))<BR>Asigna(Info.Directorio,Info.Directorio+<T>\Sucursal<T>)<BR>Directorio.Verificar(Info.Directorio,verdadero )<BR>Asigna(Info.Directorio,Info.Directorio+<T>\<T>+WebSucursalImagenTemp:WebSucursalImagenTemp.Sucursal)<BR>Directorio.Verificar(Info.Directorio,verdadero )<BR>Asigna(Info.Directorio,Info.Directorio+ <T>\<T>+Info.Nombre2)<BR>CopiarArchivo(WebSucursalImagenTemp:WebSucursalImagenTemp.Archivo,Info.Directorio  )<BR>EjecutarSQL(<T>spWebSucursalInsertarImagen :nSucursal,:tDirectorio,:tNombre<T>,WebSucursalImagenTemp:WebSucursalImagenTemp.Sucursal,Info.Directorio,Info.Nombre2)
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
[WebSucursalImagenTemp]
Estilo=Ficha
Clave=WebSucursalImagenTemp
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebSucursalImagenTemp
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
ListaEnCaptura=WebSucursalImagenTemp.Archivo
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=WebSucursalImagenTemp.Estacion= {EstacionTrabajo} AND<BR>WebSucursalImagenTemp.Sucursal= {Info.Sucursal}
[WebSucursalImagenTemp.WebSucursalImagenTemp.Archivo]
Carpeta=WebSucursalImagenTemp
Clave=WebSucursalImagenTemp.Archivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro













[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)
