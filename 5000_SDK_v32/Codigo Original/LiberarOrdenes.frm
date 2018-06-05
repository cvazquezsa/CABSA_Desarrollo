[Forma]
Clave=LiberarOrdenes
Nombre=Liberar Ordenes
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=374
PosicionInicialArriba=287
PosicionInicialAlturaCliente=159
PosicionInicialAncho=276
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LiberarOrdenes
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
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

FiltroGeneral=UsuarioCfg2.Usuario=<T>{Usuario}<T>
[Acciones.Aceptar]
Nombre=Aceptar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar Ordenes
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Antes=S
DespuesGuardar=S
Visible=S

AntesExpresiones=ProcesarSQL(<T>spPlanArtOPLiberar :nSucursal, :tEmpresa, :tUsuario, :tReferencia, :tReferenciaModulo, :tReferenciaActividad<T>, Sucursal, Empresa, Usuario, Info.PlanReferencia, Info.PlanReferenciaModulo, Info.PlanReferenciaActividad)
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

[Ficha.UsuarioCfg2.PlanOrdenCompra]
Carpeta=Ficha
Clave=UsuarioCfg2.PlanOrdenCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.UsuarioCfg2.PlanOrdenProduccion]
Carpeta=Ficha
Clave=UsuarioCfg2.PlanOrdenProduccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.UsuarioCfg2.PlanOrdenTransferencia]
Carpeta=Ficha
Clave=UsuarioCfg2.PlanOrdenTransferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.UsuarioCfg2.PlanOrdenTraspaso]
Carpeta=Ficha
Clave=UsuarioCfg2.PlanOrdenTraspaso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[Ficha.ListaEnCaptura]
(Inicio)=UsuarioCfg2.PlanOrdenCompra
UsuarioCfg2.PlanOrdenCompra=UsuarioCfg2.PlanOrdenProduccion
UsuarioCfg2.PlanOrdenProduccion=UsuarioCfg2.PlanOrdenTransferencia
UsuarioCfg2.PlanOrdenTransferencia=UsuarioCfg2.PlanOrdenTraspaso
UsuarioCfg2.PlanOrdenTraspaso=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
