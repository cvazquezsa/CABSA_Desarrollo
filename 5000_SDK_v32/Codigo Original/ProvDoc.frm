[Forma]
Clave=ProvDoc
Nombre=e(<T>Proveedores<T>+Si(Info.DocOk, <T> con <T>, <T> sin <T>))+Info.Doc
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=881
PosicionInicialArriba=212
PosicionInicialAltura=425
PosicionInicialAncho=666
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=398

[Lista]
Estilo=Iconos
Clave=Lista
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Prov
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Prov.Nombre
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=25
BusquedaEnLinea=S
CarpetaVisible=S
Filtros=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ProvCat
FiltroPredefinido=S
FiltroAplicaEn=Prov.Categoria
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin categoría)
FiltroRespetar=S
FiltroAncho=20
FiltroClase=S
FiltroClaseTodo=S
FiltroFechasNormal=S
FiltroListas=S
FiltroListasRama=CXP
FiltroListasAplicaEn=Prov.Proveedor
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=ProvFam
FiltroAplicaEn1=Prov.Categoria
FiltroAplicaEn2=Prov.Familia
MenuLocal=S
ListaAcciones=Actualizar
PermiteLocalizar=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=BAJA
FiltroArbol=Proveedores
FiltroArbolAplica=Prov.Rama
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Proveedor<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Proveedores

FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ProvTipo
FiltroAplicaEn3=Prov.Tipo
BusquedaRespetarControles=S
IconosNombre=Prov:Prov.Proveedor
FiltroGeneral=Prov.Tipo NOT IN (<T>Responsable<T>, <T>Estructura<T>)  AND Prov.Proveedor {Si(no Info.DocOk, <T>NOT<T>,<T><T>)} IN (SELECT Cuenta FROM DocCta WHERE Rama = <T>{Info.Rama}<T> AND Documento = <T>{Info.Doc}<T>)
[Lista.Prov.Nombre]
Carpeta=Lista
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[Lista.Columnas]
Proveedor=118
Nombre=299
0=131
1=310

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProvInfo
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
ConCondicion=S
EjecucionCondicion=(Prov:Prov.Tipo<><T>Acreedor<T>) o Usuario.VerInfoAcreedores
AntesExpresiones=Asigna(Info.Proveedor, Prov:Prov.Proveedor)

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

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnBarraAcciones=S
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






[Lista.FiltroListaEstatus]
(Inicio)=(Todos menos uno)
(Todos menos uno)=NORMAL
NORMAL=BAJA
BAJA=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Informacion
Informacion=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)
