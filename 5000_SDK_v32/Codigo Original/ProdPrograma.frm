[Forma]
Clave=ProdPrograma
Nombre=<T>Programa - <T>+Info.Mov+<T> <T>+Info.MovID, 
Icono=17
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=(Lista)
CarpetaPrincipal=Materiales
Comentarios=Lista(<T>Inicio: <T>+ FechaEnTexto(Info.FechaInicio, <T>dd/mmm/aaaa<T>), <T>Entrega: <T>+FechaEnTexto(Info.FechaEntrega, <T>dd/mmm/aaaa<T>))
ListaAcciones=(Lista)
PosicionInicialIzquierda=192
PosicionInicialArriba=283
PosicionInicialAltura=398
PosicionInicialAncho=895
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialAlturaCliente=430
ExpresionesAlMostrar=Asigna(Temp.Texto, SQL(<T>IF NOT EXISTS(SELECT * FROM ProdProgramaMaterial WHERE ID = :nID) AND (SELECT Estatus FROM Prod WHERE ID=:ID) NOT IN (:te1,:te2,:te3) EXEC spProdExplotar :nSucursal, :tEmpresa, :tUsuario, :tAccion, :tModulo, :nID, NULL, 1, NULL, NULL ELSE SELECT NULL<T>, Info.ID, Info.ID, <T>CONCLUIDO<T>, <T>PENDIENTE<T>, <T>CANCELADO<T>, Sucursal, Empresa, Usuario, <T>AFECTAR<T>, <T>PROD<T>, Info.ID))<BR>Si(ConDatos(Temp.Texto), Error(Temp.Texto))

[Lista.Columnas]
Lote=58
Producto=72
SubProducto=70
Articulo=81
SubCuenta=82
Cantidad=49
Unidad=41
Factor=64
Merma=40
Desperdicio=60
AlmacenDestino=86
AlmacenOrigen=80
FechaRequerida=86
LoteProducto=156
Disponible=53
Centro_1=64
Estacion_1=64
Centro=64
Estacion=64

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
NombreDesplegar=CambiarVista
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Regenerar Programa.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>EXEC spProdExplotar :nSucursal, :tEmpresa, :tUsuario, :tAccion, :tModulo, :nID, NULL, 1, NULL, NULL<T>, Sucursal, Empresa, Usuario, <T>AFECTAR<T>, <T>PROD<T>, Info.ID)<BR><BR>Informacion(<T>Programa Regenerado !<T>)

[Acciones.Regenerar Programa.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Materiales]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Materiales
Clave=Materiales
Filtros=S
ValidarCampos=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProdProgramaMaterial
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Rojo obscuro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
ListaCamposAValidar=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Predefinido
CarpetaVisible=S
MenuLocal=S
ListaAcciones=(Lista)
ControlRenglon=S
CampoRenglon=ProdProgramaMaterial.Renglon
CondicionEdicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador) y Config.ProdProgramar
FiltroPredefinido1=por Producto<BR>por Material
FiltroPredefinido3=Producto, SubProducto<BR>AlmacenOrigen, ProdProgramaMaterial.Articulo, ProdProgramaMaterial.SubCuenta
FiltroPredefinido2=ProdProgramaMaterial.ID={Info.ID}<BR>ProdProgramaMaterial.ID={Info.ID}
FiltroEstilo=Directorio

[Materiales.ProdProgramaMaterial.Lote]
Carpeta=Materiales
Clave=ProdProgramaMaterial.Lote
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Rojo obscuro

[Materiales.ProdProgramaMaterial.Producto]
Carpeta=Materiales
Clave=ProdProgramaMaterial.Producto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Rojo obscuro

[Materiales.ProdProgramaMaterial.SubProducto]
Carpeta=Materiales
Clave=ProdProgramaMaterial.SubProducto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Rojo obscuro

[Materiales.ProdProgramaMaterial.Articulo]
Carpeta=Materiales
Clave=ProdProgramaMaterial.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Materiales.ProdProgramaMaterial.SubCuenta]
Carpeta=Materiales
Clave=ProdProgramaMaterial.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=$00808040

