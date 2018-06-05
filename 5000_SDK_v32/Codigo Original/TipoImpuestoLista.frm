
[Forma]
Clave=TipoImpuestoLista
Icono=0
CarpetaPrincipal=TipoImpuesto
Modulos=(Todos)
Nombre=Lista Tipo Impuesto

ListaCarpetas=TipoImpuesto
PosicionInicialAlturaCliente=273
PosicionInicialAncho=507
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialIzquierda=429
PosicionInicialArriba=208
[TipoImpuesto]
Estilo=Iconos
Clave=TipoImpuesto
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoImpuesto
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
[TipoImpuesto.TipoImpuesto.TipoImpuesto]
Carpeta=TipoImpuesto
Clave=TipoImpuesto.TipoImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[TipoImpuesto.TipoImpuesto.Concepto]
Carpeta=TipoImpuesto
Clave=TipoImpuesto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[TipoImpuesto.TipoImpuesto.Tasa]
Carpeta=TipoImpuesto
Clave=TipoImpuesto.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[TipoImpuesto.Columnas]
0=-2
1=88
2=248
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

[TipoImpuesto.ListaEnCaptura]
(Inicio)=TipoImpuesto.TipoImpuesto
TipoImpuesto.TipoImpuesto=TipoImpuesto.Concepto
TipoImpuesto.Concepto=TipoImpuesto.Tasa
TipoImpuesto.Tasa=(Fin)
