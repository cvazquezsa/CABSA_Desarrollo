[Forma]
Clave=Sentinel
Nombre=Sentinel
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=276
PosicionInicialArriba=319
PosicionInicialAlturaCliente=358
PosicionInicialAncho=728
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Cliente, Info.Nombre, Info.Cantidad, Info.Tipo)
Totalizadores=S
PosicionSeccion1=89

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Sentinel
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
FiltroGeneral=Sentinel.Cliente=<T>{Info.Cliente}<T>

[Lista.Sentinel.Serie]
Carpeta=Lista
Clave=Sentinel.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Sentinel.Nombre]
Carpeta=Lista
Clave=Sentinel.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Sentinel.Usuarios]
Carpeta=Lista
Clave=Sentinel.Usuarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Sentinel.Fabricacion]
Carpeta=Lista
Clave=Sentinel.Fabricacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Sentinel.Vencimiento]
Carpeta=Lista
Clave=Sentinel.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Sentinel.Mantenimiento]
Carpeta=Lista
Clave=Sentinel.Mantenimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Serie=64
Nombre=239
Usuarios=47
Fabricacion=94
Vencimiento=106
Mantenimiento=134

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
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Vacio(Info.Cantidad, 0)>=Suma(Sentinel:Sentinel.Usuarios)
EjecucionMensaje=<T>No Puede Exceder a las Licencias<T>

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Usuarios Totales
Totalizadores2=Suma(Sentinel:Sentinel.Usuarios)
Totalizadores3=#,
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Usuarios Totales
CarpetaVisible=S

[(Carpeta Totalizadores).Usuarios Totales]
Carpeta=(Carpeta Totalizadores)
Clave=Usuarios Totales
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.ListaEnCaptura]
(Inicio)=Sentinel.Serie
Sentinel.Serie=Sentinel.Nombre
Sentinel.Nombre=Sentinel.Fabricacion
Sentinel.Fabricacion=Sentinel.Vencimiento
Sentinel.Vencimiento=Sentinel.Mantenimiento
Sentinel.Mantenimiento=Sentinel.Usuarios
Sentinel.Usuarios=(Fin)
