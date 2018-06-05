[Forma]
Clave=OportunidadPlantilla
Nombre=Plantilla de Oportunidades
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
CarpetaPrincipal=DatosGenerales
PosicionInicialIzquierda=240
PosicionInicialArriba=61
PosicionInicialAltura=396
PosicionInicialAncho=800
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaBloquearAjuste=N
Menus=S
BarraAyuda=S
DialogoAbrir=S
PosicionInicialAlturaCliente=568


PosicionSec1=140
Totalizadores=S
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

ActivoCondicion=no OportunidadPlantilla:OportunidadPlantilla.TieneMovimientos
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



[Notas.OportunidadPlantilla.Notas]
Carpeta=Notas
Clave=OportunidadPlantilla.Notas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57x13

[Notas.OportunidadPlantilla.Mensaje]
Carpeta=Notas
Clave=OportunidadPlantilla.Mensaje
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


EjecucionCondicion=ConDatos(OportunidadPlantilla:OportunidadPlantilla.Plantilla)
AntesExpresiones=Asigna(Info.Rama, <T>Oportunidad<T>)<BR>Asigna(Info.Cuenta, OportunidadPlantilla:OportunidadPlantilla.Plantilla)<BR>Asigna(Info.Descripcion, Info.Cuenta)
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

ConCondicion=S
EjecucionCondicion=Si<BR>  Suma(OportunidadPlantillaD:OportunidadPlantillaD.PorcentajePonderado)>100<BR>Entonces<BR>      Precaucion( <T>El Porcentaje Ponderado Total es Mayor al 100%<T>,  BotonCancelar)<BR>Fin
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

[Lista.OportunidadPlantilla.Plantilla]
Carpeta=Lista
Clave=OportunidadPlantilla.Plantilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
OportunidadPlantilla=123
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

[Beneficiario.OportunidadPlantilla.Beneficiario]
Carpeta=Beneficiario
Clave=OportunidadPlantilla.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OportunidadPlantilla.Descripcion]
Carpeta=Lista
Clave=OportunidadPlantilla.Descripcion
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


EjecucionCondicion=ConDatos(OportunidadPlantilla:OportunidadPlantilla.Plantilla)
AntesExpresiones=Asigna(Info.Rama, <T>OPORT<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)      <BR>Asigna(Info.Cuenta, OportunidadPlantilla:OportunidadPlantilla.Plantilla)<BR>Asigna(Info.Descripcion, Info.Cuenta)
RefrescarDespues=S
[Banco.OportunidadPlantilla.CuentaHabiente]
Carpeta=Banco
Clave=OportunidadPlantilla.CuentaHabiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Banco.OportunidadPlantilla.NumeroCta]
Carpeta=Banco
Clave=OportunidadPlantilla.NumeroCta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Banco.OportunidadPlantilla.BancoSucursal]
Carpeta=Banco
Clave=OportunidadPlantilla.BancoSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Banco.OportunidadPlantilla.Moneda]
Carpeta=Banco
Clave=OportunidadPlantilla.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Banco.OportunidadPlantilla.Plantilla]
Carpeta=Banco
Clave=OportunidadPlantilla.Plantilla
Editar=N
LineaNueva=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Banco.OportunidadPlantilla.Descripcion]
Carpeta=Banco
Clave=OportunidadPlantilla.Descripcion
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


