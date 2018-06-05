[Forma]
Clave=NotificacionTrabajo
Nombre=Trabajos Notificaciones
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=313
PosicionInicialAncho=915
PosicionColumna1=47
PosicionInicialIzquierda=342
PosicionInicialArriba=254
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionCol1=362

VentanaEstadoInicial=Normal
PosicionSec1=110
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NotificacionTrabajo
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
PestanaOtroNombre=S








Pestana=S
PestanaNombre=Datos Generales
[Lista.Columnas]
Cubo=110
Nombre=371

Descripcion=604
Trabajo=330
Empresa=71
0=99
1=375
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



[Remoto.Cubo.ServidorRemoto]
Carpeta=Remoto
Clave=Cubo.ServidorRemoto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Remoto.Cubo.BaseDatosRemoto]
Carpeta=Remoto
Clave=Cubo.BaseDatosRemoto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Remoto.Cubo.CuboRemoto]
Carpeta=Remoto
Clave=Cubo.CuboRemoto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco






[Remoto.ListaEnCaptura]
(Inicio)=Cubo.ServidorRemoto
Cubo.ServidorRemoto=Cubo.BaseDatosRemoto
Cubo.BaseDatosRemoto=Cubo.CuboRemoto
Cubo.CuboRemoto=(Fin)






[Lista.NotificacionTrabajo.Nombre]
Carpeta=Lista
Clave=NotificacionTrabajo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Ficha.NotificacionTrabajo.Trabajo]
Carpeta=Ficha
Clave=NotificacionTrabajo.Trabajo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.NotificacionTrabajo.Nombre]
Carpeta=Ficha
Clave=NotificacionTrabajo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.NotificacionTrabajo.Descripcion]
Carpeta=Ficha
Clave=NotificacionTrabajo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.NotificacionTrabajo.UltimaActualizacion]
Carpeta=Ficha
Clave=NotificacionTrabajo.UltimaActualizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=57
ColorFondo=$00F0F0F0


[Ficha.NotificacionTrabajo.Activo]
Carpeta=Ficha
Clave=NotificacionTrabajo.Activo
Editar=S
3D=S
Tamano=24
ColorFondo=Blanco

LineaNueva=N


[Ficha.NotificacionTrabajo.Frecuencia]
Carpeta=Ficha
Clave=NotificacionTrabajo.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
EspacioPrevio=S



[Ficha.NotificacionTrabajo.Usuario]
Carpeta=Ficha
Clave=NotificacionTrabajo.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[Ficha.NotificacionTrabajo.Contrasena]
Carpeta=Ficha
Clave=NotificacionTrabajo.Contrasena
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Lista.NotificacionTrabajo.Trabajo]
Carpeta=Lista
Clave=NotificacionTrabajo.Trabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco














[Detalle.NotificacionTrabajoD.StoreProcedure]
Carpeta=Detalle
Clave=NotificacionTrabajoD.StoreProcedure
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.NotificacionTrabajoD.Orden]
Carpeta=Detalle
Clave=NotificacionTrabajoD.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Detalle.Columnas]
Trabajo=124
StoreProcedure=273
Orden=64





[Lista.ListaEnCaptura]
(Inicio)=NotificacionTrabajo.Trabajo
NotificacionTrabajo.Trabajo=NotificacionTrabajo.Nombre
NotificacionTrabajo.Nombre=(Fin)







[Detalle.ListaEnCaptura]
(Inicio)=NotificacionTrabajoD.StoreProcedure
NotificacionTrabajoD.StoreProcedure=NotificacionTrabajoD.Orden
NotificacionTrabajoD.Orden=(Fin)























[Acciones.Trabajo]
Nombre=Trabajo
Boton=7
NombreEnBoton=S
NombreDesplegar=Generar Trabajo
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S







EspacioPrevio=S
GuardarAntes=S
Activo=S
Expresion=ProcesarSQL(<T>EXEC spNotificacionCrearJobs :Trabajo, :BaseDatos, :Usuario<T>, NotificacionTrabajo:NotificacionTrabajo.Trabajo, BaseDatos, Usuario)<BR>ActualizarVista
[Diaria]
Estilo=Ficha
Pestana=S
Clave=Diaria
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NotificacionTrabajo
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
PestanaOtroNombre=S
PestanaNombre=Diaria

PermiteEditar=S

CondicionVisible=NotificacionTrabajo:NotificacionTrabajo.Frecuencia=<T>Diaria<T>
[Semanal]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Semanal
Clave=Semanal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NotificacionTrabajo
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









CondicionVisible=NotificacionTrabajo:NotificacionTrabajo.Frecuencia=<T>Semanal<T>
[Mensual]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Mensual
Clave=Mensual
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NotificacionTrabajo
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





