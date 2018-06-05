[Forma]
Clave=UsuarioImpresora
Nombre=Impresoras del Usuario
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Usuario
ListaAcciones=Aceptar
PosicionInicialIzquierda=344
PosicionInicialArriba=279
PosicionInicialAlturaCliente=439
PosicionInicialAncho=592
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioImpresora
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
ListaOrden=UsuarioImpresora.Orden<TAB>(Acendente)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=UsuarioImpresora.Usuario=<T>{Info.Usuario}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.UsuarioImpresora.Impresora]
Carpeta=Lista
Clave=UsuarioImpresora.Impresora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.UsuarioImpresora.Orden]
Carpeta=Lista
Clave=UsuarioImpresora.Orden
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
Impresora=525
Orden=38

[Lista.ListaEnCaptura]
(Inicio)=UsuarioImpresora.Impresora
UsuarioImpresora.Impresora=UsuarioImpresora.Orden
UsuarioImpresora.Orden=(Fin)
