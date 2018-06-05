[Forma]
Clave=ActivoFInfo
Nombre=Información del Activo Fijo
Icono=6
Modulos=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=328
PosicionInicialArriba=235
PosicionInicialAltura=626
PosicionInicialAncho=624
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=520
VentanaEscCerrar=S
EsConsultaExclusiva=S

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=116
Descripcion1=198
SerieLote=107
Serie=115
0=120
1=157

[Detalle]
Estilo=Ficha
PestanaNombre=Datos Generales
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoF
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
CarpetaVisible=S
PestanaOtroNombre=S
Pestana=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ActivoF.Empresa=<T>{Empresa}<T> AND ActivoF.Articulo=<T>{Info.Articulo}<T> AND ActivoF.Serie=<T>{Info.SerieLote}<T>

[Detalle.ActivoF.Articulo]
Carpeta=Detalle
Clave=ActivoF.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Editar=S
EspacioPrevio=N

[Detalle.Art.Descripcion1]
Carpeta=Detalle
Clave=Art.Descripcion1
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ActivoF.Almacen]
Carpeta=Detalle
Clave=ActivoF.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.ActivoF.Localizacion]
Carpeta=Detalle
Clave=ActivoF.Localizacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ActivoF.Categoria]
Carpeta=Detalle
Clave=ActivoF.Categoria
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ActivoF.AdquisicionValor]
Carpeta=Detalle
Clave=ActivoF.AdquisicionValor
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[Detalle.ActivoF.AdquisicionFecha]
Carpeta=Detalle
Clave=ActivoF.AdquisicionFecha
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ActivoF.VidaUtil]
Carpeta=Detalle
Clave=ActivoF.VidaUtil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Detalle.ActivoF.Utilizacion]
Carpeta=Detalle
Clave=ActivoF.Utilizacion
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Detalle.ActivoF.DepreciacionAcum]
Carpeta=Detalle
Clave=ActivoF.DepreciacionAcum
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Detalle.ActivoF.DepreciacionUltima]
Carpeta=Detalle
Clave=ActivoF.DepreciacionUltima
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20
EspacioPrevio=S

[Detalle.ActivoF.RevaluacionUltima]
Carpeta=Detalle
Clave=ActivoF.RevaluacionUltima
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20
EspacioPrevio=N

[Detalle.ActivoF.Observaciones]
Carpeta=Detalle
Clave=ActivoF.Observaciones
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro

[Detalle.EstatusNombre]
Carpeta=Detalle
Clave=EstatusNombre
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S
Efectos=[Negritas]
EspacioPrevio=N

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
Menu=&Archivo
NombreDesplegar=&Cerrar
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreEnBoton=S
EnBarraHerramientas=S

[Lista.ActivoF.Serie]
Carpeta=Lista
Clave=ActivoF.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ActivoF.Serie]
Carpeta=Detalle
Clave=ActivoF.Serie
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
LineaNueva=N

[Lista.ActivoF.Articulo]
Carpeta=Lista
Clave=ActivoF.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=&Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
EnMenu=S
AntesExpresiones=Asigna(Info.Articulo, ActivoF:ActivoF.Articulo)

[Acciones.SerieLoteInfo]
Nombre=SerieLoteInfo
Boton=50
NombreEnBoton=S
NombreDesplegar=&Historial Artículo/Serie
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Activo=S
Antes=S
Visible=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+H
EnMenu=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Articulo, ActivoF:ActivoF.Articulo)<BR>Asigna(Info.ArtTipo, TipoSerie)<BR>Asigna(Info.SerieLote, ActivoF:ActivoF.Serie)

[Detalle.ActivoF.Moneda]
Carpeta=Detalle
Clave=ActivoF.Moneda
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.DepreciacionPorcentaje]
Carpeta=Detalle
Clave=DepreciacionPorcentaje
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ActivoF.DepreciacionMeses]
Carpeta=Detalle
Clave=ActivoF.DepreciacionMeses
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Abrir).ActivoF.Serie]
Carpeta=(Carpeta Abrir)
Clave=ActivoF.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=110
1=101

