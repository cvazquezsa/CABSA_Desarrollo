
[Forma]
Clave=MFAConceptoOpcionalLista
Icono=0
Modulos=(Todos)
Nombre=MFA - Concepto

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialIzquierda=271
PosicionInicialArriba=176
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAConceptoOpcional
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Concepto<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Conceptos
IconosNombre=MFAConceptoOpcional:MFAConceptoOpcional.concepto_clave
[Lista.MFAConceptoOpcional.concepto_descripcion]
Carpeta=Lista
Clave=MFAConceptoOpcional.concepto_descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.MFAConceptoOpcional.concepto_tipo]
Carpeta=Lista
Clave=MFAConceptoOpcional.concepto_tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

[Lista.Columnas]
0=172
1=247
2=-2


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

[Lista.ListaEnCaptura]
(Inicio)=MFAConceptoOpcional.concepto_descripcion
MFAConceptoOpcional.concepto_descripcion=MFAConceptoOpcional.concepto_tipo
MFAConceptoOpcional.concepto_tipo=(Fin)
