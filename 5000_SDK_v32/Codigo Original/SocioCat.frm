[Forma]
Clave=SocioCat
Nombre=Categorías de Socios
Icono=0
Modulos=CAP
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=505
PosicionInicialArriba=336
PosicionInicialAltura=345
PosicionInicialAncho=271
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
PosicionInicialAlturaCliente=318

[SocioCat.Columnas]
Categoria=104
Descripcion=304

[Lista]
Estilo=Hoja
Pestana=
PestanaOtroNombre=
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SocioCat
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=
HojaMostrarColumnas=
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=SocioCat.Categoria
ListaOrden=SocioCat.Categoria<TAB>(Acendente)
CarpetaVisible=S
CondicionEdicion=
HojaAjustarColumnas=S
PermiteEditar=S
HojaIndicador=
HojaConfirmarEliminar=S

[Lista.SocioCat.Categoria]
Carpeta=Lista
Clave=SocioCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Columnas]
Categoria=242
Descripcion=325

[Detalles.SocioCat.Categoria]
Carpeta=Detalles
Clave=SocioCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.SocioCat.Icono]
Carpeta=Detalles
Clave=SocioCat.Icono
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
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(SocioCat:SocioCat.Categoria)))<BR>Vacio(Temp.Texto)
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
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)
