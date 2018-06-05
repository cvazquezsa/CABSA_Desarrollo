[Forma]
Clave=TablaAnualD
Nombre=Info.Tabla
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=NumEnTexto(Info.Ejercicio)
PosicionInicialIzquierda=375
PosicionInicialArriba=218
PosicionInicialAltura=291
PosicionInicialAncho=271

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaAnualD
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
OtroOrden=S
ListaOrden=TablaAnualD.Periodo<TAB>(Acendente)
FiltroPredefinido=S
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroGeneral=TablaAnualD.TablaAnual=<T>{Info.Tabla}<T> AND<BR>TablaAnualD.Ejercicio={Info.Ejercicio}

[Lista.TablaAnualD.Periodo]
Carpeta=Lista
Clave=TablaAnualD.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaAnualD.Importe]
Carpeta=Lista
Clave=TablaAnualD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PeriodoNombre]
Carpeta=Lista
Clave=PeriodoNombre
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

[Acciones.Ejercicio]
Nombre=Ejercicio
Boton=53
NombreEnBoton=S
NombreDesplegar=&Ejercicio
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Forma(<T>EspecificarEjercicio<T>)

[Lista.Columnas]
Periodo=43
PeriodoNombre=97
Importe=101

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=Ejercicio
Ejercicio=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TablaAnualD.Periodo
TablaAnualD.Periodo=PeriodoNombre
PeriodoNombre=TablaAnualD.Importe
TablaAnualD.Importe=(Fin)
