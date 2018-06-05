
[Forma]
Clave=POSiSync
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Configuración i-Sync
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=Guardar
PosicionInicialIzquierda=549
PosicionInicialArriba=276
PosicionInicialAlturaCliente=278
PosicionInicialAncho=501
[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSiSync
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Lista.POSiSync.Host]
Carpeta=Lista
Clave=POSiSync.Host
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.POSiSync.Cluster]
Carpeta=Lista
Clave=POSiSync.Cluster
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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


[Lista.POSiSync.EsOrigen]
Carpeta=Lista
Clave=POSiSync.EsOrigen
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco




[Lista.POSiSync.SincronizaArtSuc]
Carpeta=Lista
Clave=POSiSync.SincronizaArtSuc
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco

Tamano=30





[Lista.POSiSync.Sucursal]
Carpeta=Lista
Clave=POSiSync.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.SucursalNombre]
Carpeta=Lista
Clave=SucursalNombre
Editar=S
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Plata

LineaNueva=S


[Lista.ListaEnCaptura]
(Inicio)=POSiSync.Host
POSiSync.Host=POSiSync.Cluster
POSiSync.Cluster=POSiSync.EsOrigen
POSiSync.EsOrigen=POSiSync.SincronizaArtSuc
POSiSync.SincronizaArtSuc=POSiSync.Sucursal
POSiSync.Sucursal=SucursalNombre
SucursalNombre=(Fin)

[Lista.Columnas]
0=91
1=267
