[Forma]
Clave=eDocInTrabajo
Nombre=Trabajos Recepción Documento Electrónico
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=447
PosicionInicialAncho=1101
PosicionColumna1=47
PosicionInicialIzquierda=249
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
Vista=eDocInTrabajo
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
0=91
1=267
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






[Lista.eDocInTrabajo.Nombre]
Carpeta=Lista
Clave=eDocInTrabajo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Ficha.eDocInTrabajo.Trabajo]
Carpeta=Ficha
Clave=eDocInTrabajo.Trabajo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.eDocInTrabajo.Nombre]
Carpeta=Ficha
Clave=eDocInTrabajo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.eDocInTrabajo.Descripcion]
Carpeta=Ficha
Clave=eDocInTrabajo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.eDocInTrabajo.UltimaActualizacion]
Carpeta=Ficha
Clave=eDocInTrabajo.UltimaActualizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=57
ColorFondo=$00F0F0F0


[Ficha.eDocInTrabajo.Activo]
Carpeta=Ficha
Clave=eDocInTrabajo.Activo
Editar=S
3D=S
Tamano=24
ColorFondo=Blanco

LineaNueva=N


[Ficha.eDocInTrabajo.Frecuencia]
Carpeta=Ficha
Clave=eDocInTrabajo.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
EspacioPrevio=S



[Ficha.eDocInTrabajo.Usuario]
Carpeta=Ficha
Clave=eDocInTrabajo.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[Ficha.eDocInTrabajo.Contrasena]
Carpeta=Ficha
Clave=eDocInTrabajo.Contrasena
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Lista.eDocInTrabajo.Trabajo]
Carpeta=Lista
Clave=eDocInTrabajo.Trabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco














[Detalle.eDocInTrabajoD.StoreProcedure]
Carpeta=Detalle
Clave=eDocInTrabajoD.StoreProcedure
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.eDocInTrabajoD.Orden]
Carpeta=Detalle
Clave=eDocInTrabajoD.Orden
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
(Inicio)=eDocInTrabajo.Trabajo
eDocInTrabajo.Trabajo=eDocInTrabajo.Nombre
eDocInTrabajo.Nombre=(Fin)







[Detalle.ListaEnCaptura]
(Inicio)=eDocInTrabajoD.StoreProcedure
eDocInTrabajoD.StoreProcedure=eDocInTrabajoD.Orden
eDocInTrabajoD.Orden=(Fin)























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
Expresion=ProcesarSQL(<T>EXEC speDocINCrearJobs :Trabajo, :BaseDatos, :Usuario<T>, eDocInTrabajo:eDocInTrabajo.Trabajo, BaseDatos, Usuario)<BR>ActualizarVista
[Diaria]
Estilo=Ficha
Pestana=S
Clave=Diaria
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=eDocInTrabajo
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

CondicionVisible=eDocInTrabajo:eDocInTrabajo.Frecuencia=<T>Diaria<T>
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
Vista=eDocInTrabajo
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









CondicionVisible=eDocInTrabajo:eDocInTrabajo.Frecuencia=<T>Semanal<T>
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
Vista=eDocInTrabajo
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





CondicionVisible=eDocInTrabajo:eDocInTrabajo.Frecuencia=<T>Mensual<T>
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
Vista=eDocInTrabajo
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





CondicionVisible=eDocInTrabajo:eDocInTrabajo.Frecuencia=<T>Mensual 2<T>
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

Vista=eDocInTrabajo
ListaEnCaptura=eDocInTrabajo.Trabajo








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
[Ficha.eDocInTrabajo.spSucursal]
Carpeta=Ficha
Clave=eDocInTrabajo.spSucursal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Pegado=S
Tamano=10
[Ficha.eDocInTrabajo.spEmpresa]
Carpeta=Ficha
Clave=eDocInTrabajo.spEmpresa
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

Pegado=N
LineaNueva=S
[Ficha.eDocInTrabajo.spUsuario]
Carpeta=Ficha
Clave=eDocInTrabajo.spUsuario
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














































































