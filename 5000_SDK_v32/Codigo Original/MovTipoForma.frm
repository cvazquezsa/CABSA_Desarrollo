[Forma]
Clave=MovTipoForma
Nombre=Otros Datos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Mov
PosicionInicialIzquierda=731
PosicionInicialArriba=394
PosicionInicialAlturaCliente=385
PosicionInicialAncho=458
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoForma
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
ListaOrden=MovTipoForma.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=MovTipoForma.Modulo=<T>{Info.Modulo}<T> AND MovTipoForma.Mov=<T>{Info.Mov}<T>

[Lista.MovTipoForma.Campo]
Carpeta=Lista
Clave=MovTipoForma.Campo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoForma.TipoAyuda]
Carpeta=Lista
Clave=MovTipoForma.TipoAyuda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Campo=304
TipoAyuda=124

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

[Acciones.Ayuda]
Nombre=Ayuda
Boton=47
NombreEnBoton=S
NombreDesplegar=&Ayuda
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovTipoFormaAyuda
Antes=S
Visible=S
ActivoCondicion=MovTipoForma:MovTipoForma.TipoAyuda=<T>Lista<T>
AntesExpresiones=Asigna(Info.Campo, MovTipoForma:MovTipoForma.Campo)

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar Orden
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
GuardarAntes=S
AntesExpresiones=Forma(<T>MovTipoFormaOrdenar<T>)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ayuda
Ayuda=Ordenar
Ordenar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MovTipoForma.Campo
MovTipoForma.Campo=MovTipoForma.TipoAyuda
MovTipoForma.TipoAyuda=(Fin)
