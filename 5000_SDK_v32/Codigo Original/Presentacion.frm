[Forma]
Clave=Presentacion
Nombre=Presentaciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=375
PosicionInicialArriba=294
PosicionInicialAlturaCliente=401
PosicionInicialAncho=530
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Info.PresentacionGrupo, Nulo)<BR>Asigna(Info.FechaD, PrimerDiaMes(Hoy))<BR>Asigna(Info.FechaA, UltimoDiaMes(Hoy))<BR>Asigna(Info.Desc, Nulo)<BR>Asigna(Info.DescTipo, <T>%<T>)<BR>Asigna(Info.Region, Nulo)<BR>Asigna(Info.Sucursal, Nulo)<BR>Asigna(Info.Redondeo, 2)<BR>Asigna(Info.PresentacionPrecioOfertaBase, <T>Precio Unitario<T>)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Presentacion
Fuente={Tahoma, 8, Negro, []}
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
HojaTitulos=S
HojaMostrarColumnas=S
HojaMantenerSeleccion=S
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
BusquedaAncho=20
BusquedaEnLinea=S

[Lista.Presentacion.Presentacion]
Carpeta=Lista
Clave=Presentacion.Presentacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Presentacion=299
Grupo=201

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

[Lista.Presentacion.Grupo]
Carpeta=Lista
Clave=Presentacion.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Grupos]
Nombre=Grupos
Boton=91
NombreEnBoton=S
NombreDesplegar=&Grupos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PresentacionGrupo
Activo=S
Visible=S

[Acciones.Precios]
Nombre=Precios
Boton=47
NombreEnBoton=S
NombreDesplegar=&Precios
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PresentacionPrecio
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=General.CR
EjecucionCondicion=ConDatos(Presentacion:Presentacion.Presentacion)
AntesExpresiones=Asigna(Info.Presentacion, Presentacion:Presentacion.Presentacion)

[Acciones.Ofertas]
Nombre=Ofertas
Boton=12
NombreEnBoton=S
NombreDesplegar=&Ofertas
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
Expresion=Si<BR>  Forma(<T>PresentacionPrecioOferta<T>)<BR>Entonces<BR>  ProcesarSQL(<T>spPresentacionPrecioOferta :tEmpresa, :tGrupo, :tRegion, :nSuc, :fFechaD, :fFechaA, :tBase, :nDesc, :tDescTipo, :nRedondeo<T>, Empresa, Info.PresentacionGrupo, Info.Region, Info.Sucursal, Info.FechaD, Info.FechaA, Info.PresentacionPrecioOfertaBase, Info.Desc, Info.DescTipo, Info.Redondeo) <BR>Fin
ActivoCondicion=General.CR

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Precios
Precios=Ofertas
Ofertas=Grupos
Grupos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Presentacion.Presentacion
Presentacion.Presentacion=Presentacion.Grupo
Presentacion.Grupo=(Fin)
