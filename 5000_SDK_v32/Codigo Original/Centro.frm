[Forma]
Clave=Centro
Nombre=Centros Trabajo
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=322
PosicionInicialArriba=302
PosicionInicialAltura=396
PosicionInicialAncho=635
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
BarraAyuda=S
PosicionSeccion1=55
PosicionColumna2=47
PosicionSeccion2=66
PosicionColumna3=47
PosicionColumna1=45
Menus=S
VentanaBloquearAjuste=N
DialogoAbrir=S
Plantillas=S
PermiteCopiarDoc=S
PlantillasExcepciones=Centro:Centro.Estatus
PosicionInicialAlturaCliente=393
MenuPrincipal=(Lista)

[Lista.Columnas]
Centro=104
Agente=64
ActivoFijo=124
Serie=124
Descripcion=224
Tipo=80
Almacen=93
CentroTrabajo=109
Categoria=135
Orden=37

[Detalle.Centro.Centro]
Carpeta=Detalle
Clave=Centro.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Centro.Descripcion]
Carpeta=Detalle
Clave=Centro.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+G

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+N

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
EspacioPrevio=S
GuardarAntes=S
ActivoCondicion=no Centro:Centro.TieneMovimientos

[Agentes.CentroAgente.Agente]
Carpeta=Agentes
Clave=CentroAgente.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Agentes.Agente.Nombre]
Carpeta=Agentes
Clave=Agente.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Agentes.Columnas]
Agente=106
Nombre=183
Grupo=114

[Activos.CentroAF.ActivoFijo]
Carpeta=Activos
Clave=CentroAF.ActivoFijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Activos.CentroAF.Serie]
Carpeta=Activos
Clave=CentroAF.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Activos.ActivoF.Almacen]
Carpeta=Activos
Clave=ActivoF.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

[Activos.Columnas]
ActivoFijo=118
Serie=104
Almacen=76
Categoria=104

[Indirectos.CentroIndirectos.Concepto]
Carpeta=Indirectos
Clave=CentroIndirectos.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Indirectos.CentroIndirectos.Tipo]
Carpeta=Indirectos
Clave=CentroIndirectos.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Indirectos.CentroIndirectos.Importe]
Carpeta=Indirectos
Clave=CentroIndirectos.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Indirectos.Columnas]
Concepto=184
Tipo=56
Importe=92
Moneda=70

[Agentes.Agente.Grupo]
Carpeta=Agentes
Clave=Agente.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Activos.ActivoF.Categoria]
Carpeta=Activos
Clave=ActivoF.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Indirectos.CentroIndirectos.Moneda]
Carpeta=Indirectos
Clave=CentroIndirectos.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[qa.Columnas]
Centro=64
Descripcion=244
Categoria=229

[Lista.Centro.Centro]
Carpeta=Lista
Clave=Centro.Centro
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Centro.Descripcion]
Carpeta=Lista
Clave=Centro.Descripcion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Centro.Tipo]
Carpeta=Detalle
Clave=Centro.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Estacion.Centro.Centro]
Carpeta=Estacion
Clave=Centro.Centro
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Estacion.Centro.Descripcion]
Carpeta=Estacion
Clave=Centro.Descripcion
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Estacion.Centro.Rama]
Carpeta=Estacion
Clave=Centro.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Estacion.CentroDestino.Descripcion]
Carpeta=Estacion
Clave=CentroDestino.Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Estacion.Centro.TurnosDiarios]
Carpeta=Estacion
Clave=Centro.TurnosDiarios
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N
Efectos=[Negritas]

