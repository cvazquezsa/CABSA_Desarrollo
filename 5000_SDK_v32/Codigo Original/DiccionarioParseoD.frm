
[Forma]
Clave=DiccionarioParseoD
Icono=0
CarpetaPrincipal=DiccionarioParseoD
BarraHerramientas=S
Modulos=(Todos)
Nombre=Diccionario de Parseo
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=DiccionarioParseoD
ListaAcciones=Aceptar<BR>Documento Nuevo<BR>Registro Eliminar
PosicionInicialAlturaCliente=273
PosicionInicialAncho=510
Comentarios=Lista(Info.Tipo,Info.Nombre)
PosicionInicialIzquierda=224
PosicionInicialArriba=363
[DiccionarioParseoD]
Estilo=Hoja
Clave=DiccionarioParseoD
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DiccionarioParseoD
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
ListaEnCaptura=DiccionarioParseoD.ValorOriginal<BR>DiccionarioParseoD.ValorDestino
CarpetaVisible=S

Filtros=S
OtroOrden=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=DiccionarioParseoD.Exportacion=<T>{Info.Tipo}<T> AND DiccionarioParseoD.IDSeccion = {Info.Numero}
[DiccionarioParseoD.DiccionarioParseoD.ValorOriginal]
Carpeta=DiccionarioParseoD
Clave=DiccionarioParseoD.ValorOriginal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[DiccionarioParseoD.DiccionarioParseoD.ValorDestino]
Carpeta=DiccionarioParseoD
Clave=DiccionarioParseoD.ValorDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Documento Nuevo]
Nombre=Documento Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=Eliminar
EnBarraHerramientas=S
EspacioPrevio=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S


[DiccionarioParseoD.Columnas]
ValorOriginal=238
ValorDestino=242

Exportacion=304
IDSeccion=64
RID=64



