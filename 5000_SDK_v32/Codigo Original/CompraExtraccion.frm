
[Forma]
Clave=CompraExtraccion
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=COMS
Nombre=Generar Extracción
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=64
PosicionInicialArriba=143
PosicionInicialAlturaCliente=448
PosicionInicialAncho=895
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraExtraccion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
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
ValidarCampos=S
ListaCamposAValidar=(Lista)
FiltroGeneral=CompraExtraccion.Estacion = {EstacionTrabajo} AND CompraExtraccion.ID = {Info.ID}
[Lista.CompraExtraccion.Articulo]
Carpeta=Lista
Clave=CompraExtraccion.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.CompraExtraccion.SubCuenta]
Carpeta=Lista
Clave=CompraExtraccion.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.CompraExtraccion.SerieLote]
Carpeta=Lista
Clave=CompraExtraccion.SerieLote
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.Columnas]
Articulo=105
SubCuenta=86
SerieLote=84

Descripcion1=214
Existencia=51
CantidadA=58

Cantidad=48

Saldo=45
Observaciones=177
Paquete=48
PaqueteCantidad=90
ReferenciaExtra=94
ImportacionReferencia=99
DescripcionExtra=89
[Lista.CompraExtraccion.Existencia]
Carpeta=Lista
Clave=CompraExtraccion.Existencia
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.CompraExtraccion.CantidadA]
Carpeta=Lista
Clave=CompraExtraccion.CantidadA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=Generar &Orden Extracción
EnBarraHerramientas=S
Activo=S
Visible=S

GuardarAntes=S
ConCondicion=S
Multiple=S
ListaAccionesMultiples=(Lista)
EspacioPrevio=S
EjecucionCondicion=ConDatos(CompraExtraccion:CompraExtraccion.ID)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S











Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar Cambios
Cancelar Cambios=Cerrar
Cerrar=(Fin)

















[Acciones.Generar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Si(Forma(<T>GenerarCompraExtraccion<T>), ProcesarSQL(<T>spGenerarInvExtraccion :nEstacion, :nID, :tEmpresa, :tMov, :tAlm, :tUsuario, :nSucursal<T>, EstacionTrabajo, Info.ID, Empresa, Rep.MovEspecifico, Info.AlmacenDestino, Usuario, Sucursal))
[Acciones.Generar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S





[Lista.CompraExtraccion.Cantidad]
Carpeta=Lista
Clave=CompraExtraccion.Cantidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro







[Acciones.Generar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)





[Lista.CompraExtraccion.Paquete]
Carpeta=Lista
Clave=CompraExtraccion.Paquete
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.CompraExtraccion.PaqueteCantidad]
Carpeta=Lista
Clave=CompraExtraccion.PaqueteCantidad
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro












[Lista.CompraExtraccion.ReferenciaExtra]
Carpeta=Lista
Clave=CompraExtraccion.ReferenciaExtra
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.CompraExtraccion.ImportacionReferencia]
Carpeta=Lista
Clave=CompraExtraccion.ImportacionReferencia
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.CompraExtraccion.DescripcionExtra]
Carpeta=Lista
Clave=CompraExtraccion.DescripcionExtra
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=CompraExtraccion.ReferenciaExtra
CompraExtraccion.ReferenciaExtra=CompraExtraccion.ImportacionReferencia
CompraExtraccion.ImportacionReferencia=CompraExtraccion.DescripcionExtra
CompraExtraccion.DescripcionExtra=CompraExtraccion.Articulo
CompraExtraccion.Articulo=CompraExtraccion.SubCuenta
CompraExtraccion.SubCuenta=CompraExtraccion.Cantidad
CompraExtraccion.Cantidad=CompraExtraccion.Paquete
CompraExtraccion.Paquete=CompraExtraccion.PaqueteCantidad
CompraExtraccion.PaqueteCantidad=CompraExtraccion.Existencia
CompraExtraccion.Existencia=CompraExtraccion.SerieLote
CompraExtraccion.SerieLote=CompraExtraccion.CantidadA
CompraExtraccion.CantidadA=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OpcionDesc
OpcionDesc=(Fin)









[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Generar
Generar=Cancelar
Cancelar=(Fin)
