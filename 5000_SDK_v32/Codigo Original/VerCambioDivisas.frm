[Forma]
Clave=VerCambioDivisas
Nombre=Divisas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=328
PosicionInicialArriba=152
PosicionInicialAlturaCliente=429
PosicionInicialAncho=367
VentanaTipoMarco=Sencillo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Instrumento
Fuente={Tahoma, 8, Negro, []}
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
FiltroTodoNombre=(Todas)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
CarpetaVisible=S
FiltroGrupo1=Instrumento.Moneda
FiltroTodo=S
FiltroAutoCampo=Instrumento.Moneda
FiltroEstilo=Folder (1 línea)
HojaMostrarRenglones=S
OtroOrden=S
ListaOrden=Mon.Orden<TAB>(Acendente)
FiltroGeneral=Instrumento.Mostrar=1

[Lista.Instrumento.Descripcion]
Carpeta=Lista
Clave=Instrumento.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Descripcion=189
TipoCambio=69
TipoCambioCompra=69
TipoCambioVenta=72

[Lista.TipoCambioCompra]
Carpeta=Lista
Clave=TipoCambioCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Rojo obscuro
Efectos=[Negritas]

[Lista.TipoCambioVenta]
Carpeta=Lista
Clave=TipoCambioVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Azul
Efectos=[Negritas]

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
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Instrumento.Descripcion
Instrumento.Descripcion=TipoCambioCompra
TipoCambioCompra=TipoCambioVenta
TipoCambioVenta=(Fin)
