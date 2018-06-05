[Forma]
Clave=ExplorarCampanaDEncuesta
Nombre=<T>Explorando - Encuestas de la Campaña
Icono=47
Modulos=CMP
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=597
PosicionInicialArriba=249
PosicionInicialAltura=448
PosicionInicialAncho=726
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=666
MovModulo=CMP
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
Comentarios=Lista(Info.Mov, Info.MovID)

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Movimientos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaDEncuesta
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Campo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroListasRama=CXP
FiltroListasAplicaEn=Compra.Proveedor
FiltroGrupo1=Campana.Mov
FiltroValida1=Campana.Mov
FiltroTodo=S
FiltroTodoFinal=S
PermiteLocalizar=S
ListaEnCaptura=(Lista)
IconosConSenales=S
FiltroAutoCampo=CampanaD.Situacion
FiltroAutoValidar=CampanaD.Situacion
FiltroGrupo2=Campana.MovID
FiltroValida2=Campana.MovID
IconosNombre=CampanaDEncuesta:CampanaEncuesta.Campo
FiltroGeneral=CampanaD.ID={Info.ID}

[Lista.Columnas]
0=181
1=216

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

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a E&xcel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Mostrar Campos]
Nombre=Mostrar Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Presentacion preliminar]
Nombre=Presentacion preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Lista.CampanaEncuesta.Respuesta]
Carpeta=Lista
Clave=CampanaEncuesta.Respuesta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaEncuesta.Calificacion]
Carpeta=Lista
Clave=CampanaEncuesta.Calificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ContactoNombre]
Carpeta=Lista
Clave=ContactoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Presentacion preliminar
Presentacion preliminar=Excel
Excel=Mostrar Campos
Mostrar Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CampanaEncuesta.Respuesta
CampanaEncuesta.Respuesta=CampanaEncuesta.Calificacion
CampanaEncuesta.Calificacion=ContactoNombre
ContactoNombre=(Fin)
