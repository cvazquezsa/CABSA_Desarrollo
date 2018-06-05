[Forma]
Clave=ArtArancelTratadoComercial
Nombre=Tratados Comerciales del Arancel
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Arancel
PosicionInicialIzquierda=439
PosicionInicialArriba=288
PosicionInicialAlturaCliente=367
PosicionInicialAncho=398
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtArancelTratadoComercial
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
CarpetaVisible=S
Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ArtArancelTratadoComercial.Arancel=<T>{Info.Arancel}<T>

[Lista.ArtArancelTratadoComercial.TratadoComercial]
Carpeta=Lista
Clave=ArtArancelTratadoComercial.TratadoComercial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtArancelTratadoComercial.Porcentaje]
Carpeta=Lista
Clave=ArtArancelTratadoComercial.Porcentaje
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
TratadoComercial=304
Porcentaje=64

[Lista.ListaEnCaptura]
(Inicio)=ArtArancelTratadoComercial.TratadoComercial
ArtArancelTratadoComercial.TratadoComercial=ArtArancelTratadoComercial.Porcentaje
ArtArancelTratadoComercial.Porcentaje=(Fin)
