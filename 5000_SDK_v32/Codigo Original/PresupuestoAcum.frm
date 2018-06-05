[Forma]
Clave=PresupuestoAcum
Nombre=e(<T>Presupuesto<T>)+<T> - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=262
PosicionInicialArriba=329
PosicionInicialAltura=309
PosicionInicialAncho=755
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Si(ConDatos(Info.Tipo),Info.Tipo+NuevaLinea)+NumEnTexto(Info.Ejercicio))
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=339

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PresupuestoAcum
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
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroGeneral=PresupuestoAcum.Rama=<T>{Info.Rama}<T> AND<BR>PresupuestoAcum.Cuenta=<T>{Info.Cuenta}<T> AND<BR>PresupuestoAcum.Ejercicio={Info.Ejercicio} <BR>{Si(ConDatos(Info.Tipo), <T> AND PresupuestoAcum.Tipo=<T>+Comillas(Info.Tipo),<T><T>)}

[Lista.PeriodoNombre]
Carpeta=Lista
Clave=PeriodoNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
PeriodoNombre=81
Acumulado=130
SubCuenta=124
Cuenta=124
Deudor=122
Acreedor=111
Presupuesto=113
Neto=120
Reservado=108
Ejercicio=64
Disponible=111
Ejercido=116
Comprometido=97
Devengado=94

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

[Acciones.Ejercicio]
Nombre=Ejercicio
Boton=53
NombreEnBoton=S
NombreDesplegar=&Ejercicio
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Forma(<T>EspecificarEjercicio<T>)

[Lista.PresupuestoAcum.Presupuesto]
Carpeta=Lista
Clave=PresupuestoAcum.Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PresupuestoAcum.Reservado]
Carpeta=Lista
Clave=PresupuestoAcum.Reservado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PresupuestoAcum.Ejercido]
Carpeta=Lista
Clave=PresupuestoAcum.Ejercido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PresupuestoAcum.Disponible]
Carpeta=Lista
Clave=PresupuestoAcum.Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PresupuestoAcum.Comprometido]
Carpeta=Lista
Clave=PresupuestoAcum.Comprometido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PresupuestoAcum.Devengado]
Carpeta=Lista
Clave=PresupuestoAcum.Devengado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Ejercicio
Ejercicio=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PeriodoNombre
PeriodoNombre=PresupuestoAcum.Presupuesto
PresupuestoAcum.Presupuesto=PresupuestoAcum.Reservado
PresupuestoAcum.Reservado=PresupuestoAcum.Comprometido
PresupuestoAcum.Comprometido=PresupuestoAcum.Devengado
PresupuestoAcum.Devengado=PresupuestoAcum.Ejercido
PresupuestoAcum.Ejercido=PresupuestoAcum.Disponible
PresupuestoAcum.Disponible=(Fin)
