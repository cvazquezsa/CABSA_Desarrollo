[Forma]
Clave=ActivoFDR
Nombre=Depreciaciones y Reevaluaciones del Activo Fijo
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=423
PosicionInicialAncho=838
EsConsultaExclusiva=S
PosicionInicialIzquierda=93
PosicionInicialArriba=155
EsMovimiento=S
MovModulo=AF
TituloAuto=S
MovEspecificos=Todos
SinCondicionDespliege=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Articulo, Info.SerieLote)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFijoT
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimientos
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=10
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=ActivoFijo.Ejercicio
FiltroGrupo2=ActivoFijo.Periodo
FiltroTodo=S
IconosNombre=ActivoFijoT:ActivoFijo.Mov+<T> <T>+ActivoFijoT:ActivoFijo.MovID
FiltroGeneral=ActivoFijoD.Articulo=<T>{Info.Articulo}<T><BR> AND ActivoFijoD.Serie=<T>{Info.SerieLote}<T> <BR> AND MovTipo.Clave IN (<T>AF.DP<T>, <T>AF.DT<T>, <T>AF.RV<T>) <BR> AND ActivoFijo.Empresa=<T>{Empresa}<T> <BR> AND ActivoFijo.Estatus=<T>CONCLUIDO<T>

[Lista.ActivoFijoD.Depreciacion]
Carpeta=Lista
Clave=ActivoFijoD.Depreciacion
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFijoD.DepreciacionPorcentaje]
Carpeta=Lista
Clave=ActivoFijoD.DepreciacionPorcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFijoD.MesesDepreciados]
Carpeta=Lista
Clave=ActivoFijoD.MesesDepreciados
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFijoD.Inflacion]
Carpeta=Lista
Clave=ActivoFijoD.Inflacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFijoD.ActualizacionCapital]
Carpeta=Lista
Clave=ActivoFijoD.ActualizacionCapital
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFijoD.ActualizacionDepreciacion]
Carpeta=Lista
Clave=ActivoFijoD.ActualizacionDepreciacion
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=107
1=83

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

[Lista.ActivoFijo.FechaEmision]
Carpeta=Lista
Clave=ActivoFijo.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ActivoFijo.FechaEmision
ActivoFijo.FechaEmision=ActivoFijoD.Depreciacion
ActivoFijoD.Depreciacion=ActivoFijoD.DepreciacionPorcentaje
ActivoFijoD.DepreciacionPorcentaje=ActivoFijoD.MesesDepreciados
ActivoFijoD.MesesDepreciados=ActivoFijoD.Inflacion
ActivoFijoD.Inflacion=ActivoFijoD.ActualizacionCapital
ActivoFijoD.ActualizacionCapital=ActivoFijoD.ActualizacionDepreciacion
ActivoFijoD.ActualizacionDepreciacion=(Fin)