[Materiales.ProdProgramaMaterial.AlmacenOrigen]
Carpeta=Materiales
Clave=ProdProgramaMaterial.AlmacenOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Materiales.Disponible]
Carpeta=Materiales
Clave=Disponible
IgnoraFlujo=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=$00800040
Efectos=[Negritas]

[Materiales.ProdProgramaMaterial.Cantidad]
Carpeta=Materiales
Clave=ProdProgramaMaterial.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Materiales.ProdProgramaMaterial.Merma]
Carpeta=Materiales
Clave=ProdProgramaMaterial.Merma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Materiales.ProdProgramaMaterial.Desperdicio]
Carpeta=Materiales
Clave=ProdProgramaMaterial.Desperdicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Materiales.ProdProgramaMaterial.Unidad]
Carpeta=Materiales
Clave=ProdProgramaMaterial.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Materiales.Columnas]
Lote=59
Producto=78
SubProducto=51
Articulo=79
SubCuenta=75
AlmacenOrigen=79
Disponible=52
Cantidad=49
Merma=36
Desperdicio=59
Unidad=39
FechaRequerida=84
AlmacenDestino=83
CantidadP=49
UnidadP=38

[Ruta]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ruta
Clave=Ruta
Filtros=S
ValidarCampos=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProdProgramaRuta
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Rojo obscuro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
ListaCamposAValidar=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)
MenuLocal=S
ListaAcciones=(Lista)
CondicionEdicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador) y Config.ProdProgramar
FiltroGeneral=ProdProgramaRuta.ID={Info.ID}

[Ruta.ProdProgramaRuta.Lote]
Carpeta=Ruta
Clave=ProdProgramaRuta.Lote
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFuente=Rojo obscuro
ColorFondo=Plata

[Ruta.ProdProgramaRuta.Producto]
Carpeta=Ruta
Clave=ProdProgramaRuta.Producto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=Rojo obscuro
ColorFondo=Plata

[Ruta.ProdProgramaRuta.SubProducto]
Carpeta=Ruta
Clave=ProdProgramaRuta.SubProducto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFuente=Rojo obscuro
ColorFondo=Plata

[Ruta.ProdProgramaRuta.Cantidad]
Carpeta=Ruta
Clave=ProdProgramaRuta.Cantidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Rojo obscuro

[Ruta.ProdProgramaRuta.Centro]
Carpeta=Ruta
Clave=ProdProgramaRuta.Centro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFuente=Negro
ColorFondo=Blanco

[Ruta.ProdProgramaRuta.Estacion]
Carpeta=Ruta
Clave=ProdProgramaRuta.Estacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ruta.Columnas]
Lote=59
Producto=80
SubProducto=57
Cantidad=47
Unidad=38
Centro=83
Estacion=85
Ruta=80
Orden=37
Operacion=109
FechaInicio=75
FechaTermino=76
Tiempo=45
Horas=53
Dias=67
Carga=45
FechaProcesoInicio=79
FechaProcesoTermino=76

[Acciones.DividirRuta]
Nombre=DividirRuta
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Dividir
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
ConCondicion=S
Antes=S
Visible=S
GuardarAntes=S
DespuesGuardar=S
ActivoCondicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
EjecucionCondicion=ConDatos(ProdProgramaRuta:ProdProgramaRuta.ID)
AntesExpresiones=EjecutarSQL(<T>spProdProgramaRutaDividir :nID, :nRen, :nOrden<T>, ProdProgramaRuta:ProdProgramaRuta.ID, ProdProgramaRuta:ProdProgramaRuta.Renglon, ProdProgramaRuta:ProdProgramaRuta.OrdenID)

[Acciones.UnirRuta]
Nombre=UnirRuta
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+U
NombreDesplegar=&Unir
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S
ConCondicion=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
ActivoCondicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
EjecucionCondicion=ConDatos(ProdProgramaRuta:ProdProgramaRuta.ID)
AntesExpresiones=EjecutarSQL(<T>spProdProgramaRutaUnir :nID, :nRen, :nOrden<T>, ProdProgramaRuta:ProdProgramaRuta.ID, ProdProgramaRuta:ProdProgramaRuta.Renglon, ProdProgramaRuta:ProdProgramaRuta.OrdenID)

