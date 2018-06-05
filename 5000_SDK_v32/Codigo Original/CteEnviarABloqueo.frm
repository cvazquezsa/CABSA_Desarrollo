[Forma]
Clave=CteEnviarABloqueo
Nombre=Bloquear/Desbloquear Sucursal Especifica
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=322
PosicionInicialArriba=320
PosicionInicialAltura=127
PosicionInicialAncho=380
BarraAcciones=S
AccionesTamanoBoton=22x5
AccionesDivision=S
ListaAcciones=(Lista)
AccionesCentro=S
ExpresionesAlMostrar=Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.EnviarA, Nulo)<BR>Asigna(Info.Bloqueo, Nulo)

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
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

[(Variables).Info.Cliente]
Carpeta=(Variables)
Clave=Info.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Bloqueo]
Carpeta=(Variables)
Clave=Info.Bloqueo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Bloquear]
Nombre=Bloquear
Boton=0
NombreDesplegar=&Aplicar el Bloqueo
EnBarraAcciones=S
TipoAccion=Expresion
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>Bloquear<BR>Cerrar

[Acciones.Desbloquear]
Nombre=Desbloquear
Boton=0
NombreDesplegar=&Desbloquear Sucursal
EnBarraAcciones=S
TipoAccion=Expresion
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>Desbloquear<BR>Cerrar

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Bloquear.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Bloquear.Bloquear]
Nombre=Bloquear
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
Expresion=Si<BR>  Confirmacion(<T>Esta seguro que desea bloquear a <T>+Info.Cliente+<T>, Sucursal <T>+Info.EnviarA+<T> ?<T>, BotonSi, BotonNo)=BotonSi<BR>Entonces<BR>  EjecutarSQL(<T>spCteEnviarAEstatus :tCliente, :nID, :tEstatus<T>, Info.Cliente, Info.EnviarA, Info.Bloqueo)<BR>Sino<BR>   AbortarOperacion <BR>Fin
EjecucionCondicion=ConDatos(Info.Cliente) y ConDatos(Info.EnviarA) y ConDatos(Info.Bloqueo)
EjecucionMensaje=<T>Falta llenar datos<T>

[Acciones.Desbloquear.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Desbloquear.Desbloquear]
Nombre=Desbloquear
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
Expresion=Si<BR>  Confirmacion(<T>Esta seguro que desea desbloquear a <T>+Info.Cliente+<T>, Sucursal <T>+Info.EnviarA+<T> ?<T>, BotonSi, BotonNo)=BotonSi<BR>Entonces<BR>  EjecutarSQL(<T>spCteEnviarAEstatus :tCliente, :nID, :tEstatus<T>, Info.Cliente, Info.EnviarA, <T>NORMAL<T>)<BR>Sino<BR>   AbortarOperacion <BR>Fin
EjecucionCondicion=ConDatos(Info.Cliente)
EjecucionMensaje=<T>Falta indicar el cliente<T>

[Acciones.Bloquear.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Desbloquear.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[(Variables).Info.EnviarA]
Carpeta=(Variables)
Clave=Info.EnviarA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Bloquear
Bloquear=Desbloquear
Desbloquear=Cancelar
Cancelar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.Cliente
Info.Cliente=Info.EnviarA
Info.EnviarA=Info.Bloqueo
Info.Bloqueo=(Fin)
