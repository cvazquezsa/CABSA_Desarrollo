[Forma]
Clave=ArtRotacion
Nombre=Rotación de Artículos
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=667
PosicionInicialArriba=309
PosicionInicialAltura=309
PosicionInicialAncho=265
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
PosicionSeccion1=43
PosicionColumna1=46
VentanaEscCerrar=
PosicionInicialAlturaCliente=244

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtRotacion
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PermiteEditar=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaMostrarRenglones=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
HojaAjustarColumnas=S


ListaEnCaptura=ArtRotacion.Rotacion
[Detalle.ArtFam.Familia]
Carpeta=Detalle
Clave=ArtFam.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
Efectos=[Negritas]

[Detalle.ArtFam.Icono]
Carpeta=Detalle
Clave=ArtFam.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Columnas]
Familia=263
Descripcion=310
Precios=40
BasePresupuesto=91
Impuesto1=64
Impuesto2=64
Impuesto3=72

Rotacion=106
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S
Visible=S
ConCondicion=S
EjecucionConError=S

EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ArtRotacion:ArtRotacion.Rotacion)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
[Detalle.Columnas]
Familia=64
Descripcion=304
Icono=64

[Detalle.ArtFam.FamiliaMaestra]
Carpeta=Detalle
Clave=ArtFam.FamiliaMaestra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[ArtFamD.ArtFamD.TipoPropiedad]
Carpeta=ArtFamD
Clave=ArtFamD.TipoPropiedad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[ArtFamD.Columnas]
TipoPropiedad=194

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S

ActivoCondicion=Usuario.EnviarExcel

[Lista.ListaEnCaptura]
(Inicio)=ArtFam.Familia
ArtFam.Familia=ArtFam.Precios
ArtFam.Precios=ArtFam.Impuesto1
ArtFam.Impuesto1=ArtFam.Impuesto2
ArtFam.Impuesto2=ArtFam.Impuesto3
ArtFam.Impuesto3=(Fin)


[Lista.ArtRotacion.Rotacion]
Carpeta=Lista
Clave=ArtRotacion.Rotacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)
