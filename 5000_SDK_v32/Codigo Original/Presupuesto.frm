[Forma]
Clave=Presupuesto
Nombre=e(<T>Presupuesto<T>)+<T> - <T>+Info.Descripcion+Si(ConDatos(Info.SubCuenta),<T>/<T>+Info.SubCuenta)+Si(Info.Cerrado, <T> <T>+e(<T>(Cerrado)<T>))
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=494
PosicionInicialArriba=304
PosicionInicialAltura=291
PosicionInicialAncho=452
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Si(ConDatos(Info.Tipo), Info.Tipo+NuevaLinea)+NumEnTexto(Info.Ejercicio)
VentanaExclusiva=S
PosicionInicialAlturaCliente=264

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Presupuesto
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
CarpetaVisible=S
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=Presupuesto.Periodo<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTodoFinal=S
CondicionEdicion=no Info.Cerrado
ExpAlRefrescar=Asigna(Info.Cerrado, Falso)

FiltroGeneral=Presupuesto.Rama=<T>{Info.Rama}<T> <BR>AND Presupuesto.Cuenta=<T>{Info.Cuenta}<T> <BR>AND Presupuesto.Ejercicio={Info.Ejercicio} <BR>{Si(ConDatos(Info.Tipo),      <T> AND Presupuesto.Tipo=<T>+Comillas(Info.Tipo),<T><T>)}<BR>{Si(ConDatos(Info.SubCuenta), <T> AND Presupuesto.SubCuenta=<T>+Comillas(Info.SubCuenta),<T><T>)}
[Lista.Presupuesto.Periodo]
Carpeta=Lista
Clave=Presupuesto.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Periodo=42
Cuenta=124
SubCuenta=124
PeriodoNombre=89
Presupuesto=123

[Lista.Presupuesto.Presupuesto]
Carpeta=Lista
Clave=Presupuesto.Presupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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

[Lista.PeriodoNombre]
Carpeta=Lista
Clave=PeriodoNombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Asistente]
Nombre=Asistente
Boton=12
NombreEnBoton=S
NombreDesplegar=&Asistente
EnBarraHerramientas=S
TipoAccion=Wizards
Activo=
Visible=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
ClaveAccion=Asistente Presupuestos
ListaParametros1=Info.Cuenta<BR>Info.Descripcion<BR>Presupuesto:Presupuesto.Periodo<BR>Presupuesto:Presupuesto.Presupuesto<BR>Presupuesto:Presupuesto.Periodo
ListaParametros=S
ActivoCondicion=no Info.Cerrado


[Lista.ListaEnCaptura]
(Inicio)=Presupuesto.Periodo
Presupuesto.Periodo=PeriodoNombre
PeriodoNombre=Presupuesto.Presupuesto
Presupuesto.Presupuesto=(Fin)















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Asistente
Asistente=Ejercicio
Ejercicio=(Fin)
