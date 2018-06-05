[Forma]
Clave=CorteTrabajo
Nombre=Trabajos Cortes
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=313
PosicionInicialAncho=915
PosicionColumna1=47
PosicionInicialIzquierda=225
PosicionInicialArriba=188
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
Vista=CorteTrabajo
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






[Lista.CorteTrabajo.Nombre]
Carpeta=Lista
Clave=CorteTrabajo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Ficha.CorteTrabajo.Trabajo]
Carpeta=Ficha
Clave=CorteTrabajo.Trabajo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.CorteTrabajo.Nombre]
Carpeta=Ficha
Clave=CorteTrabajo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.CorteTrabajo.Descripcion]
Carpeta=Ficha
Clave=CorteTrabajo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.CorteTrabajo.UltimaActualizacion]
Carpeta=Ficha
Clave=CorteTrabajo.UltimaActualizacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=57
ColorFondo=$00F0F0F0


[Ficha.CorteTrabajo.Activo]
Carpeta=Ficha
Clave=CorteTrabajo.Activo
Editar=S
3D=S
Tamano=24
ColorFondo=Blanco

LineaNueva=N


[Ficha.CorteTrabajo.Frecuencia]
Carpeta=Ficha
Clave=CorteTrabajo.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
EspacioPrevio=S



[Ficha.CorteTrabajo.Usuario]
Carpeta=Ficha
Clave=CorteTrabajo.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[Ficha.CorteTrabajo.Contrasena]
Carpeta=Ficha
Clave=CorteTrabajo.Contrasena
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Lista.CorteTrabajo.Trabajo]
Carpeta=Lista
Clave=CorteTrabajo.Trabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco














[Detalle.CorteTrabajoD.StoreProcedure]
Carpeta=Detalle
Clave=CorteTrabajoD.StoreProcedure
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.CorteTrabajoD.Orden]
Carpeta=Detalle
Clave=CorteTrabajoD.Orden
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
(Inicio)=CorteTrabajo.Trabajo
CorteTrabajo.Trabajo=CorteTrabajo.Nombre
CorteTrabajo.Nombre=(Fin)







[Detalle.ListaEnCaptura]
(Inicio)=CorteTrabajoD.StoreProcedure
CorteTrabajoD.StoreProcedure=CorteTrabajoD.Orden
CorteTrabajoD.Orden=(Fin)























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
Expresion=ProcesarSQL(<T>EXEC spCorteCrearJobs :Trabajo, :BaseDatos, :Usuario<T>, CorteTrabajo:CorteTrabajo.Trabajo, BaseDatos, Usuario)<BR>ActualizarVista
[Diaria]
Estilo=Ficha
Pestana=S
Clave=Diaria
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CorteTrabajo
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

CondicionVisible=CorteTrabajo:CorteTrabajo.Frecuencia=<T>Diaria<T>
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
Vista=CorteTrabajo
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









CondicionVisible=CorteTrabajo:CorteTrabajo.Frecuencia=<T>Semanal<T>
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
Vista=CorteTrabajo
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





CondicionVisible=CorteTrabajo:CorteTrabajo.Frecuencia=<T>Mensual<T>
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
Vista=CorteTrabajo
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





CondicionVisible=CorteTrabajo:CorteTrabajo.Frecuencia=<T>Mensual 2<T>
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

Vista=CorteTrabajo
ListaEnCaptura=CorteTrabajo.Trabajo








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
[Ficha.CorteTrabajo.spSucursal]
Carpeta=Ficha
Clave=CorteTrabajo.spSucursal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Pegado=S
Tamano=10
[Ficha.CorteTrabajo.spEmpresa]
Carpeta=Ficha
Clave=CorteTrabajo.spEmpresa
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

Pegado=N
LineaNueva=S
[Ficha.CorteTrabajo.spUsuario]
Carpeta=Ficha
Clave=CorteTrabajo.spUsuario
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














































































AntesExpresiones=Asigna(Info.Nombre, CorteTrabajo:CorteTrabajo.Trabajo + <T>.<T> + SQL(<T>SELECT @@SERVERNAME<T>) + <T>.<T> + BaseDatos)<BR>EjecutarSQL(<T><BR>BEGIN TRY<BR>  EXEC msdb.dbo.sp_delete_job @job_name = :tTrabajo<BR>END TRY<BR>BEGIN CATCH<BR>  IF @@ERROR > 0<BR>    RAISERROR (:tVacio, 0, 0)<BR>END CATCH<BR><T>, Info.Nombre, <T><T>)
[Diaria.CorteTrabajo.Valor]
Carpeta=Diaria
Clave=CorteTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Diaria.CorteTrabajo.HoraInicial]
Carpeta=Diaria
Clave=CorteTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Diaria.CorteTrabajo.HoraFinal]
Carpeta=Diaria
Clave=CorteTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Diaria.CorteTrabajo.ValorD]
Carpeta=Diaria
Clave=CorteTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Diaria.CorteTrabajo.FrecuenciaD]
Carpeta=Diaria
Clave=CorteTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=16
ColorFondo=Blanco


[Semanal.CorteTrabajo.Recurrencia]
Carpeta=Semanal
Clave=CorteTrabajo.Recurrencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Semanal.CorteTrabajo.HoraInicial]
Carpeta=Semanal
Clave=CorteTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Semanal.CorteTrabajo.HoraFinal]
Carpeta=Semanal
Clave=CorteTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Semanal.CorteTrabajo.Domingo]
Carpeta=Semanal
Clave=CorteTrabajo.Domingo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=N
[Semanal.CorteTrabajo.Lunes]
Carpeta=Semanal
Clave=CorteTrabajo.Lunes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.CorteTrabajo.Martes]
Carpeta=Semanal
Clave=CorteTrabajo.Martes
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.CorteTrabajo.Miercoles]
Carpeta=Semanal
Clave=CorteTrabajo.Miercoles
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.CorteTrabajo.Jueves]
Carpeta=Semanal
Clave=CorteTrabajo.Jueves
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.CorteTrabajo.Viernes]
Carpeta=Semanal
Clave=CorteTrabajo.Viernes
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.CorteTrabajo.Sabado]
Carpeta=Semanal
Clave=CorteTrabajo.Sabado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.CorteTrabajo.ValorD]
Carpeta=Semanal
Clave=CorteTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Semanal.CorteTrabajo.FrecuenciaD]
Carpeta=Semanal
Clave=CorteTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=22
ColorFondo=Blanco


