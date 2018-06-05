[Forma]
Clave=aroUnidadLista
Nombre=Unidades Organizacionales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=584
PosicionInicialArriba=319
PosicionInicialAlturaCliente=527
PosicionInicialAncho=751
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=aroUnidad
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
ValidarCampos=S
OtroOrden=S
ListaOrden=aroUnidad.Orden<TAB>(Acendente)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Clave<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Unidades Organizacionales
IconosNombre=aroUnidad:aroUnidad.UnidadOrganizacional

[Lista.aroUnidad.Nombre]
Carpeta=Lista
Clave=aroUnidad.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroUnidad.CentroCostos]
Carpeta=Lista
Clave=aroUnidad.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.aroUnidad.LineaNegocios]
Carpeta=Lista
Clave=aroUnidad.LineaNegocios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
UnidadOrganizacional=66
Nombre=470
CentroCostos=95
LineaNegocios=83
EsEstructura=57
0=111
1=365

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

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=aroUnidad.Nombre
aroUnidad.Nombre=aroUnidad.LineaNegocios
aroUnidad.LineaNegocios=aroUnidad.CentroCostos
aroUnidad.CentroCostos=(Fin)