[Estacion.Centro.HorasTurno]
Carpeta=Estacion
Clave=Centro.HorasTurno
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Estacion.Centro.Eficiencia]
Carpeta=Estacion
Clave=Centro.Eficiencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Estacion.Centro.Utilizacion]
Carpeta=Estacion
Clave=Centro.Utilizacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Estacion.Centro.CostoManoObra]
Carpeta=Estacion
Clave=Centro.CostoManoObra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Estacion.Centro.CostoIndirectos]
Carpeta=Estacion
Clave=Centro.CostoIndirectos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Estacion.Centro.CostoMoneda]
Carpeta=Estacion
Clave=Centro.CostoMoneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Estacion.Centro.DiasFestivos]
Carpeta=Estacion
Clave=Centro.DiasFestivos
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Estacion.Centro.DiasSemana]
Carpeta=Estacion
Clave=Centro.DiasSemana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Calendario]
Nombre=Calendario
Boton=9
Menu=&Ver
NombreDesplegar=&Calendario
EnMenu=S
TipoAccion=Otros
ClaveAccion=Calendario
Activo=S
Visible=S

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Centro Trabajo
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Centro
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=141
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Detalle.Centro.Almacen]
Carpeta=Detalle
Clave=Centro.Almacen
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Acciones.EstacionT]
Nombre=EstacionT
Boton=91
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+E
NombreDesplegar=&Estaciones del Centro Trabajo
EnMenu=S
TipoAccion=Formas
ClaveAccion=EstacionTListaCentro
ConCondicion=S
Antes=S
Visible=S
GuardarAntes=S
Activo=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Centro:Centro.Centro)
AntesExpresiones=Asigna(Info.Centro, Centro:Centro.Centro)<BR>Asigna(Info.Descripcion, Centro:Centro.Descripcion)

[Acciones.Grafica]
Nombre=Grafica
Boton=49
Menu=&Ver
NombreDesplegar=&Gráfica
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
Expresion=VerCRP(Centro:Centro.Centro+<T> - <T>+Centro:Centro.Descripcion, Centro:Centro.Centro)
EjecucionCondicion=ConDatos(Centro:Centro.Centro)

[Omision]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Valores por Omisión
Clave=Omision
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Centro
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Omision.Centro.DiasSemana]
Carpeta=Omision
Clave=Centro.DiasSemana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Omision.Centro.TurnosDiarios]
Carpeta=Omision
Clave=Centro.TurnosDiarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Omision.Centro.HorasTurno]
Carpeta=Omision
Clave=Centro.HorasTurno
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Omision.Centro.Eficiencia]
Carpeta=Omision
Clave=Centro.Eficiencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Omision.Centro.Utilizacion]
Carpeta=Omision
Clave=Centro.Utilizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Omision.Centro.Centro]
Carpeta=Omision
Clave=Centro.Centro
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Omision.Centro.Descripcion]
Carpeta=Omision
Clave=Centro.Descripcion
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
LineaNueva=N

[Acciones.Plan]
Nombre=Plan
Boton=88
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+P
NombreDesplegar=Plan
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=PlanCentro
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Centro:Centro.Centro)
AntesExpresiones=Asigna(Info.Centro, Centro:Centro.Centro)<BR>Asigna(Info.Descripcion, <T>Plan - Centro Trabajo<T>)

[Acciones.Capacidad]
Nombre=Capacidad
Boton=0
Menu=&Ver
NombreDesplegar=Capacidad &Total
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=PlanCentro
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Centro, <T><T>)<BR>Asigna(Info.Descripcion, <T>Capacidad Total<T>)
Visible=S

[Acciones.CentroInfo]
Nombre=CentroInfo
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=Información
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CentroInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Centro:Centro.Centro)
AntesExpresiones=Asigna(Info.Centro, Centro:Centro.Centro)

[Detalle.Centro.CostoManoObra]
Carpeta=Detalle
Clave=Centro.CostoManoObra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Centro.CostoIndirectos]
Carpeta=Detalle
Clave=Centro.CostoIndirectos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Detalle.Centro.CostoMoneda]
Carpeta=Detalle
Clave=Centro.CostoMoneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Acciones.CentroTipo]
Nombre=CentroTipo
Boton=0
Menu=&Maestros
NombreDesplegar=&Tipos
EnMenu=S
TipoAccion=Formas
ClaveAccion=CentroTipo
Activo=S
Visible=S

[Detalle.Centro.Estatus]
Carpeta=Detalle
Clave=Centro.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N
EspacioPrevio=N
Pegado=N

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
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

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

[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Centros Trabajo
Clave=(Carpeta Abrir)
Filtros=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=CentroA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Centro<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Centro.Descripcion
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=CentroTipo
FiltroAplicaEn1=Centro.Tipo
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ALTA
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
ListaAcciones=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)
IconosNombre=CentroA:Centro.Centro

[(Carpeta Abrir).Centro.Descripcion]
Carpeta=(Carpeta Abrir)
Clave=Centro.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=127
1=222

