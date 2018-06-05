[Forma]
Clave=PersonalEntrada
Nombre=Horario Entrada
Icono=0
Modulos=(Todos)
MovModulo=Entrada
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=525
PosicionInicialArriba=189
PosicionInicialAlturaCliente=618
PosicionInicialAncho=229
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Personal
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalEntrada
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
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=PersonalEntrada.Fecha
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=PersonalEntrada.Personal=<T>{Info.Personal}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.PersonalEntrada.Fecha]
Carpeta=Lista
Clave=PersonalEntrada.Fecha
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
Editar=S

[Lista.PersonalEntrada.Hora]
Carpeta=Lista
Clave=PersonalEntrada.Hora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Fecha=149
Hora=50

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

[Lista.ListaEnCaptura]
(Inicio)=PersonalEntrada.Fecha
PersonalEntrada.Fecha=PersonalEntrada.Hora
PersonalEntrada.Hora=(Fin)
