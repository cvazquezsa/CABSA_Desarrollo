[Forma]
Clave=NominaConceptoEstado
Nombre=Impuesto Estatal - por Estado
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=460
PosicionInicialArriba=262
PosicionInicialAlturaCliente=482
PosicionInicialAncho=359
Comentarios=Info.NominaConcepto
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaConceptoEstado
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=NominaConceptoEstado.NominaConcepto=<T>{Info.NominaConcepto}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.NominaConceptoEstado.Estado]
Carpeta=Lista
Clave=NominaConceptoEstado.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaConceptoEstado.GravaImpuestoEstatal]
Carpeta=Lista
Clave=NominaConceptoEstado.GravaImpuestoEstatal
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
Estado=206
GravaImpuestoEstatal=123

[Lista.ListaEnCaptura]
(Inicio)=NominaConceptoEstado.Estado
NominaConceptoEstado.Estado=NominaConceptoEstado.GravaImpuestoEstatal
NominaConceptoEstado.GravaImpuestoEstatal=(Fin)
