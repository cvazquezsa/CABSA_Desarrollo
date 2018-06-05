
[Forma]
Clave=DIOTPagoConciliado
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=DPIVA -  Pagos por Fecha Conciliación
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
Vista=DIOTPagoConciliado
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
[Lista.ListaEnCaptura]
(Inicio)=DIOTPagoConciliado.Mov
DIOTPagoConciliado.Mov=DIOTPagoConciliado.Aplica
DIOTPagoConciliado.Aplica=(Fin)

[Lista.DIOTPagoConciliado.Mov]
Carpeta=Lista
Clave=DIOTPagoConciliado.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.DIOTPagoConciliado.Aplica]
Carpeta=Lista
Clave=DIOTPagoConciliado.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Mov=141
Aplica=151
