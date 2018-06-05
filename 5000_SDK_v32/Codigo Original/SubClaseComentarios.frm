[Forma]
Clave=SubClaseComentarios
Nombre=Comentarios
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Ficha
ListaAcciones=Aceptar
PosicionInicialIzquierda=262
PosicionInicialArriba=230
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
Comentarios=Lista(Info.Clase, Info.SubClase)

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SubClaseComentarios
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
ListaEnCaptura=SubClase.Comentarios
CarpetaVisible=S
AlinearTodaCarpeta=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=SubClase.Modulo=<T>{Info.Modulo}<T> AND SubClase.Clase=<T>{Info.Clase}<T> AND SubClase.SubClase=<T>{Info.SubClase}<T>
FiltroRespetar=S
FiltroTipo=General

[Ficha.SubClase.Comentarios]
Carpeta=Ficha
Clave=SubClase.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10x3
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
