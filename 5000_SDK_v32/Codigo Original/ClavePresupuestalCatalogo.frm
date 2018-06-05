
[Forma]
Clave=ClavePresupuestalCatalogo
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=<T>Catalogos Presupuestales - <T> & Info.Tipo
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
Comentarios=Lista(Info.Proyecto, Info.Clave)
PosicionInicialAlturaCliente=419
PosicionInicialAncho=868
ListaAcciones=(Lista)
VentanaTipoMarco=Sencillo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=206
PosicionInicialArriba=177
VentanaRepetir=S
VentanaExclusiva=S
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ClavePresupuestalCatalogo
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
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral={Info.Mensaje}
[Lista.ClavePresupuestalCatalogo.Clave]
Carpeta=Lista
Clave=ClavePresupuestalCatalogo.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ClavePresupuestalCatalogo.Nombre]
Carpeta=Lista
Clave=ClavePresupuestalCatalogo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ClavePresupuestalCatalogo.TechoPresupuesto]
Carpeta=Lista
Clave=ClavePresupuestalCatalogo.TechoPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ClavePresupuestalCatalogo.Descripcion]
Carpeta=Lista
Clave=ClavePresupuestalCatalogo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.ClavePresupuestalCatalogo.Observaciones]
Carpeta=Lista
Clave=ClavePresupuestalCatalogo.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Lista.Columnas]
Clave=79
Nombre=183
TechoPresupuesto=102
Descripcion=231
Observaciones=239
Categoria=50
Rama=104
RamaTipo=166
RamaCategoria=83

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
















[Acciones.FormaRecursiva]
Nombre=FormaRecursiva
Boton=47
NombreDesplegar=Sub-Catálogos
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ClavePresupuestalCatalogo
Antes=S
DespuesGuardar=S
Visible=S






ActivoCondicion=SQL(<T>SELECT count(Tipo) FROM ClavePresupuestalCatalogoTipo WHERE Rama = :tTipo<T>, ClavePresupuestalCatalogo:ClavePresupuestalCatalogo.Tipo) = 1
AntesExpresiones=Asigna(Info.Clave, ClavePresupuestalCatalogo:ClavePresupuestalCatalogo.RID)<BR>Asigna(Info.Tipo, SQL(<T>SELECT ISNULL(MAX(Tipo), <T>& Comillas(Info.Tipo) &<T>) FROM ClavePresupuestalCatalogoTipo WHERE Rama = :tTipo<T>, ClavePresupuestalCatalogo:ClavePresupuestalCatalogo.Tipo))<BR>Asigna(Info.Mensaje, <T>Proyecto = <T> & Comillas(Info.Proyecto) & <T> AND Tipo = <T> & Comillas(Info.Tipo) &<T> AND Rama = <T> & Comillas(Info.Clave))<BR>/*Informacion(Info.Mensaje)




[Lista.ListaEnCaptura]
(Inicio)=ClavePresupuestalCatalogo.Clave
ClavePresupuestalCatalogo.Clave=ClavePresupuestalCatalogo.Nombre
ClavePresupuestalCatalogo.Nombre=ClavePresupuestalCatalogo.Descripcion
ClavePresupuestalCatalogo.Descripcion=ClavePresupuestalCatalogo.TechoPresupuesto
ClavePresupuestalCatalogo.TechoPresupuesto=ClavePresupuestalCatalogo.Observaciones
ClavePresupuestalCatalogo.Observaciones=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=FormaRecursiva
FormaRecursiva=(Fin)
