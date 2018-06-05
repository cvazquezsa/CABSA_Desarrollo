[Forma]
Clave=CfgPoliticaPreciosMov
Nombre=Políticas Precios a Nivel Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=277
PosicionInicialArriba=251
PosicionInicialAlturaCliente=487
PosicionInicialAncho=725
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgPoliticaPreciosMov
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
ValidarCampos=S
ListaCamposAValidar=(Lista)
Filtros=S
FiltroAplicaEn=CfgPoliticaPreciosMov.Estatus
FiltroPredefinido=S
FiltroGrupo1=CfgPoliticaPreciosMov.Estatus
FiltroValida1=CfgPoliticaPreciosMov.Estatus
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
FiltroAutoCampo=CfgPoliticaPreciosMov.Estatus
FiltroEstilo=Folder (1 línea)
FiltroTodo=S
FiltroTodoFinal=S

[Lista.CfgPoliticaPreciosMov.Agrupador]
Carpeta=Lista
Clave=CfgPoliticaPreciosMov.Agrupador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CfgPoliticaPreciosMov.Nombre]
Carpeta=Lista
Clave=CfgPoliticaPreciosMov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CfgPoliticaPreciosMov.Empresa]
Carpeta=Lista
Clave=CfgPoliticaPreciosMov.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CfgPoliticaPreciosMov.Sucursal]
Carpeta=Lista
Clave=CfgPoliticaPreciosMov.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CfgPoliticaPreciosMov.Cantidad]
Carpeta=Lista
Clave=CfgPoliticaPreciosMov.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CfgPoliticaPreciosMov.Porcentaje]
Carpeta=Lista
Clave=CfgPoliticaPreciosMov.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CfgPoliticaPreciosMov.Estatus]
Carpeta=Lista
Clave=CfgPoliticaPreciosMov.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Agrupador=153
Nombre=216
Empresa=72
Sucursal=53
Cantidad=51
Porcentaje=53
Estatus=84

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

[Lista.ListaEnCaptura]
(Inicio)=CfgPoliticaPreciosMov.Agrupador
CfgPoliticaPreciosMov.Agrupador=CfgPoliticaPreciosMov.Nombre
CfgPoliticaPreciosMov.Nombre=CfgPoliticaPreciosMov.Cantidad
CfgPoliticaPreciosMov.Cantidad=CfgPoliticaPreciosMov.Porcentaje
CfgPoliticaPreciosMov.Porcentaje=CfgPoliticaPreciosMov.Empresa
CfgPoliticaPreciosMov.Empresa=CfgPoliticaPreciosMov.Sucursal
CfgPoliticaPreciosMov.Sucursal=CfgPoliticaPreciosMov.Estatus
CfgPoliticaPreciosMov.Estatus=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Empresa.Nombre
Empresa.Nombre=Sucursal.Nombre
Sucursal.Nombre=(Fin)
