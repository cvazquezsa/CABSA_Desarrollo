
[Forma]
Clave=SUAComparacion
Icono=47
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Comparación
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=SUAComparacion
CarpetaPrincipal=SUAComparacion
PosicionInicialIzquierda=132
PosicionInicialArriba=62
PosicionInicialAlturaCliente=564
PosicionInicialAncho=1101
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaColor=Plata
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[SUAComparacion]
Estilo=Hoja
Clave=SUAComparacion
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SUAComparacion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=(Lista)
CarpetaVisible=S

[SUAComparacion.SUAComparacion.NSS]
Carpeta=SUAComparacion
Clave=SUAComparacion.NSS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[SUAComparacion.SUAComparacion.Nombre]
Carpeta=SUAComparacion
Clave=SUAComparacion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[SUAComparacion.SUAComparacion.Origen]
Carpeta=SUAComparacion
Clave=SUAComparacion.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUAComparacion.SUAComparacion.Tipo]
Carpeta=SUAComparacion
Clave=SUAComparacion.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUAComparacion.SUAComparacion.Fecha]
Carpeta=SUAComparacion
Clave=SUAComparacion.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUAComparacion.SUAComparacion.Dias]
Carpeta=SUAComparacion
Clave=SUAComparacion.Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUAComparacion.SUAComparacion.SDI]
Carpeta=SUAComparacion
Clave=SUAComparacion.SDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUAComparacion.SUAComparacion.TipoDescuento]
Carpeta=SUAComparacion
Clave=SUAComparacion.TipoDescuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SUAComparacion.SUAComparacion.ValorDescuento]
Carpeta=SUAComparacion
Clave=SUAComparacion.ValorDescuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUAComparacion.SUAComparacion.Credito]
Carpeta=SUAComparacion
Clave=SUAComparacion.Credito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SUAComparacion.Columnas]
NSS=77
Nombre=194
Origen=38
Tipo=25
Fecha=65
Dias=29
SDI=51
TipoDescuento=58
ValorDescuento=46
Credito=95



OrigenDatos=64


[SUAComparacion.SUAComparacion.OrigenDatos]
Carpeta=SUAComparacion
Clave=SUAComparacion.OrigenDatos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SUAComparacion.ListaEnCaptura]
(Inicio)=SUAComparacion.OrigenDatos
SUAComparacion.OrigenDatos=SUAComparacion.NSS
SUAComparacion.NSS=SUAComparacion.Nombre
SUAComparacion.Nombre=SUAComparacion.Origen
SUAComparacion.Origen=SUAComparacion.Tipo
SUAComparacion.Tipo=SUAComparacion.Fecha
SUAComparacion.Fecha=SUAComparacion.Dias
SUAComparacion.Dias=SUAComparacion.SDI
SUAComparacion.SDI=SUAComparacion.TipoDescuento
SUAComparacion.TipoDescuento=SUAComparacion.ValorDescuento
SUAComparacion.ValorDescuento=SUAComparacion.Credito
SUAComparacion.Credito=(Fin)

[SUAComparacion.ListaOrden]
(Inicio)=SUAComparacion.Nombre	(Acendente)
SUAComparacion.Nombre	(Acendente)=SUAComparacion.Origen	(Acendente)
SUAComparacion.Origen	(Acendente)=SUAComparacion.Tipo	(Acendente)
SUAComparacion.Tipo	(Acendente)=SUAComparacion.OrigenDatos	(Acendente)
SUAComparacion.OrigenDatos	(Acendente)=(Fin)

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=E&xcel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S








[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S











[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Excel
Excel=Imprimir
Imprimir=Preliminar
Preliminar=(Fin)
