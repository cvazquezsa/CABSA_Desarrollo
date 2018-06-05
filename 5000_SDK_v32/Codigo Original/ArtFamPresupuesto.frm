[Forma]
Clave=ArtFamPresupuesto
Nombre=e(<T>Presupuesto<T>)+<T> - <T>+Info.ArtFam
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=454
PosicionInicialArriba=326
PosicionInicialAlturaCliente=345
PosicionInicialAncho=371
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)
Comentarios=Info.Ejercicio
ExpresionesAlMostrar=Asigna(Info.Ejercicio,  Año(Hoy))

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtFamPresupuesto
Fuente={Tahoma, 8, Negro, []}
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
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=ArtFamPresupuesto.Familia=<T>{Info.ArtFam}<T> AND ArtFamPresupuesto.Ejercicio={Info.Ejercicio}
FiltroRespetar=S
FiltroTipo=General

[Lista.ArtFamPresupuesto.Periodo]
Carpeta=Lista
Clave=ArtFamPresupuesto.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtFamPresupuesto.Cantidad]
Carpeta=Lista
Clave=ArtFamPresupuesto.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Ejercicio=58
Periodo=41
Cantidad=115
PeriodoNombre=184

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
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
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
EjecucionCondicion=Forma(<T>EspecificarEjercicio<T>)
Visible=S

[Acciones.Asistente]
Nombre=Asistente
Boton=12
NombreEnBoton=S
NombreDesplegar=&Asistente
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Wizards
ClaveAccion=Asistente Presupuestos
ListaParametros1=ArtFamPresupuesto:ArtFamPresupuesto.Familia<BR>ArtFamPresupuesto:ArtFamPresupuesto.Familia<BR>ArtFamPresupuesto:ArtFamPresupuesto.Periodo<BR>ArtFamPresupuesto:ArtFamPresupuesto.Cantidad
ListaParametros=S
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Asistente
Asistente=Ejercicio
Ejercicio=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtFamPresupuesto.Periodo
ArtFamPresupuesto.Periodo=PeriodoNombre
PeriodoNombre=ArtFamPresupuesto.Cantidad
ArtFamPresupuesto.Cantidad=(Fin)
