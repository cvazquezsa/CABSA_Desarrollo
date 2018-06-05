[Forma]
Clave=VentaCopiarLote
Nombre=Copiar en Sucursales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=235
PosicionInicialArriba=221
PosicionInicialAltura=318
PosicionInicialAncho=554
Comentarios=Lista(Info.Cliente, Info.Mov+<T> <T>+Info.MovID)
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=291

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteEnviarA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Sucursal<T>
ElementosPorPagina=200
IconosSeleccionMultiple=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Sucursales
MenuLocal=S
ListaAcciones=(Lista)
Filtros=S
IconosNombre=CteEnviarA:CteEnviarA.ID
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroGeneral=CteEnviarA.Cliente=<T>{Info.Cliente}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.CteEnviarA.Nombre]
Carpeta=Lista
Clave=CteEnviarA.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteEnviarA.Direccion]
Carpeta=Lista
Clave=CteEnviarA.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=65
NombreEnBoton=S
NombreDesplegar=&Generar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConfirmarAntes=S
DialogoMensaje=ConfirmarCopiaMultiple
Multiple=S
ListaAccionesMultiples=Expresion<BR>Aceptar

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreEnBoton=S
NombreDesplegar=Generar y &Afectar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
ConfirmarAntes=S
DialogoMensaje=ConfirmarCopiaMultiple
Multiple=S
ListaAccionesMultiples=Expresion<BR>Aceptar
ActivoCondicion=Usuario.Afectar y Usuario.AfectarLote

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Lista.Columnas]
0=57
1=235

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=RegistrarSeleccion(<T>Lista<T>) <BR>ProcesarSQL(<T>spMovCopiarSucusal :nSucursal, :nEstacion, :nID, :tUsuario, :fFecha, 0<T>,  Sucursal, EstacionTrabajo,  Info.ID, Usuario, Hoy)

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Afectar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=RegistrarSeleccion(<T>Lista<T>) <BR>ProcesarSQL(<T>spMovCopiarSucusal :nSucursal, :nEstacion, :nID, :tUsuario, :fFecha, 1<T>,  Sucursal, EstacionTrabajo,  Info.ID, Usuario, Hoy)

[Acciones.Afectar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Afectar
Afectar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Direccion
CteEnviarA.Direccion=(Fin)

[Lista.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=(Fin)
