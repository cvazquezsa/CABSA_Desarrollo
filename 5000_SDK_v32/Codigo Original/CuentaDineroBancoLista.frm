[Forma]
Clave=CuentaDineroBancoLista
Nombre=Cuentas de Dinero
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialIzquierda=259
PosicionInicialArriba=101
PosicionInicialAltura=311
PosicionInicialAncho=783
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=485

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Cuentas
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaDinero
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroAncho=20
FiltroAutoCampo=CtaDinero.Tipo
FiltroAutoValidar=CtaDinero.Tipo
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
MenuLocal=S
ListaAcciones=Actualizar
PermiteLocalizar=S
FiltroGrupo1=(Validaciones Memoria)
FiltroGrupo2=(Validaciones Memoria)
FiltroValida1=CtaDineroCat
FiltroValida2=CtaDineroGrupo
FiltroTodo=S
FiltroTodoFinal=S
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=(Lista)
FiltroListas=S
FiltroListasRama=DIN
FiltroListasAplicaEn=CtaDinero.CtaDinero
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Cuenta<T>
ElementosPorPagina=200
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=CtaDineroFam
FiltroAplicaEn1=CtaDinero.Categoria
FiltroAplicaEn2=CtaDinero.Grupo
FiltroAplicaEn3=CtaDinero.Familia
BusquedaRapidaControles=S
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
FiltroArbol=Cuentas Dinero
FiltroArbolAplica=CtaDinero.Rama

IconosNombre=CtaDinero:CtaDinero.CtaDinero
FiltroGeneral=CtaDinero.Tipo = <T>Banco<T>
[Lista.Columnas]
0=84
CtaDinero=118
Tipo=58
Moneda=65
Descripcion=177
Empresa=50
1=178

2=-2
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreEnBoton=S
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Antes=S

Expresion=Forma(<T>CtaDineroInfo<T>)
ActivoCondicion=Usuario.CtaDineroInfo
AntesExpresiones=Asigna( Info.CtaDinero, CtaDinero:CtaDinero.CtaDinero )
[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.CtaDinero.Moneda]
Carpeta=Lista
Clave=CtaDinero.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CtaDinero.Descripcion]
Carpeta=Lista
Clave=CtaDinero.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

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
(Inicio)=CtaDinero.Descripcion
CtaDinero.Descripcion=CtaDinero.Moneda
CtaDinero.Moneda=(Fin)

[Lista.ListaOrden]
(Inicio)=CtaDinero.Tipo	(Acendente)
CtaDinero.Tipo	(Acendente)=CtaDinero.CtaDinero	(Acendente)
CtaDinero.CtaDinero	(Acendente)=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)



[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Informacion
Informacion=Personalizar
Personalizar=(Fin)
