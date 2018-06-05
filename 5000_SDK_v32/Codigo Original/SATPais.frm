[Forma]
Clave=SATPais
Nombre=Catálogo de Países
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=432
PosicionInicialArriba=134
PosicionInicialAltura=346
PosicionInicialAncho=501
PosicionInicialAlturaCliente=421

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ListaAcciones=Cerrar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATPais
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=SATPais.ClavePais<TAB>(Acendente)






[Lista.Columnas]
LimiteInferior=102
LimiteSuperior=98
Cuota=87
Porcentaje=59
TablaImpuesto=96
PeriodoTipo=82
Fecha=108

ClavePais=61
Descripcion=160
FormatoCP=127
FormatoRIT=189
ValidacionRIT=198

[Lista.SATPais.ClavePais]
Carpeta=Lista
Clave=SATPais.ClavePais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco

[Lista.SATPais.Descripcion]
Carpeta=Lista
Clave=SATPais.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.SATPais.FormatoCP]
Carpeta=Lista
Clave=SATPais.FormatoCP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.SATPais.FormatoRIT]
Carpeta=Lista
Clave=SATPais.FormatoRIT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.SATPais.ValidacionRIT]
Carpeta=Lista
Clave=SATPais.ValidacionRIT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

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

[Lista.ListaEnCaptura]
(Inicio)=SATPais.ClavePais
SATPais.ClavePais=SATPais.Descripcion
SATPais.Descripcion=SATPais.FormatoCP
SATPais.FormatoCP=SATPais.FormatoRIT
SATPais.FormatoRIT=SATPais.ValidacionRIT
SATPais.ValidacionRIT=(Fin)
