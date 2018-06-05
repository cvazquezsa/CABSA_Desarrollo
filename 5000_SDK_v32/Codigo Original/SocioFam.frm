[Forma]
Clave=SocioFam
Nombre=Familias de Socios
Icono=0
Modulos=CAP
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=494
PosicionInicialArriba=336
PosicionInicialAltura=309
PosicionInicialAncho=292
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
PosicionSeccion1=43
PosicionColumna1=46
VentanaEscCerrar=
PosicionInicialAlturaCliente=318

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodSocioexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SocioFam
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=SocioFam.Familia
CarpetaVisible=S
PermiteEditar=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
HojaMostrarRenglones=S

[Lista.SocioFam.Familia]
Carpeta=Lista
Clave=SocioFam.Familia
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=45
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.SocioFam.Familia]
Carpeta=Detalle
Clave=SocioFam.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
Efectos=[Negritas]

[Detalle.SocioFam.Icono]
Carpeta=Detalle
Clave=SocioFam.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Columnas]
Familia=263
Descripcion=310
Precios=40

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
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(SocioFam:SocioFam.Familia)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Detalle.Columnas]
Familia=64
Descripcion=304
Icono=64

[Detalle.SocioFam.FamiliaMaestra]
Carpeta=Detalle
Clave=SocioFam.FamiliaMaestra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[SocioFamD.SocioFamD.TipoPropiedad]
Carpeta=SocioFamD
Clave=SocioFamD.TipoPropiedad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[SocioFamD.Columnas]
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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)
