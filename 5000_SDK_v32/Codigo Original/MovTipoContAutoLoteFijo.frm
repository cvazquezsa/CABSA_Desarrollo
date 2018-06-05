[Forma]
Clave=MovTipoContAutoLoteFijo
Nombre=Lotes Fijos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=342
PosicionInicialArriba=288
PosicionInicialAlturaCliente=420
PosicionInicialAncho=596
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(e(<T>Empresa<T>)+<T>: <T>+Info.Empresa, Info.Nombre)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoContAutoLoteFijo
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
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=MovTipoContAutoLoteFijo.Empresa=<T>{Info.Empresa}<T> AND<BR>MovTipoContAutoLoteFijo.Modulo=<T>{Info.Modulo}<T> AND<BR>MovTipoContAutoLoteFijo.Clave=<T>{Info.Clave}<T> AND<BR>MovTipoContAutoLoteFijo.Nombre=<T>{Info.Nombre}<T>
[Lista.MovTipoContAutoLoteFijo.Lote]
Carpeta=Lista
Clave=MovTipoContAutoLoteFijo.Lote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoContAutoLoteFijo.Impuesto1]
Carpeta=Lista
Clave=MovTipoContAutoLoteFijo.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoContAutoLoteFijo.Impuesto2]
Carpeta=Lista
Clave=MovTipoContAutoLoteFijo.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Lote=205
Impuesto1=53
Impuesto2=57
Impuesto3=76
Cuenta1=124
Cuenta2=124

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

[Lista.MovTipoContAutoLoteFijo.Cuenta1]
Carpeta=Lista
Clave=MovTipoContAutoLoteFijo.Cuenta1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoContAutoLoteFijo.Cuenta2]
Carpeta=Lista
Clave=MovTipoContAutoLoteFijo.Cuenta2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro



[Lista.ListaEnCaptura]
(Inicio)=MovTipoContAutoLoteFijo.Lote
MovTipoContAutoLoteFijo.Lote=MovTipoContAutoLoteFijo.Impuesto1
MovTipoContAutoLoteFijo.Impuesto1=MovTipoContAutoLoteFijo.Cuenta1
MovTipoContAutoLoteFijo.Cuenta1=MovTipoContAutoLoteFijo.Impuesto2
MovTipoContAutoLoteFijo.Impuesto2=MovTipoContAutoLoteFijo.Cuenta2
MovTipoContAutoLoteFijo.Cuenta2=(Fin)
