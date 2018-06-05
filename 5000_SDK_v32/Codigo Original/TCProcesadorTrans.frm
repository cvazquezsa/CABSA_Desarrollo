
[Forma]
Clave=TCProcesadorTrans
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Interface Tarjetas Bancarias - Procesador Transacciones
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=303
PosicionInicialAncho=443
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=413
PosicionInicialArriba=199
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



[TCProcesadorTrans.Columnas]
ProcesadorTrans=129

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
Vista=TCProcesadorTrans
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

OtroOrden=S
ListaOrden=TCProcesadorTrans.ProcesadorTrans<TAB>(Acendente)
[Lista.TCProcesadorTrans.ProcesadorTrans]
Carpeta=Lista
Clave=TCProcesadorTrans.ProcesadorTrans
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Columnas]
ProcesadorTrans=220

TerminalEquiv=124
[Lista.ListaEnCaptura]
(Inicio)=TCProcesadorTrans.ProcesadorTrans
TCProcesadorTrans.ProcesadorTrans=TCProcesadorTrans.TerminalEquiv
TCProcesadorTrans.TerminalEquiv=(Fin)

[Lista.TCProcesadorTrans.TerminalEquiv]
Carpeta=Lista
Clave=TCProcesadorTrans.TerminalEquiv
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Layout]
Nombre=Layout
Boton=11
NombreEnBoton=S
NombreDesplegar=Layout
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TCHashTableDefinicion
Activo=S
Visible=S



GuardarAntes=S
Antes=S
AntesExpresiones=Asigna(Info.Proveedor, TCProcesadorTrans:TCProcesadorTrans.ProcesadorTrans)










[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Layout
Layout=(Fin)
