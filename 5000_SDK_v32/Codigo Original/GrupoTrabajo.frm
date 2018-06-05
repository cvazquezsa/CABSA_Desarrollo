[Forma]
Clave=GrupoTrabajo
Nombre=Grupos de Trabajo
Icono=0
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
ListaAcciones=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=380
PosicionInicialArriba=350
PosicionInicialAltura=323
PosicionInicialAncho=520
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
PosicionInicialAlturaCliente=296

[GrupoTrabajo.Columnas]
GrupoTrabajo=199
Descripcion=297
MenuPrincipal=169
Multiple=44

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=Si
EnBarraAcciones=Si
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=Si
Visible=Si
NombreEnBoton=Si
EnBarraHerramientas=Si

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=GrupoTrabajoD
ConCondicion=S
Antes=S
Visible=S
GuardarAntes=S
ActivoCondicion=GrupoTrabajo:GrupoTrabajo.Multiple
EjecucionCondicion=ConDatos(GrupoTrabajo:GrupoTrabajo.GrupoTrabajo)
AntesExpresiones=Asigna(Info.Grupo, GrupoTrabajo:GrupoTrabajo.GrupoTrabajo)

[Lista]
Estilo=Hoja
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GrupoTrabajo
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=GrupoTrabajo.GrupoTrabajo<TAB>(Acendente)
CarpetaVisible=S

[Lista.GrupoTrabajo.GrupoTrabajo]
Carpeta=Lista
Clave=GrupoTrabajo.GrupoTrabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GrupoTrabajo.Multiple]
Carpeta=Lista
Clave=GrupoTrabajo.Multiple
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
GrupoTrabajo=202
Multiple=42
DirectorioCodigo=245

[Lista.GrupoTrabajo.DirectorioCodigo]
Carpeta=Lista
Clave=GrupoTrabajo.DirectorioCodigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=150
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Detalle
Detalle=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=GrupoTrabajo.GrupoTrabajo
GrupoTrabajo.GrupoTrabajo=GrupoTrabajo.Multiple
GrupoTrabajo.Multiple=GrupoTrabajo.DirectorioCodigo
GrupoTrabajo.DirectorioCodigo=(Fin)
