
[Forma]
Clave=MapeoMovMovil
Icono=0
CarpetaPrincipal=MapeoMovMovil
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Mapeo Movimientos Móvil

ListaCarpetas=MapeoMovMovil
PosicionInicialAlturaCliente=273
PosicionInicialAncho=589
PosicionInicialIzquierda=388
PosicionInicialArriba=208
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
BarraHerramientas=S
[MapeoMovMovil]
Estilo=Hoja
Clave=MapeoMovMovil
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MapeoMovMovil
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
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)


[MapeoMovMovil.MapeoMovMovil.Modulo]
Carpeta=MapeoMovMovil
Clave=MapeoMovMovil.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MapeoMovMovil.MapeoMovMovil.Mov]
Carpeta=MapeoMovMovil
Clave=MapeoMovMovil.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[MapeoMovMovil.Columnas]
Modulo=67
Mov=124
RequiereMontacarga=108


MovTransito=124
MovFinal=124
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
EnBarraHerramientas=S


[MapeoMovMovil.MapeoMovMovil.MovTransito]
Carpeta=MapeoMovMovil
Clave=MapeoMovMovil.MovTransito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MapeoMovMovil.MapeoMovMovil.MovFinal]
Carpeta=MapeoMovMovil
Clave=MapeoMovMovil.MovFinal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MapeoMovMovil.ListaEnCaptura]
(Inicio)=MapeoMovMovil.Modulo
MapeoMovMovil.Modulo=MapeoMovMovil.Mov
MapeoMovMovil.Mov=MapeoMovMovil.MovTransito
MapeoMovMovil.MovTransito=MapeoMovMovil.MovFinal
MapeoMovMovil.MovFinal=(Fin)
