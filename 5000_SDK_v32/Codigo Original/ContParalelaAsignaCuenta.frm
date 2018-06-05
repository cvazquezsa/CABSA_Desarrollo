
[Forma]
Clave=ContParalelaAsignaCuenta
Icono=0
Modulos=(Todos)
Nombre=Asigna Cuenta

ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=557
PosicionInicialArriba=297
PosicionInicialAlturaCliente=95
PosicionInicialAncho=252
BarraHerramientas=S
MovModulo=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaExclusiva=S
VentanaExclusivaOpcion=2
ExpresionesAlMostrar=Asigna(Info.ContParalelaCuentaA,SQL(<T>SELECT MAX(Cuenta) FROM ContParalelaCta WHERE Rama = :tRama AND ID = :nID<T>,Info.Rama, Info.ID))
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
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
CarpetaVisible=S
ListaEnCaptura=(Lista)

PestanaOtroNombre=S
PestanaNombre=Asigna Código


[Acciones.Aceptar.AsignaVariables]
Nombre=AsignaVariables
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=Aceptar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S

NombreEnBoton=S

[Acciones.Aceptar.AsignaCodigo]
Nombre=AsignaCodigo
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


ConCondicion=S
EjecucionConError=S
Expresion=Asigna(Info.Observaciones, SQL(<T>spContParalelaAsignaCuenta :nID, :tCuentaD,:tCuentaA,:tCuentaAsignada<T>, Info.ID, Info.ContParalelaCuentaD, Info.ContParalelaCuentaA, Info.Valor))<BR>Informacion(Info.Observaciones)<BR>Asigna(Info.Estatus, <T>OK<T>)
EjecucionCondicion=ConDatos(Info.ContParalelaCuentaD) y ConDatos(Info.ContParalelaCuentaA) y ConDatos(Info.Valor)
EjecucionMensaje=<T>Debe asignar valores a todos los campos<T>
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

ConCondicion=S

EjecucionCondicion=Info.Estatus = <T>OK<T>
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S










EspacioPrevio=S

[Lista.Columnas]
0=207
ClaveSAT=152
Descripcion=161
Rama=124













[(Variables).ListaEnCaptura]
(Inicio)=Info.ContParalelaCuentaD
Info.ContParalelaCuentaD=Info.ContParalelaCuentaA
Info.ContParalelaCuentaA=(Fin)

[(Variables).Info.ContParalelaCuentaD]
Carpeta=(Variables)
Clave=Info.ContParalelaCuentaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ContParalelaCuentaA]
Carpeta=(Variables)
Clave=Info.ContParalelaCuentaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=AsignaVariables
AsignaVariables=AsignaCodigo
AsignaCodigo=Aceptar
Aceptar=(Fin)





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
