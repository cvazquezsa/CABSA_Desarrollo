
[Forma]
Clave=VisorWebConfigD
Icono=0
Modulos=(Todos)
Nombre=Detalle
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
PosicionInicialIzquierda=443
PosicionInicialArriba=172
PosicionInicialAlturaCliente=488
PosicionInicialAncho=715
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Categoria
ListaAcciones=(Lista)
[Hoja]
Estilo=Hoja
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VisorWebConfigD
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

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=VisorWebConfigD.Orden<TAB>(Acendente)

FiltroGeneral=VisorWebConfigD.Formato=<T>{Info.Categoria}<T>
[Hoja.VisorWebConfigD.TabTitulo]
Carpeta=Hoja
Clave=VisorWebConfigD.TabTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Hoja.VisorWebConfigD.Zona]
Carpeta=Hoja
Clave=VisorWebConfigD.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Hoja.VisorWebConfigD.ZonaTitulo]
Carpeta=Hoja
Clave=VisorWebConfigD.ZonaTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Hoja.VisorWebConfigD.URL]
Carpeta=Hoja
Clave=VisorWebConfigD.URL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Hoja.VisorWebConfigD.Bloqueado]
Carpeta=Hoja
Clave=VisorWebConfigD.Bloqueado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Hoja.Columnas]
Orden=64
TabTitulo=108
Zona=28
ZonaTitulo=108
URL=376
Bloqueado=53




[Acciones.Orden]
Nombre=Orden
Boton=50
EnBarraHerramientas=S
Activo=S
Visible=S
NombreDesplegar=Cambiar &Orden
TipoAccion=Formas
ClaveAccion=VisorWebOrdenar

GuardarAntes=S
Multiple=S
ListaAccionesMultiples=(Lista)
EspacioPrevio=S

[Acciones.Orden.VisorWebOrdenar]
Nombre=VisorWebOrdenar
Boton=0
TipoAccion=Formas
ClaveAccion=VisorWebOrdenar
Activo=S
Visible=S

[Acciones.Orden.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S


[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S






[Acciones.Orden.ListaAccionesMultiples]
(Inicio)=VisorWebOrdenar
VisorWebOrdenar=Actualizar Vista
Actualizar Vista=(Fin)
































































[Hoja.ListaEnCaptura]
(Inicio)=VisorWebConfigD.TabTitulo
VisorWebConfigD.TabTitulo=VisorWebConfigD.Zona
VisorWebConfigD.Zona=VisorWebConfigD.ZonaTitulo
VisorWebConfigD.ZonaTitulo=VisorWebConfigD.URL
VisorWebConfigD.URL=VisorWebConfigD.Bloqueado
VisorWebConfigD.Bloqueado=(Fin)

































































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Orden
Orden=(Fin)
