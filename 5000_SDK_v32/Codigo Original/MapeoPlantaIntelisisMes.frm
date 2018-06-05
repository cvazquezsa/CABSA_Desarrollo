
[Forma]
Clave=MapeoPlantaIntelisisMes
Icono=0
CarpetaPrincipal=MapeoPlantaIntelisisMes
Modulos=(Todos)
Nombre=Mapeo Planta Intelisis Factory

ListaCarpetas=MapeoPlantaIntelisisMes
PosicionInicialAlturaCliente=266
PosicionInicialAncho=445
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=417
PosicionInicialArriba=307
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Guardar Cambios
[MapeoPlantaIntelisisMes]
Estilo=Hoja
Clave=MapeoPlantaIntelisisMes
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MapeoPlantaIntelisisMes
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
ListaEnCaptura=(Lista)

PermiteEditar=S

[MapeoPlantaIntelisisMes.MapeoPlantaIntelisisMes.Referencia]
Carpeta=MapeoPlantaIntelisisMes
Clave=MapeoPlantaIntelisisMes.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[MapeoPlantaIntelisisMes.MapeoPlantaIntelisisMes.Empresa]
Carpeta=MapeoPlantaIntelisisMes
Clave=MapeoPlantaIntelisisMes.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco


[MapeoPlantaIntelisisMes.Columnas]
Referencia=131
Empresa=65
Sucursal=91

Planta=124
AlmacenMatPrima=112
[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S




[MapeoPlantaIntelisisMes.MapeoPlantaIntelisisMes.Sucursal]
Carpeta=MapeoPlantaIntelisisMes
Clave=MapeoPlantaIntelisisMes.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MapeoPlantaIntelisisMes.ListaEnCaptura]
(Inicio)=MapeoPlantaIntelisisMes.Referencia
MapeoPlantaIntelisisMes.Referencia=MapeoPlantaIntelisisMes.Empresa
MapeoPlantaIntelisisMes.Empresa=MapeoPlantaIntelisisMes.Sucursal
MapeoPlantaIntelisisMes.Sucursal=MapeoPlantaIntelisisMes.AlmacenMatPrima
MapeoPlantaIntelisisMes.AlmacenMatPrima=(Fin)

[MapeoPlantaIntelisisMes.MapeoPlantaIntelisisMes.AlmacenMatPrima]
Carpeta=MapeoPlantaIntelisisMes
Clave=MapeoPlantaIntelisisMes.AlmacenMatPrima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Columnas]
Almacen=90
Nombre=229
Grupo=100
Sucursal=46
