
[Forma]
Clave=ProyCxcEstadoCuenta
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Estado de Cuenta


ListaCarpetas=RepParam
CarpetaPrincipal=RepParam
BarraAcciones=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=470
PosicionInicialArriba=252
PosicionInicialAlturaCliente=185
PosicionInicialAncho=339
BarraHerramientas=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[ProyCxcEstadoCuenta.ListaEnCaptura]
(Inicio)=Info.Proyecto
Info.Proyecto=Info.Moneda
Info.Moneda=(Fin)




[Acciones.Preeliminar]
Nombre=Preeliminar
Boton=108
NombreEnBoton=S
NombreDesplegar=&Preeliminar
TipoAccion=Reportes Pantalla
Activo=S
Visible=S

EnBarraHerramientas=S



GuardarAntes=S
ClaveAccion=ProyCxcEstadoCuenta
[Lista.Columnas]
0=135
1=192
Moneda=144
TipoCambio=69







[(Variables).ListaEnCaptura]
(Inicio)=Info.Proyecto
Info.Proyecto=Info.Moneda
Info.Moneda=(Fin)

[RepParam]
Estilo=Ficha
Clave=RepParam
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=RepParam.Estacion={EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
[RepParam.RepParam.InfoProyectoA]
Carpeta=RepParam
Clave=RepParam.InfoProyectoA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[RepParam.RepParam.InfoMoneda]
Carpeta=RepParam
Clave=RepParam.InfoMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco






[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S






[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
TipoAccion=Reportes Impresora
ClaveAccion=ProyCxcEstadoCuenta
Activo=S
Visible=S





EspacioPrevio=S






















































Antes=S
GuardarAntes=S
AntesExpresiones=GuardarCambios
[RepParam.RepParam.InfoProyectoD]
Carpeta=RepParam
Clave=RepParam.InfoProyectoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

























[Acciones.Preeliminar.Reppant]
Nombre=Reppant
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=ProyCxcEstadoCuenta
Activo=S
Visible=S








[Acciones.Preeliminar.ListaAccionesMultiples]
(Inicio)=Guardar
Guardar=Reppant
Reppant=(Fin)




























[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoProyectoD
RepParam.InfoProyectoD=RepParam.InfoProyectoA
RepParam.InfoProyectoA=RepParam.InfoMoneda
RepParam.InfoMoneda=(Fin)











































































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preeliminar
Preeliminar=(Fin)
