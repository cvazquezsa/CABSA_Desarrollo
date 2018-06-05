[Forma]
Clave=TablaEvaluacion
Nombre=Tablas Evaluación
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
CarpetaPrincipal=Lista
PosicionInicialIzquierda=803
PosicionInicialArriba=411
PosicionInicialAltura=300
PosicionInicialAncho=314
PosicionInicialAlturaCliente=342
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaEvaluacion
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TablaEvaluacion.TablaEvaluacion
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.TablaEvaluacion.TablaEvaluacion]
Carpeta=Lista
Clave=TablaEvaluacion.TablaEvaluacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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
TablaEvaluacion=277

[Acciones.Tabla]
Nombre=Tabla
Boton=47
NombreEnBoton=S
NombreDesplegar=E&ditar Tabla
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TablaEvaluacionD
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(TablaEvaluacion:TablaEvaluacion.TablaEvaluacion)
AntesExpresiones=Asigna(Info.Tabla,TablaEvaluacion:TablaEvaluacion.TablaEvaluacion)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Tabla
Tabla=(Fin)