[(Carpeta Abrir).ActivoF.Almacen]
Carpeta=(Carpeta Abrir)
Clave=ActivoF.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Actualizar
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
Carpeta=(Carpeta Abrir)

[Acciones.Excel]
Nombre=Excel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[(Carpeta Abrir).Art.Descripcion1]
Carpeta=(Carpeta Abrir)
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros2]
Nombre=Otros2
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros3]
Nombre=Otros3
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros4]
Nombre=Otros4
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros5]
Nombre=Otros5
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros6]
Nombre=Otros6
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros7]
Nombre=Otros7
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros8]
Nombre=Otros8
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros9]
Nombre=Otros9
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Detalle.ActivoF.CentroCostos]
Carpeta=Detalle
Clave=ActivoF.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ActivoF.Cliente]
Carpeta=Detalle
Clave=ActivoF.Cliente
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.CentroCostos.Descripcion]
Carpeta=Detalle
Clave=CentroCostos.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Cte.Nombre]
Carpeta=Detalle
Clave=Cte.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ActivoF.Responsable]
Carpeta=Detalle
Clave=ActivoF.Responsable
Editar=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[Acciones.Gastos]
Nombre=Gastos
Boton=64
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+F
NombreDesplegar=Gastos del Activo &Fijo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ExplorarGastoAF
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Articulo, ActivoF:ActivoF.Articulo)<BR>Asigna(Info.SerieLote, ActivoF:ActivoF.Serie)

[Mantenimiento]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Mantenimiento
Clave=Mantenimiento
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoF
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
ListaEnCaptura=(Lista)

[Mantenimiento.ActivoF.Articulo]
Carpeta=Mantenimiento
Clave=ActivoF.Articulo
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Mantenimiento.Art.Descripcion1]
Carpeta=Mantenimiento
Clave=Art.Descripcion1
Editar=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Seguro.ActivoF.Articulo]
Carpeta=Seguro
Clave=ActivoF.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Seguro.Art.Descripcion1]
Carpeta=Seguro
Clave=Art.Descripcion1
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.Serie]
Carpeta=Mantenimiento
Clave=ActivoF.Serie
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.Almacen]
Carpeta=Mantenimiento
Clave=ActivoF.Almacen
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S

[Mantenimiento.ActivoF.Localizacion]
Carpeta=Mantenimiento
Clave=ActivoF.Localizacion
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.Categoria]
Carpeta=Mantenimiento
Clave=ActivoF.Categoria
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Seguro.ActivoF.Serie]
Carpeta=Seguro
Clave=ActivoF.Serie
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Seguro.ActivoF.Almacen]
Carpeta=Seguro
Clave=ActivoF.Almacen
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
LineaNueva=S

