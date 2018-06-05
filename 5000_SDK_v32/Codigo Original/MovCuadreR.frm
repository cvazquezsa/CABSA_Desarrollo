[Forma]
Clave=MovCuadreR
Nombre=Cuadre Contable (Desde los Movimientos)
Icono=23
Modulos=(Todos)
PosicionInicialAlturaCliente=493
PosicionInicialAncho=874
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=203
PosicionInicialArriba=252
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(FechaEnTexto(Info.FechaD, <T>dd/mmm/aaaa<T>), FechaEnTexto(Info.FechaA, <T>dd/mmm/aaaa<T>))

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovCuadreR
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=MovCuadreR.Modulo
FiltroValida1=Modulo.Nombre
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
MenuLocal=S
ListaAcciones=LocalDetalle
FiltroGrupo2=MovCuadreR.Cuenta
FiltroValida2=MovCuadreR.Cuenta
FiltroGrupo3=MovCuadreR.SubCuenta
FiltroValida3=MovCuadreR.SubCuenta
BusquedaRapidaControles=S
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=CONCLUIDO
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
IconosNombre=MovCuadreR:MovCuadreR.Mov
FiltroGeneral=MovCuadreR.Estacion={EstacionTrabajo}

[Lista.MovCuadreR.Cuenta]
Carpeta=Lista
Clave=MovCuadreR.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovCuadreR.SubCuenta]
Carpeta=Lista
Clave=MovCuadreR.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovCuadreR.Conteo]
Carpeta=Lista
Clave=MovCuadreR.Conteo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovCuadreR.ImporteMN]
Carpeta=Lista
Clave=MovCuadreR.ImporteMN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovCuadreR.Debe]
Carpeta=Lista
Clave=MovCuadreR.Debe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovCuadreR.Haber]
Carpeta=Lista
Clave=MovCuadreR.Haber
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=112
1=48

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Ejecutar]
Nombre=Ejecutar
Boton=92
NombreDesplegar=Ejecutar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S
Expresion=Si<BR>  Forma(<T>EspecificarFechas<T>)<BR>Entonces<BR>  ProcesarSQL(<T>spMovCuadre :nEstacion, :tEmpresa, :fFechaD, :fFechaA<T>, EstacionTrabajo, Empresa, Info.FechaD, Info.FechaA) <BR>  Forma.ActualizarArbol(<T>Lista<T>) <BR>  Forma.ActualizarVista <BR>Fin

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovCuadre
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(MovCuadreR:MovCuadreR.Mov)
AntesExpresiones=Asigna(Info.Modulo, MovCuadreR:MovCuadreR.Modulo)<BR>Asigna(Info.Mov, MovCuadreR:MovCuadreR.Mov)<BR>ASigna(Info.Estatus, MovCuadreR:MovCuadreR.Estatus)

[Acciones.LocalDetalle]
Nombre=LocalDetalle
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=&Detalle
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovCuadre
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(MovCuadreR:MovCuadreR.Mov)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, MovCuadreR:MovCuadreR.Modulo)<BR>Asigna(Info.Mov, MovCuadreR:MovCuadreR.Mov)<BR>ASigna(Info.Estatus, MovCuadreR:MovCuadreR.Estatus)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Ejecutar
Ejecutar=Detalle
Detalle=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MovCuadreR.Conteo
MovCuadreR.Conteo=MovCuadreR.ImporteMN
MovCuadreR.ImporteMN=MovCuadreR.Cuenta
MovCuadreR.Cuenta=MovCuadreR.SubCuenta
MovCuadreR.SubCuenta=MovCuadreR.Debe
MovCuadreR.Debe=MovCuadreR.Haber
MovCuadreR.Haber=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=BORRADOR
BORRADOR=CONFIRMAR
CONFIRMAR=PROCESAR
PROCESAR=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)
