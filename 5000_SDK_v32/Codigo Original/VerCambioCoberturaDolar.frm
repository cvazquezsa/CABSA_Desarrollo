[Forma]
Clave=VerCambioCoberturaDolar
Nombre=Dolar Compra/Venta
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=132
PosicionInicialArriba=174
PosicionInicialAltura=152
PosicionInicialAncho=211
VentanaSiempreAlFrente=S
VentanaTipoMarco=Chico (Variable)
VentanaPosicionInicial=por Omisión
ExpresionesAlCerrar=Si(Confirmacion(<T>¿ Desea Cerrar la Ventana de Coberturas ?<T>, BotonSi, BotonNo)=BotonNo, AbortarOperacion)
PosicionInicialAlturaCliente=118

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerCambioCoberturaDolar
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=$00004080
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
AutoRefrescar=S
TiempoRefrescar=00:30

[Ficha.CompraEfectivo]
Carpeta=Ficha
Clave=CompraEfectivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=7
ColorFondo=Plata
ColorFuente=$00004080
Efectos=[Negritas]

[Ficha.VentaEfectivo]
Carpeta=Ficha
Clave=VentaEfectivo
Editar=S
ValidaNombre=N
3D=N
Tamano=7
ColorFondo=Plata
ColorFuente=Azul
Efectos=[Negritas]

[Ficha.CompraCheque]
Carpeta=Ficha
Clave=CompraCheque
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=7
ColorFondo=Plata
ColorFuente=$00004080
Efectos=[Negritas]
EspacioPrevio=S

[Ficha.VentaCheque]
Carpeta=Ficha
Clave=VentaCheque
Editar=S
ValidaNombre=N
3D=N
Tamano=7
ColorFondo=Plata
ColorFuente=Azul
Efectos=[Negritas]

[Ficha.CompraTrans]
Carpeta=Ficha
Clave=CompraTrans
Editar=S
ValidaNombre=S
3D=N
Tamano=7
ColorFondo=Plata
ColorFuente=$00004080
LineaNueva=S
Efectos=[Negritas]

[Ficha.VentaTrans]
Carpeta=Ficha
Clave=VentaTrans
Editar=S
LineaNueva=N
ValidaNombre=N
3D=N
Tamano=7
ColorFondo=Plata
ColorFuente=Azul
Efectos=[Negritas]

[Ficha.CompraMexDolar]
Carpeta=Ficha
Clave=CompraMexDolar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=7
ColorFondo=Plata
ColorFuente=$00004080
Efectos=[Negritas]

[Ficha.VentaMexDolar]
Carpeta=Ficha
Clave=VentaMexDolar
Editar=S
LineaNueva=N
ValidaNombre=N
3D=N
Tamano=7
ColorFondo=Plata
ColorFuente=Azul
Efectos=[Negritas]

[Ficha.CompraTravel]
Carpeta=Ficha
Clave=CompraTravel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=7
ColorFondo=Plata
ColorFuente=$00004080
Efectos=[Negritas]
EspacioPrevio=S

[Ficha.VentaTravel]
Carpeta=Ficha
Clave=VentaTravel
Editar=S
LineaNueva=N
ValidaNombre=N
3D=N
Tamano=7
ColorFondo=Plata
ColorFuente=Azul
Efectos=[Negritas]

[Ficha.ListaEnCaptura]
(Inicio)=CompraTrans
CompraTrans=VentaTrans
VentaTrans=CompraCheque
CompraCheque=VentaCheque
VentaCheque=CompraMexDolar
CompraMexDolar=VentaMexDolar
VentaMexDolar=CompraTravel
CompraTravel=VentaTravel
VentaTravel=CompraEfectivo
CompraEfectivo=VentaEfectivo
VentaEfectivo=(Fin)
