[Forma]
Clave=RepCat
Nombre=Categor�as de Reportes
Icono=0
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=508
PosicionInicialArriba=336
PosicionInicialAltura=345
PosicionInicialAncho=263
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
VentanaTipoMarco=Di�logo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
PosicionInicialAlturaCliente=318

[RepCat.Columnas]
Categoria=104
Descripcion=304

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepCat
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=RepCat.Categoria
CarpetaVisible=S
HojaAjustarColumnas=S
PermiteEditar=S
HojaConfirmarEliminar=S
HojaVistaOmision=Autom�tica

[Lista.RepCat.Categoria]
Carpeta=Lista
Clave=RepCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Categoria=234
Descripcion=325

[Detalles.RepCat.Categoria]
Carpeta=Detalles
Clave=RepCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.RepCat.Icono]
Carpeta=Detalles
Clave=RepCat.Icono
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
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(RepCat:RepCat.Categoria)))<BR>Vacio(Temp.Texto)
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

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)
