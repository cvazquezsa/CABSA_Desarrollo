[Forma]
Clave=PropTipo
Nombre=Tipos de Propiedades
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=324
PosicionInicialArriba=215
PosicionInicialAltura=330
PosicionInicialAncho=375
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=303

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PropTipo
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=
HojaTitulos=S
HojaMostrarColumnas=S
OtroOrden=S
ListaOrden=(Lista)

[Lista.PropTipo.Tipo]
Carpeta=Lista
Clave=PropTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

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
Tipo=183
Categoria=162

[Lista.PropTipo.Categoria]
Carpeta=Lista
Clave=PropTipo.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

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

[Acciones.PropCat]
Nombre=PropCat
Boton=91
NombreEnBoton=S
NombreDesplegar=&Categorías
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PropCat
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=PropCat
PropCat=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PropTipo.Tipo
PropTipo.Tipo=PropTipo.Categoria
PropTipo.Categoria=(Fin)

[Lista.ListaOrden]
(Inicio)=PropTipo.Categoria<TAB>(Acendente)
PropTipo.Categoria<TAB>(Acendente)=PropTipo.Tipo<TAB>(Acendente)
PropTipo.Tipo<TAB>(Acendente)=(Fin)
