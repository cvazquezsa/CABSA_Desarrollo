[Forma]
Clave=CodigoPostal
Nombre=Códigos Postales
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=510
PosicionInicialArriba=374
PosicionInicialAltura=442
PosicionInicialAncho=900
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=415
Comentarios=Info.Ruta

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CodigoPostal
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
PermiteEditar=S
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=CodigoPostal.Estado
FiltroGrupo2=CodigoPostal.Delegacion
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=25
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=25
BusquedaEnLinea=S
FiltroGrupo3=CodigoPostal.Colonia
FiltroGrupo4=CodigoPostal.CodigoPostal
FiltroGeneral={Si(ConDatos(Info.Ruta), <T>CodigoPostal.Ruta=<T>+Comillas(Info.Ruta), <T>1=1<T>)}

[Lista.CodigoPostal.Delegacion]
Carpeta=Lista
Clave=CodigoPostal.Delegacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CodigoPostal.Colonia]
Carpeta=Lista
Clave=CodigoPostal.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CodigoPostal.CodigoPostal]
Carpeta=Lista
Clave=CodigoPostal.CodigoPostal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Delegacion=122
Colonia=200
CodigoPostal=71
Zona=33
Ruta=80
Estado=132
LocalidadCNBV=79

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

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Lista.CodigoPostal.Ruta]
Carpeta=Lista
Clave=CodigoPostal.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CodigoPostal.Estado]
Carpeta=Lista
Clave=CodigoPostal.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CodigoPostal.LocalidadCNBV]
Carpeta=Lista
Clave=CodigoPostal.LocalidadCNBV
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CodigoPostal.Estado
CodigoPostal.Estado=CodigoPostal.Delegacion
CodigoPostal.Delegacion=CodigoPostal.Colonia
CodigoPostal.Colonia=CodigoPostal.CodigoPostal
CodigoPostal.CodigoPostal=CodigoPostal.Ruta
CodigoPostal.Ruta=CodigoPostal.LocalidadCNBV
CodigoPostal.LocalidadCNBV=(Fin)
