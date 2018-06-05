
[Forma]
Clave=POSLDISeguros
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=304
PosicionInicialArriba=168
PosicionInicialAlturaCliente=353
PosicionInicialAncho=415
Nombre=Info.Servicio
ExpresionesAlMostrar=Asigna(Info.ImporteLDI,Info.Importe)<BR>Asigna(Info.LDICB,Nulo)<BR>Asigna(Info.POSNoTelefono,Nulo)<BR>Asigna(Info.POSNoTelefonoConf,Nulo)
ExpresionesAlCerrar=Asigna(Info.IDTexto, SQL(<T>SELECT MAX(ID) FROM POSL WHERE Host = :tHost AND (Estatus IS NULL OR Estatus in (:tEstatus, :tEst2) AND Cajero = :tCajero)<T>, Info.POSHost, <T>SINAFECTAR<T>, <T>PORCOBRAR<T>, SQL(<T>SELECT defCajero FROM Usuario WHERE Usuario = :tUsu<T>, Usuario )))<BR>Asigna(Temp.Reg, SQL(<T>spPOS :tEstacion, :tCodigo, :tEmpresa, :tModulo, :nSucursal, :tUsuario, :tReferencia, :tID<T>, EstacionTrabajo, Info.Codigo, Info.Empresa, <T>VTAS<T>, Sucursal, Usuario, Info.Referencia, Info.IDTexto))<BR><BR>Asigna(Info.IDTexto, Temp.Reg[1])<BR>Asigna(Ver.Ticket, TextoEnLista(Temp.Reg[2]))<BR>Asigna(Ver.Totales, TextoEnLista(Temp.Reg[3]))<BR>Asigna(Ver.Aviso, TextoEnLista(Temp.Reg[5]))<BR>Asigna(Ver.Memo, TextoEnLista(Temp.Reg[6]))<BR>Asigna(Ver.Total, Temp.Reg[8])<BR>Asigna(Info.Saldo, Temp.Reg[9])<BR>Asigna(Info.Importe, Temp.Reg[9])<BR>Asigna(Ver.Saldo, Temp.Reg[9])<BR>Asigna(Ver.Imagen, Temp.Reg[11])
[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

ConCondicion=S
EjecucionConError=S
Expresion=EjecutarSQL(<T>spPOSInsertarLDIPagoServicioTemp :tID, :tServicio, :tEmpresa, :tUsuario, :nSucursal, :nImporte, :tCodigo<T>,Info.IDTexto, Info.Servicio, Empresa, Usuario, Sucursal, Info.ImporteLDI,Info.LDICB)<BR>Asigna(Info.ImporteLDI,Nulo)<BR>Asigna(Info.LDICB,Nulo)
EjecucionCondicion=Info.POSNoTelefono = Info.POSNoTelefonoConf
EjecucionMensaje=<T>El telefono confirmado no corresponde<T>
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S

[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 20, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PermiteEditar=S
ConFuenteEspecial=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Negro




[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S




[Acciones.Cancelar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spPOSEliminarLDIPagoServicioTemp :tID, :tServicio, :tEmpresa, :tUsuario, :nSucursal, :nImporte, :tCodigo<T>,Info.IDTexto, Info.Servicio, Empresa, Usuario, Sucursal, Info.ImporteLDI,Info.LDICB)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S




[Acciones.Cancelar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)









[(Variables).Info.POSNoTelefono]
Carpeta=(Variables)
Clave=Info.POSNoTelefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.POSNoTelefonoConf]
Carpeta=(Variables)
Clave=Info.POSNoTelefonoConf
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[(Variables).Info.LDICB]
Carpeta=(Variables)
Clave=Info.LDICB
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco










[(Variables).Info.ImporteLDI]
Carpeta=(Variables)
Clave=Info.ImporteLDI
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata











[(Variables).ListaEnCaptura]
(Inicio)=Info.POSNoTelefono
Info.POSNoTelefono=Info.POSNoTelefonoConf
Info.POSNoTelefonoConf=Info.LDICB
Info.LDICB=Info.ImporteLDI
Info.ImporteLDI=(Fin)


[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Aceptar
Aceptar=(Fin)



















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
