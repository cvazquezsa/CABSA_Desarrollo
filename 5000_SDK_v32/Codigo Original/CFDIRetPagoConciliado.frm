

[Forma]
Clave=CFDIRetPagoConciliado
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Pagos por Fecha Conciliaci�n
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=504
PosicionInicialArriba=195
PosicionInicialAlturaCliente=299
PosicionInicialAncho=358
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S
GuardarAntes=S

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetPagoConciliado
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
[Lista.ListaEnCaptura]
(Inicio)=CFDIRetPagoConciliado.Mov
CFDIRetPagoConciliado.Mov=CFDIRetPagoConciliado.Aplica
CFDIRetPagoConciliado.Aplica=(Fin)

[Lista.CFDIRetPagoConciliado.Mov]
Carpeta=Lista
Clave=CFDIRetPagoConciliado.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CFDIRetPagoConciliado.Aplica]
Carpeta=Lista
Clave=CFDIRetPagoConciliado.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Mov=141
Aplica=151
