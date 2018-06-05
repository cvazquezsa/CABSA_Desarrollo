
[Forma]
Clave=vic_PlanoNuevo
Icono=4
Modulos=(Todos)
Nombre=Plano
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
BarraHerramientas=S
IniciarAgregando=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=vic_Plano
CarpetaPrincipal=vic_Plano
PosicionInicialIzquierda=692
PosicionInicialArriba=359
PosicionInicialAlturaCliente=206
PosicionInicialAncho=535
ListaAcciones=(Lista)
[vic_Plano]
Estilo=Ficha
Clave=vic_Plano
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=vic_Plano
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=10
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

[vic_Plano.vic_Plano.Plano]
Carpeta=vic_Plano
Clave=vic_Plano.Plano
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[vic_Plano.vic_Plano.Nombre]
Carpeta=vic_Plano
Clave=vic_Plano.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=58
ColorFondo=Blanco

[vic_Plano.vic_Plano.NombreCorto]
Carpeta=vic_Plano
Clave=vic_Plano.NombreCorto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

[vic_Plano.vic_Plano.Lista]
Carpeta=vic_Plano
Clave=vic_Plano.Lista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

EspacioPrevio=N

[vic_Plano.vic_Plano.Tipoplano]
Carpeta=vic_Plano
Clave=vic_Plano.Tipoplano
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=58
ColorFondo=Blanco
















[Lista.Columnas]
Familia=233

0=-2
1=-2
2=-2
3=-2
4=-2
5=151
6=-2
[vic_TipoPlano.Columnas]
0=108
1=127
2=119
3=149
4=118
5=136
6=-2

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


Antes=S
DespuesGuardar=S
AntesExpresiones=ejecutarsqlanimado(<T>EXEC vic_spInsertaDatosPlano null, null<T>)
[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
EspacioPrevio=S




[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S


[vic_Plano.vic_Plano.Estatus]
Carpeta=vic_Plano
Clave=vic_Plano.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco





[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar Cambios
Cancelar Cambios=Cancelar
Cancelar=(Fin)






























































[vic_Plano.ListaEnCaptura]
(Inicio)=vic_Plano.Plano
vic_Plano.Plano=vic_Plano.NombreCorto
vic_Plano.NombreCorto=vic_Plano.Nombre
vic_Plano.Nombre=vic_Plano.Lista
vic_Plano.Lista=vic_Plano.Tipoplano
vic_Plano.Tipoplano=vic_Plano.Estatus
vic_Plano.Estatus=(Fin)



[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cancelar
Cancelar=(Fin)