[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S

[Detalle.Centro.TiempoCola]
Carpeta=Detalle
Clave=Centro.TiempoCola
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.Centro.TiempoEspera]
Carpeta=Detalle
Clave=Centro.TiempoEspera
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Movimiento]
Nombre=Movimiento
Boton=76
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+T
NombreDesplegar=&Tiempos Movimiento
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CentroMovimiento
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Centro:Centro.Centro)
Antes=S
AntesExpresiones=Asigna(Info.Centro, Centro:Centro.Centro)<BR>Asigna(Info.Descripcion, Centro:Centro.Descripcion)

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

[Detalle.Centro.Cxp]
Carpeta=Detalle
Clave=Centro.Cxp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Cxp]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Maquila
Clave=Cxp
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Centro
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CondicionVisible=Centro:Centro.Cxp

[Cxp.Centro.Proveedor]
Carpeta=Cxp
Clave=Centro.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.Centro.Impuesto1]
Carpeta=Cxp
Clave=Centro.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Cxp.Centro.Condicion]
Carpeta=Cxp
Clave=Centro.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.Centro.CxpMov]
Carpeta=Cxp
Clave=Centro.CxpMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.Centro.Concepto]
Carpeta=Cxp
Clave=Centro.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.Prov.Nombre]
Carpeta=Cxp
Clave=Prov.Nombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Cxp.Centro.Centro]
Carpeta=Cxp
Clave=Centro.Centro
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Cxp.Centro.Descripcion]
Carpeta=Cxp
Clave=Centro.Descripcion
Editar=N
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.CentroTarifa]
Nombre=CentroTarifa
Boton=61
Menu=&Edición
NombreDesplegar=Tari&fas Maquila
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=CentroTarifa
Visible=S
ConCondicion=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+F
ActivoCondicion=Centro:Centro.Cxp
EjecucionCondicion=ConDatos(Centro:Centro.Centro)
AntesExpresiones=Asigna(Info.Centro, Centro:Centro.Centro)<BR>Asigna(Info.Descripcion, Centro:Centro.Descripcion)<BR>Asigna(Info.Articulo, Nulo)

[Detalle.Centro.ContUso]
Carpeta=Detalle
Clave=Centro.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CentroCostos.Descripcion]
Carpeta=Detalle
Clave=CentroCostos.Descripcion
Editar=S
ValidaNombre=N
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=Omision
Omision=Cxp
Cxp=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Movimiento
Movimiento=CentroTarifa
CentroTarifa=CentroInfo
CentroInfo=Plan
Plan=Grafica
Grafica=Capacidad
Capacidad=EstacionT
EstacionT=Calendario
Calendario=Navegador
Navegador=Cerrar
Cerrar=CentroTipo
CentroTipo=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=Centro.Centro
Centro.Centro=Centro.Estatus
Centro.Estatus=Centro.Descripcion
Centro.Descripcion=Centro.Tipo
Centro.Tipo=Centro.Almacen
Centro.Almacen=Centro.ContUso
Centro.ContUso=CentroCostos.Descripcion
CentroCostos.Descripcion=Centro.TiempoCola
Centro.TiempoCola=Centro.TiempoEspera
Centro.TiempoEspera=Centro.CostoManoObra
Centro.CostoManoObra=Centro.CostoIndirectos
Centro.CostoIndirectos=Centro.CostoMoneda
Centro.CostoMoneda=Centro.Cxp
Centro.Cxp=(Fin)

[Omision.ListaEnCaptura]
(Inicio)=Centro.Centro
Centro.Centro=Centro.Descripcion
Centro.Descripcion=Centro.DiasSemana
Centro.DiasSemana=Centro.TurnosDiarios
Centro.TurnosDiarios=Centro.HorasTurno
Centro.HorasTurno=Centro.Eficiencia
Centro.Eficiencia=Centro.Utilizacion
Centro.Utilizacion=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=Actualizar
Actualizar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)

[(Carpeta Abrir).ListaOrden]
(Inicio)=Centro.Orden<TAB>(Acendente)
Centro.Orden<TAB>(Acendente)=Centro.Centro<TAB>(Acendente)
Centro.Centro<TAB>(Acendente)=(Fin)

[Cxp.ListaEnCaptura]
(Inicio)=Centro.Centro
Centro.Centro=Centro.Descripcion
Centro.Descripcion=Centro.Proveedor
Centro.Proveedor=Prov.Nombre
Prov.Nombre=Centro.CxpMov
Centro.CxpMov=Centro.Concepto
Centro.Concepto=Centro.Impuesto1
Centro.Impuesto1=Centro.Condicion
Centro.Condicion=(Fin)
