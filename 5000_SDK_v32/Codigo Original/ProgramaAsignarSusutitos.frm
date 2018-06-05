[Forma]
Clave=ProgramaAsignarSusutitos
Nombre=Asignar Susutitos Disponibles
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=166
PosicionInicialArriba=161
PosicionInicialAlturaCliente=412
PosicionInicialAncho=691
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Cantidad, Info.Articulo, Info.Descripcion, Info.Almacen)
Totalizadores=S
PosicionSeccion1=91
VentanaExclusiva=S
ExpresionesAlMostrar=EjecutarSQL(<T>spVentaAsignarSusutitos :nEstacion, :tEmpresa, :tAlm, :tArt<T>, EstacionTrabajo, Empresa, Info.Almacen, Info.Articulo)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaAsignarSusutitos
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
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
MenuLocal=S
ListaAcciones=Copiar
OtroOrden=S
ListaOrden=VentaAsignarSusutitos.Orden<TAB>(Acendente)
FiltroGeneral=VentaAsignarSusutitos.Estacion={EstacionTrabajo}

[Lista.VentaAsignarSusutitos.Articulo]
Carpeta=Lista
Clave=VentaAsignarSusutitos.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Lista.VentaAsignarSusutitos.Disponible]
Carpeta=Lista
Clave=VentaAsignarSusutitos.Disponible
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=$00808040
Efectos=[Negritas]

[Lista.VentaAsignarSusutitos.Cantidad]
Carpeta=Lista
Clave=VentaAsignarSusutitos.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.Columnas]
Articulo=127
Descripcion1=200
SubCuenta=109
Almacen=88
Disponible=59
Cantidad=52
Factor=38
CantidadFactor=99

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
AntesExpresiones=EjecutarSQL(<T>spProgramaAsignarSusutitosAceptar :nEstacion, :nID, :nRenglon, :tArt, :tSub<T>, EstacionTrabajo, Info.ID, Info.Renglon, Info.Articulo, Info.SubCuenta)

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Acciones.Copiar]
Nombre=Copiar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Copiar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(VentaAsignarSusutitos:VentaAsignarSusutitos.Cantidad, VentaAsignarSusutitos:CantidadFactor)

[Lista.VentaAsignarSusutitos.SubCuenta]
Carpeta=Lista
Clave=VentaAsignarSusutitos.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
NombreDesplegar=CambiarVista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
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
Totalizadores1=Total
Totalizadores2=Suma(VentaAsignarSusutitos:VentaAsignarSusutitos.Cantidad)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
ListaEnCaptura=Total

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.CantidadFactor]
Carpeta=Lista
Clave=CantidadFactor
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=CambiarVista
CambiarVista=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaAsignarSusutitos.Articulo
VentaAsignarSusutitos.Articulo=Art.Descripcion1
Art.Descripcion1=VentaAsignarSusutitos.SubCuenta
VentaAsignarSusutitos.SubCuenta=CantidadFactor
CantidadFactor=VentaAsignarSusutitos.Disponible
VentaAsignarSusutitos.Disponible=VentaAsignarSusutitos.Cantidad
VentaAsignarSusutitos.Cantidad=(Fin)