Expresion=EditarDocumentacion(<T>OPORT<T>, OportunidadPlantilla:OportunidadPlantilla.Plantilla, <T>Documentación - <T>+OportunidadPlantilla:OportunidadPlantilla.Plantilla)
EjecucionCondicion=ConDatos(OportunidadPlantilla:OportunidadPlantilla.Plantilla)
[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=OportunidadPlantillaA
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
PestanaNombre=Oportunidad Plantillas
Filtros=S
OtroOrden=S
BusquedaRapidaControles=S
MenuLocal=S
PermiteLocalizar=S
IconosSubTitulo=<T>Plantilla<T>
ListaOrden=OportunidadPlantilla.Plantilla<TAB>(Acendente)
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
FiltroGrupo1=OportunidadPlantilla.Categoria
FiltroValida1=OportunidadPlantilla.Categoria
FiltroGrupo2=OportunidadPlantilla.Grupo
FiltroValida2=OportunidadPlantilla.Grupo
FiltroTodo=S
FiltroTodoFinal=S
FiltroListas=S
FiltroListasRama=(Todos)
FiltroListasAplicaEn=OportunidadPlantilla.Plantilla
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ACTIVA
BusquedaRapida=S
BusquedaEnLinea=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
ListaAcciones=(Lista)
FiltroGrupo3=OportunidadPlantilla.Familia
FiltroValida3=OportunidadPlantilla.Familia


IconosNombre=OportunidadPlantillaA:OportunidadPlantilla.Plantilla
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
0=195
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

[Banco.OportunidadPlantilla.Institucion]
Carpeta=Banco
Clave=OportunidadPlantilla.Institucion
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



[Alertas.OportunidadPlantilla.AlertaLimiteInferior]
Carpeta=Alertas
Clave=OportunidadPlantilla.AlertaLimiteInferior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Alertas.OportunidadPlantilla.AlertaLimiteSuperior]
Carpeta=Alertas
Clave=OportunidadPlantilla.AlertaLimiteSuperior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro


[Caja.OportunidadPlantilla.Alerta]
Carpeta=Caja
Clave=OportunidadPlantilla.Alerta
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=8
EspacioPrevio=S

[Caja.OportunidadPlantilla.AlertaLimiteInferior]
Carpeta=Caja
Clave=OportunidadPlantilla.AlertaLimiteInferior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[Caja.OportunidadPlantilla.AlertaLimiteSuperior]
Carpeta=Caja
Clave=OportunidadPlantilla.AlertaLimiteSuperior
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[Caja.OportunidadPlantilla.Plantilla]
Carpeta=Caja
Clave=OportunidadPlantilla.Plantilla
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]

[Caja.OportunidadPlantilla.Descripcion]
Carpeta=Caja
Clave=OportunidadPlantilla.Descripcion
3D=S
Tamano=45
ColorFondo=Plata
ValidaNombre=N

[Caja.OportunidadPlantilla.FondoFijo]
Carpeta=Caja
Clave=OportunidadPlantilla.FondoFijo
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ValidaNombre=S

[Caja.OportunidadPlantilla.FondoFijoFormaPago]
Carpeta=Caja
Clave=OportunidadPlantilla.FondoFijoFormaPago
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

EjecucionCondicion=ConDatos(OportunidadPlantilla:OportunidadPlantilla.Plantilla)
AntesExpresiones=Asigna(Info.OportunidadPlantilla, OportunidadPlantilla:OportunidadPlantilla.Plantilla)<BR>Asigna(Info.Nombre, OportunidadPlantilla:OportunidadPlantilla.Descripcion)
VisibleCondicion=General.NivelAccesoEsp y (OportunidadPlantilla:OportunidadPlantilla.NivelAcceso=<T>(Especifico)<T>)
[Caja.OportunidadPlantilla.CorteAutoCerrarDia]
Carpeta=Caja
Clave=OportunidadPlantilla.CorteAutoCerrarDia
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


[Banco.OportunidadPlantilla.CLABE]
Carpeta=Banco
Clave=OportunidadPlantilla.CLABE
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

EjecucionCondicion=ConDatos(OportunidadPlantilla:OportunidadPlantilla.Plantilla)
AntesExpresiones=Asigna(Info.Rama, <T>OPORT<T>)<BR>Asigna(Info.Cuenta, OportunidadPlantilla:OportunidadPlantilla.Plantilla)<BR>Asigna(Info.Nombre, OportunidadPlantilla:OportunidadPlantilla.Plantilla)
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




Expresion=Asigna(Info.Forma, <T>OportunidadPlantilla<T>)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Nombre, <T>Oportunidad Plantillas<T>)<BR>Si<BR>  Forma(<T>PlantillasOffice<T>)<BR>Entonces<BR>   PlantillaOffice( Info.PlantillaID ) <BR>Fin
[Banco.ListaEnCaptura]
(Inicio)=OportunidadPlantilla.Plantilla
OportunidadPlantilla.Plantilla=OportunidadPlantilla.Descripcion
OportunidadPlantilla.Descripcion=OportunidadPlantilla.CuentaHabiente
OportunidadPlantilla.CuentaHabiente=OportunidadPlantilla.Institucion
OportunidadPlantilla.Institucion=InstitucionFin.Nombre
InstitucionFin.Nombre=OportunidadPlantilla.NumeroCta
OportunidadPlantilla.NumeroCta=OportunidadPlantilla.CLABE
OportunidadPlantilla.CLABE=OportunidadPlantilla.Moneda
OportunidadPlantilla.Moneda=OportunidadPlantilla.BancoSucursal
OportunidadPlantilla.BancoSucursal=(Fin)




