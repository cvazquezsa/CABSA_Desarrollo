[Forma]
Clave=ServicioMatrizBase
Nombre=Matriz de Servicios
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=284
PosicionInicialArriba=249
PosicionInicialAlturaCliente=491
PosicionInicialAncho=711
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ServicioMatrizBase
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
FiltroGrupo1=ServicioMatrizBase.Vehiculo
FiltroGrupo2=ServicioMatrizBase.Modelo
FiltroGrupo3=ServicioMatrizBase.Motor
FiltroGrupo4=ServicioMatrizBase.Cilindros
FiltroGrupo5=ServicioMatrizBase.Transmision
FiltroGrupo6=ServicioMatrizBase.Traccion
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=30
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
HojaMantenerSeleccion=S

[Lista.ServicioMatrizBase.Vehiculo]
Carpeta=Lista
Clave=ServicioMatrizBase.Vehiculo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioMatrizBase.Modelo]
Carpeta=Lista
Clave=ServicioMatrizBase.Modelo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioMatrizBase.Motor]
Carpeta=Lista
Clave=ServicioMatrizBase.Motor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioMatrizBase.Cilindros]
Carpeta=Lista
Clave=ServicioMatrizBase.Cilindros
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioMatrizBase.Transmision]
Carpeta=Lista
Clave=ServicioMatrizBase.Transmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ServicioMatrizBase.Traccion]
Carpeta=Lista
Clave=ServicioMatrizBase.Traccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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
Vehiculo=177
Modelo=47
Motor=37
Cilindros=46
Transmision=90
Traccion=63

[Acciones.Servicios]
Nombre=Servicios
Boton=47
NombreEnBoton=S
NombreDesplegar=&Servicios
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ServicioMatriz
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(ServicioMatrizBase:ServicioMatrizBase.Vehiculo) y<BR>ConDatos(ServicioMatrizBase:ServicioMatrizBase.Modelo) y<BR>ConDatos(ServicioMatrizBase:ServicioMatrizBase.Motor) y<BR>ConDatos(ServicioMatrizBase:ServicioMatrizBase.Cilindros) y<BR>ConDatos(ServicioMatrizBase:ServicioMatrizBase.Transmision) y<BR>ConDatos(ServicioMatrizBase:ServicioMatrizBase.Traccion)
AntesExpresiones=Asigna(Servicio.Vehiculo, ServicioMatrizBase:ServicioMatrizBase.Vehiculo)<BR>Asigna(Servicio.Modelo, ServicioMatrizBase:ServicioMatrizBase.Modelo)<BR>Asigna(Servicio.Motor, ServicioMatrizBase:ServicioMatrizBase.Motor)<BR>Asigna(Servicio.Cilindros, ServicioMatrizBase:ServicioMatrizBase.Cilindros)<BR>Asigna(Servicio.Transmision, ServicioMatrizBase:ServicioMatrizBase.Transmision)<BR>Asigna(Servicio.Traccion, ServicioMatrizBase:ServicioMatrizBase.Traccion)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Servicios
Servicios=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ServicioMatrizBase.Vehiculo
ServicioMatrizBase.Vehiculo=ServicioMatrizBase.Modelo
ServicioMatrizBase.Modelo=ServicioMatrizBase.Motor
ServicioMatrizBase.Motor=ServicioMatrizBase.Cilindros
ServicioMatrizBase.Cilindros=ServicioMatrizBase.Transmision
ServicioMatrizBase.Transmision=ServicioMatrizBase.Traccion
ServicioMatrizBase.Traccion=(Fin)
