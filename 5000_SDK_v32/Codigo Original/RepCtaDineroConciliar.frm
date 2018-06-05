[Forma]
Clave=RepCtaDineroConciliar
Nombre=Movimientos por Conciliar
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=386
PosicionInicialArriba=321
PosicionInicialAltura=118
PosicionInicialAncho=251
AccionesTamanoBoton=25x5
ListaAcciones=(Lista)
AccionesCentro=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesDivision=S
VentanaExclusiva=S
BarraHerramientas=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=91

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
[(Variables)]
Estilo=Ficha
Pestana=
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PermiteEditar=S
FichaEspacioEntreLineas=7
FichaEspacioNombres=103
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
ListaEnCaptura=(Lista)
InicializarVariables=S

[(Variables).Info.CtaDineroD]
Carpeta=(Variables)
Clave=Info.CtaDineroD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[(Variables).Info.CtaDineroA]
Carpeta=(Variables)
Clave=Info.CtaDineroA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Acciones.RepPan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=Variables Asignar<BR>Conciliar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.RepPan.Conciliar]
Nombre=Conciliar
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=CtaDineroConciliar
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=ConDatos(Info.CtaDineroD) y ConDatos(Info.CtaDineroA)
EjecucionMensaje=<T>Es Necesario especificar la(s) Cuenta(s)<T>

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir.CtaDineroConciliar]
Nombre=CtaDineroConciliar
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=CtaDineroConciliar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Info.CtaDineroD) y ConDatos(Info.CtaDineroA)
EjecucionMensaje=<T>Es Necesario especificar la(s) Cuenta(s)<T>
EjecucionConError=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=Variables Asignar<BR>CtaDineroConciliar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S


[(Variables).ListaEnCaptura]
(Inicio)=Info.CtaDineroD
Info.CtaDineroD=Info.CtaDineroA
Info.CtaDineroA=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
