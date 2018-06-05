
[Forma]
Clave=WebArtCamposConfigurablesCatD
Icono=0
CarpetaPrincipal=WebArtCamposConfigurablesCatD
Modulos=(Todos)
Nombre=Detalle

ListaCarpetas=WebArtCamposConfigurablesCatD
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=508
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=584
ListaAcciones=(Lista)
Comentarios=Info.Tipo
[WebArtCamposConfigurablesCatD]
Estilo=Hoja
Clave=WebArtCamposConfigurablesCatD
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtCamposConfigurablesCatD
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebArtCamposConfigurablesCatD.Nombre<BR>WebArtCamposConfigurablesCatD.TipoCampo
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGeneral=WebArtCamposConfigurablesCatD.Tipo = <T>{Info.Tipo}<T>
[WebArtCamposConfigurablesCatD.WebArtCamposConfigurablesCatD.Nombre]
Carpeta=WebArtCamposConfigurablesCatD
Clave=WebArtCamposConfigurablesCatD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[WebArtCamposConfigurablesCatD.WebArtCamposConfigurablesCatD.TipoCampo]
Carpeta=WebArtCamposConfigurablesCatD
Clave=WebArtCamposConfigurablesCatD.TipoCampo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[WebArtCamposConfigurablesCatD.Columnas]
Nombre=215
TipoCampo=311

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

[WebArtCamposConfigurablesCatDD.Columnas]
Valor=604

[Acciones.WebArtCamposConfigurablesCatDD]
Nombre=WebArtCamposConfigurablesCatDD
Boton=0
NombreEnBoton=S
NombreDesplegar=&Valores
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S









Expresion=Asigna(Info.Nombre,WebArtCamposConfigurablesCatD:WebArtCamposConfigurablesCatD.Nombre)<BR>FormaModal(<T>WebArtCamposConfigurablesCatDD<T>)
ActivoCondicion=WebArtCamposConfigurablesCatD:WebArtCamposConfigurablesCatD.TipoCampo = <T>Menú de selección<T>




[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=WebArtCamposConfigurablesCatDD
WebArtCamposConfigurablesCatDD=(Fin)
