[Forma]
Clave=ContX
Nombre=Generador de Pólizas
Icono=34
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAltura=551
PosicionInicialAncho=803
DialogoAbrir=S
PosicionInicialIzquierda=340
PosicionInicialArriba=77
PosicionSeccion1=51
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Menus=S
BarraAyuda=S
BarraAyudaBold=S
VentanaBloquearAjuste=
VentanaAjustarZonas=S
PosicionColumna1=44
Plantillas=S
PermiteCopiarDoc=S
PosicionSeccion2=91
PosicionInicialAlturaCliente=554
PosicionSec1=249
PosicionCol1=333

MenuPrincipal=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContX
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=105
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaNombre=Datos Generales

[Ficha.ContX.Modulo]
Carpeta=Ficha
Clave=ContX.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ContX.Mov]
Carpeta=Ficha
Clave=ContX.Mov
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Columnas]
Cuenta=100
SubCuenta=100
Concepto=100
Debe=100
Haber=100
Condicion=100

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
Vista=ContXA
Fuente={MS Sans Serif, 8, Negro, []}
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
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControlesNum=S
BusquedaAncho=20
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=tipo(s) de movimientos
IconosEstiloFijo=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=ACTIVO
Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Modulo
FiltroAplicaEn1=ContX.Modulo
FiltroAutoValidar=Modulo
FiltroTodo=S
FiltroTodoFinal=S
FiltroAplicaEn=ContX.Modulo
FiltroEstilo=Folder (1 línea)

IconosConPaginas=S
IconosNombre=ContXA:ContX.Mov
[(Carpeta Abrir).Columnas]
0=139
1=96

2=-2
3=-2
[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
EnMenu=S

[Acciones.Abrir]
Nombre=Abrir
Boton=2
NombreDesplegar=&Abrir
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
EnMenu=S

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
ConfirmarAntes=
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Ficha.ContX.Conceptos]
Carpeta=Ficha
Clave=ContX.Conceptos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=42x4
ConScroll=N
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[(Carpeta Abrir).ContX.Conceptos]
Carpeta=(Carpeta Abrir)
Clave=ContX.Conceptos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

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

[Acciones.Cuentas]
Nombre=Cuentas
Boton=51
NombreDesplegar=Catálogo de Cuentas
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+F9
Expresion=Si <BR>  Forma(<T>CtaListaCopiar<T>) y ConDatos(Info.Cuenta)<BR>Entonces<BR>  Asigna(ContXD:ContXD.Cuenta, Comillas(Info.Cuenta))<BR>Fin

[Lista]
Estilo=Hoja
PestanaNombre=Renglones Póliza
Clave=Lista
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ContXD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=ContX
LlaveLocal=ContXD.ID
LlaveMaestra=ContX.ID
ControlRenglon=S
CampoRenglon=ContXD.Renglon
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaAjustarColumnas=S
HojaIndicador=S
HojaSinBorde=S
OtroOrden=S
ListaOrden=ContXD.Renglon<TAB>(Acendente)
ValidarCampos=S
ListaCamposAValidar=ContXD.Comentarios
MenuLocal=S
ListaAcciones=Comentarios

[Lista.ContXD.Cuenta]
Carpeta=Lista
Clave=ContXD.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.ContXD.SubCuenta]
Carpeta=Lista
Clave=ContXD.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.ContXD.Concepto]
Carpeta=Lista
Clave=ContXD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.ContXD.Debe]
Carpeta=Lista
Clave=ContXD.Debe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.ContXD.Haber]
Carpeta=Lista
Clave=ContXD.Haber
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.ContXD.Condicion]
Carpeta=Lista
Clave=ContXD.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.Columnas]
Cuenta=101
SubCuenta=74
Concepto=80
Debe=114
Haber=111
Condicion=81
Orden=35
UnaVez=42
Presupuesto=102
SucursalContable=52
Debe2=76
Haber2=80
Articulo=84

ContactoEspecifico=99
SubCuenta2=82
SubCuenta3=81
[Lista.ContXD.Orden]
Carpeta=Lista
Clave=ContXD.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Poliza]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales 
Clave=Poliza
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ContX
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
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Poliza.ContX.ContMov]
Carpeta=Poliza
Clave=ContX.ContMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=42
ColorFondo=Blanco
ColorFuente=Negro

[Poliza.ContX.ContConcepto]
Carpeta=Poliza
Clave=ContX.ContConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=42
ColorFondo=Blanco
ColorFuente=Negro

[Poliza.ContX.ContReferencia]
Carpeta=Poliza
Clave=ContX.ContReferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=42
ColorFondo=Blanco
ColorFuente=Negro

[Poliza.ContX.ContProyecto]
Carpeta=Poliza
Clave=ContX.ContProyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=42
ColorFondo=Blanco
ColorFuente=Negro

[Poliza.ContX.ContObservaciones]
Carpeta=Poliza
Clave=ContX.ContObservaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=42
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ContXD.Comentarios]
Carpeta=Detalle
Clave=ContXD.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=90

[Ficha.ContX.Empresa]
Carpeta=Ficha
Clave=ContX.Empresa
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
Pegado=N
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).ContX.Empresa]
Carpeta=(Carpeta Abrir)
Clave=ContX.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[(Carpeta Abrir).ContX.Modulo]
Carpeta=(Carpeta Abrir)
Clave=ContX.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Condicion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Condición General
Clave=Condicion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ContX
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ContX.Condicion
CarpetaVisible=S

