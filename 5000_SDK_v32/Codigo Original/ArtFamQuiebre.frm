[Forma]
Clave=ArtFamQuiebre
Nombre=Generar Presupuesto de Ventas
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=291
PosicionInicialArriba=267
PosicionInicialAltura=309
PosicionInicialAncho=698
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
PosicionSeccion1=43
PosicionColumna1=46
PosicionInicialAlturaCliente=462
ExpresionesAlMostrar=Asigna(Info.Ejercicio, Año(Hoy))<BR>Asigna(Info.Periodo, Mes(Hoy))<BR>Asigna(Info.Cliente, Config.ClienteFacturaVMOS)<BR>Asigna(Info.Almacen, Usuario.DefAlmacen)

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtFam
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaMostrarRenglones=S
HojaConfirmarEliminar=S
HojaAjustarColumnas=S

[Lista.ArtFam.Familia]
Carpeta=Lista
Clave=ArtFam.Familia
Editar=N
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=45
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.ArtFam.Familia]
Carpeta=Detalle
Clave=ArtFam.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
Efectos=[Negritas]

[Detalle.ArtFam.Icono]
Carpeta=Detalle
Clave=ArtFam.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Columnas]
Familia=352
Descripcion=310
Precios=40
BasePresupuesto=111
UltimoQuiebre=124
QuiebreFechaD=94
QuiebreFechaA=94

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Cerrar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S
Visible=S

[Detalle.Columnas]
Familia=64
Descripcion=304
Icono=64

[Detalle.ArtFam.FamiliaMaestra]
Carpeta=Detalle
Clave=ArtFam.FamiliaMaestra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[ArtFamD.ArtFamD.TipoPropiedad]
Carpeta=ArtFamD
Clave=ArtFamD.TipoPropiedad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[ArtFamD.Columnas]
TipoPropiedad=194

[Acciones.Presupuesto]
Nombre=Presupuesto
Boton=47
NombreEnBoton=S
NombreDesplegar=&Presupuesto Familia
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtFamPresupuesto
Visible=S
EspacioPrevio=S
Antes=S
ConCondicion=S
Activo=S
EjecucionCondicion=ConDatos(ArtFam:ArtFam.Familia)
AntesExpresiones=Asigna(Info.ArtFam, ArtFam:ArtFam.Familia)

[Lista.ArtFam.BasePresupuesto]
Carpeta=Lista
Clave=ArtFam.BasePresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=Guardar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Quiebre]
Nombre=Quiebre
Boton=47
NombreEnBoton=S
NombreDesplegar=&Quiebre Familia
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtQuiebre
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ArtFam:ArtFam.Familia)
AntesExpresiones=Asigna(Info.ArtFam, ArtFam:ArtFam.Familia)<BR>Asigna(Info.Base, ArtFam:ArtFam.BasePresupuesto)

[Acciones.Procesar]
Nombre=Procesar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Procesar Quiebres
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtQuiebreProcesar
Activo=S
Visible=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=92
NombreEnBoton=S
NombreDesplegar=&Actualizar Quiebres
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtQuiebreActualizar
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
GuardarAntes=S
AntesExpresiones=Asigna(Info.ArtFam, <T><T>)

[Acciones.CtePresupuesto]
Nombre=CtePresupuesto
Boton=68
NombreEnBoton=S
NombreDesplegar=&Cuota Cte/Suc
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CtePresupuesto
Activo=S
Visible=S
EspacioPrevio=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Guardar
Guardar=Presupuesto
Presupuesto=Actualizar
Actualizar=Quiebre
Quiebre=Procesar
Procesar=CtePresupuesto
CtePresupuesto=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtFam.Familia
ArtFam.Familia=ArtFam.BasePresupuesto
ArtFam.BasePresupuesto=(Fin)
