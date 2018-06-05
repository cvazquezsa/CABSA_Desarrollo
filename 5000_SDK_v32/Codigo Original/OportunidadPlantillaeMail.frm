[Forma]
Clave=OportunidadPlantillaeMail
Nombre=Oportunidad - Plantillas de Correo Electrónico
Icono=240
Modulos=(Todos)
ListaCarpetas=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
CarpetaPrincipal=DatosGenerales
PosicionInicialIzquierda=279
PosicionInicialArriba=61
PosicionInicialAltura=396
PosicionInicialAncho=721
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaBloquearAjuste=N
Menus=S
BarraAyuda=S
DialogoAbrir=S
PosicionInicialAlturaCliente=568


PosicionSec1=130
PosicionSec2=466
MovModulo=OPORT
MenuPrincipal=(Lista)
[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Visible=S
Activo=S
Menu=&Archivo
EnMenu=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+N

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
Menu=&Archivo
EnMenu=S
EspacioPrevio=S
Activo=S
[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Visible=S
Activo=S



[Notas.OportunidadPlantillaeMail.Notas]
Carpeta=Notas
Clave=OportunidadPlantillaeMail.Notas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57x13

[Notas.OportunidadPlantillaeMail.Mensaje]
Carpeta=Notas
Clave=OportunidadPlantillaeMail.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=Prop
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F11
EnMenu=S
ConCondicion=S
DespuesGuardar=S


EjecucionCondicion=ConDatos(OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla)
AntesExpresiones=Asigna(Info.Rama, <T>Oportunidad<T>)<BR>Asigna(Info.Cuenta, OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla)<BR>Asigna(Info.Descripcion, Info.Cuenta)
[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
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
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
EspacioPrevio=S

[Lista.OportunidadPlantillaeMail.Plantilla]
Carpeta=Lista
Clave=OportunidadPlantillaeMail.Plantilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
OportunidadPlantillaeMail=123
Tipo=92
Descripcion=213
Moneda=64

0=-2
1=232
2=-2
[Detalle.]
Carpeta=Detalle
Editar=S
3D=S
Tamano=20

[Beneficiario.Beneficiario.Nombre]
Carpeta=Beneficiario
Clave=Beneficiario.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Beneficiario.OportunidadPlantillaeMail.Beneficiario]
Carpeta=Beneficiario
Clave=OportunidadPlantillaeMail.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OportunidadPlantillaeMail.Descripcion]
Carpeta=Lista
Clave=OportunidadPlantillaeMail.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro



[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
ConCondicion=S


EjecucionCondicion=ConDatos(OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla)
AntesExpresiones=Asigna(Info.Rama, <T>OMAIL<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla)<BR>Asigna(Info.Descripcion, Info.Cuenta)
RefrescarDespues=S
[Banco.OportunidadPlantillaeMail.CuentaHabiente]
Carpeta=Banco
Clave=OportunidadPlantillaeMail.CuentaHabiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Banco.OportunidadPlantillaeMail.NumeroCta]
Carpeta=Banco
Clave=OportunidadPlantillaeMail.NumeroCta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Banco.OportunidadPlantillaeMail.BancoSucursal]
Carpeta=Banco
Clave=OportunidadPlantillaeMail.BancoSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Banco.OportunidadPlantillaeMail.Moneda]
Carpeta=Banco
Clave=OportunidadPlantillaeMail.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Banco.OportunidadPlantillaeMail.Plantilla]
Carpeta=Banco
Clave=OportunidadPlantillaeMail.Plantilla
Editar=N
LineaNueva=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Banco.OportunidadPlantillaeMail.Descripcion]
Carpeta=Banco
Clave=OportunidadPlantillaeMail.Descripcion
Editar=N
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Doc]
Nombre=Doc
Boton=17
Menu=&Edición
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S