[Condicion.ContX.Condicion]
Carpeta=Condicion
Clave=ContX.Condicion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=54x14
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ContX.ConceptoNull]
Carpeta=Ficha
Clave=ContX.ConceptoNull
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=30

[Acciones.Comentarios]
Nombre=Comentarios
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
NombreDesplegar=Comentarios
EnMenu=S
TipoAccion=Expresion
Expresion=Pregunta( ContXD:ContXD.Comentarios )
Activo=S
Visible=S

[Ficha.ContX.TipoCambio]
Carpeta=Ficha
Clave=ContX.TipoCambio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios]
Estilo=Ficha
Pestana=S
Clave=Comentarios
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ContX
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ContX.Comentarios
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Comentarios

[Comentarios.ContX.Comentarios]
Carpeta=Comentarios
Clave=ContX.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=54x14
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ContX.Moneda]
Carpeta=Ficha
Clave=ContX.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=21
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ContXD.UnaVez]
Carpeta=Lista
Clave=ContXD.UnaVez
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Ficha.ContX.EnLinea]
Carpeta=Ficha
Clave=ContX.EnLinea
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Poliza.ContX.Estatus]
Carpeta=Poliza
Clave=ContX.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=42
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Lista.ContXD.Presupuesto]
Carpeta=Lista
Clave=ContXD.Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ContXD.SucursalContable]
Carpeta=Lista
Clave=ContXD.SucursalContable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[OtrosDatos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros Datos
Clave=OtrosDatos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ContX
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

[OtrosDatos.ContX.ContContacto]
Carpeta=OtrosDatos
Clave=ContX.ContContacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=38
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.ContX.ContContactoTipo]
Carpeta=OtrosDatos
Clave=ContX.ContContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=38
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.ContX.ContUEN]
Carpeta=OtrosDatos
Clave=ContX.ContUEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=38
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.ContX.ContIntercompania]
Carpeta=OtrosDatos
Clave=ContX.ContIntercompania
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=38
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ContXD.Debe2]
Carpeta=Lista
Clave=ContXD.Debe2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.ContXD.Haber2]
Carpeta=Lista
Clave=ContXD.Haber2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.ContXD.Articulo]
Carpeta=Lista
Clave=ContXD.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[OtrosDatos.ContX.ContAfectarPresupuesto]
Carpeta=OtrosDatos
Clave=ContX.ContAfectarPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=38
ColorFondo=Blanco
ColorFuente=Negro




[Ficha.ListaEnCaptura]
(Inicio)=ContX.Modulo
ContX.Modulo=ContX.Mov
ContX.Mov=ContX.Empresa
ContX.Empresa=ContX.EnLinea
ContX.EnLinea=ContX.Conceptos
ContX.Conceptos=ContX.ConceptoNull
ContX.ConceptoNull=ContX.Moneda
ContX.Moneda=ContX.TipoCambio
ContX.TipoCambio=(Fin)



[Poliza.ListaEnCaptura]
(Inicio)=ContX.ContMov
ContX.ContMov=ContX.ContConcepto
ContX.ContConcepto=ContX.ContReferencia
ContX.ContReferencia=ContX.ContProyecto
ContX.ContProyecto=ContX.ContObservaciones
ContX.ContObservaciones=ContX.Estatus
ContX.Estatus=(Fin)

[OtrosDatos.ListaEnCaptura]
(Inicio)=ContX.ContContacto
ContX.ContContacto=ContX.ContContactoTipo
ContX.ContContactoTipo=ContX.ContUEN
ContX.ContUEN=ContX.ContIntercompania
ContX.ContIntercompania=ContX.ContAfectarPresupuesto
ContX.ContAfectarPresupuesto=(Fin)





[Lista.ContXD.ContactoEspecifico]
Carpeta=Lista
Clave=ContXD.ContactoEspecifico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco




















[Lista.ContXD.SubCuenta2]
Carpeta=Lista
Clave=ContXD.SubCuenta2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.ContXD.SubCuenta3]
Carpeta=Lista
Clave=ContXD.SubCuenta3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco




[Lista.ListaEnCaptura]
(Inicio)=ContXD.Condicion
ContXD.Condicion=ContXD.Cuenta
ContXD.Cuenta=ContXD.SubCuenta
ContXD.SubCuenta=ContXD.SubCuenta2
ContXD.SubCuenta2=ContXD.SubCuenta3
ContXD.SubCuenta3=ContXD.Concepto
ContXD.Concepto=ContXD.Articulo
ContXD.Articulo=ContXD.Debe
ContXD.Debe=ContXD.Debe2
ContXD.Debe2=ContXD.Haber
ContXD.Haber=ContXD.Haber2
ContXD.Haber2=ContXD.Orden
ContXD.Orden=ContXD.UnaVez
ContXD.UnaVez=ContXD.SucursalContable
ContXD.SucursalContable=ContXD.ContactoEspecifico
ContXD.ContactoEspecifico=ContXD.Presupuesto
ContXD.Presupuesto=(Fin)

























[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=ContX.Conceptos
ContX.Conceptos=ContX.Modulo
ContX.Modulo=ContX.Empresa
ContX.Empresa=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=ACTIVO
ACTIVO=INACTIVO
INACTIVO=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Poliza
Poliza=OtrosDatos
OtrosDatos=Condicion
Condicion=Comentarios
Comentarios=Lista
Lista=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar Cambios
Guardar Cambios=Eliminar
Eliminar=Cuentas
Cuentas=Navegador
Navegador=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)