[POS.OportunidadPlantilla.EsConcentradora]
Carpeta=POS
Clave=OportunidadPlantilla.EsConcentradora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POS.OportunidadPlantilla.ClaveLDI]
Carpeta=POS
Clave=OportunidadPlantilla.ClaveLDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[POS.OportunidadPlantilla.MovOmision]
Carpeta=POS
Clave=OportunidadPlantilla.MovOmision
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
(Inicio)=OportunidadPlantilla.Plantilla
OportunidadPlantilla.Plantilla=OportunidadPlantilla.Descripcion
OportunidadPlantilla.Descripcion=OportunidadPlantilla.FondoFijo
OportunidadPlantilla.FondoFijo=OportunidadPlantilla.FondoFijoFormaPago
OportunidadPlantilla.FondoFijoFormaPago=OportunidadPlantilla.Alerta
OportunidadPlantilla.Alerta=OportunidadPlantilla.AlertaLimiteInferior
OportunidadPlantilla.AlertaLimiteInferior=OportunidadPlantilla.AlertaLimiteSuperior
OportunidadPlantilla.AlertaLimiteSuperior=OportunidadPlantilla.CorteAutoCerrarDia
OportunidadPlantilla.CorteAutoCerrarDia=(Fin)









[POS.ListaEnCaptura]
(Inicio)=OportunidadPlantilla.MovOmision
OportunidadPlantilla.MovOmision=OportunidadPlantilla.EsConcentradora
OportunidadPlantilla.EsConcentradora=OportunidadPlantilla.ClaveLDI
OportunidadPlantilla.ClaveLDI=(Fin)



















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
Vista=OportunidadPlantilla
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
(Inicio)=OportunidadPlantilla.Descripcion
OportunidadPlantilla.Descripcion=OportunidadPlantilla.NumeroCta
OportunidadPlantilla.NumeroCta=OportunidadPlantilla.Institucion
OportunidadPlantilla.Institucion=OportunidadPlantilla.Moneda
OportunidadPlantilla.Moneda=OportunidadPlantilla.Empresa
OportunidadPlantilla.Empresa=(Fin)











[DatosGenerales.OportunidadPlantilla.Plantilla]
Carpeta=DatosGenerales
Clave=OportunidadPlantilla.Plantilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[DatosGenerales.OportunidadPlantilla.FechaEmision]
Carpeta=DatosGenerales
Clave=OportunidadPlantilla.FechaEmision
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco




[DatosGenerales.OportunidadPlantilla.GenerarMov]
Carpeta=DatosGenerales
Clave=OportunidadPlantilla.GenerarMov
Editar=S
LineaNueva=S
3D=S
Tamano=34
ColorFondo=Blanco

EspacioPrevio=S
[DatosGenerales.OportunidadPlantilla.Mov]
Carpeta=DatosGenerales
Clave=OportunidadPlantilla.Mov
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
Vista=OportunidadPlantilla
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
ListaEnCaptura=OportunidadPlantilla.Comentarios
CarpetaVisible=S
AlinearTodaCarpeta=S

PermiteEditar=S
[Comentarios.OportunidadPlantilla.Comentarios]
Carpeta=Comentarios
Clave=OportunidadPlantilla.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco











[DatosGenerales.OportunidadPlantilla.Estatus]
Carpeta=DatosGenerales
Clave=OportunidadPlantilla.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=19
ColorFondo=Blanco









[Detalle]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Detalle
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=OportunidadPlantillaD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=OportunidadPlantilla
LlaveLocal=OportunidadPlantillaD.ID
LlaveMaestra=OportunidadPlantilla.ID
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco

CarpetaVisible=S
OtroOrden=S
ControlRenglonID=S

