[Forma]
Clave=ResumenMov
Nombre=Resumen de Movimientos
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=86
PosicionInicialArriba=137
PosicionInicialAltura=494
PosicionInicialAncho=852
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
Comentarios=<T>Ultimo Recálculo: <T>+FechaEnTexto(SQL(<T>SELECT UltimoResumenMov FROM Version<T>), <T>d/mmm/aaaa h:nn am/pm<T>)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=ResumenMov
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
CarpetaVisible=S
PestanaOtroNombre=S
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroPeriodos=S
FiltroEjercicios=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroEditarFueraPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroEmpresas=S
FiltroSucursales=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
FiltroFechasNormal=S
FiltroMonedasCampo=ResumenMov.Moneda
FiltroFechasNombre=&Fecha
Filtros=S
FiltroAplicaEn=ResumenMov.Modulo
FiltroPredefinido=S
FiltroAutoCampo=ResumenMov.Modulo
FiltroAutoValidar=Modulo.Nombre
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=22
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=ResumenMov.Modulo
FiltroValida1=Modulo.Nombre
FiltroGrupo2=ResumenMov.Empresa
FiltroValida2=ResumenMov.Empresa
FiltroGrupo3=ResumenMov.Sucursal
FiltroValida3=ResumenMov.Sucursal
FiltroTodo=S
IconosNombre=ResumenMov:ResumenMov.Mov

[Lista.ResumenMov.Importe]
Carpeta=Lista
Clave=ResumenMov.Importe
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ResumenMov.Impuestos]
Carpeta=Lista
Clave=ResumenMov.Impuestos
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ResumenMov.Saldo]
Carpeta=Lista
Clave=ResumenMov.Saldo
Editar=S
Totalizador=0
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

[Lista.Columnas]
0=132
1=121

[Lista.ResumenMov.Periodo]
Carpeta=Lista
Clave=ResumenMov.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ResumenMov.Ejercicio]
Carpeta=Lista
Clave=ResumenMov.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ResumenMov.Conteo]
Carpeta=Lista
Clave=ResumenMov.Conteo
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Modulo.Nombre]
Carpeta=Lista
Clave=Modulo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentacion preliminar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
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
NombreDesplegar=Personalizar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Recalcular]
Nombre=Recalcular
Boton=92
NombreDesplegar=&Recalcular
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
Multiple=S
ListaAccionesMultiples=Actualizar Arbol<BR>Actualizar Forma
AntesExpresiones=EjecutarSQL(<T>spCalcResumen :tMoneda, 0<T>, Config.ContMoneda)

[Acciones.Recalcular.Actualizar Arbol]
Nombre=Actualizar Arbol
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S

[Acciones.Recalcular.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Preliminar
Preliminar=Imprimir
Imprimir=Excel
Excel=Recalcular
Recalcular=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Modulo.Nombre
Modulo.Nombre=ResumenMov.Periodo
ResumenMov.Periodo=ResumenMov.Ejercicio
ResumenMov.Ejercicio=ResumenMov.Conteo
ResumenMov.Conteo=ResumenMov.Importe
ResumenMov.Importe=ResumenMov.Impuestos
ResumenMov.Impuestos=ResumenMov.Saldo
ResumenMov.Saldo=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)