AntesExpresiones=Asigna(Info.Nombre, eDocInTrabajo:eDocInTrabajo.Trabajo + <T>.<T> + SQL(<T>SELECT @@SERVERNAME<T>) + <T>.<T> + BaseDatos)<BR>EjecutarSQL(<T><BR>BEGIN TRY<BR>  EXEC msdb.dbo.sp_delete_job @job_name = :tTrabajo<BR>END TRY<BR>BEGIN CATCH<BR>  IF @@ERROR > 0<BR>    RAISERROR (:tVacio, 0, 0)<BR>END CATCH<BR><T>, Info.Nombre, <T><T>)
[Diaria.eDocInTrabajo.Valor]
Carpeta=Diaria
Clave=eDocInTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Diaria.eDocInTrabajo.HoraInicial]
Carpeta=Diaria
Clave=eDocInTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Diaria.eDocInTrabajo.HoraFinal]
Carpeta=Diaria
Clave=eDocInTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Diaria.eDocInTrabajo.ValorD]
Carpeta=Diaria
Clave=eDocInTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Diaria.eDocInTrabajo.FrecuenciaD]
Carpeta=Diaria
Clave=eDocInTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=16
ColorFondo=Blanco


[Semanal.eDocInTrabajo.Recurrencia]
Carpeta=Semanal
Clave=eDocInTrabajo.Recurrencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Semanal.eDocInTrabajo.HoraInicial]
Carpeta=Semanal
Clave=eDocInTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Semanal.eDocInTrabajo.HoraFinal]
Carpeta=Semanal
Clave=eDocInTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Semanal.eDocInTrabajo.Domingo]
Carpeta=Semanal
Clave=eDocInTrabajo.Domingo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=N
[Semanal.eDocInTrabajo.Lunes]
Carpeta=Semanal
Clave=eDocInTrabajo.Lunes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.eDocInTrabajo.Martes]
Carpeta=Semanal
Clave=eDocInTrabajo.Martes
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.eDocInTrabajo.Miercoles]
Carpeta=Semanal
Clave=eDocInTrabajo.Miercoles
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.eDocInTrabajo.Jueves]
Carpeta=Semanal
Clave=eDocInTrabajo.Jueves
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.eDocInTrabajo.Viernes]
Carpeta=Semanal
Clave=eDocInTrabajo.Viernes
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.eDocInTrabajo.Sabado]
Carpeta=Semanal
Clave=eDocInTrabajo.Sabado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.eDocInTrabajo.ValorD]
Carpeta=Semanal
Clave=eDocInTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Semanal.eDocInTrabajo.FrecuenciaD]
Carpeta=Semanal
Clave=eDocInTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=22
ColorFondo=Blanco


[Mensual.eDocInTrabajo.Valor]
Carpeta=Mensual
Clave=eDocInTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Mensual.eDocInTrabajo.Recurrencia]
Carpeta=Mensual
Clave=eDocInTrabajo.Recurrencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Mensual.eDocInTrabajo.HoraInicial]
Carpeta=Mensual
Clave=eDocInTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Mensual.eDocInTrabajo.HoraFinal]
Carpeta=Mensual
Clave=eDocInTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Mensual.eDocInTrabajo.ValorD]
Carpeta=Mensual
Clave=eDocInTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Mensual.eDocInTrabajo.FrecuenciaD]
Carpeta=Mensual
Clave=eDocInTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=22
ColorFondo=Blanco


[Mensual2.eDocInTrabajo.Tipo]
Carpeta=Mensual2
Clave=eDocInTrabajo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Mensual2.eDocInTrabajo.Dia]
Carpeta=Mensual2
Clave=eDocInTrabajo.Dia
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco

[Mensual2.eDocInTrabajo.HoraInicial]
Carpeta=Mensual2
Clave=eDocInTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

EspacioPrevio=S
[Mensual2.eDocInTrabajo.HoraFinal]
Carpeta=Mensual2
Clave=eDocInTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco

[Mensual2.eDocInTrabajo.ValorD]
Carpeta=Mensual2
Clave=eDocInTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=10
[Mensual2.eDocInTrabajo.FrecuenciaD]
Carpeta=Mensual2
Clave=eDocInTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco






