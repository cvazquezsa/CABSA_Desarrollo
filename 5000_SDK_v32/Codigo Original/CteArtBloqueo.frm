[Forma]
Clave=CteArtBloqueo
Nombre=Bloquear Clientes por Agrupadores de Artículos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=211
PosicionInicialArriba=193
PosicionInicialAltura=382
PosicionInicialAncho=602
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteArtBloqueo
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
OtroOrden=S
ListaOrden=(Lista)

[Lista.CteArtBloqueo.Cliente]
Carpeta=Lista
Clave=CteArtBloqueo.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.CteArtBloqueo.Agrupador]
Carpeta=Lista
Clave=CteArtBloqueo.Agrupador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteArtBloqueo.Nombre]
Carpeta=Lista
Clave=CteArtBloqueo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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
Cliente=82
Nombre_1=242
Agrupador=78
Nombre=169

[Lista.ListaEnCaptura]
(Inicio)=CteArtBloqueo.Cliente
CteArtBloqueo.Cliente=Cte.Nombre
Cte.Nombre=CteArtBloqueo.Agrupador
CteArtBloqueo.Agrupador=CteArtBloqueo.Nombre
CteArtBloqueo.Nombre=(Fin)

[Lista.ListaOrden]
(Inicio)=CteArtBloqueo.Cliente<TAB>(Acendente)
CteArtBloqueo.Cliente<TAB>(Acendente)=CteArtBloqueo.Agrupador<TAB>(Acendente)
CteArtBloqueo.Agrupador<TAB>(Acendente)=CteArtBloqueo.Nombre<TAB>(Acendente)
CteArtBloqueo.Nombre<TAB>(Acendente)=(Fin)
