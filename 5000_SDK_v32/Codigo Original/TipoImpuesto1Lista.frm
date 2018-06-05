
[Forma]
Clave=TipoImpuesto1Lista
Icono=0
CarpetaPrincipal=TipoImpuesto1
Modulos=(Todos)
Nombre=Lista Tipo Impuesto 1

ListaCarpetas=TipoImpuesto1
PosicionInicialAlturaCliente=273
PosicionInicialAncho=507
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialIzquierda=386
PosicionInicialArriba=250
[TipoImpuesto1]
Estilo=Iconos
Clave=TipoImpuesto1
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoImpuesto1
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=Impuesto
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

IconosNombre=<T>Impuesto 1<T>
[TipoImpuesto1.TipoImpuesto1.TipoImpuesto]
Carpeta=TipoImpuesto1
Clave=TipoImpuesto1.TipoImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[TipoImpuesto1.TipoImpuesto.Concepto]
Carpeta=TipoImpuesto1
Clave=TipoImpuesto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[TipoImpuesto1.TipoImpuesto.Tasa]
Carpeta=TipoImpuesto1
Clave=TipoImpuesto.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[TipoImpuesto1.Columnas]
0=-2
1=88
2=277
3=-2



[TipoImpuesto1.ListaEnCaptura]
(Inicio)=TipoImpuesto1.TipoImpuesto
TipoImpuesto1.TipoImpuesto=TipoImpuesto.Concepto
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
