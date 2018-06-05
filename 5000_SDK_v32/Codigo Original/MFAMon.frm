
[Forma]
Clave=MFAMon
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=MFA - Códigos de Moneda
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=MFAMon
CarpetaPrincipal=MFAMon
PosicionInicialIzquierda=535
PosicionInicialArriba=227
PosicionInicialAlturaCliente=236
PosicionInicialAncho=295
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

[MFAMon]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Monedas
Clave=MFAMon
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFAMon
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
[MFAMon.ListaEnCaptura]
(Inicio)=MFAMon.Moneda
MFAMon.Moneda=MFAMon.Codigo
MFAMon.Codigo=(Fin)

[MFAMon.MFAMon.Moneda]
Carpeta=MFAMon
Clave=MFAMon.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[MFAMon.MFAMon.Codigo]
Carpeta=MFAMon
Clave=MFAMon.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[MFAMon.Columnas]
Moneda=126
Codigo=110
