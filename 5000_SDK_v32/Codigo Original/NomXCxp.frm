[Forma]
Clave=NomXCxp
Nombre=Cuentas por Pagar
Icono=34
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=272
PosicionInicialArriba=265
PosicionInicialAltura=487
PosicionInicialAncho=735
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=29
Comentarios=Info.Nombre
PosicionInicialAlturaCliente=460

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NomXCxp
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=NomXCxp.Concepto
CarpetaVisible=S
HojaMantenerSeleccion=S
Filtros=S
OtroOrden=S
ListaOrden=NomXCxp.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=NomXCxp.ID={Info.ID}

[Lista.NomXCxp.Concepto]
Carpeta=Lista
Clave=NomXCxp.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Concepto=179

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NomXCxp
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.NomXCxp.Concepto]
Carpeta=Ficha
Clave=NomXCxp.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.NomXCxp.Condicion]
Carpeta=Ficha
Clave=NomXCxp.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.NomXCxp.Comentarios]
Carpeta=Ficha
Clave=NomXCxp.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S
EnBarraHerramientas=S

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

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
NombreDesplegar=&Guardar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
EspacioPrevio=S
NombreEnBoton=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(NomXCxp:NomXCxp.Concepto)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Ficha.NomXCxp.Acreedor]
Carpeta=Ficha
Clave=NomXCxp.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NomXCxp.Importe]
Carpeta=Ficha
Clave=NomXCxp.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NomXCxp.Vencimiento]
Carpeta=Ficha
Clave=NomXCxp.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.NomXCxp.Impuestos]
Carpeta=Ficha
Clave=NomXCxp.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60x3
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=NomXCxp.Concepto
NomXCxp.Concepto=NomXCxp.Acreedor
NomXCxp.Acreedor=NomXCxp.Importe
NomXCxp.Importe=NomXCxp.Impuestos
NomXCxp.Impuestos=NomXCxp.Vencimiento
NomXCxp.Vencimiento=NomXCxp.Condicion
NomXCxp.Condicion=NomXCxp.Comentarios
NomXCxp.Comentarios=(Fin)
