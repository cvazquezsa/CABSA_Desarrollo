
[Forma]
Clave=Notificacion
Icono=0
Modulos=(Todos)
MovModulo=Notificacion
Nombre=Notificaciones

ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=565
PosicionInicialAncho=1055
PosicionCol1=534
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=155
PosicionInicialArriba=62
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Notificacion
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
Vista=Notificacion
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

PermiteEditar=S
CondicionEdicion=Si SQL(<T>SELECT ISNULL((SELECT COUNT(*) FROM Notificacion),0)<T>) > 0 Entonces<BR>  Verdadero<BR>Sino<BR>  Falso<BR>Fin
[Detalle.Notificacion.MedioComunicacion]
Carpeta=Detalle
Clave=Notificacion.MedioComunicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Detalle.Notificacion.TipoFechaNotificacion]
Carpeta=Detalle
Clave=Notificacion.TipoFechaNotificacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Detalle.Notificacion.FechaNotificacion]
Carpeta=Detalle
Clave=Notificacion.FechaNotificacion
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

LineaNueva=S
[Detalle.Notificacion.AnticipacionFecha]
Carpeta=Detalle
Clave=Notificacion.AnticipacionFecha
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

LineaNueva=N

[Lista.Columnas]
0=179
1=503



2=99
Clave=187
Descripcion=211
Frecuencia=70
Notificacion=313


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
Vista=Notificacion
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


PermiteEditar=S
CondicionVisible=Notificacion:Notificacion.Frecuencia = <T>(Semanal)<T>
[Semanal.Notificacion.Lunes]
Carpeta=Semanal
Clave=Notificacion.Lunes
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco

[Semanal.Notificacion.Martes]
Carpeta=Semanal
Clave=Notificacion.Martes
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco

[Semanal.Notificacion.Miercoles]
Carpeta=Semanal
Clave=Notificacion.Miercoles
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco

[Semanal.Notificacion.Jueves]
Carpeta=Semanal
Clave=Notificacion.Jueves
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco

[Semanal.Notificacion.Viernes]
Carpeta=Semanal
Clave=Notificacion.Viernes
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco

[Semanal.Notificacion.Sabado]
Carpeta=Semanal
Clave=Notificacion.Sabado
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco

[Semanal.Notificacion.Domingo]
Carpeta=Semanal
Clave=Notificacion.Domingo
Editar=S
LineaNueva=S
3D=S
Tamano=40
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
Vista=Notificacion
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


PermiteEditar=S
CondicionVisible=(Notificacion:Notificacion.Frecuencia <> <T>(Diaria)<T>) y (Notificacion:Notificacion.Frecuencia <> <T>(Semanal)<T>)
[MensualoMayor.Notificacion.DiaMes]
Carpeta=MensualoMayor
Clave=Notificacion.DiaMes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[MensualoMayor.Notificacion.FechaInicio]
Carpeta=MensualoMayor
Clave=Notificacion.FechaInicio
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco




[Acciones.Destinatario]
Nombre=Destinatario
Boton=84
NombreEnBoton=S
NombreDesplegar=&Destinatarios
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NotificacionDestinatario
Activo=S
Visible=S

EspacioPrevio=S


Antes=S



























AntesExpresiones=Asigna(Info.Notificacion,Notificacion:Notificacion.Notificacion)
[Acciones.Consulta]
Nombre=Consulta
Boton=74
NombreEnBoton=S
NombreDesplegar=&Etiquetas Usuario
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NotificacionConsulta
Activo=S
Antes=S
Visible=S













EspacioPrevio=S













AntesExpresiones=Asigna(Info.Notificacion,Notificacion:Notificacion.Notificacion)
[Acciones.Parametro]
Nombre=Parametro
Boton=93
NombreEnBoton=S
NombreDesplegar=&Parámetros
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NotificacionParam
Antes=S
Visible=S













