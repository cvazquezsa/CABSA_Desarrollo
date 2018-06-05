[Forma]
Clave=SincroISTrabajo
Nombre=Trabajo Sincro Intelisis Service
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=291
PosicionInicialAncho=559
PosicionColumna1=47
PosicionInicialIzquierda=337
PosicionInicialArriba=265
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
Vista=SincroISTrabajo
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






[Lista.SincroISTrabajo.Nombre]
Carpeta=Lista
Clave=SincroISTrabajo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



[Ficha.SincroISTrabajo.Trabajo]
Carpeta=Ficha
Clave=SincroISTrabajo.Trabajo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.SincroISTrabajo.Nombre]
Carpeta=Ficha
Clave=SincroISTrabajo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.SincroISTrabajo.Descripcion]
Carpeta=Ficha
Clave=SincroISTrabajo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=57
ColorFondo=Blanco

[Ficha.SincroISTrabajo.UltimaActualizacion]
Carpeta=Ficha
Clave=SincroISTrabajo.UltimaActualizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=57
ColorFondo=$00F0F0F0


[Ficha.SincroISTrabajo.Activo]
Carpeta=Ficha
Clave=SincroISTrabajo.Activo
Editar=S
3D=S
Tamano=24
ColorFondo=Blanco

LineaNueva=S


[Ficha.SincroISTrabajo.Frecuencia]
Carpeta=Ficha
Clave=SincroISTrabajo.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
EspacioPrevio=S



[Ficha.SincroISTrabajo.Usuario]
Carpeta=Ficha
Clave=SincroISTrabajo.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[Ficha.SincroISTrabajo.Contrasena]
Carpeta=Ficha
Clave=SincroISTrabajo.Contrasena
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Lista.SincroISTrabajo.Trabajo]
Carpeta=Lista
Clave=SincroISTrabajo.Trabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco














[Detalle.SincroISTrabajoD.StoreProcedure]
Carpeta=Detalle
Clave=SincroISTrabajoD.StoreProcedure
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Detalle.SincroISTrabajoD.Orden]
Carpeta=Detalle
Clave=SincroISTrabajoD.Orden
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
(Inicio)=SincroISTrabajo.Trabajo
SincroISTrabajo.Trabajo=SincroISTrabajo.Nombre
SincroISTrabajo.Nombre=(Fin)







[Detalle.ListaEnCaptura]
(Inicio)=SincroISTrabajoD.StoreProcedure
SincroISTrabajoD.StoreProcedure=SincroISTrabajoD.Orden
SincroISTrabajoD.Orden=(Fin)























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
Expresion=ProcesarSQL(<T>EXEC spCrearJobsSincroISTrabajo :Trabajo, :BaseDatos, :Usuario<T>, SincroISTrabajo:SincroISTrabajo.Trabajo, BaseDatos, Usuario)<BR>ActualizarVista
[Diaria]
Estilo=Ficha
Pestana=S
Clave=Diaria
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SincroISTrabajo
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

CondicionVisible=SincroISTrabajo:SincroISTrabajo.Frecuencia=<T>Diaria<T>
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
Vista=SincroISTrabajo
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









CondicionVisible=SincroISTrabajo:SincroISTrabajo.Frecuencia=<T>Semanal<T>
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
Vista=SincroISTrabajo
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





CondicionVisible=SincroISTrabajo:SincroISTrabajo.Frecuencia=<T>Mensual<T>
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
Vista=SincroISTrabajo
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






CondicionVisible=SincroISTrabajo:SincroISTrabajo.Frecuencia=<T>Mensual 2<T>
[Diaria.SincroISTrabajo.Valor]
Carpeta=Diaria
Clave=SincroISTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Diaria.SincroISTrabajo.HoraInicial]
Carpeta=Diaria
Clave=SincroISTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco

EspacioPrevio=S
[Diaria.SincroISTrabajo.HoraFinal]
Carpeta=Diaria
Clave=SincroISTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco

[Diaria.SincroISTrabajo.ValorD]
Carpeta=Diaria
Clave=SincroISTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Diaria.SincroISTrabajo.FrecuenciaD]
Carpeta=Diaria
Clave=SincroISTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=14
ColorFondo=Blanco


[Semanal.SincroISTrabajo.Recurrencia]
Carpeta=Semanal
Clave=SincroISTrabajo.Recurrencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Semanal.SincroISTrabajo.HoraInicial]
Carpeta=Semanal
Clave=SincroISTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco

EspacioPrevio=S
[Semanal.SincroISTrabajo.HoraFinal]
Carpeta=Semanal
Clave=SincroISTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco

[Semanal.SincroISTrabajo.Domingo]
Carpeta=Semanal
Clave=SincroISTrabajo.Domingo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=N
[Semanal.SincroISTrabajo.Lunes]
Carpeta=Semanal
Clave=SincroISTrabajo.Lunes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
[Semanal.SincroISTrabajo.Martes]
Carpeta=Semanal
Clave=SincroISTrabajo.Martes
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.SincroISTrabajo.Miercoles]
Carpeta=Semanal
Clave=SincroISTrabajo.Miercoles
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.SincroISTrabajo.Jueves]
Carpeta=Semanal
Clave=SincroISTrabajo.Jueves
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.SincroISTrabajo.Viernes]
Carpeta=Semanal
Clave=SincroISTrabajo.Viernes
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.SincroISTrabajo.Sabado]
Carpeta=Semanal
Clave=SincroISTrabajo.Sabado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Semanal.SincroISTrabajo.ValorD]
Carpeta=Semanal
Clave=SincroISTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Semanal.SincroISTrabajo.FrecuenciaD]
Carpeta=Semanal
Clave=SincroISTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco


[Mensual.SincroISTrabajo.Valor]
Carpeta=Mensual
Clave=SincroISTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Mensual.SincroISTrabajo.Recurrencia]
Carpeta=Mensual
Clave=SincroISTrabajo.Recurrencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=7
[Mensual.SincroISTrabajo.HoraInicial]
Carpeta=Mensual
Clave=SincroISTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

EspacioPrevio=S
[Mensual.SincroISTrabajo.HoraFinal]
Carpeta=Mensual
Clave=SincroISTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco

[Mensual.SincroISTrabajo.ValorD]
Carpeta=Mensual
Clave=SincroISTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=7
[Mensual.SincroISTrabajo.FrecuenciaD]
Carpeta=Mensual
Clave=SincroISTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=22
ColorFondo=Blanco


[Mensual2.SincroISTrabajo.Tipo]
Carpeta=Mensual2
Clave=SincroISTrabajo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Mensual2.SincroISTrabajo.Dia]
Carpeta=Mensual2
Clave=SincroISTrabajo.Dia
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco

[Mensual2.SincroISTrabajo.HoraInicial]
Carpeta=Mensual2
Clave=SincroISTrabajo.HoraInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

EspacioPrevio=S
[Mensual2.SincroISTrabajo.HoraFinal]
Carpeta=Mensual2
Clave=SincroISTrabajo.HoraFinal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco

[Mensual2.SincroISTrabajo.ValorD]
Carpeta=Mensual2
Clave=SincroISTrabajo.ValorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=10
[Mensual2.SincroISTrabajo.FrecuenciaD]
Carpeta=Mensual2
Clave=SincroISTrabajo.FrecuenciaD
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=18
ColorFondo=Blanco







[Ficha.ListaEnCaptura]
(Inicio)=SincroISTrabajo.Trabajo
SincroISTrabajo.Trabajo=SincroISTrabajo.Nombre
SincroISTrabajo.Nombre=SincroISTrabajo.Descripcion
SincroISTrabajo.Descripcion=SincroISTrabajo.UltimaActualizacion
SincroISTrabajo.UltimaActualizacion=SincroISTrabajo.Activo
SincroISTrabajo.Activo=SincroISTrabajo.Frecuencia
SincroISTrabajo.Frecuencia=SincroISTrabajo.Usuario
SincroISTrabajo.Usuario=SincroISTrabajo.Contrasena
SincroISTrabajo.Contrasena=(Fin)





[Diaria.ListaEnCaptura]
(Inicio)=SincroISTrabajo.Valor
SincroISTrabajo.Valor=SincroISTrabajo.HoraInicial
SincroISTrabajo.HoraInicial=SincroISTrabajo.HoraFinal
SincroISTrabajo.HoraFinal=SincroISTrabajo.ValorD
SincroISTrabajo.ValorD=SincroISTrabajo.FrecuenciaD
SincroISTrabajo.FrecuenciaD=(Fin)











[Semanal.ListaEnCaptura]
(Inicio)=SincroISTrabajo.Recurrencia
SincroISTrabajo.Recurrencia=SincroISTrabajo.HoraInicial
SincroISTrabajo.HoraInicial=SincroISTrabajo.HoraFinal
SincroISTrabajo.HoraFinal=SincroISTrabajo.Lunes
SincroISTrabajo.Lunes=SincroISTrabajo.Martes
SincroISTrabajo.Martes=SincroISTrabajo.Miercoles
SincroISTrabajo.Miercoles=SincroISTrabajo.Jueves
SincroISTrabajo.Jueves=SincroISTrabajo.Viernes
SincroISTrabajo.Viernes=SincroISTrabajo.Sabado
SincroISTrabajo.Sabado=SincroISTrabajo.Domingo
SincroISTrabajo.Domingo=SincroISTrabajo.ValorD
SincroISTrabajo.ValorD=SincroISTrabajo.FrecuenciaD
SincroISTrabajo.FrecuenciaD=(Fin)















[Mensual.ListaEnCaptura]
(Inicio)=SincroISTrabajo.Valor
SincroISTrabajo.Valor=SincroISTrabajo.Recurrencia
SincroISTrabajo.Recurrencia=SincroISTrabajo.HoraInicial
SincroISTrabajo.HoraInicial=SincroISTrabajo.HoraFinal
SincroISTrabajo.HoraFinal=SincroISTrabajo.ValorD
SincroISTrabajo.ValorD=SincroISTrabajo.FrecuenciaD
SincroISTrabajo.FrecuenciaD=(Fin)





































[Mensual2.ListaEnCaptura]
(Inicio)=SincroISTrabajo.Tipo
SincroISTrabajo.Tipo=SincroISTrabajo.Dia
SincroISTrabajo.Dia=SincroISTrabajo.HoraInicial
SincroISTrabajo.HoraInicial=SincroISTrabajo.HoraFinal
SincroISTrabajo.HoraFinal=SincroISTrabajo.ValorD
SincroISTrabajo.ValorD=SincroISTrabajo.FrecuenciaD
SincroISTrabajo.FrecuenciaD=(Fin)

























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
