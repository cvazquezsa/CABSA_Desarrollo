[Forma]
Clave=CfgModuloCentralAccion
Nombre=Configuración - Colas / Caché
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=646
PosicionInicialArriba=445
PosicionInicialAlturaCliente=273
PosicionInicialAncho=472
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgModuloCentralAccion
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

[Lista.CfgModuloCentralAccion.Accion]
Carpeta=Lista
Clave=CfgModuloCentralAccion.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CfgModuloCentralAccion.Cache]
Carpeta=Lista
Clave=CfgModuloCentralAccion.Cache
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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
Accion=185
Cache=124
Cola=124
ProcesarColaTamanoLote=154

[Lista.CfgModuloCentralAccion.Cola]
Carpeta=Lista
Clave=CfgModuloCentralAccion.Cola
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CfgModuloCentralAccion.Accion
CfgModuloCentralAccion.Accion=CfgModuloCentralAccion.Cola
CfgModuloCentralAccion.Cola=CfgModuloCentralAccion.Cache
CfgModuloCentralAccion.Cache=(Fin)