Expresion=EditarDocumentacion(<T>OMAIL<T>, OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla, <T>Documentación - <T>+OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla)
EjecucionCondicion=ConDatos(OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla)
[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=OportunidadPlantillaeMailA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Oportunidad - Plantillas de Correo Electrónico
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
IconosSubTitulo=<T>Plantilla<T>
ListaOrden=OportunidadPlantillaeMail.Plantilla<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroGrupo1=OportunidadPlantillaeMail.Categoria
FiltroValida1=OportunidadPlantillaeMail.Categoria
FiltroGrupo2=OportunidadPlantillaeMail.Grupo
FiltroValida2=OportunidadPlantillaeMail.Grupo
FiltroTodo=S
FiltroTodoFinal=S
FiltroListas=S
FiltroListasRama=(Todos)
FiltroListasAplicaEn=OportunidadPlantillaeMail.Plantilla
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ACTIVA
BusquedaRapida=S
BusquedaEnLinea=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
ListaAcciones=(Lista)
FiltroGrupo3=OportunidadPlantillaeMail.Familia
FiltroValida3=OportunidadPlantillaeMail.Familia


IconosNombre=OportunidadPlantillaeMailA:OportunidadPlantillaeMail.Plantilla
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

[(Carpeta Abrir).Columnas]
0=142
1=159

2=-2
3=-2
4=-2
5=-2

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

[Banco.OportunidadPlantillaeMail.Institucion]
Carpeta=Banco
Clave=OportunidadPlantillaeMail.Institucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Banco.InstitucionFin.Nombre]
Carpeta=Banco
Clave=InstitucionFin.Nombre
Editar=S
3D=S
Tamano=29
ColorFondo=Plata
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



[Alertas.OportunidadPlantillaeMail.AlertaLimiteInferior]
Carpeta=Alertas
Clave=OportunidadPlantillaeMail.AlertaLimiteInferior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Alertas.OportunidadPlantillaeMail.AlertaLimiteSuperior]
Carpeta=Alertas
Clave=OportunidadPlantillaeMail.AlertaLimiteSuperior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro


[Caja.OportunidadPlantillaeMail.Alerta]
Carpeta=Caja
Clave=OportunidadPlantillaeMail.Alerta
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=8
EspacioPrevio=S

[Caja.OportunidadPlantillaeMail.AlertaLimiteInferior]
Carpeta=Caja
Clave=OportunidadPlantillaeMail.AlertaLimiteInferior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[Caja.OportunidadPlantillaeMail.AlertaLimiteSuperior]
Carpeta=Caja
Clave=OportunidadPlantillaeMail.AlertaLimiteSuperior
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[Caja.OportunidadPlantillaeMail.Plantilla]
Carpeta=Caja
Clave=OportunidadPlantillaeMail.Plantilla
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]

[Caja.OportunidadPlantillaeMail.Descripcion]
Carpeta=Caja
Clave=OportunidadPlantillaeMail.Descripcion
3D=S
Tamano=45
ColorFondo=Plata
ValidaNombre=N

[Caja.OportunidadPlantillaeMail.FondoFijo]
Carpeta=Caja
Clave=OportunidadPlantillaeMail.FondoFijo
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ValidaNombre=S

[Caja.OportunidadPlantillaeMail.FondoFijoFormaPago]
Carpeta=Caja
Clave=OportunidadPlantillaeMail.FondoFijoFormaPago
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
ValidaNombre=S



[Acciones.OportunidadPlantillaAcceso]
Nombre=OportunidadPlantillaAcceso
Boton=0
Menu=&Edición
NombreDesplegar=Acceso Especifico...
EnMenu=S
TipoAccion=Formas
ClaveAccion=OportunidadPlantillaAcceso
Activo=S
ConCondicion=S
Antes=S
GuardarAntes=S
DespuesGuardar=S
EspacioPrevio=S

EjecucionCondicion=ConDatos(OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla)
AntesExpresiones=Asigna(Info.OportunidadPlantillaeMail, OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla)<BR>Asigna(Info.Nombre, OportunidadPlantillaeMail:OportunidadPlantillaeMail.Descripcion)
VisibleCondicion=General.NivelAccesoEsp y (OportunidadPlantillaeMail:OportunidadPlantillaeMail.NivelAcceso=<T>(Especifico)<T>)
[Caja.OportunidadPlantillaeMail.CorteAutoCerrarDia]
Carpeta=Caja
Clave=OportunidadPlantillaeMail.CorteAutoCerrarDia
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco




