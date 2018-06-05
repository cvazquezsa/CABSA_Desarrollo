[Forma]
Clave=PeriodoEspecial
Nombre=<T>Periodos Especiales - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=351
PosicionInicialArriba=235
PosicionInicialAltura=291
PosicionInicialAncho=321
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Modulo.Nombre(Info.Modulo)
PosicionInicialAlturaCliente=264

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PeriodoEspecial
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
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroGeneral=PeriodoEspecial.Empresa=<T>{Info.Empresa}<T> AND<BR>PeriodoEspecial.Modulo=<T>{Info.Modulo}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.PeriodoEspecial.Periodo]
Carpeta=Lista
Clave=PeriodoEspecial.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PeriodoEspecial.Nombre]
Carpeta=Lista
Clave=PeriodoEspecial.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Modulo=54
Periodo=48
Nombre=243

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=PeriodoEspecial.Periodo
PeriodoEspecial.Periodo=PeriodoEspecial.Nombre
PeriodoEspecial.Nombre=(Fin)
