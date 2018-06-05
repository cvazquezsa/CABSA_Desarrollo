
[Forma]
Clave=TipoImpuesto4Lista
Icono=0
CarpetaPrincipal=TipoImpuesto4
Modulos=(Todos)
Nombre=Lista Tipo Impuesto 4

ListaCarpetas=TipoImpuesto4
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=363
PosicionInicialArriba=250
PosicionInicialAlturaCliente=273
PosicionInicialAncho=552
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
[TipoImpuesto4]
Estilo=Iconos
Clave=TipoImpuesto4
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoImpuesto4
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200

IconosSubTitulo=Impuesto
IconosNombre=<T>Impuesto 4<T>
[TipoImpuesto4.TipoImpuesto4.TipoImpuesto]
Carpeta=TipoImpuesto4
Clave=TipoImpuesto4.TipoImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco

[TipoImpuesto4.TipoImpuesto.Concepto]
Carpeta=TipoImpuesto4
Clave=TipoImpuesto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[TipoImpuesto4.Columnas]
TipoImpuesto=69
Concepto=304

0=-2
1=-2
2=319
3=48

[TipoImpuesto4.TipoImpuesto.Tasa]
Carpeta=TipoImpuesto4
Clave=TipoImpuesto.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[TipoImpuesto4.ListaEnCaptura]
(Inicio)=TipoImpuesto4.TipoImpuesto
TipoImpuesto4.TipoImpuesto=TipoImpuesto.Concepto
TipoImpuesto.Concepto=TipoImpuesto.Tasa
TipoImpuesto.Tasa=(Fin)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccinar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