[Acciones.OportunidadPlantillaCat]
Nombre=OportunidadPlantillaCat
Boton=0
Menu=&Maestros
NombreDesplegar=&Categorías
EnMenu=S
TipoAccion=Formas
ClaveAccion=OportunidadPlantillaCat
Activo=S
Visible=S

[Acciones.OportunidadPlantillaGrupo]
Nombre=OportunidadPlantillaGrupo
Boton=0
Menu=&Maestros
NombreDesplegar=&Grupo
EnMenu=S
TipoAccion=Formas
ClaveAccion=OportunidadPlantillaGrupo
Activo=S
Visible=S

[Acciones.OportunidadPlantillaFam]
Nombre=OportunidadPlantillaFam
Boton=0
Menu=&Maestros
NombreDesplegar=&Familias
EnMenu=S
TipoAccion=Formas
ClaveAccion=OportunidadPlantillaFam
Activo=S
Visible=S


[Banco.OportunidadPlantillaeMail.CLABE]
Carpeta=Banco
Clave=OportunidadPlantillaeMail.CLABE
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
LineaNueva=S
Efectos=[Negritas]

[Acciones.RefCta]
Nombre=RefCta
Boton=110
Menu=&Edición
NombreDesplegar=Referencias
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=RefCta
Activo=S
ConCondicion=S
Antes=S
Visible=S

EjecucionCondicion=ConDatos(OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla)
AntesExpresiones=Asigna(Info.Rama, <T>OMAIL<T>)<BR>Asigna(Info.Cuenta, OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla)<BR>Asigna(Info.Nombre, OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla)
[Acciones.PlantillasOffice]
Nombre=PlantillasOffice
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=Plantillas &Office
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S




Expresion=Asigna(Info.Forma, <T>OportunidadPlantillaeMail<T>)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Nombre, <T>Oportunidad Plantillas<T>)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
[Banco.ListaEnCaptura]
(Inicio)=OportunidadPlantillaeMail.Plantilla
OportunidadPlantillaeMail.Plantilla=OportunidadPlantillaeMail.Descripcion
OportunidadPlantillaeMail.Descripcion=OportunidadPlantillaeMail.CuentaHabiente
OportunidadPlantillaeMail.CuentaHabiente=OportunidadPlantillaeMail.Institucion
OportunidadPlantillaeMail.Institucion=InstitucionFin.Nombre
InstitucionFin.Nombre=OportunidadPlantillaeMail.NumeroCta
OportunidadPlantillaeMail.NumeroCta=OportunidadPlantillaeMail.CLABE
OportunidadPlantillaeMail.CLABE=OportunidadPlantillaeMail.Moneda
OportunidadPlantillaeMail.Moneda=OportunidadPlantillaeMail.BancoSucursal
OportunidadPlantillaeMail.BancoSucursal=(Fin)




[POS.OportunidadPlantillaeMail.EsConcentradora]
Carpeta=POS
Clave=OportunidadPlantillaeMail.EsConcentradora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POS.OportunidadPlantillaeMail.ClaveLDI]
Carpeta=POS
Clave=OportunidadPlantillaeMail.ClaveLDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[POS.OportunidadPlantillaeMail.MovOmision]
Carpeta=POS
Clave=OportunidadPlantillaeMail.MovOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
















[POS.Columnas]
EsConcentradora=90
ClaveLDI=64
MovOmision=140





