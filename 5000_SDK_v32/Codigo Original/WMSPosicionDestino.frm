
[Forma]
Clave=WMSPosicionDestino
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Posición Destino

PosicionInicialIzquierda=418
PosicionInicialArriba=232
PosicionInicialAlturaCliente=225
PosicionInicialAncho=529
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Almacen +<T> | <T>+Info.Articulo
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[(Variables).Info.Posicion]
Carpeta=(Variables)
Clave=Info.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Posicion=89
Tipo=106
ArticuloEsp=73
Pasillo=45
Nivel=37
Zona=64
Descripcion=159
Estatus=54

PosicionDestino=81
Movimiento=126
Origenc=137
Tarima=124
Descrpcion=181
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WMSMontacargaTarea
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

PermiteEditar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral={<T>WMSMontacargaTarea.IDLista =<T>& Info.Numero} {<T> AND WMSMontacargaTarea.Estacion = <T> & EstacionTrabajo }
[Lista.WMSMontacargaTarea.PosicionDestino]
Carpeta=Lista
Clave=WMSMontacargaTarea.PosicionDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

EditarConBloqueo=S
IgnoraFlujo=S
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
Activo=S
Visible=S

GuardarAntes=S
Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S









[Lista.WMSMontacargaTarea.Movimiento]
Carpeta=Lista
Clave=WMSMontacargaTarea.Movimiento
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.Origenc]
Carpeta=Lista
Clave=Origenc
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco









[Lista.WMSMontacargaTarea.Tarima]
Carpeta=Lista
Clave=WMSMontacargaTarea.Tarima
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

















[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Temp.Logico, Verdadero)
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)
















[Lista.ListaEnCaptura]
(Inicio)=WMSMontacargaTarea.Movimiento
WMSMontacargaTarea.Movimiento=Origenc
Origenc=WMSMontacargaTarea.Tarima
WMSMontacargaTarea.Tarima=WMSMontacargaTarea.PosicionDestino
WMSMontacargaTarea.PosicionDestino=(Fin)











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
