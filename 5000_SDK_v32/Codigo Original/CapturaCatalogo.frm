[Forma]
Clave=CapturaCatalogo
Nombre=Configuración - Modificaciones Catálogos Transaccionalmente
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=327
PosicionInicialArriba=130
PosicionInicialAlturaCliente=483
PosicionInicialAncho=625
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CapturaCatalogo
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

[Lista.CapturaCatalogo.Catalogo]
Carpeta=Lista
Clave=CapturaCatalogo.Catalogo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CapturaCatalogo.Forma]
Carpeta=Lista
Clave=CapturaCatalogo.Forma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
Catalogo=304
Forma=158
Modo=124

[Lista.CapturaCatalogo.Modo]
Carpeta=Lista
Clave=CapturaCatalogo.Modo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CapturaCatalogo.Catalogo
CapturaCatalogo.Catalogo=CapturaCatalogo.Forma
CapturaCatalogo.Forma=CapturaCatalogo.Modo
CapturaCatalogo.Modo=(Fin)
