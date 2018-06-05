[Forma]
Clave=PrecioCostoTodos
Nombre=<T>Listas de Precios / Costos<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=374
PosicionInicialArriba=183
PosicionInicialAlturaCliente=367
PosicionInicialAncho=276
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PrecioCostoTodos
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Lista<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Listas
OtroOrden=S
IconosNombre=PrecioCostoTodos:PrecioCostoTodos.Lista
ListaOrden=(Lista)

[Lista.Columnas]
0=199

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.ListaOrden]
(Inicio)=PrecioCostoTodos.Lista<TAB>(Acendente)
PrecioCostoTodos.Lista<TAB>(Acendente)=PrecioCostoTodos.Orden<TAB>(Acendente)
PrecioCostoTodos.Orden<TAB>(Acendente)=(Fin)
