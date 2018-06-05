
[Forma]
Clave=WebArtAtributos
Icono=0
CarpetaPrincipal=WebArtAtributos
Modulos=(Todos)
Nombre=Atributos Artículos eCommerce
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=WebArtAtributos
PosicionInicialIzquierda=592
PosicionInicialArriba=269
PosicionInicialAlturaCliente=324
PosicionInicialAncho=415
Comentarios=Info.Articulo
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[WebArtAtributos]
Estilo=Hoja
Clave=WebArtAtributos
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtAtributos
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
ListaEnCaptura=WebArtAtributos.Nombre<BR>WebArtAtributos.Valor
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

PermiteEditar=S
FiltroGeneral=WebArtAtributos.IDArt = {Info.ID}
[WebArtAtributos.WebArtAtributos.Nombre]
Carpeta=WebArtAtributos
Clave=WebArtAtributos.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[WebArtAtributos.WebArtAtributos.Valor]
Carpeta=WebArtAtributos
Clave=WebArtAtributos.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[WebArtAtributos.Columnas]
Nombre=166
Valor=165

[Acciones.Expresion]
Nombre=Expresion
Boton=20
NombreEnBoton=S
NombreDesplegar=&Generar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=FormaModal(<T>WebArtAtributosCatTemp<T>)<BR>ActualizarForma



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=(Fin)