[Seguro.ActivoF.Localizacion]
Carpeta=Seguro
Clave=ActivoF.Localizacion
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Seguro.ActivoF.Categoria]
Carpeta=Seguro
Clave=ActivoF.Categoria
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoSiguiente]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoSiguiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoPeriodicidad]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoPeriodicidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoCantidad]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoCantidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoUnidad]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoUnidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoUltimo]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoUltimo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=$00E3DFE0
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoAcum]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoAcum
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.MantenimientoPromedio]
Carpeta=Mantenimiento
Clave=MantenimientoPromedio
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.Mantenimientos]
Carpeta=Mantenimiento
Clave=ActivoF.Mantenimientos
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoHoras]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoHoras
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.ReparacionUltima]
Carpeta=Mantenimiento
Clave=ActivoF.ReparacionUltima
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.ReparacionAcum]
Carpeta=Mantenimiento
Clave=ActivoF.ReparacionAcum
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.Reparaciones]
Carpeta=Mantenimiento
Clave=ActivoF.Reparaciones
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.ReparacionHoras]
Carpeta=Mantenimiento
Clave=ActivoF.ReparacionHoras
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ReparacionPromedio]
Carpeta=Mantenimiento
Clave=ReparacionPromedio
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ActivoF.Referencia]
Carpeta=Detalle
Clave=ActivoF.Referencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.Referencia]
Carpeta=Mantenimiento
Clave=ActivoF.Referencia
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ActivoF.DepreciacionInicio]
Carpeta=Detalle
Clave=ActivoF.DepreciacionInicio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ActivoF.ValorRevaluado]
Carpeta=Detalle
Clave=ActivoF.ValorRevaluado
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Detalle.ValorHistoricoNeto]
Carpeta=Detalle
Clave=ValorHistoricoNeto
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.ActivoFDR]
Nombre=ActivoFDR
Boton=51
Menu=&Ver
NombreDesplegar=&Depreciaciones y Reevaluaciones
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=ActivoFDR
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
AntesExpresiones=Asigna(Info.Articulo, ActivoF:ActivoF.Articulo)<BR>Asigna(Info.SerieLote, ActivoF:ActivoF.Serie)

[Detalle.NombreCompleto]
Carpeta=Detalle
Clave=NombreCompleto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
OcultaNombre=S

[Detalle.ActivoF.Espacio]
Carpeta=Detalle
Clave=ActivoF.Espacio
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Espacio.Nombre]
Carpeta=Detalle
Clave=Espacio.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
OcultaNombre=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F11
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=PropInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(ActivoF:ActivoF.ID)
AntesExpresiones=Asigna(Info.Descripcion, ActivoF:ActivoF.Articulo+<T> <T>+ActivoF:ActivoF.Serie) <BR>Asigna(Info.Rama, <T>AF<T>)<BR>Asigna(Info.Cuenta, ActivoF:ActivoF.ID)

[Garantia]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Garantía
Clave=Garantia
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoF
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
ListaEnCaptura=(Lista)

[Garantia.ActivoF.Articulo]
Carpeta=Garantia
Clave=ActivoF.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Garantia.Art.Descripcion1]
Carpeta=Garantia
Clave=Art.Descripcion1
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Garantia.ActivoF.Serie]
Carpeta=Garantia
Clave=ActivoF.Serie
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Mantenimiento.ActivoF.MantenimientoVence]
Carpeta=Mantenimiento
Clave=ActivoF.MantenimientoVence
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Garantia.ActivoF.Almacen]
Carpeta=Garantia
Clave=ActivoF.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Garantia.ActivoF.Localizacion]
Carpeta=Garantia
Clave=ActivoF.Localizacion
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Garantia.ActivoF.Categoria]
Carpeta=Garantia
Clave=ActivoF.Categoria
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Garantia.ActivoF.Referencia]
Carpeta=Garantia
Clave=ActivoF.Referencia
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Garantia.ActivoF.Garantia]
Carpeta=Garantia
Clave=ActivoF.Garantia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Garantia.ActivoF.GarantiaVence]
Carpeta=Garantia
Clave=ActivoF.GarantiaVence
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Seguro]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Seguro
Clave=Seguro
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoF
Fuente={Tahoma, 8, Negro, []}
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
CarpetaVisible=S

