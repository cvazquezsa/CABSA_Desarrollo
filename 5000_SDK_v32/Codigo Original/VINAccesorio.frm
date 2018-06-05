[Forma]
Clave=VINAccesorio
Nombre=Componentes del VIN
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=370
PosicionInicialArriba=266
PosicionInicialAlturaCliente=458
PosicionInicialAncho=539
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.VIN
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
Totalizadores=S
PosicionSeccion1=92
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VINAccesorio
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PermiteEditar=S
CondicionEdicion=(no Info.Bloqueado) y Usuario.ModificarVINAccesorio
FiltroGeneral=VINAccesorio.VIN=<T>{Info.VIN}<T> AND VINAccesorio.Estatus=<T>ALTA<T>

[Lista.VINAccesorio.Accesorio]
Carpeta=Lista
Clave=VINAccesorio.Accesorio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VINAccesorio.Descripcion]
Carpeta=Lista
Clave=VINAccesorio.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VINAccesorio.PrecioDistribuidor]
Carpeta=Lista
Clave=VINAccesorio.PrecioDistribuidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VINAccesorio.PrecioPublico]
Carpeta=Lista
Clave=VINAccesorio.PrecioPublico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Accesorio=95
Descripcion=193
PrecioDistribuidor=113
PrecioPublico=94

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

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
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
Totalizadores1=Precio Distribuidor<BR>Precio Publico
Totalizadores2=Suma( VINAccesorio:VINAccesorio.PrecioDistribuidor )<BR>Suma( VINAccesorio:VINAccesorio.PrecioPublico )
Totalizadores3=(Monetario)<BR>(Monetario)
ListaEnCaptura=(Lista)

[(Carpeta Totalizadores).Precio Distribuidor]
Carpeta=(Carpeta Totalizadores)
Clave=Precio Distribuidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Precio Publico]
Carpeta=(Carpeta Totalizadores)
Clave=Precio Publico
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.ListaEnCaptura]
(Inicio)=VINAccesorio.Accesorio
VINAccesorio.Accesorio=VINAccesorio.Descripcion
VINAccesorio.Descripcion=VINAccesorio.PrecioDistribuidor
VINAccesorio.PrecioDistribuidor=VINAccesorio.PrecioPublico
VINAccesorio.PrecioPublico=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Precio Distribuidor
Precio Distribuidor=Precio Publico
Precio Publico=(Fin)
