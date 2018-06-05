
[Forma]
Clave=SATFraccionArancelariaLista
Icono=0
Modulos=(Todos)
Nombre=Fracción Arancelaria
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=307
PosicionInicialArriba=103
PosicionInicialAlturaCliente=436
PosicionInicialAncho=873
ListaAcciones=Seleccionar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATFraccionArancelaria
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

[Lista.SATFraccionArancelaria.Clave]
Carpeta=Lista
Clave=SATFraccionArancelaria.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SATFraccionArancelaria.Descripcion]
Carpeta=Lista
Clave=SATFraccionArancelaria.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.SATFraccionArancelaria.UnidadMedida]
Carpeta=Lista
Clave=SATFraccionArancelaria.UnidadMedida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SATFraccionArancelaria.Importacion]
Carpeta=Lista
Clave=SATFraccionArancelaria.Importacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.SATFraccionArancelaria.Exportacion]
Carpeta=Lista
Clave=SATFraccionArancelaria.Exportacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Columnas]
Clave=97
Descripcion=506
UnidadMedida=95
Importacion=64
Exportacion=64


[Lista.ListaEnCaptura]
(Inicio)=SATFraccionArancelaria.Clave
SATFraccionArancelaria.Clave=SATFraccionArancelaria.Descripcion
SATFraccionArancelaria.Descripcion=SATFraccionArancelaria.UnidadMedida
SATFraccionArancelaria.UnidadMedida=SATFraccionArancelaria.Importacion
SATFraccionArancelaria.Importacion=SATFraccionArancelaria.Exportacion
SATFraccionArancelaria.Exportacion=(Fin)



[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)

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
