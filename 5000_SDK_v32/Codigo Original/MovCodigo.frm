[Forma]
Clave=MovCodigo
Nombre=Códigos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=328
PosicionInicialArriba=152
PosicionInicialAlturaCliente=429
PosicionInicialAncho=236
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovCodigo
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
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=MovCodigo.Modulo=<T>{Info.Modulo}<T> AND MovCodigo.ModuloID={Info.ID}

[Lista.MovCodigo.Cantidad]
Carpeta=Lista
Clave=MovCodigo.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=125
Cantidad=71
Codigo=135
SubCuenta=139
Unidad=72
SerieLote=131

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
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=GuardarCambios<BR>Asigna(Temp.Texto, SQL(<T>spMovCodigo :tModulo, :nID, 1<T>, Info.Modulo, Info.ID))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Temp.Texto

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar

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

[Lista.MovCodigo.Codigo]
Carpeta=Lista
Clave=MovCodigo.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Verificar]
Nombre=Verificar
Boton=41
NombreEnBoton=S
NombreDesplegar=&Verificar
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=S
Visible=S
EspacioPrevio=S
ClaveAccion=Actualizar Vista
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=Expresion<BR>Actualizar Vista

[Acciones.Verificar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Temp.Texto, SQL(<T>spMovCodigo :tModulo, :nID<T>, Info.Modulo, Info.ID))<BR>Si(Vacio(Temp.Texto),  Informacion(<T>Códigos Correctos<T>), Error(Temp.Texto))
Activo=S
Visible=S

[Acciones.Verificar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Verificar
Verificar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MovCodigo.Codigo
MovCodigo.Codigo=MovCodigo.Cantidad
MovCodigo.Cantidad=(Fin)
