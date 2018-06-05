

[Forma]
Clave=WMSSurtidoTrabajo
Nombre=Trabajos Explosiones de Surtido
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=313
PosicionInicialAncho=915
PosicionColumna1=47
PosicionInicialIzquierda=204
PosicionInicialArriba=187
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
Vista=WMSSurtidoTrabajo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=$00F0F0F0
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






[Lista.WMSSurtidoTrabajo.Nombre]
Carpeta=Lista
Clave=WMSSurtidoTrabajo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Ficha.WMSSurtidoTrabajo.Trabajo]
Carpeta=Ficha
Clave=WMSSurtidoTrabajo.Trabajo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.WMSSurtidoTrabajo.Nombre]
Carpeta=Ficha
Clave=WMSSurtidoTrabajo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.WMSSurtidoTrabajo.Descripcion]
Carpeta=Ficha
Clave=WMSSurtidoTrabajo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.WMSSurtidoTrabajo.UltimaActualizacion]
Carpeta=Ficha
Clave=WMSSurtidoTrabajo.UltimaActualizacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=57
ColorFondo=$00F0F0F0


[Ficha.WMSSurtidoTrabajo.Activo]
Carpeta=Ficha
Clave=WMSSurtidoTrabajo.Activo
Editar=S
3D=S
Tamano=24
ColorFondo=Blanco

LineaNueva=N


[Ficha.WMSSurtidoTrabajo.Frecuencia]
Carpeta=Ficha
Clave=WMSSurtidoTrabajo.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
EspacioPrevio=S



[Ficha.WMSSurtidoTrabajo.Usuario]
Carpeta=Ficha
Clave=WMSSurtidoTrabajo.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[Ficha.WMSSurtidoTrabajo.Contrasena]
Carpeta=Ficha
Clave=WMSSurtidoTrabajo.Contrasena
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Lista.WMSSurtidoTrabajo.Trabajo]
Carpeta=Lista
Clave=WMSSurtidoTrabajo.Trabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco














[Detalle.WMSSurtidoTrabajoD.StoreProcedure]
Carpeta=Detalle
Clave=WMSSurtidoTrabajoD.StoreProcedure
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.WMSSurtidoTrabajoD.Orden]
Carpeta=Detalle
Clave=WMSSurtidoTrabajoD.Orden
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
(Inicio)=WMSSurtidoTrabajo.Trabajo
WMSSurtidoTrabajo.Trabajo=WMSSurtidoTrabajo.Nombre
WMSSurtidoTrabajo.Nombre=(Fin)







[Detalle.ListaEnCaptura]
(Inicio)=WMSSurtidoTrabajoD.StoreProcedure
WMSSurtidoTrabajoD.StoreProcedure=WMSSurtidoTrabajoD.Orden
WMSSurtidoTrabajoD.Orden=(Fin)























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
Expresion=ProcesarSQL(<T>EXEC spWMSSurtidoCrearJobs :Trabajo, :BaseDatos, :Usuario<T>, WMSSurtidoTrabajo:WMSSurtidoTrabajo.Trabajo, BaseDatos, Usuario)<BR>ActualizarVista
[Diaria]
Estilo=Ficha
Pestana=S
Clave=Diaria
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=WMSSurtidoTrabajo
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

CondicionVisible=WMSSurtidoTrabajo:WMSSurtidoTrabajo.Frecuencia=<T>Diaria<T>
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
Vista=WMSSurtidoTrabajo
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









CondicionVisible=WMSSurtidoTrabajo:WMSSurtidoTrabajo.Frecuencia=<T>Semanal<T>
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
Vista=WMSSurtidoTrabajo
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





CondicionVisible=WMSSurtidoTrabajo:WMSSurtidoTrabajo.Frecuencia=<T>Mensual<T>
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
Vista=WMSSurtidoTrabajo
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





CondicionVisible=WMSSurtidoTrabajo:WMSSurtidoTrabajo.Frecuencia=<T>Mensual 2<T>
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

Vista=WMSSurtidoTrabajo
ListaEnCaptura=WMSSurtidoTrabajo.Trabajo








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
[Ficha.WMSSurtidoTrabajo.spSucursal]
Carpeta=Ficha
Clave=WMSSurtidoTrabajo.spSucursal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Pegado=S
Tamano=10
[Ficha.WMSSurtidoTrabajo.spEmpresa]
Carpeta=Ficha
Clave=WMSSurtidoTrabajo.spEmpresa
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

Pegado=N
LineaNueva=S
[Ficha.WMSSurtidoTrabajo.spUsuario]
Carpeta=Ficha
Clave=WMSSurtidoTrabajo.spUsuario
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
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Antes=S
Visible=S














































