CondicionVisible=NotificacionTrabajo:NotificacionTrabajo.Frecuencia=<T>Mensual<T>
[Mensual2]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Mensual 2
Clave=Mensual2
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NotificacionTrabajo
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





CondicionVisible=NotificacionTrabajo:NotificacionTrabajo.Frecuencia=<T>Mensual 2<T>
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
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

Vista=NotificacionTrabajo
ListaEnCaptura=NotificacionTrabajo.Trabajo








[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S







EspacioPrevio=S











DocNuevo=S
Carpeta=(Carpeta principal)
[Ficha.NotificacionTrabajo.spSucursal]
Carpeta=Ficha
Clave=NotificacionTrabajo.spSucursal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Pegado=S
Tamano=10
[Ficha.NotificacionTrabajo.spEmpresa]
Carpeta=Ficha
Clave=NotificacionTrabajo.spEmpresa
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

Pegado=N
LineaNueva=S
[Ficha.NotificacionTrabajo.spUsuario]
Carpeta=Ficha
Clave=NotificacionTrabajo.spUsuario
Editar=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

Pegado=S





































[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Antes=S
Visible=S















AntesExpresiones=Asigna(Info.Nombre, NotificacionTrabajo:NotificacionTrabajo.Trabajo + <T>.<T> + SQL(<T>SELECT @@SERVERNAME<T>) + <T>.<T> + BaseDatos)<BR>EjecutarSQL(<T><BR>BEGIN TRY<BR>  EXEC msdb.dbo.sp_delete_job @job_name = :tTrabajo<BR>END TRY<BR>BEGIN CATCH<BR>  IF @@ERROR > 0<BR>    RAISERROR (:tVacio, 0, 0)<BR>END CATCH<BR><T>, Info.Nombre, <T><T>)































































[Diaria.NotificacionTrabajo.Valor]
Carpeta=Diaria
Clave=NotificacionTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Diaria.NotificacionTrabajo.HoraInicial]
Carpeta=Diaria
Clave=NotificacionTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Diaria.NotificacionTrabajo.HoraFinal]
Carpeta=Diaria
Clave=NotificacionTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Diaria.NotificacionTrabajo.ValorD]
Carpeta=Diaria
Clave=NotificacionTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Diaria.NotificacionTrabajo.FrecuenciaD]
Carpeta=Diaria
Clave=NotificacionTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=16
ColorFondo=Blanco


[Semanal.NotificacionTrabajo.Recurrencia]
Carpeta=Semanal
Clave=NotificacionTrabajo.Recurrencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Semanal.NotificacionTrabajo.HoraInicial]
Carpeta=Semanal
Clave=NotificacionTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Semanal.NotificacionTrabajo.HoraFinal]
Carpeta=Semanal
Clave=NotificacionTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Semanal.NotificacionTrabajo.Domingo]
Carpeta=Semanal
Clave=NotificacionTrabajo.Domingo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=N
[Semanal.NotificacionTrabajo.Lunes]
Carpeta=Semanal
Clave=NotificacionTrabajo.Lunes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.NotificacionTrabajo.Martes]
Carpeta=Semanal
Clave=NotificacionTrabajo.Martes
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.NotificacionTrabajo.Miercoles]
Carpeta=Semanal
Clave=NotificacionTrabajo.Miercoles
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.NotificacionTrabajo.Jueves]
Carpeta=Semanal
Clave=NotificacionTrabajo.Jueves
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.NotificacionTrabajo.Viernes]
Carpeta=Semanal
Clave=NotificacionTrabajo.Viernes
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.NotificacionTrabajo.Sabado]
Carpeta=Semanal
Clave=NotificacionTrabajo.Sabado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.NotificacionTrabajo.ValorD]
Carpeta=Semanal
Clave=NotificacionTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Semanal.NotificacionTrabajo.FrecuenciaD]
Carpeta=Semanal
Clave=NotificacionTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=22
ColorFondo=Blanco


[Mensual.NotificacionTrabajo.Valor]
Carpeta=Mensual
Clave=NotificacionTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Mensual.NotificacionTrabajo.Recurrencia]
Carpeta=Mensual
Clave=NotificacionTrabajo.Recurrencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Mensual.NotificacionTrabajo.HoraInicial]
Carpeta=Mensual
Clave=NotificacionTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Mensual.NotificacionTrabajo.HoraFinal]
Carpeta=Mensual
Clave=NotificacionTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Mensual.NotificacionTrabajo.ValorD]
Carpeta=Mensual
Clave=NotificacionTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Mensual.NotificacionTrabajo.FrecuenciaD]
Carpeta=Mensual
Clave=NotificacionTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=22
ColorFondo=Blanco


[Mensual2.NotificacionTrabajo.Tipo]
Carpeta=Mensual2
Clave=NotificacionTrabajo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Mensual2.NotificacionTrabajo.Dia]
Carpeta=Mensual2
Clave=NotificacionTrabajo.Dia
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco

