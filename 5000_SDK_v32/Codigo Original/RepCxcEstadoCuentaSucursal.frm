[Forma]
Clave=RepCxcEstadoCuentaSucursal
Icono=0
Modulos=(Todos)
Nombre=Estado de Cuenta por Sucursal
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=242
PosicionInicialAncho=325
PosicionInicialIzquierda=520
PosicionInicialArriba=223
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=EjecutarSQL(<T>spEstadoCuenta3 :nEstacion<T>, EstacionTrabajo)

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
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
PestanaOtroNombre=S
PestanaNombre=Estado De Cuentas
PermiteEditar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=RepParam.Estacion = {EstacionTrabajo}

[Ficha.RepParam.InfoEstatusEspecifico]
Carpeta=Ficha
Clave=RepParam.InfoEstatusEspecifico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Pantalla
ClaveAccion=RepCxcEstadoCuentaSucursal
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Preliminar
GuardarAntes=S
Antes=S
AntesExpresiones=Asigna(Info.ClienteEnviarA, RepParam:RepParam.InfoClienteEnviarA)<BR>Asigna(Info.Moneda, RepParam:RepParam.InfoMoneda)<BR>Asigna(Info.Estatus, RepParam:RepParam.InfoEstatus)<BR>Asigna(Info.Sucursal, RepParam:RepParam.InfoSucursal)<BR>Asigna(Rep.Titulo, RepParam:RepParam.RepTitulo)<BR>Asigna(Info.FechaA, RepParam:RepParam.InfoFechaA)

[Ficha.RepParam.InfoMoneda]
Carpeta=Ficha
Clave=RepParam.InfoMoneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Impresora
ClaveAccion=CxcEstadoCuentaSucursal
Activo=S
Visible=S
Antes=S
GuardarAntes=S
AntesExpresiones=Asigna(Info.ClienteEnviarA, RepParam:RepParam.InfoClienteEnviarA)<BR>Asigna(Info.Moneda, RepParam:RepParam.InfoMoneda)<BR>Asigna(Info.Estatus, RepParam:RepParam.InfoEstatus)<BR>Asigna(Info.Sucursal, RepParam:RepParam.InfoSucursal)<BR>Asigna(Rep.Titulo, RepParam:RepParam.RepTitulo)<BR>Asigna(Info.FechaA, RepParam:RepParam.InfoFechaA)

[Ficha.RepParam.RepTitulo]
Carpeta=Ficha
Clave=RepParam.RepTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107
0=66
1=60
2=206
3=104
4=-2

[Acciones.RepPan.Preliminar]
Nombre=Preliminar
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=CxcEstadoCuentaSucursal
Activo=S
Visible=S

[Ficha.RepParam.InfoClienteEnviarA]
Carpeta=Ficha
Clave=RepParam.InfoClienteEnviarA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[Ficha.RepParam.InfoCliente]
Carpeta=Ficha
Clave=RepParam.InfoCliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Ficha.RepParam.InfoFechaA]
Carpeta=Ficha
Clave=RepParam.InfoFechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[Ficha.ListaEnCaptura]
(Inicio)=RepParam.InfoCliente
RepParam.InfoCliente=RepParam.InfoFechaA
RepParam.InfoFechaA=RepParam.InfoClienteEnviarA
RepParam.InfoClienteEnviarA=RepParam.InfoEstatusEspecifico
RepParam.InfoEstatusEspecifico=RepParam.InfoMoneda
RepParam.InfoMoneda=RepParam.RepTitulo
RepParam.RepTitulo=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
