
[Forma]
Clave=SAUXArtServicio
Icono=0
CarpetaPrincipal=Ficha
Modulos=(Todos)
Nombre=Servicios de Artículos

ListaCarpetas=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Articulo, Info.Descripcion)
PosicionInicialAlturaCliente=234
PosicionInicialAncho=522
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=539
PosicionInicialArriba=314
ListaAcciones=(Lista)
[Ficha]
Estilo=Hoja
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SAUXArtServicio
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
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
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGeneral=SAUXArtServicio.Articulo = <T>{Info.Articulo}<T>
[Ficha.SAUXArtServicio.Servicio]
Carpeta=Ficha
Clave=SAUXArtServicio.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Columnas]
Servicio=103

Cantidad=64
Articulo=172
Descripcion=312
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(SAUXArtServicio.Servicio)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>                                       
EjecucionConError=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Visible=S





EspacioPrevio=S
ActivoCondicion=Usuario.EnviarExcel
























[Ficha.SAUXArtServicio.Cantidad]
Carpeta=Ficha
Clave=SAUXArtServicio.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Lista.Columnas]
Servicio=131
Descripcion=604





[Ficha.ListaEnCaptura]
(Inicio)=SAUXArtServicio.Servicio
SAUXArtServicio.Servicio=Descripcion
Descripcion=SAUXArtServicio.Cantidad
SAUXArtServicio.Cantidad=(Fin)

[Ficha.Descripcion]
Carpeta=Ficha
Clave=Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata



























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)