ListaOrden=OportunidadPlantillaD.Renglon<TAB>(Acendente)
ControlRenglon=S
CampoRenglon=OportunidadPlantillaD.Renglon



ListaEnCaptura=(Lista)
ControlRenglonTipo=S
HojaColoresPorTipo=S
CampoDespliegaTipo=OportunidadPlantillaD.Tipo
CampoDespliegaTipoOpcion=OportunidadPlantillaD.Tipo
ValidarCampos=S
ListaCamposAValidar=Recurso.Nombre
CondicionEdicion=OportunidadPlantilla:OportunidadPlantilla.TieneMovimientos = Falso
[Detalle.Columnas]
Etapa=87
Asunto=410
PorcentajePonderado=119











Tipo=89
Clave=119
Descripcion=301
RecursoOmision=108
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
























































[DatosGenerales.OportunidadPlantilla.MovOportunidad]
Carpeta=DatosGenerales
Clave=OportunidadPlantilla.MovOportunidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













LineaNueva=S
[Detalle.OportunidadPlantillaD.Tipo]
Carpeta=Detalle
Clave=OportunidadPlantillaD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Detalle.OportunidadPlantillaD.Clave]
Carpeta=Detalle
Clave=OportunidadPlantillaD.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.OportunidadPlantillaD.Descripcion]
Carpeta=Detalle
Clave=OportunidadPlantillaD.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle.OportunidadPlantillaD.PorcentajePonderado]
Carpeta=Detalle
Clave=OportunidadPlantillaD.PorcentajePonderado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










































[Detalle.ListaCamposAValidar]
(Inicio)=OportunidadPlantillaD.RecursoOmision
OportunidadPlantillaD.RecursoOmision=Recurso.Nombre
Recurso.Nombre=(Fin)


[Detalle.OportunidadPlantillaD.RecursoOmision]
Carpeta=Detalle
Clave=OportunidadPlantillaD.RecursoOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

EditarConBloqueo=S




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
Totalizadores2=Suma(OportunidadPlantillaD:OportunidadPlantillaD.PorcentajePonderado)
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
























































[DatosGenerales.OportunidadPlantilla.PlantillaeMail]
Carpeta=DatosGenerales
Clave=OportunidadPlantilla.PlantillaeMail
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco




































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
Vista=OportunidadPlantilla
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
(Inicio)=OportunidadPlantilla.Categoria
OportunidadPlantilla.Categoria=OportunidadPlantilla.Grupo
OportunidadPlantilla.Grupo=OportunidadPlantilla.Familia
OportunidadPlantilla.Familia=(Fin)

[Agrupadores.OportunidadPlantilla.Categoria]
Carpeta=Agrupadores
Clave=OportunidadPlantilla.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Agrupadores.OportunidadPlantilla.Grupo]
Carpeta=Agrupadores
Clave=OportunidadPlantilla.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Agrupadores.OportunidadPlantilla.Familia]
Carpeta=Agrupadores
Clave=OportunidadPlantilla.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[DatosGenerales.ListaEnCaptura]
(Inicio)=OportunidadPlantilla.Plantilla
OportunidadPlantilla.Plantilla=OportunidadPlantilla.FechaEmision
OportunidadPlantilla.FechaEmision=OportunidadPlantilla.Estatus
OportunidadPlantilla.Estatus=OportunidadPlantilla.MovOportunidad
OportunidadPlantilla.MovOportunidad=OportunidadPlantilla.PlantillaeMail
OportunidadPlantilla.PlantillaeMail=OportunidadPlantilla.GenerarMov
OportunidadPlantilla.GenerarMov=OportunidadPlantilla.Mov
OportunidadPlantilla.Mov=(Fin)













































































































































































































[Detalle.ListaEnCaptura]
(Inicio)=OportunidadPlantillaD.Tipo
OportunidadPlantillaD.Tipo=OportunidadPlantillaD.Clave
OportunidadPlantillaD.Clave=OportunidadPlantillaD.Descripcion
OportunidadPlantillaD.Descripcion=OportunidadPlantillaD.RecursoOmision
OportunidadPlantillaD.RecursoOmision=OportunidadPlantillaD.PorcentajePonderado
OportunidadPlantillaD.PorcentajePonderado=(Fin)






















































































































































































































































































































































































































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
OportunidadPlantillaFam=Navegador
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