AntesExpresiones=Asigna(Info.Nombre, WMSSurtidoTrabajo:WMSSurtidoTrabajo.Trabajo + <T>.<T> + SQL(<T>SELECT @@SERVERNAME<T>) + <T>.<T> + BaseDatos)<BR>EjecutarSQL(<T><BR>BEGIN TRY<BR>  EXEC msdb.dbo.sp_delete_job @job_name = :tTrabajo<BR>END TRY<BR>BEGIN CATCH<BR>  IF @@ERROR > 0<BR>    RAISERROR (:tVacio, 0, 0)<BR>END CATCH<BR><T>, Info.Nombre, <T><T>)
[Diaria.WMSSurtidoTrabajo.Valor]
Carpeta=Diaria
Clave=WMSSurtidoTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Diaria.WMSSurtidoTrabajo.HoraInicial]
Carpeta=Diaria
Clave=WMSSurtidoTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Diaria.WMSSurtidoTrabajo.HoraFinal]
Carpeta=Diaria
Clave=WMSSurtidoTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Diaria.WMSSurtidoTrabajo.ValorD]
Carpeta=Diaria
Clave=WMSSurtidoTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Diaria.WMSSurtidoTrabajo.FrecuenciaD]
Carpeta=Diaria
Clave=WMSSurtidoTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=16
ColorFondo=Blanco


[Semanal.WMSSurtidoTrabajo.Recurrencia]
Carpeta=Semanal
Clave=WMSSurtidoTrabajo.Recurrencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Semanal.WMSSurtidoTrabajo.HoraInicial]
Carpeta=Semanal
Clave=WMSSurtidoTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Semanal.WMSSurtidoTrabajo.HoraFinal]
Carpeta=Semanal
Clave=WMSSurtidoTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Semanal.WMSSurtidoTrabajo.Domingo]
Carpeta=Semanal
Clave=WMSSurtidoTrabajo.Domingo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=N
[Semanal.WMSSurtidoTrabajo.Lunes]
Carpeta=Semanal
Clave=WMSSurtidoTrabajo.Lunes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.WMSSurtidoTrabajo.Martes]
Carpeta=Semanal
Clave=WMSSurtidoTrabajo.Martes
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.WMSSurtidoTrabajo.Miercoles]
Carpeta=Semanal
Clave=WMSSurtidoTrabajo.Miercoles
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.WMSSurtidoTrabajo.Jueves]
Carpeta=Semanal
Clave=WMSSurtidoTrabajo.Jueves
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.WMSSurtidoTrabajo.Viernes]
Carpeta=Semanal
Clave=WMSSurtidoTrabajo.Viernes
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.WMSSurtidoTrabajo.Sabado]
Carpeta=Semanal
Clave=WMSSurtidoTrabajo.Sabado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.WMSSurtidoTrabajo.ValorD]
Carpeta=Semanal
Clave=WMSSurtidoTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Semanal.WMSSurtidoTrabajo.FrecuenciaD]
Carpeta=Semanal
Clave=WMSSurtidoTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=22
ColorFondo=Blanco


[Mensual.WMSSurtidoTrabajo.Valor]
Carpeta=Mensual
Clave=WMSSurtidoTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Mensual.WMSSurtidoTrabajo.Recurrencia]
Carpeta=Mensual
Clave=WMSSurtidoTrabajo.Recurrencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Mensual.WMSSurtidoTrabajo.HoraInicial]
Carpeta=Mensual
Clave=WMSSurtidoTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Mensual.WMSSurtidoTrabajo.HoraFinal]
Carpeta=Mensual
Clave=WMSSurtidoTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Mensual.WMSSurtidoTrabajo.ValorD]
Carpeta=Mensual
Clave=WMSSurtidoTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Mensual.WMSSurtidoTrabajo.FrecuenciaD]
Carpeta=Mensual
Clave=WMSSurtidoTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=22
ColorFondo=Blanco


[Mensual2.WMSSurtidoTrabajo.Tipo]
Carpeta=Mensual2
Clave=WMSSurtidoTrabajo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Mensual2.WMSSurtidoTrabajo.Dia]
Carpeta=Mensual2
Clave=WMSSurtidoTrabajo.Dia
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco

[Mensual2.WMSSurtidoTrabajo.HoraInicial]
Carpeta=Mensual2
Clave=WMSSurtidoTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

EspacioPrevio=S
[Mensual2.WMSSurtidoTrabajo.HoraFinal]
Carpeta=Mensual2
Clave=WMSSurtidoTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco

[Mensual2.WMSSurtidoTrabajo.ValorD]
Carpeta=Mensual2
Clave=WMSSurtidoTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=10
[Mensual2.WMSSurtidoTrabajo.FrecuenciaD]
Carpeta=Mensual2
Clave=WMSSurtidoTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco






[Diaria.ListaEnCaptura]
(Inicio)=WMSSurtidoTrabajo.Valor
WMSSurtidoTrabajo.Valor=WMSSurtidoTrabajo.HoraInicial
WMSSurtidoTrabajo.HoraInicial=WMSSurtidoTrabajo.HoraFinal
WMSSurtidoTrabajo.HoraFinal=WMSSurtidoTrabajo.ValorD
WMSSurtidoTrabajo.ValorD=WMSSurtidoTrabajo.FrecuenciaD
WMSSurtidoTrabajo.FrecuenciaD=(Fin)












[Semanal.ListaEnCaptura]
(Inicio)=WMSSurtidoTrabajo.Recurrencia
WMSSurtidoTrabajo.Recurrencia=WMSSurtidoTrabajo.HoraInicial
WMSSurtidoTrabajo.HoraInicial=WMSSurtidoTrabajo.HoraFinal
WMSSurtidoTrabajo.HoraFinal=WMSSurtidoTrabajo.Lunes
WMSSurtidoTrabajo.Lunes=WMSSurtidoTrabajo.Martes
WMSSurtidoTrabajo.Martes=WMSSurtidoTrabajo.Miercoles
WMSSurtidoTrabajo.Miercoles=WMSSurtidoTrabajo.Jueves
WMSSurtidoTrabajo.Jueves=WMSSurtidoTrabajo.Viernes
WMSSurtidoTrabajo.Viernes=WMSSurtidoTrabajo.Sabado
WMSSurtidoTrabajo.Sabado=WMSSurtidoTrabajo.Domingo
WMSSurtidoTrabajo.Domingo=WMSSurtidoTrabajo.ValorD
WMSSurtidoTrabajo.ValorD=WMSSurtidoTrabajo.FrecuenciaD
WMSSurtidoTrabajo.FrecuenciaD=(Fin)






[Mensual.ListaEnCaptura]
(Inicio)=WMSSurtidoTrabajo.Valor
WMSSurtidoTrabajo.Valor=WMSSurtidoTrabajo.Recurrencia
WMSSurtidoTrabajo.Recurrencia=WMSSurtidoTrabajo.HoraInicial
WMSSurtidoTrabajo.HoraInicial=WMSSurtidoTrabajo.HoraFinal
WMSSurtidoTrabajo.HoraFinal=WMSSurtidoTrabajo.ValorD
WMSSurtidoTrabajo.ValorD=WMSSurtidoTrabajo.FrecuenciaD
WMSSurtidoTrabajo.FrecuenciaD=(Fin)










































[Mensual2.ListaEnCaptura]
(Inicio)=WMSSurtidoTrabajo.Tipo
WMSSurtidoTrabajo.Tipo=WMSSurtidoTrabajo.Dia
WMSSurtidoTrabajo.Dia=WMSSurtidoTrabajo.HoraInicial
WMSSurtidoTrabajo.HoraInicial=WMSSurtidoTrabajo.HoraFinal
WMSSurtidoTrabajo.HoraFinal=WMSSurtidoTrabajo.ValorD
WMSSurtidoTrabajo.ValorD=WMSSurtidoTrabajo.FrecuenciaD
WMSSurtidoTrabajo.FrecuenciaD=(Fin)




















[Ficha.WMSSurtidoTrabajo.Procesar]
Carpeta=Ficha
Clave=WMSSurtidoTrabajo.Procesar
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S











[Ficha.ListaEnCaptura]
(Inicio)=WMSSurtidoTrabajo.spEmpresa
WMSSurtidoTrabajo.spEmpresa=WMSSurtidoTrabajo.spSucursal
WMSSurtidoTrabajo.spSucursal=WMSSurtidoTrabajo.spUsuario
WMSSurtidoTrabajo.spUsuario=WMSSurtidoTrabajo.Trabajo
WMSSurtidoTrabajo.Trabajo=WMSSurtidoTrabajo.Nombre
WMSSurtidoTrabajo.Nombre=WMSSurtidoTrabajo.Descripcion
WMSSurtidoTrabajo.Descripcion=WMSSurtidoTrabajo.UltimaActualizacion
WMSSurtidoTrabajo.UltimaActualizacion=WMSSurtidoTrabajo.Procesar
WMSSurtidoTrabajo.Procesar=WMSSurtidoTrabajo.Activo
WMSSurtidoTrabajo.Activo=WMSSurtidoTrabajo.Frecuencia
WMSSurtidoTrabajo.Frecuencia=WMSSurtidoTrabajo.Usuario
WMSSurtidoTrabajo.Usuario=WMSSurtidoTrabajo.Contrasena
WMSSurtidoTrabajo.Contrasena=(Fin)























































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
