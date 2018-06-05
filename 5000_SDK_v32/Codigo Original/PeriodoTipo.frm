[Forma]
Clave=PeriodoTipo
Nombre=Tipos de Periodos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAltura=300
PosicionInicialAncho=435
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=422
PosicionInicialArriba=362
ExpresionesAlMostrar=Asigna(Info.Ejercicio, EjercicioTrabajo)
PosicionInicialAlturaCliente=273

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PeriodoTipo
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMantenerSeleccion=S

[Lista.PeriodoTipo.PeriodoTipo]
Carpeta=Lista
Clave=PeriodoTipo.PeriodoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
PeriodoTipo=164
DiasPeriodo=69
DiasHabiles=68
UltimoDiaPagado=102

[Acciones.Editar]
Nombre=Editar
Boton=47
NombreEnBoton=S
NombreDesplegar=&Tabla
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PeriodoTipoD
ConCondicion=S
Antes=S
Activo=S
EjecucionCondicion=ConDatos(PeriodoTipo:PeriodoTipo.PeriodoTipo)
AntesExpresiones=Asigna(Info.PeriodoTipo, PeriodoTipo:PeriodoTipo.PeriodoTipo)

[Lista.PeriodoTipo.DiasPeriodo]
Carpeta=Lista
Clave=PeriodoTipo.DiasPeriodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PeriodoTipo.DiasHabiles]
Carpeta=Lista
Clave=PeriodoTipo.DiasHabiles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PeriodoTipo.UltimoDiaPagado]
Carpeta=Lista
Clave=PeriodoTipo.UltimoDiaPagado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.PeriodoTipoMov]
Nombre=PeriodoTipoMov
Boton=47
NombreEnBoton=S
NombreDesplegar=por &Movimiento
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PeriodoTipoMov
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(PeriodoTipo:PeriodoTipo.PeriodoTipo)
AntesExpresiones=Asigna(Info.PeriodoTipo, PeriodoTipo:PeriodoTipo.PeriodoTipo)

[Acciones.PeriodoTipoMovEmpresa]
Nombre=PeriodoTipoMovEmpresa
Boton=47
NombreEnBoton=S
NombreDesplegar=por Movimiento/&Empresa
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PeriodoTipoMovEmpresa
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(PeriodoTipo:PeriodoTipo.PeriodoTipo)
AntesExpresiones=Asigna(Info.PeriodoTipo, PeriodoTipo:PeriodoTipo.PeriodoTipo)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=PeriodoTipoMov
PeriodoTipoMov=PeriodoTipoMovEmpresa
PeriodoTipoMovEmpresa=Editar
Editar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PeriodoTipo.PeriodoTipo
PeriodoTipo.PeriodoTipo=PeriodoTipo.DiasPeriodo
PeriodoTipo.DiasPeriodo=PeriodoTipo.DiasHabiles
PeriodoTipo.DiasHabiles=PeriodoTipo.UltimoDiaPagado
PeriodoTipo.UltimoDiaPagado=(Fin)
