[Forma]
Clave=TablaComisionEspD
Nombre=<T>Tabla - <T>+Info.Tipo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Tabla
PosicionInicialIzquierda=334
PosicionInicialArriba=230
PosicionInicialAlturaCliente=273
PosicionInicialAncho=356
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaComisionEspD
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=TablaComisionEspD.TablaComisionEsp=<T>{Info.Tabla}<T>

[Lista.TablaComisionEspD.Desde]
Carpeta=Lista
Clave=TablaComisionEspD.Desde
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaComisionEspD.Hasta]
Carpeta=Lista
Clave=TablaComisionEspD.Hasta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaComisionEspD.Importe]
Carpeta=Lista
Clave=TablaComisionEspD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaComisionEspD.Porcentaje]
Carpeta=Lista
Clave=TablaComisionEspD.Porcentaje
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
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Lista.Columnas]
Desde=66
Hasta=67
Importe=87
Porcentaje=57
Importe2=103

[Lista.TablaComisionEspD.Importe2]
Carpeta=Lista
Clave=TablaComisionEspD.Importe2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=TablaComisionEspD.Desde
TablaComisionEspD.Desde=TablaComisionEspD.Hasta
TablaComisionEspD.Hasta=TablaComisionEspD.Porcentaje
TablaComisionEspD.Porcentaje=TablaComisionEspD.Importe
TablaComisionEspD.Importe=TablaComisionEspD.Importe2
TablaComisionEspD.Importe2=(Fin)
