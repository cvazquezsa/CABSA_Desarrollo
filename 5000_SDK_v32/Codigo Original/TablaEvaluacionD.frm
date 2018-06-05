[Forma]
Clave=TablaEvaluacionD
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
PosicionInicialIzquierda=438
PosicionInicialArriba=294
PosicionInicialAltura=291
PosicionInicialAncho=445
PosicionInicialAlturaCliente=408

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaEvaluacionD
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
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroGeneral=TablaEvaluacionD.TablaEvaluacion=<T>{Info.Tabla}<T>

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
Periodo=43
PeriodoNombre=87
Importe=117
Numero=69
Valor=70
Nombre=304
Orden=40

[Lista.TablaEvaluacionD.Valor]
Carpeta=Lista
Clave=TablaEvaluacionD.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Lista.TablaEvaluacionD.Nombre]
Carpeta=Lista
Clave=TablaEvaluacionD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaEvaluacionD.Orden]
Carpeta=Lista
Clave=TablaEvaluacionD.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TablaEvaluacionD.Nombre
TablaEvaluacionD.Nombre=TablaEvaluacionD.Valor
TablaEvaluacionD.Valor=TablaEvaluacionD.Orden
TablaEvaluacionD.Orden=(Fin)

[Lista.ListaOrden]
(Inicio)=TablaEvaluacionD.Orden<TAB>(Acendente)
TablaEvaluacionD.Orden<TAB>(Acendente)=TablaEvaluacionD.Nombre<TAB>(Acendente)
TablaEvaluacionD.Nombre<TAB>(Acendente)=(Fin)
