[Forma]
Clave=CteTel
Nombre=Teléfonos del Cliente
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=654
PosicionInicialArriba=397
PosicionInicialAlturaCliente=372
PosicionInicialAncho=611
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Cliente
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteTel
Fuente={Tahoma, 8, Negro, []}
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
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaTitulos=S
HojaAjustarColumnas=S
HojaMostrarColumnas=S
FiltroGeneral=CteTel.Cliente=<T>{Info.Cliente}<T>

[Lista.CteTel.Telefono]
Carpeta=Lista
Clave=CteTel.Telefono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Telefono=227
Cliente=64
Tipo=124
Extencion=53
Lada=41
PedirTono=57
DePreferencia=74

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
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(CteTel:CteTel.Telefono)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Acciones.Asistente]
Nombre=Asistente
Boton=12
NombreDesplegar=Asistente
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Wizards
ClaveAccion=Asistente Series/Lotes
ListaParametros1=CteTel:CteTel.Telefono
ListaParametros=S
Activo=S
Visible=S

[Lista.CteTel.Tipo]
Carpeta=Lista
Clave=CteTel.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteTel.Extencion]
Carpeta=Lista
Clave=CteTel.Extencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteTel.Lada]
Carpeta=Lista
Clave=CteTel.Lada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteTel.PedirTono]
Carpeta=Lista
Clave=CteTel.PedirTono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteTel.DePreferencia]
Carpeta=Lista
Clave=CteTel.DePreferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Asistente
Asistente=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CteTel.Tipo
CteTel.Tipo=CteTel.Telefono
CteTel.Telefono=CteTel.Extencion
CteTel.Extencion=CteTel.Lada
CteTel.Lada=CteTel.DePreferencia
CteTel.DePreferencia=CteTel.PedirTono
CteTel.PedirTono=(Fin)
