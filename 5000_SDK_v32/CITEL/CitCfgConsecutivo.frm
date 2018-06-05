
[Forma]
Clave=CitCfgConsecutivo
Icono=0
Modulos=(Todos)
Nombre=Configurar Consecutivo
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaColor=Plata

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=535
PosicionInicialArriba=208
PosicionInicialAlturaCliente=273
PosicionInicialAncho=295
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CitCfgConsecutivo
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
CarpetaVisible=S
ListaEnCaptura=(Lista)

[Lista.ListaEnCaptura]
(Inicio)=CitCfgConsecutivo.TipoCliente
CitCfgConsecutivo.TipoCliente=CitCfgConsecutivo.Prefijo
CitCfgConsecutivo.Prefijo=CitCfgConsecutivo.LargoSubfijo
CitCfgConsecutivo.LargoSubfijo=(Fin)

[Lista.CitCfgConsecutivo.TipoCliente]
Carpeta=Lista
Clave=CitCfgConsecutivo.TipoCliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CitCfgConsecutivo.Prefijo]
Carpeta=Lista
Clave=CitCfgConsecutivo.Prefijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CitCfgConsecutivo.LargoSubfijo]
Carpeta=Lista
Clave=CitCfgConsecutivo.LargoSubfijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
TipoCliente=124
Prefijo=64
LargoSubfijo=67

[Acciones.Guardar]
Nombre=Guardar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S













[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cancelar
Cancelar=(Fin)
