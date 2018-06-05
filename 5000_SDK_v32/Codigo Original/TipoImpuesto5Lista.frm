
[Forma]
Clave=TipoImpuesto5Lista
Icono=0
CarpetaPrincipal=TipoImpuesto5
Modulos=(Todos)
Nombre=Lista Tipo Impuesto 5

ListaCarpetas=TipoImpuesto5
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
[TipoImpuesto5]
Estilo=Iconos
Clave=TipoImpuesto5
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoImpuesto5
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
IconosNombre=<T>Impuesto 5<T>
IconosSubTitulo=Impuesto

[TipoImpuesto5.TipoImpuesto5.TipoImpuesto]
Carpeta=TipoImpuesto5
Clave=TipoImpuesto5.TipoImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[TipoImpuesto5.TipoImpuesto.Concepto]
Carpeta=TipoImpuesto5
Clave=TipoImpuesto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[TipoImpuesto5.TipoImpuesto.Tasa]
Carpeta=TipoImpuesto5
Clave=TipoImpuesto.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[TipoImpuesto5.Columnas]
0=-2
1=-2
2=-2

3=-2
[TipoImpuesto5.ListaEnCaptura]
(Inicio)=TipoImpuesto5.TipoImpuesto
TipoImpuesto5.TipoImpuesto=TipoImpuesto.Concepto
TipoImpuesto.Concepto=TipoImpuesto.Tasa
TipoImpuesto.Tasa=(Fin)

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
