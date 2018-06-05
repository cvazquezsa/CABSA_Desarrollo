[Forma]
Clave=JasperTrabajo
Nombre=Trabajo Jasper Intelisis Service
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=291
PosicionInicialAncho=559
PosicionColumna1=47
PosicionInicialIzquierda=829
PosicionInicialArriba=392
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionCol1=262

VentanaEstadoInicial=Normal
PosicionSec1=110
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=JasperTrabajo
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
Trabajo=229
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






[Lista.JasperTrabajo.Nombre]
Carpeta=Lista
Clave=JasperTrabajo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Ficha.JasperTrabajo.Trabajo]
Carpeta=Ficha
Clave=JasperTrabajo.Trabajo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.JasperTrabajo.Nombre]
Carpeta=Ficha
Clave=JasperTrabajo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.JasperTrabajo.Descripcion]
Carpeta=Ficha
Clave=JasperTrabajo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.JasperTrabajo.UltimaActualizacion]
Carpeta=Ficha
Clave=JasperTrabajo.UltimaActualizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=57
ColorFondo=$00F0F0F0


[Ficha.JasperTrabajo.Activo]
Carpeta=Ficha
Clave=JasperTrabajo.Activo
Editar=S
3D=S
Tamano=24
ColorFondo=Blanco

LineaNueva=S


[Ficha.JasperTrabajo.Frecuencia]
Carpeta=Ficha
Clave=JasperTrabajo.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
EspacioPrevio=S



[Ficha.JasperTrabajo.Usuario]
Carpeta=Ficha
Clave=JasperTrabajo.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[Ficha.JasperTrabajo.Contrasena]
Carpeta=Ficha
Clave=JasperTrabajo.Contrasena
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Lista.JasperTrabajo.Trabajo]
Carpeta=Lista
Clave=JasperTrabajo.Trabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco














[Detalle.JasperTrabajoD.StoreProcedure]
Carpeta=Detalle
Clave=JasperTrabajoD.StoreProcedure
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.JasperTrabajoD.Orden]
Carpeta=Detalle
Clave=JasperTrabajoD.Orden
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
(Inicio)=JasperTrabajo.Trabajo
JasperTrabajo.Trabajo=JasperTrabajo.Nombre
JasperTrabajo.Nombre=(Fin)







[Detalle.ListaEnCaptura]
(Inicio)=JasperTrabajoD.StoreProcedure
JasperTrabajoD.StoreProcedure=JasperTrabajoD.Orden
JasperTrabajoD.Orden=(Fin)























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
Expresion=ProcesarSQL(<T>EXEC spCrearJobsJasperTrabajo :Trabajo, :BaseDatos, :Usuario<T>, JasperTrabajo:JasperTrabajo.Trabajo, BaseDatos, Usuario)<BR>ActualizarVista
[Diaria]
Estilo=Ficha
Pestana=S
Clave=Diaria
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=JasperTrabajo
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

CondicionVisible=JasperTrabajo:JasperTrabajo.Frecuencia=<T>Diaria<T>
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
Zona=A1
Vista=JasperTrabajo
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









CondicionVisible=JasperTrabajo:JasperTrabajo.Frecuencia=<T>Semanal<T>
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
Zona=A1
Vista=JasperTrabajo
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





CondicionVisible=JasperTrabajo:JasperTrabajo.Frecuencia=<T>Mensual<T>
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
Zona=A1
Vista=JasperTrabajo
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






CondicionVisible=JasperTrabajo:JasperTrabajo.Frecuencia=<T>Mensual 2<T>
[Diaria.JasperTrabajo.Valor]
Carpeta=Diaria
Clave=JasperTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Diaria.JasperTrabajo.HoraInicial]
Carpeta=Diaria
Clave=JasperTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco

EspacioPrevio=S
[Diaria.JasperTrabajo.HoraFinal]
Carpeta=Diaria
Clave=JasperTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco

[Diaria.JasperTrabajo.ValorD]
Carpeta=Diaria
Clave=JasperTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Diaria.JasperTrabajo.FrecuenciaD]
Carpeta=Diaria
Clave=JasperTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=14
ColorFondo=Blanco


[Semanal.JasperTrabajo.Recurrencia]
Carpeta=Semanal
Clave=JasperTrabajo.Recurrencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Semanal.JasperTrabajo.HoraInicial]
Carpeta=Semanal
Clave=JasperTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco

EspacioPrevio=S
[Semanal.JasperTrabajo.HoraFinal]
Carpeta=Semanal
Clave=JasperTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco

[Semanal.JasperTrabajo.Domingo]
Carpeta=Semanal
Clave=JasperTrabajo.Domingo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=N
[Semanal.JasperTrabajo.Lunes]
Carpeta=Semanal
Clave=JasperTrabajo.Lunes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
[Semanal.JasperTrabajo.Martes]
Carpeta=Semanal
Clave=JasperTrabajo.Martes
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.JasperTrabajo.Miercoles]
Carpeta=Semanal
Clave=JasperTrabajo.Miercoles
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.JasperTrabajo.Jueves]
Carpeta=Semanal
Clave=JasperTrabajo.Jueves
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.JasperTrabajo.Viernes]
Carpeta=Semanal
Clave=JasperTrabajo.Viernes
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.JasperTrabajo.Sabado]
Carpeta=Semanal
Clave=JasperTrabajo.Sabado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.JasperTrabajo.ValorD]
Carpeta=Semanal
Clave=JasperTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Semanal.JasperTrabajo.FrecuenciaD]
Carpeta=Semanal
Clave=JasperTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco


