
[Forma]
Clave=MapeoIntelisisMes
Icono=0
CarpetaPrincipal=MapeoIntelisisMes
Modulos=(Todos)
Nombre=Mapeo Intelisis Factory

ListaCarpetas=MapeoIntelisisMes
PosicionInicialAlturaCliente=273
PosicionInicialAncho=344
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=623
PosicionInicialArriba=274




[MapeoIntelisisMes.Columnas]
Modulo=45
Movimiento=135
ReferenciaIntelisisMes=124



[Mapeo Intelisis Mes.ListaEnCaptura]
(Inicio)=MapeoIntelisisMes.Modulo
MapeoIntelisisMes.Modulo=MapeoIntelisisMes.Movimiento
MapeoIntelisisMes.Movimiento=MapeoIntelisisMes.ReferenciaIntelisisMes
MapeoIntelisisMes.ReferenciaIntelisisMes=(Fin)




[MapeoIntelisisMes]
Estilo=Hoja
Clave=MapeoIntelisisMes
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MapeoIntelisisMes
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
[MapeoIntelisisMes.ListaEnCaptura]
(Inicio)=MapeoIntelisisMes.Modulo
MapeoIntelisisMes.Modulo=MapeoIntelisisMes.Movimiento
MapeoIntelisisMes.Movimiento=MapeoIntelisisMes.ReferenciaIntelisisMes
MapeoIntelisisMes.ReferenciaIntelisisMes=(Fin)

[MapeoIntelisisMes.MapeoIntelisisMes.Modulo]
Carpeta=MapeoIntelisisMes
Clave=MapeoIntelisisMes.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[MapeoIntelisisMes.MapeoIntelisisMes.Movimiento]
Carpeta=MapeoIntelisisMes
Clave=MapeoIntelisisMes.Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MapeoIntelisisMes.MapeoIntelisisMes.ReferenciaIntelisisMes]
Carpeta=MapeoIntelisisMes
Clave=MapeoIntelisisMes.ReferenciaIntelisisMes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
