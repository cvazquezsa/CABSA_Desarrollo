[Forma]
Clave=PlanEstructura
Nombre=Estructuras Planeación
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=252
PosicionInicialArriba=159
PosicionInicialAltura=509
PosicionInicialAncho=520
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
Vista=PlanEstructura
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

[Lista.PlanEstructura.TipoPlan]
Carpeta=Lista
Clave=PlanEstructura.TipoPlan
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Acronimo.Termino]
Carpeta=Lista
Clave=Acronimo.Termino
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.PlanEstructura.Acronimo]
Carpeta=Lista
Clave=PlanEstructura.Acronimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlanEstructura.Orden]
Carpeta=Lista
Clave=PlanEstructura.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlanEstructura.Visible]
Carpeta=Lista
Clave=PlanEstructura.Visible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
TipoPlan=76
Termino=265
Acronimo=74
Orden=38
Visible=35

[Lista.ListaEnCaptura]
(Inicio)=PlanEstructura.TipoPlan
PlanEstructura.TipoPlan=PlanEstructura.Acronimo
PlanEstructura.Acronimo=Acronimo.Termino
Acronimo.Termino=PlanEstructura.Orden
PlanEstructura.Orden=PlanEstructura.Visible
PlanEstructura.Visible=(Fin)

[Lista.ListaOrden]
(Inicio)=PlanEstructura.TipoPlan<TAB>(Acendente)
PlanEstructura.TipoPlan<TAB>(Acendente)=PlanEstructura.Orden<TAB>(Acendente)
PlanEstructura.Orden<TAB>(Acendente)=(Fin)
