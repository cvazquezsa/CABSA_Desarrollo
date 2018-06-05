[Forma]
Clave=AutoMantServ
Nombre=Mantenimiento Preventivo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=238
PosicionInicialArriba=165
PosicionInicialAlturaCliente=404
PosicionInicialAncho=547
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Mantenimiento

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AutoMantServ
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
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
FiltroAplicaEn=AutoMantServ.Tipo
FiltroAutoCampo=AutoMantServ.Tipo
FiltroAutoValidar=AutoMantServ.Tipo
FiltroEstilo=Folder (1 línea)
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=AutoMantServ.Kms<TAB>(Acendente)
FiltroGeneral=AutoMantServ.Mantenimiento=<T>{Info.Mantenimiento}<T>

[Lista.AutoMantServ.Kms]
Carpeta=Lista
Clave=AutoMantServ.Kms
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoMantServ.Tiempo]
Carpeta=Lista
Clave=AutoMantServ.Tiempo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoMantServ.Unidad]
Carpeta=Lista
Clave=AutoMantServ.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoMantServ.Tipo]
Carpeta=Lista
Clave=AutoMantServ.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Tipo=77
Kms=82
Tiempo=40
Unidad=62
Tolerancia=69
Servicio=180
Dias=64

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

[Acciones.AutoMantServD]
Nombre=AutoMantServD
Boton=47
NombreEnBoton=S
NombreDesplegar=&Artículos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AutoMantServD
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(AutoMantServ:AutoMantServ.Servicio)
AntesExpresiones=Asigna(Info.Servicio, AutoMantServ:AutoMantServ.Servicio)

[Lista.AutoMantServ.Servicio]
Carpeta=Lista
Clave=AutoMantServ.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoMantServ.Dias]
Carpeta=Lista
Clave=AutoMantServ.Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=AutoMantServD
AutoMantServD=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AutoMantServ.Servicio
AutoMantServ.Servicio=AutoMantServ.Tipo
AutoMantServ.Tipo=AutoMantServ.Kms
AutoMantServ.Kms=AutoMantServ.Tiempo
AutoMantServ.Tiempo=AutoMantServ.Unidad
AutoMantServ.Unidad=AutoMantServ.Dias
AutoMantServ.Dias=(Fin)
