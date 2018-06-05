[Forma]
Clave=CompetenciaResultado
Icono=0
Modulos=(Todos)
Nombre=Resultados del Competencia

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Competencia
PosicionInicialIzquierda=408
PosicionInicialArriba=177
PosicionInicialAlturaCliente=377
PosicionInicialAncho=490
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompetenciaResultado
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
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)

Filtros=S
OtroOrden=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaOrden=CompetenciaResultado.Orden<TAB>(Acendente)
FiltroGeneral=CompetenciaResultado.Competencia=<T>{Info.Competencia}<T>
[Lista.CompetenciaResultado.Resultado]
Carpeta=Lista
Clave=CompetenciaResultado.Resultado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.CompetenciaResultado.Valor]
Carpeta=Lista
Clave=CompetenciaResultado.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




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
Resultado=343
Valor=64

Orden=42

Descalifica=59
[Lista.CompetenciaResultado.Orden]
Carpeta=Lista
Clave=CompetenciaResultado.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=CompetenciaResultado.Resultado
CompetenciaResultado.Resultado=CompetenciaResultado.Valor
CompetenciaResultado.Valor=CompetenciaResultado.Orden
CompetenciaResultado.Orden=(Fin)
