
[Forma]
Clave=SerieTarjetaMovRedimir2
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Redime Puntos

ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=535
PosicionInicialArriba=311
PosicionInicialAlturaCliente=126
PosicionInicialAncho=500
BarraAcciones=S
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
AccionesCentro=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Por diseño
VentanaEstadoInicial=Normal
VentanaColor=Plata
[(Variables)]
Estilo=Ficha
Clave=(Variables)
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
PermiteEditar=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Plata

[(Variables).Info.MonederoCBSerie]
Carpeta=(Variables)
Clave=Info.MonederoCBSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.MonederoRedimeImp]
Carpeta=(Variables)
Clave=Info.MonederoRedimeImp
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Acciones.Saldo.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Saldo.RepSaldoMonederoCB]
Nombre=RepSaldoMonederoCB
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=RepSaldoMonederoCB
Activo=S
Visible=S

[Acciones.Saldo]
Nombre=Saldo
Boton=0
NombreEnBoton=S
NombreDesplegar=Saldo
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
[Acciones.Saldo.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=RepSaldoMonederoCB
RepSaldoMonederoCB=(Fin)

[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Mensaje,nulo)<BR>Asigna(Info.Mensaje,SQL(<T>EXEC spMonederoCBRefimir :tEmpresa, :nSucursal, :tModulo, :nID, :tSerie, :nImporte, :nPOS<T>, Empresa, Sucursal, <T>VTAS<T>, Info.MonederoCBID, Info.MonederoCBSerie, Info.MonederoRedimeImp, Info.MonederoCBPosicion))<BR>Si<BR>  ConDatos(Info.Mensaje)<BR>Entonces<BR>  Error(Info.Mensaje)<BR>Fin<BR>//Forma.ActualizarVista(<T>VentaCobro<T>)<BR>//Forma.ActualizarForma(<T>VentaCobro<T>)
[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
ConCondicion=S
EjecucionCondicion=Vacio(Info.Mensaje)
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreEnBoton=S
NombreDesplegar=Aceptar
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S

[(Variables).ListaEnCaptura]
(Inicio)=Info.MonederoCBSerie
Info.MonederoCBSerie=Info.MonederoRedimeImp
Info.MonederoRedimeImp=(Fin)






[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=SQL
SQL=Cerrar
Cerrar=(Fin)



[Forma.ListaAcciones]
(Inicio)=Saldo
Saldo=Aceptar
Aceptar=(Fin)
