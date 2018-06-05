
[Forma]
Clave=MESArtExistenciaInt
Icono=0
CarpetaPrincipal=MESArtExistenciaInt
Modulos=(Todos)
Nombre=Cuadrar Existencias Intelisis/Factory

ListaCarpetas=MESArtExistenciaInt
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=258
PosicionInicialArriba=160
PosicionInicialAlturaCliente=561
PosicionInicialAncho=763
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
ExpresionesAlMostrar=EjecutarSQL(<T>spInicializarArtExistenciaIntMES<T>)<BR>Asigna(Info.Sucursal,nulo)
[MESArtExistenciaInt]
Estilo=Hoja
Clave=MESArtExistenciaInt
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MESArtExistenciaInt
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)


PermiteEditar=S
[MESArtExistenciaInt.MESArtExistenciaInt.Articulo]
Carpeta=MESArtExistenciaInt
Clave=MESArtExistenciaInt.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MESArtExistenciaInt.MESArtExistenciaInt.SubCuenta]
Carpeta=MESArtExistenciaInt
Clave=MESArtExistenciaInt.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[MESArtExistenciaInt.MESArtExistenciaInt.SerieLote]
Carpeta=MESArtExistenciaInt
Clave=MESArtExistenciaInt.SerieLote
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MESArtExistenciaInt.MESArtExistenciaInt.Almacen]
Carpeta=MESArtExistenciaInt
Clave=MESArtExistenciaInt.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[MESArtExistenciaInt.MESArtExistenciaInt.ExistenciaInte]
Carpeta=MESArtExistenciaInt
Clave=MESArtExistenciaInt.ExistenciaInte
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MESArtExistenciaInt.MESArtExistenciaInt.ExistenciaMES]
Carpeta=MESArtExistenciaInt
Clave=MESArtExistenciaInt.ExistenciaMES
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MESArtExistenciaInt.Columnas]
Articulo=124
SubCuenta=130
SerieLote=124
Almacen=103
ExistenciaInte=116
ExistenciaMES=120

[Acciones.Cuadrar MES]
Nombre=Cuadrar MES
Boton=82
NombreEnBoton=S
NombreDesplegar=&Cuadrar Factory desde Intelisis
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S



EspacioPrevio=S
Multiple=S
ListaAccionesMultiples=(Lista)
ConCondicion=S
EjecucionCondicion=conDatos(Info.Sucursal)
[Acciones.Cuadrar Intelisis]
Nombre=Cuadrar Intelisis
Boton=82
NombreEnBoton=S
NombreDesplegar=&Cuadrar Intelisis desde Factory
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S


EspacioPrevio=S
ConCondicion=S
Multiple=S
ListaAccionesMultiples=(Lista)
EjecucionCondicion=conDatos(Info.Sucursal)
[Acciones.Solicitar]
Nombre=Solicitar
Boton=7
NombreEnBoton=S
NombreDesplegar=Solicitar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S








EspacioPrevio=S

Antes=S
Expresion=Si(ConDatos(Info.Sucursal),EjecutarSQL(<T>spSolicitarExistenciaMES :tEmpresa,:tUsuario,:nSucursal<T>,Empresa,Usuario,Info.Sucursal),Error(<T>Es Necesario Asignar la sucursal<T>))<BR>ActualizarForma
AntesExpresiones=FormaModal(<T>EspecificarSucursal<T>)
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S







































[Acciones.Cuadrar MES.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=SI Precaucion( <T>¡Precaución!. Este proceso requiere que ningún usuario esté firmado en el sistema. Se harán ajustes automáticos<BR>en el inventario para cuadrar las existencias, está seguro? <T> ,BotonSi , BotonNo )= BotonSi<BR>ENTONCES<BR>EjecutarSQL(<T>EXEC spSolicitarExistenciaMES :tEmpresa, :tUsuario, :nSucursal <T>, Empresa, Usuario, Info.Sucursal)<BR>ProcesarSQL(<T>EXEC spInforCuadrarExistenciaMES :tUsuario,:tEmpresa, :nSucursal<T>,Usuario, Empresa, Info.Sucursal)<BR>FIN
[Acciones.Cuadrar MES.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S






[MESArtExistenciaInt.ListaEnCaptura]
(Inicio)=MESArtExistenciaInt.Articulo
MESArtExistenciaInt.Articulo=MESArtExistenciaInt.SubCuenta
MESArtExistenciaInt.SubCuenta=MESArtExistenciaInt.SerieLote
MESArtExistenciaInt.SerieLote=MESArtExistenciaInt.Almacen
MESArtExistenciaInt.Almacen=MESArtExistenciaInt.ExistenciaInte
MESArtExistenciaInt.ExistenciaInte=MESArtExistenciaInt.ExistenciaMES
MESArtExistenciaInt.ExistenciaMES=(Fin)


























[Acciones.Cuadrar MES.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)














[Acciones.Cuadrar Intelisis.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=SI Precaucion( <T>¡Precaución!. Este proceso requiere que ningún usuario esté firmado en el sistema. Se harán ajustes automáticos<BR>en el inventario para cuadrar las existencias, está seguro? <T> ,BotonSi , BotonNo )= BotonSi<BR>ENTONCES<BR>EjecutarSQL(<T>spSolicitarExistenciaMES :tEmpresa,:tUsuario,:nSucursal<T>,Empresa,Usuario,Info.Sucursal)<BR>ProcesarSQL(<T>spInforCuadrarExistenciaIntelisis :tEmpresa,:tUsuario,:nSucursal,:nEstacion<T>,Empresa,Usuario,Sucursal, EstacionTrabajo )<BR>ActualizarForma<BR>FIN
Activo=S
Visible=S

[Acciones.Cuadrar Intelisis.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cuadrar Intelisis.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)




[Acciones.Enviar a Excel]
Nombre=Enviar a Excel
Boton=67
NombreEnBoton=S
NombreDesplegar=&Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Solicitar
Solicitar=Cuadrar MES
Cuadrar MES=Cuadrar Intelisis
Cuadrar Intelisis=Enviar a Excel
Enviar a Excel=(Fin)
