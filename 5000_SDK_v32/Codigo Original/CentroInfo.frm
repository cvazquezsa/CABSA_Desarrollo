[Forma]
Clave=CentroInfo
Nombre=Información del Centro Trabajo
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=105
PosicionInicialArriba=221
PosicionInicialAltura=326
PosicionInicialAncho=814
PosicionColumna1=38
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Info.Centro

[Ficha]
Estilo=Ficha
Clave=Ficha
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Centro
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=Centro.Centro=<T>{Info.Centro}<T>

[Ficha.Centro.Centro]
Carpeta=Ficha
Clave=Centro.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Centro.Descripcion]
Carpeta=Ficha
Clave=Centro.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Centro.Tipo]
Carpeta=Ficha
Clave=Centro.Tipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ordenes Trabajando
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ProdPendienteD
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=ProdPendienteD:ProdPendienteD.Mov+<T> <T>+ProdPendienteD:ProdPendienteD.MovID
FiltroGeneral=ProdPendienteD.Centro=<T>{Info.Centro}<T>

[Lista.ProdPendienteD.Ruta]
Carpeta=Lista
Clave=ProdPendienteD.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdPendienteD.FechaEmision]
Carpeta=Lista
Clave=ProdPendienteD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdPendienteD.Unidad]
Carpeta=Lista
Clave=ProdPendienteD.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=124
1=71

[Lista.ProdPendienteD.FechaEntrega]
Carpeta=Lista
Clave=ProdPendienteD.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProdPendienteD.Cantidad]
Carpeta=Lista
Clave=ProdPendienteD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Ficha.Centro.Almacen]
Carpeta=Ficha
Clave=Centro.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.OPCampos]
Nombre=OPCampos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.OPPropiedades]
Nombre=OPPropiedades
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>PROD<T>)<BR>Asigna(Info.ID, ProdPendienteD:ProdPendienteD.ID)
Visible=S

[Acciones.Plan]
Nombre=Plan
Boton=88
NombreEnBoton=S
NombreDesplegar=&Plan
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=PlanCentro
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Centro, Centro:Centro.Centro)<BR>Asigna(Info.Descripcion, <T>Plan - Centro Trabajo<T>)

[Acciones.Grafica]
Nombre=Grafica
Boton=49
NombreEnBoton=S
NombreDesplegar=&Gráfica
EnBarraHerramientas=S
TipoAccion=Expresion
Expresion=VerCRP(Centro:Centro.Centro+<T> - <T>+Centro:Centro.Descripcion, Centro:Centro.Centro)
Activo=S
Visible=S

[Ficha.Centro.TiempoCola]
Carpeta=Ficha
Clave=Centro.TiempoCola
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Centro.TiempoEspera]
Carpeta=Ficha
Clave=Centro.TiempoEspera
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Lista
Lista=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Plan
Plan=Grafica
Grafica=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Centro.Centro
Centro.Centro=Centro.Tipo
Centro.Tipo=Centro.Descripcion
Centro.Descripcion=Centro.Almacen
Centro.Almacen=Centro.TiempoCola
Centro.TiempoCola=Centro.TiempoEspera
Centro.TiempoEspera=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProdPendienteD.Ruta
ProdPendienteD.Ruta=ProdPendienteD.FechaEmision
ProdPendienteD.FechaEmision=ProdPendienteD.FechaEntrega
ProdPendienteD.FechaEntrega=ProdPendienteD.Cantidad
ProdPendienteD.Cantidad=ProdPendienteD.Unidad
ProdPendienteD.Unidad=(Fin)

[Lista.ListaAcciones]
(Inicio)=OPPropiedades
OPPropiedades=OPCampos
OPCampos=(Fin)
