[Forma]
Clave=TablaRangoD
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
PosicionInicialArriba=291
PosicionInicialAltura=291
PosicionInicialAncho=315
PosicionInicialAlturaCliente=408

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaRangoD
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
FiltroGeneral=TablaRangoD.TablaRango=<T>{Info.Tabla}<T>

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

[Lista.TablaRangoD.Valor]
Carpeta=Lista
Clave=TablaRangoD.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.TablaRangoD.NumeroD]
Carpeta=Lista
Clave=TablaRangoD.NumeroD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaRangoD.NumeroA]
Carpeta=Lista
Clave=TablaRangoD.NumeroA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TablaRangoD.NumeroD
TablaRangoD.NumeroD=TablaRangoD.NumeroA
TablaRangoD.NumeroA=TablaRangoD.Valor
TablaRangoD.Valor=(Fin)

[Lista.ListaOrden]
(Inicio)=TablaRangoD.NumeroD<TAB>(Acendente)
TablaRangoD.NumeroD<TAB>(Acendente)=TablaRangoD.NumeroA<TAB>(Acendente)
TablaRangoD.NumeroA<TAB>(Acendente)=(Fin)
