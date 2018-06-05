
[Forma]
Clave=SATUnidadAduanaLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Unidad Aduana
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=453
PosicionInicialArriba=106
PosicionInicialAlturaCliente=463
PosicionInicialAncho=366
ListaAcciones=Seleccionar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATUnidadAduana
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

[Lista.SATUnidadAduana.Clave]
Carpeta=Lista
Clave=SATUnidadAduana.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Lista.SATUnidadAduana.Descripcion]
Carpeta=Lista
Clave=SATUnidadAduana.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.Columnas]
Clave=92
Descripcion=234


[Lista.ListaEnCaptura]
(Inicio)=SATUnidadAduana.Clave
SATUnidadAduana.Clave=SATUnidadAduana.Descripcion
SATUnidadAduana.Descripcion=(Fin)



[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
