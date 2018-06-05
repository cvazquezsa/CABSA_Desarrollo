
[Forma]
Clave=IntelisisSLD
Icono=22
Modulos=(Todos)
Nombre=Licenciamientos

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=372
PosicionInicialArriba=158
PosicionInicialAlturaCliente=416
PosicionInicialAncho=621
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Cliente, Info.Clave, Info.Nombre)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
EsConsultaExclusiva=S
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=IntelisisSLD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S


FiltroGeneral=IntelisisSLD.Licencia=<T>{Info.Clave}<T>
[Lista.IntelisisSLD.Cantidad]
Carpeta=Lista
Clave=IntelisisSLD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.IntelisisSLD.Estatus]
Carpeta=Lista
Clave=IntelisisSLD.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Columnas]
Menu=182
Modulos=391
Cantidad=48
Estatus=86


Licencia=304
Licenciamiento=311
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






[Acciones.Hist]
Nombre=Hist
Boton=53
NombreDesplegar=&Histórico
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=IntelisisSLDHist
Activo=S
Visible=S













[Lista.IntelisisSLD.Licenciamiento]
Carpeta=Lista
Clave=IntelisisSLD.Licenciamiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco









[Lista.ListaEnCaptura]
(Inicio)=IntelisisSLD.Licenciamiento
IntelisisSLD.Licenciamiento=IntelisisSLD.Cantidad
IntelisisSLD.Cantidad=IntelisisSLD.Estatus
IntelisisSLD.Estatus=(Fin)













[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Hist
Hist=(Fin)
