
[Forma]
Clave=POSCobroFormasPago
Icono=0
CarpetaPrincipal=POSCobroFormasPago
Modulos=(Todos)
Nombre=Formas Pago Pantalla Cobro

ListaCarpetas=POSCobroFormasPago
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=220
PosicionInicialArriba=0
PosicionInicialAlturaCliente=689
PosicionInicialAncho=925
ListaAcciones=Aceptar
Comentarios=Info.Sucursal
[POSCobroFormasPago]
Estilo=Ficha
Clave=POSCobroFormasPago
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCobroFormasPago
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=POSCobroFormasPago.Empresa = <T>{Empresa}<T> AND<BR>POSCobroFormasPago.Sucursal = {Info.Sucursal}

[POSCobroFormasPago.POSCobroFormasPago.F2]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.F2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.F3]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.F3
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.F4]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.F4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.F5]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.F5
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCBFormaPago.Columnas]
Codigo=100
FormaPago=172


[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[POSCobroFormasPago.ListaEnCaptura]
(Inicio)=POSCobroFormasPago.F2
POSCobroFormasPago.F2=POSCobroFormasPago.F3
POSCobroFormasPago.F3=POSCobroFormasPago.F4
POSCobroFormasPago.F4=POSCobroFormasPago.F5
POSCobroFormasPago.F5=POSCobroFormasPago.F6
POSCobroFormasPago.F6=POSCobroFormasPago.F7
POSCobroFormasPago.F7=POSCobroFormasPago.F8
POSCobroFormasPago.F8=POSCobroFormasPago.BancoA01
POSCobroFormasPago.BancoA01=POSCobroFormasPago.TDCA01
POSCobroFormasPago.TDCA01=POSCobroFormasPago.BancoA02
POSCobroFormasPago.BancoA02=POSCobroFormasPago.TDCA02
POSCobroFormasPago.TDCA02=POSCobroFormasPago.BancoA03
POSCobroFormasPago.BancoA03=POSCobroFormasPago.TDCA03
POSCobroFormasPago.TDCA03=POSCobroFormasPago.BancoA04
POSCobroFormasPago.BancoA04=POSCobroFormasPago.TDCA04
POSCobroFormasPago.TDCA04=POSCobroFormasPago.BancoA05
POSCobroFormasPago.BancoA05=POSCobroFormasPago.TDCA05
POSCobroFormasPago.TDCA05=POSCobroFormasPago.BancoA06
POSCobroFormasPago.BancoA06=POSCobroFormasPago.TDCA06
POSCobroFormasPago.TDCA06=POSCobroFormasPago.BancoA07
POSCobroFormasPago.BancoA07=POSCobroFormasPago.TDCA07
POSCobroFormasPago.TDCA07=POSCobroFormasPago.BancoA08
POSCobroFormasPago.BancoA08=POSCobroFormasPago.TDCA08
POSCobroFormasPago.TDCA08=POSCobroFormasPago.BancoB01
POSCobroFormasPago.BancoB01=POSCobroFormasPago.TDCB01
POSCobroFormasPago.TDCB01=POSCobroFormasPago.BancoB02
POSCobroFormasPago.BancoB02=POSCobroFormasPago.TDCB02
POSCobroFormasPago.TDCB02=POSCobroFormasPago.BancoB03
POSCobroFormasPago.BancoB03=POSCobroFormasPago.TDCB03
POSCobroFormasPago.TDCB03=POSCobroFormasPago.BancoB04
POSCobroFormasPago.BancoB04=POSCobroFormasPago.TDCB04
POSCobroFormasPago.TDCB04=POSCobroFormasPago.BancoB05
POSCobroFormasPago.BancoB05=POSCobroFormasPago.TDCB05
POSCobroFormasPago.TDCB05=POSCobroFormasPago.BancoB06
POSCobroFormasPago.BancoB06=POSCobroFormasPago.TDCB06
POSCobroFormasPago.TDCB06=POSCobroFormasPago.BancoB07
POSCobroFormasPago.BancoB07=POSCobroFormasPago.TDCB07
POSCobroFormasPago.TDCB07=POSCobroFormasPago.BancoB08
POSCobroFormasPago.BancoB08=POSCobroFormasPago.TDCB08
POSCobroFormasPago.TDCB08=POSCobroFormasPago.BancoC01
POSCobroFormasPago.BancoC01=POSCobroFormasPago.TDCC01
POSCobroFormasPago.TDCC01=POSCobroFormasPago.BancoC02
POSCobroFormasPago.BancoC02=POSCobroFormasPago.TDCC02
POSCobroFormasPago.TDCC02=POSCobroFormasPago.BancoC03
POSCobroFormasPago.BancoC03=POSCobroFormasPago.TDCC03
POSCobroFormasPago.TDCC03=POSCobroFormasPago.BancoC04
POSCobroFormasPago.BancoC04=POSCobroFormasPago.TDCC04
POSCobroFormasPago.TDCC04=POSCobroFormasPago.BancoC05
POSCobroFormasPago.BancoC05=POSCobroFormasPago.TDCC05
POSCobroFormasPago.TDCC05=POSCobroFormasPago.BancoC06
POSCobroFormasPago.BancoC06=POSCobroFormasPago.TDCC06
POSCobroFormasPago.TDCC06=POSCobroFormasPago.BancoC07
POSCobroFormasPago.BancoC07=POSCobroFormasPago.TDCC07
POSCobroFormasPago.TDCC07=POSCobroFormasPago.BancoC08
POSCobroFormasPago.BancoC08=POSCobroFormasPago.TDCC08
POSCobroFormasPago.TDCC08=(Fin)


[POSCobroFormasPago.POSCobroFormasPago.F6]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.F6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.F7]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.F7
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.F8]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.F8
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[POSCobroFormasPago.POSCobroFormasPago.BancoA01]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoA01
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoA02]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoA02
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoA03]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoA03
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoA04]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoA04
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoA05]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoA05
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoA06]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoA06
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoA07]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoA07
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoA08]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoA08
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoB01]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoB01
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoB02]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoB02
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoB03]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoB03
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoB04]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoB04
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoB05]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoB05
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoB06]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoB06
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoB07]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoB07
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoB08]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoB08
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoC01]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoC01
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoC02]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoC02
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoC03]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoC03
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoC04]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoC04
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoC05]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoC05
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoC06]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoC06
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoC07]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoC07
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.BancoC08]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.BancoC08
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[POSCobroFormasPago.POSCobroFormasPago.TDCA01]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCA01
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCA02]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCA02
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCA03]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCA03
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCA04]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCA04
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCA05]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCA05
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCA06]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCA06
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCA07]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCA07
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCA08]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCA08
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCB01]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCB01
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCB02]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCB02
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCB03]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCB03
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCB04]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCB04
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCB05]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCB05
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCB06]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCB06
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCB07]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCB07
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCB08]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCB08
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCC01]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCC01
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCC02]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCC02
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCC03]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCC03
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCC04]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCC04
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCC05]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCC05
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCC06]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCC06
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCC07]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCC07
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[POSCobroFormasPago.POSCobroFormasPago.TDCC08]
Carpeta=POSCobroFormasPago
Clave=POSCobroFormasPago.TDCC08
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco


