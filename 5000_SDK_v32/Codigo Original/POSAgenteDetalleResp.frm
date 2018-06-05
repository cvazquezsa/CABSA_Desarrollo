
[Forma]
Clave=POSAgenteDetalle
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Agente

ListaCarpetas=Principal
CarpetaPrincipal=Principal
PosicionInicialIzquierda=634
PosicionInicialArriba=437
PosicionInicialAlturaCliente=135
PosicionInicialAncho=544
BarraAcciones=S
AccionesTamanoBoton=20x5
ListaAcciones=(Lista)
Menus=S
AccionesCentro=S
AccionesDivision=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaExclusiva=S
VentanaSinIconosMarco=S
VentanaExclusivaOpcion=0
PosicionSec1=451
PosicionSec2=546
PosicionCol1=892
PosicionCol2=537
PosicionCol3=581
ExpresionesAlMostrar=Asigna(Info.Agente, SQL(<T>SELECT Agente FROM POSL WHERE ID =:tID<T>, Info.IDTexto))<BR>Asigna(Info.Nombre, nulo)
ExpresionesAlCerrar=EjecutarSQL(<T>spPOSInicializar  :tEmpresa, :nSucursal, :tUsuario, :nEstacion, :tID<T>,Empresa, Sucursal, Usuario, EstacionTrabajo, Info.IDTexto)<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))
[Principal]
Estilo=Ficha
PestanaOtroNombre=S
Clave=Principal
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Negro

PermiteEditar=S

CampoAccionAlEnter=Nombre
[Lista.Columnas]
0=105
1=247

[Principal.Info.Agente]
Carpeta=Principal
Clave=Info.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

AccionAlEnter=Nombre
[Acciones.Nombre]
Nombre=Nombre
Boton=0
NombreDesplegar=Nombre
TipoAccion=Expresion
Activo=S
Visible=S


Multiple=S
ListaAccionesMultiples=(Lista)
[Principal.Info.Nombre]
Carpeta=Principal
Clave=Info.Nombre
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=$00EAEAEA



Efectos=[Negritas]

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=Aceptar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



NombreEnBoton=S























Multiple=S
ListaAccionesMultiples=(Lista)
RefrescarDespues=S
[Principal.ListaEnCaptura]
(Inicio)=Info.Agente
Info.Agente=Info.Nombre
Info.Nombre=(Fin)


[Acciones.Nombre.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Nombre, SQL(<T>SELECT Nombre FROM Agente WHERE Agente=:ta<T>, Info.Agente))<BR>Si<BR>  Info.Nombre = nulo<BR>Entonces<BR>   Error( <T>Verificar Agente<T>,  BotonAceptar )<BR>Sino<BR>   <T><T><BR>Fin<BR><BR>Asigna(Temp.Texto, SQL(<T>spPOSActualizaAgenteDetalle :@ID, :@Agente, :@Renglon, :@Sucusal<T>, Info.IDTexto, Info.Agente, Info.Renglon, Sucursal))<BR>Si<BR>  Temp.Texto <>  nulo<BR>Entonces<BR>  Informacion(Temp.Texto)<BR>Sino<BR>  <T><T><BR>Fin
[Acciones.Nombre.variables Asignar]
Nombre=variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S










[Acciones.Aceptar.expresion]
Nombre=expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S










[Acciones.Aceptar.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Aceptar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S



[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
















ConCondicion=S
EjecucionCondicion=ConDatos(Info.Agente)
EjecucionMensaje=<T>Asigne el Agente Vendedor<T>
EjecucionConError=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Actualizar Forma
Actualizar Forma=Actualizar Vista
Actualizar Vista=Cerrar
Cerrar=(Fin)


















[Acciones.Nombre.ListaAccionesMultiples]
(Inicio)=variables Asignar
variables Asignar=Expresion
Expresion=(Fin)











[Forma.ListaAcciones]
(Inicio)=Nombre
Nombre=Aceptar
Aceptar=(Fin)
