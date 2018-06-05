
[Forma]
Clave=eCommerceMetodoEnvioCfg
Icono=0
CarpetaPrincipal=eCommerceMetodoEnvioCfg
Modulos=(Todos)

ListaCarpetas=(Lista)
PosicionInicialAlturaCliente=489
PosicionInicialAncho=629
PosicionInicialIzquierda=368
PosicionInicialArriba=100
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionSec1=202
PosicionCol1=410
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
BarraHerramientas=S
BarraAyuda=S
BarraAyudaBold=S
DialogoAbrir=S
Comentarios=Info.Clave
Nombre=Métodos de Envío
[eCommerceMetodoEnvioCfg]
Estilo=Ficha
Clave=eCommerceMetodoEnvioCfg
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eCommerceMetodoEnvioCfg
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PermiteEditar=S

[eCommerceMetodoEnvioCfg.eCommerceMetodoEnvioCfg.MetodoEnvio]
Carpeta=eCommerceMetodoEnvioCfg
Clave=eCommerceMetodoEnvioCfg.MetodoEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[eCommerceMetodoEnvioCfg.eCommerceMetodoEnvioCfg.Nombre]
Carpeta=eCommerceMetodoEnvioCfg
Clave=eCommerceMetodoEnvioCfg.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[PorArticulo.eCommerceMetodoEnvioCfg.PorcentajePrecio]
Carpeta=PorArticulo
Clave=eCommerceMetodoEnvioCfg.PorcentajePrecio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[PorcentajeGlobal.eCommerceMetodoEnvioCfg.PorcentajePrecio]
Carpeta=PorcentajeGlobal
Clave=eCommerceMetodoEnvioCfg.PorcentajePrecio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco














































[eCommerceMetodoEnvioCfg.eCommerceMetodoEnvioCfg.Precio5]
Carpeta=eCommerceMetodoEnvioCfg
Clave=eCommerceMetodoEnvioCfg.Precio5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
Pegado=N
[eCommerceMetodoEnvioCfg.eCommerceMetodoEnvioCfg.Precio4]
Carpeta=eCommerceMetodoEnvioCfg
Clave=eCommerceMetodoEnvioCfg.Precio4
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
LineaNueva=S
[eCommerceMetodoEnvioCfg.eCommerceMetodoEnvioCfg.Precio1]
Carpeta=eCommerceMetodoEnvioCfg
Clave=eCommerceMetodoEnvioCfg.Precio1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[eCommerceMetodoEnvioCfg.eCommerceMetodoEnvioCfg.Precio2]
Carpeta=eCommerceMetodoEnvioCfg
Clave=eCommerceMetodoEnvioCfg.Precio2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
Pegado=N
[eCommerceMetodoEnvioCfg.eCommerceMetodoEnvioCfg.Precio3]
Carpeta=eCommerceMetodoEnvioCfg
Clave=eCommerceMetodoEnvioCfg.Precio3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20











