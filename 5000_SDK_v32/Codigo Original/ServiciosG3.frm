
[Forma]
Clave=ServiciosG3
Icono=0
Modulos=(Todos)
Nombre=Servicios G3

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=171
PosicionInicialArriba=121
PosicionInicialAlturaCliente=447
PosicionInicialAncho=1023
PosicionCol1=394
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionSec1=176
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ServiciosG3
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

Filtros=S
FiltroPredefinido=S
FiltroGrupo1=ServiciosG3.Modulo
FiltroValida1=ServiciosG3.Modulo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo2=ServiciosG3.Servicio
FiltroValida2=ServiciosG3.Servicio
FiltroTodo=S

ListaEnCaptura=ServiciosG3.Servicio
[Encabezado]
Estilo=Ficha
Clave=Encabezado
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ServiciosG3
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Encabezado.ServiciosG3.Servicio]
Carpeta=Encabezado
Clave=ServiciosG3.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Encabezado.ServiciosG3.Modulo]
Carpeta=Encabezado
Clave=ServiciosG3.Modulo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

Pegado=S
[Encabezado.ServiciosG3.Estatus]
Carpeta=Encabezado
Clave=ServiciosG3.Estatus
Editar=S
LineaNueva=N
3D=S
Tamano=10
ColorFondo=Blanco








[Lista.Columnas]
Servicio=216



ID=34
NombreCSV=354

[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=ServiciosG3Detalle
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=ServiciosG3
LlaveLocal=ServiciosG3Detalle.ID
LlaveMaestra=ServiciosG3.ID
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

[Detalle.ServiciosG3Detalle.IdArchivosCSV]
Carpeta=Detalle
Clave=ServiciosG3Detalle.IdArchivosCSV
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.NominaG4CFG.NombreCSV]
Carpeta=Detalle
Clave=NominaG4CFG.NombreCSV
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=200
ColorFondo=Plata

Efectos=[Negritas]
[Detalle.ServiciosG3Detalle.Estatus]
Carpeta=Detalle
Clave=ServiciosG3Detalle.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Detalle.Columnas]
IdArchivosCSV=74
NombreCSV=370
Estatus=64


[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S



NombreEnBoton=S
Carpeta=Encabezado























[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
























[Lista.ServiciosG3.Servicio]
Carpeta=Lista
Clave=ServiciosG3.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco









[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S














































[Detalle.ListaEnCaptura]
(Inicio)=ServiciosG3Detalle.IdArchivosCSV
ServiciosG3Detalle.IdArchivosCSV=NominaG4CFG.NombreCSV
NominaG4CFG.NombreCSV=ServiciosG3Detalle.Estatus
ServiciosG3Detalle.Estatus=(Fin)
























[Encabezado.ServiciosG3.URL]
Carpeta=Encabezado
Clave=ServiciosG3.URL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68
ColorFondo=Blanco

[Encabezado.ServiciosG3.API]
Carpeta=Encabezado
Clave=ServiciosG3.API
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68
ColorFondo=Blanco

[Encabezado.ServiciosG3.DirectorioObjetosEspeciales]
Carpeta=Encabezado
Clave=ServiciosG3.DirectorioObjetosEspeciales
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68
ColorFondo=Blanco

[Encabezado.ServiciosG3.DirectorioArchivosZip]
Carpeta=Encabezado
Clave=ServiciosG3.DirectorioArchivosZip
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=68
ColorFondo=Blanco

[Encabezado.ServiciosG3.Debug]
Carpeta=Encabezado
Clave=ServiciosG3.Debug
Editar=S
LineaNueva=S
3D=S
Tamano=10
ColorFondo=Blanco





















[Encabezado.ListaEnCaptura]
(Inicio)=ServiciosG3.Servicio
ServiciosG3.Servicio=ServiciosG3.Modulo
ServiciosG3.Modulo=ServiciosG3.URL
ServiciosG3.URL=ServiciosG3.API
ServiciosG3.API=ServiciosG3.DirectorioObjetosEspeciales
ServiciosG3.DirectorioObjetosEspeciales=ServiciosG3.DirectorioArchivosZip
ServiciosG3.DirectorioArchivosZip=ServiciosG3.Debug
ServiciosG3.Debug=ServiciosG3.Estatus
ServiciosG3.Estatus=(Fin)



























[Acciones.Preconfigurado]
Nombre=Preconfigurado
Boton=93
NombreEnBoton=S
NombreDesplegar=Cargar Preconfigurado
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S









































































Expresion=SI Precaucion(<T>¿ Esta seguro que desea cargar el Preconfigurado ?<T>+NuevaLinea+NuevaLinea+<T>Esta acción puede borrar configuración previamente realizada. <T>, BotonSi, BotonNo ) = BotonSi<BR>   Entonces<BR>     ProcesarSQL(<T>EXEC spNominaG4CargaDatos :tEmpre<T>, Empresa)<BR>   FIN
Activo=S








[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Encabezado
Encabezado=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Guardar
Guardar=Navegador
Navegador=Preconfigurado
Preconfigurado=(Fin)
