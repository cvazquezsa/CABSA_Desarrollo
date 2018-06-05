[Forma]
Clave=MenuOpcionHTML
Nombre=HTML
Icono=17
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=473
PosicionInicialArriba=230
PosicionInicialAlturaCliente=556
PosicionInicialAncho=733
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Info.Opcion

[Ficha]
Estilo=Ficha
Clave=Ficha
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MenuOpcionHTML
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
ListaEnCaptura=MenuOpcion.HTML
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
AlinearTodaCarpeta=S
FiltroGeneral=MenuOpcion.Menu=<T>{Info.Menu}<T> AND MenuOpcion.Opcion=<T>{Info.Opcion}<T>

[Ficha.MenuOpcion.HTML]
Carpeta=Ficha
Clave=MenuOpcion.HTML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x10
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Editar]
Nombre=Editar
Boton=35
NombreEnBoton=S
NombreDesplegar=&Editar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=EditorHTML(MenuOpcionHTML:MenuOpcion.HTML, <T>HTML<T>, <T>HTML<T>)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Editar
Editar=(Fin)
