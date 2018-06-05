[Forma]
Clave=TransferirLote
Nombre=Transferir Lotes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=278
PosicionInicialArriba=103
PosicionInicialAlturaCliente=527
PosicionInicialAncho=467
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Almacen, Info.Articulo)
Totalizadores=S
PosicionSeccion1=93
ExpresionesAlMostrar=Forma(<T>EspecificarArtSubAlm<T>)<BR>Asigna(Info.Disponible, SQL(<T>spTransferirLoteSugerir :nEstacion, :tEmpresa, :tArt, :tSub, :tAlm<T>, EstacionTrabajo, Empresa, Info.Articulo, Info.SubCuenta, Info.Almacen))

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TransferirLote
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
Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=TransferirLote.Estacion={EstacionTrabajo}

[Lista.TransferirLote.Almacen]
Carpeta=Lista
Clave=TransferirLote.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Alm.Nombre]
Carpeta=Lista
Clave=Alm.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TransferirLote.Cantidad]
Carpeta=Lista
Clave=TransferirLote.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.Columnas]
Almacen=107
Nombre=264
Cantidad=53

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
GuardarAntes=S

[Acciones.Transferir]
Nombre=Transferir
Boton=7
NombreEnBoton=S
NombreDesplegar=&Transferir
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
ConCondicion=S
EjecucionConError=S
ConfirmarAntes=S
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=Expresion<BR>Cerrar
EjecucionCondicion=(Info.Disponible-Suma(TransferirLote:TransferirLote.Cantidad))>=0
EjecucionMensaje=<T>Excede al Disponible<T>

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
Totalizadores1=Existencia<BR>Asignado<BR>Disponible
Totalizadores2=Info.Disponible<BR>Suma(TransferirLote:TransferirLote.Cantidad)<BR>Info.Disponible-Suma(TransferirLote:TransferirLote.Cantidad)
Totalizadores3=(Cantidades)<BR>(Cantidades)<BR>(Cantidades)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=$00808040
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Existencia]
Carpeta=(Carpeta Totalizadores)
Clave=Existencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Asignado]
Carpeta=(Carpeta Totalizadores)
Clave=Asignado
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata
ColorFuente=$00004080
Efectos=[Negritas]

[(Carpeta Totalizadores).Disponible]
Carpeta=(Carpeta Totalizadores)
Clave=Disponible
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

[Acciones.Transferir.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spTransferirLoteGenerar :nEstacion, :tEmpresa, :tArt, :tSub, :tAlm, :tUsuario, :fFecha<T>, EstacionTrabajo, Empresa, Info.Articulo, Info.SubCuenta, Info.Almacen, Usuario, FechaTrabajo)

[Acciones.Transferir.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Transferir
Transferir=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TransferirLote.Almacen
TransferirLote.Almacen=Alm.Nombre
Alm.Nombre=TransferirLote.Cantidad
TransferirLote.Cantidad=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Existencia
Existencia=Asignado
Asignado=Disponible
Disponible=(Fin)