[Caja.ListaEnCaptura]
(Inicio)=OportunidadPlantillaeMail.Plantilla
OportunidadPlantillaeMail.Plantilla=OportunidadPlantillaeMail.Descripcion
OportunidadPlantillaeMail.Descripcion=OportunidadPlantillaeMail.FondoFijo
OportunidadPlantillaeMail.FondoFijo=OportunidadPlantillaeMail.FondoFijoFormaPago
OportunidadPlantillaeMail.FondoFijoFormaPago=OportunidadPlantillaeMail.Alerta
OportunidadPlantillaeMail.Alerta=OportunidadPlantillaeMail.AlertaLimiteInferior
OportunidadPlantillaeMail.AlertaLimiteInferior=OportunidadPlantillaeMail.AlertaLimiteSuperior
OportunidadPlantillaeMail.AlertaLimiteSuperior=OportunidadPlantillaeMail.CorteAutoCerrarDia
OportunidadPlantillaeMail.CorteAutoCerrarDia=(Fin)









[POS.ListaEnCaptura]
(Inicio)=OportunidadPlantillaeMail.MovOmision
OportunidadPlantillaeMail.MovOmision=OportunidadPlantillaeMail.EsConcentradora
OportunidadPlantillaeMail.EsConcentradora=OportunidadPlantillaeMail.ClaveLDI
OportunidadPlantillaeMail.ClaveLDI=(Fin)



















[DatosGenerales]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=DatosGenerales
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadPlantillaeMail
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S





