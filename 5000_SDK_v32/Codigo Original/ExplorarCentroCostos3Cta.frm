[Forma]
Clave=ExplorarCentroCostos3Cta
Icono=47
Modulos=(Todos)
Nombre=<T>Explorando - Centros de Costos 3 (por Cuenta)<T>
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=333
PosicionInicialArriba=213
PosicionInicialAltura=470
PosicionInicialAncho=773
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.SubCuenta, Info.Ejercicio)
PosicionInicialAlturaCliente=443
VentanaEstadoInicial=Normal

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContAcum
Fuente={MS Sans Serif, 8, Negro, []}
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Acum.Empresa=<T>{Empresa}<T> AND Cta.Tipo<><T>{TipoEstructura}<T> AND Acum.SubCuenta=<T>{Info.SubCuenta}<T> AND Acum.Ejercicio={Info.Ejercicio}

[Lista.Cta.Cuenta]
Carpeta=Lista
Clave=Cta.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cta.Descripcion]
Carpeta=Lista
Clave=Cta.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cta.Tipo]
Carpeta=Lista
Clave=Cta.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Acum.Cargos]
Carpeta=Lista
Clave=Acum.Cargos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Acum.Abonos]
Carpeta=Lista
Clave=Acum.Abonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Cuenta=132
Descripcion=206
Tipo=68
PeriodoNombre=79
Cargos=123
Abonos=131
NombrePeriodo=80

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
NombreDesplegar=Presentación preliminar
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

[Lista.NombrePeriodo]
Carpeta=Lista
Clave=NombrePeriodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Ejercicio]
Nombre=Ejercicio
Boton=53
NombreEnBoton=S
NombreDesplegar=&Ejercicio
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=Forma(<T>EspecificarEjercicio<T>)

[Acciones.Desglosar]
Nombre=Desglosar
Boton=47
NombreDesplegar=&Desglosar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ExplorarCentroCostos3CtaD
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
ActivoCondicion=no ContAcum:Cta.EsAcumulativa
EjecucionCondicion=ConDatos(ContAcum:Cta.Cuenta)
AntesExpresiones=Asigna(Info.Cuenta, ContAcum:Cta.Cuenta)<BR>Asigna(Info.Periodo, ContAcum:Acum.Periodo)<BR>Asigna(Info.Nombre, ContAcum:NombrePeriodo)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Desglosar
Desglosar=Ejercicio
Ejercicio=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cta.Cuenta
Cta.Cuenta=Cta.Descripcion
Cta.Descripcion=Cta.Tipo
Cta.Tipo=NombrePeriodo
NombrePeriodo=Acum.Cargos
Acum.Cargos=Acum.Abonos
Acum.Abonos=(Fin)