[Seguro.ActivoF.Referencia]
Carpeta=Seguro
Clave=ActivoF.Referencia
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Seguro.ActivoF.SeguroVence]
Carpeta=Seguro
Clave=ActivoF.SeguroVence
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Seguro.ActivoF.SeguroAcum]
Carpeta=Seguro
Clave=ActivoF.SeguroAcum
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Seguro.ActivoF.SeguroInicio]
Carpeta=Seguro
Clave=ActivoF.SeguroInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Seguro.ActivoF.SeguroTipoPoliza]
Carpeta=Seguro
Clave=ActivoF.SeguroTipoPoliza
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Seguro.ActivoF.Aseguradora]
Carpeta=Seguro
Clave=ActivoF.Aseguradora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[Seguro.ActivoF.SeguroMonto]
Carpeta=Seguro
Clave=ActivoF.SeguroMonto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Seguro.ProvAseguradora.Nombre]
Carpeta=Seguro
Clave=ProvAseguradora.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ActivoF.Departamento]
Carpeta=Detalle
Clave=ActivoF.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[Detalle.ActivoF.Licencia]
Carpeta=Detalle
Clave=ActivoF.Licencia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Evaluacion]
Nombre=Evaluacion
Boton=103
Menu=&Ver
NombreDesplegar=Evaluaciones
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=EvaluacionCalificacionInfo
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Clave, ActivoF:ActivoF.ID)<BR>Asigna(Info.Nombre, ActivoF:ActivoF.Articulo+<T>/<T>+ActivoF:ActivoF.Serie)<BR>Asigna(Info.Aplica, <T>Activos Fijos<T>)<BR>Asigna(Info.Nombre2, Nulo)

[Detalle.ActivoF.Arrendadora]
Carpeta=Detalle
Clave=ActivoF.Arrendadora
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Detalle.ProvArrendadora.Nombre]
Carpeta=Detalle
Clave=ProvArrendadora.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Movimientos.Columnas]
0=114
1=104

[Mantenimientos.Columnas]
0=94
1=92

[DetalleMantenimientos]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalle Mantenimientos
Clave=DetalleMantenimientos
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFijoMov
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroAplicaEn=ActivoFijo.Mov
FiltroPredefinido=S
FiltroAutoCampo=ActivoFijo.Mov
FiltroAutoValidar=ActivoFijo.Mov
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
IconosNombre=ActivoFijoMov:Mov+<T> <T>+ActivoFijoMov:MovID
FiltroGeneral=e.Empresa=<T>{Empresa}<T> AND e.Estatus=<T>CONCLUIDO<T> AND d.Articulo=<T>{Info.Articulo}<T> AND d.Serie=<T>{Info.SerieLote}<T> AND mt.Clave=<T>AF.MA<T>

[DetalleMantenimientos.FechaEmision]
Carpeta=DetalleMantenimientos
Clave=FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[DetalleMantenimientos.Proveedor]
Carpeta=DetalleMantenimientos
Clave=Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[DetalleMantenimientos.Horas]
Carpeta=DetalleMantenimientos
Clave=Horas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[DetalleMantenimientos.Observaciones]
Carpeta=DetalleMantenimientos
Clave=Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[DetalleMantenimientos.Columnas]
0=99
1=79