ListaEnCaptura=(Lista)
Pestana=S
[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=OportunidadPlantillaeMail.Descripcion
OportunidadPlantillaeMail.Descripcion=OportunidadPlantillaeMail.NumeroCta
OportunidadPlantillaeMail.NumeroCta=OportunidadPlantillaeMail.Institucion
OportunidadPlantillaeMail.Institucion=OportunidadPlantillaeMail.Moneda
OportunidadPlantillaeMail.Moneda=OportunidadPlantillaeMail.Empresa
OportunidadPlantillaeMail.Empresa=(Fin)











[DatosGenerales.OportunidadPlantillaeMail.Plantilla]
Carpeta=DatosGenerales
Clave=OportunidadPlantillaeMail.Plantilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[DatosGenerales.OportunidadPlantillaeMail.FechaEmision]
Carpeta=DatosGenerales
Clave=OportunidadPlantillaeMail.FechaEmision
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco




[Comentarios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comentarios
Clave=Comentarios
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadPlantillaeMail
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=OportunidadPlantillaeMail.Comentarios
CarpetaVisible=S
AlinearTodaCarpeta=S

[Comentarios.OportunidadPlantillaeMail.Comentarios]
Carpeta=Comentarios
Clave=OportunidadPlantillaeMail.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco











[DatosGenerales.OportunidadPlantillaeMail.Estatus]
Carpeta=DatosGenerales
Clave=OportunidadPlantillaeMail.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=19
ColorFondo=Blanco









[Detalle]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Detalle
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=OportunidadPlantillaeMailMensaje
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=OportunidadPlantillaeMail
LlaveLocal=OportunidadPlantillaeMailMensaje.ID
LlaveMaestra=OportunidadPlantillaeMail.ID
CampoColorLetras=Negro
CampoColorFondo=Blanco

CarpetaVisible=S




FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
ListaEnCaptura=OportunidadPlantillaeMailMensaje.Mensaje
AlinearTodaCarpeta=S
[Detalle.Columnas]
Etapa=87
Asunto=410
PorcentajePonderado=119











Tipo=89
Clave=119
Descripcion=301
RecursoOmision=108


[Detalle.ListaCamposAValidar]
(Inicio)=OportunidadPlantillaeMailMensaje.RecursoOmision
OportunidadPlantillaeMailMensaje.RecursoOmision=Recurso.Nombre
Recurso.Nombre=(Fin)



[Detalle.ListaEnCaptura]
(Inicio)=OportunidadPlantillaeMailMensaje.Tipo
OportunidadPlantillaeMailMensaje.Tipo=OportunidadPlantillaeMailMensaje.Clave
OportunidadPlantillaeMailMensaje.Clave=OportunidadPlantillaeMailMensaje.Descripcion
OportunidadPlantillaeMailMensaje.Descripcion=OportunidadPlantillaeMailMensaje.RecursoOmision
OportunidadPlantillaeMailMensaje.RecursoOmision=OportunidadPlantillaeMailMensaje.PorcentajePonderado
OportunidadPlantillaeMailMensaje.PorcentajePonderado=(Fin)





































[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total
Totalizadores2=Suma(OportunidadPlantillaeMailMensaje:OportunidadPlantillaeMailMensaje.PorcentajePonderado)
Totalizadores=S
TotCarpetaRenglones=Detalle
TotAlCambiar=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CarpetaVisible=S

Totalizadores3=#.##%
[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata






































[Detalle.OportunidadPlantillaeMailMensaje.Mensaje]
Carpeta=Detalle
Clave=OportunidadPlantillaeMailMensaje.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





























































[Acciones.AyudaEtiquetas]
Nombre=AyudaEtiquetas
Boton=101
NombreEnBoton=S
NombreDesplegar=Ayuda Etiquetas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=OportunidadTagAyuda
Activo=S
Visible=S







GuardarAntes=S
Antes=S
AntesExpresiones=Asigna(Info.Anuncio, OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla)
DespuesGuardar=S
[Acciones.OportunidadAnexo]
Nombre=OportunidadAnexo
Boton=77
NombreEnBoton=S
NombreDesplegar=Anexos eMail
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=OportunidadAnexo
Activo=S
Visible=S

EspacioPrevio=S












GuardarAntes=S
Antes=S
DespuesGuardar=S

















































AntesExpresiones=Asigna(Info.Anuncio, OportunidadPlantillaeMail:OportunidadPlantillaeMail.Plantilla)
[DatosGenerales.OportunidadPlantillaeMail.Asunto]
Carpeta=DatosGenerales
Clave=OportunidadPlantillaeMail.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=80x1












EspacioPrevio=S































[Agrupadores]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Agrupadores
Clave=Agrupadores
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadPlantillaeMail
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
[Agrupadores.ListaEnCaptura]
(Inicio)=OportunidadPlantillaeMail.Categoria
OportunidadPlantillaeMail.Categoria=OportunidadPlantillaeMail.Grupo
OportunidadPlantillaeMail.Grupo=OportunidadPlantillaeMail.Familia
OportunidadPlantillaeMail.Familia=(Fin)

[Agrupadores.OportunidadPlantillaeMail.Categoria]
Carpeta=Agrupadores
Clave=OportunidadPlantillaeMail.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Agrupadores.OportunidadPlantillaeMail.Grupo]
Carpeta=Agrupadores
Clave=OportunidadPlantillaeMail.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Agrupadores.OportunidadPlantillaeMail.Familia]
Carpeta=Agrupadores
Clave=OportunidadPlantillaeMail.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco







[DatosGenerales.ListaEnCaptura]
(Inicio)=OportunidadPlantillaeMail.Plantilla
OportunidadPlantillaeMail.Plantilla=OportunidadPlantillaeMail.FechaEmision
OportunidadPlantillaeMail.FechaEmision=OportunidadPlantillaeMail.Estatus
OportunidadPlantillaeMail.Estatus=OportunidadPlantillaeMail.Asunto
OportunidadPlantillaeMail.Asunto=(Fin)












































































































































































































[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ACTIVA
ACTIVA=INACTIVA
INACTIVA=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=Actualizar
Actualizar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Campos
Campos=(Fin)







[Forma.ListaCarpetas]
(Inicio)=DatosGenerales
DatosGenerales=Comentarios
Comentarios=Detalle
Detalle=Agrupadores
Agrupadores=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=PlantillasOffice
PlantillasOffice=Propiedades
Propiedades=Anexos
Anexos=Doc
Doc=RefCta
RefCta=OportunidadPlantillaAcceso
OportunidadPlantillaAcceso=OportunidadPlantillaCat
OportunidadPlantillaCat=OportunidadPlantillaGrupo
OportunidadPlantillaGrupo=OportunidadPlantillaFam
OportunidadPlantillaFam=OportunidadAnexo
OportunidadAnexo=AyudaEtiquetas
AyudaEtiquetas=Navegador
Navegador=Cerrar
Cerrar=Otros1
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
