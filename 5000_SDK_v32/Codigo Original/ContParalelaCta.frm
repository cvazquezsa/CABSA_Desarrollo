[Forma]
Clave=ContParalelaCta
Nombre=Contabilidad Paralela - Cuentas
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=292
PosicionInicialArriba=42
PosicionInicialAltura=569
PosicionInicialAncho=781
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=43
PosicionSeccion1=67
BarraAyuda=S
PosicionInicialAlturaCliente=605
PosicionSec1=314

Comentarios=Info.Empresa
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Anuncio, <T>Todas<T>)<BR>Asigna(Info.Filtro, SQL(<T>SELECT dbo.fnContParalelaCtaFiltro(:tFiltro)<T>, Info.Anuncio))
MenuPrincipal=(Lista)
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalelaCta
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=ContParalelaCta.Cuenta<TAB>(Acendente)
HojaAjustarColumnas=S
Filtros=S
FiltroGrupo1=ContParalelaCta.Rama
FiltroAplicaEn=ContParalelaCta.Cuenta
FiltroTipo=Arbol
FiltroEnOrden=S
FiltroTodoNombre=Contabilidad
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=40
FiltroPredefinido=S
FiltroValida1=CtaLista.Descripcion
FiltroArbolClave=ContParalelaCta.Cuenta
FiltroArbolValidar=ContParalelaCta.Descripcion
FiltroArbolRama=ContParalelaCta.Rama
FiltroArbolAcumulativas=ContParalelaCta.EsAcumulativa
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaAncho=40
BusquedaEnLinea=S
FiltroListas=S
FiltroListasRama=CONT
FiltroListasAplicaEn=ContParalelaCta.Cuenta
PermiteLocalizar=S

MenuLocal=S
ListaAcciones=AsignarCuenta
FiltroGeneral=ContParalelaCta.ID = <T>{Info.ID}<T><BR>AND {Info.Filtro}
[Lista.ContParalelaCta.Descripcion]
Carpeta=Lista
Clave=ContParalelaCta.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalles
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ContParalelaCta
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
ListaEnCaptura=(Lista)
CarpetaVisible=S

PermiteEditar=S
MenuLocal=S
ListaAcciones=Asignar
[Detalle.ContParalelaCta.Cuenta]
Carpeta=Detalle
Clave=ContParalelaCta.Cuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.ContParalelaCta.Rama]
Carpeta=Detalle
Clave=ContParalelaCta.Rama
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
IgnoraFlujo=N
ColorFondo=Blanco
Efectos=[Negritas]

[Detalle.ContParalelaCta.Descripcion]
Carpeta=Detalle
Clave=ContParalelaCta.Descripcion
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=45
ColorFondo=Blanco

[Lista.Columnas]
Cuenta=111
Descripcion=292
Clave=140



0=207
[Lista.Clave]
Carpeta=Lista
Clave=Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.ContParalelaCta.EsAcumulativa]
Carpeta=Detalle
Clave=ContParalelaCta.EsAcumulativa
Editar=N
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Detalle.ContParalelaCta.EsAcreedora]
Carpeta=Detalle
Clave=ContParalelaCta.EsAcreedora
Editar=N
3D=S
Tamano=15
ColorFondo=Blanco

[Configuracion.ContParalelaCta.Categoria]
Carpeta=Configuracion
Clave=ContParalelaCta.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Configuracion.ContParalelaCta.Familia]
Carpeta=Configuracion
Clave=ContParalelaCta.Familia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Configuracion.ContParalelaCta.Grupo]
Carpeta=Configuracion
Clave=ContParalelaCta.Grupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Detalle.ContParalelaCta.Tipo]
Carpeta=Detalle
Clave=ContParalelaCta.Tipo
Editar=N
ValidaNombre=S
3D=S
Tamano=15
Efectos=[Negritas]
ColorFondo=Blanco

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S
EspacioPrevio=S


[Detalle.ContParalelaCta.Estatus]
Carpeta=Detalle
Clave=ContParalelaCta.Estatus
Editar=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco














[Configuracion.ListaEnCaptura]
(Inicio)=ContParalelaCta.Categoria
ContParalelaCta.Categoria=ContParalelaCta.Familia
ContParalelaCta.Familia=ContParalelaCta.Grupo
ContParalelaCta.Grupo=(Fin)




















































[(Carpeta Abrir)]
Estilo=Iconos
Pestana=S
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=ContParalelaCta
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S


[(Carpeta Abrir).Columnas]
0=-2



































