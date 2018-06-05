[Forma]
Clave=PuestoRelacion
Nombre=Relaciones de Trabajo del Puesto
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
Comentarios=Info.Puesto
ListaAcciones=Aceptar
PosicionInicialIzquierda=248
PosicionInicialArriba=285
PosicionInicialAlturaCliente=419
PosicionInicialAncho=784

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PuestoRelacion
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
FiltroGeneral=PuestoRelacion.Puesto = <T>{Info.Puesto}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.PuestoRelacion.PuestoRelacion]
Carpeta=Lista
Clave=PuestoRelacion.PuestoRelacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PuestoRelacion.Tipo]
Carpeta=Lista
Clave=PuestoRelacion.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PuestoRelacion.Motivo]
Carpeta=Lista
Clave=PuestoRelacion.Motivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
PuestoRelacion=237
Tipo=63
Motivo=451

[Lista.ListaEnCaptura]
(Inicio)=PuestoRelacion.PuestoRelacion
PuestoRelacion.PuestoRelacion=PuestoRelacion.Tipo
PuestoRelacion.Tipo=PuestoRelacion.Motivo
PuestoRelacion.Motivo=(Fin)
