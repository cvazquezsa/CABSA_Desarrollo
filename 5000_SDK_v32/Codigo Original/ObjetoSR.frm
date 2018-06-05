
[Forma]
Clave=ObjetoSR
Icono=0
Modulos=(Todos)
Nombre=Objetos SR

ListaCarpetas=ObjetoSR
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=ObjetoSR
ListaAcciones=(Lista)
PosicionInicialIzquierda=544
PosicionInicialArriba=224
PosicionInicialAlturaCliente=241
PosicionInicialAncho=277
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[ObjetoSR]
Estilo=Hoja
Clave=ObjetoSR
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ObjetoSR
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
ListaEnCaptura=ObjetoSR.Objeto
CarpetaVisible=S

PermiteEditar=S
[ObjetoSR.ObjetoSR.Objeto]
Carpeta=ObjetoSR
Clave=ObjetoSR.Objeto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[ObjetoSR.Columnas]
Objeto=234

[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S



NombreEnBoton=S













[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
GuardarConfirmar=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S









Carpeta=(Carpeta principal)
















[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cancelar
Cancelar=Eliminar
Eliminar=(Fin)
