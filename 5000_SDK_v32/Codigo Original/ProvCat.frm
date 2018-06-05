[Forma]
Clave=ProvCat
Nombre=Categorías de Proveedores
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=377
PosicionInicialArriba=211
PosicionInicialAltura=345
PosicionInicialAncho=270
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S

[ProvCat.Columnas]
Categoria=104
Descripcion=304

[Lista]
Estilo=Hoja
Pestana=
PestanaOtroNombre=
PestanaNombre=Lista
Clave=Lista
OtroOrden=Si
AlineacionAutomatica=Si
AcomodarTexto=Si
MostrarConteoRegistros=Si
Zona=A1
Vista=ProvCat
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=
HojaMostrarColumnas=
HojaMostrarRenglones=Si
HojaColoresPorEstatus=Si
HojaMantenerSeleccion=Si
HojaPermiteInsertar=Si
HojaPermiteEliminar=Si
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ProvCat.Categoria
ListaOrden=ProvCat.Categoria<TAB>(Acendente)
CarpetaVisible=Si
CondicionEdicion=
HojaAjustarColumnas=Si
PermiteEditar=Si
HojaIndicador=
HojaConfirmarEliminar=Si

[Lista.ProvCat.Categoria]
Carpeta=Lista
Clave=ProvCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Columnas]
Categoria=242
Descripcion=325

[Detalles.ProvCat.Categoria]
Carpeta=Detalles
Clave=ProvCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.ProvCat.Icono]
Carpeta=Detalles
Clave=ProvCat.Icono
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
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ProvCat:ProvCat.Categoria)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

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

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)
