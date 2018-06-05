
[Forma]
Clave=RutaDistribucionMaxMin
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Ruta de Distribución para Máximos y Mínimos

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=500
PosicionInicialArriba=233
PosicionInicialAlturaCliente=236
PosicionInicialAncho=411
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RutaDistribucionMaxMin
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

PermiteEditar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=RutaDistribucionMaxMin.Orden<TAB>(Acendente)
FiltroGeneral=RutaDistribucionMaxMin.AlmacenDestino = {Comillas(Info.Almacen)}
[Lista.RutaDistribucionMaxMin.AlmacenOrigen]
Carpeta=Lista
Clave=RutaDistribucionMaxMin.AlmacenOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.RutaDistribucionMaxMin.AlmacenDestino]
Carpeta=Lista
Clave=RutaDistribucionMaxMin.AlmacenDestino
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Lista.Columnas]
AlmacenOrigen=169
AlmacenDestino=178




Almacen=90
Nombre=229
Grupo=100
Sucursal=46
0=164
1=173
[FormaExtraValor.Columnas]
VerCampo=298
VerValor=266

[(Carpeta Abrir).Columnas]
0=119
1=369
2=-2






[Acciones.Guardar]
Nombre=Guardar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=&Ordenar
EnBarraHerramientas=S
Activo=S
Visible=S

EspacioPrevio=S

















Multiple=S
ListaAccionesMultiples=Actualiza
[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S














[Acciones.Ordenar.Actualiza]
Nombre=Actualiza
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=FormaModal(<T>RutaDistribucionMaxMinOrden<T>)<BR>ActualizarForma
[Lista.ListaEnCaptura]
(Inicio)=RutaDistribucionMaxMin.AlmacenOrigen
RutaDistribucionMaxMin.AlmacenOrigen=RutaDistribucionMaxMin.AlmacenDestino
RutaDistribucionMaxMin.AlmacenDestino=(Fin)












[Acciones.Ordenar.ListaAccionesMultiples]
(Inicio)=Actualiza
Actualiza=Ordena
Ordena=(Fin)









[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cancelar
Cancelar=Ordenar
Ordenar=(Fin)
