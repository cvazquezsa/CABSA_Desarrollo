[Forma]
Clave=PlantaLista
Nombre=Plantas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
EsConsultaExclusiva=S
PosicionInicialIzquierda=444
PosicionInicialArriba=286
PosicionInicialAltura=467
PosicionInicialAncho=337
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialAlturaCliente=416

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PlantaProductiva
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S


HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
[Lista.Columnas]
Sucursal=58
Nombre=266
Prefijo=62
Region=79
0=91
1=267

Clave=52
Descripcion=244
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S


[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)


[Lista.PlantaProductiva.Clave]
Carpeta=Lista
Clave=PlantaProductiva.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
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



[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)



[Lista.ListaEnCaptura]
(Inicio)=PlantaProductiva.Clave
PlantaProductiva.Clave=PlantaProductiva.Descripcion
PlantaProductiva.Descripcion=(Fin)
