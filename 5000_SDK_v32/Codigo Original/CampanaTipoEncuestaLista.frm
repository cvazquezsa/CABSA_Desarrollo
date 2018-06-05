[Forma]
Clave=CampanaTipoEncuestaLista
Nombre=Ayuda
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=669
PosicionInicialArriba=236
PosicionInicialAlturaCliente=584
PosicionInicialAncho=682
Comentarios=Lista(Info.Tipo, Info.Campo)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaTipoEncuestaLista
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
ListaOrden=CampanaTipoEncuestaLista.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=CampanaTipoEncuestaLista.CampanaTipo=<T>{Info.Tipo}<T> AND<BR>CampanaTipoEncuestaLista.Campo=<T>{Info.Campo}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.CampanaTipoEncuestaLista.Valor]
Carpeta=Lista
Clave=CampanaTipoEncuestaLista.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaTipoEncuestaLista.Orden]
Carpeta=Lista
Clave=CampanaTipoEncuestaLista.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
Valor=604
Orden=40

[Lista.ListaEnCaptura]
(Inicio)=CampanaTipoEncuestaLista.Valor
CampanaTipoEncuestaLista.Valor=CampanaTipoEncuestaLista.Orden
CampanaTipoEncuestaLista.Orden=(Fin)