ActivoCondicion=Si SQL(<T>IF EXISTS(SELECT 1 FROM NotificacionParam WHERE Notificacion = :tNotificacion) SELECT 1 ELSE SELECT 0<T>,Notificacion:Notificacion.Notificacion) = 1 Entonces<BR>  Verdadero<BR>Sino<BR>  Falso<BR>Fin
AntesExpresiones=Asigna(Info.Notificacion,Notificacion:Notificacion.Notificacion)
[Acciones.Filtro]
Nombre=Filtro
Boton=107
NombreEnBoton=S
NombreDesplegar=&Filtros
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NotificacionFiltro
Activo=S
Antes=S
Visible=S




















AntesExpresiones=Asigna(Info.Notificacion,Notificacion:Notificacion.Notificacion)

[Lista.Notificacion.Notificacion]
Carpeta=Lista
Clave=Notificacion.Notificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





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






[Detalle.Notificacion.Asunto]
Carpeta=Detalle
Clave=Notificacion.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=47
ColorFondo=Blanco

EspacioPrevio=S

[Detalle.Notificacion.Notificacion]
Carpeta=Detalle
Clave=Notificacion.Notificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=47
ColorFondo=Blanco

[Detalle.Notificacion.Clave]
Carpeta=Detalle
Clave=Notificacion.Clave
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

LineaNueva=S
[Detalle.Notificacion.Descripcion]
Carpeta=Detalle
Clave=Notificacion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=47x4
ColorFondo=Blanco















[Detalle.Notificacion.Frecuencia]
Carpeta=Detalle
Clave=Notificacion.Frecuencia
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

































[Acciones.Nueva]
Nombre=Nueva
Boton=1
NombreDesplegar=&Nueva
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S




























































































Expresion=SI FormaModal(<T>NotificacionNueva<T>) = Verdadero Entonces<BR>  EJECUTARSQL(<T>EXEC spNotificacionNueva :nEstacion, :tNotificacion, :tClave<T>,EstacionTrabajo, Info.Nombre, Info.NotificacionClave)<BR>  ActualizarForma<BR>Fin
[Acciones.Vigencia]
Nombre=Vigencia
Boton=53
NombreDesplegar=&Vigencia
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NotificacionVigencia
Activo=S
Antes=S
Visible=S

EspacioPrevio=S


















































AntesExpresiones=Asigna(Info.Notificacion,Notificacion:Notificacion.Notificacion)<BR>EJECUTARSQL(<T>EXEC spNotificacionCargarVigencia :nEstacion, :tNotificacion<T>,EstacionTrabajo,Info.Notificacion)
[Acciones.Copiar]
Nombre=Copiar
Boton=65
NombreDesplegar=&Copiar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S





































Expresion=SI FormaModal(<T>NotificacionCopiar<T>) = Verdadero Entonces<BR>  EJECUTARSQL(<T>EXEC spNotificacionCopiar :nEstacion, :tNotificacion, :tNotificacionNueva<T>,EstacionTrabajo, Info.NotificacionLista, Info.Notificacion)<BR>  ActualizarForma<BR>Fin
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
TipoAccion=Expresion
Activo=S
Visible=S





















Expresion=EJECUTARSQL(<T>EXEC spNotificacionEliminar :nEstacion, :tNotificacion<T>,EstacionTrabajo, Notificacion:Notificacion.Notificacion)<BR>ActualizarForma
[Acciones.Ayuda]
Nombre=Ayuda
Boton=101
NombreEnBoton=S
NombreDesplegar=&Ayuda Etiquetas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NotificacionTagAyuda
Activo=S
Visible=S










Antes=S
AntesExpresiones=Asigna(Info.Notificacion,Notificacion:Notificacion.Notificacion)
[Detalle.Notificacion.Estatus]
Carpeta=Detalle
Clave=Notificacion.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=47
ColorFondo=Blanco




















