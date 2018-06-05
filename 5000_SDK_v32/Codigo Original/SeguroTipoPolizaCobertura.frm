[Forma]
Clave=SeguroTipoPolizaCobertura
Nombre=Cobertura
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=346
PosicionInicialArriba=269
PosicionInicialAlturaCliente=451
PosicionInicialAncho=587
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
Vista=SeguroTipoPolizaCobertura
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

[Lista.SeguroTipoPolizaCobertura.Articulo]
Carpeta=Lista
Clave=SeguroTipoPolizaCobertura.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SeguroTipoPolizaCobertura.ImporteMaximo]
Carpeta=Lista
Clave=SeguroTipoPolizaCobertura.ImporteMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
Articulo=124
Descripcion1=301
ImporteMaximo=131

[Lista.ListaEnCaptura]
(Inicio)=SeguroTipoPolizaCobertura.Articulo
SeguroTipoPolizaCobertura.Articulo=Art.Descripcion1
Art.Descripcion1=SeguroTipoPolizaCobertura.ImporteMaximo
SeguroTipoPolizaCobertura.ImporteMaximo=(Fin)
