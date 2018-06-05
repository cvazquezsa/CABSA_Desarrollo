[Forma]
Clave=ResumenMovProyecto
Nombre=Resumen de Movimientos - Nivel Proyecto
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=41
PosicionInicialArriba=137
PosicionInicialAltura=494
PosicionInicialAncho=927
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
Comentarios=<T>Ultimo Recálculo: <T>+FechaEnTexto(SQL(<T>SELECT UltimoResumenMovProyecto FROM Version<T>), <T>d/mmm/aaaa h:nn am/pm<T>)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=ResumenMovProyecto
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
FiltroMonedasCampo=ResumenMovProyecto.Moneda
FiltroFechasNombre=&Fecha
Filtros=S
FiltroAplicaEn=ResumenMovProyecto.Proyecto
FiltroPredefinido=S
FiltroAutoCampo=ResumenMovProyecto.Modulo
FiltroAutoValidar=Modulo.Nombre
FiltroNullNombre=(sin proyecto)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=25
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroGrupo1=ResumenMovProyecto.Proyecto
FiltroValida1=ResumenMovProyecto.Proyecto
FiltroGrupo2=ResumenMovProyecto.Modulo
FiltroValida2=Modulo.Nombre
FiltroGrupo3=ResumenMovProyecto.Empresa
FiltroValida3=ResumenMovProyecto.Empresa
FiltroGrupo4=ResumenMovProyecto.Sucursal
FiltroValida4=ResumenMovProyecto.Sucursal
FiltroNull=S
IconosNombre=ResumenMovProyecto:ResumenMovProyecto.Mov
FiltroTodoFinal=S
FiltroIgnorarEmpresas=S

[Lista.ResumenMovProyecto.Importe]
Carpeta=Lista
Clave=ResumenMovProyecto.Importe
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ResumenMovProyecto.Impuestos]
Carpeta=Lista
Clave=ResumenMovProyecto.Impuestos
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ResumenMovProyecto.Saldo]
Carpeta=Lista
Clave=ResumenMovProyecto.Saldo
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
0=123
1=120

[Lista.ResumenMovProyecto.Periodo]
Carpeta=Lista
Clave=ResumenMovProyecto.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ResumenMovProyecto.Ejercicio]
Carpeta=Lista
Clave=ResumenMovProyecto.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ResumenMovProyecto.Conteo]
Carpeta=Lista
Clave=ResumenMovProyecto.Conteo
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
AntesExpresiones=EjecutarSQL(<T>spCalcResumen :tMoneda, 1<T>, Config.ContMoneda)

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

[Lista.ResumenMovProyecto.Proyecto]
Carpeta=Lista
Clave=ResumenMovProyecto.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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
Modulo.Nombre=ResumenMovProyecto.Proyecto
ResumenMovProyecto.Proyecto=ResumenMovProyecto.Periodo
ResumenMovProyecto.Periodo=ResumenMovProyecto.Ejercicio
ResumenMovProyecto.Ejercicio=ResumenMovProyecto.Conteo
ResumenMovProyecto.Conteo=ResumenMovProyecto.Importe
ResumenMovProyecto.Importe=ResumenMovProyecto.Impuestos
ResumenMovProyecto.Impuestos=ResumenMovProyecto.Saldo
ResumenMovProyecto.Saldo=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)