[Acciones.DividirMaterial]
Nombre=DividirMaterial
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Dividir
GuardarAntes=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
ActivoCondicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
EjecucionCondicion=ConDatos(ProdProgramaMaterial:ProdProgramaMaterial.ID)
AntesExpresiones=EjecutarSQL(<T>spProdProgramaMaterialDividir :nID, :nRenglon<T>, ProdProgramaMaterial:ProdProgramaMaterial.ID, ProdProgramaMaterial:ProdProgramaMaterial.Renglon)

[Acciones.UnirMaterial]
Nombre=UnirMaterial
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+U
NombreDesplegar=&Unir
GuardarAntes=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
ActivoCondicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
EjecucionCondicion=ConDatos(ProdProgramaMaterial:ProdProgramaMaterial.ID)
AntesExpresiones=EjecutarSQL(<T>spProdProgramaMaterialUnir :nID, :nRenglon<T>, ProdProgramaMaterial:ProdProgramaMaterial.ID, ProdProgramaMaterial:ProdProgramaMaterial.Renglon)

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Visible=S
ActivoCondicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente) y Config.ProdProgramar

[Materiales.ProdProgramaMaterial.FechaRequerida]
Carpeta=Materiales
Clave=ProdProgramaMaterial.FechaRequerida
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Ruta.ProdProgramaRuta.Operacion]
Carpeta=Ruta
Clave=ProdProgramaRuta.Operacion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Acciones.Calcular]
Nombre=Calcular
Boton=92
NombreEnBoton=S
NombreDesplegar=Calcular &Fechas
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
DespuesGuardar=S
Visible=S
ActivoCondicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador, EstatusPendiente) y Config.ProdProgramar
AntesExpresiones=Dialogo(<T>ProdProgramaCalcular<T>)<BR>Asigna(Temp.Logico, Falso)<BR>Caso Info.CalcularFechaPrograma<BR>  Es <T>Fecha Actual<T> Entonces Asigna(Info.CalcularFechaPrograma, <T>Fecha Inicio<T>) Asigna(Temp.Logico, Verdadero) <BR>  Es <T>Fecha Entrega<T> Entonces Asigna(Temp.Logico, Forma(<T>EspecificarFechaInicio<T>))<BR>  Es <T>Fecha Inicio<T> Entonces Asigna(Temp.Logico, Forma(<T>EspecificarFechaEntrega<T>))<BR>Fin<BR>Si<BR>  Temp.Logico<BR>Entonces<BR>  Asigna(Temp.Reg, SQL(<T>spProdProgramaRutaCalcFechas :nID, :fInicio, :fEntrega, :tCalc, 1<T>, ProdProgramaRuta:ProdProgramaRuta.ID, Vacio(Info.FechaInicio, Hoy), Vacio(Info.FechaEntrega, Hoy), Info.CalcularFechaPrograma))<BR>  Asigna(Info.FechaInicio, Temp.Reg[1])<BR>  Asigna(Info.FechaEntrega, Temp.Reg[2])<BR>Fin

[Ruta.ProdProgramaRuta.FechaProcesoInicio]
Carpeta=Ruta
Clave=ProdProgramaRuta.FechaProcesoInicio
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Ruta.ProdProgramaRuta.FechaProcesoTermino]
Carpeta=Ruta
Clave=ProdProgramaRuta.FechaProcesoTermino
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
TipoAccion=Ventana
Visible=S
Multiple=S
ClaveAccion=Aceptar
ListaAccionesMultiples=Cancelar<BR>Expresion<BR>Aceptar
ActivoCondicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)

[Acciones.Eliminar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Eliminar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spProdProgramaEliminar :tID<T>, Info.ID)

[Acciones.Eliminar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Materiales.ProdProgramaMaterial.AlmacenDestino]
Carpeta=Materiales
Clave=ProdProgramaMaterial.AlmacenDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=0
NombreDesplegar=&Información Artículo
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Articulo, ProdProgramaMaterial:ProdProgramaMaterial.Articulo)

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

[Materiales.ProdProgramaMaterial.CantidadP]
Carpeta=Materiales
Clave=ProdProgramaMaterial.CantidadP
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Rojo obscuro
Tamano=20

[Materiales.ProdProgramaMaterial.UnidadP]
Carpeta=Materiales
Clave=ProdProgramaMaterial.UnidadP
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Rojo obscuro