[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
EnBarraHerramientas=S


[eCommerceMetodoEnvioCfgD]
Estilo=Hoja
Clave=eCommerceMetodoEnvioCfgD
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=eCommerceMetodoEnvioCfgD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=eCommerceMetodoEnvioCfg
LlaveLocal=(Lista)

LlaveMaestra=(Lista)
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



CondicionVisible=eCommerceMetodoEnvioCfg:eCommerceMetodoEnvioCfg.MetodoEnvio EN(<T>Por Peso<T>,<T>Por Total de Pedido<T>,<T>shipping_byweight<T>,<T>shipping_bytotal<T>)
[eCommerceMetodoEnvioCfgD.eCommerceMetodoEnvioCfgD.NumeroD]
Carpeta=eCommerceMetodoEnvioCfgD
Clave=eCommerceMetodoEnvioCfgD.NumeroD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[eCommerceMetodoEnvioCfgD.eCommerceMetodoEnvioCfgD.NumeroA]
Carpeta=eCommerceMetodoEnvioCfgD
Clave=eCommerceMetodoEnvioCfgD.NumeroA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[eCommerceMetodoEnvioCfgD.eCommerceMetodoEnvioCfgD.Precio]
Carpeta=eCommerceMetodoEnvioCfgD
Clave=eCommerceMetodoEnvioCfgD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[eCommerceMetodoEnvioCfgD.Columnas]
NumeroD=146
NumeroA=196
Precio=229




[(Carpeta Abrir)]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Métodos de Envío
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=eCommerceMetodoEnvioCfgA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S


Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=eCommerceMetodoEnvioCfg.MetodoEnvio
FiltroAutoValidar=eCommerceMetodoEnvioCfg.MetodoEnvio
FiltroAutoOrden=eCommerceMetodoEnvioCfg.Nombre
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
ListaEnCaptura=eCommerceMetodoEnvioCfg.Nombre
IconosSubTitulo=<T> <T>
FiltroGrupo1=eCommerceMetodoEnvioCfg.MetodoEnvio
FiltroValida1=eCommerceMetodoEnvioCfg.MetodoEnvio
FiltroArbolClave=eCommerceMetodoEnvioCfg.MetodoEnvio
FiltroArbolValidar=eCommerceMetodoEnvioCfg.MetodoEnvio
FiltroTodo=S
FiltroTodoFinal=S
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroEstatusDefault=ACTIVO
IconosNombre=<T> <T>
IconosConPaginas=S
FiltroGeneral=eCommerceMetodoEnvioCfg.SucursaleCommerce=<T>{Info.Clave}<T>
[(Carpeta Abrir).Columnas]
0=28






















1=491
[(Carpeta Abrir).eCommerceMetodoEnvioCfg.Nombre]
Carpeta=(Carpeta Abrir)
Clave=eCommerceMetodoEnvioCfg.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco








































[Acciones.Documento Nuevo]
Nombre=Documento Nuevo
Boton=1
NombreDesplegar=&Nuevo
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S



[Acciones.Documento Abrir]
Nombre=Documento Abrir
Boton=2
NombreDesplegar=&Abrir
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S





[Acciones.Documento Eliminar]
Nombre=Documento Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Activo=S
Visible=S









[Acciones.Actualizar Forma]
Nombre=Actualizar Forma
Boton=23
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


















NombreDesplegar=Metodo Envio &Activo
GuardarAntes=S
ConCondicion=S
Antes=S
EspacioPrevio=S
EjecucionCondicion=eCommerceMetodoEnvioCfg:eCommerceMetodoEnvioCfg.Estatus <> EstatusActivo
AntesExpresiones=Asigna(eCommerceMetodoEnvioCfg:eCommerceMetodoEnvioCfg.Estatus,EstatusActivo)
[eCommerceMetodoEnvioCfg.ListaEnCaptura]
(Inicio)=eCommerceMetodoEnvioCfg.MetodoEnvio
eCommerceMetodoEnvioCfg.MetodoEnvio=eCommerceMetodoEnvioCfg.Nombre
eCommerceMetodoEnvioCfg.Nombre=eCommerceMetodoEnvioCfg.Precio1
eCommerceMetodoEnvioCfg.Precio1=eCommerceMetodoEnvioCfg.Precio3
eCommerceMetodoEnvioCfg.Precio3=eCommerceMetodoEnvioCfg.Precio2
eCommerceMetodoEnvioCfg.Precio2=eCommerceMetodoEnvioCfg.Precio4
eCommerceMetodoEnvioCfg.Precio4=eCommerceMetodoEnvioCfg.Precio5
eCommerceMetodoEnvioCfg.Precio5=(Fin)






















[Acciones.Inactivo]
Nombre=Inactivo
Boton=21
NombreDesplegar=Metodo Envio &Inactivo
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
ConCondicion=S
Antes=S
Visible=S







EspacioPrevio=S
EjecucionCondicion=eCommerceMetodoEnvioCfg:eCommerceMetodoEnvioCfg.Estatus <> EstatusInActivo
AntesExpresiones=Asigna(eCommerceMetodoEnvioCfg:eCommerceMetodoEnvioCfg.Estatus,EstatusInActivo)




[Acciones.Navegador (Documentos)]
Nombre=Navegador (Documentos)
Boton=0
NombreDesplegar=Navegador (Documentos)
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S



EspacioPrevio=S
























[eCommerceMetodoEnvioCfgD.LlaveLocal]
(Inicio)=eCommerceMetodoEnvioCfgD.SucursaleCommerce
eCommerceMetodoEnvioCfgD.SucursaleCommerce=eCommerceMetodoEnvioCfgD.MetodoEnvio
eCommerceMetodoEnvioCfgD.MetodoEnvio=eCommerceMetodoEnvioCfgD.Nombre
eCommerceMetodoEnvioCfgD.Nombre=(Fin)

[eCommerceMetodoEnvioCfgD.LlaveMaestra]
(Inicio)=eCommerceMetodoEnvioCfg.SucursaleCommerce
eCommerceMetodoEnvioCfg.SucursaleCommerce=eCommerceMetodoEnvioCfg.MetodoEnvio
eCommerceMetodoEnvioCfg.MetodoEnvio=eCommerceMetodoEnvioCfg.Nombre
eCommerceMetodoEnvioCfg.Nombre=(Fin)

[eCommerceMetodoEnvioCfgD.ListaEnCaptura]
(Inicio)=eCommerceMetodoEnvioCfgD.NumeroD
eCommerceMetodoEnvioCfgD.NumeroD=eCommerceMetodoEnvioCfgD.NumeroA
eCommerceMetodoEnvioCfgD.NumeroA=eCommerceMetodoEnvioCfgD.Precio
eCommerceMetodoEnvioCfgD.Precio=(Fin)











[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ACTIVO
ACTIVO=INACTIVO
INACTIVO=(Fin)

[Forma.ListaCarpetas]
(Inicio)=eCommerceMetodoEnvioCfg
eCommerceMetodoEnvioCfg=eCommerceMetodoEnvioCfgD
eCommerceMetodoEnvioCfgD=(Fin)

[Forma.ListaAcciones]
(Inicio)=Documento Nuevo
Documento Nuevo=Documento Abrir
Documento Abrir=Aceptar
Aceptar=Documento Eliminar
Documento Eliminar=Actualizar Forma
Actualizar Forma=Inactivo
Inactivo=Navegador (Documentos)
Navegador (Documentos)=(Fin)