[Diaria.ListaEnCaptura]
(Inicio)=eDocInTrabajo.Valor
eDocInTrabajo.Valor=eDocInTrabajo.HoraInicial
eDocInTrabajo.HoraInicial=eDocInTrabajo.HoraFinal
eDocInTrabajo.HoraFinal=eDocInTrabajo.ValorD
eDocInTrabajo.ValorD=eDocInTrabajo.FrecuenciaD
eDocInTrabajo.FrecuenciaD=(Fin)












[Semanal.ListaEnCaptura]
(Inicio)=eDocInTrabajo.Recurrencia
eDocInTrabajo.Recurrencia=eDocInTrabajo.HoraInicial
eDocInTrabajo.HoraInicial=eDocInTrabajo.HoraFinal
eDocInTrabajo.HoraFinal=eDocInTrabajo.Lunes
eDocInTrabajo.Lunes=eDocInTrabajo.Martes
eDocInTrabajo.Martes=eDocInTrabajo.Miercoles
eDocInTrabajo.Miercoles=eDocInTrabajo.Jueves
eDocInTrabajo.Jueves=eDocInTrabajo.Viernes
eDocInTrabajo.Viernes=eDocInTrabajo.Sabado
eDocInTrabajo.Sabado=eDocInTrabajo.Domingo
eDocInTrabajo.Domingo=eDocInTrabajo.ValorD
eDocInTrabajo.ValorD=eDocInTrabajo.FrecuenciaD
eDocInTrabajo.FrecuenciaD=(Fin)






[Mensual.ListaEnCaptura]
(Inicio)=eDocInTrabajo.Valor
eDocInTrabajo.Valor=eDocInTrabajo.Recurrencia
eDocInTrabajo.Recurrencia=eDocInTrabajo.HoraInicial
eDocInTrabajo.HoraInicial=eDocInTrabajo.HoraFinal
eDocInTrabajo.HoraFinal=eDocInTrabajo.ValorD
eDocInTrabajo.ValorD=eDocInTrabajo.FrecuenciaD
eDocInTrabajo.FrecuenciaD=(Fin)










































[Mensual2.ListaEnCaptura]
(Inicio)=eDocInTrabajo.Tipo
eDocInTrabajo.Tipo=eDocInTrabajo.Dia
eDocInTrabajo.Dia=eDocInTrabajo.HoraInicial
eDocInTrabajo.HoraInicial=eDocInTrabajo.HoraFinal
eDocInTrabajo.HoraFinal=eDocInTrabajo.ValorD
eDocInTrabajo.ValorD=eDocInTrabajo.FrecuenciaD
eDocInTrabajo.FrecuenciaD=(Fin)
























[Ficha.eDocInTrabajo.spOrigen]
Carpeta=Ficha
Clave=eDocInTrabajo.spOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.eDocInTrabajo.spDestino]
Carpeta=Ficha
Clave=eDocInTrabajo.spDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco



[Ficha.ListaEnCaptura]
(Inicio)=eDocInTrabajo.spEmpresa
eDocInTrabajo.spEmpresa=eDocInTrabajo.spSucursal
eDocInTrabajo.spSucursal=eDocInTrabajo.spUsuario
eDocInTrabajo.spUsuario=eDocInTrabajo.Trabajo
eDocInTrabajo.Trabajo=eDocInTrabajo.Nombre
eDocInTrabajo.Nombre=eDocInTrabajo.Descripcion
eDocInTrabajo.Descripcion=eDocInTrabajo.UltimaActualizacion
eDocInTrabajo.UltimaActualizacion=eDocInTrabajo.Activo
eDocInTrabajo.Activo=eDocInTrabajo.Frecuencia
eDocInTrabajo.Frecuencia=eDocInTrabajo.Usuario
eDocInTrabajo.Usuario=eDocInTrabajo.Contrasena
eDocInTrabajo.Contrasena=eDocInTrabajo.spOrigen
eDocInTrabajo.spOrigen=eDocInTrabajo.spDestino
eDocInTrabajo.spDestino=(Fin)







































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
