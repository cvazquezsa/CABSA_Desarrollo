
[Forma]
Clave=TipoImpuesto2Lista
Icono=0
CarpetaPrincipal=TipoImpuesto2
Modulos=(Todos)
Nombre=Lista Tipo Impuesto 2

ListaCarpetas=TipoImpuesto2
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=390
PosicionInicialArriba=250
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
[TipoImpuesto2]
Estilo=Iconos
Clave=TipoImpuesto2
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoImpuesto2
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosNombre=<T>Impuesto 2<T>
IconosSubTitulo=Impuesto
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
[TipoImpuesto2.ListaEnCaptura]
(Inicio)=TipoImpuesto2.TipoImpuesto
TipoImpuesto2.TipoImpuesto=TipoImpuesto.Concepto
TipoImpuesto.Concepto=TipoImpuesto.Tasa
TipoImpuesto.Tasa=(Fin)

[TipoImpuesto2.TipoImpuesto2.TipoImpuesto]
Carpeta=TipoImpuesto2
Clave=TipoImpuesto2.TipoImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[TipoImpuesto2.TipoImpuesto.Concepto]
Carpeta=TipoImpuesto2
Clave=TipoImpuesto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[TipoImpuesto2.TipoImpuesto.Tasa]
Carpeta=TipoImpuesto2
Clave=TipoImpuesto.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[TipoImpuesto2.Columnas]
0=-2
1=-2
2=305
3=-2

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
