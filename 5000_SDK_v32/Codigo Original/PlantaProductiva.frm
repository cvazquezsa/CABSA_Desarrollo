[Forma]
Clave=PlantaProductiva
Nombre=Planta Productiva
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=472
PosicionInicialArriba=172
PosicionInicialAlturaCliente=420
PosicionInicialAncho=402
PosicionColumna1=34
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PlantaProductiva
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PermiteEditar=S
HojaMantenerSeleccion=S
HojaTitulos=S
HojaMostrarColumnas=S


ListaEnCaptura=(Lista)
[Ficha.Metodo.Metodo]
Carpeta=Ficha
Clave=Metodo.Metodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Metodo.Descripcion]
Carpeta=Ficha
Clave=Metodo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=50x10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Metodo=160
Nombre=322

Clave=52
Descripcion=244
Sucursal=64
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



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Descripcion
Descripcion=(Fin)


[Lista.PlantaProductiva.Clave]
Carpeta=Lista
Clave=PlantaProductiva.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

[Lista.PlantaProductiva.Descripcion]
Carpeta=Lista
Clave=PlantaProductiva.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=PlantaProductiva.Clave
PlantaProductiva.Clave=PlantaProductiva.Descripcion
PlantaProductiva.Descripcion=PlantaProductiva.Sucursal
PlantaProductiva.Sucursal=(Fin)

[Lista.PlantaProductiva.Sucursal]
Carpeta=Lista
Clave=PlantaProductiva.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
