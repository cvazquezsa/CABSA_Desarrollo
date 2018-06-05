
[Forma]
Clave=ActivoFTipoIndicador
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Indicadores Validos por Tipo
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=273
PosicionInicialAncho=577
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=431
PosicionInicialArriba=300
Comentarios=Lista(Info.Tipo)
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFTipoIndicador
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S
OtroOrden=S
PermiteEditar=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ActivoFTipoIndicador.Tipo = {Comillas(Info.Tipo)}
[Lista.ActivoFTipoIndicador.Indicador]
Carpeta=Lista
Clave=ActivoFTipoIndicador.Indicador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoIndicador.TipoDato]
Carpeta=Lista
Clave=ActivoFTipoIndicador.TipoDato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoIndicador.Formato]
Carpeta=Lista
Clave=ActivoFTipoIndicador.Formato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ActivoFTipoIndicador.ValidarEnLista]
Carpeta=Lista
Clave=ActivoFTipoIndicador.ValidarEnLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Indicador=225
TipoDato=124
Formato=124
ValidarEnLista=70




[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.ActivoFTipoIndicadorLista]
Nombre=ActivoFTipoIndicadorLista
Boton=41
NombreDesplegar=Valores Validos
EnBarraHerramientas=S
Activo=S
Visible=S



NombreEnBoton=S
TipoAccion=Formas
ClaveAccion=ActivoFTipoIndicadorLista
Antes=S




EspacioPrevio=S


GuardarAntes=S
AntesExpresiones=Asigna(Info.Observaciones, ActivoFTipoIndicador:ActivoFTipoIndicador.Indicador)

















[Lista.ListaEnCaptura]
(Inicio)=ActivoFTipoIndicador.Indicador
ActivoFTipoIndicador.Indicador=ActivoFTipoIndicador.TipoDato
ActivoFTipoIndicador.TipoDato=ActivoFTipoIndicador.Formato
ActivoFTipoIndicador.Formato=ActivoFTipoIndicador.ValidarEnLista
ActivoFTipoIndicador.ValidarEnLista=(Fin)


[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S











NombreEnBoton=S
Expresion=EJECUTARSQL(<T>EXEC spMAFPermiteEliminarActivoFTipoIndicador :tTipo, NULL, :tIndicador, :tDependeDe, :tModo<T>,ActivoFTipoIndicador:ActivoFTipoIndicador.Tipo,ActivoFTipoIndicador:ActivoFTipoIndicador.Indicador,<T>ActivoFTipo<T>,<T>Eliminar<T>)<BR>ActualizarVista
ActivoCondicion=SI(SQL(<T>EXEC spMAFPermiteEliminarActivoFTipoIndicador :tTipo, NULL, :tIndicador, :tDependeDe, :tModo<T>,ActivoFTipoIndicador:ActivoFTipoIndicador.Tipo,ActivoFTipoIndicador:ActivoFTipoIndicador.Indicador,<T>ActivoFTipo<T>,<T>Preguntar<T>) = 1,Verdadero,Falso)






[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Eliminar
Eliminar=ActivoFTipoIndicadorLista
ActivoFTipoIndicadorLista=(Fin)
