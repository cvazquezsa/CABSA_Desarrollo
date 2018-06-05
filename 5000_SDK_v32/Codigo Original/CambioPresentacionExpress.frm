[Forma]
Clave=CambioPresentacionExpress
Nombre=Cambio de Presentación Express
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=336
PosicionInicialArriba=280
PosicionInicialAlturaCliente=436
PosicionInicialAncho=608
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.Almacen)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CambioPresentacionSugerir
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PermiteLocalizar=S
IconosNombre=CambioPresentacionSugerir:Articulo

[Lista.Descripcion]
Carpeta=Lista
Clave=Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Disponible]
Carpeta=Lista
Clave=Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=159
1=314

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Generar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spCambioPresentacionGenerar :tEmp, :tAlm, :tArt, :tPre, :nCantidad, :tUnidad, :tModulo, :nID<T>, Empresa, Info.Almacen, CambioPresentacionSugerir:Articulo, Info.Articulo, Info.Cantidad, Info.Unidad, Info.Modulo, Info.ID)

[Acciones.Generar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Expresion<BR>Aceptar
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=ConDatos(CambioPresentacionSugerir:Articulo) y Forma(<T>EspecificarCantidad<T>)

[Acciones.Localizar]
Nombre=Localizar
Boton=73
NombreEnBoton=S
NombreDesplegar=&Localizar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Generar
Generar=Cancelar
Cancelar=Localizar
Localizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Descripcion
Descripcion=Disponible
Disponible=(Fin)
