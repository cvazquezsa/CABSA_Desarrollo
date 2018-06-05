[Forma]
Clave=NotaCtaInfo
Nombre=<T>Comentarios - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=256
PosicionInicialArriba=241
PosicionInicialAltura=285
PosicionInicialAncho=512
VentanaExclusiva=S
VentanaEscCerrar=S

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotaCta
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=NotaCta.Comentarios
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
AlinearTodaCarpeta=S
FiltroGeneral=NotaCta.Rama=<T>{Info.Rama}<T> AND<BR>NotaCta.Cuenta=<T>{Info.Cuenta}<T>

[Ficha.NotaCta.Comentarios]
Carpeta=Ficha
Clave=NotaCta.Comentarios
Editar=S
LineaNueva=S
3D=S
Tamano=70x15
ColorFondo=Plata
ConScroll=S
ValidaNombre=N
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