[Mensual.CorteTrabajo.Valor]
Carpeta=Mensual
Clave=CorteTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Mensual.CorteTrabajo.Recurrencia]
Carpeta=Mensual
Clave=CorteTrabajo.Recurrencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Mensual.CorteTrabajo.HoraInicial]
Carpeta=Mensual
Clave=CorteTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Mensual.CorteTrabajo.HoraFinal]
Carpeta=Mensual
Clave=CorteTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Mensual.CorteTrabajo.ValorD]
Carpeta=Mensual
Clave=CorteTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Mensual.CorteTrabajo.FrecuenciaD]
Carpeta=Mensual
Clave=CorteTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=22
ColorFondo=Blanco


[Mensual2.CorteTrabajo.Tipo]
Carpeta=Mensual2
Clave=CorteTrabajo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Mensual2.CorteTrabajo.Dia]
Carpeta=Mensual2
Clave=CorteTrabajo.Dia
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco

[Mensual2.CorteTrabajo.HoraInicial]
Carpeta=Mensual2
Clave=CorteTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

EspacioPrevio=S
[Mensual2.CorteTrabajo.HoraFinal]
Carpeta=Mensual2
Clave=CorteTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco

[Mensual2.CorteTrabajo.ValorD]
Carpeta=Mensual2
Clave=CorteTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=10
[Mensual2.CorteTrabajo.FrecuenciaD]
Carpeta=Mensual2
Clave=CorteTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco






[Diaria.ListaEnCaptura]
(Inicio)=CorteTrabajo.Valor
CorteTrabajo.Valor=CorteTrabajo.HoraInicial
CorteTrabajo.HoraInicial=CorteTrabajo.HoraFinal
CorteTrabajo.HoraFinal=CorteTrabajo.ValorD
CorteTrabajo.ValorD=CorteTrabajo.FrecuenciaD
CorteTrabajo.FrecuenciaD=(Fin)












[Semanal.ListaEnCaptura]
(Inicio)=CorteTrabajo.Recurrencia
CorteTrabajo.Recurrencia=CorteTrabajo.HoraInicial
CorteTrabajo.HoraInicial=CorteTrabajo.HoraFinal
CorteTrabajo.HoraFinal=CorteTrabajo.Lunes
CorteTrabajo.Lunes=CorteTrabajo.Martes
CorteTrabajo.Martes=CorteTrabajo.Miercoles
CorteTrabajo.Miercoles=CorteTrabajo.Jueves
CorteTrabajo.Jueves=CorteTrabajo.Viernes
CorteTrabajo.Viernes=CorteTrabajo.Sabado
CorteTrabajo.Sabado=CorteTrabajo.Domingo
CorteTrabajo.Domingo=CorteTrabajo.ValorD
CorteTrabajo.ValorD=CorteTrabajo.FrecuenciaD
CorteTrabajo.FrecuenciaD=(Fin)






[Mensual.ListaEnCaptura]
(Inicio)=CorteTrabajo.Valor
CorteTrabajo.Valor=CorteTrabajo.Recurrencia
CorteTrabajo.Recurrencia=CorteTrabajo.HoraInicial
CorteTrabajo.HoraInicial=CorteTrabajo.HoraFinal
CorteTrabajo.HoraFinal=CorteTrabajo.ValorD
CorteTrabajo.ValorD=CorteTrabajo.FrecuenciaD
CorteTrabajo.FrecuenciaD=(Fin)










































[Mensual2.ListaEnCaptura]
(Inicio)=CorteTrabajo.Tipo
CorteTrabajo.Tipo=CorteTrabajo.Dia
CorteTrabajo.Dia=CorteTrabajo.HoraInicial
CorteTrabajo.HoraInicial=CorteTrabajo.HoraFinal
CorteTrabajo.HoraFinal=CorteTrabajo.ValorD
CorteTrabajo.ValorD=CorteTrabajo.FrecuenciaD
CorteTrabajo.FrecuenciaD=(Fin)




















[Ficha.CorteTrabajo.Procesar]
Carpeta=Ficha
Clave=CorteTrabajo.Procesar
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S











[Ficha.ListaEnCaptura]
(Inicio)=CorteTrabajo.spEmpresa
CorteTrabajo.spEmpresa=CorteTrabajo.spSucursal
CorteTrabajo.spSucursal=CorteTrabajo.spUsuario
CorteTrabajo.spUsuario=CorteTrabajo.Trabajo
CorteTrabajo.Trabajo=CorteTrabajo.Nombre
CorteTrabajo.Nombre=CorteTrabajo.Descripcion
CorteTrabajo.Descripcion=CorteTrabajo.UltimaActualizacion
CorteTrabajo.UltimaActualizacion=CorteTrabajo.Procesar
CorteTrabajo.Procesar=CorteTrabajo.Activo
CorteTrabajo.Activo=CorteTrabajo.Frecuencia
CorteTrabajo.Frecuencia=CorteTrabajo.Usuario
CorteTrabajo.Usuario=CorteTrabajo.Contrasena
CorteTrabajo.Contrasena=(Fin)























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
