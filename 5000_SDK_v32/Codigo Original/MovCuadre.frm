[Forma]
Clave=MovCuadre
Nombre=Cuadre Contable (Desde los Movimientos)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=210
PosicionInicialArriba=185
PosicionInicialAlturaCliente=626
PosicionInicialAncho=860
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Mov, EstatusNombre(Info.Estatus))

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovCuadre
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
PestanaOtroNombre=S
PestanaNombre=Movimientos
FiltroGrupo1=MovCuadre.Cuenta
FiltroValida1=MovCuadre.Cuenta
FiltroGrupo2=MovCuadre.SubCuenta
FiltroValida2=MovCuadre.SubCuenta
FiltroTodo=S
MenuLocal=S
ListaAcciones=LocalPropiedades
IconosNombre=MovCuadre:MovCuadre.Mov+<T> <T>+MovCuadre:MovCuadre.MovID
FiltroGeneral=MovCuadre.Estacion={EstacionTrabajo} AND<BR>MovCuadre.Modulo=<T>{Info.Modulo}<T> AND<BR>MovCuadre.Mov=<T>{Info.Mov}<T> AND<BR>MovCuadre.Estatus=<T>{Info.Estatus}<T>

[Lista.MovCuadre.ImporteMN]
Carpeta=Lista
Clave=MovCuadre.ImporteMN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.MovCuadre.Cuenta]
Carpeta=Lista
Clave=MovCuadre.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovCuadre.SubCuenta]
Carpeta=Lista
Clave=MovCuadre.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovCuadre.Debe]
Carpeta=Lista
Clave=MovCuadre.Debe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.MovCuadre.Haber]
Carpeta=Lista
Clave=MovCuadre.Haber
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

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

[Lista.Columnas]
0=152
1=88

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

[Acciones.LocalPropiedades]
Nombre=LocalPropiedades
Boton=0
UsaTeclaRapida=S
TeclaRapida=F11
NombreDesplegar=Propiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(MovCuadre:MovCuadre.ModuloID)
AntesExpresiones=Asigna(Info.Modulo, MovCuadre:MovCuadre.Modulo)<BR>Asigna(Info.ID, MovCuadre:MovCuadre.ModuloID)

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Visible=S
NombreEnBoton=S
ConCondicion=S
EjecucionCondicion=ConDatos(MovCuadre:MovCuadre.ModuloID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, MovCuadre:MovCuadre.Modulo)<BR>Asigna(Info.ID, MovCuadre:MovCuadre.ModuloID)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Propiedades
Propiedades=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MovCuadre.ImporteMN
MovCuadre.ImporteMN=MovCuadre.Cuenta
MovCuadre.Cuenta=MovCuadre.SubCuenta
MovCuadre.SubCuenta=MovCuadre.Debe
MovCuadre.Debe=MovCuadre.Haber
MovCuadre.Haber=(Fin)