[Mensual2.NotificacionTrabajo.HoraInicial]
Carpeta=Mensual2
Clave=NotificacionTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

EspacioPrevio=S
[Mensual2.NotificacionTrabajo.HoraFinal]
Carpeta=Mensual2
Clave=NotificacionTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco

[Mensual2.NotificacionTrabajo.ValorD]
Carpeta=Mensual2
Clave=NotificacionTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=10
[Mensual2.NotificacionTrabajo.FrecuenciaD]
Carpeta=Mensual2
Clave=NotificacionTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco






[Diaria.ListaEnCaptura]
(Inicio)=NotificacionTrabajo.Valor
NotificacionTrabajo.Valor=NotificacionTrabajo.HoraInicial
NotificacionTrabajo.HoraInicial=NotificacionTrabajo.HoraFinal
NotificacionTrabajo.HoraFinal=NotificacionTrabajo.ValorD
NotificacionTrabajo.ValorD=NotificacionTrabajo.FrecuenciaD
NotificacionTrabajo.FrecuenciaD=(Fin)












[Semanal.ListaEnCaptura]
(Inicio)=NotificacionTrabajo.Recurrencia
NotificacionTrabajo.Recurrencia=NotificacionTrabajo.HoraInicial
NotificacionTrabajo.HoraInicial=NotificacionTrabajo.HoraFinal
NotificacionTrabajo.HoraFinal=NotificacionTrabajo.Lunes
NotificacionTrabajo.Lunes=NotificacionTrabajo.Martes
NotificacionTrabajo.Martes=NotificacionTrabajo.Miercoles
NotificacionTrabajo.Miercoles=NotificacionTrabajo.Jueves
NotificacionTrabajo.Jueves=NotificacionTrabajo.Viernes
NotificacionTrabajo.Viernes=NotificacionTrabajo.Sabado
NotificacionTrabajo.Sabado=NotificacionTrabajo.Domingo
NotificacionTrabajo.Domingo=NotificacionTrabajo.ValorD
NotificacionTrabajo.ValorD=NotificacionTrabajo.FrecuenciaD
NotificacionTrabajo.FrecuenciaD=(Fin)






[Mensual.ListaEnCaptura]
(Inicio)=NotificacionTrabajo.Valor
NotificacionTrabajo.Valor=NotificacionTrabajo.Recurrencia
NotificacionTrabajo.Recurrencia=NotificacionTrabajo.HoraInicial
NotificacionTrabajo.HoraInicial=NotificacionTrabajo.HoraFinal
NotificacionTrabajo.HoraFinal=NotificacionTrabajo.ValorD
NotificacionTrabajo.ValorD=NotificacionTrabajo.FrecuenciaD
NotificacionTrabajo.FrecuenciaD=(Fin)










































[Mensual2.ListaEnCaptura]
(Inicio)=NotificacionTrabajo.Tipo
NotificacionTrabajo.Tipo=NotificacionTrabajo.Dia
NotificacionTrabajo.Dia=NotificacionTrabajo.HoraInicial
NotificacionTrabajo.HoraInicial=NotificacionTrabajo.HoraFinal
NotificacionTrabajo.HoraFinal=NotificacionTrabajo.ValorD
NotificacionTrabajo.ValorD=NotificacionTrabajo.FrecuenciaD
NotificacionTrabajo.FrecuenciaD=(Fin)




















[Ficha.NotificacionTrabajo.Procesar]
Carpeta=Ficha
Clave=NotificacionTrabajo.Procesar
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S








[Ficha.ListaEnCaptura]
(Inicio)=NotificacionTrabajo.spEmpresa
NotificacionTrabajo.spEmpresa=NotificacionTrabajo.spSucursal
NotificacionTrabajo.spSucursal=NotificacionTrabajo.spUsuario
NotificacionTrabajo.spUsuario=NotificacionTrabajo.Trabajo
NotificacionTrabajo.Trabajo=NotificacionTrabajo.Nombre
NotificacionTrabajo.Nombre=NotificacionTrabajo.Descripcion
NotificacionTrabajo.Descripcion=NotificacionTrabajo.UltimaActualizacion
NotificacionTrabajo.UltimaActualizacion=NotificacionTrabajo.Procesar
NotificacionTrabajo.Procesar=NotificacionTrabajo.Activo
NotificacionTrabajo.Activo=NotificacionTrabajo.Frecuencia
NotificacionTrabajo.Frecuencia=NotificacionTrabajo.Usuario
NotificacionTrabajo.Usuario=NotificacionTrabajo.Contrasena
NotificacionTrabajo.Contrasena=(Fin)















[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Diaria
Diaria=Semanal
Semanal=Mensual
Mensual=Mensual2
Mensual2=Lista
Lista=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Trabajo
Trabajo=(Fin)
