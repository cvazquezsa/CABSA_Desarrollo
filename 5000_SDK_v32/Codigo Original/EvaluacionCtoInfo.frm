[Forma]
Clave=EvaluacionCtoInfo
Nombre=<T>Evaluación - <T>+Info.Evaluacion+ <T> (<T>+FechaEnTexto(Info.Fecha, <T>dd/mmm/aaaa<T>)+<T>)<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=1302
PosicionInicialArriba=52
PosicionInicialAlturaCliente=440
PosicionInicialAncho=673
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=por Omisión
PosicionColumna1=69
Comentarios=Si(Info.Aplica=<T>Movimientos<T>, Info.Nombre, Lista(Info.Clave, Info.Nombre))
VentanaExclusiva=S
AutoGuardar=S
ExpresionesAlMostrar=EjecutarSQL(<T>spEvaluacionCto :tEval, :fFecha, :tCto<T>, Info.Evaluacion, Info.Fecha, Info.Clave)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EvaluacionCto
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
CarpetaVisible=S
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
FiltroAplicaEn=EvaluacionFormato.Seccion
FiltroAutoCampo=EvaluacionFormato.Seccion
FiltroAutoValidar=EvaluacionFormato.Seccion
FiltroGeneral=EvaluacionCto.Contacto=<T>{Info.Clave}<T> AND <BR>EvaluacionCto.Fecha=<T>{FechaFormatoServidor(Info.Fecha)}<T> AND<BR>EvaluacionCto.Evaluacion=<T>{Info.Evaluacion}<T>

[Lista.EvaluacionCto.Punto]
Carpeta=Lista
Clave=EvaluacionCto.Punto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro
Editar=N
Efectos=[Negritas]

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Punto=353
Descripcion=604
Calificacion=60
Respuesta=65

[Desc]
Estilo=Ficha
Clave=Desc
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=EvaluacionCto
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=EvaluacionFormato.Descripcion
CarpetaVisible=S
AlinearTodaCarpeta=S
PermiteEditar=S

[Desc.EvaluacionFormato.Descripcion]
Carpeta=Desc
Clave=EvaluacionFormato.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10x5
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Historico]
Nombre=Historico
Boton=53
NombreEnBoton=S
NombreDesplegar=&Histórico
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EvaluacionCtoHist
Activo=S
Visible=S

[Acciones.Reporte]
Nombre=Reporte
Boton=68
NombreEnBoton=S
NombreDesplegar=&Reporte
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Pantalla
ClaveAccion=EvaluacionCto
Activo=S
Visible=S
GuardarAntes=S

[Acciones.Comentarios]
Nombre=Comentarios
Boton=38
NombreEnBoton=S
NombreDesplegar=&Comentarios
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=EvaluacionComentariosInfo
Activo=S
Visible=S
EspacioPrevio=S

[Lista.EvaluacionCto.Respuesta]
Carpeta=Lista
Clave=EvaluacionCto.Respuesta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.SubEvaluacion]
Nombre=SubEvaluacion
Boton=47
NombreEnBoton=S
NombreDesplegar=&Sub
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
Expresion=Asigna(Info.SubEvaluacion, EvaluacionCto:EvaluacionFormato.Referencia)<BR>Forma(<T>EvaluacionCtoSubInfo<T>)
ActivoCondicion=ConDatos(EvaluacionCto:EvaluacionFormato.Referencia)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Desc
Desc=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Comentarios
Comentarios=SubEvaluacion
SubEvaluacion=Reporte
Reporte=Historico
Historico=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=EvaluacionCto.Punto
EvaluacionCto.Punto=EvaluacionCto.Respuesta
EvaluacionCto.Respuesta=(Fin)

[Lista.ListaOrden]
(Inicio)=EvaluacionFormato.Orden<TAB>(Acendente)
EvaluacionFormato.Orden<TAB>(Acendente)=EvaluacionCto.Punto<TAB>(Acendente)
EvaluacionCto.Punto<TAB>(Acendente)=(Fin)
