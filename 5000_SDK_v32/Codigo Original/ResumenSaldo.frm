[Forma]
Clave=ResumenSaldo
Nombre=Resumen de Saldos
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=160
PosicionInicialArriba=211
PosicionInicialAltura=345
PosicionInicialAncho=703
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
Comentarios=<T>Ultimo Recálculo: <T>+FechaEnTexto(SQL(<T>SELECT UltimoResumenSaldo FROM Version<T>), <T>d/mmm/aaaa h:nn am/pm<T>)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=ResumenSaldo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Módulo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
BusquedaRapidaControles=S
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
FiltroMonedasCampo=ResumenSaldo.Moneda
FiltroFechasNombre=&Fecha
Filtros=S
FiltroAplicaEn=ResumenSaldo.Empresa
FiltroPredefinido=S
FiltroAutoCampo=ResumenMov.Modulo
FiltroAutoValidar=Modulo.Nombre
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=22
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroGrupo1=ResumenSaldo.Modulo
FiltroValida1=Modulo.Nombre
FiltroGrupo2=ResumenSaldo.Empresa
FiltroValida2=ResumenSaldo.Empresa
ListaEnCaptura=(Lista)
FiltroGrupo3=ResumenSaldo.Sucursal
FiltroValida3=ResumenSaldo.Sucursal
IconosNombre=ResumenSaldo:Modulo.Nombre

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
0=136
1=149

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

[Lista.ResumenSaldo.Saldo]
Carpeta=Lista
Clave=ResumenSaldo.Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ResumenSaldo.SaldoU]
Carpeta=Lista
Clave=ResumenSaldo.SaldoU
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Rama.Descripcion]
Carpeta=Lista
Clave=Rama.Descripcion
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

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Rama.Descripcion
Rama.Descripcion=ResumenSaldo.Saldo
ResumenSaldo.Saldo=ResumenSaldo.SaldoU
ResumenSaldo.SaldoU=(Fin)
