
[Forma]
Clave=TipoImpuesto3Lista
Icono=0
CarpetaPrincipal=TipoImpuesto3
Modulos=(Todos)
Nombre=Lista Tipo Impuesto 3

ListaCarpetas=TipoImpuesto3
PosicionInicialAlturaCliente=273
PosicionInicialAncho=405
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=437
PosicionInicialArriba=250
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
[TipoImpuesto3]
Estilo=Iconos
Clave=TipoImpuesto3
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoImpuesto3
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
ElementosPorPagina=200
IconosSubTitulo=Impuesto
IconosNombre=<T>Impuesto 3<T>
[TipoImpuesto3.TipoImpuesto3.TipoImpuesto]
Carpeta=TipoImpuesto3
Clave=TipoImpuesto3.TipoImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[TipoImpuesto3.TipoImpuesto.Concepto]
Carpeta=TipoImpuesto3
Clave=TipoImpuesto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[TipoImpuesto3.Columnas]
TipoImpuesto=69
Concepto=304




0=-2
1=-2
2=214
3=-2
[TipoImpuesto3.TipoImpuesto.Tasa]
Carpeta=TipoImpuesto3
Clave=TipoImpuesto.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

















[TipoImpuesto3.ListaEnCaptura]
(Inicio)=TipoImpuesto3.TipoImpuesto
TipoImpuesto3.TipoImpuesto=TipoImpuesto.Concepto
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
