[Forma]
Clave=ArtLinea
Nombre=Líneas de Artículos
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=618
PosicionInicialArriba=256
PosicionInicialAltura=345
PosicionInicialAncho=363
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
PosicionInicialAlturaCliente=318

VentanaEstadoInicial=Normal
VentanaColor=Plata
ExpresionesAlMostrar=Asigna(Pos.AgenteDetalle,sql(<T>SELECT POSAgenteDetalle FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Asigna(Pos.AgenteDetMaestro,sql(<T>SELECT POSAgenteDetMaestro FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))
[ArtLinea.Columnas]
Linea=104
Descripcion=304

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtLinea
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=ArtLinea.Linea<TAB>(Acendente)
CarpetaVisible=S
HojaAjustarColumnas=S
PermiteEditar=S
HojaConfirmarEliminar=S
HojaVistaOmision=Automática
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.ArtLinea.Linea]
Carpeta=Lista
Clave=ArtLinea.Linea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Columnas]
Linea=234
Descripcion=325
Clave=99

[Detalles.ArtLinea.Linea]
Carpeta=Detalles
Clave=ArtLinea.Linea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.ArtLinea.Icono]
Carpeta=Detalles
Clave=ArtLinea.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
EnMenu=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
GuardarAntes=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ArtLinea:ArtLinea.Linea)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

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

[Lista.ArtLinea.Clave]
Carpeta=Lista
Clave=ArtLinea.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Lista.ArtLinea.POSAgenteDetalle]
Carpeta=Lista
Clave=ArtLinea.POSAgenteDetalle
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.ListaEnCaptura]
(Inicio)=ArtLinea.Linea
ArtLinea.Linea=ArtLinea.Clave
ArtLinea.Clave=ArtLinea.POSAgenteDetalle
ArtLinea.POSAgenteDetalle=(Fin)









[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)
