
[Forma]
Clave=MovTipoMFACostoVenta
Icono=0
Modulos=(Todos)
Nombre=MFA - Movimientos Costo de Venta
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=358
PosicionInicialAncho=403
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=481
PosicionInicialArriba=166
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFACostoVenta
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

ListaOrden=(Lista)
CarpetaVisible=S
PermiteEditar=S


[Lista.MovTipoMFACostoVenta.Modulo]
Carpeta=Lista
Clave=MovTipoMFACostoVenta.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.MovTipoMFACostoVenta.Mov]
Carpeta=Lista
Clave=MovTipoMFACostoVenta.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Modulo=85
Mov=241

[Lista.ListaEnCaptura]
(Inicio)=MovTipoMFACostoVenta.Modulo
MovTipoMFACostoVenta.Modulo=MovTipoMFACostoVenta.Mov
MovTipoMFACostoVenta.Mov=(Fin)

[Lista.ListaOrden]
(Inicio)=MovTipoMFACostoVenta.Modulo	(Acendente)
MovTipoMFACostoVenta.Modulo	(Acendente)=MovTipoMFACostoVenta.Mov	(Acendente)
MovTipoMFACostoVenta.Mov	(Acendente)=(Fin)
