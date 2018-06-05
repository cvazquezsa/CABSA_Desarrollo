[Forma]
Clave=ExplorarRHPersonal
Nombre=Explorando - Movimientos en Recursos Humanos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=199
PosicionInicialArriba=154
PosicionInicialAltura=453
PosicionInicialAncho=625
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
PosicionInicialAlturaCliente=426
Comentarios=Lista(Info.Personal, Info.Nombre)

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RHT
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Departamento
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=Puesto
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=PersonalCat
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=PersonalGrupo
FiltroAplicaEn1=Personal.Departamento
FiltroAplicaEn2=Personal.Puesto
FiltroAplicaEn3=Personal.Categoria
FiltroAplicaEn4=Personal.Grupo
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
FiltroListas=S
FiltroListasRama=RH
FiltroListasAplicaEn=RHD.Personal
FiltroFechas=S
FiltroSucursales=S
FiltroListaEstatus=CONCLUIDO
FiltroFechasCampo=RH.FechaEmision
FiltroFechasDefault=Este Mes
BusquedaRapida=S
BusquedaEnLinea=S
PestanaOtroNombre=S
BusquedaAncho=20
OtroOrden=S
ListaOrden=RH.FechaEmision<TAB>(Acendente)
FiltroProyectos=S
IconosNombre=RHT:RH.Mov+<T> <T>+RHT:RH.MovID
FiltroGeneral=RH.Empresa=<T>{Empresa}<T> AND RH.Estatus=<T>CONCLUIDO<T> AND RHD.Personal=<T>{Info.Personal}<T>
FiltroSucursalesTodasPorOmision=S

[Lista.RH.FechaEmision]
Carpeta=Lista
Clave=RH.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RH.Concepto]
Carpeta=Lista
Clave=RH.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RHD.SueldoDiario]
Carpeta=Lista
Clave=RHD.SueldoDiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=160
1=87

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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S


[Lista.ListaEnCaptura]
(Inicio)=RH.FechaEmision
RH.FechaEmision=RH.Concepto
RH.Concepto=RHD.SueldoDiario
RHD.SueldoDiario=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)
