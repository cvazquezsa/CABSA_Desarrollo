[Forma]
Clave=OpcionD
Nombre=Detalles de la Opción
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Opcion, Info.Descripcion)
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=49
PosicionInicialArriba=52
PosicionInicialAltura=446
PosicionInicialAncho=759
VentanaExclusiva=S
PosicionInicialAlturaCliente=420

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OpcionD
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Predefinido
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
FiltroPredefinido1=por Número<BR>por Nombre
FiltroPredefinido2=OpcionD.Opcion IS NOT NULL<BR>OpcionD.Opcion IS NOT NULL
FiltroPredefinido3=OpcionD.Numero<BR>OpcionD.Nombre
FiltroEstilo=Directorio

FiltroGeneral=OpcionD.Opcion=<T>{Info.Opcion}<T>
[Lista.OpcionD.Numero]
Carpeta=Lista
Clave=OpcionD.Numero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Efectos=[Negritas]
EditarConBloqueo=N

[Lista.OpcionD.Nombre]
Carpeta=Lista
Clave=OpcionD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

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

[Lista.Columnas]
Numero=58
Nombre=213

InformacionAdicional=196
Imagen=182
Descontinuado=75
[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Acciones.Anexos]
Nombre=Anexos
Boton=77
NombreDesplegar=&Anexos
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=ConDatos(OpcionD:OpcionD.Numero)
AntesExpresiones=Asigna(Info.Rama, <T>OPC<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, Info.Opcion+OpcionD:OpcionD.Numero)<BR>Asigna(Info.Descripcion, OpcionD:OpcionD.Nombre)
RefrescarDespues=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ActivoCondicion=no OpcionD:OpcionD.TieneMovimientos



[Lista.OpcionD.InformacionAdicional]
Carpeta=Lista
Clave=OpcionD.InformacionAdicional
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.OpcionD.Imagen]
Carpeta=Lista
Clave=OpcionD.Imagen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco










[Lista.ListaEnCaptura]
(Inicio)=OpcionD.Numero
OpcionD.Numero=OpcionD.Nombre
OpcionD.Nombre=OpcionD.InformacionAdicional
OpcionD.InformacionAdicional=OpcionD.Imagen
OpcionD.Imagen=OpcionD.Descontinuado
OpcionD.Descontinuado=(Fin)

[Lista.OpcionD.Descontinuado]
Carpeta=Lista
Clave=OpcionD.Descontinuado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Anexos
Anexos=Excel
Excel=(Fin)