[Ruta.ProdProgramaRuta.Unidad]
Carpeta=Ruta
Clave=ProdProgramaRuta.Unidad
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Rojo obscuro

[Acciones.PlanCentro]
Nombre=PlanCentro
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=Plan Centro Trabajo
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=PlanCentro
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Centro, ProdProgramaRuta:ProdProgramaRuta.Centro)<BR>Asigna(Info.Descripcion, <T>Plan - Centro Trabajo<T>)

[Ruta.ProdProgramaRuta.Orden]
Carpeta=Ruta
Clave=ProdProgramaRuta.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Negro
ColorFondo=Blanco

[Acciones.QuitarRuta]
Nombre=QuitarRuta
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+Q
NombreDesplegar=&Quitar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S
ConCondicion=S
GuardarAntes=S
ActivoCondicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
EjecucionCondicion=ConDatos(ProdProgramaRuta:ProdProgramaRuta.ID)
Antes=S
AntesExpresiones=EjecutarSQL(<T>spProdProgramaRutaQuitar :nID, :nRen, :nOrden<T>, ProdProgramaRuta:ProdProgramaRuta.ID, ProdProgramaRuta:ProdProgramaRuta.Renglon, ProdProgramaRuta:ProdProgramaRuta.OrdenID)
DespuesGuardar=S

[Acciones.QuitarMaterial]
Nombre=QuitarMaterial
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+Q
NombreDesplegar=&Quitar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S
ConCondicion=S
GuardarAntes=S
ActivoCondicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
EjecucionCondicion=ConDatos(ProdProgramaMaterial:ProdProgramaMaterial.ID)
Antes=S
AntesExpresiones=EjecutarSQL(<T>spProdProgramaMaterialQuitar :nID, :nRenglon<T>, ProdProgramaMaterial:ProdProgramaMaterial.ID, ProdProgramaMaterial:ProdProgramaMaterial.Renglon)
DespuesGuardar=S

[Acciones.Susutitos]
Nombre=Susutitos
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+S
NombreDesplegar=Asignar &Susutitos...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Visible=S
ConCondicion=S
GuardarAntes=S
EspacioPrevio=S
ActivoCondicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)
EjecucionCondicion=Asigna(Info.ID, ProdProgramaMaterial:ProdProgramaMaterial.ID)<BR>Asigna(Info.Articulo, ProdProgramaMaterial:ProdProgramaMaterial.Articulo)<BR>Asigna(Info.SubCuenta, ProdProgramaMaterial:ProdProgramaMaterial.SubCuenta)<BR>Asigna(Info.Descripcion, ProdProgramaMaterial:Material.Descripcion1)<BR>Asigna(Info.Almacen, ProdProgramaMaterial:ProdProgramaMaterial.AlmacenOrigen)<BR>Asigna(Info.Cantidad, ProdProgramaMaterial:ProdProgramaMaterial.Cantidad)<BR>Asigna(Info.Renglon, ProdProgramaMaterial:ProdProgramaMaterial.Renglon)<BR>ConDatos(ProdProgramaMaterial:ProdProgramaMaterial.ID) y Forma(<T>ProgramaAsignarSusutitos<T>)

[Acciones.Grafica]
Nombre=Grafica
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Gráfica Centro Trabajo
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=VerCRP(ProdProgramaRuta:ProdProgramaRuta.Centro+<T> - <T>+ProdProgramaRuta:Centro.Descripcion, ProdProgramaRuta:ProdProgramaRuta.Centro)

[Forma.ListaCarpetas]
(Inicio)=Materiales
Materiales=Ruta
Ruta=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Guardar
Guardar=Eliminar
Eliminar=Calcular
Calcular=CambiarVista
CambiarVista=(Fin)

