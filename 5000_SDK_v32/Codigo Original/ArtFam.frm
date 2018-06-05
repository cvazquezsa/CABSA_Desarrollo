[Forma]
Clave=ArtFam
Nombre=Familias de Artículos
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=415
PosicionInicialArriba=114
PosicionInicialAltura=309
PosicionInicialAncho=536
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
PosicionSeccion1=43
PosicionColumna1=46
PosicionInicialAlturaCliente=462

VentanaEstadoInicial=Normal
VentanaColor=Plata
ExpresionesAlMostrar=Asigna(Pos.AgenteDetalle,sql(<T>SELECT POSAgenteDetalle FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Asigna(Pos.AgenteDetMaestro,sql(<T>SELECT POSAgenteDetMaestro FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))
[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtFam
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
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

[Lista.ArtFam.Familia]
Carpeta=Lista
Clave=ArtFam.Familia
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=45
ColorFondo=Blanco

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
ReferenciaIntelisisService=304
Clave=124
InforDescripcion=184

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

EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ArtFam:ArtFam.Familia)))<BR>Vacio(Temp.Texto)
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
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Acciones.Precios]
Nombre=Precios
Boton=64
NombreEnBoton=S
NombreDesplegar=&Precios
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtFamPrecios
ConCondicion=S
Antes=S
EspacioPrevio=S
ActivoCondicion=ArtFam:ArtFam.Precios
EjecucionCondicion=ConDatos(ArtFam:ArtFam.Familia)
AntesExpresiones=Asigna(Info.ArtFam, ArtFam:ArtFam.Familia)
VisibleCondicion=General.Ford

[Lista.ArtFam.Precios]
Carpeta=Lista
Clave=ArtFam.Precios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtFam.Impuesto1]
Carpeta=Lista
Clave=ArtFam.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtFam.Impuesto2]
Carpeta=Lista
Clave=ArtFam.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ArtFam.Impuesto3]
Carpeta=Lista
Clave=ArtFam.Impuesto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.ArtFam.InforDescripcion]
Carpeta=Lista
Clave=ArtFam.InforDescripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=ArtFam.Familia
ArtFam.Familia=ArtFam.InforDescripcion
ArtFam.InforDescripcion=ArtFam.Precios
ArtFam.Precios=ArtFam.Impuesto1
ArtFam.Impuesto1=ArtFam.Impuesto2
ArtFam.Impuesto2=ArtFam.Impuesto3
ArtFam.Impuesto3=ArtFam.POSAgenteDetalle
ArtFam.POSAgenteDetalle=(Fin)

[Lista.ArtFam.POSAgenteDetalle]
Carpeta=Lista
Clave=ArtFam.POSAgenteDetalle
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco









































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=Precios
Precios=(Fin)
