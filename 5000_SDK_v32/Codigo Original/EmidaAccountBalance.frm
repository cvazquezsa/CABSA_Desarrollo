
[Forma]
Clave=EmidaAccountBalance
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Emida - Consulta de Saldo
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Datos
CarpetaPrincipal=Datos
PosicionInicialIzquierda=264
PosicionInicialArriba=151
PosicionInicialAlturaCliente=387
PosicionInicialAncho=752
Comentarios=Lista(Empresa, Info.Sucursal)
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Datos]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Datos
Clave=Datos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmidaAccountBalance
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

Filtros=S
OtroOrden=S
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=50
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=EmidaAccountBalance.URL
FiltroValida1=EmidaAccountBalance.URL
FiltroGeneral=EmidaAccountBalance.Empresa = <T>{Empresa}<T> AND Sucursal = {Sucursal}
[Datos.EmidaAccountBalance.availableBalance]
Carpeta=Datos
Clave=EmidaAccountBalance.availableBalance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco








[Datos.EmidaAccountBalance.legalBusinessname]
Carpeta=Datos
Clave=EmidaAccountBalance.legalBusinessname
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Datos.EmidaAccountBalance.dba]
Carpeta=Datos
Clave=EmidaAccountBalance.dba
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco



[Acciones.ActualizarSaldo]
Nombre=ActualizarSaldo
Boton=7
NombreEnBoton=S
NombreDesplegar=&Actualizar Saldo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
















Expresion=ProcesarSQL(<T>EXEC spEmidaGetAccountBalance :nEstacion, :tEmpresa, :nSucursal, :tUsuario<T>, EstacionTrabajo, Empresa, Sucursal, Usuario)<BR>ActualizarVista<BR>ActualizarForma<BR>Forma.ActualizarArbol(<T>Datos<T>)






[Datos.ListaEnCaptura]
(Inicio)=EmidaAccountBalance.dba
EmidaAccountBalance.dba=EmidaAccountBalance.legalBusinessname
EmidaAccountBalance.legalBusinessname=EmidaAccountBalance.availableBalance
EmidaAccountBalance.availableBalance=(Fin)

[Datos.ListaOrden]
(Inicio)=EmidaAccountBalance.Empresa	(Acendente)
EmidaAccountBalance.Empresa	(Acendente)=EmidaAccountBalance.URL	(Acendente)
EmidaAccountBalance.URL	(Acendente)=(Fin)











[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=ActualizarSaldo
ActualizarSaldo=(Fin)
