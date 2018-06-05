
[Forma]
Clave=NotificacionClave
Icono=0
Modulos=(Todos)
MovModulo=NotificacionClave
Nombre=Claves de Notificación

ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=613
PosicionInicialAncho=737
PosicionCol1=398
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=8
PosicionInicialArriba=30
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NotificacionClave
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
[Lista.NotificacionClave.Descripcion]
Carpeta=Lista
Clave=NotificacionClave.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalle
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NotificacionClave
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Detalle.NotificacionClave.MedioComunicacion]
Carpeta=Detalle
Clave=NotificacionClave.MedioComunicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[Detalle.NotificacionClave.TipoFechaNotificacion]
Carpeta=Detalle
Clave=NotificacionClave.TipoFechaNotificacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.NotificacionClave.FechaNotificacion]
Carpeta=Detalle
Clave=NotificacionClave.FechaNotificacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S
[Detalle.NotificacionClave.AnticipacionFecha]
Carpeta=Detalle
Clave=NotificacionClave.AnticipacionFecha
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=N

[Lista.Columnas]
0=74
1=209



2=99
Clave=84
Descripcion=211
Frecuencia=70

[Lista.NotificacionClave.Frecuencia]
Carpeta=Lista
Clave=NotificacionClave.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








[Semanal]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Frecuencia
Clave=Semanal
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NotificacionClave
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


CondicionVisible=NotificacionClave:NotificacionClave.Frecuencia = <T>(Semanal)<T>
[Semanal.NotificacionClave.Lunes]
Carpeta=Semanal
Clave=NotificacionClave.Lunes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Semanal.NotificacionClave.Martes]
Carpeta=Semanal
Clave=NotificacionClave.Martes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Semanal.NotificacionClave.Miercoles]
Carpeta=Semanal
Clave=NotificacionClave.Miercoles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Semanal.NotificacionClave.Jueves]
Carpeta=Semanal
Clave=NotificacionClave.Jueves
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Semanal.NotificacionClave.Viernes]
Carpeta=Semanal
Clave=NotificacionClave.Viernes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Semanal.NotificacionClave.Sabado]
Carpeta=Semanal
Clave=NotificacionClave.Sabado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Semanal.NotificacionClave.Domingo]
Carpeta=Semanal
Clave=NotificacionClave.Domingo
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco







[MensualoMayor]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Frecuencia
Clave=MensualoMayor
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NotificacionClave
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)


CondicionVisible=(NotificacionClave:NotificacionClave.Frecuencia <> <T>(Diaria)<T>) y (NotificacionClave:NotificacionClave.Frecuencia <> <T>(Semanal)<T>)
[MensualoMayor.NotificacionClave.DiaMes]
Carpeta=MensualoMayor
Clave=NotificacionClave.DiaMes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MensualoMayor.NotificacionClave.FechaInicio]
Carpeta=MensualoMayor
Clave=NotificacionClave.FechaInicio
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Semanal.ListaEnCaptura]
(Inicio)=NotificacionClave.Lunes
NotificacionClave.Lunes=NotificacionClave.Martes
NotificacionClave.Martes=NotificacionClave.Miercoles
NotificacionClave.Miercoles=NotificacionClave.Jueves
NotificacionClave.Jueves=NotificacionClave.Viernes
NotificacionClave.Viernes=NotificacionClave.Sabado
NotificacionClave.Sabado=NotificacionClave.Domingo
NotificacionClave.Domingo=(Fin)

[MensualoMayor.ListaEnCaptura]
(Inicio)=NotificacionClave.DiaMes
NotificacionClave.DiaMes=NotificacionClave.FechaInicio
NotificacionClave.FechaInicio=(Fin)




