[Acciones.Asignadas]
Nombre=Asignadas
Boton=71
NombreEnBoton=S
NombreDesplegar=&Asignadas
EnBarraHerramientas=S
EnMenu=S
Visible=S







EspacioPrevio=S






Menu=&Ver
TipoAccion=Expresion
Expresion=Asigna(Info.Anuncio,  <T>Asignadas<T>)<BR>Asigna(Info.Filtro, SQL(<T>SELECT dbo.fnContParalelaCtaFiltro(:tFiltro)<T>, Info.Anuncio))<BR>ActualizarVista<BR>ActualizarForma
ActivoCondicion=Info.Anuncio <> <T>Asignadas<T>
[Acciones.Todas]
Nombre=Todas
Boton=103
NombreEnBoton=S
NombreDesplegar=&Todas
EnBarraHerramientas=S
EnMenu=S
Visible=S

EspacioPrevio=S












Menu=&Ver















TipoAccion=Expresion
Expresion=Asigna(Info.Anuncio,  <T>Todas<T>)<BR>Asigna(Info.Filtro, SQL(<T>SELECT dbo.fnContParalelaCtaFiltro(:tFiltro)<T>, Info.Anuncio))<BR>ActualizarVista<BR>ActualizarForma
ActivoCondicion=Info.Anuncio <> <T>Todas<T>
[Acciones.SinAsignar]
Nombre=SinAsignar
Boton=102
NombreEnBoton=S
Menu=&Ver
NombreDesplegar=&Sin Asignar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
Visible=S

























TipoAccion=Expresion











































Expresion=Asigna(Info.Anuncio,  <T>SinAsignar<T>)<BR>Asigna(Info.Filtro, SQL(<T>SELECT dbo.fnContParalelaCtaFiltro(:tFiltro)<T>, Info.Anuncio))<BR>ActualizarVista<BR>ActualizarForma
ActivoCondicion=Info.Anuncio <> <T>SinAsignar<T>

[Acciones.Asignar]
Nombre=Asignar
Boton=0
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S


[Acciones.AsignarCuenta]
Nombre=AsignarCuenta
Boton=0
NombreDesplegar=Asignar Cuenta
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Antes=S













Expresion=FormaModal(<T>ContParalelaAsignaCuenta<T>)<BR>ActualizarVista<BR>ActualizarForma
AntesExpresiones=Asigna(Info.Valor, ContParalelaCta:ContParalelaCta.CuentaAsignada)<BR>Asigna(Info.ContParalelaCuentaD, ContParalelaCta:ContParalelaCta.Cuenta)<BR>Asigna(Info.Rama, ContParalelaCta:ContParalelaCta.Rama)




[Lista.ListaEnCaptura]
(Inicio)=Clave
Clave=ContParalelaCta.Descripcion
ContParalelaCta.Descripcion=(Fin)











































[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

























EspacioPrevio=S
Menu=&Archivo
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



















Menu=&Archivo














[Transformacion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Transformación
Clave=Transformacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ContParalelaCta
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

[Transformacion.ContParalelaCta.CuentaAsignada]
Carpeta=Transformacion
Clave=ContParalelaCta.CuentaAsignada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Transformacion.Cta.Descripcion]
Carpeta=Transformacion
Clave=Cta.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco

[Transformacion.ContParalelaCta.TransformarNegativo]
Carpeta=Transformacion
Clave=ContParalelaCta.TransformarNegativo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20

[Transformacion.Columnas]
CuentaAsignada=124
Descripcion_1=304
TransformarNegativo=124










[Transformacion.ListaEnCaptura]
(Inicio)=ContParalelaCta.CuentaAsignada
ContParalelaCta.CuentaAsignada=Cta.Descripcion
Cta.Descripcion=ContParalelaCta.TransformarNegativo
ContParalelaCta.TransformarNegativo=(Fin)




[Detalle.ListaEnCaptura]
(Inicio)=ContParalelaCta.Cuenta
ContParalelaCta.Cuenta=ContParalelaCta.Descripcion
ContParalelaCta.Descripcion=ContParalelaCta.Tipo
ContParalelaCta.Tipo=ContParalelaCta.Rama
ContParalelaCta.Rama=ContParalelaCta.Estatus
ContParalelaCta.Estatus=ContParalelaCta.EsAcumulativa
ContParalelaCta.EsAcumulativa=ContParalelaCta.EsAcreedora
ContParalelaCta.EsAcreedora=(Fin)
















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=Transformacion
Transformacion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Todas
Todas=Asignadas
Asignadas=SinAsignar
SinAsignar=Navegador
Navegador=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)
