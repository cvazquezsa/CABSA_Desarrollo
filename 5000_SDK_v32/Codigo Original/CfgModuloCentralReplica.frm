[Forma]
Clave=CfgModuloCentralReplica
Nombre=Configuración Replica
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=634
PosicionInicialArriba=426
PosicionInicialAlturaCliente=311
PosicionInicialAncho=652
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
Vista=CfgModuloCentralReplica
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

[Lista.CfgModuloCentralReplica.Tema]
Carpeta=Lista
Clave=CfgModuloCentralReplica.Tema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CfgModuloCentralReplica.Frecuencia]
Carpeta=Lista
Clave=CfgModuloCentralReplica.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CfgModuloCentralReplica.UltimaReplica]
Carpeta=Lista
Clave=CfgModuloCentralReplica.UltimaReplica
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
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
Tema=214
Frecuencia=119
UltimaReplica=183
Estatus=94

[Lista.CfgModuloCentralReplica.Estatus]
Carpeta=Lista
Clave=CfgModuloCentralReplica.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Lista.ListaEnCaptura]
(Inicio)=CfgModuloCentralReplica.Tema
CfgModuloCentralReplica.Tema=CfgModuloCentralReplica.Frecuencia
CfgModuloCentralReplica.Frecuencia=CfgModuloCentralReplica.UltimaReplica
CfgModuloCentralReplica.UltimaReplica=CfgModuloCentralReplica.Estatus
CfgModuloCentralReplica.Estatus=(Fin)
