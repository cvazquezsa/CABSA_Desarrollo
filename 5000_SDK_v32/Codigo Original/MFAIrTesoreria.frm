
[Forma]
Clave=MFAIrTesoreria
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Configuración Claves Tesorería

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=533
PosicionInicialArriba=267
PosicionInicialAlturaCliente=222
PosicionInicialAncho=326
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Guardar y Cerrar
BarraHerramientas=S
Menus=S
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAIrTesoreria
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)


PermiteEditar=S
Filtros=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
[Lista.MFAIrTesoreria.Movimiento]
Carpeta=Lista
Clave=MFAIrTesoreria.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFAIrTesoreria.Clave]
Carpeta=Lista
Clave=MFAIrTesoreria.Clave
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Movimiento=141
Clave=104





0=105
1=109



[Acciones.Guardar y Cerrar]
Nombre=Guardar y Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
EnBarraHerramientas=S
GuardarAntes=S

[Lista.ListaEnCaptura]
(Inicio)=MFAIrTesoreria.Movimiento
MFAIrTesoreria.Movimiento=MFAIrTesoreria.Clave
MFAIrTesoreria.Clave=(Fin)
