[Forma]
Clave=CtaDineroDoc
Nombre=<T>Cuentas de Dinero<T>+Si(Info.DocOk, <T> con <T>, <T> sin <T>)+Info.Doc
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialIzquierda=837
PosicionInicialArriba=215
PosicionInicialAltura=419
PosicionInicialAncho=719
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=392

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
FiltroAncho=17
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
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=CtaDineroTipo
FiltroAplicaEn1=CtaDinero.Categoria
FiltroAplicaEn2=CtaDinero.Grupo
FiltroAplicaEn3=CtaDinero.Familia
FiltroAplicaEn4=CtaDinero.Tipo
FiltroTodoFinal=S
BusquedaRapidaControles=S
IconosNombre=CtaDinero:CtaDinero.CtaDinero
FiltroGeneral=CtaDinero.CtaDinero {Si(no Info.DocOk, <T>NOT<T>,<T><T>)} IN (SELECT Cuenta FROM DocCta WHERE Rama = <T>{Info.Rama}<T> AND Documento = <T>{Info.Doc}<T>)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
[Lista.Columnas]
0=131
CtaDinero=118
Tipo=58
Moneda=65
Descripcion=177
1=260

2=162
[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Antes=S
Expresion=Forma(<T>CtaDineroInfo<T>)
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
NombreDesplegar=Presentacion preliminar
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

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
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























[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Informacion
Informacion=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)
