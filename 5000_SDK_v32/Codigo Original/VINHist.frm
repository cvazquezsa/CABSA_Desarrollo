[Forma]
Clave=VINHist
Nombre=Histórico de Cambios (VIN)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=186
PosicionInicialArriba=158
PosicionInicialAlturaCliente=368
PosicionInicialAncho=740
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Info.SerieLote

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VINHist
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Fecha<T>
ElementosPorPagina=200
PestanaOtroNombre=S
IconosNombre=VINHist:VINHist.Fecha
FiltroGeneral=VINHist.VIN=<T>{Info.SerieLote}<T>

[Lista.VINHist.Placas]
Carpeta=Lista
Clave=VINHist.Placas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VINHist.Cliente]
Carpeta=Lista
Clave=VINHist.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VINHist.Conductor]
Carpeta=Lista
Clave=VINHist.Conductor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteDestino.Nombre]
Carpeta=Lista
Clave=CteDestino.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Fecha=118
Placas=103
Cliente=93
Nombre=130
Conductor=88
Nombre_1=191
0=111
1=144

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

[Lista.VINHist.Estatus]
Carpeta=Lista
Clave=VINHist.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VINHist.Situacion]
Carpeta=Lista
Clave=VINHist.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VINHist.SituacionFecha]
Carpeta=Lista
Clave=VINHist.SituacionFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
(Inicio)=Cerrar
Cerrar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VINHist.Placas
VINHist.Placas=VINHist.Cliente
VINHist.Cliente=Cte.Nombre
Cte.Nombre=VINHist.Conductor
VINHist.Conductor=CteDestino.Nombre
CteDestino.Nombre=VINHist.Estatus
VINHist.Estatus=VINHist.Situacion
VINHist.Situacion=VINHist.SituacionFecha
VINHist.SituacionFecha=(Fin)