[Mensual.JasperTrabajo.Valor]
Carpeta=Mensual
Clave=JasperTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Mensual.JasperTrabajo.Recurrencia]
Carpeta=Mensual
Clave=JasperTrabajo.Recurrencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Mensual.JasperTrabajo.HoraInicial]
Carpeta=Mensual
Clave=JasperTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Mensual.JasperTrabajo.HoraFinal]
Carpeta=Mensual
Clave=JasperTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Mensual.JasperTrabajo.ValorD]
Carpeta=Mensual
Clave=JasperTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Mensual.JasperTrabajo.FrecuenciaD]
Carpeta=Mensual
Clave=JasperTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=22
ColorFondo=Blanco


[Mensual2.JasperTrabajo.Tipo]
Carpeta=Mensual2
Clave=JasperTrabajo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Mensual2.JasperTrabajo.Dia]
Carpeta=Mensual2
Clave=JasperTrabajo.Dia
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco

[Mensual2.JasperTrabajo.HoraInicial]
Carpeta=Mensual2
Clave=JasperTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

EspacioPrevio=S
[Mensual2.JasperTrabajo.HoraFinal]
Carpeta=Mensual2
Clave=JasperTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco

[Mensual2.JasperTrabajo.ValorD]
Carpeta=Mensual2
Clave=JasperTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=10
[Mensual2.JasperTrabajo.FrecuenciaD]
Carpeta=Mensual2
Clave=JasperTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco







[Ficha.ListaEnCaptura]
(Inicio)=JasperTrabajo.Trabajo
JasperTrabajo.Trabajo=JasperTrabajo.Nombre
JasperTrabajo.Nombre=JasperTrabajo.Descripcion
JasperTrabajo.Descripcion=JasperTrabajo.UltimaActualizacion
JasperTrabajo.UltimaActualizacion=JasperTrabajo.Activo
JasperTrabajo.Activo=JasperTrabajo.Frecuencia
JasperTrabajo.Frecuencia=JasperTrabajo.Usuario
JasperTrabajo.Usuario=JasperTrabajo.Contrasena
JasperTrabajo.Contrasena=(Fin)





[Diaria.ListaEnCaptura]
(Inicio)=JasperTrabajo.Valor
JasperTrabajo.Valor=JasperTrabajo.HoraInicial
JasperTrabajo.HoraInicial=JasperTrabajo.HoraFinal
JasperTrabajo.HoraFinal=JasperTrabajo.ValorD
JasperTrabajo.ValorD=JasperTrabajo.FrecuenciaD
JasperTrabajo.FrecuenciaD=(Fin)











[Semanal.ListaEnCaptura]
(Inicio)=JasperTrabajo.Recurrencia
JasperTrabajo.Recurrencia=JasperTrabajo.HoraInicial
JasperTrabajo.HoraInicial=JasperTrabajo.HoraFinal
JasperTrabajo.HoraFinal=JasperTrabajo.Lunes
JasperTrabajo.Lunes=JasperTrabajo.Martes
JasperTrabajo.Martes=JasperTrabajo.Miercoles
JasperTrabajo.Miercoles=JasperTrabajo.Jueves
JasperTrabajo.Jueves=JasperTrabajo.Viernes
JasperTrabajo.Viernes=JasperTrabajo.Sabado
JasperTrabajo.Sabado=JasperTrabajo.Domingo
JasperTrabajo.Domingo=JasperTrabajo.ValorD
JasperTrabajo.ValorD=JasperTrabajo.FrecuenciaD
JasperTrabajo.FrecuenciaD=(Fin)















[Mensual.ListaEnCaptura]
(Inicio)=JasperTrabajo.Valor
JasperTrabajo.Valor=JasperTrabajo.Recurrencia
JasperTrabajo.Recurrencia=JasperTrabajo.HoraInicial
JasperTrabajo.HoraInicial=JasperTrabajo.HoraFinal
JasperTrabajo.HoraFinal=JasperTrabajo.ValorD
JasperTrabajo.ValorD=JasperTrabajo.FrecuenciaD
JasperTrabajo.FrecuenciaD=(Fin)





































[Mensual2.ListaEnCaptura]
(Inicio)=JasperTrabajo.Tipo
JasperTrabajo.Tipo=JasperTrabajo.Dia
JasperTrabajo.Dia=JasperTrabajo.HoraInicial
JasperTrabajo.HoraInicial=JasperTrabajo.HoraFinal
JasperTrabajo.HoraFinal=JasperTrabajo.ValorD
JasperTrabajo.ValorD=JasperTrabajo.FrecuenciaD
JasperTrabajo.FrecuenciaD=(Fin)



































[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Diaria
Diaria=Semanal
Semanal=Mensual
Mensual=Mensual2
Mensual2=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Trabajo
Trabajo=(Fin)