[Detalle.Notificacion.AnticipacionFechaTipo]
Carpeta=Detalle
Clave=Notificacion.AnticipacionFechaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco



















































[Acciones.Condicion]
Nombre=Condicion
Boton=94
NombreEnBoton=S
NombreDesplegar=&Condicion Usuario
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NotificacionCondicion
Activo=S
Antes=S
Visible=S











EspacioPrevio=S
AntesExpresiones=Asigna(Info.Notificacion,Notificacion:Notificacion.Notificacion)
[Lista.ListaEnCaptura]
(Inicio)=Notificacion.Notificacion
Notificacion.Notificacion=Notificacion.Clave
Notificacion.Clave=(Fin)

[Lista.Notificacion.Clave]
Carpeta=Lista
Clave=Notificacion.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco











































































[Acciones.VigenciaHora]
Nombre=VigenciaHora
Boton=76
NombreDesplegar=&Vigencia Horaria
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NotificacionVigenciaHora
Activo=S
Visible=S













Antes=S
AntesExpresiones=Asigna(Info.Notificacion,Notificacion:Notificacion.Notificacion)<BR>EJECUTARSQL(<T>EXEC spNotificacionCargarVigenciaHora :nEstacion, :tNotificacion<T>,EstacionTrabajo,Info.Notificacion)






































[Acciones.Mensaje]
Nombre=Mensaje
Boton=58
NombreDesplegar=&Mensaje
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NotificacionMensaje
Activo=S
Visible=S





Antes=S










NombreEnBoton=S




AntesExpresiones=Asigna(Info.Notificacion,Notificacion:Notificacion.Notificacion)












[MensualoMayor.ListaEnCaptura]
(Inicio)=Notificacion.DiaMes
Notificacion.DiaMes=Notificacion.FechaInicio
Notificacion.FechaInicio=(Fin)













[Semanal.ListaEnCaptura]
(Inicio)=Notificacion.Lunes
Notificacion.Lunes=Notificacion.Martes
Notificacion.Martes=Notificacion.Miercoles
Notificacion.Miercoles=Notificacion.Jueves
Notificacion.Jueves=Notificacion.Viernes
Notificacion.Viernes=Notificacion.Sabado
Notificacion.Sabado=Notificacion.Domingo
Notificacion.Domingo=(Fin)







[Detalle.ListaEnCaptura]
(Inicio)=Notificacion.Notificacion
Notificacion.Notificacion=Notificacion.Clave
Notificacion.Clave=Notificacion.Frecuencia
Notificacion.Frecuencia=Notificacion.Descripcion
Notificacion.Descripcion=Notificacion.MedioComunicacion
Notificacion.MedioComunicacion=Notificacion.TipoFechaNotificacion
Notificacion.TipoFechaNotificacion=Notificacion.AnticipacionFechaTipo
Notificacion.AnticipacionFechaTipo=Notificacion.AnticipacionFecha
Notificacion.AnticipacionFecha=Notificacion.FechaNotificacion
Notificacion.FechaNotificacion=Notificacion.Asunto
Notificacion.Asunto=Notificacion.Estatus
Notificacion.Estatus=(Fin)























[Acciones.Anexo]
Nombre=Anexo
Boton=77
NombreEnBoton=S
NombreDesplegar=Anexos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NotificacionAnexo
Activo=S
Visible=S



EspacioPrevio=S






















Antes=S
















































AntesExpresiones=Asigna(Info.Notificacion,Notificacion:Notificacion.Notificacion)














[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=Semanal
Semanal=MensualoMayor
MensualoMayor=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nueva
Nueva=Copiar
Copiar=Eliminar
Eliminar=Mensaje
Mensaje=Destinatario
Destinatario=Filtro
Filtro=Vigencia
Vigencia=VigenciaHora
VigenciaHora=Parametro
Parametro=Consulta
Consulta=Condicion
Condicion=Anexo
Anexo=Ayuda
Ayuda=(Fin)