[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S






[Acciones.Destinatario]
Nombre=Destinatario
Boton=84
NombreEnBoton=S
NombreDesplegar=&Destinatarios
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NotificacionClaveDestinatario
Activo=S
Visible=S

EspacioPrevio=S


Antes=S
























AntesExpresiones=Asigna(Info.NotificacionClave,NotificacionClave:NotificacionClave.Clave)
[Lista.ListaEnCaptura]
(Inicio)=NotificacionClave.Clave
NotificacionClave.Clave=NotificacionClave.Descripcion
NotificacionClave.Descripcion=NotificacionClave.Frecuencia
NotificacionClave.Frecuencia=(Fin)

[Lista.NotificacionClave.Clave]
Carpeta=Lista
Clave=NotificacionClave.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco











[Acciones.Modulo]
Nombre=Modulo
Boton=16
NombreEnBoton=S
NombreDesplegar=&Modulos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NotificacionClaveMOdulo
Activo=S
Antes=S
Visible=S



















AntesExpresiones=Asigna(Info.NotificacionClave,NotificacionClave:NotificacionClave.Clave)
[Acciones.Consulta]
Nombre=Consulta
Boton=75
NombreEnBoton=S
NombreDesplegar=&Consulta
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NotificacionClaveConsulta
Activo=S
Antes=S
Visible=S













EspacioPrevio=S













AntesExpresiones=Asigna(Info.NotificacionClave,NotificacionClave:NotificacionClave.Clave)
[Acciones.Parametro]
Nombre=Parametro
Boton=93
NombreEnBoton=S
NombreDesplegar=&Parámetros
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NotificacionClaveParam
Activo=S
Antes=S
Visible=S













AntesExpresiones=Asigna(Info.NotificacionClave,NotificacionClave:NotificacionClave.Clave)
[Acciones.Filtro]
Nombre=Filtro
Boton=107
NombreEnBoton=S
NombreDesplegar=&Filtros
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NotificacionClaveFiltro
Activo=S
Antes=S
Visible=S





















AntesExpresiones=Asigna(Info.NotificacionClave,NotificacionClave:NotificacionClave.Clave)




























[Detalle.NotificacionClave.AnticipacionFechaTipo]
Carpeta=Detalle
Clave=NotificacionClave.AnticipacionFechaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Detalle.NotificacionClave.Asunto]
Carpeta=Detalle
Clave=NotificacionClave.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=41
ColorFondo=Blanco

[Detalle.NotificacionClave.Mensaje]
Carpeta=Detalle
Clave=NotificacionClave.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41x5
ColorFondo=Blanco



[Detalle.ListaEnCaptura]
(Inicio)=NotificacionClave.Clave
NotificacionClave.Clave=NotificacionClave.Descripcion
NotificacionClave.Descripcion=NotificacionClave.MedioComunicacion
NotificacionClave.MedioComunicacion=NotificacionClave.TipoFechaNotificacion
NotificacionClave.TipoFechaNotificacion=NotificacionClave.AnticipacionFechaTipo
NotificacionClave.AnticipacionFechaTipo=NotificacionClave.AnticipacionFecha
NotificacionClave.AnticipacionFecha=NotificacionClave.FechaNotificacion
NotificacionClave.FechaNotificacion=NotificacionClave.Frecuencia
NotificacionClave.Frecuencia=NotificacionClave.Asunto
NotificacionClave.Asunto=NotificacionClave.Mensaje
NotificacionClave.Mensaje=(Fin)

[Detalle.NotificacionClave.Clave]
Carpeta=Detalle
Clave=NotificacionClave.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Detalle.NotificacionClave.Descripcion]
Carpeta=Detalle
Clave=NotificacionClave.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41x3
ColorFondo=Blanco

[Detalle.NotificacionClave.Frecuencia]
Carpeta=Detalle
Clave=NotificacionClave.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco





















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=Semanal
Semanal=MensualoMayor
MensualoMayor=(Fin)

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Destinatario
Destinatario=Modulo
Modulo=Filtro
Filtro=Parametro
Parametro=Consulta
Consulta=(Fin)
