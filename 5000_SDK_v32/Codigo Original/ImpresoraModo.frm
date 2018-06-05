[Forma]
Clave=ImpresoraModo
Nombre=Modos de Impresión
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=297
PosicionInicialArriba=230
PosicionInicialAltura=300
PosicionInicialAncho=430
PosicionInicialAlturaCliente=273

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ImpresoraModo
Fuente={MS Sans Serif, 8, Negro, []}
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

[Lista.ImpresoraModo.Modo]
Carpeta=Lista
Clave=ImpresoraModo.Modo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Lista.ImpresoraModo.Secuencia]
Carpeta=Lista
Clave=ImpresoraModo.Secuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Modo=157
Secuencia=243

[Lista.ListaEnCaptura]
(Inicio)=ImpresoraModo.Modo
ImpresoraModo.Modo=ImpresoraModo.Secuencia
ImpresoraModo.Secuencia=(Fin)
