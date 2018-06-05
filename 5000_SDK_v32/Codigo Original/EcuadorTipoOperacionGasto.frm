
[Forma]
Clave=EcuadorTipoOperacionGasto
Icono=0
CarpetaPrincipal=EcuadorTipoOperacionGasto
Modulos=(Todos)
Nombre=Ecuador Tipo Operacion Gasto

ListaCarpetas=EcuadorTipoOperacionGasto
PosicionInicialAlturaCliente=188
PosicionInicialAncho=334
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=473
PosicionInicialArriba=292
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)


[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S


Carpeta=(Carpeta principal)
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EspacioPrevio=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S





[TipodeOperacionGasto.Columnas]
TipodeOperacionGasto=304






[EcuadorTipoOperacionGasto]
Estilo=Hoja
Clave=EcuadorTipoOperacionGasto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EcuadorTipoOperacionGasto
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



ListaEnCaptura=EcuadorTipoOperacionGasto.EcuadorTipoOperacionGasto

[EcuadorTipoOperacionGasto.EcuadorTipoOperacionGasto.EcuadorTipoOperacionGasto]
Carpeta=EcuadorTipoOperacionGasto
Clave=EcuadorTipoOperacionGasto.EcuadorTipoOperacionGasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




[EcuadorTipoOperacionGasto.Columnas]
EcuadorTipoOperacionGasto=304

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=(Fin)
