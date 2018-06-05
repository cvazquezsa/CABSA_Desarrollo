[Forma]
Clave=TablaRangoStD
Nombre=Info.Tabla
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=482
PosicionInicialArriba=294
PosicionInicialAltura=291
PosicionInicialAncho=464
PosicionInicialAlturaCliente=408

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaRangoStD
Fuente={MS Sans Serif, 8, Negro, []}
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
Filtros=S
OtroOrden=S
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroGeneral=TablaRangoStD.TablaRangoSt=<T>{Info.Tabla}<T>

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
Periodo=43
PeriodoNombre=87
Importe=117
Numero=69
Valor=70
NumeroD=64
NumeroA=64
Nombre=304

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Lista.TablaRangoStD.NumeroD]
Carpeta=Lista
Clave=TablaRangoStD.NumeroD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaRangoStD.NumeroA]
Carpeta=Lista
Clave=TablaRangoStD.NumeroA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaRangoStD.Nombre]
Carpeta=Lista
Clave=TablaRangoStD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TablaRangoStD.NumeroD
TablaRangoStD.NumeroD=TablaRangoStD.NumeroA
TablaRangoStD.NumeroA=TablaRangoStD.Nombre
TablaRangoStD.Nombre=(Fin)

[Lista.ListaOrden]
(Inicio)=TablaRangoStD.NumeroD<TAB>(Acendente)
TablaRangoStD.NumeroD<TAB>(Acendente)=TablaRangoStD.NumeroA<TAB>(Acendente)
TablaRangoStD.NumeroA<TAB>(Acendente)=(Fin)