[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=Seguro
Seguro=Garantia
Garantia=Mantenimiento
Mantenimiento=DetalleMantenimientos
DetalleMantenimientos=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Propiedades
Propiedades=Evaluacion
Evaluacion=ArtInfo
ArtInfo=SerieLoteInfo
SerieLoteInfo=ActivoFDR
ActivoFDR=Gastos
Gastos=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=ActivoF.Articulo
ActivoF.Articulo=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Localizacion
ActivoF.Localizacion=ActivoF.Categoria
ActivoF.Categoria=ActivoF.Referencia
ActivoF.Referencia=ActivoF.Departamento
ActivoF.Departamento=ActivoF.Licencia
ActivoF.Licencia=ActivoF.Arrendadora
ActivoF.Arrendadora=ProvArrendadora.Nombre
ProvArrendadora.Nombre=ActivoF.CentroCostos
ActivoF.CentroCostos=CentroCostos.Descripcion
CentroCostos.Descripcion=ActivoF.Cliente
ActivoF.Cliente=Cte.Nombre
Cte.Nombre=ActivoF.AdquisicionValor
ActivoF.AdquisicionValor=ActivoF.AdquisicionFecha
ActivoF.AdquisicionFecha=ActivoF.DepreciacionInicio
ActivoF.DepreciacionInicio=ActivoF.Moneda
ActivoF.Moneda=ActivoF.VidaUtil
ActivoF.VidaUtil=ActivoF.DepreciacionMeses
ActivoF.DepreciacionMeses=DepreciacionPorcentaje
DepreciacionPorcentaje=ActivoF.Utilizacion
ActivoF.Utilizacion=ActivoF.DepreciacionUltima
ActivoF.DepreciacionUltima=ActivoF.DepreciacionAcum
ActivoF.DepreciacionAcum=ValorHistoricoNeto
ValorHistoricoNeto=ActivoF.RevaluacionUltima
ActivoF.RevaluacionUltima=ActivoF.ValorRevaluado
ActivoF.ValorRevaluado=ActivoF.Responsable
ActivoF.Responsable=NombreCompleto
NombreCompleto=ActivoF.Espacio
ActivoF.Espacio=Espacio.Nombre
Espacio.Nombre=EstatusNombre
EstatusNombre=ActivoF.Observaciones
ActivoF.Observaciones=(Fin)

[Mantenimiento.ListaEnCaptura]
(Inicio)=ActivoF.Articulo
ActivoF.Articulo=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Localizacion
ActivoF.Localizacion=ActivoF.Categoria
ActivoF.Categoria=ActivoF.Referencia
ActivoF.Referencia=ActivoF.MantenimientoSiguiente
ActivoF.MantenimientoSiguiente=ActivoF.MantenimientoPeriodicidad
ActivoF.MantenimientoPeriodicidad=ActivoF.MantenimientoCantidad
ActivoF.MantenimientoCantidad=ActivoF.MantenimientoUnidad
ActivoF.MantenimientoUnidad=ActivoF.MantenimientoUltimo
ActivoF.MantenimientoUltimo=ActivoF.MantenimientoAcum
ActivoF.MantenimientoAcum=ActivoF.MantenimientoHoras
ActivoF.MantenimientoHoras=ActivoF.Mantenimientos
ActivoF.Mantenimientos=MantenimientoPromedio
MantenimientoPromedio=ActivoF.MantenimientoVence
ActivoF.MantenimientoVence=ActivoF.ReparacionUltima
ActivoF.ReparacionUltima=ActivoF.ReparacionAcum
ActivoF.ReparacionAcum=ActivoF.ReparacionHoras
ActivoF.ReparacionHoras=ActivoF.Reparaciones
ActivoF.Reparaciones=ReparacionPromedio
ReparacionPromedio=(Fin)

[Garantia.ListaEnCaptura]
(Inicio)=ActivoF.Articulo
ActivoF.Articulo=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Localizacion
ActivoF.Localizacion=ActivoF.Categoria
ActivoF.Categoria=ActivoF.Referencia
ActivoF.Referencia=ActivoF.Garantia
ActivoF.Garantia=ActivoF.GarantiaVence
ActivoF.GarantiaVence=(Fin)

[Seguro.ListaEnCaptura]
(Inicio)=ActivoF.Articulo
ActivoF.Articulo=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Localizacion
ActivoF.Localizacion=ActivoF.Categoria
ActivoF.Categoria=ActivoF.Referencia
ActivoF.Referencia=ActivoF.Aseguradora
ActivoF.Aseguradora=ProvAseguradora.Nombre
ProvAseguradora.Nombre=ActivoF.SeguroTipoPoliza
ActivoF.SeguroTipoPoliza=ActivoF.SeguroInicio
ActivoF.SeguroInicio=ActivoF.SeguroVence
ActivoF.SeguroVence=ActivoF.SeguroMonto
ActivoF.SeguroMonto=ActivoF.SeguroAcum
ActivoF.SeguroAcum=(Fin)

[DetalleMantenimientos.ListaEnCaptura]
(Inicio)=FechaEmision
FechaEmision=Proveedor
Proveedor=Horas
Horas=Observaciones
Observaciones=(Fin)
