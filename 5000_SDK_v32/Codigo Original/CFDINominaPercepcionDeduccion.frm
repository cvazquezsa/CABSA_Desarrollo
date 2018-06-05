
[Forma]
Clave=CFDINominaPercepcionDeduccion
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Nómina - Percepciones y Deducciones
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=296
PosicionInicialArriba=96
PosicionInicialAlturaCliente=497
PosicionInicialAncho=773
Comentarios=Lista(Info.Mov +<T> <T> + Info.MovID, Info.Personal)
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaPercepcionDeduccion
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tipo<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S

ListaOrden=CFDINominaPercepcionDeduccion.ClaveSAT<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroGrupo1=CFDINominaPercepcionDeduccion.Movimiento
FiltroValida1=CFDINominaPercepcionDeduccion.Movimiento
IconosNombre=CFDINominaPercepcionDeduccion:CFDINominaPercepcionDeduccion.Movimiento
FiltroTodo=S
FiltroGeneral=CFDINominaPercepcionDeduccion.ID = {Info.ID} AND<BR>CFDINominaPercepcionDeduccion.Personal = <T>{Info.Personal}<T>
[Lista.CFDINominaPercepcionDeduccion.Concepto]
Carpeta=Lista
Clave=CFDINominaPercepcionDeduccion.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.CFDINominaPercepcionDeduccion.TipoSAT]
Carpeta=Lista
Clave=CFDINominaPercepcionDeduccion.TipoSAT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.CFDINominaPercepcionDeduccion.ClaveSAT]
Carpeta=Lista
Clave=CFDINominaPercepcionDeduccion.ClaveSAT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.CFDINominaPercepcionDeduccion.ImporteGravado]
Carpeta=Lista
Clave=CFDINominaPercepcionDeduccion.ImporteGravado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.CFDINominaPercepcionDeduccion.ImporteExcento]
Carpeta=Lista
Clave=CFDINominaPercepcionDeduccion.ImporteExcento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[Lista.Columnas]
0=81
1=144
2=60
3=73
4=108
5=124











[Lista.ListaEnCaptura]
(Inicio)=CFDINominaPercepcionDeduccion.Concepto
CFDINominaPercepcionDeduccion.Concepto=CFDINominaPercepcionDeduccion.TipoSAT
CFDINominaPercepcionDeduccion.TipoSAT=CFDINominaPercepcionDeduccion.ClaveSAT
CFDINominaPercepcionDeduccion.ClaveSAT=CFDINominaPercepcionDeduccion.ImporteGravado
CFDINominaPercepcionDeduccion.ImporteGravado=CFDINominaPercepcionDeduccion.ImporteExcento
CFDINominaPercepcionDeduccion.ImporteExcento=(Fin)

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


EspacioPrevio=S
[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Preliminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S




[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S



















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=(Fin)