[Materiales.ListaEnCaptura]
(Inicio)=ProdProgramaMaterial.Lote
ProdProgramaMaterial.Lote=ProdProgramaMaterial.Producto
ProdProgramaMaterial.Producto=ProdProgramaMaterial.SubProducto
ProdProgramaMaterial.SubProducto=ProdProgramaMaterial.CantidadP
ProdProgramaMaterial.CantidadP=ProdProgramaMaterial.UnidadP
ProdProgramaMaterial.UnidadP=ProdProgramaMaterial.Articulo
ProdProgramaMaterial.Articulo=ProdProgramaMaterial.SubCuenta
ProdProgramaMaterial.SubCuenta=ProdProgramaMaterial.AlmacenOrigen
ProdProgramaMaterial.AlmacenOrigen=ProdProgramaMaterial.AlmacenDestino
ProdProgramaMaterial.AlmacenDestino=ProdProgramaMaterial.Cantidad
ProdProgramaMaterial.Cantidad=ProdProgramaMaterial.Unidad
ProdProgramaMaterial.Unidad=ProdProgramaMaterial.Merma
ProdProgramaMaterial.Merma=ProdProgramaMaterial.Desperdicio
ProdProgramaMaterial.Desperdicio=Disponible
Disponible=ProdProgramaMaterial.FechaRequerida
ProdProgramaMaterial.FechaRequerida=(Fin)

[Materiales.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=SubProductoDesc
SubProductoDesc=Material.Descripcion1
Material.Descripcion1=SubCuentaDesc
SubCuentaDesc=(Fin)

[Materiales.ListaAcciones]
(Inicio)=DividirMaterial
DividirMaterial=UnirMaterial
UnirMaterial=QuitarMaterial
QuitarMaterial=Susutitos
Susutitos=ArtInfo
ArtInfo=(Fin)

[Ruta.ListaEnCaptura]
(Inicio)=ProdProgramaRuta.Lote
ProdProgramaRuta.Lote=ProdProgramaRuta.Producto
ProdProgramaRuta.Producto=ProdProgramaRuta.SubProducto
ProdProgramaRuta.SubProducto=ProdProgramaRuta.Cantidad
ProdProgramaRuta.Cantidad=ProdProgramaRuta.Unidad
ProdProgramaRuta.Unidad=ProdProgramaRuta.Orden
ProdProgramaRuta.Orden=ProdProgramaRuta.Centro
ProdProgramaRuta.Centro=ProdProgramaRuta.Operacion
ProdProgramaRuta.Operacion=ProdProgramaRuta.Estacion
ProdProgramaRuta.Estacion=ProdProgramaRuta.FechaProcesoInicio
ProdProgramaRuta.FechaProcesoInicio=ProdProgramaRuta.FechaProcesoTermino
ProdProgramaRuta.FechaProcesoTermino=(Fin)

[Ruta.ListaCamposAValidar]
(Inicio)=ProdProgramaRuta.Ruta
ProdProgramaRuta.Ruta=Centro.Descripcion
Centro.Descripcion=EstacionT.Descripcion
EstacionT.Descripcion=ProdProgramaRuta.Unidad
ProdProgramaRuta.Unidad=ProdProgramaRuta.TiempoCola
ProdProgramaRuta.TiempoCola=ProdProgramaRuta.TiempoFijo
ProdProgramaRuta.TiempoFijo=ProdProgramaRuta.TiempoVariable
ProdProgramaRuta.TiempoVariable=ProdProgramaRuta.TiempoEspera
ProdProgramaRuta.TiempoEspera=ProdProgramaRuta.TiempoMovimiento
ProdProgramaRuta.TiempoMovimiento=ProdProgramaRuta.DiasCarga
ProdProgramaRuta.DiasCarga=ProdProgramaRuta.DiasEntrega
ProdProgramaRuta.DiasEntrega=(Fin)

[Ruta.ListaOrden]
(Inicio)=ProdProgramaRuta.Lote<TAB>(Acendente)
ProdProgramaRuta.Lote<TAB>(Acendente)=ProdProgramaRuta.Producto<TAB>(Acendente)
ProdProgramaRuta.Producto<TAB>(Acendente)=ProdProgramaRuta.SubProducto<TAB>(Acendente)
ProdProgramaRuta.SubProducto<TAB>(Acendente)=ProdProgramaRuta.Orden<TAB>(Acendente)
ProdProgramaRuta.Orden<TAB>(Acendente)=ProdProgramaRuta.Cantidad<TAB>(Acendente)
ProdProgramaRuta.Cantidad<TAB>(Acendente)=(Fin)

[Ruta.ListaAcciones]
(Inicio)=DividirRuta
DividirRuta=UnirRuta
UnirRuta=QuitarRuta
QuitarRuta=PlanCentro
PlanCentro=Grafica
Grafica=(Fin)
